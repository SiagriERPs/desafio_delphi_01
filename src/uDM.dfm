object DM: TDM
  OldCreateOrder = False
  Height = 404
  Width = 675
  object Conexao: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Aliare\desafio_delphi_01\data\DBALIARE.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    AllowStreamedConnected = False
    Left = 80
    Top = 32
  end
  object Trans: TIBTransaction
    DefaultDatabase = Conexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 24
  end
  object qryGlobal: TIBQuery
    Database = Conexao
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 216
    Top = 88
  end
  object qryGraos: TIBQuery
    Database = Conexao
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from grao')
    Left = 328
    Top = 32
    object qryGraosID: TIntegerField
      FieldName = 'ID'
      Origin = 'GRAO.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryGraosDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'GRAO.DESCRICAO'
      Size = 100
    end
    object qryGraosSTATUS: TIBStringField
      FieldName = 'STATUS'
      Origin = 'GRAO.STATUS'
      Size = 15
    end
  end
  object dsGraos: TDataSource
    DataSet = qryGraos
    Left = 384
    Top = 32
  end
end
