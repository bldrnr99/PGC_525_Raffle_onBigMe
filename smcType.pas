unit smcType;

interface
//
////////// dichiarazione costanti comuni ai vari moduli di SMARTIDEA.
//
uses
  Windows,
  Messages;

const
     // mutex per verifica programmi in esecuzione.
     kEmoTag           = 'EmoTag';
     kSmcTests         = 'SmcTests';
     kSmartService     = 'SmartideaSrv';
     kInitHwAndCard    = 'InitHwAndCard';
     kSmartSet         = 'SmartSetup';
     kCardBuilder      = 'CardBuilder';
     kLoader           = 'DrvLoader';
     //  'MicroGuard' è in mgType.pas
     
     // mutex per verifica situazioni in corso.
     IOinProgress        = 'SmcIoMtx';        // se esiste, indica I/O sequence in corso.
     SessionExclusive    = 'SmcSsExclusive';  // se esiste, indica I/O sequence in corso.
     // messaggi per comunicazioni interprocesses; verranno registrati in windows.
     msgSmartIdeaCardIn     = 'SmiCardIn';
     msgSmartIdeaCardOut    = 'SmiCardOut';

     kSsaverBitmap = 'SmartideaSSaver.BMP';
     kMainINI = 'Smc.ini';
     kUserINI = 'SmcUser.ini';
     //
     kDrvPassword = '|;ç@ò° #?5%<])^é]+_£/>*!C''èra_Una-Volt@{ù"~';
     kRootkey = HKEY_LOCAL_MACHINE;
     kPath    = 'SOFTWARE\3MSystem\SmartIdea\Config';
     /////       passwords vanno confuse tra altre costanti !!!
     kDrvPassword2 = 'SharewareVer.';
     kManifacturer = 'Gread';    // per bypass tutti i blocchi in InitHw/Card in produzione.

     /////////  kostanti per Registry...
     kAP = 'AskPin';                //
     kAL = 'AutoLogon';             //
     kAW = 'AutoLogWindow';         //
     kCT = 'CardType';              //  Application
     kCM = 'CardModel';             //  default.
     kClkLo = 'CryLo';              //
     kClkHi = 'CryHi';              //
     kDL = 'DriveALock';            //
     kLO = 'ForceLogoff';           //
     kPO = 'ForcePwrOff';           //
     kWS = 'ForceWinShut';          //
     kIT = 'InterfaceType';         //  0=FDD-B  1=FDD-A  2=KYB   3=USB
     kHK = 'KeybTrap';              // in SmartSrv abilita rilevazione hotkeys. Non usato.
     kRD = 'KYBRepeatDelay';        // valori da ripristinare su keyboard dopo una sessione
     kRR = 'KYBRepeatRate';         // di I/O, che di fatto resetta quelli impostati dal sistema.
     kLA = 'Language';              // Default language. Per moduli che lo usano.
     kLP = 'LockPcOnCardEx';        // in SmartSrv starta lo screensaver.
     kMD = 'MountDriveOnCardIns';   //
     kHL = 'PcHardLock';            // in SmartSrv dice se HardLock (keyb) del Pc oppure solo Soft mode.
     kPC = 'PowerControl';          // in SmartSrv e Configurazioni sistema.
     kSN = 'ScreenSaverName';       //
     kUD = 'UnmountDriveOnCardExt'; //
     /////                       ( old pwd = !C''èra_Una-Volt@ )
     kDrvPassword3 = 'Com1,Com2,Lpt1'; //  deve essere la stessa per Hex2Drv e SmcDrvLoader !
     /////

