UNIT DM1;

INTERFACE

USES
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Math,
  System.Variants,
  System.Classes,
  System.DateUtils,
  Registry,
  Vcl.Printers,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DBSumLst,
  OtlCommon,
  OtlComm,
  OtlTask,
  OtlTaskControl,
  OtlEventMonitor,
  MMSystem, frxClass, frxDBSet, edbcomps,
  JvExExtCtrls, JvExtComponent, JvClock,
  ipwsmpp,
  IdText,
  System.StrUtils,
  System.UITypes,
  AdvSmoothSlider,
  System.Types,
  System.RegularExpressions,
  DBGridEh,
  IniFiles, MemTableDataEh, MemTableEh, PivotGridsEh, Datasnap.DBClient;

TYPE
  TForm2 = CLASS(TForm)
    EDBEngine1: TEDBEngine;
    PGC_Session: TEDBSession;
    DB_Main: TEDBDatabase;
    tb_Fees: TEDBTable;
    tb_Cassa_Services: TEDBTable;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    Shape4: TShape;
    Label4: TLabel;
    Shape5: TShape;
    Label5: TLabel;
    tb_Tessere_Cards: TEDBTable;
    sc_Tessere_Cards: TDataSource;
    sc_Clients: TDataSource;
    tb_Clients: TEDBTable;
    tb_CardsCategories: TEDBTable;
    Shape6: TShape;
    Label6: TLabel;
    tb_ServicesSold: TEDBTable;
    sc_ServicesSold: TDataSource;
    tm_CheckLifeTime: TTimer;
    tb_Services: TEDBTable;
    tb_Cards: TEDBTable;
    qy_RREU_Bookings: TEDBQuery;
    Shape7: TShape;
    Label7: TLabel;
    tb_Sentinel_Services: TEDBTable;
    tb_Sentinel_SS: TEDBTable;
    tb_CleanLog: TEDBTable;
    Shape8: TShape;
    Label8: TLabel;
    tb_Personale_Personnel: TEDBTable;
    tb_Personale_PerHis: TEDBTable;
    PGC_QuerySC: TDataSource;
    tb_Cassa_SS: TEDBTable;
    tb_Cassa_ServicesID: TAutoIncField;
    tb_Cassa_ServicesServiceGroup: TWideStringField;
    tb_Cassa_ServicesServiceType: TWideStringField;
    tb_Cassa_ServicesServiceName: TWideStringField;
    tb_Cassa_ServicesFeeID: TSmallintField;
    tb_Cassa_ServicesCharge: TBooleanField;
    tb_Cassa_ServicesActuator: TSmallintField;
    tb_Cassa_ServicesEnabled: TBooleanField;
    tb_Cassa_ServicesDoor: TBooleanField;
    tb_Cassa_ServicesLights: TBooleanField;
    tb_Cassa_ServicesProjector: TBooleanField;
    tb_Cassa_ServicesAlarm: TBooleanField;
    tb_Cassa_ServicesLastEventDT: TDateTimeField;
    tb_Cassa_ServicesLastEventDescr: TWideStringField;
    tb_Cassa_ServicesUsedWithoutClean: TSmallintField;
    tb_Cassa_ServicesCardInID: TSmallintField;
    tb_Cassa_ServicesPrivacy: TBooleanField;
    tb_Cassa_ServicesLastAlias: TWideStringField;
    Shape9: TShape;
    Label9: TLabel;
    tb_Manut_Services: TEDBTable;
    tb_Manut_SMaintenance: TEDBTable;
    tb_Tessere_SS: TEDBTable;
    sc_Tessere_SS: TDataSource;
    Shape10: TShape;
    Label10: TLabel;
    tb_Anomalies: TEDBTable;
    sc_Anomalies: TDataSource;
    s_OpLedger: TDataSource;
    Shape11: TShape;
    tb_AdminServices_SS: TEDBTable;
    Label11: TLabel;
    tb_AdminServices_Clients: TEDBTable;
    qy_AdminServices_S: TEDBQuery;
    sc_AdminServices_S: TDataSource;
    Shape12: TShape;
    Label12: TLabel;
    tb_Cassa_ServicesCardReader: TSmallintField;
    sc_Services: TDataSource;
    tb_Pecunia: TEDBTable;
    sc_Pecuniam: TDataSource;
    ClRoster_Query: TEDBQuery;
    ClRosterQuerySC: TDataSource;
    qy_SS: TEDBQuery;
    OmniEventMonitor1: TOmniEventMonitor;
    qy_FR_OpLedger: TEDBQuery;
    qy_FR_Teseu2: TEDBQuery;
    sc_TaxQy: TDataSource;
    qy_FR_Teseu1: TEDBQuery;
    sc_FR_Teseu1: TDataSource;
    sc_FR_Teseu2: TDataSource;
    sc_FR_Teseu3: TDataSource;
    qy_FR_Teseu3: TEDBQuery;
    Shape13: TShape;
    Label13: TLabel;
    sc_ExpLedger: TDataSource;
    qy_FR_CostCenter: TEDBQuery;
    Shape14: TShape;
    Label14: TLabel;
    sc_FR_OpLedger: TDataSource;
    tb_CostCenterGroupNames: TEDBTable;
    Shape15: TShape;
    Label15: TLabel;
    Shape16: TShape;
    tb_ToDoList: TEDBTable;
    sc_ToDoList: TDataSource;
    Label16: TLabel;
    PGC2_Query: TEDBQuery;
    PGC2_QuerySC: TDataSource;
    tb_Permissions: TEDBTable;
    DB_Bar: TEDBDatabase;
    tb_TabNow: TEDBTable;
    sc_TabNow: TDataSource;
    Shape17: TShape;
    Label17: TLabel;
    qy_BarClosing: TEDBQuery;
    qy_BarTmp: TEDBQuery;
    scqy_TabsOpen: TDataSource;
    qy_TabsOpen: TEDBQuery;
    qy_OTabDet: TEDBQuery;
    scqy_OTabDet: TDataSource;
    qy_Tmp: TEDBQuery;
    qy_Bar_Closing: TEDBQuery;
    scqy_BarSoldByDetail: TDataSource;
    tb_ClubPermissions: TEDBTable;
    sc_ClubPermissions: TDataSource;
    qy_Permissions: TEDBQuery;
    qy_Presence: TEDBQuery;
    qy_dlg_Clients: TEDBQuery;
    scQy_FR_CostCenter: TDataSource;
    scQy_FR_OpLedger: TDataSource;
    qy_OpLedgerReport: TEDBQuery;
    qy_BarReport: TEDBQuery;
    tb_OTab: TEDBTable;
    tb_OTabDescription: TWideStringField;
    tb_OTabPayMethod: TWideStringField;
    tb_OTabData: TDateTimeField;
    tb_OTabFeeID: TIntegerField;
    tb_OTabSubFeeID: TSmallintField;
    tb_OTabCostCenter: TWideStringField;
    tb_OTabTxID: TWideStringField;
    tb_OTabRegistered: TBooleanField;
    qysc_PagaDopo: TDataSource;
    tb_OTabTmpTxID: TWideStringField;
    tb_OTabIsMasterFee: TBooleanField;
    tb_OTabDirectDebit: TBooleanField;
    tb_OTabDebitToGirl: TBooleanField;
    tb_OTabRelated: TIntegerField;
    tb_OTabReceiptID: TSmallintField;
    tb_OTabReceiptCopies: TSmallintField;
    tb_OTabDrinkCreditTimeLimit: TSmallintField;
    tb_OTabDrinkCreditValue: TFloatField;
    tb_OTabLifetimeSpan: TSmallintField;
    tb_OTabTimeSpan2Use: TSmallintField;
    tb_OTabDrinkcredits: TSmallintField;
    qy_Update: TEDBQuery;
    scqy_CalcPecunia: TDataSource;
    qy_CalcPecunia: TEDBQuery;
    qy_BarSoldBy: TEDBQuery;
    qy_Print: TEDBQuery;
    qy_ClientSS: TEDBQuery;
    tb_RRDeposits: TEDBTable;
    sc_RRDeposits: TDataSource;
    scqy_Tmp: TDataSource;
    qy_LstDays: TEDBQuery;
    scqy_LstDays: TDataSource;
    sc_CostCenterGroupNames: TDataSource;
    tb_CostCenterGroupNamesID: TAutoIncField;
    tb_CostCenterGroupNamesGroupName: TWideStringField;
    tb_CostCenterGroupNamesFullName: TWideStringField;
    qy_frxClOpLedger: TEDBQuery;
    qy_gPec: TEDBQuery;
    qy_Tmp2: TEDBQuery;
    scqy_Tmp2: TDataSource;
    qy_InHousePresence: TEDBQuery;
    scqy_InHousePresence: TDataSource;
    qy_BarOpLePayM: TEDBQuery;
    tb_Raffle: TEDBTable;
    sc_Raffle: TDataSource;
    tb_RaffleFees: TEDBTable;
    sc_Rafflefees: TDataSource;
    tb_OTabRentPayedUntil: TDateField;
    tb_AdMonitors: TEDBTable;
    sc_AdMonitors: TDataSource;
    tb_1000: TEDBTable;
    tb_2900: TEDBTable;
    tb_5000: TEDBTable;
    tb_OTabdAccount: TSmallintField;
    tb_OTabaAccount: TSmallintField;
    tb_OTabAmountCHF: TFloatField;
    tb_OTabAmountEuro: TFloatField;
    tb_OTabCH: TBooleanField;
    tb_OTabEU: TBooleanField;
    tb_OTabCC: TBooleanField;
    tb_OTabPD: TBooleanField;
    tb_OTabOF: TBooleanField;
    Shape18: TShape;
    Label18: TLabel;
    tb_1200: TEDBTable;
    tb_6000: TEDBTable;
    tb_OTabClientID: TSmallintField;
    tb_OTabCardID: TSmallintField;
    tb_OTabOperator: TWideStringField;
    qy_Only4SS: TEDBQuery;
    Shape19: TShape;
    Label19: TLabel;
    qy_RR_All__MayBeNot: TEDBQuery;
    qy_WriteOtabToAccounts: TEDBQuery;
    Shape20: TShape;
    sometext: TLabel;
    tb_EU_ReceiptText: TEDBTable;
    sc_EU_ReceiptText: TDataSource;
    tb_OTabBookingID: TIntegerField;
    qy_UpdateBookinsTXID: TEDBQuery;
    qysc_1000_CH: TDataSource;
    qysc_1000_EU: TDataSource;
    qysc_1000_CC: TDataSource;
    qy_1000_CH: TEDBQuery;
    qy_1000_EU: TEDBQuery;
    qy_1000_CC: TEDBQuery;
    qy_TmpClosing: TEDBQuery;
    qy_PagaDopo: TEDBQuery;
    qy_WritePdPayment: TEDBQuery;
    qy_Fees_Edit: TEDBQuery;
    tb_OTabPosPrintItems: TWideStringField;
    tb_PosPlaceHolders: TEDBTable;
    sc_PosPlaceholders: TDataSource;
    tb_OTabPrintQRCode: TSmallintField;
    tb_OTabAmountToPrint: TFloatField;
    tb_OTabReceipt: TBooleanField;
    scqy_ClientSS: TDataSource;
    tb_BonMalFees: TEDBTable;
    sc_BonMalFees: TDataSource;
    tb_OTabBonusMalusID: TIntegerField;
    tb_OTabPercentageOfFee: TFloatField;
    qy_ClientiClients: TEDBQuery;
    scqy_ClientiClients: TDataSource;
    tb_Manual: TEDBTable;
    sc_manual: TDataSource;
    qy_Manual: TEDBQuery;
    tb_EUCountryList: TEDBTable;
    sc_EUCountryList: TDataSource;
    qy_oTabFees: TEDBQuery;
    tb_oTabMemory: TEDBTable;
    tb_OTabBonusPoints: TSmallintField;
    tb_OTabDefaultPayMethod: TWideStringField;
    tb_OTabCutOffCount: TSmallintField;
    tb_RREU_RentalRooms: TEDBTable;
    sc_RREU_RentalRooms: TDataSource;
    scqy_RREU_Bookings: TDataSource;
    tb_FeeE: TEDBTable;
    sc_FeeE: TDataSource;
    tb_ClientiClients: TEDBTable;
    tb_PosText: TEDBTable;
    sc_PosText: TDataSource;
    tb_PosImages: TEDBTable;
    sc_PosImages: TDataSource;
    PGC_Query: TEDBQuery;
    tb_PosTextID: TAutoIncField;
    tb_PosTextCategory: TSmallintField;
    tb_PosTextEnabled: TBooleanField;
    tb_PosTextData: TDateField;
    tb_PosTextDescription: TWideStringField;
    tb_PosTextPosRichTextBlob: TBlobField;
    sc_1000: TDataSource;
    sc_Fees_Edit: TDataSource;
    tb_Fees_Edit: TEDBTable;
    tb_PosTextPosRichTextCBlob: TWideMemoField;
    tb_RREU_Rooms: TEDBTable;
    tb_RREU_Buildings: TEDBTable;
    sc_RREU_Buildings: TDataSource;
    sc_RREU_Rooms: TDataSource;
    qy_BookingD: TEDBQuery;
    qysc_BookingD: TDataSource;
    qy_1010_All: TEDBQuery;
    qysc_1010_All: TDataSource;
    qy_PecuniaComments: TEDBQuery;
    qy_1000_GCC: TEDBQuery;
    qysc_1000_GCC: TDataSource;
    tb_AllFees: TEDBTable;
    qy_FondoCassa: TEDBQuery;
    sc_AllFees: TDataSource;
    qy_TmpBar: TEDBQuery;
    q: TEDBQuery;
    qysc_Q: TDataSource;
    qy_CashToClients: TEDBQuery;
    qysc_CashtoClients: TDataSource;
    qy_1000_GCCkeyboard: TEDBQuery;
    qysc_1000_GCCkeyboard: TDataSource;
    qy_1010_GCC: TEDBQuery;
    qysc_1010_GCC: TDataSource;
    qy_BarOpLedger: TEDBQuery;
    scqy_BarOpLedger: TDataSource;
    EDBScript1: TEDBScript;
    scqy_Presence: TDataSource;
    tb_ClientHist: TEDBTable;
    sc_ClientHist: TDataSource;
    qy_SaliteStats: TEDBQuery;
    scqy_SaliteStats: TDataSource;
    tb_ServicesDetails: TEDBTable;
    tb_RafflePrice: TEDBTable;
    sc_RafflePrice: TDataSource;
    qry_RaffleCheck: TEDBQuery;
    tb_OTabPrintLotteryTicket: TBooleanField;
    qy_1000_GCCClientID: TIntegerField;
    qy_1000_GCCAlias: TWideStringField;
    qy_1000_GCCData: TDateTimeField;
    qy_1000_GCCDare: TFloatField;
    qy_1000_GCCAvere: TFloatField;
    qy_1000_GCCSubFeeID: TIntegerField;
    qy_1000_GCCBalance: TBCDField;
    qy_1000_GCCNote: TWideStringField;
    qy_1000_GCCRowType: TSmallintField;
    qy_1000_GCCTxID: TWideStringField;
    PROCEDURE PGC_SessionBeforeConnect(Sender: TObject);
    PROCEDURE tb_Fees_Edit_BeforePost(DataSet: TDataSet);
    FUNCTION GetMaxClientID: integer;
    FUNCTION TimeInRange(ATime: TTime; AStartTime, AEndTime: TTime;
      AInclusive: Boolean = True): Boolean;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE OmniEventMonitor1TaskTerminated(CONST task: IOmniTaskControl);
    PROCEDURE tb_ClientsAfterInsert(DataSet: TDataSet);
    PROCEDURE tm_CheckLifeTime_Timer(Sender: TObject);
    PROCEDURE PlayASound(soundFile: STRING; loop: Boolean);
    PROCEDURE HandleMguardClientData(CONST task: IOmniTask);
    PROCEDURE HandleMguardPersonnelData(CONST task: IOmniTask);
    PROCEDURE OmniEventMonitor1TaskUndeliveredMessage
      (CONST task: IOmniTaskControl; CONST msg: TOmniMessage);
    PROCEDURE tb_Personale_PerHisAfterInsert(DataSet: TDataSet);
    PROCEDURE tb_Manut_SMaintenanceAfterInsert(DataSet: TDataSet);
    PROCEDURE tb_Tessere_CardsAfterScroll(DataSet: TDataSet);
    PROCEDURE tb_Cassa_ServicesAfterScroll(DataSet: TDataSet);
    PROCEDURE tb_AdminServices_SSAfterScroll(DataSet: TDataSet);
    PROCEDURE PGC_SessionStatusMessage(Sender: TObject;
      CONST StatusMessage: STRING);
    // New Omnithread procedures

    PROCEDURE t_executePrint_(PName: STRING; TextAR: TStrings;
      dCredits, prCopies, header, textPos: integer; lotteryT, promoT: Boolean);
    PROCEDURE tb_ToDoListAfterInsert(DataSet: TDataSet);
    PROCEDURE t_checkBalance(queryStr, table: STRING);
    PROCEDURE tb_Personale_PersonnelBeforePost(DataSet: TDataSet);
    PROCEDURE tb_Personale_PersonnelBeforeEdit(DataSet: TDataSet);
    FUNCTION GetComputerNameFromWindows: STRING;
    PROCEDURE nActivateDatabase;
    PROCEDURE tb_RREU_BookingsBeforeInsert(DataSet: TDataSet);
    PROCEDURE t_executequery(queryStr, dbName, dBase, table: STRING);
    PROCEDURE qy_RR_21CalcFields(DataSet: TDataSet);
    PROCEDURE qy_RR_23CalcFields(DataSet: TDataSet);
    PROCEDURE tb_EU_ReceiptTextBeforePost(DataSet: TDataSet);
    PROCEDURE t_Print(printQrCode, copies: integer);
    PROCEDURE tb_textBeforePost(DataSet: TDataSet);
    PROCEDURE tb_textAfterScroll(DataSet: TDataSet);
    FUNCTION RemoveIntegerFromCSV(CONST CSV: STRING;
      CONST ValueToRemove: integer): STRING;
    FUNCTION AddIntegerToCSV(CONST CSV: STRING;
      CONST ValueToAdd: integer): STRING;
    PROCEDURE tb_BonMalFeesBeforePost(DataSet: TDataSet);
    PROCEDURE tb_BonMalFeesBeforeInsert(DataSet: TDataSet);
    FUNCTION CapitalizeWords(CONST Input: STRING): STRING;
    FUNCTION ValidateEmail(CONST emailAddress: STRING): Boolean;
    PROCEDURE AdminClientSAccountingFilter(startD, endD: TDateTime;
      Sender: TObject);
    procedure tb_FeeEAfterPost(DataSet: TDataSet);
    procedure tb_FeeEBeforeDelete(DataSet: TDataSet);
    procedure tb_FeeEAfterInsert(DataSet: TDataSet);
    procedure tb_ClientiClientsBeforeInsert(DataSet: TDataSet);
    procedure tb_ClientiClientsBeforePost(DataSet: TDataSet);
    procedure tb_ClientiClientsAfterInsert(DataSet: TDataSet);
    procedure tb_PosPlaceHoldersBeforePost(DataSet: TDataSet);
    procedure tb_Fees_EditBeforeDelete(DataSet: TDataSet);
    Function VerifyIfRecordsExist(id, sId: String): Boolean;
    procedure tb_Fees_EditBeforePost(DataSet: TDataSet);

    procedure tb_Fees_EditAfterPost(DataSet: TDataSet);
    procedure tb_Fees_EditAfterDelete(DataSet: TDataSet);
    procedure tb_RREU_RoomsAfterScroll(DataSet: TDataSet);
    procedure PGC_SessionRemoteTimeout(Sender: TObject;
      var StayConnected: Boolean);
    procedure tb_Fees_EditAfterInsert(DataSet: TDataSet);
    procedure tb_FeeEBeforePost(DataSet: TDataSet);
    procedure tb_FeeEBeforeEdit(DataSet: TDataSet);
    procedure MultiClickValidate(Sender: TField);
    Procedure MonthlyStats;
    // procedure FillGridFromQuery;
    // procedure BuildColumnTotalsFooter(FirstDataRow, FirstDataCol,
    // LastDataCol: integer; ExcludeLastDataRow: Boolean = False);
    procedure tb_ClientiClientsBeforeDelete(DataSet: TDataSet);
    procedure PostReverseEntry(data1010: TDateTime; closingID: String);

    procedure tb_ClientiClientsAfterScroll(DataSet: TDataSet);
    procedure tb_ClientHistBeforePost(DataSet: TDataSet);
    procedure tb_ClientHistAfterPost(DataSet: TDataSet);

  PRIVATE
    { Private declarations }
    FOrigMultiClick: Boolean;
    FOrigGroupID: integer;
    FUNCTION GetNewSession: TEDBSession;

  CONST
    ConnXDoorReaderID: shortString = '28';
    BarReaderID: shortString = '34';
    relaisOn = '20';
    relaisOff = '23';
    ledGreen = 'BX';
    ledRed = 'AX';
    ledBlue = '';
    ledBlink = 'DX';
    ledOff = 'CX';
  PUBLIC
    { Public declarations }
    regClientLoCrdNr, regClientHiCrdNr, newClLedgerID, newOpLedgerID,
      newRecID: integer;
    endTransfer: Boolean;
     Procedure Update_Qy_1010_GCC(workingDayPeriod: String;
      OUT Sum1010, Sum2900: Double); overload;
    Procedure Update_Qy_1010_GCC(workingDayPeriod: String;
      OUT Sum1010CHF, Sum1010EUR, Sum2900CHF, Sum2900EUR: Double); overload;
  END;

