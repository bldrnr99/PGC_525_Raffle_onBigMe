UNIT TagC32;

INTERFACE

USES
        Windows,
        Messages,
        SysUtils,
        Classes,
        Forms,
        OoMisc,
        AdPort,
        AdSelCom,
        AdPacket,
        smcUtil;

TYPE

        tRfidErrors = (rfidOK, rfidTimeout, rfidSizeError, rfidSelectTagFail,
          rfidRdFail, rfidWrFail, rfidLockFail, rfidCrcError, rfidTagUnknown,
          rfidCmdUnknown, rfidErrUnknown);
        tInOut = (Rx, Tx, line);
        tdataAs = (asStr, asHex);

        TTagEvent = PROCEDURE(TagID: shortstring) OF OBJECT;

        TTagReader = CLASS(TDataModule)
                ApdComPort1: TApdComPort;
                ApdDataPacket1: TApdDataPacket;
                PROCEDURE ApdComPort1TriggerAvail(CP: TObject; Count: Word);
                PROCEDURE ApdDataPacket1Timeout(Sender: TObject);
                PROCEDURE ApdDataPacket1Packet(Sender: TObject; Data: Pointer;
                  Size: Integer);
                PROCEDURE DataModuleDestroy(Sender: TObject);
        PRIVATE
                { Private declarations }

        PUBLIC
                { Public declarations }
                ContinuoScan: boolean;
                //
                RfidRequest: shortstring;
                RC: STRING[2];
                // M1 Response-Code (vedi tabella Skyetek protocol)
                RfidResponse: shortstring;
                Rfid_ascBlockData: shortstring;
                Rfid_strBlockData: shortstring;
                TID: shortstring; // Tag ID.
                FwVersion: shortstring; // Fw ver.
                Tag_StrBuffer: STRING;
                // TI-iso15693  64 Blk * 4 byte = 256 bytes
                Tag_HexBuffer: STRING;
                //
                kDispMask: STRING; // mask nelle string grid.
                kBlockLen: Integer; // in TI iso15693 = 4 bytes.
                nBlocks: Integer; // # blocks of 8 byte each on every TAG
                nRows: Integer;
                // rows in Card stringgrid (needs # for data + 1 title).
                nHexCol: Integer; // num colonne in grid hex.
                BlkPerRow: Integer; // num blocchi presenti in una riga.
                strRow: STRING;

                TagEventLink: TTagEvent; // link a TagEvent.
                FUNCTION OpenPort(ComPort: Integer): boolean;
                PROCEDURE ClosePort;
                PROCEDURE ResetReader;
                FUNCTION CheckReader: boolean;
                PROCEDURE SingleScan;
                PROCEDURE StartScan;
                FUNCTION StopScan: boolean;
                FUNCTION SelectTag(TagID: shortstring): boolean;
                // metto in Selected Mode il TID corrente.
                FUNCTION ReadBlock(BlkNum: byte): boolean;
                FUNCTION WriteBlock(BlkNum: byte; dataAs: tdataAs; BlkData: STRING)
                  : boolean;
                FUNCTION Received_(str: shortstring): boolean;
                // Attende Stringa prevista o Timeout.
                FUNCTION ReceivedLen_(Count: Integer; VAR frame: shortstring): boolean;
                PROCEDURE Rfid_WaitResponse;

        END;

FUNCTION HexToStr(H: byte): shortstring;
FUNCTION HexStr2Str(StrHex: STRING): shortstring;
FUNCTION Str2HexStr(str: shortstring): STRING;
FUNCTION CharsToStrhex(dump: shortstring): shortstring;

