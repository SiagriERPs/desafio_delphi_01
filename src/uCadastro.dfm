object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 439
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pcCadastro: TPageControl
    Left = 0
    Top = 81
    Width = 642
    Height = 327
    ActivePage = tsConsulta
    Align = alClient
    TabOrder = 1
    object tsConsulta: TTabSheet
      Caption = 'tsConsulta'
      TabVisible = False
      OnShow = tsConsultaShow
      object grdCadastro: TDBGrid
        Left = 0
        Top = 0
        Width = 634
        Height = 317
        Align = alClient
        DataSource = dsCadastro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = grdCadastroDblClick
        OnKeyPress = grdCadastroKeyPress
        OnKeyUp = grdCadastroKeyUp
      end
    end
    object tsCadastro: TTabSheet
      Caption = 'tsCadastro'
      ImageIndex = 1
      TabVisible = False
      OnShow = tsCadastroShow
    end
  end
  object pnFiltro: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 57
    Align = alTop
    TabOrder = 2
    Visible = False
    object rgFiltro: TRadioGroup
      Left = 1
      Top = 1
      Width = 640
      Height = 55
      Align = alClient
      Caption = 'Selecione a informa'#231#227'o que deseja consultar'
      TabOrder = 0
    end
  end
  object pnTextoConsulta: TPanel
    Left = 0
    Top = 57
    Width = 642
    Height = 24
    Align = alTop
    TabOrder = 0
    object lbConsultar: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 63
      Height = 16
      Align = alLeft
      Alignment = taRightJustify
      Caption = ' Consultar : '
      ExplicitHeight = 15
    end
    object edConsulta: TEdit
      AlignWithMargins = True
      Left = 73
      Top = 4
      Width = 565
      Height = 16
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      TextHint = 'Texto de consulta (F3)'
      OnChange = edConsultaChange
      OnKeyUp = edConsultaKeyUp
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 408
    Width = 642
    Height = 31
    Align = alBottom
    TabOrder = 3
    object btAdicionar: TButton
      Left = 1
      Top = 1
      Width = 76
      Height = 29
      Align = alLeft
      Caption = '&Adicionar'
      TabOrder = 0
      OnClick = btAdicionarClick
    end
    object btFechar: TButton
      Left = 566
      Top = 1
      Width = 75
      Height = 29
      Align = alRight
      Caption = '&Fechar'
      ModalResult = 8
      TabOrder = 1
    end
    object btCancelar: TButton
      Left = 77
      Top = 1
      Width = 75
      Height = 29
      Align = alLeft
      Caption = '&Cancelar'
      TabOrder = 2
      OnClick = btCancelarClick
    end
    object btExcluir: TButton
      Left = 227
      Top = 1
      Width = 75
      Height = 29
      Align = alLeft
      Caption = '&Excluir'
      TabOrder = 3
      Visible = False
      OnClick = btExcluirClick
    end
    object btConsultar: TButton
      Left = 416
      Top = 1
      Width = 75
      Height = 29
      Align = alRight
      Caption = 'Consu&ltar'
      TabOrder = 4
      OnClick = btConsultarClick
    end
    object btGravar: TButton
      Left = 152
      Top = 1
      Width = 75
      Height = 29
      Align = alLeft
      Caption = '&Gravar'
      TabOrder = 5
      OnClick = btGravarClick
    end
    object btImprimir: TButton
      Left = 491
      Top = 1
      Width = 75
      Height = 29
      Align = alRight
      Caption = '&Imprimir'
      TabOrder = 6
    end
  end
  object qrCadastro: TFDQuery
    Filtered = True
    Connection = DM.con
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      '')
    Left = 120
    Top = 88
  end
  object dsCadastro: TDataSource
    DataSet = qrCadastro
    OnStateChange = dsCadastroStateChange
    Left = 192
    Top = 104
  end
end
