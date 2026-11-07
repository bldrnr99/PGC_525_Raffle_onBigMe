unit mgType;

interface
//
////////// dichiarazione costanti comuni ai vari moduli di MICROGUARD.
//
uses
  Windows,
  Messages;

const
     // mutex per verifica programmi in esecuzione.
     kMicroGuard       = 'MicroGuard';
     // mutex per verifica situazioni in corso.
     // messaggi per comunicazioni interprocesses; verranno registrati in windows.

     kMgRootkey = HKEY_LOCAL_MACHINE;
     kMgPath    = 'SOFTWARE\3MSystem\MicroGuard\Config';

     //  kostanti per Registry...
     kMgLA = 'Language';              // Default language. Per moduli che lo usano.

const
     // kostanti
     mgETX   = $03;
     mgSTX   = $02;
     kISPaddress  = 'A0';   // $FC i Device sotto ISP hanno indirizzo fisso, uguale per tutti in boot loader !

     cmdGetDeviceList   = chr($10);  // comando locale (non va ai Microguards)
     cmdPing            = $1A;
     cmdGetDeviceInfo   = $1B;
     cmdRelayOn         = chr($20);
     cmdRelayOff        = chr($23);
     cmdRelayToggle     = chr($25);
     cmdGetIOStatus     = chr($30);  // risponde con 4 bytes di on/off.
     cmdGetANAStatus    = $33;       // risponde con 2 word  di valori analogici
     cmdSetParameter    = $35;       // per settare cfg in eeprom MGuard.
     cmdSetWarning      = chr($37);  // per controllare Led/Beeper.
     cmdEnterISP        = $3F;       // per far entrare divice in ISP boot loader !

     answDeviceList     = $80;
     answPingAnswer     = $8C;
     answIspReady       = $8D;
     answDeviceInfo     = $8E;
     answRelayOn        = $B0;
     answRelayOff       = $B3;
     answRelToggled     = $B5;
     answIOStatus       = $C0;
     answSetParameter   = $C5;
     answSetWarning     = $C7;
     answEnterISP       = $CF;

     eveCardIn          = chr($90);  // in Datamodule diventa $91 se anche Door opened !
     eveCardInDoorOpen  = chr($91);  
     eveCardOut         = chr($93);
     eveCardInsideIn    = chr($95);
     eveCardInsideOut   = chr($97);
     EveButton          = chr($99);   // user button.
     eveSwitch1On       = chr($A0);
     eveSwitch1Off      = chr($A2);
     eveSwitch2On       = chr($A4);
     eveSwitch2Off      = chr($A6);


const
  maxATmega32CodeArray  = 32768; // lunghezza array per Upload di Firmware su ATmega323
  maxATmegaEEpArray   = 2048;  //

  paramUnLock1      = '1';
  paramUnLock2      = '2';
  paramUnLock3      = '3';
  paramOneTimeSet   = '4';
  paramOneTimeReset = '5';
  paramRdPwd        = '6';
  paramWrPwd        = '7';
  paramSecRelay     = '8';
  paramLedRed       = 'A';
  paramLedGreen     = 'B';
  paramLedOff       = 'C';
  paramLedBlink     = 'D';
  paramNumBeeps     = 'E';


type

  TDynRxDataEvent = procedure of object;
  TDeviceState = (dsReady, dsIspReady, dsOffLine);  // Microguard status
  //            1         2         3            4
  TIOtype = (ioNone, ioRelay, ioSwitch, ioCounter, ioAnalogInput);  // enum I/O types
  //TChType = (chCom, chUsb, chTcp);       // Channel types

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Le seguenti strutture sono molto importanti per mantenere dati relativi ai Device (per Polling)
  // e alle TreeView (per visualizzazioni e status).
  // Sono struttire interdipendenti, ma possono essere popolate in momenti diversi, perchè i Node-ID sono
  // assegnati dalle Routine del MainForm (di visualizzazione) che è l'ultimo a essere creato,
  // Quindi il LanArray che è generato per primo in DataModule, può essere a sua volta completato solo dopo
  // la costruzione(LoadLanLayout) delle TreeView.
  // Questo può sembrare macchinoso, e magari è migliorabile, ma si deve sempre tenere separati il Motore Lan
  // dal Main Form di visualizzazione. Anche in previsione di conversione in Service !
  // Anche l'aggancio di §Eventi Dynamici dal basso (LanHal, Datamodule) verso l'alto (MainForm) è sempre
  // motivato dalla necessità di tenere separati LanEngine da Visualizzazioni !!!!!
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  TLanRec = record      // Record Array con i dati di tutti i devices sulla lan.
    Codice:     integer;        // chiave primaria di MgLanConfig
    Channel:    integer;
    Router:     string[15];     // inteso come address di tipo 485 o TCP.
    Address:    string[15];     // di tipo 485 o TCP.
    DevStatus:  TDeviceState;   // dsReady, dsIspReady, dsDead
    DeviceType: integer;        // 1 (Reader), 2 (Actuator), 3 (Router), 4 ...
    DeviceTypeStr: string[15];
    DeviceName: string[30];
    NodeId:     integer;
    CpuType:    string[10];
    CpuClock:   string[10];
    CpuSign:    string[10];
    CpuFwVer:   string[4];
  end;

  TIORec = record         // Record con i NodeID relativi agli I/O di ogni device.
    DeviceNodeId:   integer;
    IOtype:         integer;        // es  1 (relay), 2 (switch), 3 (analogInput) ...
    IOaddr:         integer;        // es. 1 (relay1), 2 (relay2), 3 (relay3) ...
    IOname:         string[15];     // es. "Relay 1"
    IOnodeId:       integer;        // es. nodeid di "Relay 1"
    IOstate1nodeId: integer;        // es. nodeid di "ON" o Valore Analog "XXXXX"
    IOstate2nodeId: integer;        // es. nodeid di "OFF"
  end;

  TFrame485 = record            // Record con i dati relativi a Tx e Rx rs485 corrente.
    Channel:    integer;
    Router:     string[15];     // inteso come address di tipo 485 o TCP.
    Address:    string[15];     // di tipo 485 o TCP.
    AnswerToPoll: boolean;      // dice se è una frame di Polling che si aspetta quindi una Risposta !!!
    IspFrame:   boolean;        // dice se Frame corrente è per ISP.  Sono trattate un po' diversamente.
    RxTimeout:  boolean;
    Data:       string;
  end;


