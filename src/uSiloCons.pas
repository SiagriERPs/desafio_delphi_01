unit uSiloCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, uClasseTrade, uClasseGrao;

type
  TfrmSiloCons = class(TForm)
    grp_Filtros: TGroupBox;
    txt_Trade: TEdit;
    grp_ListaSilo: TGroupBox;
    grd_ListaSilos: TDBGrid;
    lbl_Trade: TLabel;
    lbl_Info: TLabel;
    cbo_Status: TComboBox;
    lbl_Status: TLabel;
    lbl_Legenda: TLabel;
    pnl_CorLegenda: TPanel;
    btn_Salvar: TBitBtn;
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
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure cbo_TipoSelect(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure grd_ListaSilosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ListaSilosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txt_FiltroKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeExit(Sender: TObject);
    procedure txt_IDGraoExit(Sender: TObject);
    procedure KeyPress_Geral(Sender: TObject; var Key: Char);
  private
    Trade : TTrade;
    Grao  : TGrao;
    procedure CarregarGrid;
    function GerarWhere():String;
    { Private declarations }
  public
    vForm, vID_Pesquisa:String;

    { Public declarations }
  end;

var
  frmSiloCons: TfrmSiloCons;

implementation

{$R *.dfm}

uses uGraoCad, uDM, uGraoCons, uTradeCons, uFuncoes_Globais, uSiloCad;

function TfrmSiloCons.GerarWhere():String;
Var
  vWhere:String;
begin
  DM.qrySilo.SQL.Add(' WHERE 1=1 ');

  {$REGION 'WHERE TIPO'}
  if trim(txt_Filtro.Text) <> '' then begin

    {$REGION 'WHERE ID'}
    if cbo_Tipo.ItemIndex = 0 then begin
      DM.qrySilo.SQL.Add(' AND s.ID =:vId');
      DM.qrySilo.ParamByName('vId').AsString := txt_Filtro.Text;
    end;
    {$ENDREGION}

    {$REGION 'WHERE DESCRICAO'}
    if cbo_Tipo.ItemIndex = 1 then begin
      DM.qrySilo.SQL.Add(' AND s.DESCRICAO LIKE :vDescri');
      DM.qrySilo.ParamByName('vDescri').AsString := '%' + txt_Filtro.Text + '%';
    end;
  {$ENDREGION}
  end;
  {$ENDREGION}

  {$REGION 'WHERE ID_TRADE'}
  if trim(txt_IDTrade.Text) <> '' then begin
    DM.qrySilo.SQL.Add(' AND s.id_trade =:vId');
    DM.qrySilo.ParamByName('vId').ASInteger := Trade.vId;
  end;
  {$ENDREGION}

  {$REGION 'WHERE ID_GRAO'}
  if trim(txt_IDGrao.Text) <> ''then begin
    DM.qrySilo.SQL.Add(' AND s.id_grao =:vId');
    DM.qrySilo.ParamByName('vId').ASInteger := Grao.vId;
  end;
  {$ENDREGION}

  {$REGION 'WHERE STATUS'}
  if (cbo_Status.ItemIndex = 1) or (cbo_Status.ItemIndex = 2) then begin
    DM.qrySilo.SQL.Add(' AND s.STATUS =:vStatus');
    DM.qrySilo.ParamByName('vStatus').AsString := cbo_Status.Text;
  end;
  {$ENDREGION}
end;

procedure TfrmSiloCons.CarregarGrid();
begin
  DM.qrySilo.close;
  DM.qrySilo.SQL.Text :=
    ' SELECT s.id, s.descricao, s.capacidade, s.STATUS, ' +
    '        s.id_grao, g.descricao graos,              ' +
    '        s.id_trade, t.descricao Trades             ' +
    ' FROM SILO s                                       ' +
    ' INNER JOIN GRAO g on g.id = s.id_grao             ' +
    ' INNER JOIN TRADE t on t.id = s.id_trade           ';

  DM.qrySilo.SQL.Add(GerarWhere());
  DM.qrySilo.SQL.Add(' ORDER BY ID');

  DM.qrySilo.Open;
  DM.qrySilo.First;
end;


procedure TfrmSiloCons.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key= VK_F1) then begin
    if frmTradeCons = nil then Application.CreateForm(TfrmTradeCons, frmTradeCons);
    frmTradeCons.vForm := 'CONSULTA_SILO';
    frmTradeCons.ShowModal;
    FreeAndNil(frmTradeCons);
    txt_IDTrade.Text := vID_Pesquisa;
    txt_IDTrade.SetFocus;
  end;

  if (key= VK_F2) then begin
    if frmGraoCons = nil then Application.CreateForm(TfrmGraoCons, frmGraoCons);
    frmGraoCons.vForm := 'CONSULTA_SILO';
    frmGraoCons.ShowModal;
    FreeAndNil(frmGraoCons);
    txt_IDGrao.Text := vID_Pesquisa;
    txt_IDGrao.SetFocus;
  end;
end;

procedure TfrmSiloCons.FormShow(Sender: TObject);
begin
  Trade := TTrade.Create;
  Grao  := TGrao.Create;

  btn_Pesquisar.Click;

  if vForm <> 'Novo' then begin
    lbl_Info.Visible   := False;
    btn_Salvar.Visible := False;
  end;
end;

procedure TfrmSiloCons.grd_ListaSilosDblClick(Sender: TObject);
begin
  if DM.qrySilo.Eof then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Selecione um Registro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Novo' then begin
    if frmSiloCad = nil then Application.CreateForm(TfrmSiloCad, frmSiloCad);
    frmSiloCad.vForm := 'Alteracao';
    frmSiloCad.vID := DM.qrySiloID.AsString;

    frmSiloCad.ShowModal;
    FreeAndNil(frmSiloCad);
  end;

  btn_Pesquisar.Click;
end;

procedure TfrmSiloCons.grd_ListaSilosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {alterando a cor da linha atual selecionada}
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color:=clGradientInactiveCaption;

  {alterando a cor da fonte dos produtos cancelados}
  if DM.qrySiloSTATUS.AsString = 'Inativo' then
    TDBGrid(Sender).Canvas.Font.Color:=clRed;

  TDBGrid(Sender).Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmSiloCons.KeyPress_Geral(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);
end;

procedure TfrmSiloCons.cbo_TipoSelect(Sender: TObject);
begin
  lbl_Tipo.Caption := cbo_Tipo.Text;
  txt_Filtro.Text := '';
end;

procedure TfrmSiloCons.txt_FiltroKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if cbo_Tipo.ItemIndex = 0 then
    Key := ApenasNumero(Key, txt_Filtro.Text);
end;

procedure TfrmSiloCons.txt_IDGraoExit(Sender: TObject);
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

procedure TfrmSiloCons.txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDGrao.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDGrao.Text);
end;

procedure TfrmSiloCons.txt_IDTradeExit(Sender: TObject);
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

procedure TfrmSiloCons.txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDTrade.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDTrade.Text);
end;

procedure TfrmSiloCons.btn_PesquisarClick(Sender: TObject);
begin
  CarregarGrid();
end;

procedure TfrmSiloCons.btn_SalvarClick(Sender: TObject);
begin
  if frmSiloCad = nil then Application.CreateForm(TfrmSiloCad, frmSiloCad);
  frmSiloCad.vForm := 'Novo';
  frmSiloCad.ShowModal;
  FreeAndNil(frmSiloCad);

  btn_Pesquisar.Click;
end;

procedure TfrmSiloCons.btn_FecharClick(Sender: TObject);
begin
  close;
end;

end.