const
     // kostanti usate più che altro in smcHalxxx.
     PingID = $9A;  // byte predefinito con cui AVR risponde ai Ping la V2.
     //PingID = $8A;  // byte predefinito con cui AVR risponde ai Ping la V1.
     ACK    = $06;  // per risposte da AVR
     NAK    = $15;

     kPwrCntlYes = $00;  // flag byte n°8, dice Smartidea prende controllo = esclude switch.
     kPwrCntlNo  = $FF;  // flag byte n°8, dice Smartidea non controlla = manuale.
                         // $FF è default value in eeprom AVR !
     // Floppy interface ***
     // i valori di durata del periodo T del clock di comunicazione con AVR
     // è invece stato reso variabile; ovvero regolabile per tarare la velocità
     // di I/O su vari PC !
     WrAVR = 2;       // = spiazzamento di $3F2 da 3F0.
     RdAVR = 7;       // = spiazzamento di $3F7 da 3F0.
     kFloppyAbusy = $1C;  // $1C = Floppy Drive A: attivo !
     kAVRready = $7F;   // = Diskette change rilasciato, come Ack per AVR pronto per I/O.
     kAVRbusy  = $FF;   // = Diskette change attivato, indica AVR occupato.
     rdData_1  = $FF;     // valore letto su FDD $3F7 che corrisponde a 1 logico da AVR.
     rdData_0  = $7F;     // valore letto su FDD $3F7 che corrisponde a 0 logico da AVR.
     // per certe MB i valori letti da 3F7 vengono ridotti a questi due casi con un OR
     // al fine di testare soloil 7° bit, che è quello di DiskChange che ci interessa!
     // Infatti capita anche di trovare $00/$80, ecc.
     ClockTimeWkUp = 50000;  // 50 millisecondi di durata del dummy pulse per AVR Wake-Up.
     // kTimeout è un parametro vincolato a modo di operare in StartIOsequence !!!
     // deve essere sempre MAGGIORE di Watch-Dog timeout su AVR (Max 2048), Così da
     // dar modo ad AVR di ripartire (senza delays iniziali !) e rispondere con Ready.
     kTimeOut = 2600;       // millisecondi di attesa risposta (READY).
     kAvrWakeupTime = 40;   // millisecondi necessari per StartUp di AVR.  Ovvero il
                            // il tempo del ResetPulseHW + Codice SW iniziale (InitPorts,ecc.)
     wrRelease = $0C;     // valore di default su FDD $3F2. equivale a rilascio clock.

     // keyboard interface ***
     kbOUT   = 0;        // data register 60H  to keyboard
     kbIN    = 0;        // data register 60H  from keyboard
     kbCMD     = 4;      // in write è  keyboard cmd register 64H
     kbSTATUS  = 4;      // in read è   keyboard status register 64H
     kbTimeOut = 50;     // 50 msec in cui attendere risposta da Kyb/Avr, poi scatta timeout.
     kSessionTimer = 350;// 350 msec durata max sessione su AVR, che poi rilascia KybInterface !
     cmdEndSession = $18;//     
     MouseDisable = $A7; // command to Controller through Command Register $64
     MouseEnable  = $A8; //
     KeybDisable  = $F5; // command to Keyboard through Output Register $60
     CtrlReset    = $AA; // KeybController SelfTest (risolve hangs?)
     KeybEnable   = $F4; //
     SetTypematic = $F3; //
     IRQoffXTset  = $26; // command byte through Output Register $60
     IRQonATset   = $47; //
     cmdEcho      = $D2; // Il byte seguente viene ritornato al sistema (Windows) tramite un IRQ1 !
     ScanCodeSel  = $F0; // Seleziona scan code tables.
     ScanCodeCurr = $00; //
     ScanCode1    = $01; //
     ScanCode2    = $02; //
     ScanCode3    = $03; //
     MagicNum1 = $25;    // data to Keyboard through Output Register $60
     MagicNum2 = $7B;    //
     KybACK = $FA;       // tipi di response byte da Keyboard al Pc.
     KybERR = $FE;       //

     // USB interface ***


     // DriverX queue constants
     QMaxOperaz = 512;   // per FDD una WR sono 4*n°bits,  per RD sono 5*n°bits !!!!!!!!
                         // es.: lettura 8+1 bytes => 9*8*5 = 360 queue operazioni to store !!!
     QMaxBuffer = 512;     // Ogni locazione di questo buffer è in words !!! quindi per fare
                           // 256 letture, devo allocare 512 Bytes !!!
                           // per FDD ogni bit letto occupa una locazione, ed ogni lettura è
                           // composta da 5 operazioni quindi 9ByteDati*8bits*5opz=360.
