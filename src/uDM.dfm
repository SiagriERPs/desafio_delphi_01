object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 254
  Width = 176
  object con: TFDConnection
    Params.Strings = (
      
        'Database=C:\DSV\Delphi\ProjetoTrade\desafio_delphi_01\data\DBTRA' +
        'DE.FDB'
      'DriverID=FB'
      'Password=masterkey'
      'Server=127.0.0.1'
      'User_Name=SYSDBA'
      'Port=3050')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object conDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_1\bin\fbclient.dll'
    Left = 64
    Top = 88
  end
  object ConWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 152
  end
end