var
   LanArray:       array of TLanRec;
   NumDevices:     integer;
   IOarray:        array of TIORec;
   NumIO:          integer;
   Frame485:       TFrame485;
   iniPollTimeout: integer;
   iniSleepMs:     integer;



implementation

// none

initialization

finalization
//   finalize(IOarray);


(*
    // range di AppError Num sono 0-9 prettamente Locali all'applicativo.
    // Sys Errors son riservati a VCL SmartC32,  App Errors in applicativo (qui)
    //    0x = Errori Base iniziali a startup programma.
    //           01, 'Unable to connect at MicroGuard Database !'
    //           02, 'Unable to Open MicroGuard Tables !'
    //           03, 'Unable to Write LOG Record !'
    //           04, ''
    //    1x = Errors, in inizio connessioni ai channels.
    //           10, 'Unable to Activate Lan Engine !'
    //           11, 'Unable to Activate Channel '
    //           12,
    //           13,
    //           14,
    //    2x = problemi con registry entry / creazione componente.
    //           20, 'Registry entry for SmartIdea not found.'
    //           22, 'Device SmartIdea not found. Error #'
    //           23, 'Registry entry for Fdd parameters not found'  (smcHalFDD.pas)
    //           24  'Unable to read from Main INIfile '   (smc.ini)
    //           25  'Unable to Read RegistryKey'  (problema di accesso al registry 3MSys)
    //           26  ' xxx - Privileged Operation' (problema di diritti di accesso a registry 3MSys in NT/2000)
    //    3x = problemi di autenticazione.
    //           30, 'Authentication failed.');
    //    4x = a chiusura connessione al reader e routine SysArea.
    //           40, ''
    //           41, ''
    //           42, ''
    //    5x = free.
*)

(*
        COMMAND / EVENT  TABLE

    MgRecordType:     string        // C command,  E event
    MgRecordDate:     double
    MgRecordTime:     double
    MgDeviceType:     integer
    MgDeviceAddress:  string
    MgDeviceName:     string        // only for Events
    MgEventType:      integer
    MgEventCode:      integer
    MgEventDescr:     string
    MgCommandType:    integer       // only for Commands
    MgCommandCode:    integer

example:

     * Command TO Server *

        - GetDeviceList (one cmd many events)
            MgRecordType   = 'C'
            MgCommandType  =  1
            MgCommandCode  = 10

        - RelayON
            MgRecordType    = 'C'
            MgDeviceAddress = user defined
            MgCommandType   =  2
            MgCommandCode   = 20

        - RelayOFF
            MgRecordType    = 'C'
            MgDeviceAddress = user defined
            MgCommandType   =  2
            MgCommandCode   = 23

        - RelayTOGGLE
            MgRecordType    = 'C'
            MgDeviceAddress = user defined
            MgCommandType   =  2
            MgCommandCode   = 25


     * Event FROM Server *

        - DeviceRecord                   (RecordS di risposta alla GetDevList)
            MgRecordType       = 'E'
            MgRecordDate:      = current
            MgRecordTime:      = current
            MgDeviceType:      =
            MgDeviceAddress:   = string
            MgDeviceName:      = string
            MgEventType:       =  1
            MgEventCode:       = 80
            MgEventDescr:      = 001-017     // record 1 di N

        - CardIn                         (Card inserita, restituisce la Label 8 bytes)
            MgRecordType       = 'E'
            MgRecordDate:      = current
            MgRecordTime:      = current
            MgDeviceType:      =
            MgDeviceAddress:   = string
            MgDeviceName:      = string
            MgEventType:       =  2
            MgEventCode:       = 90
            MgEventDescr:      = "Card Label"

        - CardOut                         (Card estratta)
            MgRecordType       = 'E'
            MgRecordDate:      = current
            MgRecordTime:      = current
            MgDeviceType:      =
            MgDeviceAddress:   = string
            MgDeviceName:      = string
            MgEventType:       =  2
            MgEventCode:       = 93

        - CardInside                     (Stato Card in tasca interna inserita)
            MgRecordType       = 'E'
            MgRecordDate:      = current
            MgRecordTime:      = current
            MgDeviceType:      =
            MgDeviceAddress:   = string
            MgDeviceName:      = string
            MgEventType:       =  2
            MgEventCode:       = 95
            MgEventDescr:      = Y

        - CardInside                     (Stato Card in tasca interna estratta)
            MgRecordType       = 'E'
            MgRecordDate:      = current
            MgRecordTime:      = current
            MgDeviceType:      =
            MgDeviceAddress:   = string
            MgDeviceName:      = string
            MgEventType:       =  2
            MgEventCode:       = 97
            MgEventDescr:      = N

*)

end.



