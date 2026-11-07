unit Mgm_LanHal;
// per interfacciare MG con rete 485,USB,TCP

(*
    dà al sistema un livello di astrazione sulle periferiche che si occupano del reale
    I/O con la rete 485 o TCP.
    Vi è in infatti un unica funzione di trasmissione e un solo evento di ricezione
    che viene passato ai livelli superiori per l'analisi logica dei dati.
    più alcune funzioni di gestione rete.
    Comunque il protocollo 485, nel senso della composizione e significato delle frame che
    girano sulla rete, è gestito qui. Il Datamodule si occupa invece dei dati da Inviare e Ricevere e
    configurazione delle linee (data che ha anche "sottomano" le tabelle!).
    Il MainForm si occupa invece della sola parte visiva, comprese le treeView, che aggiorna secondo i
    dati Freschi che trova o chiede nel Datamodule !

    - NON è implementato il polling perchè troppo oneroso per il PC, specie se MG è un service.
      Finchè non verrà implementatyo un router USB, l'I/O sarà  On-Demand  sia per trasmissione
      che ricezione, sperando che non vi siano collisioni !
      Piuttosto il protocollo deve preveder un Acknowledge per ogni trasmissione, sia PC che Devices !

    - Quindi Non vi sono Loop di interrogazione ciclica dei devices.


    MgFrame:     prev ETX||  ...time...  ||STX|+|Addr.|+|CMD|+|Data-LEN|+|DATA|+|CRC|+|ETX||  ...time...

      CRC è calcolato comprendendo Tutta la frame, dall'address all'Etx !
      In ricezione si aspetta sempre l' STX o Timeout, e poi si convalida la frame ricevuta verificandone il CRC !
      Ci sono comandi di sistema (ping), per router (loadTable), per devices e per main Station
      suddivisi per vari range.

      CHANNEL Addresses:
         1..N channels

      ROUTER Addresses:
         00  = Reserved: No router, used as prefix for devices direct connected on channel.
         04..253 = Router Addresses, used as prefix for devices connected through 1 or more routers.
         254 = Reserved.        $FE
         255 = Reserved.        $FF

      DEVICE Addresses:
      qui e in dbTable uso notazione decimale per comodità.
        00  = Reserved: Master Station.
        01  = Reserved: All - Broadcast Devices+Router.
        02  = Reserved: Stx
        03  = Reserved: Etx
        04  = Reserved: All Routers - Broadcast routers only.
        .
        05  = 05 = Devices
        ...
        250 = FA = Devices
        .
        251 = Default DEV Addr $FB
        252 = Default ISP Addr $FC        
        .
        253 = Device / Router  $FD
        254 = Reserved.        $FE
        255 = Reserved.        $FF

    - Significati di TAG del CommTimer:
         0 = OK, Channel free.
         1 = Channel BUSY, in trasmissione.
         2 = Channel BUSY, Errore CRC in risposta ricevuta.
         3 = Channel BUSY, Timeout in attesa risposta da device.

*)

interface

uses
  Windows, SysUtils, Classes, Forms, Extctrls,
  AdPort, AdPacket,
  smcUtil,
  mgType;

type
  TLanHal = class
//TLanHal = class(TComponent)
    LastCommError: integer;    // generico.
//    Polled:       boolean;     // dice se Packet ricevuto è Asyncrono o relativo a un Poll command.
    CommTimer:    TTimer;      // per rilevazione Timeout sul channel. ne andrebbe uno per ogni channel...
    function Initialize(chType, chAddr:string; chSpeed:integer): Boolean;
    function Release: Boolean;
    function LanTx:Boolean;

  protected
    { Protected declarations }
    kTimeout : integer;  // intervallo per Timer adibito a timeout comunicazione con device.
    procedure CommTimeout(Sender: TObject);
    procedure CommAnswer(Sender: TObject; RxData: AnsiString);   // vale sia per Ch1 che Ch2. per ora.
    function  ComputeCRC(Frame: ShortString): ShortString;

  public
    { Public declarations }
    function  PingDevice(Ch: integer; Router,Addr: string): TDeviceState;
    function  GetDeviceInfo(Ch: integer; Router,Addr: string): String;
    function  RelayToggle(RelNum,Ch: integer; Router,Addr: string): boolean;
    function  RelayOn(RelNum,Ch: integer; Router,Addr: string): boolean;
    function  RelayOff(RelNum,Ch: integer; Router,Addr: string): boolean;
    function  GetIOStatus(Ch: integer; Router,Addr: string): String;
    function  SetCfgParameter(ParamNum,ParamStr: string; Ch: integer; Router,Addr: string): boolean;
    function  WarnUser(Warn: string; Ch: integer; Router,Addr: string): boolean;    
    function  SendIspFrame(Fr: shortstring; Ch: integer; Router,Addr: string): shortstring;
    function  EnterIsp(Ch: integer; Router,Addr: string): boolean;

  end;


