inherited frmuGrao: TfrmuGrao
  ActiveControl = grdCadastro
  Caption = 'frmGrao'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited pcCadastro: TPageControl
    inherited tsCadastro: TTabSheet
      object lbCódigo: TLabel
        Left = 16
        Top = 11
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
      end
      object lbNome: TLabel
        Left = 16
        Top = 69
        Width = 78
        Height = 15
        Caption = 'Nome do Gr'#227'o'
      end
      object edCódigo: TDBEdit
        Left = 16
        Top = 32
        Width = 49
        Height = 23
        TabStop = False
        DataField = 'ID'
        DataSource = dsCadastro
        Enabled = False
        TabOrder = 0
      end
      object edNome: TDBEdit
        Left = 16
        Top = 90
        Width = 345
        Height = 23
        DataField = 'NOME'
        DataSource = dsCadastro
        TabOrder = 1
      end
    end
  end
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited pnTextoConsulta: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lbConsultar: TLabel
      Height = 16
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited edConsulta: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited Panel3: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited btExcluir: TButton
      ExplicitLeft = 227
    end
    inherited btConsultar: TButton
      ExplicitLeft = 416
    end
    inherited btImprimir: TButton
      ExplicitLeft = 491
      ExplicitTop = 1
    end
  end
  inherited qrCadastro: TFDQuery
    SQL.Strings = (
      'select * from Grao')
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
end
