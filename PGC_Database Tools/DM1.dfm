object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Data Module'
  ClientHeight = 682
  ClientWidth = 1240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TShape
    Left = 32
    Top = 23
    Width = 433
    Height = 634
  end
  object EDBEngine1: TEDBEngine
    Active = True
    EngineType = etClient
    Signature = 'edb_signature'
    EncryptionPassword = 'elevatesoft'
    ExclusiveFileAccess = True
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
    Left = 56
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
    LocalTempTablesPath = 'C:\Program Files (x86)\PGC_510\Temp'
    LocalShowUserPasswords = False
    LocalShowDatabaseCatalogVersions = True
    RemoteSignature = 'edb_signature'
    RemoteEncryptionPassword = 'elevatesoft'
    RemoteAddress = '127.0.0.1'
    BeforeConnect = PGC_SessionBeforeConnect
    OnStatusMessage = PGC_SessionStatusMessage
    Left = 120
    Top = 80
  end
  object PGC_Database: TEDBDatabase
    Connected = True
    DatabaseName = 'PGC_DB_Unicode'
    Database = 'PGC_DB_Main_Unicode'
    SessionName = 'PGC_Session_1'
    OnProgress = PGC_DatabaseProgress
    OnStatusMessage = PGC_DatabaseStatusMessage
    OnLogMessage = PGC_DatabaseLogMessage
    Left = 200
    Top = 80
  end
  object tb_Anomalies: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Anomalies'
    Left = 104
    Top = 152
  end
  object tb_CardCategories: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'CardCategories'
    Left = 104
    Top = 200
  end
  object tb_Cards: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Cards'
    Left = 104
    Top = 256
  end
  object tb_CleanLog: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'CleanLog'
    Left = 104
    Top = 312
  end
  object tb_ClientHistory: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ClientHistory'
    Left = 104
    Top = 368
  end
  object tb_Clients: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Clients'
    Left = 104
    Top = 432
  end
  object tb_ClLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ClLedger'
    Left = 104
    Top = 496
  end
  object tb_Discounts: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Discounts'
    Left = 104
    Top = 552
  end
  object tb_ExpLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ExpLedger'
    Left = 96
    Top = 608
  end
  object tb_Fees: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Fees'
    Left = 296
    Top = 152
  end
  object tb_Operators: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Operators'
    Left = 296
    Top = 208
  end
  object tb_OpLedger: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'OpLedger'
    Left = 288
    Top = 264
  end
  object tb_Pecuniam: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Pecuniam'
    Left = 288
    Top = 328
  end
  object tb_Personnel: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Personnel'
    Left = 288
    Top = 384
  end
  object tb_PersonnelHistory: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'PersonnelHistory'
    Left = 280
    Top = 440
  end
  object tb_ReceiptText: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ReceiptText'
    Left = 280
    Top = 496
  end
  object tb_Services: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'Services'
    Left = 280
    Top = 552
  end
  object tb_ServicesMaintenance: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ServicesMaintenance'
    Left = 280
    Top = 608
  end
  object tb_SS: TEDBTable
    Active = True
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    TableName = 'ServicesSold'
    Left = 368
    Top = 584
  end
  object PGC_Query: TEDBQuery
    DatabaseName = 'PGC_DB_Unicode'
    SessionName = 'PGC_Session_1'
    Params = <>
    Left = 280
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = tb_OpLedger
    Left = 376
    Top = 152
  end
end
