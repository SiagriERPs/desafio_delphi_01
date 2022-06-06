unit uContratoCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, uClasseTrade, uClasseGrao, uClasseProdutor;

type
  TfrmContratoCons = class(TForm)
    grp_Filtros: TGroupBox;
    txt_Trade: TEdit;
    grp_ListaSilo: TGroupBox;
    grd_ListaContratos: TDBGrid;
    lbl_Trade: TLabel;
    lbl_Info: TLabel;
    btn_Novo: TBitBtn;
    btn_Fechar: TBitBtn;
    btn_Pesquisar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    txt_Grao: TEdit;
    Label3: TLabel;
    lbl_Tipo: TLabel;
    lbl_Filtro: TLabel;
    txt_Filtro: TEdit;
    cbo_Tipo: TComboBox;
    txt_IDTrade: TEdit;
    txt_IDGrao: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    txt_Produtor: TEdit;
    txt_IDProdutor: TEdit;
    procedure btn_NovoClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure cbo_TipoSelect(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure grd_ListaContratosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ListaContratosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txt_FiltroKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeExit(Sender: TObject);
    procedure txt_IDGraoExit(Sender: TObject);
    procedure KeyPress_Geral(Sender: TObject; var Key: Char);
    procedure txt_IDProdutorExit(Sender: TObject);
    procedure txt_IDProdutorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    Trade : TTrade;
    Grao  : TGrao;
    Produtor  : TProdutor;
    procedure CarregarGrid;
    function GerarWhere():String;
    { Private declarations }
  public
    vForm, vID_Pesquisa:String;

    { Public declarations }
  end;

var
  frmContratoCons: TfrmContratoCons;

implementation

{$R *.dfm}

uses uGraoCad, uDM, uGraoCons, uTradeCons, uFuncoes_Globais, uSiloCad, uProdutorCons, uContratoCad;

function TfrmContratoCons.GerarWhere():String;
Var
  vWhere:String;
begin
  DM.qryContrato.SQL.Add(' WHERE 1=1 ');

  {$REGION 'WHERE TIPO'}
  if trim(txt_Filtro.Text) <> '' then begin
    {$REGION 'WHERE ID'}
    if cbo_Tipo.ItemIndex = 0 then begin
      DM.qryContrato.SQL.Add(' AND c.ID =:vId');
      DM.qryContrato.ParamByName('vId').AsString := txt_Filtro.Text;
    end;
    {$ENDREGION}

    {$REGION 'WHERE CNPJ'}
    if cbo_Tipo.ItemIndex = 1 then begin
      DM.qryContrato.SQL.Add(' AND p.CNPJ LIKE :vDescri');
      DM.qryContrato.ParamByName('vDescri').AsString := '%' + RemoveCaractere(txt_Filtro.Text) + '%';
    end;
    {$ENDREGION}
  end;
  {$ENDREGION}

  {$REGION 'WHERE ID_TRADE'}
  if trim(txt_IDTrade.Text) <> '' then begin
    DM.qryContrato.SQL.Add(' AND c.id_trade =:vId');
    DM.qryContrato.ParamByName('vId').ASInteger := Trade.vId;
  end;
  {$ENDREGION}

  {$REGION 'WHERE ID_GRAO'}
  if trim(txt_IDGrao.Text) <> ''then begin
    DM.qryContrato.SQL.Add(' AND c.id_grao =:vId');
    DM.qryContrato.ParamByName('vId').ASInteger := Grao.vId;
  end;
  {$ENDREGION}

  {$REGION 'WHERE ID_PRODUTOR'}
  if trim(txt_IDGrao.Text) <> ''then begin
    DM.qryContrato.SQL.Add(' AND c.id_produtor =:vId');
    DM.qryContrato.ParamByName('vId').ASInteger := Produtor.vId;
  end;
  {$ENDREGION}

end;

procedure TfrmContratoCons.CarregarGrid();
begin
  DM.qryContrato.close;
  DM.qryContrato.SQL.Text :=
    'SELECT c.id, c.qtde_geral,                     ' +
    '       c.id_produtor, p.nome PRODUTOR, p.CNPJ, ' +
    '       c.id_trade, t.descricao TRADE,          ' +
    '       c.id_grao, g.descricao GRAO             ' +
    'FROM CONTRATO c                                ' +
    'INNER JOIN GRAO g on g.id = c.id_grao          ' +
    'INNER JOIN TRADE t on t.id = c.id_trade        ' +
    'INNER JOIN PRODUTOR p on p.id = c.id_produtor  ';

  DM.qryContrato.SQL.Add(GerarWhere());
  DM.qryContrato.SQL.Add(' ORDER BY ID');

  DM.qryContrato.Open;
  DM.qryContrato.First;
end;

procedure TfrmContratoCons.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key= VK_F1) then begin
    if frmTradeCons = nil then Application.CreateForm(TfrmTradeCons, frmTradeCons);
    frmTradeCons.vForm := 'CONSULTA_CONTRATO';
    frmTradeCons.ShowModal;
    FreeAndNil(frmTradeCons);
    txt_IDTrade.Text := vID_Pesquisa;
    txt_IDTrade.SetFocus;
  end;

  if (key= VK_F2) then begin
    if frmGraoCons = nil then Application.CreateForm(TfrmGraoCons, frmGraoCons);
    frmGraoCons.vForm := 'CONSULTA_CONTRATO';
    frmGraoCons.ShowModal;
    FreeAndNil(frmGraoCons);
    txt_IDGrao.Text := vID_Pesquisa;
    txt_IDGrao.SetFocus;
  end;

  if (key= VK_F3) then begin
    if frmProdutorCons = nil then Application.CreateForm(TfrmProdutorCons, frmProdutorCons);
    frmProdutorCons.vForm := 'CONSULTA_CONTRATO';
    frmProdutorCons.ShowModal;
    FreeAndNil(frmProdutorCons);
    txt_IDProdutor.Text := vID_Pesquisa;
    txt_IDProdutor.SetFocus;
  end;
