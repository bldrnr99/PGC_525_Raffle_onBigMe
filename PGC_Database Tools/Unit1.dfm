object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 653
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EDBEngine1: TEDBEngine
    Active = True
    EngineType = etClient
    Signature = 'edb_signature'
    EncryptionPassword = 'elevatesoft'
    LicensedSessions = 4096
    ConfigPath = 'C:\Program Files (x86)\PGC_510\Data Unicode\DB Tools Temp'
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
    TempTablesPath = 'C:\Program Files (x86)\PGC_510\Data Unicode\DB Tools Temp'
    ShowUserPasswords = True
    ShowDatabaseCatalogVersions = True
    ServerName = 'EDBSrvr'
    ServerDescription = 'ElevateDB Server'
    ServerAuthorizedAddresses.Strings = (
      '*')
    Left = 32
    Top = 8
  end
  object PGC_DB_Tools_Session: TEDBSession
    Connected = True
    LoginUser = 'Operator'
    LoginPassword = '1234'
    SessionName = 'PGC_510_Unicode'
    LocalSignature = 'edb_signature'
    LocalEncryptionPassword = 'elevatesoft'
    LocalConfigPath = 'C:\Program Files (x86)\PGC_510\Data Unicode\Temp'
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
    LocalTempTablesPath = 'C:\Program Files (x86)\PGC_510\Data Unicode\DB Tools Temp'
    LocalShowUserPasswords = True
    LocalShowDatabaseCatalogVersions = True
    RemoteSignature = 'edb_signature'
    RemoteEncryptionPassword = 'elevatesoft'
    RemoteAddress = '127.0.0.1'
    Left = 144
    Top = 8
  end
  object EDBDatabase1: TEDBDatabase
    DatabaseName = 'PGC_DB_Main_Unicode'
    SessionName = 'Default'
    Left = 312
    Top = 8
  end
end
