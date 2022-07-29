object DMConnection: TDMConnection
  OldCreateOrder = False
  Height = 75
  Width = 92
  object ZConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    BeforeConnect = ZConnectionBeforeConnect
    AutoEncodeStrings = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 32
    Top = 16
  end
end