VAR
  Form2: TForm2;
  pgc_Ini: TiniFile;
  deletedFeeID, LastSessionValue: integer;
  SessionNameSection: TRTLCriticalSection;
  t_WriteData, t_Playsound, t_CheckLifeSpan, t_ReadData, t_PrintDoc,
    t_FillRoster: IOmniTaskControl;
  overrideSound: Boolean;
  fValue, localConfigPath: STRING;
  FSelectingFee: Boolean = False;
  SelectedFeeID: integer = -1;

IMPLEMENTATION

{$R *.dfm}


USES
  Main,
  SyncObjs,
  DSiWin32,
  OtlParallel,
  nLedger,
  KeyBoard, nRoutines, PGCManual, TaskDlgHelperF, GCC, uClientStore;

PROCEDURE TForm2.FormCreate(Sender: TObject);
VAR
  Reg: TRegistry;
  I: integer;
begin
  Reg := TRegistry.Create;
  TRY
    Reg.RootKey := HKEY_CURRENT_USER;
    // Open the key, return false if it doesn't exist
    IF Reg.OpenKey('\SOFTWARE\PGC_523\Settings', False) THEN
    BEGIN
      WITH Reg DO
      BEGIN
        IF Reg.ValueExists('LocalConfigPath') THEN
          localConfigPath := ReadString('LocalConfigPath');
      END;
      Reg.CloseKey;
    END;
  FINALLY
    Reg.Free;
  END;
  pgc_Ini := TiniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  TRY
    BEGIN
      localConfigPath := pgc_Ini.ReadString('Settings', 'LocalConfigPath', '');
    END;
  FINALLY
    pgc_Ini.Free;
  END;

  nActivateDatabase;
  LastSessionValue := 0;
  InitializeCriticalSection(SessionNameSection);

  SetLength(Form1.c_permissions_Arr, tb_Permissions.FieldCount - 2);
  endTransfer := True;

  {
    With qy_TMP do
    begin
    If Active Then
    Close;
    SQL.Clear;
    SQL.Add('SELECT t1.*, t2.* FROM openTab as t1, Clients AS t2 WHERE 1 = 0');
    Active := True;
    for I := 0 to FieldCount - 1 do
    begin
    FieldName := Fields[I].FieldName;
    FPlaceholders.Add(FieldName, Unassigned);
    end;
    FPlaceholders.Add('datea', Unassigned);
    FPlaceholders.Add('dateb', Unassigned);
    FPlaceholders.Add('datenow', Unassigned);
    FPlaceholders.Add('datetimenow', Unassigned);
    FPlaceholders.Add('company', Unassigned);
    FPlaceholders.Add('shorttxid', Unassigned);
    Active := False;
    end;
  }
  Form1.xx_CheckIfStillPresent;
end;

PROCEDURE TForm2.FormClose(Sender: TObject; VAR Action: TCloseAction);
VAR
  Reg: TRegistry;
BEGIN
  Reg := TRegistry.Create;
  TRY
    Reg.RootKey := HKEY_CURRENT_USER; // Set the Root Key
    // Open the key, and create it if it doesn't exist
    IF Reg.OpenKey('\SOFTWARE\PGC_523\Settings', True) THEN
      WITH Reg DO
      BEGIN
        WriteString('LocalConfigPath', localConfigPath);
      END;
  FINALLY
    Reg.Free;
  END;
  DeleteCriticalSection(SessionNameSection);
END;


// ---------------------------------------------------------------------------
// Main version: refreshes qy_1010_GCC and returns totals split CHF / EUR
// Paymethod values: 'CH' or 'EU'
// ---------------------------------------------------------------------------
Procedure TForm2.Update_Qy_1010_GCC(workingDayPeriod: String;
  OUT Sum1010CHF, Sum1010EUR, Sum2900CHF, Sum2900EUR: Double);
Var
  earliest_Date: TDateTime;
begin
  Sum1010CHF := 0;
  Sum1010EUR := 0;
  Sum2900CHF := 0;
  Sum2900EUR := 0;
  earliest_Date := 0;

  IF CCtoG.rg_CCtoG.ItemIndex = 0 Then
    With qy_Tmp do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT MIN(x.MinData) AS earliest_date');
      SQL.Add('FROM (');
      SQL.Add('  SELECT c1000.txid, MIN(c1000.Data) AS MinData');
      SQL.Add('  FROM c_1000 c1000');
      SQL.Add('  WHERE c1000.Dare > 0');
      SQL.Add('    AND c1000.Data >= :FromDate');
      SQL.Add('    AND NOT EXISTS (');
      SQL.Add('      SELECT 1');
      SQL.Add('      FROM c_1010 c1010');
      SQL.Add('      WHERE c1010.txid = c1000.txid');
      SQL.Add('    )');
      SQL.Add('    AND EXISTS (');
      SQL.Add('      SELECT 1');
      SQL.Add('      FROM c_2900 c2900');
      SQL.Add('      WHERE c2900.txid  = c1000.txid');
      SQL.Add('        AND c2900.Avere = c1000.Dare');
      SQL.Add('    )');
      SQL.Add('    AND NOT EXISTS (');
      SQL.Add('      SELECT 1');
      SQL.Add('      FROM c_2900 c2900d');
      SQL.Add('      WHERE c2900d.txid = c1000.txid');
      SQL.Add('        AND c2900d.Dare = c1000.Dare');
      SQL.Add('    )');
      SQL.Add('  GROUP BY c1000.txid');
      SQL.Add(') x');
      ParamByName('FromDate').AsDateTime := EncodeDate(2025, 8, 25);
      // Start date of new Euro app

      Open;
      If RecordCount > 0 Then
        // Earliest date with CC to G not yet in busta and not yet payed
        earliest_Date := FieldByName('earliest_Date').AsDateTime;
    end;

  With qy_1010_GCC do
  begin
    // DisableControls;
    Var
      ClientOrder: String;
    try
      Close;
      Unprepare;
      SQL.Clear;
      SQL.text := 'SELECT  tx.txid, ' +

        '  c1_first.data1 AS data1000, ' + '  c1_first.dare1 AS dare1000, ' +
        '  c1_first.Paymethod AS Paymethod, ' +
        '  c1_first.ClientID , ' + '  c1_first.CardID , ' +
        '  c1_first.SubFeeID , ' + '  c1_first.FeeID , ' +
        '    c1_first.Description, ' + '  c1_second.data2 AS c1_data2, ' +

        '  c2_first.data1 AS data1010, ' + '  c2_second.data2 AS c2_data2, ' +

        '  c3.data2 AS Lastdata2900, ' + '  c3.cpartita AS c3_cpartita, ' +
        '  COALESCE(c.LastName, '''') || '', '' || ' +
        '  SUBSTRING(COALESCE(c.FirstName, '''') FROM 1 FOR 3) AS ShortName, ' +
        '     c1_first.ClientID ' + 'FROM ( ' + '  SELECT DISTINCT txid ' +
        '  FROM ( ' + '    SELECT txid FROM c_1000 WHERE SubFeeID IN (990,999) '
        + '    UNION ' +
        '    SELECT txid FROM c_1010 WHERE SubFeeID IN (990,999) ' +
        '    UNION ' +
        '    SELECT txid FROM c_2900 WHERE SubFeeID IN (990,999) ' + '  ) t '
        + ') tx ' +

        'LEFT JOIN ( ' + '  SELECT c1.txid, ' + '         c1.Data AS data1, ' +
        '         c1.Dare AS dare1, ' +
        '         c1.Paymethod AS Paymethod, ' +
        '         c1.ClientID AS ClientID , ' +
        '         c1.CardID AS CardID , ' + '         c1.FeeID AS FeeID, ' +
        '         c1.SubFeeID AS SubFeeID, ' +
        '         c1.Description AS Description ' + '  FROM c_1000 c1 ' +
        '  INNER JOIN ( ' + '    SELECT txid, MIN(Data) AS min_data ' +
        '    FROM c_1000 ' + '    WHERE SubFeeID IN (990,999) ' +
        '    GROUP BY txid ' +
        '  ) c1_min ON c1.txid = c1_min.txid AND c1.Data = c1_min.min_data ' +
        '  WHERE c1.SubFeeID IN (990,999) ' +
        ') c1_first ON c1_first.txid = tx.txid ' +

        'LEFT JOIN ( ' + '  SELECT c1.txid, ' + '         c1.Data AS data2 ' +
        '  FROM c_1000 c1 ' + '  INNER JOIN ( ' +
        '    SELECT c1x.txid, MIN(c1x.Data) AS min_data ' +
        '    FROM c_1000 c1x ' + '    INNER JOIN ( ' +
        '      SELECT txid, MIN(Data) AS first_min ' + '      FROM c_1000 ' +
        '      WHERE SubFeeID IN (990,999) ' + '      GROUP BY txid ' +
        '    ) first ON c1x.txid = first.txid ' +
        '    WHERE c1x.SubFeeID IN (990,999) ' +
        '      AND c1x.Data > first.first_min ' + '    GROUP BY c1x.txid ' +
        '  ) c1_min ON c1.txid = c1_min.txid AND c1.Data = c1_min.min_data ' +
        '  WHERE c1.SubFeeID IN (990,999) ' +
        ') c1_second ON c1_second.txid = tx.txid ' +

        'LEFT JOIN ( ' + '  SELECT c2.txid, ' + '         c2.Data AS data1 ' +
        '  FROM c_1010 c2 ' + '  INNER JOIN ( ' +
        '    SELECT txid, MIN(Data) AS min_data ' + '    FROM c_1010 ' +
        '    WHERE SubFeeID IN (990,999) ' + '    GROUP BY txid ' +
        '  ) c2_min ON c2.txid = c2_min.txid AND c2.Data = c2_min.min_data ' +
        '  WHERE c2.SubFeeID IN (990,999) ' +
        ') c2_first ON c2_first.txid = tx.txid ' +

        'LEFT JOIN ( ' + '  SELECT c2.txid, ' + '         c2.Data AS data2 ' +
        '  FROM c_1010 c2 ' + '  INNER JOIN ( ' +
        '    SELECT c2x.txid, MIN(c2x.Data) AS min_data ' +
        '    FROM c_1010 c2x ' + '    INNER JOIN ( ' +
        '      SELECT txid, MIN(Data) AS first_min ' + '      FROM c_1010 ' +
        '      WHERE SubFeeID IN (990,999) ' + '      GROUP BY txid ' +
        '    ) first ON c2x.txid = first.txid ' +
        '    WHERE c2x.SubFeeID IN (990,999) ' +
        '      AND c2x.Data > first.first_min ' + '    GROUP BY c2x.txid ' +
        '  ) c2_min ON c2.txid = c2_min.txid AND c2.Data = c2_min.min_data ' +
        '  WHERE c2.SubFeeID IN (990,999) ' +
        ') c2_second ON c2_second.txid = tx.txid ' +

        'LEFT JOIN ( ' + '  SELECT c3.txid, ' + '         c3.Data AS data2, ' +
        '         c3.cPartita AS cpartita ' + '  FROM c_2900 c3 ' +
        '  INNER JOIN ( ' + '    SELECT c3x.txid, MIN(c3x.Data) AS min_data ' +
        '    FROM c_2900 c3x ' + '    INNER JOIN ( ' +
        '      SELECT txid, MIN(Data) AS first_min ' + '      FROM c_2900 ' +
        '      WHERE SubFeeID IN (990,999) ' + '      GROUP BY txid ' +
        '    ) first ON c3x.txid = first.txid ' +
        '    WHERE c3x.SubFeeID IN (990,999) ' +
        '      AND c3x.Data > first.first_min ' + '    GROUP BY c3x.txid ' +
        '  ) c3_min ON c3.txid = c3_min.txid AND c3.Data = c3_min.min_data ' +
        '  WHERE c3.SubFeeID IN (990,999) ' + ') c3 ON c3.txid = tx.txid ' +

        'LEFT JOIN Clients c ON c.ID = c1_first.ClientID ';

      IF CCtoG.rg_CCtoG.ItemIndex = 1 Then // workingdayperiod filter
        SQL.Add(' WHERE (c2_first.data1 ' + workingDayPeriod + ') OR ' +
          ' (c3.data2 ' + workingDayPeriod + ' ) ')
      else
        SQL.Add('WHERE c1_first.data1 >= CAST(' +
          QuotedStr(EDBEngine1.DateTimeToSQLStr(earliest_Date, True)) +
          ' AS TimeStamp)');

      If CCtoG.cb_ClientOrder.Checked then
        ClientOrder := ' ORDER BY ShortName '
      else
        ClientOrder := ' ORDER BY c1_first.data1 ';
      SQL.Add(ClientOrder);
      Prepare;
      Open;

      WITH qy_Tmp Do
      begin
        If Active Then
          Close;
        SQL.Clear;
        SQL.text := 'SELECT ' +
          ' COALESCE(SUM(CASE WHEN cPartita = 1010 AND Paymethod = ''CH'' ' +
          '   THEN Avere ELSE 0 END), 0) AS Sum1010CHF, ' +
          ' COALESCE(SUM(CASE WHEN cPartita = 1010 AND Paymethod = ''EU'' ' +
          '   THEN Avere ELSE 0 END), 0) AS Sum1010EUR, ' +
          ' COALESCE(SUM(CASE WHEN cPartita = 2900 AND Paymethod = ''CH'' ' +
          '   THEN Avere ELSE 0 END), 0) AS Sum2900CHF, ' +
          ' COALESCE(SUM(CASE WHEN cPartita = 2900 AND Paymethod = ''EU'' ' +
          '   THEN Avere ELSE 0 END), 0) AS Sum2900EUR ' +
          ' FROM c_1000 ';

        IF CCtoG.rg_CCtoG.ItemIndex = 1 Then // workingdayperiod filter
          SQL.Add(' WHERE Data ' + workingDayPeriod)
        else
          SQL.Add(' WHERE Data>= CAST(' +
            QuotedStr(EDBEngine1.DateTimeToSQLStr(earliest_Date, True)) +
            ' AS TimeStamp)');
        Open;
        If RecordCount > 0 Then
        begin
          Sum1010CHF := FieldByName('Sum1010CHF').AsFloat;
          Sum1010EUR := FieldByName('Sum1010EUR').AsFloat;
          Sum2900CHF := FieldByName('Sum2900CHF').AsFloat;
          Sum2900EUR := FieldByName('Sum2900EUR').AsFloat;
        end;
        Active := False;
      end;

    finally
      // EnableControls;
    end;
  end;
