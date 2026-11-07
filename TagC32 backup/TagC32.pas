//*****************************************************************************
// TAG32C version AM001 for application PGC_510
//*****************************************************************************

unit TagC32;

interface

uses
  Windows, Messages, SysUtils, Classes,  Forms, OoMisc, AdPort, AdSelCom, AdPacket;


type

  tRfidErrors = (rfidOK, rfidTimeout, rfidSizeError, rfidSelectTagFail, rfidRdFail, rfidWrFail,
                 rfidLockFail, rfidCrcError, rfidTagUnknown, rfidCmdUnknown, rfidErrUnknown);
  tInOut = (Rx,Tx,line); 

  TTagEvent = procedure(TagID: shortstring) of object;  

  TTagReader = class(TDataModule)
    ApdComPort1: TApdComPort;
    ApdDataPacket1: TApdDataPacket;
    procedure ApdComPort1TriggerAvail(CP: TObject; Count: Word);
    procedure ApdDataPacket1Timeout(Sender: TObject);
    procedure ApdDataPacket1Packet(Sender: TObject; Data: Pointer; Size: Integer);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }


  public
    { Public declarations }
    ContinuoScan : boolean;
    //
    RfidRequest       : shortstring;
    RC                : string[2];   // M1 Response-Code (vedi tabella Skyetek protocol)
    RfidResponse      : shortstring;
    RfidBlockData     : shortstring;
    TID               : shortstring; // Tag ID.
    FwVersion         : shortstring; // Fw ver.
    Tag_StrBuffer     : string;                   // TI-iso15693  64 Blk * 4 byte = 256 bytes
    Tag_HexBuffer     : string;
    //
    kDispMask         : string;      // mask nelle string grid.
    kBlockLen         : integer;     // in TI iso15693 = 4 bytes.
    nBlocks           : integer;     // # blocks of 8 byte each on every TAG
    nRows             : integer;     // rows in Card stringgrid (needs # for data + 1 title).
    nHexCol           : integer;     // num colonne in grid hex.
    BlkPerRow         : integer;     // num blocchi presenti in una riga.
    strRow            : string;

    TagEventLink :   TTagEvent;       // link a TagEvent.
    function  OpenPort(ComPort: integer): boolean;
    procedure ClosePort;
    procedure ResetReader;
    function  CheckReader: boolean;
    procedure SingleScan;    
    procedure StartScan;
    function  StopScan: boolean;
    function  SelectTag(TagId: shortstring): boolean;  // metto in Selected Mode il TID corrente.
    function  ReadBlock(BlkNum: byte): boolean;
    function  WriteBlock(BlkNum: byte; BlkData: string): boolean;
    function  Received_(str: shortstring): Boolean;  // Attende Stringa prevista o Timeout.
    function  ReceivedLen_(Count: integer; var frame: shortstring): Boolean;
    procedure Rfid_WaitResponse;

  end;

  function HexToStr( H:byte ): shortstring;
  function HexStr2Str(StrHex: string): shortstring;
  function CharsToStrhex(dump: shortstring): shortstring;
  function StrhexToInt( S:shortstring ): longint;

