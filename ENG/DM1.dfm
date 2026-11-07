object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Data Module'
  ClientHeight = 674
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 24
    Top = 195
    Width = 337
    Height = 134
  end
  object Label1: TLabel
    Left = 32
    Top = 195
    Width = 34
    Height = 16
    Caption = 'Cassa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape2: TShape
    Left = 367
    Top = 195
    Width = 249
    Height = 134
  end
  object Label2: TLabel
    Left = 375
    Top = 195
    Width = 81
    Height = 16
    Caption = 'Prezzi - Bonus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape3: TShape
    Left = 24
    Top = 335
    Width = 337
    Height = 154
  end
  object Label3: TLabel
    Left = 32
    Top = 335
    Width = 35
    Height = 16
    Caption = 'Clienti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape4: TShape
    Left = 24
    Top = 55
    Width = 407
    Height = 90
  end
  object Label4: TLabel
    Left = 32
    Top = 55
    Width = 204
    Height = 16
    Caption = 'Engine - Session -Database - Query'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape5: TShape
    Left = 367
    Top = 335
    Width = 249
    Height = 154
  end
  object Label5: TLabel
    Left = 375
    Top = 335
    Width = 50
    Height = 16
    Caption = 'Chiusura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape6: TShape
    Left = 622
    Top = 335
    Width = 249
    Height = 154
  end
  object Label6: TLabel
    Left = 630
    Top = 335
    Width = 46
    Height = 16
    Caption = 'Tessere'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape7: TShape
    Left = 622
    Top = 195
    Width = 249
    Height = 134
  end
  object Label7: TLabel
    Left = 630
    Top = 195
    Width = 46
    Height = 16
    Caption = 'Sentinel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape8: TShape
    Left = 367
    Top = 495
    Width = 249
    Height = 154
  end
  object Label8: TLabel
    Left = 375
    Top = 495
    Width = 56
    Height = 16
    Caption = 'Personale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape9: TShape
    Left = 24
    Top = 495
    Width = 337
    Height = 154
  end
  object Label9: TLabel
    Left = 32
    Top = 495
    Width = 79
    Height = 16
    Caption = 'Manutenzione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape10: TShape
    Left = 622
    Top = 495
    Width = 249
    Height = 154
  end
  object Label10: TLabel
    Left = 630
    Top = 495
    Width = 41
    Height = 16
    Caption = 'RS 485'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EDBEngine1: TEDBEngine
    Active = True
    EngineType = etClient
    Signature = 'edb_signature'
    EncryptionPassword = 'elevatesoft'
    LicensedSessions = 4096
    ConfigPath = 'C:\Program Files (x86)\PGC_510\Data Unicode'
    ConfigName = 'EDBConfig'
    ConfigExtension = '.EDBCfg'
    LockExtension = '.EDBLck'
    LogExtension = '.EDBLog'
    MaxLogFileSize = 1048576
    LogCategories = [lcInformation, lcWarning, lcError]
    CatalogName = 'EDBDatabase'
    CatalogExtension = '.EDBCat'
    BackupExtension = '.EDBBkp'
    UpdateExtension = '.EDBUpd'
    TableExtension = '.EDBTbl'
    TableIndexExtension = '.EDBIdx'
    TableBlobExtension = '.EDBBlb'
    TablePublishExtension = '.EDBPbl'
    TempTablesPath = 'C:\Program Files (x86)\PGC_510\Temp'
    ShowUserPasswords = False
    ShowDatabaseCatalogVersions = True
    ServerName = 'EDBSrvr'
    ServerDescription = 'ElevateDB Server'
    ServerAuthorizedAddresses.Strings = (
      '*')
    Left = 48
    Top = 80
  end
  object PGC_Session: TEDBSession
    Connected = True
    LoginUser = 'Operator'
    SessionName = 'PGC_Session_1'
    LocalSignature = 'edb_signature'
    LocalEncryptionPassword = 'elevatesoft'
    LocalConfigPath = 'C:\Program Files (x86)\PGC_510\Data Unicode'
    LocalConfigName = 'EDBConfig'
    LocalConfigExtension = '.EDBCfg'
    LocalLockExtension = '.EDBLck'
    LocalLogExtension = '.EDBLog'
    LocalMaxLogFileSize = 1048576
    LocalLogCategories = [lcInformation, lcWarning, lcError]
    LocalCatalogName = 'EDBDatabase'
    LocalCatalogExtension = '.EDBCat'
    LocalBackupExtension = '.EDBBkp'
    LocalUpdateExtension = '.EDBUpd'
    LocalTableExtension = '.EDBTbl'
    LocalTableIndexExtension = '.EDBIdx'
    LocalTableBlobExtension = '.EDBBlb'
    LocalTablePublishExtension = '.EDBPbl'
    LocalTempTablesPath = 'C:\Users\Alex\AppData\Local\Temp\'
    LocalShowUserPasswords = True
    LocalShowDatabaseCatalogVersions = True
    RemoteSignature = 'edb_signature'
    RemoteEncryptionPassword = 'elevatesoft'
    RemoteAddress = '127.0.0.1'
    BeforeConnect = PGC_SessionBeforeConnect
    Left = 120
    Top = 80
  end
  object PGC_Database: TEDBDatabase
    Connected = True
    DatabaseName = 'PGC_DB_Unicode'
    Database = 'PGC_DB_Main_Unicode'
    SessionName = 'PGC_Session_1'
    Left = 200
    Top = 80
  end
  object tb_Cassa_Cards: TEDBTable
    Active = True
    AfterScroll = tb_Cassa_CardsAfterScroll
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Cards'
    Left = 72
    Top = 216
  end
  object tb_Fees: TEDBTable
    Active = True
    AutoCalcFields = False
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    FieldDefs = <
      item
        Name = 'K'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Fee'
        DataType = ftFloat
      end
      item
        Name = 'Fee_Euro'
        DataType = ftFloat
      end
      item
        Name = 'Fee_Overtime'
        DataType = ftFloat
      end
      item
        Name = 'Fee_Overtime_Euro'
        DataType = ftFloat
      end
      item
        Name = 'Deposit'
        DataType = ftFloat
      end
      item
        Name = 'Deposit_Euro'
        DataType = ftFloat
      end
      item
        Name = 'Reemboursment'
        DataType = ftFloat
      end
      item
        Name = 'Reemboursment_Euro'
        DataType = ftFloat
      end
      item
        Name = 'Enabled'
        DataType = ftBoolean
      end
      item
        Name = 'Icon'
        DataType = ftBlob
      end
      item
        Name = 'StartT'
        DataType = ftTime
      end
      item
        Name = 'EndT'
        DataType = ftTime
      end
      item
        Name = 'TimeSpan2Use'
        DataType = ftSmallint
      end
      item
        Name = 'LifeTimeSpan'
        DataType = ftSmallint
      end
      item
        Name = 'Bonus_Points'
        DataType = ftInteger
      end
      item
        Name = 'Bonus_Days'
        DataType = ftWideString
        Size = 13
      end
      item
        Name = 'Bonus_OnlyNoPromo'
        DataType = ftBoolean
      end
      item
        Name = 'RecLastMod'
        DataType = ftDateTime
      end
      item
        Name = 'CardsFrom'
        DataType = ftInteger
      end
      item
        Name = 'CardsTo'
        DataType = ftInteger
      end
      item
        Name = 'Bonus4CardsFrom'
        DataType = ftInteger
      end
      item
        Name = 'Bonus4CardsTo'
        DataType = ftInteger
      end
      item
        Name = 'DrinkCredits'
        DataType = ftInteger
      end
      item
        Name = 'Only4Reg_Clients'
        DataType = ftBoolean
      end>
    IndexDefs = <
      item
        Name = 'Fees_ID_IDX'
        Fields = 'ID;K'
        Options = [ixPrimary]
      end>
    ReadOnly = True
    TableName = 'Fees'
    StoreDefs = True
    Left = 280
    Top = 272
  end
  object tb_Clienti_Clients: TEDBTable
    Active = True
    AutoCalcFields = False
    AfterInsert = tb_Clienti_ClientsAfterInsert
    AfterScroll = tb_Clienti_ClientsAfterScroll
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Clients'
    Left = 64
    Top = 392
  end
  object tb_Cassa_ClLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    IndexName = 'IDX_ClientID_ClLedger'
    TableName = 'ClLedger'
    Left = 72
    Top = 272
    object tb_Cassa_ClLedgerData: TDateTimeField
      FieldName = 'Data'
    end
    object tb_Cassa_ClLedgerDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object tb_Cassa_ClLedgerDare: TFloatField
      FieldName = 'Dare'
    end
    object tb_Cassa_ClLedgerAvere: TFloatField
      FieldName = 'Avere'
    end
    object tb_Cassa_ClLedgerID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tb_Cassa_ClLedgerClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tb_Cassa_ClLedgerCardID: TIntegerField
      FieldName = 'CardID'
    end
    object tb_Cassa_ClLedgerParentID: TIntegerField
      FieldName = 'ParentID'
    end
    object tb_Cassa_ClLedgerBonusEarned: TFloatField
      FieldName = 'BonusEarned'
    end
    object tb_Cassa_ClLedgerBonusSpent: TFloatField
      FieldName = 'BonusSpent'
    end
  end
  object tb_Chiusura_OpLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'OpLedger'
    Left = 416
    Top = 360
  end
  object tb_Cassa_Services: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Services'
    Left = 176
    Top = 216
    object tb_Cassa_ServicesID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tb_Cassa_ServicesServiceGroup: TWideStringField
      FieldName = 'ServiceGroup'
    end
    object tb_Cassa_ServicesServiceType: TWideStringField
      FieldName = 'ServiceType'
      Size = 15
    end
    object tb_Cassa_ServicesServiceName: TWideStringField
      FieldName = 'ServiceName'
    end
    object tb_Cassa_ServicesFeeID: TSmallintField
      FieldName = 'FeeID'
    end
    object tb_Cassa_ServicesCharge: TBooleanField
      FieldName = 'Charge'
    end
    object tb_Cassa_ServicesActuator: TSmallintField
      FieldName = 'Actuator'
    end
    object tb_Cassa_ServicesCardReader: TSmallintField
      FieldName = 'CardReader'
    end
    object tb_Cassa_ServicesEnabled: TBooleanField
      FieldName = 'Enabled'
    end
    object tb_Cassa_ServicesDoor: TBooleanField
      FieldName = 'Door'
      ReadOnly = True
    end
    object tb_Cassa_ServicesLights: TBooleanField
      FieldName = 'Lights'
      ReadOnly = True
    end
    object tb_Cassa_ServicesProjector: TBooleanField
      FieldName = 'Projector'
      ReadOnly = True
    end
    object tb_Cassa_ServicesAlarm: TBooleanField
      FieldName = 'Alarm'
      ReadOnly = True
    end
    object tb_Cassa_ServicesLastEventDT: TDateTimeField
      FieldName = 'LastEventDT'
    end
    object tb_Cassa_ServicesLastEventDescr: TWideStringField
      FieldName = 'LastEventDescr'
      Size = 30
    end
    object tb_Cassa_ServicesUsedWithoutClean: TSmallintField
      FieldName = 'UsedWithoutClean'
    end
    object tb_Cassa_ServicesCardInID: TSmallintField
      FieldName = 'CardInID'
    end
    object tb_Cassa_ServicesPrivacy: TBooleanField
      FieldName = 'Privacy'
    end
    object tb_Cassa_ServicesLastAlias: TWideStringField
      FieldName = 'LastAlias'
      Size = 15
    end
  end
  object tb_Discounts: TEDBTable
    Active = True
    AfterInsert = tb_DiscountsAfterInsert
    BeforePost = tb_DiscountsBeforePost
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    IndexFieldNames = 'FeeID'
    MasterFields = 'ID'
    MasterSource = Form1.sc_Fees_Edit
    TableName = 'Discounts'
    Left = 544
    Top = 232
    object tb_DiscountsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tb_DiscountsFeeID: TSmallintField
      FieldName = 'FeeID'
    end
    object tb_DiscountsDescription: TWideStringField
      FieldName = 'Description'
      Size = 45
    end
    object tb_DiscountsMon: TBooleanField
      FieldName = 'Mon'
    end
    object tb_DiscountsTue: TBooleanField
      FieldName = 'Tue'
    end
    object tb_DiscountsWed: TBooleanField
      FieldName = 'Wed'
    end
    object tb_DiscountsThu: TBooleanField
      FieldName = 'Thu'
    end
    object tb_DiscountsFri: TBooleanField
      FieldName = 'Fri'
    end
    object tb_DiscountsSat: TBooleanField
      FieldName = 'Sat'
    end
    object tb_DiscountsSun: TBooleanField
      FieldName = 'Sun'
    end
    object tb_DiscountsStartTime: TTimeField
      FieldName = 'StartTime'
    end
    object tb_DiscountsEndTime: TTimeField
      FieldName = 'EndTime'
    end
    object tb_DiscountsHowManyMinutes: TSmallintField
      FieldName = 'HowManyMinutes'
    end
    object tb_DiscountsEnabled: TBooleanField
      FieldName = 'Enabled'
    end
    object tb_DiscountsFrom_Card_ID: TSmallintField
      FieldName = 'From_Card_ID'
    end
    object tb_DiscountsTo_Card_ID: TSmallintField
      FieldName = 'To_Card_ID'
    end
    object tb_DiscountsBonus_Points: TSmallintField
      FieldName = 'Bonus_Points'
    end
    object tb_DiscountsImportoSconto: TFloatField
      FieldName = 'ImportoSconto'
      DisplayFormat = '#,#.00'
    end
    object tb_DiscountsRecCreated: TDateTimeField
      FieldName = 'RecCreated'
    end
    object tb_DiscountsRecLastMod: TDateTimeField
      FieldName = 'RecLastMod'
    end
    object tb_DiscountsOperator: TWideStringField
      FieldName = 'Operator'
    end
    object tb_DiscountsSD_1: TDateField
      FieldName = 'SD_1'
    end
    object tb_DiscountsSD_2: TDateField
      FieldName = 'SD_2'
    end
    object tb_DiscountsSD_3: TDateField
      FieldName = 'SD_3'
    end
    object tb_DiscountsSD_4: TDateField
      FieldName = 'SD_4'
    end
    object tb_DiscountsSD_5: TDateField
      FieldName = 'SD_5'
    end
    object tb_DiscountsSD_6: TDateField
      FieldName = 'SD_6'
    end
    object tb_DiscountsSD_7: TDateField
      FieldName = 'SD_7'
    end
    object tb_DiscountsBonus_DateFrame: TSmallintField
      FieldName = 'Bonus_DateFrame'
    end
    object tb_DiscountsStart_Date: TDateField
      FieldName = 'Start_Date'
    end
    object tb_DiscountsEnd_Date: TDateField
      FieldName = 'End_Date'
    end
  end
  object tb_Fees_Edit: TEDBTable
    Active = True
    AfterInsert = tb_Fees_EditAfterInsert
    BeforePost = tb_Fees_EditBeforePost
    AfterPost = tb_Fees_EditAfterPost
    BeforeDelete = tb_Fees_EditBeforeDelete
    AfterDelete = tb_Fees_EditAfterDelete
    AfterScroll = tb_Fees_EditAfterScroll
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Fees'
    Left = 424
    Top = 232
    object tb_Fees_EditID: TIntegerField
      FieldName = 'ID'
    end
    object tb_Fees_EditDescription: TWideStringField
      Alignment = taCenter
      FieldName = 'Description'
    end
    object tb_Fees_EditFee: TFloatField
      FieldName = 'Fee'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditDeposit: TFloatField
      FieldName = 'Deposit'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditEnabled: TBooleanField
      FieldName = 'Enabled'
    end
    object tb_Fees_EditIcon: TBlobField
      FieldName = 'Icon'
    end
    object tb_Fees_EditStartT: TTimeField
      Alignment = taCenter
      FieldName = 'StartT'
      DisplayFormat = 'hh:nn'
      EditMask = '!90:00;1;_'
    end
    object tb_Fees_EditEndT: TTimeField
      Alignment = taCenter
      FieldName = 'EndT'
      DisplayFormat = 'hh:nn'
      EditMask = '!90:00;1;_'
    end
    object tb_Fees_EditBonus_Points: TIntegerField
      FieldName = 'Bonus_Points'
    end
    object tb_Fees_EditBonus_Days: TWideStringField
      FieldName = 'Bonus_Days'
      Size = 13
    end
    object tb_Fees_EditBonus_OnlyNoPromo: TBooleanField
      FieldName = 'Bonus_OnlyNoPromo'
    end
    object tb_Fees_EditRecLastMod: TDateTimeField
      FieldName = 'RecLastMod'
    end
    object tb_Fees_EditFee_Overtime: TFloatField
      FieldName = 'Fee_Overtime'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditCardsFrom: TIntegerField
      FieldName = 'CardsFrom'
    end
    object tb_Fees_EditCardsTo: TIntegerField
      FieldName = 'CardsTo'
    end
    object tb_Fees_EditBonus4CardsFrom: TIntegerField
      FieldName = 'Bonus4CardsFrom'
    end
    object tb_Fees_EditBonus4CardsTo: TIntegerField
      FieldName = 'Bonus4CardsTo'
    end
    object tb_Fees_EditFee_Euro: TFloatField
      FieldName = 'Fee_Euro'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditFee_Overtime_Euro: TFloatField
      FieldName = 'Fee_Overtime_Euro'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditDeposit_Euro: TFloatField
      FieldName = 'Deposit_Euro'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditOnly4Reg_Clients: TBooleanField
      FieldName = 'Only4Reg_Clients'
    end
    object tb_Fees_EditDrinkCredits: TIntegerField
      FieldName = 'DrinkCredits'
    end
    object tb_Fees_EditLifeTimeSpan: TSmallintField
      FieldName = 'LifeTimeSpan'
    end
    object tb_Fees_EditTimeSpan2Use: TSmallintField
      FieldName = 'TimeSpan2Use'
    end
    object tb_Fees_EditReemboursment: TFloatField
      FieldName = 'Reemboursment'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditReemboursment_Euro: TFloatField
      FieldName = 'Reemboursment_Euro'
      DisplayFormat = '#,#.00'
    end
    object tb_Fees_EditK: TAutoIncField
      FieldName = 'K'
      ReadOnly = True
    end
  end
  object PGC_Query: TEDBQuery
    DatabaseName = 'PGC_DB_Main_Unicode'
    SessionName = 'PGC_Session_1'
    Params = <>
    Left = 280
    Top = 80
  end
  object tb_Clienti_Cards: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Cards'
    Left = 168
    Top = 440
  end
  object tb_ClientHistory: TEDBTable
    Active = True
    AfterInsert = tb_ClientHistoryAfterInsert
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    IndexName = 'Cli_His_IDX'
    MasterFields = 'ID'
    MasterSource = Form1.sc_Clienti_Clients
    TableName = 'ClientHistory'
    Left = 64
    Top = 440
  end
  object tb_Clienti_ClLedger: TEDBTable
    Active = True
    CopyOnAppend = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ClLedger'
    Left = 168
    Top = 384
  end
  object tb_Cassa_Discounts: TEDBTable
    Active = True
    Filter = 'Enabled = True'
    Filtered = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    MasterSource = Form1.sc_Fees
    TableName = 'Discounts'
    Left = 280
    Top = 216
  end
  object tb_ClLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ClLedger'
    Left = 544
    Top = 8
  end
  object sc_ClLedger: TDataSource
    DataSet = tb_ClLedger
    Left = 544
    Top = 72
  end
  object tb_Tessere_Cards: TEDBTable
    Active = True
    AfterScroll = tb_Tessere_CardsAfterScroll
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Cards'
    Left = 656
    Top = 352
  end
  object sc_Tessere_Cards: TDataSource
    DataSet = tb_Tessere_Cards
    Left = 752
    Top = 352
  end
  object sc_Clients: TDataSource
    DataSet = tb_Clients
    Left = 720
    Top = 64
  end
  object tb_Clients: TEDBTable
    Active = True
    AfterInsert = tb_ClientsAfterInsert
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Clients'
    Left = 720
    Top = 8
  end
  object tb_CardsCategories: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'CardCategories'
    Left = 656
    Top = 440
  end
  object OmniEventMonitor1: TOmniEventMonitor
    OnTaskTerminated = OmniEventMonitor1TaskTerminated
    OnTaskUndeliveredMessage = OmniEventMonitor1TaskUndeliveredMessage
    Left = 40
    Top = 8
  end
  object tb_ServicesSold: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ServicesSold'
    Left = 808
    Top = 8
  end
  object sc_ServicesSold: TDataSource
    DataSet = tb_ServicesSold
    Left = 808
    Top = 64
  end
  object tb_Clienti_SS: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    MasterSource = Form1.sc_Clienti_Clients
    TableName = 'ServicesSold'
    Left = 264
    Top = 440
  end
  object tm_CheckLifeTime: TTimer
    Interval = 90000
    OnTimer = tm_CheckLifeTime_Timer
    Left = 136
    Top = 8
  end
  object tb_Services: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Services'
    Left = 632
    Top = 8
  end
  object tb_Cards: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Cards'
    Left = 896
    Top = 64
  end
  object qy_Sentinel: TEDBQuery
    DatabaseName = 'PGC_DB_Unicode'
    Params = <>
    Left = 784
    Top = 280
  end
  object tb_Sentinel_Services: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Services'
    Left = 672
    Top = 224
  end
  object tb_Sentinel_SS: TEDBTable
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    Left = 784
    Top = 224
  end
  object tb_CleanLog: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'CleanLog'
    Left = 896
    Top = 8
  end
  object tb_Personale_Personnel: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Personnel'
    Left = 424
    Top = 520
  end
  object tb_Personale_PerHis: TEDBTable
    Active = True
    AfterInsert = tb_Personale_PerHisAfterInsert
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    IndexName = 'PerHisAvsIDX'
    MasterFields = 'AVS'
    MasterSource = Form1.sc_Personale_Personnel
    TableName = 'PersonnelHistory'
    Left = 424
    Top = 584
  end
  object PGC_QuerySC: TDataSource
    Left = 360
    Top = 80
  end
  object tb_Cassa_SS: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ServicesSold'
    Left = 168
    Top = 272
  end
  object tb_Manut_Services: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Services'
    Left = 88
    Top = 528
  end
  object tb_Manut_SMaintenance: TEDBTable
    Active = True
    AfterInsert = tb_Manut_SMaintenanceAfterInsert
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    IndexName = 'SID_IDX'
    MasterFields = 'ID'
    MasterSource = Form1.sc_Manut_Services
    TableName = 'ServicesMaintenance'
    Left = 240
    Top = 528
  end
  object tb_Clienti_ClientsRoster: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Clients'
    Left = 112
    Top = 344
  end
  object tb_Tessere_SS: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    MasterSource = sc_Tessere_Cards
    TableName = 'ServicesSold'
    Left = 656
    Top = 400
  end
  object sc_Tessere_SS: TDataSource
    DataSet = tb_Tessere_SS
    Left = 752
    Top = 400
  end
  object tb_Anomalies: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Anomalies'
    Left = 648
    Top = 520
  end
  object sc_Anomalies: TDataSource
    DataSet = tb_Anomalies
    Left = 760
    Top = 520
  end
  object tb_Chiusura_ExpLedger: TEDBTable
    Active = True
    BeforeInsert = tb_Chiusura_ExpLedgerBeforeInsert
    AfterInsert = tb_Chiusura_ExpLedgerAfterInsert
    BeforeEdit = tb_Chiusura_ExpLedgerBeforeEdit
    AfterPost = tb_Chiusura_ExpLedgerAfterPost
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ExpLedger'
    Left = 416
    Top = 424
  end
  object tb_OpLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'OpLedger'
    Left = 456
    Top = 8
  end
  object sc_OpLedger: TDataSource
    DataSet = tb_OpLedger
    Left = 456
    Top = 72
  end
  object OpLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'OpLedger'
    Left = 528
    Top = 144
  end
  object s_OpLedger: TDataSource
    DataSet = OpLedger
    Left = 624
    Top = 144
  end
  object sl_Clienti_ClLedger: TDBSumList
    DataSet = tb_Clienti_ClLedger
    ExternalRecalc = False
    SumCollection = <
      item
        FieldName = 'Dare'
        GroupOperation = goSum
      end
      item
        FieldName = 'Avere'
        GroupOperation = goSum
      end>
    VirtualRecords = False
    SumListChanged = sl_Clienti_ClLedgerSumListChanged
    Left = 256
    Top = 376
  end
end
