object fmPesquisar: TfmPesquisar
  Left = 0
  Top = 0
  Caption = 'fmPesquisar'
  ClientHeight = 381
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object dbGrid: TDBGrid
    Left = 0
    Top = 81
    Width = 514
    Height = 255
    Align = alClient
    DataSource = dsQry
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 30
    Align = alTop
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 217
      Top = 1
      Width = 75
      Height = 28
      Align = alLeft
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object edtCNPJPesquisa: TMaskEdit
      Left = 1
      Top = 1
      Width = 216
      Height = 28
      Align = alLeft
      EditMask = '99.999.999/9999-99;1;_'
      MaxLength = 18
      TabOrder = 1
      Text = '  .   .   /    -  '
      ExplicitHeight = 21
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 336
    Width = 514
    Height = 45
    Align = alBottom
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    object Button2: TButton
      Left = 363
      Top = 1
      Width = 75
      Height = 43
      Align = alRight
      Caption = 'Button2'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 438
      Top = 1
      Width = 75
      Height = 43
      Align = alRight
      Caption = 'Button3'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object rgPesquisa: TRadioGroup
    Left = 0
    Top = 30
    Width = 514
    Height = 51
    Align = alTop
    Caption = 'Pesquisar por:'
    Columns = 2
    Items.Strings = (
      'Produtor'
      'Trader')
    TabOrder = 3
  end
  object dsQry: TDataSource
    DataSet = qry
    Left = 248
    Top = 200
  end
  object qry: TFDQuery
    Left = 184
    Top = 152
  end
end