CONST
        /// //// RFID Skyetek strings
        // M1 Skyetek Commands
        cr = chr($0D);
        lf = chr($0A);
        bt_Attn = 'AT' + cr;

        m1_getFwVer: STRING = cr + '00220101' + cr; // get reader FW version
        m1_gotoSleep: STRING = cr + '204204010035E9' + cr;
        // set M1 in Sleep mode (+crc)
        m1_WakeUp: STRING = cr + '20420401030772' + cr; // wakeup M1 (+crc)
        m1_StartScan: STRING = cr + '031401' + cr;
        // cerca solo iso15693, Loop, Inventory
        m1_SingleScan: STRING = cr + '001401' + cr;
        // cerca solo iso15693, Loop, Inventory
        m1_StopScan: STRING = cr + 'xx' + cr; // Quit Loop Mode.
        m1_TagSelect: STRING = cr + '481401';
        // aggiungere TID +cr  (solo iso15693) es: E007000001CBB00A +cr
        m1_TagReadBlock: STRING = cr + '082401';
        // Legge 1 o + blocchi, da 4 bytes.
        m1_TagWriteBlock: STRING = cr + '084401';
        // Scrive 1 o + blocchi, da 4 bytes.
        // m1_TagReadLen : string = cr + '' + cr;                 // Legge Len bytes da inizio Tag.

        // M1 Answers
        // m1_FwVersion : string = lf + '22C023' + cr + lf;    // versioni C001 o C002 o C005 o C023 o 0802
        m1_FwVersion: STRING = lf + '220802' + cr + lf;
        // versioni C001 o C002 o C005 o C023 o 0802
        m1_FwAnswer: STRING = lf + '22';
        // inizio risposta, segue ver. specifica, es: 'C023'+cr+lf
        m1_goneSleep: STRING = lf + '426116' + cr + lf;
        // M1 � in Sleep mode (+crc)  = Sys Wr Pass
        m1_Waken: STRING = lf + '426116' + cr + lf;
        // M1 � svegliato (+crc)      = Sys Wr Pass
        m1_isScanning: STRING = lf + '1C' + cr + lf;
        // modulo in scansione iso15693 continua.
        m1_ScanStopped: STRING = lf + '9C' + cr + lf; // scansione interrotta.
        m1_TagSelected: STRING = lf + '14' + cr + lf; // Tag Select Pass.
        m1_TagReadOk: STRING = lf + '24';
        // Tag Read Pass, ma seguono N� bytes letti + cr+lf
        m1_TagWriteOk: STRING = lf + '44' + cr + lf; // Write Tag Pass.

        // ReturnCode only
        m1rc_FwReadOk: STRING = '22'; //
        m1rc_TagSelected: STRING = '14'; // Tag Select Pass.
        m1rc_TagReadOk: STRING = '24';
        // Tag Read Pass, ma seguono N� bytes letti + cr+lf
        m1rc_TagReadFail: STRING = 'A4'; // Tag Read Fail !
        m1rc_isScanning: STRING = '1C';
        // modulo in scansione iso15693 continua.
        m1rc_ScanStopped: STRING = '9C'; // scansione interrotta.
        m1rc_TagSelectFail: STRING = '94'; // Tag Select Fail.

        // Skyetek ERROR CODES
        // $94     Select TAG Fail
        // $A4     Read TAG Fail
        // $C4     Write TAG Fail
        // $84     Unknown Command
        // $85     Unknown Tag Type
        // $87     Invalid Number of Blocks
        // ...

        // n� di bytes in un Blocco FISICO iso15693
        kBlock_ascLen: byte = 8; // 4 bytes * 2 ascii = 8
        kBlock_Len: byte = 4; // 4 bytes.
        kSector_Len: byte = 5; // 5 blocchi = 20 bytes.

VAR
        TagReader: TTagReader;

IMPLEMENTATION

{$R *.dfm}


// Rossi version
FUNCTION TTagReader.OpenPort(ComPort: Integer): boolean;
BEGIN
        ContinuoScan := false;
        IF isPortAvailable(ComPort) THEN
        BEGIN
                IF ApdComPort1.open THEN
                        ApdComPort1.open := false;
                application.ProcessMessages;
                ApdComPort1.ComNumber := ComPort;
                TRY
                        ApdComPort1.open := True;
                        // ora prova cmd su M1-mini...
                        IF CheckReader THEN
                        BEGIN
                                result := True;
                                exit;
                        END;
                EXCEPT
                        result := false;
                END;
        END;
        result := false;
