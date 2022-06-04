unit uGraoCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmGraoCons = class(TForm)
    grp_Filtros: TGroupBox;
    txt_Filtro: TEdit;
    lbl_Tipo: TLabel;
    grp_ListaGraos: TGroupBox;
    grd_ListaGraos: TDBGrid;
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
    procedure grd_ListaGraosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ListaGraosDrawColumnCell(Sender: TObject; const Rect: TRect;
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
  frmGraoCons: TfrmGraoCons;

implementation

{$R *.dfm}

uses uGraoCad, uDM, uFuncoes_Globais, uSiloCons, uSiloCad;

function TfrmGraoCons.GerarWhere():String;
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

procedure TfrmGraoCons.CarregarGrid();
begin
  DM.qryGraos.close;
  DM.qryGraos.SQL.Text :=
    ' Select * from GRAO ';
  DM.qryGraos.SQL.Add(GerarWhere());
  DM.qryGraos.SQL.Add(' ORDER BY ID');

  DM.qryGraos.Open;
  DM.qryGraos.First;

end;


procedure TfrmGraoCons.FormShow(Sender: TObject);
begin
  btn_Pesquisar.Click;

  if vForm <> 'Novo' then begin
    lbl_Info.Visible   := False;
    btn_Salvar.Visible := False;
  end;
end;

procedure TfrmGraoCons.grd_ListaGraosDblClick(Sender: TObject);
begin
  if DM.qryGraos.Eof then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Selecione um Registro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Novo' then begin

    if frmGraoCad = nil then Application.CreateForm(TfrmGraoCad, frmGraoCad);
    frmGraoCad.vForm := 'Alteracao';
    frmGraoCad.vID := DM.qryGraosID.AsString;

    frmGraoCad.ShowModal;
    FreeAndNil(frmGraoCad);
  end
  else if  vForm = 'CONSULTA_SILO' then begin
    frmSiloCons.vID_Pesquisa := DM.qryGraosID.AsString;
    close;
    abort;
  end
  else if vForm = 'CONSULTA_SILOCAD' then begin
    if  DM.qryGraosStatus.AsString = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Se Encontra Inativa'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;

    frmSiloCad.vID_Pesquisa := DM.qryGraosID.AsString;
    close;
    abort;
  end;

  btn_Pesquisar.Click;
end;

procedure TfrmGraoCons.grd_ListaGraosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmGraoCons.cbo_TipoSelect(Sender: TObject);
begin
  lbl_Tipo.Caption := cbo_Tipo.Text;
  txt_Filtro.Text := '';
end;

procedure TfrmGraoCons.txt_FiltroKeyPress(Sender: TObject; var Key: Char);
begin
  if cbo_Tipo.ItemIndex = 0 then
    Key := ApenasNumero(Key, txt_Filtro.Text);
end;

procedure TfrmGraoCons.btn_PesquisarClick(Sender: TObject);
begin
  CarregarGrid();
end;

procedure TfrmGraoCons.btn_SalvarClick(Sender: TObject);
begin
  if frmGraoCad = nil then Application.CreateForm(TfrmGraoCad, frmGraoCad);
  frmGraoCad.vForm := 'Novo';
  frmGraoCad.ShowModal;
  FreeAndNil(frmGraoCad);

  btn_Pesquisar.Click;
end;

procedure TfrmGraoCons.btn_FecharClick(Sender: TObject);
begin
  close;
end;

end.
