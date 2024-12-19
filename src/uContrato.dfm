inherited frmContrato: TfrmContrato
  Caption = 'Contratos de Armazenamento de Gr'#227'os'
  ClientWidth = 720
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 736
  TextHeight = 15
  inherited pcCadastro: TPageControl
    Width = 720
    ExplicitWidth = 720
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 712
      inherited grdCadastro: TDBGrid
        Width = 712
      end
    end
    inherited tsCadastro: TTabSheet
      ExplicitWidth = 712
      object lbIdContrato: TLabel
        Left = 16
        Top = 16
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
        FocusControl = edIdContrato
      end
      object lbProdutor: TLabel
        Left = 16
        Top = 64
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
        FocusControl = edIdProdutor
      end
      object lbTrade: TLabel
        Left = 16
        Top = 112
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
        FocusControl = edIdTrade
      end
      object lbGrao: TLabel
        Left = 16
        Top = 160
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
        FocusControl = edIdGrao
      end
      object lbQuantidade: TLabel
        Left = 16
        Top = 208
        Width = 87
        Height = 15
        Caption = 'Quantidade (Kg)'
        FocusControl = edIdQuantidade
      end
      object lbEmissao: TLabel
        Left = 131
        Top = 16
        Width = 70
        Height = 15
        Caption = 'Data Emiss'#227'o'
        FocusControl = edDataEmissao
      end
      object lbVigencia: TLabel
        Left = 307
        Top = 16
        Width = 45
        Height = 15
        Caption = 'Vig'#234'ncia'
        FocusControl = edDataVigencia
      end
      object lbNomeProdutor: TLabel
        Left = 59
        Top = 64
        Width = 47
        Height = 15
        Caption = 'Produtor'
      end
      object lbNomeTrade: TLabel
        Left = 59
        Top = 112
        Width = 28
        Height = 15
        Caption = 'Trade'
      end
      object lbNomeGrao: TLabel
        Left = 59
        Top = 160
        Width = 25
        Height = 15
        Caption = 'Gr'#227'o'
      end
      object Label1: TLabel
        Left = 483
        Top = 5
        Width = 120
        Height = 15
        Caption = 'Silos de Armazenagem'
      end
      object edIdContrato: TDBEdit
        Left = 16
        Top = 32
        Width = 87
        Height = 23
        DataField = 'ID'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 0
      end
      object edIdProdutor: TDBEdit
        Left = 16
        Top = 80
        Width = 39
        Height = 23
        DataField = 'IDPRODUTOR'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 1
      end
      object edIdTrade: TDBEdit
        Left = 16
        Top = 128
        Width = 38
        Height = 23
        DataField = 'IDTRADE'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 2
      end
      object edIdGrao: TDBEdit
        Left = 16
        Top = 176
        Width = 39
        Height = 23
        DataField = 'IDGRAO'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 3
      end
      object edIdQuantidade: TDBEdit
        Left = 16
        Top = 224
        Width = 87
        Height = 23
        Hint = 'M'#225'x. permitido: 99.999,999'
        DataField = 'QUANTIDADE'
        DataSource = dsCadastro
        MaxLength = 9
        TabOrder = 4
        TextHint = '99999,999'
      end
      object edDataEmissao: TDBEdit
        Left = 131
        Top = 32
        Width = 169
        Height = 23
        DataField = 'DTEMISSAO'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 5
      end
      object edDataVigencia: TDBEdit
        Left = 307
        Top = 32
        Width = 169
        Height = 23
        DataField = 'DTVIGENCIA'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 6
      end
      object grdSilos: TDBGrid
        Left = 483
        Top = 26
        Width = 226
        Height = 290
        Anchors = [akTop, akRight, akBottom]
        DataSource = dsSilo
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
      object edNomeProdutor: TDBLookupComboBox
        Left = 59
        Top = 80
        Width = 417
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'IDPRODUTOR'
        DataSource = dsCadastro
        KeyField = 'ID'
        ListField = 'NOME'
        ListSource = dsProdutor
        TabOrder = 8
      end
      object edTrade: TDBLookupComboBox
        Left = 60
        Top = 128
        Width = 417
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'IDTRADE'
        DataSource = dsCadastro
        KeyField = 'ID'
        ListField = 'NOME'
        ListSource = dsTrade
        TabOrder = 9
      end
      object edGrao: TDBLookupComboBox
        Left = 59
        Top = 176
        Width = 417
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'IDGRAO'
        DataSource = dsCadastro
        KeyField = 'ID'
        ListField = 'NOME'
        ListSource = dsGrao
        TabOrder = 10
      end
    end
  end
  inherited pnFiltro: TPanel
    Width = 720
    Visible = True
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 720
    inherited rgFiltro: TRadioGroup
      Width = 718
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'CNPJ Produtor'
        'CNPJ Trade')
      ExplicitWidth = 718
    end
  end
  inherited pnTextoConsulta: TPanel
    Width = 720
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 720
    inherited lbConsultar: TLabel
      Height = 16
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited edConsulta: TEdit
      Width = 643
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 643
    end
  end
  inherited Panel3: TPanel
    Width = 720
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 720
    inherited btFechar: TButton
      Left = 644
      ExplicitLeft = 644
    end
    inherited btExcluir: TButton
      Visible = False
    end
    inherited btConsultar: TButton
      Left = 494
      ExplicitLeft = 494
    end
    inherited btImprimir: TButton
      Left = 569
      ExplicitLeft = 569
    end
  end
  inherited qrCadastro: TFDQuery
    AfterPost = qrCadastroAfterPost
    SQL.Strings = (
      
        'select c.*, p.cnpj CNPJ_P, p.nome nmProdutor, t.cnpj CNPJ_T, t.n' +
        'ome nmTrade, g.nome nmGrao from Contrato c'
      'join produtor p on p.id = c.idprodutor'
      'join trade t on t.id = c.idtrade'
      'join grao g on g.id = c.idgrao'
      'order by p.nome')
    Left = 456
    object qrCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 7
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrCadastroIDPRODUTOR: TIntegerField
      FieldName = 'IDPRODUTOR'
      Origin = 'IDPRODUTOR'
      Required = True
      Visible = False
    end
    object qrCadastroIDTRADE: TIntegerField
      FieldName = 'IDTRADE'
      Origin = 'IDTRADE'
      Required = True
      Visible = False
    end
    object qrCadastroIDGRAO: TIntegerField
      FieldName = 'IDGRAO'
      Origin = 'IDGRAO'
      Required = True
      Visible = False
    end
    object qrCadastroCNPJ_P: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CNPJ Prod.'
      DisplayWidth = 19
      FieldName = 'CNPJ_P'
      Origin = 'CNPJ'
      ProviderFlags = []
      ReadOnly = True
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object qrCadastroNMPRODUTOR: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produtor'
      DisplayWidth = 22
      FieldName = 'NMPRODUTOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qrCadastroCNPJ_T: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CNPJ Trade'
      DisplayWidth = 18
      FieldName = 'CNPJ_T'
      Origin = 'CNPJ'
      ProviderFlags = []
      ReadOnly = True
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object qrCadastroNMTRADE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Trade'
      DisplayWidth = 33
      FieldName = 'NMTRADE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qrCadastroNMGRAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Gr'#227'o'
      DisplayWidth = 10
      FieldName = 'NMGRAO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qrCadastroQUANTIDADE: TCurrencyField
      DisplayLabel = 'Quantidade (Kg)'
      DisplayWidth = 9
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
      DisplayFormat = '00,000.000'
      EditFormat = '99,999.999;0;_'
      currency = False
      Precision = 3
    end
    object qrCadastroDTEMISSAO: TSQLTimeStampField
      DisplayLabel = 'Data Emiss'#227'o'
      DisplayWidth = 18
      FieldName = 'DTEMISSAO'
      Origin = 'DTEMISSAO'
    end
    object qrCadastroDTVIGENCIA: TSQLTimeStampField
      DisplayLabel = 'Vig'#234'ncia'
      DisplayWidth = 19
      FieldName = 'DTVIGENCIA'
      Origin = 'DTVIGENCIA'
    end
    object qrCadastrolkpProdutor: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'lkpProdutor'
      LookupDataSet = qrProdutor
      LookupKeyFields = 'ID'
      LookupResultField = 'NOME'
      KeyFields = 'IDPRODUTOR'
      Visible = False
      Size = 50
      Lookup = True
    end
    object qrCadastrolkpTrade: TStringField
      DisplayWidth = 34
      FieldKind = fkLookup
      FieldName = 'lkpTrade'
      LookupDataSet = qrTrade
      LookupKeyFields = 'ID'
      LookupResultField = 'NOME'
      KeyFields = 'IDTRADE'
      Visible = False
      Size = 50
      Lookup = True
    end
    object qrCadastrolkpGrao: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'lkpGrao'
      LookupDataSet = qrGrao
      LookupKeyFields = 'ID'
      LookupResultField = 'NOME'
      KeyFields = 'IDGRAO'
      Visible = False
      Size = 50
      Lookup = True
    end
  end
  inherited dsCadastro: TDataSource
    OnDataChange = dsCadastroDataChange
    Left = 456
    Top = 144
  end
  object qrSilo: TFDQuery
    DetailFields = 'IDCONTRATO;IDENTIFICADOR;IDTRADE;QUANTIDADE'
    Connection = DM.con
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select * from silo'
      '')
    Left = 472
    Top = 280
    object qrSiloQUANTIDADE: TCurrencyField
      DisplayLabel = 'Quantidade (Kg)'
      DisplayWidth = 14
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      DisplayFormat = '#,000.000'
    end
    object qrSiloIDCONTRATO: TIntegerField
      DisplayLabel = 'Contrato'
      DisplayWidth = 7
      FieldName = 'IDCONTRATO'
      Origin = 'IDCONTRATO'
      Required = True
    end
    object qrSiloIDTRADE: TIntegerField
      DisplayLabel = 'Trade'
      DisplayWidth = 4
      FieldName = 'IDTRADE'
      Origin = 'IDTRADE'
      Required = True
    end
    object qrSiloIDENTIFICADOR: TStringField
      DisplayLabel = 'Identificador'
      DisplayWidth = 20
      FieldName = 'IDENTIFICADOR'
      Origin = 'IDENTIFICADOR'
    end
  end
  object dsSilo: TDataSource
    DataSet = qrSilo
    Left = 472
    Top = 336
  end
  object qrProdutor: TFDQuery
    Active = True
    MasterSource = dsCadastro
    MasterFields = 'IDTRADE;IDPRODUTOR;ID'
    Connection = DM.con
    SQL.Strings = (
      'select * from Produtor')
    Left = 376
    Top = 272
    object qrProdutorID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrProdutorCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qrProdutorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
  end
  object dsProdutor: TDataSource
    DataSet = qrProdutor
    Left = 376
    Top = 328
  end
  object qrTrade: TFDQuery
    Active = True
    MasterSource = dsCadastro
    MasterFields = 'IDTRADE;IDPRODUTOR;ID'
    Connection = DM.con
    SQL.Strings = (
      'select * from Trade')
    Left = 304
    Top = 272
    object qrTradeID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrTradeCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qrTradeNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
  end
  object dsTrade: TDataSource
    DataSet = qrTrade
    Left = 304
    Top = 328
  end
  object qrGrao: TFDQuery
    Active = True
    MasterSource = dsCadastro
    MasterFields = 'IDTRADE;IDPRODUTOR;ID'
    Connection = DM.con
    SQL.Strings = (
      'select * from Grao')
    Left = 232
    Top = 272
    object qrGraoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrGraoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
  end
  object dsGrao: TDataSource
    DataSet = qrGrao
    Left = 232
    Top = 328
  end
end