END;


// ChatGPT version
(*
  function TTagReader.OpenPort(ComPort: Integer): Boolean;
  begin
  Result := False;
  ContinuoScan := False;

  if isPortAvailable(ComPort) then
  begin
  // Close if already open
  if ApdComPort1.Open then
  ApdComPort1.Open := False;

  Application.ProcessMessages;

  // Assign port number
  ApdComPort1.ComNumber := ComPort;

  try
  ApdComPort1.Open := True;

  // Attempt to verify reader connection
  if CheckReader then
  begin
  Result := True;
  Exit;
  end;
  except
  on E: Exception do
  begin
  // Optional: log or handle
  OutputDebugString(PChar('OpenPort exception: ' + E.Message));
  Result := False;
  end;
  end;
  end;

  // Fallback false if port not available or error occurs
  Result := False;
  end;
*)

PROCEDURE TTagReader.ClosePort;
BEGIN
        ApdComPort1.open := false;
END;

PROCEDURE TTagReader.ResetReader;
VAR
        ET: EventTimer;
BEGIN
        ApdComPort1.RTS := True;
        NewTimer(ET, 2);
        // 1 tick = 55 msec,  10 => 550 ms    MA c'� il Timer FREE ???
        REPEAT
                application.ProcessMessages;
                // Se il PC sta lavorando molto, alle volte non riesce a
                ApdComPort1.ProcessCommunications;
                // ricevere risposte complete e va in timeout !
        UNTIL TimerExpired(ET);
        ApdComPort1.RTS := false; // Release skyetek reset line.
END;

FUNCTION TTagReader.CheckReader: boolean;
BEGIN
        // Attenzione, qualsiasi Comando interrompe eventuale Scan Loop in corso !
        // basterebbe inviare solo un CR per verificare se in Loop...
        ApdComPort1.FlushInBuffer;
        application.ProcessMessages;
        RfidRequest := m1_getFwVer; // <CR>00220101<CR>   get reader FW version
        ApdComPort1.PutString(RfidRequest);
        // M1 risponde con <LF>22C005<CR><LF>
        Rfid_WaitResponse;
        IF RC = m1rc_FwReadOk THEN // '22'
                result := True
        ELSE IF RfidResponse <> '' THEN
                result := True
        ELSE
                result := false;
END;

PROCEDURE TTagReader.DataModuleDestroy(Sender: TObject);
BEGIN
        ApdComPort1.open := false;
END;

// ###################################################################

FUNCTION TTagReader.Received_(str: shortstring): boolean;
// Attende Stringa prevista o Timeout.
BEGIN // attenzione che Yeld=True permette processmessages cio� reentrancy.
        ApdComPort1.ProcessCommunications;
        IF ApdComPort1.WaitForString(str, 10, True, True) THEN
                // 1 tick = 55 msec,  10 => 550 ms
                result := True
        ELSE
                result := false;
END;

FUNCTION TTagReader.ReceivedLen_(Count: Integer;
  VAR frame: shortstring): boolean;
VAR // Attende Count bytes in var frame o Timeout.
        ET: EventTimer;
        k: Integer;
BEGIN
        k := 0;
        NewTimer(ET, 15);
        // 1 tick = 55 msec,  2 => 100 ms    MA c'� il Timer FREE ???
        REPEAT
                application.ProcessMessages;
                // Se il PC sta lavorando molto, alle volte non riesce a ricevere risposte complete e va in timeout !
                IF ApdComPort1.CharReady THEN
                BEGIN
                        frame := frame + ApdComPort1.GetChar;
                        inc(k);
                END;
        UNTIL (k = Count) OR TimerExpired(ET);
        IF k = Count THEN
                result := True
        ELSE
                result := false;
        // LogFrame(Rx, frame);
END;

PROCEDURE TTagReader.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
VAR
        st: shortstring;
BEGIN
        exit;
        // Putroppo ApdPacket sembra inaffidabile...!
        // alle volte non rileva i pacchetti pur avendoli ricevuti !
        ApdComPort1.GetBlock(st[1], Count);
        SetLength(st, Count);
        // LogFrame(Rx, st);