const
    /////// RFID Skyetek strings
    // M1 Skyetek Commands
    cr       = chr($0D);
    lf       = chr($0A);
    bt_Attn  = 'AT' + cr;

    m1_getFwVer     : string = cr + '00220101' + cr;         // get reader FW version
    m1_gotoSleep    : string = cr + '204204010035E9' + cr;   // set M1 in Sleep mode (+crc)
    m1_WakeUp       : string = cr + '20420401030772' + cr;   // wakeup M1 (+crc)
    m1_StartScan    : string = cr + '031401' + cr;           // cerca solo iso15693, Loop, Inventory
    m1_SingleScan   : string = cr + '001401' + cr;           // cerca solo iso15693, Loop, Inventory
    m1_StopScan     : string = cr + 'xx' +cr;                // Quit Loop Mode.
    m1_TagSelect    : string = cr + '481401';                // aggiungere TID +cr  (solo iso15693) es: E007000001CBB00A +cr
    m1_TagReadBlock : string = cr + '082401';                // Legge 1 o + blocchi, da 4 bytes.
    m1_TagWriteBlock: string = cr + '084401';                // Scrive 1 o + blocchi, da 4 bytes.
    //m1_TagReadLen : string = cr + '' + cr;                 // Legge Len bytes da inizio Tag.

    // M1 Answers
    //m1_FwVersion : string = lf + '22C023' + cr + lf;    // versioni C001 o C002 o C005 o C023 o 0802
    m1_FwVersion   : string = lf + '220802' + cr + lf;    // versioni C001 o C002 o C005 o C023 o 0802
    m1_FwAnswer    : string = lf + '22';                  // inizio risposta, segue ver. specifica, es: 'C023'+cr+lf
    m1_goneSleep   : string = lf + '426116' + cr + lf;    // M1 è in Sleep mode (+crc)  = Sys Wr Pass
    m1_Waken       : string = lf + '426116' + cr + lf;    // M1 è svegliato (+crc)      = Sys Wr Pass
    m1_isScanning  : string = lf + '1C' + cr + lf;        // modulo in scansione iso15693 continua.
    m1_ScanStopped : string = lf + '9C' + cr + lf;        // scansione interrotta.
    m1_TagSelected : string = lf + '14' + cr + lf;        // Tag Select Pass.
    m1_TagReadOk   : string = lf + '24';                  // Tag Read Pass, ma seguono N° bytes letti + cr+lf
    m1_TagWriteOk  : string = lf + '44' + cr + lf;        // Write Tag Pass.

    // ReturnCode only
    m1rc_FwReadOk      : string = '22';        //
    m1rc_TagSelected   : string = '14';        // Tag Select Pass.
    m1rc_TagReadOk     : string = '24';        // Tag Read Pass, ma seguono N° bytes letti + cr+lf
    m1rc_TagReadFail   : string = 'A4';        // Tag Read Fail !
    m1rc_isScanning    : string = '1C';        // modulo in scansione iso15693 continua.
    m1rc_ScanStopped   : string = '9C';        // scansione interrotta.
    m1rc_TagSelectFail : string = '94';        // Tag Select Fail.

    // Skyetek ERROR CODES
    //   $94     Select TAG Fail
    //   $A4     Read TAG Fail
    //   $C4     Write TAG Fail
    //   $84     Unknown Command
    //   $85     Unknown Tag Type
    //   $87     Invalid Number of Blocks
    //   ...

    // n° di bytes in un Blocco FISICO iso15693
    kBlock_ascLen  : byte = 8;          // 4 bytes * 2 ascii = 8
    kBlock_Len     : byte = 4;          // 4 bytes.
    kSector_Len    : byte = 5;          // 5 blocchi = 20 bytes.


var
  TagReader: TTagReader;

implementation


{$R *.dfm}

function TTagReader.OpenPort(ComPort: integer): boolean;
begin
    ContinuoScan := false;
    if isPortAvailable(ComPort) then begin
        if ApdComPort1.open then
            ApdComPort1.open := false;
        application.ProcessMessages;
        ApdComPort1.ComNumber := ComPort;
        try
           ApdComPort1.Open := True;
           // ora prova cmd su M1-mini...
           if CheckReader then begin
               result := True;
               exit;
           end;
        except
           result := False;
        end;
    end;
    result := False;
end;

procedure TTagReader.ClosePort;
begin
    ApdComPort1.open := False;
end;

procedure TTagReader.ResetReader;
var
  ET : EventTimer;
begin
    ApdComPort1.RTS := True;
    NewTimer(ET, 2); // 1 tick = 55 msec,  10 => 550 ms    MA c'è il Timer FREE ???
    repeat
        Application.ProcessMessages;        // Se il PC sta lavorando molto, alle volte non riesce a
        ApdComPort1.ProcessCommunications;  // ricevere risposte complete e va in timeout !
    until TimerExpired(ET);
    ApdComPort1.RTS := False;           // Release skyetek reset line.
end;

function TTagReader.CheckReader: boolean;
begin
    // Attenzione, qualsiasi Comando interrompe eventuale Scan Loop in corso !
    // basterebbe inviare solo un CR per verificare se in Loop...
    ApdComPort1.FlushInBuffer;
    application.ProcessMessages;
    RfidRequest := m1_getFwVer;                                 // <CR>00220101<CR>   get reader FW version
    ApdComPort1.PutString( RfidRequest );                       // M1 risponde con <LF>22C005<CR><LF>
    Rfid_WaitResponse;
    if RC = m1rc_FwReadOk then                                  // '22'
          result := True
    else
        if RfidResponse <> '' then
            result := True
        else
            result := False;
