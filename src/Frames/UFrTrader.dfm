object FrTrader: TFrTrader
  Left = 0
  Top = 0
  Width = 583
  Height = 454
  Align = alClient
  TabOrder = 0
  object Label18: TLabel
    Left = 0
    Top = 0
    Width = 583
    Height = 20
    Align = alTop
    Alignment = taCenter
    Caption = 'Cadastro Trader'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 114
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 252
    Width = 577
    Height = 20
    Margins.Top = 15
    Align = alTop
    Caption = 'Traders cadastrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 142
  end
  object Panel9: TPanel
    Left = 0
    Top = 197
    Width = 583
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 4
    object btnCadastrarTrader: TButton
      Left = 0
      Top = 0
      Width = 161
      Height = 40
      Align = alLeft
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCadastrarTraderClick
    end
  end
  object Panel8: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 164
    Width = 577
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 3
    object Label6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 291
      Height = 24
      Align = alLeft
      Caption = 'Total de armazenamento dos silos em kg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtArmazenamentoSilosKg: TEdit
      AlignWithMargins = True
      Left = 300
      Top = 0
      Width = 173
      Height = 27
      Margins.Top = 0
      Align = alLeft
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      ExplicitHeight = 30
    end
  end
  object Panel7: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 121
    Width = 577
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 2
    object Label5: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 139
      Height = 24
      Align = alLeft
      Caption = 'Quantidade de silos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object spQtdeSilos: TSpinEdit
      AlignWithMargins = True
      Left = 148
      Top = 0
      Width = 69
      Height = 28
      Margins.Top = 0
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 100000
      MaxValue = 410065408
      MinValue = 0
      ParentFont = False
      TabOrder = 0
      Value = 0
      OnChange = spQtdeSilosChange
    end
  end
  object Panel6: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 78
    Width = 577
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 1
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 112
      Height = 24
      Align = alLeft
      Caption = 'Nome do trader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtNomeTrader: TEdit
      AlignWithMargins = True
      Left = 121
      Top = 0
      Width = 453
      Height = 27
      Margins.Top = 0
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 30
    end
  end
  object Panel5: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 35
    Width = 577
    Height = 30
    Margins.Top = 15
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 0
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 107
      Height = 24
      Margins.Right = 8
      Align = alLeft
      Caption = 'CNPJ do trader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtCNPJTrader: TMaskEdit
      AlignWithMargins = True
      Left = 121
      Top = 0
      Width = 229
      Height = 27
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
  object dbGridTrader: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 278
    Width = 577
    Height = 173
    Align = alClient
    DataSource = dscGridTrader
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = 20
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = 20
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = 20
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = 20
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = True
      end>
  end
  object dscGridTrader: TDataSource
    Left = 400
    Top = 288
  end
end
