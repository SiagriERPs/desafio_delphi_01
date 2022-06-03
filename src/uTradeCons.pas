unit uTradeCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmTradeCons = class(TForm)
    grp_Filtros: TGroupBox;
    lbl_Tipo: TLabel;
    lbl_Filtro: TLabel;
    lbl_Status: TLabel;
    txt_Filtro: TEdit;
    cbo_Tipo: TComboBox;
    cbo_Status: TComboBox;
    grp_ListaGraos: TGroupBox;
    lbl_Info: TLabel;
    lbl_Legenda: TLabel;
    grd_ListaGraos: TDBGrid;
    pnl_CorLegenda: TPanel;
    btn_Salvar: TBitBtn;
    btn_Fechar: TBitBtn;
    btn_Pesquisar: TBitBtn;
    procedure cbo_TipoSelect(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure grd_ListaGraosDblClick(Sender: TObject);
    procedure grd_ListaGraosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure txt_FiltroKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    procedure CarregarGrid;
    function GerarWhere: String;
    { Private declarations }
  public
    vForm, vID :String;
    { Public declarations }
  end;

var
  frmTradeCons: TfrmTradeCons;

implementation

{$R *.dfm}

uses uFuncoes_Globais, uDM, uTradeCad;

function TfrmTradeCons.GerarWhere():String;
Var
  vWhere:String;
begin
  DM.qryGraos.SQL.Add(' WHERE 1=1 ');

  {$REGION 'WHERE STATUS'}
  if (cbo_Status.ItemIndex = 1) or (cbo_Status.ItemIndex = 2) then begin
    DM.qryGraos.SQL.Add(' AND STATUS =:vStatus');
    DM.qryGraos.ParamByName('vStatus').AsString := cbo_Status.Text;
  end;
  {$ENDREGION}

  {$REGION 'WHERE TIPO'}
  if trim(txt_Filtro.Text) <> '' then begin

    {$REGION 'WHERE ID'}
    if cbo_Tipo.ItemIndex = 0 then begin
      DM.qryGraos.SQL.Add(' AND ID =:vId');
      DM.qryGraos.ParamByName('vId').AsString := txt_Filtro.Text;
    end;
    {$ENDREGION}

    {$REGION 'WHERE DESCRICAO'}
    if cbo_Tipo.ItemIndex = 1 then begin
      DM.qryGraos.SQL.Add(' AND DESCRICAO LIKE :vDescri');
      DM.qryGraos.ParamByName('vDescri').AsString := '%' + txt_Filtro.Text + '%';
    end;
  {$ENDREGION}
  end;
  {$ENDREGION}
end;

procedure TfrmTradeCons.CarregarGrid();
begin
  DM.qryGraos.close;
  DM.qryGraos.SQL.Text :=
    ' Select * from TRADE ';
  DM.qryGraos.SQL.Add(GerarWhere());
  DM.qryGraos.SQL.Add(' ORDER BY ID');

  DM.qryGraos.Open;
  DM.qryGraos.First;

end;

procedure TfrmTradeCons.btn_PesquisarClick(Sender: TObject);
begin
  CarregarGrid();
end;


procedure TfrmTradeCons.btn_SalvarClick(Sender: TObject);
begin
  if frmTradeCad = nil then Application.CreateForm(TfrmTradeCad, frmTradeCad);
  frmTradeCad.vForm := 'Novo';
  frmTradeCad.ShowModal;
  FreeAndNil(frmTradeCad);

  btn_Pesquisar.Click;
end;

procedure TfrmTradeCons.cbo_TipoSelect(Sender: TObject);
begin
  lbl_Tipo.Caption := cbo_Tipo.Text;
  txt_Filtro.Text := '';
end;

procedure TfrmTradeCons.FormShow(Sender: TObject);
begin
  btn_Pesquisar.Click;

  if vForm <> 'Novo' then begin
    lbl_Info.Visible   := False;
    btn_Salvar.Visible := False;
  end;
end;

procedure TfrmTradeCons.grd_ListaGraosDblClick(Sender: TObject);
begin
  if DM.qryGraos.Eof then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Selecione um Registro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Novo' then begin

    if frmTradeCad = nil then Application.CreateForm(TfrmTradeCad, frmTradeCad);
    frmTradeCad.vForm := 'Alteracao';
    frmTradeCad.vID := DM.qryGraosID.AsString;

    frmTradeCad.ShowModal;
    FreeAndNil(frmTradeCad);
  end;

  btn_Pesquisar.Click;
end;

procedure TfrmTradeCons.grd_ListaGraosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {alterando a cor da linha atual selecionada}
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color:=clGradientInactiveCaption;

  {alterando a cor da fonte dos produtos cancelados}
  if DM.qryGraosSTATUS.AsString = 'Inativo' then
    TDBGrid(Sender).Canvas.Font.Color:=clRed;

  TDBGrid(Sender).Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;


procedure TfrmTradeCons.txt_FiltroKeyPress(Sender: TObject; var Key: Char);
begin
  if cbo_Tipo.ItemIndex = 0 then
    Key := ApenasNumero(Key, txt_Filtro.Text);
end;

procedure TfrmTradeCons.btn_FecharClick(Sender: TObject);
begin
  close;
end;

end.