end;

procedure TTagReader.DataModuleDestroy(Sender: TObject);
begin
    ApdComPort1.Open := False;
end;

//###################################################################

function TTagReader.Received_(str: shortstring): Boolean;  // Attende Stringa prevista o Timeout.
begin  //attenzione che Yeld=True permette processmessages cioè reentrancy.
    ApdComPort1.ProcessCommunications;
    if ApdComPort1.WaitForString(str, 10, True, True) then // 1 tick = 55 msec,  10 => 550 ms
        result := True
    else
        result := False;
end;
function TTagReader.ReceivedLen_(Count: integer; var frame: shortstring): Boolean;
var                                                     // Attende Count bytes in var frame o Timeout.
  ET : EventTimer;
  k: integer;
begin
    k := 0;
    NewTimer(ET, 15); // 1 tick = 55 msec,  2 => 100 ms    MA c'è il Timer FREE ???
    repeat
        Application.ProcessMessages;        // Se il PC sta lavorando molto, alle volte non riesce a ricevere risposte complete e va in timeout !
        if ApdComPort1.CharReady then begin
            frame := frame + ApdComPort1.GetChar;
            inc(k);
        end;
    until (k = Count) or TimerExpired(ET);
    if k = Count then
        result := True
    else
        result := False;
    //LogFrame(Rx, frame);
end;

procedure TTagReader.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
var
   st: shortstring;
begin
    exit;
    // Putroppo ApdPacket sembra inaffidabile...!
    // alle volte non rileva i pacchetti pur avendoli ricevuti !
    ApdComPort1.GetBlock(st[1], Count);
    SetLength(st, Count);
    //LogFrame(Rx, st);
end;

procedure TTagReader.ApdDataPacket1Timeout(Sender: TObject);
begin
    //LogFrame(Rx, ' Rx Timeout !');
end;

procedure TTagReader.ApdDataPacket1Packet(Sender: TObject; Data: Pointer; Size: Integer);
begin
    // con IncludeStrings := False resta solo  -<...Data...>-
    Move(Data^,  RfidResponse[1] , Size);
    SetLength(RfidResponse, Size);
    //LogFrame(Rx, RfidResponse); debug only.
    //
    RC := copy(RfidResponse, 1, 2);  // Estrae Reponse Code !
    //
    // se è il risultato OK di una Select, visualizza il TID rilevato !
    if RC = m1rc_TagSelected then begin                 // '14' = Select Tag Pass.
        if Length(RfidResponse) > 2 then begin
            TID := copy(RfidResponse, 3, size-2);
            if assigned(TagEventLink) then begin
                // passo l'evento all' applicazione utente.
                TagEventLink( TID );
            end;
        end;
    end;
    if RC = m1rc_TagReadOk then begin                   // '24' = Read Tag Pass.
        RfidBlockData := copy(RfidResponse, 3, size-2);
    end;
    if RC = m1rc_FwReadOk then begin                    // '22' = Fw version.
        FwVersion := copy(RfidResponse, 3, size-2);
    end;
end;

procedure TTagReader.Rfid_WaitResponse;
var
  ET : EventTimer;
begin
    // attende risposta da M1 o Timeout !
    RfidResponse := '';
    RC := '';
    NewTimer(ET, 10); // 1 tick = 55 msec,  10 => 550 ms    MA c'è il Timer FREE ???
    repeat
        Application.ProcessMessages;        // Se il PC sta lavorando molto, alle volte non riesce a
        ApdComPort1.ProcessCommunications;  // ricevere risposte complete e va in timeout !
    until (RC <> '') or TimerExpired(ET);
end;

//#################################################################################

procedure TTagReader.SingleScan;
begin
//    ApdDataPacket1.Enabled := False;        // disable temporaneo
    RfidRequest := m1_SingleScan;             // <CR>001401<CR>    iso15693, Loop, Inventory
    ApdComPort1.PutString( RfidRequest );     // answer <LF>1C<CR><LF>
    Rfid_WaitResponse;
//    ApdDataPacket1.Enabled := True;
end;

procedure TTagReader.StartScan;
begin
//    LogFrame(Line,' ');
    RfidRequest := m1_StartScan;  // <CR>031401<CR>    iso15693, Loop, Inventory
//    LogFrame(Tx, RfidRequest);
    ApdComPort1.PutString( RfidRequest );     // answer <LF>1C<CR><LF>
    Rfid_WaitResponse;
