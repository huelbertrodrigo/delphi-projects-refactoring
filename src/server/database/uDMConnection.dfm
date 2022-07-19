object DMConnection: TDMConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object ZConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    AutoEncodeStrings = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 88
    Top = 56
  end
end