var
  LanHal:        TLanHal;
  ApdComPort1:   TApdComPort;      // Per ora gestisco solo 2 port com.
  AnswerFromCh1: TApdDataPacket;   //
  ApdComPort2:   TApdComPort;      //
  AnswerFromCh2: TApdDataPacket;   //
  //
  // qui eventuali oggetti per USB e TCP channels !
  //
  PacketAnswer:  shortstring;
  DynRxData:     TDynRxDataEvent;

implementation

// Intializes the hardware and THal instance.
// NB: bisognerebbe creare una Classe CHANNEL da instanziare da 1-N canali, all'interno della quale
//     vengono create le varie Com, Usb, Tcp, con indirizzi diversificati, trasparenti al channel che
//     andrà sempre da 1 a N !
function TLanHal.Initialize(chType, chAddr:string; chSpeed:integer): Boolean;
var
  ComPort: integer;
begin
    result := false;
    // Per ora gestisco solo 2 port com.
    if chType = 'COM' then begin
      ComPort := strToInt(chAddr);  // es.: 2 = Com2
      if ComPort = 1 then begin
        ApdComPort1 := TApdComPort.Create(nil);
        ApdComPort1.Baud := chSpeed;
        ApdComPort1.StopBits := 2;
        ApdComPort1.ComNumber := 1; //ComPort;
        ApdComPort1.RS485Mode := True;  // implica  ApdComPort1.RTS:= False
        // il resto dei parametri è a default.
        ApdComPort1.Open := True;
        //
        AnswerFromCh1 := TApdDataPacket.Create(nil);
        AnswerFromCh1.ComPort := ApdComPort1;
        AnswerFromCh1.EndCond := [ecString];
        AnswerFromCh1.EndString := char($03);
        AnswerFromCh1.StartCond := scString;
        AnswerFromCh1.StartString := char($02);
        AnswerFromCh1.OnStringPacket := CommAnswer; // aggancia evento. Per ora è comune a Ch1 e Ch2 !
        AnswerFromCh1.Enabled := true;
        if ApdComPort1.Open then
            result := True;
      end;
      if ComPort = 2 then begin
        ApdComPort2 := TApdComPort.Create(nil);
        ApdComPort2.Baud := chSpeed;
        ApdComPort2.StopBits := 2;
        ApdComPort2.ComNumber := 2; //ComPort;
        ApdComPort2.RS485Mode := True;  // implica  ApdComPort1.RTS:= False
        // il resto dei parametri è a default.
        ApdComPort2.Open := True;
        //
        AnswerFromCh2 := TApdDataPacket.Create(nil);
        AnswerFromCh2.ComPort := ApdComPort2;
        AnswerFromCh2.EndCond := [ecString];
        AnswerFromCh2.EndString := char($03);
        AnswerFromCh2.StartCond := scString;
        AnswerFromCh2.StartString := char($02);
        AnswerFromCh2.OnStringPacket := CommAnswer; // aggancia evento.
        AnswerFromCh2.Enabled := true;
        if ApdComPort2.Open then
            result := True;
      end;
    end else
    if chType = 'USB' then begin
        // todo
    end else
    if chType = 'TCP' then begin
        // todo
    end;
    if chType = 'CommTimer' then begin
        // in realtà non è un canale, ma solo il timer (eventuale) per CommTimeout.
        CommTimer := TTimer.create(nil);  // in origine era Self not nil !
        CommTimer.enabled := false;
        kTimeout := iniPollTimeout;       // Deve essere almeno 30 perchè Windows ci mette più del normale a completare
        CommTimer.Interval := kTimeout;   // un giro di Poll, quindi rischia di andare in timeout prima della risposta
        CommTimer.OnTimer  := CommTimeout;// che viene così addebitata al device successivo !!! 
        CommTimer.tag      := 0;
        result := True;
    end;
end;