END;

PROCEDURE TTagReader.ApdDataPacket1Timeout(Sender: TObject);
BEGIN
        // LogFrame(Rx, ' Rx Timeout !');
END;

PROCEDURE TTagReader.ApdDataPacket1Packet(Sender: TObject; Data: Pointer;
  Size: Integer);
BEGIN
        // con IncludeStrings := False resta solo  -<...Data...>-
        // Move(Data^, RfidResponse[1], Size);
        SetLength(RfidResponse, Size);

        SetLength(RfidResponse, Size);
        Move(Data^, PChar(RfidResponse)^, Size); // ChatGPT version
        // LogFrame(Rx, RfidResponse); debug only. // Rossi version
        //
        RC := copy(RfidResponse, 1, 2); // Estrae Reponse Code !
        //
        // se � il risultato OK di una Select, visualizza il TID rilevato !
        IF RC = m1rc_TagSelected THEN
        BEGIN // '14' = Select Tag Pass.
                IF Length(RfidResponse) > 2 THEN
                BEGIN
                        TID := copy(RfidResponse, 3, Size - 2);
                        IF assigned(TagEventLink) THEN
                        BEGIN
                                // passo l'evento all' applicazione utente.
                                TagEventLink(TID);
                        END;
                END;
        END;
        IF RC = m1rc_TagReadOk THEN
        BEGIN // '24' = Read Tag Pass.
                Rfid_ascBlockData := copy(RfidResponse, 3, Size - 2);
                Rfid_strBlockData := HexStr2Str(Rfid_ascBlockData);
                // input Rfid_ascBlockData 2:1 output Rfid_strBlockData
        END;
        IF RC = m1rc_FwReadOk THEN
        BEGIN // '22' = Fw version.
                FwVersion := copy(RfidResponse, 3, Size - 2);
        END;
END;

PROCEDURE TTagReader.Rfid_WaitResponse;
VAR
        ET: EventTimer;
BEGIN
        // attende risposta da M1 o Timeout !
        RfidResponse := '';
        RC := '';
        NewTimer(ET, 10);
        // 1 tick = 55 msec,  10 => 550 ms    MA c'� il Timer FREE ???
        REPEAT
                application.ProcessMessages;
                // Se il PC sta lavorando molto, alle volte non riesce a
                ApdComPort1.ProcessCommunications;
                // ricevere risposte complete e va in timeout !
        UNTIL (RC <> '') OR TimerExpired(ET);
END;

// #################################################################################

PROCEDURE TTagReader.SingleScan;
BEGIN
        // ApdDataPacket1.Enabled := False;          // disable temporaneo
        RfidRequest := m1_SingleScan;
        // <CR>001401<CR>    iso15693, Loop, Inventory
        ApdComPort1.PutString(RfidRequest); // answer <LF>1C<CR><LF>
        Rfid_WaitResponse;
        // ApdDataPacket1.Enabled := True;
END;

PROCEDURE TTagReader.StartScan;
BEGIN
        // LogFrame(Line,' ');
        RfidRequest := m1_StartScan;
        // <CR>031401<CR>    iso15693, Loop, Inventory
        // LogFrame(Tx, RfidRequest);
        ApdComPort1.PutString(RfidRequest); // answer <LF>1C<CR><LF>
        Rfid_WaitResponse;
        // LogFrame(Rx, RfidResponse);  // mostro anche se non mi interessa.
        // ContinuoScan := True; � user var
END;

FUNCTION TTagReader.StopScan: boolean;
BEGIN
        // LogFrame(Line,' ');
        // LogFrame(Line,'Quit scan mode: ');
        RfidRequest := m1_StopScan; // any cmd.
        ApdComPort1.PutString(RfidRequest); // answer <LF>9C<CR><LF>
        // LogFrame(Tx, RfidRequest);
        Rfid_WaitResponse; // m1_ScanStopped
        IF RC = '9C' THEN // Select Tag Loop Cancel
                result := True // answer  <LF>9C<CR><LF>
        ELSE
                result := false;
