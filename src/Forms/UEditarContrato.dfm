object FmEditarContrato: TFmEditarContrato
  Left = 0
  Top = 0
  Caption = 'Editar contrato'
  ClientHeight = 411
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    AlignWithMargins = True
    Left = 9
    Top = 270
    Width = 526
    Height = 20
    Margins.Left = 9
    Margins.Top = 50
    Align = alTop
    Caption = 'Respons'#225'vel pelo armazenamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 240
  end
  object Panel12: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 15
    Width = 532
    Height = 30
    Margins.Top = 15
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 0
    object Label9: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 127
      Height = 24
      Margins.Right = 8
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
    object edtContratoCNPJProdutor: TMaskEdit
      Left = 138
      Top = 0
      Width = 229
      Height = 30
      Align = alLeft
      Alignment = taCenter
      Enabled = False
      EditMask = '99.999.999/9999-99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 18
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '  .   .   /    -  '
    end
  end
  object Panel10: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 532
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 1
    object Label10: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 132
      Height = 24
      Align = alLeft
      Caption = 'Nome do Produtor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtContratoNomeProdutor: TEdit
      Left = 138
      Top = 0
      Width = 394
      Height = 30
      Align = alClient
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel11: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 101
    Width = 532
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 2
    object Label11: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 126
      Height = 24
      Margins.Right = 9
      Align = alLeft
      Caption = 'Nome do produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtContratoNomeProduto: TEdit
      Left = 138
      Top = 0
      Width = 394
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
  object Panel13: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 144
    Width = 532
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 3
    object Label12: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 92
      Height = 24
      Align = alLeft
      Caption = 'Tipo do gr'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtContratoTipoGrao: TComboBox
      Left = 98
      Top = 0
      Width = 226
      Height = 30
      Align = alLeft
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Soja amarela'
      Items.Strings = (
        'Soja amarela'
        'Soja edamame '
        'Soja preta')
    end
  end
  object Panel14: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 187
    Width = 532
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 4
    object Label13: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 164
      Height = 24
      Align = alLeft
      Caption = 'Quantidade do gr'#227'o Kg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtContratoQtdeGrao: TEdit
      Left = 170
      Top = 0
      Width = 128
      Height = 30
      Align = alLeft
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 9999999
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
  end
  object Panel15: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 303
    Width = 532
    Height = 30
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 5
    object Label15: TLabel
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
    object edtContratoCNPJTrader: TMaskEdit
      Left = 118
      Top = 0
      Width = 229
      Height = 30
      Align = alLeft
      Enabled = False
      EditMask = '99.999.999/9999-99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 18
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '  .   .   /    -  '
      ExplicitLeft = 95
    end
  end
  object Panel16: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 339
    Width = 532
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 6
    object Label16: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 89
      Height = 24
      Align = alLeft
      Caption = 'Nome trader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 20
    end
    object edtContratoNomeTrader: TEdit
      Left = 95
      Top = 0
      Width = 437
      Height = 30
      Align = alClient
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel17: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 375
    Width = 532
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel10'
    ShowCaption = False
    TabOrder = 7
    object btnCadastrarContrato: TButton
      Left = 0
      Top = 0
      Width = 128
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
      OnClick = btnCadastrarContratoClick
    end
  end
end