end;

// ---------------------------------------------------------------------------
// Old 2-sum version, kept for the existing callers in GCC.pas.
// Refreshes qy_1010_GCC the same way; the sums mix CHF + EUR.
// ---------------------------------------------------------------------------
Procedure TForm2.Update_Qy_1010_GCC(workingDayPeriod: String;
  OUT Sum1010, Sum2900: Double);
Var
  s1010CHF, s1010EUR, s2900CHF, s2900EUR: Double;
begin
  Update_Qy_1010_GCC(workingDayPeriod, s1010CHF, s1010EUR, s2900CHF, s2900EUR);
  Sum1010 := s1010CHF + s1010EUR;
  Sum2900 := s2900CHF + s2900EUR;
end;



procedure TForm2.PostReverseEntry(data1010: TDateTime; closingID: String);
var
  Sess: TEDBSession;
  DB: TEDBDatabase;
begin

  // Data1010 only used if chosenDate from small calendar

  If data1010 = 0 then
    data1010 := NOW;

  IF tb_OTab.State IN [dsEdit, dsInsert] Then
    tb_OTab.Post;
  // --- Transaction over BOTH inserts ---
  if not DB_Main.InTransaction then
    DB_Main.StartTransaction(['c_1000', 'c_1010']);

  With qy_Tmp2 do
  begin
    if Active then
      Close;
    SQL.Clear;
    try
      // 1) INSERT into c_1000 (mirror row)
      if Active then
        Close;
      SQL.Clear;
      SQL.text := 'INSERT INTO c_1000 (' +
        '  Data, ClientID, CardID, Description, Avere, FeeID, SubFeeID,' +
        '  Verified, Canceled, PayMethod, Operator, cPartita, txId, closingID) '
        + 'VALUES (' +
        '  CURRENT_TIMESTAMP, :ClientID, :CardID, :Description, :Avere, :FeeID, :SubFeeID,'
        + '  :Verified, :Canceled, :PayMethod, :Operator,1010, :TxId, :ClosingID)';

      ParamByName('ClientID').AsInteger := qy_1010_GCC.FieldByName('ClientID')
        .AsInteger;
      ParamByName('CardID').AsInteger := qy_1010_GCC.FieldByName('CardID')
        .AsInteger;
      ParamByName('Description').AsString :=
        qy_1010_GCC.FieldByName('Description').AsString + ' in busta';
      // NOTE: if you actually have AVERE value in another field, change here.
      ParamByName('Avere').AsCurrency := qy_1010_GCC.FieldByName('Dare1000')
        .AsCurrency;
      ParamByName('FeeID').AsInteger := qy_1010_GCC.FieldByName('FeeID')
        .AsInteger;
      ParamByName('SubFeeID').AsInteger := qy_1010_GCC.FieldByName('SubFeeID')
        .AsInteger;
      ParamByName('Verified').AsBoolean := False;
       ParamByName('Canceled').AsBoolean := False;
      ParamByName('PayMethod').AsString := 'EU';
      ParamByName('Operator').AsString := Trim(Form1.Cashier);
      ParamByName('TxId').AsString := qy_1010_GCC.FieldByName('TXID').AsString;

      if closingID = '' then
        Params.ParamByName('closingID').Clear // becomes NULL
      else
        ParamByName('closingID').AsString := closingID;
      ExecSQL;

      // 2) INSERT into c_1010
      SQL.text := 'INSERT INTO c_1010 (' +
        '  Data, ClientID, CardID, Description, Dare, FeeID, SubFeeID,' +
        '  Verified, Canceled, PayMethod, Operator, cPartita, txId, closingID) '
        + 'VALUES (' +
        '  CURRENT_TIMESTAMP, :ClientID, :CardID, :Description, :Dare, :FeeID, :SubFeeID,'
        + '  :Verified, :Canceled, :PayMethod, :Operator, 1000, :TxId, :closingID)';

      ParamByName('ClientID').AsInteger := qy_1010_GCC.FieldByName('ClientID')
        .AsInteger;
      ParamByName('CardID').AsInteger := qy_1010_GCC.FieldByName('CardID')
        .AsInteger;
      ParamByName('FeeID').AsInteger := qy_1010_GCC.FieldByName('FeeID')
        .AsInteger;
      ParamByName('Description').AsString :=
        qy_1010_GCC.FieldByName('Description').AsString + ' da cassa ';
      ParamByName('Dare').AsCurrency := qy_1010_GCC.FieldByName('Dare1000')
        .AsCurrency;

      ParamByName('SubFeeID').AsInteger := qy_1010_GCC.FieldByName('SubFeeID')
        .AsInteger;
      ParamByName('Verified').AsBoolean := False;
      ParamByName('Canceled').AsBoolean := False;
      ParamByName('PayMethod').AsString := 'EU';
      ParamByName('Operator').AsString := Trim(Form1.Cashier);
      ParamByName('TxId').AsString := qy_1010_GCC.FieldByName('TXID').AsString;

      if closingID = '' then
        Params.ParamByName('closingID').Clear // becomes NULL
      else
        ParamByName('closingID').AsString := closingID;
      ExecSQL;

      DB_Main.Commit;
    except
      on E: Exception do
      begin
        if DB_Main.InTransaction then
          DB_Main.Rollback;
        ShowMessage('ReverseEntry failed: ' + E.Message);
        // raise;  or ShowMessage('ReverseEntry failed: ' + E.Message);
      end;
    end;
  end;
end;

PROCEDURE TForm2.PGC_SessionStatusMessage(Sender: TObject;
  CONST StatusMessage: STRING);
BEGIN
  Form1.RzStatusPane2.Caption := StatusMessage;
END;

PROCEDURE TForm2.tb_AdminServices_SSAfterScroll(DataSet: TDataSet);
VAR
  clID: integer;
BEGIN
  IF NOT Form1.startUp THEN
    WITH Form1, tb_AdminServices_Clients DO
    BEGIN
      IF tb_AdminServices_SS.FieldByName('ClientID').AsVariant = NULL THEN
        clID := 0
      ELSE
        clID := tb_AdminServices_SS.FieldByName('ClientID').AsVariant;

      Filter := '(ID = ' + IntToStr(clID) + ')';
      Filtered := True;
    END;
END;

PROCEDURE TForm2.tb_Cassa_ServicesAfterScroll(DataSet: TDataSet);
VAR
  sId: integer;
BEGIN
  IF NOT Form1.startUp THEN
    WITH tb_AdminServices_SS DO
    BEGIN
      IF tb_Cassa_Services.FieldByName('ID').AsVariant = NULL THEN
        sId := 0
      ELSE
        sId := tb_Cassa_Services.FieldByName('ID').AsVariant;

      Filter := '(ServiceID = ' + QuotedStr(IntToStr(sId)) + ')';
      Filtered := True;
      IF Active THEN
        Last;
    END;
END;

procedure TForm2.tb_ClientHistAfterPost(DataSet: TDataSet);
begin
  tb_ClientHist.Refresh;
end;

procedure TForm2.tb_ClientHistBeforePost(DataSet: TDataSet);
var
  idNotifica: String;
  start1, end1, start2, end2: TDateTime;
  rec: integer;
begin
  With qy_Tmp do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.text :=
      'SELECT max(DateInTeseu) AS InTeseu, DaysNotified FROM ClientHistory ' +
      ' WHERE ClientID = ' + IntToStr(uClientStore.ThisClient.id) +
      'GROUP BY ClientID';
    Open;
    If RecordCount > 0 Then
    begin
      rec := RecordCount;
      start1 := FieldByName('InTeseu').AsDateTime;
      end1 := IncDay(FieldByName('InTeseu').AsDateTime,
        FieldByName('DaysNotified').AsInteger);
    end;
    Active := False;
  end;

  With tb_ClientHist do
  begin
    // Check if complete
    // ---------------------------------------------------------------------------
    if ((FieldByName('DateInTeseu').IsNull) OR
      (FieldByName('DateInTeseu').AsDateTime = 0)) Then
    begin
      ShowMessage
        ('Registrazione viene interrotta perché manca la data della notifica!');
      Abort;
    end;

    if DateOf(FieldByName('DateInTeseu').AsDateTime) = DateOf(start1) Then
    begin
      ShowMessage
        ('Registrazione viene interrotta perché esiste giá una notifica con la stessa data!');
      FieldValues[('DateInTeseu')] := NULL;
      Abort;
    end;

    If (FieldByName('DaysNotified').AsInteger = 0) then
    begin
      ShowMessage
        ('Registrazione Cancel; interrotta perché mancano i giorni notificati!');
      Abort;
    end;

    if ((FieldByName('IDNotifica').IsNull) OR
      (FieldByName('DateInTeseu').AsDateTime = 0)) Then
    begin
      ShowMessage
        ('Registrazione viene interrotta perché manca l''ID della notifica!');
      Abort;
    end;

    // Check if last working day before today's reg date
    start2 := DateOf(FieldByName('DateInTeseu').AsDateTime);
    end2 := IncDay(start2, FieldByName('DaysNotified').AsInteger);

    IF end2 < DateOf(NOW) Then
    begin
      ShowMessage
        ('Registrazione viene interrotta perché la data Fine Notifica risulterebbe antecedente ad oggi!');
      FieldValues[('DateInTeseu')] := NULL;
      FieldValues[('DaysNotified')] := 0;
      Abort;
    end;
    // Check if overlapping working days
    IF (start1 > 0) AND ((start1 <= end2) and (start2 <= end1)) Then
    begin
      ShowMessage
        ('Registrazione viene interrotta perché Le date nuove si sovvrapongono con la registrazione anteriore.!');
      FieldValues[('DateInTeseu')] := NULL;
      FieldValues[('DaysNotified')] := 0;
      Abort;
    end;
    // Everything ok, complete the record
    // ------------------------------------------------------------------------
    FieldByName('Date').AsDateTime := NOW;
    FieldByName('ClientID').AsInteger := tb_ClientiClients.FieldByName('ID')
      .AsInteger;
    FieldByName('DateOutTeseu').AsDateTime := end2;
    FieldByName('Author').AsString := Form1.Cashier;
    tb_ClientHist.FieldByName('ClientID').AsInteger :=
      tb_ClientiClients.FieldByName('ID').AsInteger;
    idNotifica := FieldByName('IDNotifica').AsString;

    TaskDlgHelperF.TaskDlg_Default('Notifiche', 'Registrazione Notifiche',
      'Registrazione notifica per ' +
      Trim(tb_ClientiClients.FieldByName('Alias').AsString) + ' effettuata.',
      'OK', '', '', 'calendar48.ico');

    // Update Clients table
    With qy_Tmp do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.text := 'UPDATE Clients SET IDTeseu = ' + QuotedStr(idNotifica) +
        ' WHERE ID = ' + IntToStr(uClientStore.ThisClient.id);
      ExecSQL;
    end;
  end;