// Rilascia the hardware and THal instance.
function TLanHal.Release: Boolean;
begin
    if ApdComPort1 <> nil then
        FreeAndNil(ApdComPort1);
    if ApdComPort2 <> nil then
        FreeAndNil(ApdComPort2);
    if AnswerFromCh1 <> nil then
        FreeAndNil(AnswerFromCh1);
    if AnswerFromCh2 <> nil then
        FreeAndNil(AnswerFromCh2);
    if CommTimer <> nil then begin
        CommTimer.enabled := false;
        CommTimer.Free;
    end;
    result := true;
end;

procedure TLanHal.CommTimeout;
begin
    CommTimer.tag := 3; //se arriva qui, implica timeout in attesa risposta da Device.
    // Tag = 3 serve per segnalare timeout ricezione relativo all'ultima Trasmissione 
    CommTimer.enabled := false;
    // default time = 30 ms !
    // NON di meno, perchè i Packet arrivano molto in ritardo rispetto all'arrivo fisico,
    // colpa del driver Windows e/o AsyncPro.  Infatti succede anche che arrivi Ora il
    // Packet del device pollato prima dell'attuale !  oppure risposte sporche e incomplete
    // perchè windows ritarda nel rilasciare RTS e mettersi in ricezione 485 !
    if ApdComPort1 <> nil then begin
      AnswerFromCh1.Enabled := false;
      AnswerFromCh1.Enabled := true;
    end;
    if ApdComPort2 <> nil then begin
      AnswerFromCh2.Enabled := false;
      AnswerFromCh2.Enabled := true;
    end;
end;

procedure TLanHal.CommAnswer(Sender: TObject; RxData: AnsiString);
var
   crc, crcRx, addr: string;
   len:              integer;
begin
    // ok, fine risposta.
    // per ora i due Packet Answer sono linkati alla stessa routine Ch1Answer !!
    PacketAnswer := '';
    CommTimer.enabled := false;  // Timeout timer Stop.
    // Prima di tutto essendo arrivata la stringa prevista, cioè inizio STX(02h) e fine ETX(03h) vado
    // a verificarne l'affidabilità calcolandone il CRC.
    len := Length(RxData);
    // ma solo se non è una frame ISP.
    if not Frame485.IspFrame then begin
        crcRx := copy(RxData, len-2, 2);  // prende i 2 char di CRC e li confronta con quello calcolato.
        crc   := ComputeCRC(copy(RxData, 1, len-3));
        if crcRx <> crc then begin
            CommTimer.tag := 2;                    // = Errore CRC.
            exit;
        end;
    end;
    // verifica address. se frame destinata a Pc.
    addr := copy(RxData, 2, 1);
    if addr[1] <> chr($01) then begin
        CommTimer.tag := 4;                    // Bad Answer !
        exit;
    end;
    // Mantengo come risposta solo il Blocco-Dati effettivo, sfrondato dai byte di contorno.
    if Frame485.IspFrame then
        PacketAnswer := copy(RxData, 3, Length(RxData)-3)  // perchè isp frame è più corta. è senza crc !
    else
        PacketAnswer := copy(RxData, 3, Length(RxData)-5);
    // Se ricevuto Packet senza polling, è un Evento from Device, che deve essere servito.
    if not Frame485.AnswerToPoll then begin
        LastCommError := 0;
        Frame485.RxTimeout := False;
        Frame485.Data := PacketAnswer;
        // così lo passo direttamente al DataModule.
        // qui NON faccio TimeStamps o altre Analisi sul contenuto !!!
        if assigned(DynRxData) then
            DynRxData;
        end
    else begin  // verifica se address di risposta coincide con quello di Poll.
        addr := copy(RxData, 3, 1);
        if addr <>  HexStr2Str(Frame485.Address) then begin
            CommTimer.tag := 5;                    // Wrong Device !
            exit;
        end;
    end;
    // segnala Fine pollata.
    Frame485.AnswerToPoll := False;
    CommTimer.tag := 0;
end;

function TLanHal.LanTx:Boolean;
var
   strToDevice: string;