//    LogFrame(Rx, RfidResponse);  // mostro anche se non mi interessa.
//    ContinuoScan := True; è user var
end;

function TTagReader.StopScan: boolean;
begin
//    LogFrame(Line,' ');
//    LogFrame(Line,'Quit scan mode: ');
    RfidRequest := m1_StopScan;  // any cmd.
    ApdComPort1.PutString( RfidRequest );     // answer <LF>9C<CR><LF>
//    LogFrame(Tx, RfidRequest);
    Rfid_WaitResponse;                        // m1_ScanStopped
    if RC = '9C' then                         // Select Tag Loop Cancel
        result := True                        // answer  <LF>9C<CR><LF>
    else
        result := False;
end;


function TTagReader.SelectTag(TagId: shortstring): boolean;  // metto in Selected Mode il TID corrente.
begin
    //  Se è in LOOP mode è necessario prima uscire !  (vedi StopScan)
    RfidRequest := m1_TagSelect;                       // inizio con parte fissa
    RfidRequest := RfidRequest + TID +cr;              // e completo con Tid.
    ApdComPort1.PutString( RfidRequest );
    //LogFrame(Tx, RfidRequest);
    Rfid_WaitResponse;
    if RC = '14' then                                // Tag Select Pass
        result := true                              // answer  <LF>14<CR><LF>
    else
        result := false;
end;

function TTagReader.ReadBlock(BlkNum: byte): boolean;
begin
    RfidRequest := m1_TagReadBlock;                           // inizio con parte fissa
    RfidRequest := RfidRequest + HexToStr(BlkNum) + HexToStr($01) +cr;  // e completo con address e n° blocchi da leggere.
    ApdComPort1.PutString( RfidRequest );
    Rfid_WaitResponse;
    if RC = '24' then            // = Read Tag Pass.
        result := true           // answer  <LF>24 + data<CR><LF>
    else
        result := false;
end;
function TTagReader.WriteBlock(BlkNum: byte; BlkData: string): boolean;
begin
    RfidRequest := m1_TagWriteBlock;                           // inizio con parte fissa
    // e completo con Address + n° blocchi da leggere (1) + Data.
    RfidRequest := RfidRequest + HexToStr(BlkNum) + HexToStr($01)+ BlkData +cr;
    ApdComPort1.PutString( RfidRequest );
    Rfid_WaitResponse;
    if RC = '44' then            // = Write Tag Pass.
        result := true           // answer  <LF>44<CR><LF>
    else
        result := false;
end;

//########################################################################################
// util

function HexToStr( H:byte ): shortstring;               //   $2B  ->  '2B'
const
     Hex: shortstring = '0123456789ABCDEF';
var
     t0, t1: byte;
begin
     t0 := H shr 4;
     t1 := H and $0F;
     HexToStr := Hex[t0+1] + Hex[t1+1];
end;

///////  travasa String/Short in Shortstring[8] secondo DataAs.  ////////////
function HexStr2Str(StrHex: string): shortstring; // in 2:1 out !
var       // input(4) 'C0B4' -> output(2) $C0+$B4
  j: integer;        // Result è short così non perdo eventuali $00 in output !
begin                // qui senza dataAs e vincolo lunghezza.
    result := '';    // Passaggio da stringaHex con lunghezza N perchè Hex,
    for j := 0 to (length(StrHex) div 2)-1 do  // a lunghezza dimezzata N/2.
        result := result + char(StrhexToInt(copy(StrHex,j*2+1,2)))
end;

function CharsToStrhex(dump: shortstring): shortstring;
var
   i,l: integer;
   t: shortstring;
begin
    t := '';
    l := length(dump);
    for i := 1 to l do
       t := t + HexToStr(byte(dump[i]));
    result := t;
end;

function StrhexToInt( S:shortstring ): longint;         //  'FFFE'    ->   65534 = $FFFE
var
   i:     byte;
   w:     longint;
begin
     W := 0;
     for i := 1 to Length( S ) do begin
         case S[i] of
	      '0'..'9':  w := w *16 +(Ord(S[i]) -48);
          'A'..'F':  w := w *16 +(Ord(S[i]) -55);
          'a'..'f':  w := w *16 +(Ord(S[i]) -87);
         end;
     end;
     StrhexToInt := w;
end;


end.