end;

procedure TForm2.tb_ClientiClientsAfterInsert(DataSet: TDataSet);
begin
  WITH tb_ClientiClients DO
  BEGIN
    FieldByName('ID').AsInteger := GetMaxClientID;
    FieldByName('NotEmail').AsString := Form1.ed_NotEmail.text;
    FieldByName('NotPwd').AsString := Form1.ed_NotPwd.text;
  END;
end;

procedure TForm2.tb_ClientiClientsAfterScroll(DataSet: TDataSet);
Var
  n: integer;
  v: Variant;
begin
  {
    With Form1 do
    If Not startUp then
    begin
    ThisClient.id := tb_ClientiClients.FieldByName('ID').AsInteger;
    v := tb_Cards.Lookup('ClientID', ThisClient.id, 'ID');
    // IntToStr not needed if field is numeric
    if not VarIsNull(v) then
    n := v
    else
    n := -1;
    IF n > -1 then
    begin
    ed_ClCardID.Text := IntToStr(n);
    yy_CheckAllClientData('AdminPage', n);;
    end
    else
    ed_ClCardID.Text := '';
    end;
    tb_ClientHist.Filter := 'ClientID = ' + tb_ClientiClients.FieldByName
    ('ID').AsString;
  }
end;

procedure TForm2.tb_ClientiClientsBeforeDelete(DataSet: TDataSet);
begin
  If DataSet.FieldByName('ID').AsInteger = 0 Then
  begin
    ShowMessage('Cliente # 0 non puó essere eliminato!');
    Abort;
  end
  else
  begin
    With Form2.qy_Tmp do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT ClientID FROM c_1200 ');
      Active := True;
      If RecordCount > 0 Then
      begin
        CASE TaskDlgHelperF.TaskDlg_Default('Gestione clienti',
          'Eliminazione dati cliente', 'Stai per eliminare i dati di ' +
          uClientStore.ThisClient.alias + '. Confermi? ', 'SI', 'NO', '',
          'ExitRoom_48.ico') OF
          mrOk:
            begin
              //
            end;
          mrNo:
            Abort
        END;
      end;
    end;
  end;
end;

procedure TForm2.tb_ClientiClientsBeforeInsert(DataSet: TDataSet);
begin
  (*
    IF Form1.cb_Check_ClientDataInput.Checked THEN
    BEGIN
    WITH tb_ClientiClients DO
    BEGIN
    IF FieldByName('LastName').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il cognome!');
    // Abort;
    END;
    IF FieldByName('FirstName').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il nome!');
    // Abort;
    END;
    IF FieldByName('Alias').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il nome d''arte!');
    // Abort;
    END;
    IF FieldByName('BirthDate').IsNull THEN
    BEGIN
    ShowMessage('Manca la data di nascità!');
    // Abort;
    END;
    IF FieldByName('Citizienship').AsString = '' THEN
    BEGIN
    ShowMessage('Manca la nazionalità!');
    // Abort;
    END;
    IF FieldByName('Phone').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il no di telefono!');
    // Abort;
    END;
    IF FieldByName('Email').AsString = '' THEN
    BEGIN
    ShowMessage('Manca l''email!');
    // Abort;
    END;

    IF FieldByName('Address').AsString = '' THEN
    BEGIN
    ShowMessage('Manca l''indirizzo di residenza!');
    // Abort;
    END;
    IF FieldByName('Cap').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il CAP!');
    // Abort;
    END;
    IF FieldByName('City').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il luogo di residenza!');
    // Abort;
    END;
    IF FieldByName('Country').AsString = '' THEN
    BEGIN
    ShowMessage('Manca il paese di residenza!');
    // Abort;
    END;
    IF FieldByName('Permit').AsString = '' THEN
    BEGIN
    ShowMessage('Manca l''indicazione del permesso!');
    // Abort;
    END;
    IF FieldByName('Simic').AsString = '' THEN
    BEGIN
    ShowMessage('Manca l''ID SIMIC!');
    // Abort;
    END;
    END;
    END;
  *)
end;

procedure TForm2.tb_ClientiClientsBeforePost(DataSet: TDataSet);
begin
  WITH tb_ClientiClients DO
  BEGIN
    IF (NOT FieldByName('IBAN').IsNull) AND
      (FieldByName('IBAN').AsString <> '') THEN
    BEGIN
      IF Form1.CheckIBAN(FieldByName('IBAN').AsString) <> True THEN
      BEGIN
        ShowMessage('No IBAN Errato!');
        Abort;
      END;
    END;
    IF FieldByName('IBAN').AsString = '' THEN
      FieldValues['IBAN'] := NULL;
    FieldByName('FirstName').AsString :=
      CapitalizeWords(FieldByName('FirstName').AsString);
    FieldByName('LastName').AsString :=
      CapitalizeWords(FieldByName('LastName').AsString);
    FieldByName('Alias').AsString :=
      CapitalizeWords(FieldByName('Alias').AsString);
    {
      IF NOT ValidateEmail(FieldByName('EMail').AsString) THEN
      BEGIN
      ShowMessage('Indirizzo email invalido. Controlla e prova ancora.');
      FieldByName('EMail').AsString := '';
      END;
    }
  END;
end;

PROCEDURE TForm2.AdminClientSAccountingFilter(startD, endD: TDateTime;
  Sender: TObject);
BEGIN
  CASE Form1.tp_AdminClientsAccounting.ActivePageIndex OF
    0:
      IF tb_ClientiClients.FieldByName('ID').AsString <> '' THEN
        WITH qy_ClientSS DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('SELECT ss.ClientID,ss.CardID, ss.SoldDt, ss.StartUse, ss.EndUse,'
            + 'ss.ServiceID,ss.Valid,ss.CheckedOut,ss.SubfeeID, Fees.Description Descr '
            + 'FROM ServicesSold ss ' +
            'LEFT JOIN Fees ON ss.SubfeeID = fees.subID ' + ' WHERE ClientID = '
            + tb_ClientiClients.FieldByName('ID').AsString +
            ' AND SoldDT BETWEEN CAST(' +
            QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', startD)) +
            ' AS Timestamp) ' + ' AND CAST(' +
            QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', endD)) +
            ' as Timestamp)');
          Active := True;
          Refresh;
          Last;
          Form1.dbgd_AdminClientsSS.Refresh;
        END;
    1:
      IF tb_ClientiClients.FieldByName('ID').AsString <> '' THEN
        WITH qy_BarSoldBy DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('SELECT *, Bar_Products.ProductName ' +
            'FROM Bar_SoldByDetail ' +
            'LEFT JOIN Bar_Products ON Bar_Products.ProductID = Bar_SoldByDetail.ProductID '
            + ' WHERE SoldBy = ' + Form2.tb_ClientiClients.FieldByName('ID')
            .AsString + ' AND Data BETWEEN CAST(' +
            QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', IncDay(Today, -30)))
            + ' AS Timestamp) ' + ' AND CAST(' +
            QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', Today)) +
            ' as Timestamp)');
          Active := True;
          Refresh;
          Last;
          Form1.dbgd_AdminClientsSoldBy.Refresh;
        END;
  END;
END;

FUNCTION TForm2.CapitalizeWords(CONST Input: STRING): STRING;
VAR
  Words: TArray<STRING>;
  I: integer;
BEGIN
  Words := Input.ToLower.Split([' '], TStringSplitOptions.ExcludeEmpty);
  FOR I := 0 TO HIGH(Words) DO
    Words[I] := UpperCase(Words[I][1]) + Copy(Words[I], 2, MaxInt);
  Result := STRING.Join(' ', Words);
END;

FUNCTION TForm2.ValidateEmail(CONST emailAddress: STRING): Boolean;
VAR
  RegEx: TRegEx;
BEGIN
  RegEx := TRegEx.Create
    ('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');
  Result := RegEx.Match(emailAddress).Success;
END;

PROCEDURE TForm2.tb_ClientsAfterInsert(DataSet: TDataSet);
BEGIN
  tb_Clients.FieldByName('ID').AsInteger := GetMaxClientID;
END;

PROCEDURE TForm2.tb_EU_ReceiptTextBeforePost(DataSet: TDataSet);
BEGIN
  tb_EU_ReceiptText.FieldValues['ID'] := tb_FeeE.FieldByName('SubID').AsInteger;
END;

procedure TForm2.tb_FeeEAfterInsert(DataSet: TDataSet);
begin
  tb_FeeE.FieldByName('RecLastMod').AsDateTime := NOW;
  Form1.dbVgd_FeesEdit.Rows[0].TextEditing := True;
  Form1.dbVgd_FeesEdit.Rows[1].TextEditing := True;
end;

procedure TForm2.tb_FeeEAfterPost(DataSet: TDataSet);
begin
  tb_Fees.Refresh;
  tb_Fees_Edit.Refresh;
  tb_RaffleFees.Refresh;
end;

procedure TForm2.tb_FeeEBeforeDelete(DataSet: TDataSet);
begin
  tb_Fees.Refresh;
end;

procedure TForm2.tb_FeeEBeforeEdit(DataSet: TDataSet);
begin
  // stash the very first value as soon as the user begins editing
  FOrigMultiClick := DataSet.FieldByName('MultiClick').AsBoolean;
  FOrigGroupID := DataSet.FieldByName('GroupID').AsInteger;
end;

procedure TForm2.MultiClickValidate(Sender: TField);
begin
  // “Sender” is the MultiClick field itself
  if Sender.AsBoolean and (Sender.DataSet.FieldByName('GroupID').AsInteger > 0)
  then
    raise EDatabaseError.Create
      ('Non possono essere attivate contemporaneamente sia MultiClick sia GroupID > 0');
end;

procedure TForm2.tb_FeeEBeforePost(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if (FieldByName('MultiClick').AsBoolean) and
      (FieldByName('GroupID').AsInteger > 0) then
    begin

      TaskDlgHelperF.TaskDlg_Default('Errore Database edit',
        'Conflitto MultiClick-GroupID',
        'Non possono essere attivate contemporaneamente sia MultiClick sia GroupID > 0',
        'OK', '', '', 'stop_48.ico');
      // restore the bad‐guy fields…
      FieldByName('MultiClick').AsBoolean := FOrigMultiClick;
      DataSet.FieldByName('GroupID').AsInteger := FOrigGroupID;
      // then cancel the post so nothing else gets committed
      // Abort;
    end;
    if (FieldByName('ReceiptCopies').AsInteger > 0) and
      (FieldByName('PosPrintItems').IsNull) then
    begin
      TaskDlgHelperF.TaskDlg_Default('Errore Database edit',
        'Testo Ricevuta mancante',
        'Prima di impostare il numero di ricevute devi impostare il testo/immagini della ricevuta stessa.',
        'OK', '', '', 'stop_48.ico');
      // restore the bad‐guy fields…
      FieldByName('ReceiptCopies').AsInteger := 0;
    end;
  end;
end;

PROCEDURE TForm2.tb_BonMalFeesBeforeInsert(DataSet: TDataSet);
BEGIN
  Form1.ExpandVCategories(True);
END;

PROCEDURE TForm2.tb_BonMalFeesBeforePost(DataSet: TDataSet);
BEGIN
  tb_BonMalFees.FieldByName('IsBonusMalusFee').AsBoolean := True;
END;

FUNCTION TForm2.RemoveIntegerFromCSV(CONST CSV: STRING;
  CONST ValueToRemove: integer): STRING;
VAR
  CSVList: TStringList;
  Index: integer;
  s: STRING;
BEGIN
  s := IntToStr(ValueToRemove);
  // Create a TStringList to handle the comma-delimited string
  CSVList := TStringList.Create;
  TRY
    CSVList.Delimiter := ','; // Set the delimiter to a comma
    CSVList.StrictDelimiter := True;
    // Avoid treating spaces as part of the delimiter
    CSVList.DelimitedText := CSV; // Parse the CSV string into the TStringList

    // Find and delete the integer from the list
    INDEX := CSVList.IndexOf(IntToStr(ValueToRemove));
    IF INDEX <> -1 THEN
      CSVList.Delete(INDEX); // Remove the value if found

    // Convert the modified TStringList back to a CSV string
    Result := CSVList.DelimitedText;
  FINALLY
    CSVList.Free; // Free the TStringList
  END;
END;

FUNCTION TForm2.AddIntegerToCSV(CONST CSV: STRING;
  CONST ValueToAdd: integer): STRING;
VAR
  CSVList: TStringList;
BEGIN
  // Create a TStringList to handle the comma-delimited string
  CSVList := TStringList.Create;
  TRY
    CSVList.Delimiter := ','; // Set the delimiter to a comma
    CSVList.StrictDelimiter := True;
    // Avoid treating spaces as part of the delimiter
    CSVList.DelimitedText := CSV; // Parse the CSV string into the TStringList

    // Check if the value already exists; add it if it doesn't
    IF CSVList.IndexOf(IntToStr(ValueToAdd)) = -1 THEN
      CSVList.Add(IntToStr(ValueToAdd));

    // Convert the modified TStringList back to a CSV string
    Result := CSVList.DelimitedText;
  FINALLY
    CSVList.Free; // Free the TStringList
  END;
END;

procedure TForm2.tb_Fees_EditAfterDelete(DataSet: TDataSet);
begin
  tb_Fees.Refresh;
  tb_FeeE.Refresh;
end;

procedure TForm2.tb_Fees_EditAfterInsert(DataSet: TDataSet);
begin
  Form1.dbgd_Fees_Edit.Options := Form1.dbgd_Fees_Edit.Options -
    [DBGridEh.dgRowSelect] + [DBGridEh.dgEditing];
end;

procedure TForm2.tb_Fees_EditAfterPost(DataSet: TDataSet);
begin
  tb_Fees.Refresh;
  tb_FeeE.Refresh;
end;

procedure TForm2.tb_Fees_EditBeforeDelete(DataSet: TDataSet);
begin
  IF VerifyIfRecordsExist(tb_Fees_Edit.FieldByName('ID').AsString,
    tb_Fees_Edit.FieldByName('SubID').AsString) Then
  begin
    TaskDlgHelperF.TaskDlg_Default('Çontabilitá', 'LIMITAZIONE CONTABILITÀ',
      'Questo prezzo ha registrazioni contabili e quindi non può essere eliminato!',
      'OK', '', '', 'stop_48.ico');
    Abort;
  end
  else
  begin
    IF TaskDlgHelperF.TaskDlg_Default('Gestione prezzi', 'Eliminazione prezzo',
      'Confermi l''eliminazione del prezzo ' + tb_Fees_Edit.FieldByName
      ('Description').AsString, 'OK', 'NO', '', 'stop_48.ico') <> mrOk then
      Abort;
  end;
end;

procedure TForm2.tb_Fees_EditBeforePost(DataSet: TDataSet);
var
  I: integer;
  fld: TField;
  fieldName: string;
  blockedFields: TArray<string>;
  sId, sSubID: String;
begin
  if VarToStr(tb_Fees_Edit.FieldByName('ID').OldValue) = '' then
    sId := VarToStr(tb_Fees_Edit.FieldByName('ID').NewValue)
  else
    sId := VarToStr(tb_Fees_Edit.FieldByName('ID').OldValue);

  If VarToStr(tb_Fees_Edit.FieldByName('SubID').OldValue) = '' Then
    sSubID := VarToStr(tb_Fees_Edit.FieldByName('SubID').NewValue)
  else
    sSubID := VarToStr(tb_Fees_Edit.FieldByName('SubID').OldValue);

  if VerifyIfRecordsExist(sId, sSubID) then
  begin
    blockedFields := ['ID', 'SubID', 'Category', 'Description'];

    for I := 0 to DataSet.FieldCount - 1 do
    begin
      fld := DataSet.Fields[I];
      fieldName := fld.fieldName;

      if MatchText(fieldName, blockedFields) then
      begin
        // Safe null comparison
        if VarIsNull(fld.OldValue) and fld.IsNull then
          Continue;

        // Only trigger cancel on real changes
        case fld.DataType of
          ftString, ftWideString:
            if fld.OldValue <> fld.AsString then
            begin
              ShowMessage(Format('Questo prezzo ha registrazioni contabili.' +
                sLineBreak +
                'Il campo "%s" non può essere cambiato. Modifiche saranno annullate.',
                [fieldName]));
              DataSet.Cancel;
              Exit;
            end;

          ftBoolean:
            if fld.OldValue <> fld.AsBoolean then
            begin
              ShowMessage(Format('Questo prezzo ha registrazioni contabili.' +
                sLineBreak +
                'Il campo "%s" non può essere cambiato. Modifiche saranno annullate.',
                [fieldName]));
              DataSet.Cancel;
              Exit;
            end;

          ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            if Abs(fld.OldValue - fld.AsFloat) > 0.00001 then
            begin
              ShowMessage(Format('Questo prezzo ha registrazioni contabili.' +
                sLineBreak +
                'Il campo "%s" non può essere cambiato. Modifiche saranno annullate.',
                [fieldName]));
              DataSet.Cancel;
              Exit;
            end;

          ftInteger, ftSmallint, ftWord:
            if fld.OldValue <> fld.AsInteger then
            begin
              ShowMessage(Format('Questo prezzo ha registrazioni contabili.' +
                sLineBreak +
                'Il campo "%s" non può essere cambiato. Modifiche saranno annullate.',
                [fieldName]));
              DataSet.Cancel;
              Exit;
            end;

        else
          if fld.OldValue <> fld.NewValue then
          begin
            ShowMessage(Format('Questo prezzo ha registrazioni contabili.' +
              sLineBreak +
              'Il campo "%s" non può essere cambiato. Modifiche saranno annullate.',
              [fieldName]));
            DataSet.Cancel;
            Exit;
          end;
        end;
      end;
    end;
  end
  else
  begin
    // Ask confirmation to save if editing is allowed
    if MessageDlg('Do you want to save these changes?', mtConfirmation,
      [mbYes, mbNO], 0) <> mrYes then
    begin
      DataSet.Cancel;
      Exit;
    end;
  end;
end;

Function TForm2.VerifyIfRecordsExist(id, sId: String): Boolean;
begin
  With qy_Tmp do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT ''Table1'' AS TableName FROM c_1000 WHERE FeeID = ' + id +
      ' and SubFeeID = ' + sId + ' UNION ' +
      'SELECT ''Table2'' FROM c_1200 WHERE FeeID = ' + id + ' and SubFeeID = ' +
      sId + ' UNION ' + 'SELECT ''Table3'' FROM c_2900 WHERE FeeID = ' + id +
      ' and SubFeeID = ' + sId + ' UNION ' +
      'SELECT ''Table4'' FROM c_5000 WHERE FeeID = ' + id + ' and SubFeeID = ' +
      sId + ' UNION ' + 'SELECT ''Table5'' FROM c_6000 WHERE FeeID = ' + id +
      ' and SubFeeID = ' + sId);
    Active := True;
    Result := (not SQL.IsEmpty) AND (FieldByName('TableName').AsString <> '');
    Active := False;
  end;