//   strToDevice: shortstring;
begin
    // Spedisce Frame485.Data senza curarsi del contenuto.
    //               1° |02|   +         2°  |Addr.|           +  3° |Cmd byte| 4°... |Data|
    strToDevice := chr(mgSTX)  +  HexStr2Str(Frame485.Address) +      Frame485.Data;
    if Frame485.IspFrame then begin
        CommTimer.Interval := kTimeout+256; // perchè frame ISP può essere molto lunga !!!
        // nelle ISP frame non uso CRC.
        strToDevice := strToDevice + 'x' + chr(mgETX);// 'x' = $78 é dummy perchè boot loader prende dati a blocchi
        end                                           // di 2 bytes. dati che devono essere nel range $30-$3F !
    else begin
        CommTimer.Interval := kTimeout;  // ripristina Timeout standard per frame da 16-30 bytes max !!!
        //  calcolo CRC su parte principale della frame.
        //                         +      n°,n°+1   |CRC|    +   n°+2 |03|
        strToDevice := strToDevice + ComputeCRC(strToDevice) +  chr(mgETX);
    end;
    Frame485.AnswerToPoll := True;  // ovvero ci si aspetta una risposta.
    Sleep(iniSleepMs);   // default = 4. necessario per  evitare ritardi in disattivazione RTS per 485 !
    case Frame485.Channel of
      1: ApdComPort1.PutString(strToDevice);
      2: ApdComPort2.PutString(strToDevice);
    end;
    // Ora attende risposta da Device.
    CommTimer.tag     := 1;
    CommTimer.enabled := True;          // Starta Timeout Timer.
    while CommTimer.tag = 1 do begin    // 1 = in attesa Rx
        Application.processmessages;
        Sleep(1);
        //ApdComPort.ProcessCommunications;
    end;
    // Fine attesa.
    // Stop Timeout Timer lo è già da Packet o Timeout !
    if CommTimer.tag = 0 then begin
        // il device ha risposto,
        LastCommError := 0;             // 0 = Ok
        Frame485.RxTimeout := False;
        Frame485.Data := PacketAnswer;
        result := true;
        end
    else begin
        // il device ha risposto Male
        // o  Non ha risposto.
        LastCommError := CommTimer.tag;  // 2 = CRC Error     3 = Timeout Error.
        Frame485.RxTimeout := True;
        Frame485.Data := '';
        result := false;
    end;
    CommTimer.tag := 0;
    Frame485.IspFrame     := False;
    Frame485.AnswerToPoll := False;   // necessario per Packets Eventi dai device: arrivano anche senza polling !
end;

function TLanHal.PingDevice(Ch: integer; Router,Addr: string): TDeviceState;  // usata in Enum LAN
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := chr(cmdPing);    //  |CMD|
    if LanTx then begin
        // Device ha risposto correttamente e senza errori, quindi
        // analizzo la risposta.
        if Frame485.Data[2] = chr(answPingAnswer) then    // NB: Data[1] è address mittente !
            result := dsReady
        else if Frame485.Data[2] = chr(answIspReady) then
            result := dsIspReady
        else
            result := dsOffLine;
        end
    else
        // Device non ha risposto.
        result := dsOffLine;
end;

function TLanHal.GetDeviceInfo(Ch: integer; Router,Addr: string): String;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := chr(cmdGetDeviceInfo);    //  |CMD|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answDeviceInfo) then    // NB: Data[1] è address mittente !
            // se AnswerCode coincide allora prendo in carico i tre byte di Info Device.
            result := copy(Frame485.Data, 3, 3)
        else
            result := ''
    else
        // Errore, timeout o bad answer !
        result := '';
end;

