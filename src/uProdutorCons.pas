unit uProdutorCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmProdutorCons = class(TForm)
    grp_Filtros: TGroupBox;
    txt_Filtro: TEdit;
    lbl_Tipo: TLabel;
    grp_ListaGraos: TGroupBox;
    grd_ListaProdutor: TDBGrid;
    cbo_Tipo: TComboBox;
    lbl_Filtro: TLabel;
    lbl_Info: TLabel;
    cbo_Status: TComboBox;
    lbl_Status: TLabel;
    lbl_Legenda: TLabel;
    pnl_CorLegenda: TPanel;
    btn_Salvar: TBitBtn;
    btn_Fechar: TBitBtn;
    btn_Pesquisar: TBitBtn;
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure txt_FiltroKeyPress(Sender: TObject; var Key: Char);
    procedure cbo_TipoSelect(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure grd_ListaProdutorDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ListaProdutorDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure CarregarGrid;
    function GerarWhere():String;
    { Private declarations }
  public
    vForm:String;
    { Public declarations }
  end;

var
  frmProdutorCons: TfrmProdutorCons;

implementation

{$R *.dfm}

uses uGraoCad, uDM, uFuncoes_Globais, uSiloCons, uProdutorCad;

function TfrmProdutorCons.GerarWhere():String;
Var
  vWhere:String;
begin
  DM.qryProdutor.SQL.Add(' WHERE 1=1 ');

  {$REGION 'WHERE TIPO'}
  if trim(txt_Filtro.Text) <> '' then begin

    {$REGION 'WHERE ID'}
    if cbo_Tipo.ItemIndex = 0 then begin
      DM.qryProdutor.SQL.Add(' AND ID =:vId');
      DM.qryProdutor.ParamByName('vId').AsString := txt_Filtro.Text;
    end;
    {$ENDREGION}

    {$REGION 'WHERE DESCRICAO'}
    if cbo_Tipo.ItemIndex = 1 then begin
      DM.qryProdutor.SQL.Add(' AND DESCRICAO LIKE :vDescri');
      DM.qryProdutor.ParamByName('vDescri').AsString := '%' + txt_Filtro.Text + '%';
    end;
  {$ENDREGION}

    {$REGION 'WHERE CNPJ'}
    if cbo_Tipo.ItemIndex = 2 then begin
      DM.qryProdutor.SQL.Add(' AND CNPJ LIKE :vCNPJ ');
      DM.qryProdutor.ParamByName('vCNPJ').AsString := '%' + RemoveCaractere(txt_Filtro.Text) + '%';
    end;
    {$ENDREGION}
  end;
  {$ENDREGION}

  {$REGION 'WHERE STATUS'}
  if (cbo_Status.ItemIndex = 1) or (cbo_Status.ItemIndex = 2) then begin
    DM.qryProdutor.SQL.Add(' AND STATUS =:vStatus');
    DM.qryProdutor.ParamByName('vStatus').AsString := cbo_Status.Text;
  end;
  {$ENDREGION}
end;

procedure TfrmProdutorCons.CarregarGrid();
begin
  DM.qryProdutor.close;
  DM.qryProdutor.SQL.Text :=
    ' Select * from  PRODUTOR ';
  DM.qryProdutor.SQL.Add(GerarWhere());
  DM.qryProdutor.SQL.Add(' ORDER BY ID');

  DM.qryProdutor.Open;
  DM.qryProdutor.First;
end;

procedure TfrmProdutorCons.FormShow(Sender: TObject);
begin
  btn_Pesquisar.Click;

  if vForm <> 'Novo' then begin
    lbl_Info.Visible   := False;
    btn_Salvar.Visible := False;
  end;
end;

procedure TfrmProdutorCons.grd_ListaProdutorDblClick(Sender: TObject);
begin
  if DM.qryProdutor.Eof then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Selecione um Registro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Novo' then begin
    if frmProdutorCad = nil then Application.CreateForm(TfrmProdutorCad, frmProdutorCad);
    frmProdutorCad.vForm := 'Alteracao';
    frmProdutorCad.vID := DM.qryProdutorID.AsString;

    frmProdutorCad.ShowModal;
    FreeAndNil(frmProdutorCad);
  end;

  btn_Pesquisar.Click;
end;

procedure TfrmProdutorCons.grd_ListaProdutorDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {alterando a cor da linha atual selecionada}
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color:=clGradientInactiveCaption;

  {alterando a cor da fonte dos produtos cancelados}
  if DM.qryProdutorSTATUS.AsString = 'Inativo' then
    TDBGrid(Sender).Canvas.Font.Color:=clRed;

  TDBGrid(Sender).Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmProdutorCons.cbo_TipoSelect(Sender: TObject);
begin
  lbl_Tipo.Caption := cbo_Tipo.Text;
  txt_Filtro.Text := '';
end;

procedure TfrmProdutorCons.txt_FiltroKeyPress(Sender: TObject; var Key: Char);
begin
  if cbo_Tipo.ItemIndex = 0 then
    Key := ApenasNumero(Key, txt_Filtro.Text);
end;

procedure TfrmProdutorCons.btn_PesquisarClick(Sender: TObject);
begin
  CarregarGrid();
end;

procedure TfrmProdutorCons.btn_SalvarClick(Sender: TObject);
begin
  if frmProdutorCad = nil then Application.CreateForm(TfrmProdutorCad, frmProdutorCad);
  frmProdutorCad.vForm := 'Novo';
  frmProdutorCad.ShowModal;
  FreeAndNil(frmProdutorCad);

  btn_Pesquisar.Click;
end;

procedure TfrmProdutorCons.btn_FecharClick(Sender: TObject);
begin
  close;
end;

end.
