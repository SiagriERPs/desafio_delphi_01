object frmGraoCons: TfrmGraoCons
  Left = 0
  Top = 0
  Caption = 'Consulta de Cadastro de Gr'#227'os'
  ClientHeight = 380
  ClientWidth = 556
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    556
    380)
  PixelsPerInch = 96
  TextHeight = 16
  object grp_Filtros: TGroupBox
    Left = 8
    Top = 8
    Width = 540
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Filtros'
    TabOrder = 0
    ExplicitWidth = 673
    object lbl_Tipo: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 16
      Caption = 'Tipo'
    end
    object lbl_Filtro: TLabel
      Left = 159
      Top = 16
      Width = 58
      Height = 16
      Caption = 'Descri'#231#227'o'
    end
    object lbl_Status: TLabel
      Left = 431
      Top = 16
      Width = 38
      Height = 16
      Caption = 'Status'
    end
    object txt_Filtro: TEdit
      Left = 159
      Top = 34
      Width = 266
      Height = 24
      Hint = 'Informe o Nome do Seu Gr'#227'o'
      Align = alCustom
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object cbo_Tipo: TComboBox
      Left = 8
      Top = 34
      Width = 145
      Height = 24
      ItemIndex = 1
      TabOrder = 1
      Text = 'Descri'#231#227'o'
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
    end
    object cbo_Status: TComboBox
      Left = 431
      Top = 34
      Width = 106
      Height = 24
      ItemIndex = 0
      TabOrder = 2
      Text = 'Geral'
      Items.Strings = (
        'Geral'
        'Ativo'
        'Inativo')
    end
  end
  object grp_ListaGraos: TGroupBox
    Left = 8
    Top = 79
    Width = 540
    Height = 262
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Lista Gr'#227'os'
    TabOrder = 1
    ExplicitWidth = 673
    object lbl_Info: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 243
      Width = 530
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Para Altera'#231#227'o Duplo Click no Registro do Lista'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 225
    end
    object lbl_Legenda: TLabel
      Left = 494
      Top = 3
      Width = 36
      Height = 16
      Caption = 'Inativo'
    end
    object grd_ListaGraos: TDBGrid
      Left = 2
      Top = 18
      Width = 536
      Height = 222
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
    end
    object pnl_CorLegenda: TPanel
      Left = 473
      Top = 3
      Width = 17
      Height = 15
      Color = clRed
      ParentBackground = False
      TabOrder = 1
    end
  end
  object btn_Salvar: TButton
    Left = 8
    Top = 347
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Novo'
    TabOrder = 2
  end
  object btn_Fechar: TButton
    Left = 473
    Top = 347
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Fechar'
    TabOrder = 3
    ExplicitLeft = 596
  end
end