function TLanHal.EnterIsp(Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := chr(cmdEnterISP);    //  |CMD|
    if LanTx then
        if Frame485.Data[2] = chr(answEnterISP) then begin   // se AnswerCode coincide allora ok.
            // Device ora esegue il Boot Loader
            Sleep(10); // dò il tempo a Device di andare in ISP. (?)
            result := true;
            end
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;
function TLanHal.SendIspFrame(Fr: shortstring; Ch: integer; Router,Addr: string): shortstring;
var
    len: integer;
begin                                  // invia e riceve ISP frame per isp remoto.
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Addr := HexStr2Str(Addr);
    Addr := char(byte(Addr[1]) or $80);
    Addr := Str2HexStr(Addr);
    Frame485.Address   := Addr; // è DevAddress+$80 oppure kISPaddress = 'FC' default ISP address di emergenza !
    len := length(Fr);
    // ora mantengo il Cmd byte, ma codifico in Ascii la parte Dati per non interferire
    // con protocolo stx/etx della 485 !                                            (2) $C0+$B4 -> (4) 'C0B4'
    Frame485.Data      := Fr[1] + Str2HexStr(copy(Fr,2,len-1));  //  |CMDbyte    +      ISP frame|
    Frame485.IspFrame  := True;
    if LanTx then begin
        // Device ha risposto correttamente e senza errori.
        // NB: Data[1] è address mittente !
        //     qui niente AnswerCode. L'address mittente dice già che è un device in
        //     fase di ISP, perciò prendo direttamente in carico la ISP frame.
        // i bytes di ritorno sono codificati Ascii, per averli in range limitato e poter trasmettere $00 to $FF
        // senza interferire col protocollo 485, ma implica doppia lunghezza e decodifica in ricezione:
        len := length(Frame485.Data);
        result := copy(Frame485.Data, 2, len-1);  // elimino l'address del device mittente.
        result := HexStr2Str(result);
        end
    else
        // Errore, Timeout o bad answer !
        result := '';
end;

function TLanHal.RelayToggle(RelNum,Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := cmdRelayToggle + chr(ord(RelNum));  //  |CMD|+|detail|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answRelToggled) then    // NB: Data[1] è address mittente !
            // se AnswerCode coincide allora ok.
            result := true
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;

function TLanHal.RelayOn(RelNum,Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := cmdRelayOn + chr(ord(RelNum));    //  |CMD|+|detail|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answRelayOn) then  // stesso AnswerCode per Relay1 e Relay2.
            // se AnswerCode coincide allora ok.
            result := true
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;
function TLanHal.RelayOff(RelNum,Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := cmdRelayOff + chr(ord(RelNum));    //  |CMD|+|detail|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answRelayOff) then  // stesso AnswerCode per Relay1 e Relay2.
            // se AnswerCode coincide allora ok.
            result := true
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;

function TLanHal.GetIOStatus(Ch: integer; Router,Addr: string): String;
var
  tStr: shortstring;
begin                                  // legge lo status di tutti gli I/O del device.
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := cmdGetIOStatus;    //  |CMD|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answIOStatus) then begin   // NB: Data[1] è address mittente !
            // se AnswerCode coincide allora prendo in carico i 4 bytes di I/O Status.
            // deevo convertie in string 0/1 altrimenti i $00 (from Avr) troncano la result !
            tStr := '0000';
            if copy(Frame485.Data, 3, 1) = chr($FF) then tStr[1] := '1';
            if copy(Frame485.Data, 4, 1) = chr($FF) then tStr[2] := '1';
            if copy(Frame485.Data, 5, 1) = chr($FF) then tStr[3] := '1';
            if copy(Frame485.Data, 6, 1) = chr($FF) then tStr[4] := '1';
            //result := copy(Frame485.Data, 3, 4);
            result := tStr;
            end
        else
            result := ''
    else
        // Errore, timeout o bad answer !
        result := '';
end;

function TLanHal.SetCfgParameter(ParamNum,ParamStr: string; Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := chr(cmdSetParameter) + ParamNum[1] + ParamStr;    //  |CMD|+|details|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answSetParameter) then  // stesso AnswerCode per qualsiasi Parametro.
            // se AnswerCode coincide allora ok.
            result := true
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;

function TLanHal.WarnUser(Warn: string; Ch: integer; Router,Addr: string): boolean;
begin
    Frame485.Channel   := Ch;
    Frame485.Router    := Router;
    Frame485.Address   := Addr;
    Frame485.Data      := cmdSetWarning + Warn; //  |CMD|+| warnNum & warnParam stanno in unica string.|
    if LanTx then
        // Device ha risposto correttamente e senza errori.
        if Frame485.Data[2] = chr(answSetWarning) then  // stesso AnswerCode per qualsiasi Parametro.
            // se AnswerCode coincide allora ok.
            result := true
        else
            result := false
    else
        // Errore, timeout o bad answer !
        result := false;
end;

function  TLanHal.ComputeCRC(Frame: ShortString): ShortString;
var
   i:    integer;       // Calcola CRC come somme successive.
   b:    byte;          // facile da riprodurre anche su AVR.
begin
    b := $00;
    for i := 1 to Length(Frame) do
        b := b + byte(Frame[i]);
    result := HexToStr(b);
    //result := '00';
end;


initialization
   // NB !!!
   // questa parte è eseguita ancora prima che vengano creati i form presenti nel progetto !!!

finalization


end.
