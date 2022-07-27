object DMConnection: TDMConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 64
  Width = 337
  object ZConnectionSQLite: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    AutoEncodeStrings = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 144
    Top = 8
  end
  object ZConnectionPostgreSQL: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    AutoEncodeStrings = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 256
    Top = 8
  end
  object ZConnectionFirebird: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    AutoEncodeStrings = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 40
    Top = 8
  end
end
