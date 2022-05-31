object frmGraoCad: TfrmGraoCad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Gr'#227'o'
  ClientHeight = 99
  ClientWidth = 366
  Color = clBtnHighlight
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    366
    99)
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 350
    Height = 49
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Nome Gr'#227'o'
    TabOrder = 0
    ExplicitWidth = 273
    object txt_Descricao: TEdit
      Left = 3
      Top = 18
      Width = 344
      Height = 24
      Hint = 'Informe o Nome do Seu Gr'#227'o'
      Align = alCustom
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      ExplicitWidth = 267
    end
  end
  object btn_Salvar: TButton
    Left = 8
    Top = 66
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Salvar'
    TabOrder = 1
    ExplicitTop = 63
  end
  object btn_Fechar: TButton
    Left = 283
    Top = 66
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Fechar'
    TabOrder = 2
    ExplicitLeft = 206
    ExplicitTop = 63
  end
  object Button1: TButton
    Left = 89
    Top = 66
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Inativar'
    TabOrder = 3
    Visible = False
  end
end