end;

procedure TfrmContratoCons.FormShow(Sender: TObject);
begin
  Trade    := TTrade.Create;
  Grao     := TGrao.Create;
  Produtor := TProdutor.Create;

  btn_Pesquisar.Click;

  if vForm <> 'Novo' then begin
    lbl_Info.Visible   := False;
    btn_Novo.Visible := False;
  end;
end;

procedure TfrmContratoCons.grd_ListaContratosDblClick(Sender: TObject);
begin
  if DM.qryContrato.Eof then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Selecione um Registro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Novo' then begin
    if frmContratoCad = nil then Application.CreateForm(TfrmContratoCad, frmContratoCad);
    frmContratoCad.vForm := 'Alteracao';
    frmContratoCad.vID := DM.qryContratoID.AsString;

    frmContratoCad.ShowModal;
    FreeAndNil(frmContratoCad);
  end;

  btn_Pesquisar.Click;
end;

procedure TfrmContratoCons.grd_ListaContratosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {alterando a cor da linha atual selecionada}
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color:=clGradientInactiveCaption;

  TDBGrid(Sender).Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmContratoCons.KeyPress_Geral(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);
end;

procedure TfrmContratoCons.cbo_TipoSelect(Sender: TObject);
begin
  lbl_Tipo.Caption := cbo_Tipo.Text;
  txt_Filtro.Text := '';
end;

procedure TfrmContratoCons.txt_FiltroKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if cbo_Tipo.ItemIndex = 0 then
    Key := ApenasNumero(Key, txt_Filtro.Text);
end;

procedure TfrmContratoCons.txt_IDGraoExit(Sender: TObject);
begin
  txt_Grao.Text := '';

  if trim(txt_IDGrao.Text) <> '' then begin
    if not Grao.PesquisarGrao('ID', txt_IDGrao.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Grão Não Localizado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDGrao.Text := '';
      abort;
    end;
    txt_Grao.Text := Grao.vDescricao;
  end;
end;

procedure TfrmContratoCons.txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDGrao.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDGrao.Text);
end;

procedure TfrmContratoCons.txt_IDProdutorExit(Sender: TObject);
begin
  txt_Produtor.Text := '';

  if trim(txt_IDProdutor.Text) <> '' then begin
    if not Produtor.PesquisarProdutor('ID', txt_IDProdutor.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Produtor Não Localizado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDProdutor.Text := '';
      abort;
    end;
    txt_Produtor.Text := Produtor.vNome;
  end;
end;

procedure TfrmContratoCons.txt_IDProdutorKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDProdutor.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDProdutor.Text);
end;

procedure TfrmContratoCons.txt_IDTradeExit(Sender: TObject);
begin
  txt_Trade.Text := '';

  if trim(txt_IDTrade.Text) <> '' then begin
    if not Trade.PesquisarTrade('ID', txt_IDTrade.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Não Localizada'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDTrade.Text := '';
      abort;
    end;

    txt_Trade.Text := trade.vDescricao;
  end;
end;

procedure TfrmContratoCons.txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDTrade.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDTrade.Text);
end;

procedure TfrmContratoCons.btn_PesquisarClick(Sender: TObject);
begin
  CarregarGrid();
end;

procedure TfrmContratoCons.btn_NovoClick(Sender: TObject);
begin
  if frmContratoCad = nil then Application.CreateForm(TfrmContratoCad, frmContratoCad);
  frmContratoCad.vForm := 'Novo';
  frmContratoCad.ShowModal;
  FreeAndNil(frmContratoCad);

  btn_Pesquisar.Click;
end;

procedure TfrmContratoCons.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContratoCons.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Trade.Destroy;
  Grao.Destroy;
  Produtor.Destroy;
end;


end.