const
  // messaggi per comunicazioni interprocesses; verranno registrati in windows.

  TimeoutIoMutex      = 6000;           // 6 secondi di attesa prima di dare timeout.
                                        // legato anche a Max Timeout in Tx/Rx Cpu Cards !

  maxSharedCard  = 8192;  // max area shared card mem.
  maxSharedFlash = 2048;  // max area shared eep mem.

  maxArray            = 4096;  // lunghezza massima per array daticard e cryptografia !
  maxSArray           = 256;   // lunghezza massima per ShortArray (blocchi da 8 byte) !
  max8515CodeArray    = 8192;  // lunghezza array per Upload di Firmware su 8515 !
  maxAT161CodeArray   = 16384; // lunghezza array per Upload di Firmware su AT161 !

  CodeSizeAT8515   = 8192;   // FUNcards dimensione codice AVR8515.
  EEpromSizeAT8515 = 512;    // FUNcards dimensione eeprom AVR8515.
  CodeSizeAT2323   = 2048;   // FUNcards dimensione codice AVR2323.
  EEpromSizeAT2323 = 128;    // FUNcards dimensione eeprom AVR2323.

  EEpromSize24LC16   = 2048;   // dimensione ext.eeprom. 2Kb
  EEpromSize24LC64   = 8192;   // dimensione ext.eeprom. 8Kb
  EEpromSize24LC128  = 16384;  // dimensione ext.eeprom. 16Kb
  EEpromSize24LC256  = 32768;  // dimensione ext.eeprom. 32Kb
  EEpromSize24LC512  = 65536;  // dimensione ext.eeprom. 64Kb
  EEpromSize24LC1024 = 131072; // dimensione ext.eeprom. 128Kb

  // le kostanti per EEprom (AVR) possono risiedere in questo file perchè non
  // cambiano al cambiare del tipo di card. Le costanti relative alla Card invece
  // possono variare a runtime (user cambia card-type), quindi vengono gestite
  // in SmartC32.pas
  MAXeeHw   = 511; // Indirizzo fisico massimo per EEprom (512 bytes con AVR8515) !
  MAXeeAddrUser  = 447; // massimo e minimo indirizzo Utente per per EEProm. Dipende da AVR,
                        // 0-447=448 bytes.   448=512-64 infatti i primi 64 sono ad
                        // uso mio (di sistema!).
  FlagPwr         = 8;    // 8=Power Control
                          //    disattiva gli switch manuali.  $00
                          //    riabilita gli switch manuali.  $FF
  FlagCardInterface = 7;  // 7=Default CardInterface su reader (AVR usa per Pc power-on)
                          // ifXicor := char($FF) default è sempre Xicor.
                          //   ifI2C := char($01) NB: riflettono valori delle Const su AVR !
                          //   ifCpu := char($02)
                          //   ifISP := char($03)
  Flag6           = 6;    // queste sono posizioni delle flag all'interno del gruppo di
  Flag5           = 5;    // 8 byte, di cui in realta solo 6 usabili, dato che le prime
  Flag4           = 4;    // all'indirizzo zero e uno, vengono spesso corrotte al reset di AVR !
  Flag3           = 3;
  Flag2           = 2; // Non
  Flag1           = 1; // Usare!
  //  6 bytes per Flags. Non usare byte 1 e 2 !!!
  addrFlags       = 0;
  addrReadPwd     = 8;    //
  addrWritePwd    = 16;   //  indirizzi di sistema nella EEprom di AVR.
  addrCryptoKey   = 24;   //  chiave univoca per lettore o gruppo in Lan.
  addrWakeUpID1   = 32;   //  User
  addrWakeUpID2   = 40;   //  Admin
  addrReaderID    = 48;   //  main ReaderID.
  addrEEpromCRC   = 56;   //  di cui:
  //  58 - 60     = free
  //  61 - 62     = CRC_SysArea  è word contenente CRC della Sys EEprom
  //                             per ora è fuori dal range di calcolo CRC.
  //  63          = CRC_status   è byte calcolato da AVR, dice se crc è OK !
  //                             risiede in eeprom, ma fuori dal range di calcolo CRC.
                                 EEpromBAD = $FF;
                                 EEpromOK  = $49;
  //  System area finisce a 63.
  BASEeeAddrUser  = 64;   // quindi è praticamente fisso e non varia a seconda delle cards !
  UsrEENumBlocks  = 56;   // Numero di BLOCCHI(da 8 bytes) riservati all'utente. Usato più che altro per property editor.

  addrCardID      = 0; // è indirizzo di blocco riservato su Card.

  // per velocizzare test su blocco 8 byte cardID.
  kFFlong = chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+
            chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+
            chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+
            chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+
            chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF);
  kFF  = chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF)+chr($FF);
  k00  = chr($00)+chr($00)+chr($00)+chr($00)+chr($00)+chr($00)+chr($00)+chr($00);

  // Layout 102 tasti !
  // Ora uso solo il SET 2, così non devo mettermi anche a cambiare/gestire il SET corrente
  // di keyboard che per default è 2 !!!!
  // per il PIN mi servono solo lettere e numeri, ed eventualmente gli shift !
  KeyLangITA: array[1..104] of Char = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8',
                                '9','ì','''','ì','ù',char($08),' ','|','.','.','.','.','.','.','.','.','.','.','~','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.',
                                       'è','.','.','.','.','.','.','.','.','.','.','.','/','*','-','+','~','.','0','1','2','3','4','5','6','7','8','9','+','ò','à',',','.','-');

  KeySet2:    array[1..104] of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8',
                                 '9','ì','-','=','\',char($08),' ','|','.','.','.','.','.','.','.','.','.','.','~','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.',
                                       '[','.','.','.','.','.','.','.','.','.','.','.','/','*','-','+','~','.','0','1','2','3','4','5','6','7','8','9',']',';','"',',','.','/');
  // ScanCodes SET 1     1..105 ----------------------------------------------------------------------------------------------------------------------------------------------------
  // è il set (a 2 bytes) che corrisponde ai bytes che la keyb controller passa a windows ad ogni IRQ1 !
  // ovvero 2 IRQ1 per ogni tasto premuto !
         // Questi sono i codici tastiera (Set1) da usare per Stuff keyboard !
         // Il break è il make ORed $80, quindi sarebbe calcolabile invece di usare array...
  Make1:      array[1..104] of byte = ($1E,$30,$2E,$20,$12,$21,$22,$23,$17,$24,$25,$26,$32,$31,$18,$19,$10,$13,$1F,$14,$16,$2F,$11,$2D,$15,$2C,$0B,$02,$03,$04,$05,$06,$07,$08,$09,
                                       $0A,$29,$0C,$0D,$2B,$0E,$39,$0F,$3A,$2A,$1D,$E0,$38,$36,$E0,$E0,$E0,$E0,$1C,$01,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$57,$58,$E0,$46,$E1,
                                       $1A,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$45,$E0,$37,$4A,$4E,$E0,$53,$52,$4F,$50,$51,$4B,$4C,$4D,$47,$09,$49,$1B,$27,$28,$33,$34,$35);

  Break1:     array[1..104] of byte = ($9E,$B0,$AE,$A0,$92,$A1,$A2,$A3,$97,$A4,$A5,$A6,$B2,$B1,$98,$99,$19,$93,$9F,$94,$96,$AF,$91,$AD,$95,$AC,$8B,$82,$83,$84,$85,$86,$87,$88,$89,
                                       $8A,$89,$8C,$8D,$AB,$8E,$B9,$8F,$BA,$AA,$9D,$5B,$B8,$B6,$1D,$5C,$38,$5D,$9C,$81,$BB,$BC,$BD,$BE,$BF,$C0,$C1,$C2,$C3,$C4,$D7,$D8,$2A,$C6,$1D,
                                       $9A,$52,$47,$49,$53,$4F,$51,$48,$4B,$50,$4D,$C5,$35,$B7,$CA,$CE,$1C,$D3,$D2,$CF,$D0,$D1,$CB,$CC,$CD,$C7,$89,$C9,$9B,$A7,$A8,$B3,$B4,$B5);

  // ScanCodes SET 2     1..105 ----------------------------------------------------------------------------------------------------------------------------------------------------
  // è il set (a 3 bytes) usato per comunicazione su cavo tastiera fra controller e keyboard !
          // nei make/break (Set2) codes con più di un byte, metto solo il primo byte ($E0), tanto
          // controllo solo quelli utili, ovvero PadEnter !
  Make2:      array[1..104] of byte = ($1C,$32,$21,$23,$24,$2B,$34,$33,$43,$3B,$42,$4B,$3A,$31,$44,$4D,$15,$2D,$1B,$2C,$3C,$2A,$1D,$22,$35,$1A,$45,$16,$1E,$26,$25,$2E,$36,$3D,$3E,
                                       $46,$0E,$4E,$55,$5D,$66,$29,$0D,$58,$12,$14,$E0,$11,$59,$E0,$E0,$E0,$E0,$5A,$76,$05,$06,$04,$0C,$03,$0B,$83,$0A,$01,$09,$78,$07,$E0,$7E,$E1,
                                       $54,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$77,$E0,$7C,$7B,$79,$E0,$71,$70,$69,$72,$7A,$6B,$73,$74,$6C,$75,$7D,$5B,$4C,$52,$41,$49,$4A);
         // Nei break code ometto l'F0 iniziale comune a quasi tutti i tasti ! infatti
         // i break sono uguali ai make, solo preceduto da $F0 !!!
  Break2:     array[1..104] of byte = ($1C,$32,$21,$23,$24,$2B,$34,$33,$43,$3B,$42,$4B,$3A,$31,$44,$4D,$15,$2D,$1B,$2C,$3C,$2A,$1D,$22,$35,$1A,$45,$16,$1E,$26,$25,$2E,$36,$3D,$3E,
                                       $46,$0E,$4E,$55,$5D,$66,$29,$0D,$58,$12,$14,$E0,$11,$59,$E0,$E0,$E0,$E0,$5A,$76,$05,$06,$04,$0C,$03,$0B,$83,$0A,$01,$09,$78,$07,$E0,$7E,$E1,
                                       $54,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$77,$E0,$7C,$7B,$79,$E0,$71,$70,$69,$72,$7A,$6B,$73,$74,$6C,$75,$7D,$5B,$4C,$52,$41,$49,$4A);


type

  TLockMode = (lkNoLock, lkLocked, lkPinOnly);
  TLockType = (ltSoftLock, ltHardLock);
  TOsVersion = (OsUnknown,OsWin95,OsWin98,OsWin98SE,OsWinME,OsWinNT,OsWin2000,OsWinXP);
  TTarget = (None, IspMicro, MainMicro);  // per definire con chi comunicare.
  TInterfaceType = (FloppyB, FloppyA, Keyboard, USB);
  TDataArr = array[1..maxArray] of AnsiChar;  // per poter passare un array come parametro di
                                          // ritorno delle funzioni De/Crypt.
                                          // Base 1 per essere compatibile con LongString !
  TBlockArr = array[1..maxSArray] of char;

  TUserType = (TAdmin, TUser, TAny); // tipi di utente, ovvero tipi CardID.

  TCardInterface = (ifXicor, ifI2C, ifCpu, ifISP);  // mirror di enum su AVR !!!
  TResetPolarity = (rpPositive, rpNegative); //  impulso di Card Reset 010 oppure 101.
  TSession       = (ssOpen, ssOpenExclusive, ssClose);
  // Card Activate/Deactivate è in effetti già presente in TSession, ma in ReaderCmd
  // metto a disposizione i singoli comandi per un maggior controllo su card, pur
  // mantenendo aperte le sessioni correnti.
  TReaderCmd     = (ResetCpuCard, CpuCardActivate, CpuCardDeactivate, IgnoreNull);

  TMetodo = procedure of object;   // usate per lanciare CardIO events in SmartC32 da HAL !

var
     // i seguenti valori di Clock vanno settati assieme alla durata dell'ultimo
     // periodo T nel loop di Tx a Pc sull'AVR !!!    altrimenti l'ultimo bit ricevuto
     // da AVR sarà spesso a 1, es: 1955AA55  diventa 1955AAD5 !
     //  FDD
     ClockTimeLo : word; //10;  // microsecondi di durata 1/2T.  ovvero ClockTimeLow.
     ClockTimeHi : word; //5;   // microsecondi di durata 1/2T.  ovvero ClockTimeHigh. T = 20.
     ClockTime   : word; //15;  // microsecondi di durata T. serve in cicli dummy.
     wrClock_1   : byte; // = $2C;     // valori da inviare su port FDD per scrivere
     wrClock_0   : byte; // = $2D;     // zero o uno verso AVR.
     FddDrive    : byte; // 0=fddB  1=fddA  2=kyb  3=usb
     //  KYB
     KybRepeatDelay : byte;//
     KybRepeatRate  : byte;//
     TypematicVal:  byte;  // valore complessivo da restorare in kyboard (ricavato da
                           // calcolo sui due parametri salvati in registry).

     // var inizializzate in AVR8515fdd, ma così possono anche essere
     // forzate dall'appplicazione chiamante !
     HalActive : boolean;         // come FActive per componente. Questo è per unit HAL !
     kSysAdmin : boolean;         // verrà settata per far si che alcune funzioni
                 		          // accedano anche a dati/funzioni di systema
                                  // default è False !
     kSysEEpromChanged : boolean; // dice se sono stati cambiati valori nella System Area
                                  // della eeprom AVR (WriteAvrEEprom); così poi in
                                  // chiusura SmartC32 verrà forzato il ricalcolo del CRC.
     CurrLockType : TLockType;   // Hard o Soft, CurrLockMode è in smcType comune a tutti gli Halxxx !
     CurrLockMode : TLockMode;   // dice se Pc locked.
     IfType       : shortstring; // testo dice Tipo Interfaccia. Usata per ErrDlg comune.
     kCardTimeout:   integer;    // massimo Timeout in ReadCPUcard espresso in AVR_SysTick.
                                 // su AVR 1 Tick = 30 msec, quindi 50 = 1,5 secondi

     //  Valori che vengono riassegnati se l'utente cambia tipo di card.
     MinHwBlock:       word;   // di solito è 0.
     MaxHwBlock:       word;   // inteso come 0->61 = 62 totali.
     TotNumBlocks:     word;   // n° Totale dei blocchi sulla Card.
     UsrNumBlocks:     word;   // numero di blocchi riservati all'utente.
     SysNumBlocks:     word;   // numero di blocchi iniziali riservati al
                               // sistema. 0->0 = 1.
                               // E' indipendente da UserBeginBlock !
     UserHwBeginBlock: word;   // = SysNumBlocks - MinHwBlock
     // il limite superiore vale sia per User che System. La parte riservata al sistema
     // è invece quella iniziale (1 o 2 blocchi); poi viene la user area.
     // UserHwEndBlock = MaxHwBlock.
     // Seguono valori min e max, visibili e selezionabili dall'utente
     UserBeginBlock:   word;
                               // l'utente parte sempre da blocco 1.
     UserEndBlock:     word;   // 1->61 = 61 user totali;
                               // è ultimo blocco indirizzabile dall'utente.

implementation

// versione 4: abilito 2° locazione (di riserva) per ReaderID.
//             infatti alle volte il reset di AVR cancella la prima
//             locazione in EEprom !  lascio sempre attiva la locazione originale, ma
//             per compatibilità con i già installati, da ora, setto e verifico
//             anche la locazione di riserva !


end.