end;

PROCEDURE TForm2.tb_Fees_Edit_BeforePost(DataSet: TDataSet);
BEGIN
  IF Form1.ClubAccPermissions.FeesEdit = False THEN
    Abort;
  DataSet.FieldByName('RecLastMod').AsDateTime := NOW;
END;

PROCEDURE TForm2.tb_Manut_SMaintenanceAfterInsert(DataSet: TDataSet);
BEGIN
  DataSet.FieldByName('SID').AsInteger := tb_Manut_Services.FieldByName('ID')
    .AsInteger;
  DataSet.FieldByName('Author').AsString := Form1.Cashier;
END;

PROCEDURE TForm2.tb_Personale_PerHisAfterInsert(DataSet: TDataSet);
BEGIN
  DataSet.FieldByName('AVS').AsString := tb_Personale_Personnel.FieldByName
    ('AVS').AsString;
END;

PROCEDURE TForm2.tb_Personale_PersonnelBeforeEdit(DataSet: TDataSet);
BEGIN
  fValue := tb_Personale_Personnel.FieldByName('PassWord').AsString;
END;

PROCEDURE TForm2.tb_Personale_PersonnelBeforePost(DataSet: TDataSet);
VAR
  s: STRING;
BEGIN
  IF tb_Personale_Personnel.FieldByName('PassWord').AsString <> fValue THEN
  BEGIN
    s := tb_Personale_Personnel.FieldByName('PassWord').AsString;
    s := Form1.EnCrypt(s);
    tb_Personale_Personnel.FieldByName('PassWord').AsString := s;
  END;
END;

// Only characters. Curly brackets will be added automatically dragdropping.
procedure TForm2.tb_PosPlaceHoldersBeforePost(DataSet: TDataSet);
begin
  if not DataSet.FieldByName('Placeholder').IsNull then
  begin
    Var
      s: String;
    s := DataSet.FieldByName('Placeholder').AsString;
    DataSet.FieldByName('Placeholder').AsString :=
      TRegEx.Replace(s, '[^A-Za-z]+', '');
  end;
end;

PROCEDURE TForm2.tb_RREU_BookingsBeforeInsert(DataSet: TDataSet);
BEGIN
  IF MessageDlg('Confermi l''inserimento di una nuova stanza?', mtConfirmation,
    [mbOK, mbNO], 0, mbNO) <> mrOk THEN
    Abort
END;

procedure TForm2.tb_RREU_RoomsAfterScroll(DataSet: TDataSet);
begin
  IF NOT tb_RREU_Rooms.FieldByName('BookingID').IsNull Then
    With qy_BookingD do
    begin
      IF Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT b.* , cl.Alias FROM RREU_Bookings b ' +
        'LEFT JOIN Clients cl ON cl.ID = b.GuestID ' + 'WHERE b.BookingID = ' +
        tb_RREU_Rooms.FieldByName('BookingID').AsString);
      Active := True;
      Refresh;
      Form1.dbVgd_Booking.Refresh;
    end;
end;

PROCEDURE TForm2.tb_Tessere_CardsAfterScroll(DataSet: TDataSet);
VAR
  cID: integer;
BEGIN
  IF NOT Form1.startUp THEN
    WITH Form1, tb_Tessere_SS DO
    BEGIN
      IF tb_Tessere_Cards.FieldByName('ClientID').AsVariant = NULL THEN
        cID := 0
      ELSE
        cID := tb_Tessere_Cards.FieldByName('ClientID').AsVariant;

      Filter := '(ClientID = ' + IntToStr(cID) + ') AND (CardID = ' +
        tb_Tessere_Cards.FieldByName('ID').AsString + ')';
      Filtered := True;
      IF Active THEN
        Last;
    END;
END;

PROCEDURE TForm2.tb_textAfterScroll(DataSet: TDataSet);
BEGIN

  IF DataSet.FieldByName('Category').AsInteger = 99 THEN
    Form1.dbgd_Pos_T.SelectedColor := clMedGray;
END;

PROCEDURE TForm2.tb_textBeforePost(DataSet: TDataSet);
VAR
  RichText: STRING;
BEGIN
  // Assume 'RichTextField' contains the RTF data
  RichText := DataSet.FieldByName('PosRichText').AsString;
  // Strip RTF formatting
  DataSet.FieldByName('PosText').AsString := Form1.StripRTFFormatting(RichText);
END;

PROCEDURE TForm2.tb_ToDoListAfterInsert(DataSet: TDataSet);
BEGIN
  Form2.tb_ToDoList.FieldByName('Data').AsDateTime := NOW;
END;

PROCEDURE TForm2.tm_CheckLifeTime_Timer(Sender: TObject);
VAR
  queryStr: STRING;
BEGIN
  IF TimeInRange(Time, Form1.todays_O_time, Form1.todays_C_time, False) THEN
  BEGIN
    queryStr := 'UPDATE ServicesSold SET VALID = FALSE ' +
      ' WHERE (Current_TimeStamp - SoldDT)Hour > LIFETIMESPAN';
    t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'ServicesSold');
    sleep(50);
    queryStr := 'UPDATE Services SET Enabled = FALSE, LastEventDescr = ' +
      QuotedStr('Da pulire!') + ' WHERE (CardInID = 0) AND (UsedWithoutClean > '
      + IntToStr(Form1.ed_MarkRedAfterUse.Value) + ')';
    t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    tb_Cassa_Services.Refresh;
    tb_Cassa_SS.Refresh;
  END;
END;

// Own TimeInRange function because Delphi function does not work with endtime after midnight
FUNCTION TForm2.TimeInRange(ATime: TTime; AStartTime, AEndTime: TTime;
  AInclusive: Boolean = True): Boolean;
BEGIN
  ATime := TimeOf(ATime);
  AStartTime := TimeOf(AStartTime);
  AEndTime := TimeOf(AEndTime);

  IF ATime < AStartTime THEN
    ATime := IncDay(ATime);
  IF AEndTime < AStartTime THEN
    AEndTime := IncDay(AEndTime);

  IF AInclusive THEN
    Result := (AStartTime <= ATime) AND (ATime <= AEndTime)
  ELSE
    Result := (AStartTime < ATime) AND (ATime < AEndTime);
END;

PROCEDURE TForm2.PGC_SessionBeforeConnect(Sender: TObject);
BEGIN
  WITH Form1, PGC_Session DO
  BEGIN
    IF ed_RemoteHostName.text = '' THEN
    BEGIN
      RemoteHost := GetComputerNameFromWindows;
      // Better remote host name than remote ip address (ip could change)
      PGC_Session.RemotePort := ed_RemotePort.Value;

    END
    ELSE
      RemoteAddress := ed_RemoteAddress.text;
    PGC_Session.localConfigPath := localConfigPath;
    LoginUser := 'Administrator';
    LoginPassword := 'EDBDefault';
  END;
END;

procedure TForm2.PGC_SessionRemoteTimeout(Sender: TObject;
  var StayConnected: Boolean);
begin
  // Prevent the session from ever disconnecting:
  StayConnected := True;
end;

PROCEDURE TForm2.nActivateDatabase;
BEGIN
  TRY
    BEGIN
      PGC_Session.Connected := False;
      EDBEngine1.Active := True;
      PGC_Session.RemoteHost := GetComputerNameFromWindows;

      IF PGC_Session.RemoteHost = '' THEN
        ShowMessage('Failed to retrieve the computer name. Error code: ' +
          IntToStr(GetLastError));

      PGC_Session.Connected := True;
      DB_Main.Connected := True;
      // EDB_Bar.Connected := True;
      tb_Cards.Active := True;
      tb_Services.Active := True;
      tb_Clients.Active := True;

      tb_CleanLog.Active := True;
      tb_Permissions.Active := True;
      tb_Personale_Personnel.Active := True;

      tb_FeeE.Active := True;
      tb_Sentinel_Services.Active := True;
      tb_Sentinel_SS.Active := True;
      tb_AdminServices_SS.Active := True;
      tb_TabNow.Active := True;
      tb_AdminServices_Clients.Active := True;
      tb_Cassa_Services.Active := True;
      tb_Fees.Active := True;
      tb_OTab.Active := True;
      tb_oTabMemory.Active := True;
      tb_Cassa_SS.Active := True;

      tb_Tessere_Cards.Active := True;
      tb_Tessere_SS.Active := True;
      tb_CardsCategories.Active := True;

      tb_ClientiClients.Active := True;

      tb_Manut_Services.Active := True;
      tb_Manut_SMaintenance.Active := True;
      tb_Personale_Personnel.Active := True;
      tb_Personale_PerHis.Active := True;
      tb_ClubPermissions.Active := True;
      tb_Anomalies.Active := True;
      tb_CostCenterGroupNames.Active := True;
      tb_ToDoList.Active := True;
      tb_Raffle.Active := True;
      tb_RaffleFees.Active := True;
      tb_AdMonitors.Active := True;
      tb_1000.Active := True;
      tb_1200.Active := True;
      tb_2900.Active := True;
      tb_5000.Active := True;

      tb_PosText.Active := True;
      tb_PosPlaceHolders.Active := True;
      tb_PosImages.Active := True;
      tb_BonMalFees.Active := True;
      tb_Manual.Active := True;
      tb_EUCountryList.Active := True;
      tb_Fees_Edit.Active := True;
      tb_RREU_Buildings.Active := True;
      tb_RREU_Rooms.Active := True;
      tb_AllFees.Active := True;
      tb_ClientHist.Active := True;
      // tb_ServicesDetails.Active := True;
      tb_RafflePrice.Active := True;

      qy_InHousePresence.Active := True;
      qy_AdminServices_S.Active := True;
      qy_TabsOpen.Active := True;
      qy_BarSoldBy.Active := True;

      qy_dlg_Clients.Active := True;
      // qy_FR_Teseu1.Active := True;
      qy_BarReport.Active := True;
      qy_BarOpLedger.Active := True;
      qy_PagaDopo.Active := True;
      tb_ServicesSold.Active := True;
      qy_CalcPecunia.Active := True;
      qy_PecuniaComments.Active := True;

    END;
  FINALLY
  END;
END;

FUNCTION TForm2.GetComputerNameFromWindows: STRING;
VAR
  iLen: Cardinal;