END;

FUNCTION TTagReader.SelectTag(TagID: shortstring): boolean;
// metto in Selected Mode il TID corrente.
BEGIN
        // Se � in LOOP mode � necessario prima uscire !  (vedi StopScan)
        RfidRequest := m1_TagSelect; // inizio con parte fissa
        RfidRequest := RfidRequest + TID + cr; // e completo con Tid.
        ApdComPort1.PutString(RfidRequest);
        // LogFrame(Tx, RfidRequest);
        Rfid_WaitResponse;
        IF RC = '14' THEN // Tag Select Pass
                result := True // answer  <LF>14<CR><LF>
        ELSE
                result := false;
END;

FUNCTION TTagReader.ReadBlock(BlkNum: byte): boolean;
BEGIN
        RfidRequest := m1_TagReadBlock; // inizio con parte fissa
        RfidRequest := RfidRequest + HexToStr(BlkNum) + HexToStr($01) + cr;
        // e completo con address e n� blocchi da leggere.
        ApdComPort1.PutString(RfidRequest);
        Rfid_WaitResponse;
        IF RC = '24' THEN // = Read Tag Pass.
                result := True // answer  <LF>24 + data<CR><LF>
        ELSE
                result := false;
END;

FUNCTION TTagReader.WriteBlock(BlkNum: byte; dataAs: tdataAs;
  BlkData: STRING): boolean;
BEGIN
        IF dataAs = asStr THEN
        BEGIN
                // se stringa, va convertita in hexstring, perch� cos� vuole M1.
                BlkData := Str2HexStr(BlkData);
        END;
        RfidRequest := m1_TagWriteBlock; // inizio con parte fissa
        // e completo con Address + n� blocchi da scrivere (1) + Data.
        RfidRequest := RfidRequest + HexToStr(BlkNum) + HexToStr($01) + BlkData + cr;
        ApdComPort1.PutString(RfidRequest);
        Rfid_WaitResponse;
        IF RC = '44' THEN // = Write Tag Pass.
                result := True // answer  <LF>44<CR><LF>
        ELSE
                result := false;
END;

// ########################################################################################
// util

FUNCTION HexToStr(H: byte): shortstring; // $2B  ->  '2B'
CONST
        Hex: shortstring = '0123456789ABCDEF';
VAR
        t0, t1: byte;
BEGIN
        t0 := H SHR 4;
        t1 := H AND $0F;
        HexToStr := Hex[t0 + 1] + Hex[t1 + 1];
END;

// in 2:1 out !
FUNCTION HexStr2Str(StrHex: STRING): shortstring;
// input(4) '5349' -> output(2) 'SI'
VAR // input(4) 'C0B4' -> output(2) $C0+$B4
        j: Integer; // Result � short cos� non perdo eventuali $00 in output !
BEGIN
        result := '';
        // Passaggio da stringaHex con lunghezza N perch� Hex, a stringaAsc con lunghezza dimezzata N/2.
        FOR j := 0 TO (Length(StrHex) DIV 2) - 1 DO
                result := result + char(StrhexToInt(copy(StrHex, j * 2 + 1, 2)))
END;

// in 1:2 out !
FUNCTION Str2HexStr(str: shortstring): STRING;
VAR
        j: Integer;
        // Passaggio da stringaAsc con lunghezza N, a stringaHex con lunghezza doppia 2N.
BEGIN // input(2) $C0+$B4 -> output(4) 'C0B4'
        result := ''; // input(2)   'SI'  -> output(4) '5349'
        FOR j := 1 TO Length(str) DO
                result := result + HexToStr(byte(str[j]))
END;

FUNCTION CharsToStrhex(dump: shortstring): shortstring;
VAR
        i, l: Integer;
        t: shortstring;
BEGIN
        t := '';
        l := Length(dump);
        FOR i := 1 TO l DO
                t := t + HexToStr(byte(dump[i]));
        result := t;
END;

END.
