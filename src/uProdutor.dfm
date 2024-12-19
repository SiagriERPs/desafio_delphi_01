inherited frmProdutor: TfrmProdutor
  Caption = 'Produtores de Gr'#227'os'
  ClientHeight = 294
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 333
  TextHeight = 15
  inherited pcCadastro: TPageControl
    Height = 182
    ActivePage = tsConsulta
    inherited tsConsulta: TTabSheet
      ExplicitHeight = 172
      inherited grdCadastro: TDBGrid
        Height = 172
      end
    end
    inherited tsCadastro: TTabSheet
      ExplicitHeight = 172
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
        FocusControl = edId
      end
      object Label2: TLabel
        Left = 16
        Top = 64
        Width = 27
        Height = 15
        Caption = 'CNPJ'
        FocusControl = edCNPJ
      end
      object Label3: TLabel
        Left = 16
        Top = 112
        Width = 33
        Height = 15
        Caption = 'Nome'
        FocusControl = edNome
      end
      object edId: TDBEdit
        Left = 16
        Top = 32
        Width = 154
        Height = 23
        DataField = 'ID'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 0
      end
      object edCNPJ: TDBEdit
        Left = 16
        Top = 80
        Width = 214
        Height = 23
        DataField = 'CNPJ'
        DataSource = dsCadastro
        MaxLength = 18
        TabOrder = 1
      end
      object edNome: TDBEdit
        Left = 16
        Top = 128
        Width = 609
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'NOME'
        DataSource = dsCadastro
        TabOrder = 2
      end
    end
  end
  inherited pnFiltro: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited pnTextoConsulta: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lbConsultar: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited edConsulta: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited Panel3: TPanel
    Top = 263
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited qrCadastro: TFDQuery
    Active = True
    SQL.Strings = (
      'select * from Produtor')
    Left = 600
    object qrCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrCadastroCNPJ: TStringField
      DisplayWidth = 18
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object qrCadastroNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
  end
  inherited dsCadastro: TDataSource
    Left = 600
    Top = 144
  end
end
