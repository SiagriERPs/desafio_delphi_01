inherited frmGrao: TfrmGrao
  Caption = 'Gr'#227'os'
  ClientHeight = 249
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 288
  TextHeight = 15
  inherited pcCadastro: TPageControl
    Height = 137
    inherited tsConsulta: TTabSheet
      ExplicitHeight = 127
      inherited grdCadastro: TDBGrid
        Height = 127
      end
    end
    inherited tsCadastro: TTabSheet
      ExplicitHeight = 127
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
        Width = 78
        Height = 15
        Caption = 'Nome do Gr'#227'o'
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
      object edNome: TDBEdit
        Left = 16
        Top = 80
        Width = 609
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'NOME'
        DataSource = dsCadastro
        TabOrder = 1
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
    Top = 218
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited qrCadastro: TFDQuery
    SQL.Strings = (
      'select * from Grao')
    Left = 600
    Top = 72
    object qrCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrCadastroNOME: TStringField
      DisplayLabel = 'Nome do Gr'#227'o'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
  end
  inherited dsCadastro: TDataSource
    Left = 600
    Top = 120
  end
end