BEGIN
  iLen := MAX_COMPUTERNAME_LENGTH + 1; // From Windows.pas
  Result := StringOfChar(#0, iLen);
  GetComputerName(PChar(Result), iLen);
  SetLength(Result, iLen);
END;

FUNCTION TForm2.GetMaxClientID: integer;
VAR
  n1, n2: integer;
BEGIN
  WITH qy_Tmp DO
  BEGIN
    IF Active THEN
      Close;
    DataSource := sc_Clients;
    SQL.Clear;
    SQL.Add('Select max(ID) as maxClientId from Clients');
    Active := True;
    IF FieldValues['maxClientID'] >= 1 THEN
      Result := FieldValues['maxClientID']
    ELSE
      Result := 0;
    Active := False;
    Unprepare;
    n1 := Result;

    IF Active THEN
      Close;
    DataSource := sc_ServicesSold;
    SQL.Clear;
    SQL.Add('Select max(ClientID) as maxClientId from ServicesSold');
    Active := True;
    IF FieldValues['maxClientID'] >= 1 THEN
      Result := max(FieldValues['maxClientID'], Result)
    ELSE
      Result := 0;
    Active := False;
    Unprepare;
    n2 := Result;
    Result := max(n1, n2) + 1;
  END;
END;

PROCEDURE TForm2.t_checkBalance(queryStr, table: STRING);
VAR
  LocalSession: TEDBSession;
  LocalDatabase: TEDBDatabase;
  LocalQuery: TEDBQuery;
  LocalTable: TEDBTable;
  sl: TStringList;
BEGIN
  Async(
    PROCEDURE
    BEGIN
      LocalSession := GetNewSession;
      TRY
        LocalDatabase := TEDBDatabase.Create(NIL);
        TRY
          WITH LocalDatabase DO
          BEGIN
            SessionName := LocalSession.SessionName;
            Database := 'PGC_DB_Main_Euro';
            DatabaseName := 'DB_Main';
            LocalSession.LoginUser := 'Administrator';
            LocalSession.LoginPassword := 'EDBDefault';
            Connected := True;
          END;
          LocalTable := TEDBTable.Create(NIL);
          LocalQuery := TEDBQuery.Create(NIL);
          TRY
            WITH LocalTable DO
            BEGIN
              tableName := table;
              SessionName := LocalSession.SessionName;
              DatabaseName := 'DB_Main';
              Active := True;
            END;
            WITH LocalQuery DO
            BEGIN
              SessionName := LocalSession.SessionName;
              DatabaseName := LocalDatabase.DatabaseName;
              SQL.Clear;
              SQL.Add(queryStr);
              Prepare;
              TRY
                LocalDatabase.StartTransaction([table], -1);
                TRY
                  ExecSQL;
                  LocalDatabase.Commit;
                  sl := TStringList.Create;
                  IF RecordCount > 0 THEN
                  BEGIN
                    sl.Add('Clienti con importi non pagati');
                    sl.Add('--------------------------------');
                  END;
                  First;
                  WHILE NOT EoF DO
                  BEGIN
                    IF FieldValues['rrBalance'] <> 0 THEN
                      sl.Add(FieldByName('Alias').AsString + ': ' +
                        FormatFloat('#,##0.00', FieldValues['rrBalance']));
                    Next;
                  END;
                EXCEPT
                  LocalDatabase.Rollback;
                  RAISE;
                END;
              FINALLY
                Close;
                Unprepare;
              END;
            END;
          FINALLY
            LocalQuery.Free;
            LocalTable.Close;
            LocalTable.Free;
          END;
        FINALLY
          LocalDatabase.Free;
        END;
      FINALLY
        LocalSession.Free;
      END;
    END).Await(
    PROCEDURE
    BEGIN
      WITH sl DO
        TRY
          IF sl.Count > 2 THEN
            ShowMessage(text);
        FINALLY
          Free;
        END;
    END);
END;

PROCEDURE TForm2.t_executequery(queryStr, dbName, dBase, table: STRING);
VAR
  LocalSession: TEDBSession;
  LocalDatabase: TEDBDatabase;
  LocalQuery: TEDBQuery;
  LocalTable: TEDBTable;
BEGIN
  Async(
    PROCEDURE
    BEGIN
      LocalSession := GetNewSession;
      TRY
        LocalDatabase := TEDBDatabase.Create(NIL);
        TRY
          WITH LocalDatabase DO
          BEGIN
            SessionName := LocalSession.SessionName;
            Database := dBase;
            DatabaseName := dbName;
            LocalSession.LoginUser := 'Administrator';
            LocalSession.LoginPassword := 'EDBDefault';
            Connected := True;
          END;
          LocalTable := TEDBTable.Create(NIL);
          LocalQuery := TEDBQuery.Create(NIL);
          TRY
            WITH LocalTable DO
            BEGIN
              Form1.RzStatusPane1.Caption := table;
              tableName := table;
              SessionName := LocalSession.SessionName;
              DatabaseName := LocalDatabase.DatabaseName;
              Active := True;
            END;
            WITH LocalQuery DO
            BEGIN
              SessionName := LocalSession.SessionName;
              DatabaseName := LocalDatabase.DatabaseName;
              SQL.Clear;
              SQL.Add(queryStr);
              Prepare;
              TRY
                LocalDatabase.StartTransaction([table], -1);
                TRY
                  ExecSQL;
                  LocalDatabase.Commit;
                EXCEPT
                  LocalDatabase.Rollback;
                  ShowMessage('Transaction rolled back due to error');
                  RAISE;
                END;
              FINALLY
                Unprepare;
              END;
            END;
          FINALLY
            LocalTable.Refresh;
            LocalQuery.Free;
            LocalTable.Close;
            LocalTable.Free;
          END;
        FINALLY
          LocalDatabase.Free;
        END;
      FINALLY
        LocalSession.Free;
      END;
    END).Await(
    PROCEDURE
    BEGIN
      IF (table = 'Services') OR (table = 'ServicesSold') THEN
      BEGIN
        tb_Cassa_Services.Refresh;
        Form1.dbgd_Rooms.Refresh;
      END;
      IF table = 'OpenTab' THEN
      BEGIN
        tb_OTab.Refresh;
        Form1.dbgd_CashierDisplay.SumList.RecalcAll;
        Form1.dbgd_CashierDisplay.Refresh;
      END;
      IF table = 'OpenTabMemory' THEN
        tb_oTabMemory.Refresh;
      IF table = 'c_1200' THEN
      BEGIN
        qy_PagaDopo.Refresh;
        Form1.dbgd_PagaDopo.Refresh;
        Form1.dbgd_PagaDopo.SumList.RecalcAll;
      END;
      IF table = 'Clients' THEN
      BEGIN
        tb_Clients.Refresh;
      END;
      IF table = 'RREU_Bookings' THEN
      BEGIN
        // tb_RREU_Bookings.Refresh;
      END;
    END);
END;

PROCEDURE TForm2.t_Print(printQrCode, copies: integer);

BEGIN
  Async(
    PROCEDURE
    BEGIN
      sleep(2000);
      // Print the items in the string
      WITH Form1 DO
        // Form1.PrintItemsFromTables(ItemstoPrint_Arr, img_QRcode, printQrCode, db_RTEditor,          txnID, copies, GetMyPrinter);

    END).Await(
    PROCEDURE
    BEGIN

    END);
END;

PROCEDURE TForm2.t_executePrint_(PName: STRING; TextAR: TStrings;
dCredits, prCopies, header, textPos: integer; lotteryT, promoT: Boolean);
VAR
  myPrinter: TPrinter;
  Device: ARRAY [0 .. 255] OF Char;
  Driver: ARRAY [0 .. 255] OF Char;
  Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
  I, x: word;
BEGIN
  Async(
    PROCEDURE
    BEGIN
      Form1.nPrintJobDone := False;
      Printer.PrinterIndex := Printer.Printers.IndexOf(PName);
      Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
      myPrinter := Printer;
      x := 0;
      WHILE (x < prCopies) DO
        WITH myPrinter DO
        BEGIN
          // Print Headers
          BeginDoc;
          CASE header OF
            0: // Empty PGC header
              BEGIN
                SetTextAlign(myPrinter.Handle, TA_Center);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 140, 'Benvenuto al');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Times New Roman';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(250, 170, 'POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 220, 'Gentlemen''s Club');
                Canvas.Font.Size := 12;
                SetTextAlign(Printer.Handle, TA_LEFT);
              END;
            1: // Bar ticket header
              BEGIN
                SetTextAlign(myPrinter.Handle, TA_Center);
                Canvas.Draw(0, 0, Form1.dbimg_Body.Picture.Graphic);
                Canvas.Draw(220, 0, Form1.Barcode1.Bitmap);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 140, 'Benvenuto al');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Times New Roman';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(250, 170, 'POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 220, 'Gentlemen''s Club');
                SetTextAlign(myPrinter.Handle, TA_LEFT);
                Canvas.Font.Size := 16;
              END;
            2: // Credit card receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Draw(220, 0, Form1.Barcode1.Bitmap);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 110, 'CONFERMA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 170, 'Carta di Credito');
                Canvas.Font.Size := 12;
              END;
            22: // Credit card receipt header with IBAN
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'CONFERMA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per rimborso da carta di credito');
                Canvas.Font.Size := 12;
              END;
            25: // Credit card receipt header with cash
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per rimborso da carta di credito');
                Canvas.Font.Size := 12;
              END;
            29: // Rental Deposit
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                IF uClientStore.ThisBooking.reemboursment THEN
                  Canvas.TextOut(20, 90, 'RIMBORSO CAUZIONE AFFITTO')
                ELSE
                  Canvas.TextOut(20, 90, 'CAUZIONE AFFITTO CAMERA');
                Canvas.Font.Size := 12;
              END;
            3: // Liberatoria fotografica header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 18;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'LIBERATORIA');
                Canvas.TextOut(20, 100, 'FOTOGRAFICA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            4: // Rooms to clean header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'Info per pulizia');
                Canvas.TextOut(20, 100, 'Utilizzo stanze');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            5: // Evaluation header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'Valutazione tempi');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            6: // Tax receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per imposta giornaliera');
                Canvas.Font.Size := 12;
              END;
            7: // Recap Expenses receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 20, 'R i c a p i t o l a z i o n e');
                Canvas.TextOut(20, 50, 'ricevute spese');
                Canvas.TextOut(20, 80, '-----------------------------');
                Canvas.TextOut(20, 110, ' ');
                Canvas.Font.Size := 12;
              END;
            8: // Girl Promo Entrance fee header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Draw(0, 0, Form1.Image2.Picture.Graphic);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 140, '                  P R O M O');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 170, '        POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 220, '              Gentlemen''s Club');
                Canvas.Font.Size := 12;
              END;
            9: // Lottery ticket header
              BEGIN
                SetTextAlign(myPrinter.Handle, TA_Center);
                Canvas.Draw(0, 0, Form1.imgLotteryT.Picture.Graphic);
                Canvas.Draw(220, 0, Form1.Barcode1.Bitmap);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 140, 'LA FORTUNA BENDATA AL');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Times New Roman';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(250, 170, 'POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 220, 'Gentlemen''s Club');
                Canvas.Font.Size := 12;
                SetTextAlign(Printer.Handle, TA_LEFT);
              END;

            11: // Credit Card to clients recap header for administrative purposes
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 50, 'POMPEII');
                Canvas.Font.Name := 'Lucida Sans Typewriter';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 10;
                Canvas.TextOut(20, 80, 'Gentlemen''s Club');
                Canvas.Font.Size := 8;
                SetTextAlign(Printer.Handle, TA_LEFT);
              END;
            12: // Tax receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'CAUZIONE ABITAZIONE');
                Canvas.Font.Size := 12;
              END;
          END;
          // Print text
          I := 0;
          SetTextAlign(Printer.Handle, TA_LEFT);
          WHILE I < TextAR.Count DO
          BEGIN
            Canvas.TextOut(20, textPos + (I * 30), TextAR.Strings[I]);
            inc(I);
          END;
          EndDoc;
          inc(x);
        END;

      // Print Lottery ticket
      IF lotteryT THEN
      BEGIN
        // Add the letter R (Raffle) to txID
        WITH Form1 DO
        BEGIN
          Barcode1.InputText := 'R' + txnID;
          TRY
            img_QRcode.Picture.Assign(Barcode1.Bitmap);
          EXCEPT
            ON E: Exception DO
            BEGIN
              img_QRcode.Picture.Assign(NIL);
            END;
          END;
        END;
        x := 0;
        WHILE (x < 2) DO
        BEGIN
          WITH myPrinter DO
          BEGIN
            BeginDoc;
            IF x = 0 THEN
            BEGIN
              SetTextAlign(myPrinter.Handle, TA_Center);
              Canvas.Draw(0, 0, Form1.imgLotteryT.Picture.Graphic);
              Canvas.Draw(0, 0, Form1.dbimg_Body.Picture.Graphic);
              Canvas.Draw(220, 0, Form1.img_QRcode.Picture.Graphic);
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 140, Form1.ed_LotteryT.text);
              Canvas.Font.Size := 20;
              Canvas.Font.Name := 'Times New Roman';
              Canvas.Font.Style := [fsBold];
              Canvas.TextOut(250, 170, 'POMPEII');
              Canvas.Font.Name := 'Tahoma';
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 220, 'Gentlemen''s Club');
            END;
            IF x > 0 THEN
            BEGIN
              Canvas.Font.Name := 'Tahoma';
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 220, 'Ticket Club');
            END;
            Canvas.Font.Style := [fsBold];
            Canvas.Font.Size := 24;
            Canvas.TextOut(250, 300, '*' + RightStr(Form1.txnID, 5) + '*');
            Canvas.Font.Style := [];
            Canvas.Font.Size := 12;
            Canvas.TextOut(250, 500, DateTimeToStr(NOW));
            EndDoc;
          END;
          inc(x);
        END;
      END;

      IF promoT THEN
      BEGIN
        WITH myPrinter DO
        BEGIN
          (*
            BeginDoc;
            SetTextAlign(myPrinter.Handle, TA_Center);
            Canvas.Font.Size := 20;
            Canvas.Font.Name := 'Times New Roman';
            Canvas.Font.Style := [fsBold];
            Canvas.TextOut(250, 0, 'POMPEII');

            Canvas.Font.Name := 'Tahoma';
            Canvas.Font.Style := [];
            Canvas.Font.Size := 12;
            Canvas.TextOut(250, 50, Form1.ed_PromoTxt0.Text);
            // Canvas.Draw(120, 110, Form1.db_PromoImage.Picture.Graphic);
            Canvas.Draw(120, 110, Form1.Image5.Picture.Graphic);

            Canvas.TextOut(257, 400, Form1.ed_PromoTxt1.Text);
            Canvas.TextOut(257, 440, Form1.ed_PromoTxt2.Text);
            Canvas.Font.Size := 10;

            Canvas.TextOut(257, 490, Form1.ed_PromoTxt3.Text);
            Canvas.TextOut(250, 540, DateTimeToStr(Now));
            EndDoc;
          *)
        END;
      END;
    END).Await(
    PROCEDURE
    BEGIN
      TextAR.Free;
      Form1.nPrintJobDone := True;
    END);
END;

PROCEDURE TForm2.HandleMguardClientData(CONST task: IOmniTask);
VAR
  eventCode, cardID, cardInID, clientID, deviceAddress, deviceName, actuatorID,
    readerID: STRING;
  LocalSession: TEDBSession;
  LocalDatabase: TEDBDatabase;
  LocalQuery: TEDBQuery;
  LocalTable: TEDBTable;
  cardValid: Boolean;
  // if card,client,fee,valid exists in ServicesSold table
  fID: integer;
