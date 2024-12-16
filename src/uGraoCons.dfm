object frmGraoCons: TfrmGraoCons
  Left = 0
  Top = 0
  Caption = 'Consulta de Cadastro de Gr'#227'os'
  ClientHeight = 380
  ClientWidth = 600
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    600
    380)
  PixelsPerInch = 96
  TextHeight = 16
  object grp_Filtros: TGroupBox
    Left = 8
    Top = 8
    Width = 584
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Filtros'
    TabOrder = 0
    DesignSize = (
      584
      65)
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
      Anchors = [akRight, akBottom]
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
      OnKeyPress = txt_FiltroKeyPress
    end
    object cbo_Tipo: TComboBox
      Left = 8
      Top = 34
      Width = 145
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 1
      TabOrder = 1
      Text = 'Descri'#231#227'o'
      OnSelect = cbo_TipoSelect
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
    end
    object cbo_Status: TComboBox
      Left = 431
      Top = 34
      Width = 106
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akRight, akBottom]
      ItemIndex = 0
      TabOrder = 2
      Text = 'Geral'
      Items.Strings = (
        'Geral'
        'Ativo'
        'Inativo')
    end
    object btn_Pesquisar: TBitBtn
      Left = 543
      Top = 34
      Width = 33
      Height = 22
      Hint = 'Click Para Efetuar a Pesquisa de Gr'#227'os'
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000320B0000320B000000010000000100005A6B7300AD7B
        73004A637B00EFBD8400B58C8C00A5948C00C6948C00B59C8C00BD9C8C00F7BD
        8C00BD949400C6949400CE949400C69C9400CEAD9400F7CE9400C6A59C00CEA5
        9C00D6A59C00C6AD9C00CEAD9C00D6AD9C00F7CE9C00F7D69C004A7BA500CEAD
        A500D6B5A500DEBDA500F7D6A500DEBDAD00DEC6AD00E7C6AD00FFDEAD00FFE7
        AD00CEB5B500F7DEB500F7E7B500FFE7B500FFEFB500D6BDBD00DED6BD00E7DE
        BD00FFE7BD006B9CC600EFDEC600FFEFC600FFF7C600F7E7CE00FFF7CE00F7EF
        D600F7F7D600FFF7D600FFFFD6002184DE00F7F7DE00FFFFDE001884E700188C
        E700FFFFE700188CEF00218CEF00B5D6EF00F7F7EF00FFF7EF00FFFFEF00FFFF
        F700FF00FF004AB5FF0052B5FF0052BDFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0042020A424242
        424242424242424242422B39180B42424242424242424242424243443C180B42
        4242424242424242424242444438180B42424242424242424242424244433918
        0A424242424242424242424242444335004201101A114242424242424242453D
        05072F343434291942424242424242221A2D34343437403E0442424242424206
        231C303437404146284242424242421B210F30373A414140310D42424242421F
        20032434373A3A37321342424242421D25030F2D37373737311042424242420D
        2D2D1C162430333429424242424242421E463F0F0316252E0842424242424242
        4227312D21252314424242424242424242420E141B1B42424242}
      TabOrder = 3
      OnClick = btn_PesquisarClick
    end
  end
  object grp_ListaGraos: TGroupBox
    Left = 8
    Top = 79
    Width = 584
    Height = 262
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Lista Gr'#227'os'
    TabOrder = 1
    DesignSize = (
      584
      262)
    object lbl_Info: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 243
      Width = 574
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Para Altera'#231#227'o Duplo Click no Registro da Lista'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 225
    end
    object lbl_Legenda: TLabel
      Left = 503
      Top = 3
      Width = 74
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Status Inativo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grd_ListaGraos: TDBGrid
      Left = 2
      Top = 18
      Width = 580
      Height = 222
      Align = alClient
      DataSource = DM.dsGraos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnDrawColumnCell = grd_ListaGraosDrawColumnCell
      OnDblClick = grd_ListaGraosDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 380
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Status'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 85
          Visible = True
        end>
    end
    object pnl_CorLegenda: TPanel
      Left = 485
      Top = 3
      Width = 17
      Height = 15
      Anchors = [akTop, akRight]
      Color = clRed
      ParentBackground = False
      TabOrder = 1
    end
  end
  object btn_Salvar: TBitBtn
    Left = 8
    Top = 342
    Width = 89
    Height = 30
    Hint = 'Click Para Cadastrar um Gr'#227'o Novo'
    Anchors = [akLeft, akBottom]
    Caption = '&Novo'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000D70D0000D70D00000000000000000001FFFFFFDEDFDF
      9DA2A08B908E8B908E8B908E8A8F8D8A8F8D0D0DA20000A40000A40D0DA29A9E
      9CDCDEDDFFFFFFFFFFFFFFFFFF9EA3A1EBEDECFEFFFEFEFFFFFEFFFFFFFFFFFF
      FFFF0000A43B3BCB3B3BCB0000A4EEEFEF9AA09EFEFEFEFFFFFFFFFFFF8F9592
      FEFEFEEAEDECEAEDECEBEEEDECEFEEEDEFEE0000A44343CB4343CB0000A4FEFF
      FF8D9290FBFBFBFFFFFFFFFFFF919694FDFEFEE7EAE9E6EAE81616AB0000A400
      00A40C0CAA4949CF4949CF0C0CAA0000A40000A41818ACFFFFFFFFFFFF929896
      FDFEFDE4E8E7C1C5C30000A44F4FD34F4FD34F4FD34F4FD34F4FD34F4FD34F4F
      D34F4FD30000A4FFFFFFFFFFFF949A97FDFDFDE1E6E3DFE4E20000A46767DB67
      67DB6767DB6969DB6969DB6767DB6767DB6767DB0000A4FFFFFFFFFFFF969B99
      FDFDFDDDE3E0BBBFBE1213A80000A40000A40A0AA86767DD6969DD0B0BA90000
      A40000A41818ADFFFFFFFFFFFF979D9BFDFDFDDAE0DDD8DEDBD9DFDCD9DFDCD9
      DFDC0000A46A6ADE6A6ADE0000A4FEFEFE959B99FBFBFBFFFFFFFFFFFF999F9D
      FDFDFDD9DFDCB6BBBAB6BCB9B5BBB9B5BBB90000A46A6AE06C6CE00000A4FEFE
      FE979D9AFBFBFBFFFFFFFFFFFF9BA19EFDFDFDDAE0DCD7DDDAD6DDDAD5DCD9D5
      DBD81415AA0000A40000A41415AAFEFEFE999E9CFBFBFBFFFFFFFFFFFF9CA2A0
      FDFDFDDCE3E0BABFBCB8BEBBB7BDBAB6BBB9B4BAB8B2B9B5AFB4B1C6CCC8D9DB
      DA9BA19FFDFDFDFFFFFFFFFFFF9EA4A2FDFDFDE1E6E4DEE3E1DDE2DFDBE1DED9
      E0DCD7DEDBBBC1BEAAAFACB1B3B2D8DAD9BABFBDFFFFFFFFFFFFFFFFFFA0A6A3
      FDFEFDE5E9E7C0C5C2BFC3C1BDC2BFBBC0BEBABFBCB5B9B7FFFFFFFCFCFCABAF
      ADE6E7E7FFFFFFFFFFFFFFFFFFA1A7A5FEFEFEE9ECEBE5E9E7E3E8E5E1E6E3DE
      E4E1DFE5E2D7D9D9FDFDFDBCC0BED2D5D3FFFFFFFFFFFFFFFFFFFFFFFFAEB3B1
      EDEFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9E7E9E8AFB4B1D2D5D4FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFE3E5E4AFB5B2A6ACAAA6ACA9A5ABA9A5ABA8A5
      ABA8A6ACAABFC3C1E6E7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 2
    OnClick = btn_SalvarClick
  end
  object btn_Fechar: TBitBtn
    Left = 503
    Top = 342
    Width = 89
    Height = 30
    Hint = 'Click Para Fechar a Tela de Gr'#227'o'
    Anchors = [akRight, akBottom]
    Caption = '&Fechar'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000D70D0000D70D00000000000000000001FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFE5555C35555C3FBFBFEFFFFFFFF
      FFFFFFFFFFFFFFFFFBFBFE5555C35555C3FBFBFEFFFFFFFFFFFFFFFFFFFBFBFE
      4E4EC11D1DB21D1DB24E4EC1FBFBFEFFFFFFFFFFFFFBFBFE4E4EC11D1DB21D1D
      B24E4EC1FBFBFEFFFFFFFFFFFF5B5BC52121B53B3BC83B3BC82121B65151C3FB
      FBFEFBFBFE5151C32121B63C3CC83B3BC82121B65B5BC5FFFFFFFFFFFF5D5DC7
      2626B84545CD4141CC4646CD2626B85353C35353C32626B84646CD4242CC4545
      CD2626B85D5DC7FFFFFFFFFFFFFBFBFE5656C62B2BBC5050D14A4AD05050D130
      30BE3030BE5050D14A4AD05050D12B2BBC5656C6FBFBFEFFFFFFFFFFFFFFFFFF
      FBFBFE5858C73232BD5959D65252D45B5BD75B5BD75353D45959D63232BD5858
      C7FBFBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFE5A5AC83A3AC36565DB63
      63DB6363DB6565DB3A3AC35A5AC8FBFBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFBFBFE5D5DCB4040C66E6EDF6A6ADF6A6ADF6E6EDF4141C65D5DCBFBFB
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFE5F5FCC4040C77676E36A6AE177
      77E47777E46969E17676E34040C75F5FCCFBFBFEFFFFFFFFFFFFFFFFFFFBFBFE
      6262CD4343C97E7EE67171E47F7FE64848CB4848CB7F7FE67272E47E7EE64444
      CA6262CDFBFBFEFFFFFFFFFFFF6D6DD14949CB8686E77878E58888E74A4ACB65
      65CF6565CF4A4ACB8888E77979E58787E74949CB6E6ED1FFFFFFFFFFFF7070D3
      4F4FCD8F8FE99090E95050CD6767D1FCFCFEFCFCFE6767D15050CD9090E98F8F
      E94F4FCD7070D3FFFFFFFFFFFFFCFCFE6969D25252CD5353CD6969D2FCFCFEFF
      FFFFFFFFFFFCFCFE6A6AD25454CE5454CD6A6AD2FCFCFEFFFFFFFFFFFFFFFFFF
      FCFCFE7474D67575D6FCFCFEFFFFFFFFFFFFFFFFFFFFFFFFFCFCFE7575D67575
      D6FCFCFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 3
    OnClick = btn_FecharClick
  end
end
