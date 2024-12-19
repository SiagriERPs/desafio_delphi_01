object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'frmPrincipal'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  TextHeight = 15
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 132
    Height = 25
    Caption = 'Produtor'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 47
    Width = 132
    Height = 25
    Caption = 'Trade'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 78
    Width = 132
    Height = 25
    Caption = 'Gr'#227'o'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 109
    Width = 132
    Height = 25
    Caption = 'Contrato'
    TabOrder = 3
    OnClick = Button4Click
  end
end