BEGIN
  fID := 0;
  // Collect data
  // ------------------------------------------------------------------------
  deviceAddress := task.Param.ByName('deviceAddress');
  deviceName := task.Param.ByName('deviceName');
  IF Copy(deviceName, 1, 8) = 'Actuator' THEN
    deviceName := 'Actuator';
  eventCode := task.Param.ByName('eventCode');
  cardID := task.Param.ByName('cardID');
  clientID := task.Param.ByName('clientID');
  // Get service info
  // ------------------------------------------------------------------------
  LocalSession := GetNewSession;
  TRY
    LocalDatabase := TEDBDatabase.Create(NIL);
    TRY
      WITH LocalDatabase DO
      BEGIN
        SessionName := LocalSession.SessionName;
        Database := 'PGC_DB_Main_Euro';
        DatabaseName := 'DB_Main';
        LocalSession.LoginUser := 'Administrator';
        LocalSession.LoginPassword := 'EDBDefault';
        Connected := True;
      END;
      LocalTable := TEDBTable.Create(NIL);
      LocalQuery := TEDBQuery.Create(NIL);
      TRY
        WITH LocalTable DO
        BEGIN
          tableName := 'Services';
          SessionName := LocalSession.SessionName;
          DatabaseName := 'DB_Main';
          Active := True;
        END;
        WITH LocalQuery DO
        BEGIN
          SessionName := LocalSession.SessionName;
          DatabaseName := LocalDatabase.DatabaseName;
          SQL.Clear;
          SQL.Add('SELECT ID AS b_ID,FeeID AS b_feeID,CardInID AS b_CardIN,' +
            ' Actuator AS b_ActID, Reader AS b_ReaID , Enabled AS b_Ena,' +
            ' UsedWithoutClean AS b_Used' + ' FROM Services' +
            ' WHERE (Reader = ' + deviceAddress + ' OR Actuator = ' +
            deviceAddress);
          Prepare;
          TRY
            LocalDatabase.StartTransaction(['Services'], -1);
            TRY
              ExecSQL;
              LocalDatabase.Commit;
              IF FieldValues['feeID'] <> NULL THEN
              BEGIN
                fID := FieldValues['b_FeeID'];
                cardInID := FieldValues['b_CardIN'];
                actuatorID := FieldValues['b_ActID'];
                readerID := FieldValues['b_ReaID'];
              END
              ELSE
                fID := 0;
            EXCEPT
              LocalDatabase.Rollback;
            END;
          FINALLY
            LocalDatabase.CloseDataSets;
            Unprepare;
          END;
        END;
      FINALLY
        LocalQuery.Free;
        LocalTable.Close;
        LocalTable.Free;
      END;
    FINALLY
      LocalDatabase.Free;
    END;
  FINALLY
    LocalSession.Free;
  END;
  sleep(50);

  IF fID > 0 THEN
  BEGIN
    // now check feeid,cardid,userid,valid in ServicesSold table
    // ---------------------------------------------------------------------------
    LocalSession := GetNewSession;
    TRY
      LocalDatabase := TEDBDatabase.Create(NIL);
      TRY
        WITH LocalDatabase DO
        BEGIN
          SessionName := LocalSession.SessionName;
          Database := 'PGC_DB_Main_Euro';
          DatabaseName := 'DB_Main';
          LocalSession.LoginUser := 'Administrator';
          LocalSession.LoginPassword := 'EDBDefault';
          Connected := True;
        END;
        LocalTable := TEDBTable.Create(NIL);
        LocalQuery := TEDBQuery.Create(NIL);
        TRY
          WITH LocalTable DO
          BEGIN
            tableName := 'ServicesSold';
            SessionName := LocalSession.SessionName;
            DatabaseName := 'DB_Main';
            Active := True;
          END;
          WITH LocalQuery DO
          BEGIN
            SessionName := LocalSession.SessionName;
            DatabaseName := LocalDatabase.DatabaseName;
            SQL.Clear;
            SQL.Add('SELECT Valid AS val FROM ServicesSold WHERE CardID = ' +
              cardID + ' AND ClientID = ' + clientID + ' AND FeeID = ' +
              IntToStr(fID) + ' AND Valid = True');
            Prepare;
            TRY
              LocalDatabase.StartTransaction(['ServicesSold'], -1);
              TRY
                ExecSQL;
                LocalDatabase.Commit;
                IF FieldValues['val'] = True THEN
                  cardValid := True
                ELSE
                  cardValid := False
              EXCEPT
                LocalDatabase.Rollback;
              END;
            FINALLY
              LocalDatabase.CloseDataSets;
              Unprepare;
            END;
          END;
        FINALLY
          LocalQuery.Free;
          LocalTable.Close;
          LocalTable.Free;
        END;
      FINALLY
        LocalDatabase.Free;
      END;
    FINALLY
      LocalSession.Free;
    END;
  END // end if fee  > 0
  ELSE
  BEGIN
    // else if there is no fee then check if client is in house and enabled
    // -----------------------------------------------------------------------
    LocalSession := GetNewSession;
    TRY
      LocalDatabase := TEDBDatabase.Create(NIL);
      TRY
        WITH LocalDatabase DO
        BEGIN
          SessionName := LocalSession.SessionName;
          Database := 'PGC_DB_Main_Euro';
          DatabaseName := 'DB_Main';
          LocalSession.LoginUser := 'Administrator';
          LocalSession.LoginPassword := 'EDBDefault';
          Connected := True;
        END;
        LocalTable := TEDBTable.Create(NIL);
        LocalQuery := TEDBQuery.Create(NIL);
        TRY
          WITH LocalTable DO
          BEGIN
            tableName := 'Clients';
            SessionName := LocalSession.SessionName;
            DatabaseName := 'DB_Main';
            Active := True;
          END;
          WITH LocalQuery DO
          BEGIN
            SessionName := LocalSession.SessionName;
            DatabaseName := LocalDatabase.DatabaseName;
            SQL.Clear;
            SQL.Add('SELECT Enabled AS ena FROM Clients WHERE' + ' ClientID = '
              + clientID + ' AND InHouse = True' + ' AND Enabled = True');
            Prepare;
            TRY
              LocalDatabase.StartTransaction(['Cards'], -1);
              TRY
                ExecSQL;
                LocalDatabase.Commit;
                IF FieldValues['ena'] = True THEN
                  cardValid := True
                ELSE
                  cardValid := False
              EXCEPT
                LocalDatabase.Rollback;
              END;
            FINALLY
              LocalDatabase.CloseDataSets;
              Unprepare;
            END;
          END;
        FINALLY
          LocalQuery.Free;
          LocalTable.Close;
          LocalTable.Free;
        END;
      FINALLY
        LocalDatabase.Free;
      END;
    FINALLY
      LocalSession.Free;
    END;
  END;
END;

PROCEDURE TForm2.HandleMguardPersonnelData(CONST task: IOmniTask);
VAR
  eventCode, cardID, deviceAddress, deviceName: STRING;
  // readerID, actuatorID, clientID:String;
  LocalSession: TEDBSession;
  LocalDatabase: TEDBDatabase;
  LocalQuery: TEDBQuery;
  LocalTable: TEDBTable;
  cardValid: Boolean; // if card, valid exists in Cards table
  // fID: integer;
BEGIN
  // Collect data
  // ------------------------------------------------------------------------
  cardValid := False;
  deviceAddress := task.Param.ByName('deviceAddress');
  deviceName := task.Param.ByName('deviceName');
  IF Copy(deviceName, 1, 8) = 'Actuator' THEN
    deviceName := 'Actuator';
  eventCode := task.Param.ByName('eventCode');
  cardID := task.Param.ByName('cardID');
  // check if card exists, is valid and has rights
  // ----------------------------------------------------------
  LocalSession := GetNewSession;
  TRY
    LocalDatabase := TEDBDatabase.Create(NIL);
    TRY
      WITH LocalDatabase DO
      BEGIN
        SessionName := LocalSession.SessionName;
        Database := 'PGC_DB_Main_Euro';
        DatabaseName := 'DB_Main';
        LocalSession.LoginUser := 'Administrator';
        LocalSession.LoginPassword := 'EDBDefault';
        Connected := True;
      END;
      LocalTable := TEDBTable.Create(NIL);
      LocalQuery := TEDBQuery.Create(NIL);
      TRY
        WITH LocalTable DO
        BEGIN
          tableName := 'Cards';
          SessionName := LocalSession.SessionName;
          DatabaseName := 'DB_Main';
          Active := True;
        END;
        WITH LocalQuery DO
        BEGIN
          SessionName := LocalSession.SessionName;
          DatabaseName := LocalDatabase.DatabaseName;
          SQL.Clear;
          SQL.Add('SELECT Enabled AS ena FROM Cards WHERE CardID = ' + cardID +
            ' AND Enabled = True');
          Prepare;
          TRY
            LocalDatabase.StartTransaction(['ServicesSold'], -1);
            TRY
              ExecSQL;
              LocalDatabase.Commit;
              IF FieldValues['ena'] = True THEN
                cardValid := True
              ELSE
                cardValid := False
            EXCEPT
              LocalDatabase.Rollback;
            END;
          FINALLY
            LocalDatabase.CloseDataSets;
            Unprepare;
          END;
        END;
      FINALLY
        LocalQuery.Free;
        LocalTable.Close;
        LocalTable.Free;
      END;
    FINALLY
      LocalDatabase.Free;
    END;
  FINALLY
    LocalSession.Free;
  END;
  task.Comm.Send(0, cardValid);
END;

FUNCTION TForm2.GetNewSession: TEDBSession;
BEGIN
  EnterCriticalSection(SessionNameSection);
  TRY
    LastSessionValue := LastSessionValue + 1;
    Result := TEDBSession.Create(NIL);
    WITH Result DO
    BEGIN
      SessionName := 'AccountSession' + IntToStr(LastSessionValue);
      SessionType := stRemote;
    END;
  FINALLY
    LeaveCriticalSection(SessionNameSection);
  END;
END;

// ------------------------------------------------------------------------------
// Thread task starter procedures
// ------------------------------------------------------------------------------

PROCEDURE TForm2.OmniEventMonitor1TaskTerminated(CONST task: IOmniTaskControl);
BEGIN
  tb_Cassa_Services.Refresh;
  qy_ClientSS.Refresh;
  task.Terminate(1);
  // Form1.RecalcClGridSums;
  IF task = t_WriteData THEN
    t_WriteData := NIL;
  IF task = t_Playsound THEN
    t_Playsound := NIL;
  IF task = t_CheckLifeSpan THEN
    t_CheckLifeSpan := NIL;
END;

PROCEDURE TForm2.OmniEventMonitor1TaskUndeliveredMessage
  (CONST task: IOmniTaskControl; CONST msg: TOmniMessage);
BEGIN
  Form1.nnWriteCashierDisplay(0, True, clRed, task.Name + ': ' + msg.MsgData +
    ' OmniEvMon undelivered!', 0);
END;

PROCEDURE TForm2.PlayASound(soundFile: STRING; loop: Boolean);
BEGIN
  Async(
    PROCEDURE
    BEGIN
      IF soundFile <> '' THEN
      BEGIN
        soundFile := 'C:\Program Files (x86)\PGC_510\' + soundFile;
        IF loop THEN
          sndPlaySound(PWideChar(soundFile), SND_NODEFAULT OR
            SND_ASYNC OR SND_LOOP)
        ELSE
          sndPlaySound(PWideChar(soundFile), SND_NODEFAULT OR SND_ASYNC);
      END
      ELSE
        sndPlaySound(PWideChar(NIL), SND_NODEFAULT OR SND_ASYNC);
    END).Await(
    PROCEDURE
    BEGIN
      //
    END);
END;

PROCEDURE TForm2.qy_RR_21CalcFields(DataSet: TDataSet);
BEGIN
  Trim(DataSet.FieldByName('Alias').AsString);
END;

PROCEDURE TForm2.qy_RR_23CalcFields(DataSet: TDataSet);
BEGIN
  Trim(DataSet.FieldByName('Alias').AsString);
END;

{
  procedure TForm2.FillGridFromQuery;
  var
  aRow, aCol: integer;
  F, Fp, Fb, fID, T1, T3, T4, T5, T6: TField;
  dayName, payedEntrance, barEntrance, clientID: string;
  calDate, aDate: TDateTime;
  Y, M: word;

  // capture "Entrate Bar" for the extra footer
  BarVals: array [1 .. 31] of string;
  BarT1, BarT3, BarT4, BarT5, BarT6: string;
  HasBar: Boolean;

  procedure InitBarData;
  var
  i: integer;
  begin
  for i := 1 to 31 do
  BarVals[i] := '';
  BarT1 := '';
  BarT3 := '';
  BarT4 := '';
  BarT5 := '';
  BarT6 := '';
  HasBar := False;
  end;

  begin
  MonthlyStats;

  calDate := Form1.cal_ClRoster.Date;
  Y := YearOf(calDate);
  M := MonthOf(calDate);

  InitBarData;

  Form1.sg_ClientRoster.BeginUpdate;
  try
  with Form1.sg_ClientRoster do
  begin
  ClearAll;
  FixedFooters := 0;

  if ColCount < 38 then
  ColCount := 38; // 0..37

  // two header rows (0,1); data from row 2
  RowCount := Form2.q.RecordCount + 2;
  FixedRows := 2;

  // widths
  ColWidths[0] := 110;
  ColWidths[37] := 30;
  for aCol := 1 to 31 do
  ColWidths[aCol] := 30;
  for aCol := 32 to 36 do
  ColWidths[aCol] := 58;

  // header row 0: day numbers
  for aCol := 1 to 31 do
  Cells[aCol, 0] := Format('%0.2d', [aCol]);

  // header row 1: weekday initials (locale-aware)
  for aCol := 1 to 31 do
  begin
  if TryEncodeDate(Y, M, aCol, aDate) then
  Cells[aCol, 1] :=
  Copy(FormatSettings.ShortDayNames[DayOfWeek(aDate)], 1, 1)
  else
  Cells[aCol, 1] := '';
  end;

  Cells[0, 0] := FormatSettings.LongMonthNames[M];
  Cells[32, 0] := 'Totale ';
  Cells[33, 0] := '- 3 -';
  Cells[34, 0] := '- 4 -';
  Cells[35, 0] := '- 5 -';
  Cells[36, 0] := '- 6 -';
  Cells[37, 0] := 'ID Cliente';
  ColAlignments[0] := taLeftJustify;

  // fill data (row 2..)
  aRow := 2;
  Form2.q.First;
  while not Form2.q.EoF do
  begin
  clientID := 'ClientID';
  fID := q.FindField(clientID);

  if (fID <> nil) and (fID.AsInteger = 0) then
  begin
  // capture bar data only (no data row)
  HasBar := True;

  for aCol := 1 to 31 do
  begin
  barEntrance := Format('E%0.2d', [aCol]);
  Fb := q.FindField(barEntrance);
  if (Fb <> nil) and (not Fb.IsNull) and (Fb.AsInteger > 0) then
  BarVals[aCol] := Fb.AsString
  else
  BarVals[aCol] := '';
  end;

  T1 := q.FindField('TF1');
  T3 := q.FindField('TF3');
  T4 := q.FindField('TF4');
  T5 := q.FindField('TF5');
  T6 := q.FindField('TF6');

  if (T1 <> nil) and (not T1.IsNull) and (T1.AsInteger > 0) then
  BarT1 := T1.AsString;
  if (T3 <> nil) and (not T3.IsNull) and (T3.AsInteger > 0) then
  BarT3 := T3.AsString;
  if (T4 <> nil) and (not T4.IsNull) and (T4.AsInteger > 0) then
  BarT4 := T4.AsString;
  if (T5 <> nil) and (not T5.IsNull) and (T5.AsInteger > 0) then
  BarT5 := T5.AsString;
  if (T6 <> nil) and (not T6.IsNull) and (T6.AsInteger > 0) then
  BarT6 := T6.AsString;
  end
  else
  begin
  Cells[0, aRow] := Trim(Form2.q.FieldByName('Alias').AsString);
  Cells[37, aRow] := Form2.q.FieldByName('ClientID').AsString;

  for aCol := 1 to 31 do
  begin
  dayName := Format('d%0.2d', [aCol]);
  payedEntrance := Format('X%0.2d', [aCol]);
  F := q.FindField(dayName);
  Fp := q.FindField(payedEntrance);

  if (F <> nil) and (not F.IsNull) and (F.AsInteger > 0) then
  Cells[aCol, aRow] := F.AsString
  else if (Fp <> nil) and (not Fp.IsNull) and (Fp.AsInteger > 0) then
  Cells[aCol, aRow] := 'x';
  end;

  T3 := q.FindField('TF3');
  T4 := q.FindField('TF4');
  T5 := q.FindField('TF5');
  T6 := q.FindField('TF6');

  if (T3 <> nil) and (not T3.IsNull) and (T3.AsInteger > 0) then
  Cells[33, aRow] := T3.AsString;
  if (T4 <> nil) and (not T4.IsNull) and (T4.AsInteger > 0) then
  Cells[34, aRow] := T4.AsString;
  if (T5 <> nil) and (not T5.IsNull) and (T5.AsInteger > 0) then
  Cells[35, aRow] := T5.AsString;
  if (T6 <> nil) and (not T6.IsNull) and (T6.AsInteger > 0) then
  Cells[36, aRow] := T6.AsString;

  inc(aRow);
  end;

  Form2.q.Next;
  end;

  if HasBar then
  RowCount := RowCount - 1; // we skipped printing the bar as data

  // --- IMPORTANT ORDER ---
  // 1) Let helper create its 2 footer rows (it may set FixedFooters := 2 internally)
  BuildColumnTotalsFooter(2, 1, 31, False); // data starts at row 2

  // 2) NOW expand to 3 footer rows (adds one above the existing two)
  FixedFooters := 3;

  // 3) Write "Entrate Bar" into the TOP footer row (RowCount - 3)
  var
  BarFooterRow := RowCount - FixedFooters; // = RowCount - 3
  Cells[0, BarFooterRow] := 'Entrate Bar';
  Cells[37, BarFooterRow] := '';

  for aCol := 1 to 31 do
  Cells[aCol, BarFooterRow] := BarVals[aCol];

  Cells[32, BarFooterRow] := BarT1;
  Cells[33, BarFooterRow] := BarT3;
  Cells[34, BarFooterRow] := BarT4;
  Cells[35, BarFooterRow] := BarT5;
  Cells[36, BarFooterRow] := BarT6;
  end;
  finally
  Form1.sg_ClientRoster.EndUpdate;

  end;
  end;
}

