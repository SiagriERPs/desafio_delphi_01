object FrProdutor: TFrProdutor
  Left = 0
  Top = 0
  Width = 614
  Height = 511
  Align = alClient
  TabOrder = 0
  object Label17: TLabel
    Left = 0
    Top = 0
    Width = 614
    Height = 22
    Align = alTop
    Alignment = taCenter
    Caption = 'Cadastro de produtor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 22
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 168
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 168
    Width = 608
    Height = 20
    Margins.Top = 15
    Align = alTop
    Caption = 'Produtores cadastrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 165
  end
  object Panel4: TPanel
    Left = 0
    Top = 113
    Width = 614
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel4'
    ShowCaption = False
    TabOrder = 2
    object btnCadastrarProdutor: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 158
      Height = 34
      Align = alLeft
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCadastrarProdutorClick
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 80
    Width = 608
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 132
      Height = 24
      Align = alLeft
      Caption = 'Nome do produtor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtNomeProdutor: TEdit
      Left = 138
      Top = 0
      Width = 470
      Height = 30
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 608
    Height = 30
    Margins.Top = 15
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 127
      Height = 24
      Margins.Right = 5
      Align = alLeft
      Caption = 'CNPJ do produtor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtCNPJProdutor: TMaskEdit
      AlignWithMargins = True
      Left = 138
      Top = 0
      Width = 229
      Height = 27
      Hint = 'CNPJ do produtor'
      Margins.Top = 0
      Align = alLeft
      Alignment = taCenter
      EditMask = '99.999.999/9999-99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 18
      ParentFont = False
      TabOrder = 0
      Text = '  .   .   /    -  '
      ExplicitHeight = 30
    end
  end
  object dbGridProdutor: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 194
    Width = 608
    Height = 314
    Align = alClient
    DataSource = dscGridProdutor
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = 20
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end>
  end
  object dscGridProdutor: TDataSource
    Left = 296
    Top = 240
  end
end