{
  procedure TForm2.BuildColumnTotalsFooter(FirstDataRow, FirstDataCol,
  LastDataCol: integer; ExcludeLastDataRow: Boolean = False);
  const
  ClientIDCol = 37; // your ClientID column index
  TotalsCol = 32; // "Totals" column index
  DesiredFooters = 2; // Sum + Count
  var
  r, c: integer;
  CurrDataEnd, ClientZeroRow: integer;
  NeededDataRows, NeededRowCount: integer;
  DataEndRow: integer;
  rSum, rCount: integer;
  sumV, grandSum: integer;
  cnt, grandCnt: integer;
  s, hdr: string;
  dayVal: integer;
  deltaFoot: integer;
  cID: integer;
  begin
  with Form1.sg_ClientRoster do
  begin
  BeginUpdate;
  try
  // Ensure required columns exist (never shrink here)
  if ColCount <= TotalsCol then
  ColCount := TotalsCol + 1;
  if ColCount <= ClientIDCol then
  ColCount := ClientIDCol + 1;

  if Cells[TotalsCol, 0] = '' then
  Cells[TotalsCol, 0] := 'Totals';

  // --- Find current last data row and the ClientID=0 row (above any existing footers) ---
  CurrDataEnd := RowCount - 1 - FixedFooters;
  if CurrDataEnd < FirstDataRow then
  CurrDataEnd := FirstDataRow - 1;

  ClientZeroRow := -1;
  for r := FirstDataRow to CurrDataEnd do
  begin
  cID := StrToIntDef(Trim(Cells[ClientIDCol, r]), -1);
  if cID = 0 then
  begin
  ClientZeroRow := r;
  Break;
  end;
  end;

  // We need enough *data* rows to keep ClientID=0 within data area,
  // plus room for DesiredFooters at the bottom.
  if ClientZeroRow >= 0 then
  NeededDataRows := ClientZeroRow + 1
  else
  NeededDataRows := CurrDataEnd + 1; // current data rows count

  if NeededDataRows < FirstDataRow then
  NeededDataRows := FirstDataRow;

  NeededRowCount := NeededDataRows + DesiredFooters;

  // Grow RowCount first (never shrink), so footers never eat data
  if RowCount < NeededRowCount then
  RowCount := NeededRowCount;

  // If we need more footers than currently reserved, grow RowCount by the delta first
  deltaFoot := DesiredFooters - FixedFooters;
  if deltaFoot > 0 then
  RowCount := RowCount + deltaFoot;
  FixedFooters := DesiredFooters;

  // Recompute indices after adjustments
  DataEndRow := RowCount - 1 - FixedFooters;
  if ExcludeLastDataRow and (DataEndRow >= FirstDataRow) then
  Dec(DataEndRow);

  rSum := RowCount - 2; // Sum footer row
  rCount := RowCount - 1; // Count footer row

  // ===== SUM footer (exclude ClientID=0) =====
  Cells[0, rSum] := 'Σ (Sum)';
  grandSum := 0;

  for c := FirstDataCol to LastDataCol do
  begin
  sumV := 0;
  for r := FirstDataRow to DataEndRow do
  begin
  cID := StrToIntDef(Trim(Cells[ClientIDCol, r]), -1);
  if cID = 0 then
  Continue; // exclude ClientID=0
  s := Cells[c, r];
  inc(sumV, StrToIntDef(s, 0));
  // numeric-only sum (matches your original)
  end;
  Ints[c, rSum] := sumV;
  inc(grandSum, sumV);
  end;
  Ints[TotalsCol, rSum] := grandSum;

  // ===== COUNT footer for headers "01".."31" (exclude ClientID=0, count non-empty) =====
  Cells[0, rCount] := '# (01..31)';
  grandCnt := 0;

  for c := 0 to ColCount - 1 do
  begin
  hdr := Trim(Cells[c, 0]);
  dayVal := StrToIntDef(hdr, -1);
  if (Length(hdr) = 2) and (dayVal >= 1) and (dayVal <= 31) then
  begin
  cnt := 0;
  for r := FirstDataRow to DataEndRow do
  begin
  cID := StrToIntDef(Trim(Cells[ClientIDCol, r]), -1);
  if cID = 0 then
  Continue; // exclude ClientID=0
  if Cells[c, r] <> '' then
  inc(cnt); // count any non-empty cell (numbers or strings)
  end;
  Ints[c, rCount] := cnt;
  inc(grandCnt, cnt);
  end;
  end;

  Ints[TotalsCol, rCount] := grandCnt;

  finally
  EndUpdate;
  end;
  end;
  end;
}

Procedure TForm2.MonthlyStats;
begin
  WITH Form2.PGC_Query do
  begin
    If Active Then
      Close;
    q.SQL.Clear;
    q.SQL.Clear;
    const
      // Safely convert string -> DATE (treat '' as NULL so CAST never errors)
      ClosingDateExpr = 'CAST(NULLIF(RTRIM(LTRIM(t.ClosingID)), '''') AS DATE)';
    q.SQL.Add('SELECT t.ClientID, c.ID, c.Alias,');

    // Days 1..7
    q.SQL.Add(' /* Days 1..7 */ ' + ' SUM(CASE WHEN EXTRACT(DAY FROM ' +
      ClosingDateExpr + ') =  1 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d01, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  1 AND t.SubFeeID IN (310,315) THEN 1 END) AS X01, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  1 AND t.FeeID   IN (1) THEN 1 END) AS E01, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  2 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d02, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  2 AND t.SubFeeID IN (310,315) THEN 1 END) AS X02, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  2 AND t.FeeID   IN (1) THEN 1 END) AS E02, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  3 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d03, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  3 AND t.SubFeeID IN (310,315) THEN 1 END) AS X03, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  3 AND t.FeeID   IN (1) THEN 1 END) AS E03, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  4 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d04, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  4 AND t.SubFeeID IN (310,315) THEN 1 END) AS X04, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  4 AND t.FeeID   IN (1) THEN 1 END) AS E04, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  5 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d05, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  5 AND t.SubFeeID IN (310,315) THEN 1 END) AS X05, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  5 AND t.FeeID   IN (1) THEN 1 END) AS E05, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  6 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d06, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  6 AND t.SubFeeID IN (310,315) THEN 1 END) AS X06, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  6 AND t.FeeID   IN (1) THEN 1 END) AS E06, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  7 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d07, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  7 AND t.SubFeeID IN (310,315) THEN 1 END) AS X07, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  7 AND t.FeeID   IN (1) THEN 1 END) AS E07, ');

    // Days 8..14
    q.SQL.Add(' /* Days 8..14 */ ' + ' SUM(CASE WHEN EXTRACT(DAY FROM ' +
      ClosingDateExpr + ') =  8 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d08, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  8 AND t.SubFeeID IN (310,315) THEN 1 END) AS X08, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  8 AND t.FeeID   IN (1) THEN 1 END) AS E08, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  9 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d09, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  9 AND t.SubFeeID IN (310,315) THEN 1 END) AS X09, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') =  9 AND t.FeeID   IN (1) THEN 1 END) AS E09, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 10 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d10, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 10 AND t.SubFeeID IN (310,315) THEN 1 END) AS X10, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 10 AND t.FeeID   IN (1) THEN 1 END) AS E10, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 11 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d11, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 11 AND t.SubFeeID IN (310,315) THEN 1 END) AS X11, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 11 AND t.FeeID   IN (1) THEN 1 END) AS E11, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 12 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d12, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 12 AND t.SubFeeID IN (310,315) THEN 1 END) AS X12, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 12 AND t.FeeID   IN (1) THEN 1 END) AS E12, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 13 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d13, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 13 AND t.SubFeeID IN (310,315) THEN 1 END) AS X13, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 13 AND t.FeeID   IN (1) THEN 1 END) AS E13, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 14 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d14, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 14 AND t.SubFeeID IN (310,315) THEN 1 END) AS X14, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 14 AND t.FeeID   IN (1) THEN 1 END) AS E14, ');

    // Days 15..21 + W3
    q.SQL.Add(' /* Days 15..21 + W3 */ ' + ' SUM(CASE WHEN EXTRACT(DAY FROM ' +
      ClosingDateExpr + ') = 15 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d15, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 15 AND t.SubFeeID IN (310,315) THEN 1 END) AS X15, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 15 AND t.FeeID   IN (1) THEN 1 END) AS E15, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 16 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d16, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 16 AND t.SubFeeID IN (310,315) THEN 1 END) AS X16, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 16 AND t.FeeID   IN (1) THEN 1 END) AS E16, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 17 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d17, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 17 AND t.SubFeeID IN (310,315) THEN 1 END) AS X17, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 17 AND t.FeeID   IN (1) THEN 1 END) AS E17, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 18 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d18, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 18 AND t.SubFeeID IN (310,315) THEN 1 END) AS X18, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 18 AND t.FeeID   IN (1) THEN 1 END) AS E18, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 19 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d19, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 19 AND t.SubFeeID IN (310,315) THEN 1 END) AS X19, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 19 AND t.FeeID   IN (1) THEN 1 END) AS E19, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 20 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d20, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 20 AND t.SubFeeID IN (310,315) THEN 1 END) AS X20, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 20 AND t.FeeID   IN (1) THEN 1 END) AS E20, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 21 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d21, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 21 AND t.SubFeeID IN (310,315) THEN 1 END) AS X21, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 21 AND t.FeeID   IN (1) THEN 1 END) AS E21, ');

    // Days 22..28
    q.SQL.Add(' /* Days 22..28 */ ' + ' SUM(CASE WHEN EXTRACT(DAY FROM ' +
      ClosingDateExpr + ') = 22 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d22, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 22 AND t.SubFeeID IN (310,315) THEN 1 END) AS X22, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 22 AND t.FeeID   IN (1) THEN 1 END) AS E22, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 23 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d23, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 23 AND t.SubFeeID IN (310,315) THEN 1 END) AS X23, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 23 AND t.FeeID   IN (1) THEN 1 END) AS E23, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 24 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d24, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 24 AND t.SubFeeID IN (310,315) THEN 1 END) AS X24, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 24 AND t.FeeID   IN (1) THEN 1 END) AS E24, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 25 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d25, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 25 AND t.SubFeeID IN (310,315) THEN 1 END) AS X25, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 25 AND t.FeeID   IN (1) THEN 1 END) AS E25, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 26 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d26, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 26 AND t.SubFeeID IN (310,315) THEN 1 END) AS X26, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 26 AND t.FeeID   IN (1) THEN 1 END) AS E26, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 27 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d27, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 27 AND t.SubFeeID IN (310,315) THEN 1 END) AS X27, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 27 AND t.FeeID   IN (1) THEN 1 END) AS E27, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 28 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d28, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 28 AND t.SubFeeID IN (310,315) THEN 1 END) AS X28, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 28 AND t.FeeID   IN (1) THEN 1 END) AS E28, ');

    // Days 29..31
    q.SQL.Add(' /* Days 29..31 */ ' + ' SUM(CASE WHEN EXTRACT(DAY FROM ' +
      ClosingDateExpr + ') = 29 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d29, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 29 AND t.SubFeeID IN (310,315) THEN 1 END) AS X29, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 29 AND t.FeeID   IN (1) THEN 1 END) AS E29, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 30 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d30, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 30 AND t.SubFeeID IN (310,315) THEN 1 END) AS X30, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 30 AND t.FeeID   IN (1) THEN 1 END) AS E30, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 31 AND t.FeeID   IN (4,5,6) THEN 1 END) AS d31, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 31 AND t.SubFeeID IN (310,315) THEN 1 END) AS X31, ' +
      ' SUM(CASE WHEN EXTRACT(DAY FROM ' + ClosingDateExpr +
      ') = 31 AND t.FeeID   IN (1) THEN 1 END) AS E31, ');

    // Totals
    q.SQL.Add(
      '  CASE WHEN c.ID = 0 THEN SUM(CASE WHEN t.FeeID = 1 THEN 1 END) ELSE CAST(NULL AS INTEGER) END AS TF1, '
      + '  SUM(CASE WHEN t.SubFeeID IN (310,315) THEN 1 END) AS TF3,' +
      '  SUM(CASE WHEN t.FeeID = 4 THEN 1 END) AS TF4,' +
      '  SUM(CASE WHEN t.FeeID = 5 THEN 1 END) AS TF5,' +
      '  SUM(CASE WHEN t.FeeID = 6 THEN 1 END) AS TF6 ');

    // FROM / JOIN / WHERE / GROUP BY
    q.SQL.Add(' FROM c_1000 t');
    q.SQL.Add(' JOIN Clients c ON c.ID = t.ClientID');
    q.SQL.Add(' WHERE ' + ClosingDateExpr + ' >= :StartDate');
    q.SQL.Add('   AND ' + ClosingDateExpr + ' <  :EndDateEx');
    q.SQL.Add('   AND (t.FeeID IN (1,4,5,6) OR t.SubFeeID IN (310,315))');
    q.SQL.Add(' GROUP BY c.ID, c.Alias');
    q.SQL.Add(' ORDER BY c.Alias;');

    // Params: half-open [StartDate, EndDateEx)
    var
      StartDate, EndDateEx: TDateTime;
    StartDate := EncodeDate(YearOf(Form1.cal_ClRoster.Date),
      MonthOf(Form1.cal_ClRoster.Date), 1); // 00:00
    EndDateEx := IncMonth(StartDate, 1); // first of next month 00:00

    q.ParamByName('StartDate').AsDateTime := StartDate;
    q.ParamByName('EndDateEx').AsDateTime := EndDateEx;
    q.Active := True;
  end;
end;

INITIALIZATION

LastSessionValue := 0;
InitializeCriticalSection(SessionNameSection);

FINALIZATION

DeleteCriticalSection(SessionNameSection);

END.
