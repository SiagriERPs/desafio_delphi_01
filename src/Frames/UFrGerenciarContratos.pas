unit UFrGerenciarContratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, UControleDB;

type
  TFrGerenciarContratos = class(TFrame)
    gridGerenciar: TDBGrid;
    Panel18: TPanel;
    Label7: TLabel;
    btnImprimirTodosContratos: TSpeedButton;
    edtCNPJGerenciar: TMaskEdit;
    rgGerenciar: TRadioGroup;
    Panel2: TPanel;
    SpeedButton9: TSpeedButton;
    SpeedButton11: TSpeedButton;
    dscGridGerenciar: TDataSource;
    procedure edtCNPJGerenciarChange(Sender: TObject);
    procedure rgGerenciarClick(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure btnImprimirTodosContratosClick(Sender: TObject);
  private
    { Private declarations }
    FcontroleDB : TControleDB;

    procedure pesquisaContratos;
    procedure atualizaGridContrato;
    procedure imprimirContratos;
    procedure carregarColunasGrid;
    procedure adicionarCapacidadeTrader(const pTraderId: string;pQtde: double);
  public
    { Public declarations }
    constructor create(AOwner: TComponent; controleDB:TcontroleDB); reintroduce;
    procedure atualizaGrid;
  end;

implementation

uses
  Vcl.Printers, UEditarContrato, UClasseContrato;

{$R *.dfm}

{ TFrGerenciarContratos }

CONST
SQL_GRID_CONTRATOS = 'SELECT a.TCONTRATO_ID, a.TCONTRATO_ID_PRODUTOR, a.TCONTRATO_ID_TRADER , ' +
                             ' a.TCONTRATO_NOME_PROD, a.TCONTRATO_TIPO_GRAO, a.TCONTRATO_DATA_CONTRATO , ' +
                             ' a.TCONTRATO_KG_GRAO, b.TPRODUTOR_NOME, b.TPRODUTOR_CNPJ, c.TTRADER_NOME, C.TTRADER_cnpj ' +
                             ' FROM TCONTRATO a ' +
                             ' inner join TPRODUTOR b on b.TPRODUTOR_ID = a.TCONTRATO_ID_PRODUTOR ' +
                             ' inner join TTRADER c on c.TTRADER_ID = a.TCONTRATO_ID_TRADER';

procedure TFrGerenciarContratos.adicionarCapacidadeTrader(const pTraderId: string; pQtde: double);
var
  novaQtdeArmazenamento : double;
begin
  FcontroleDB.sqlGlobal.Open('select ttrader_armazenamento from ttrader where ttrader_id = :id',[pTraderId]);

  novaQtdeArmazenamento := FcontroleDB.sqlGlobal.FieldByName('ttrader_armazenamento').AsFloat + pQtde;
  FcontroleDB.sqlGlobal.ExecSQL('update ttrader set ttrader_armazenamento = :qtde where ttrader_id = :id', [novaQtdeArmazenamento,pTraderId]);

end;

procedure TFrGerenciarContratos.atualizaGrid;
begin
  FcontroleDB.sqlGlobal.Open(SQL_GRID_CONTRATOS);
end;

procedure TFrGerenciarContratos.atualizaGridContrato;
begin
   FcontroleDB.sqlGlobal.Open(SQL_GRID_CONTRATOS);
end;

procedure TFrGerenciarContratos.btnImprimirTodosContratosClick(Sender: TObject);
begin
  imprimirContratos;
end;

procedure TFrGerenciarContratos.carregarColunasGrid;
begin
   dscGridGerenciar.DataSet := FcontroleDB.sqlGlobal;
   gridGerenciar.Columns[0].Title.Caption := 'Nome produto';
   gridGerenciar.Columns[0].FieldName := 'TCONTRATO_NOME_PROD';
   gridGerenciar.Columns[0].Width := 200;

   gridGerenciar.Columns[1].Title.Caption := 'CNPJ do produtor';
   gridGerenciar.Columns[1].FieldName := 'TPRODUTOR_cnpj';
   gridGerenciar.Columns[1].Width := 190;

   gridGerenciar.Columns[2].Title.Caption := 'Nome do produtor';
   gridGerenciar.Columns[2].FieldName := 'TPRODUTOR_NOME';
   gridGerenciar.Columns[2].Width := 190;

   gridGerenciar.Columns[3].Title.Caption := 'CNPJ da trade';
   gridGerenciar.Columns[3].FieldName := 'TTRADER_CNPJ';
   gridGerenciar.Columns[3].Width := 190;

   gridGerenciar.Columns[4].Title.Caption := 'Nome da trade';
   gridGerenciar.Columns[4].FieldName := 'TTRADER_NOME';
   gridGerenciar.Columns[4].Width := 190;

   gridGerenciar.Columns[5].Title.Caption := 'Grão contratado';
   gridGerenciar.Columns[5].FieldName := 'TCONTRATO_TIPO_GRAO';
   gridGerenciar.Columns[5].Width := 140;

   gridGerenciar.Columns[6].Title.Caption := 'Quantidade armazenada Kg';
   gridGerenciar.Columns[6].FieldName := 'TCONTRATO_KG_GRAO';
   gridGerenciar.Columns[6].Width := 250;

   gridGerenciar.Columns[7].Title.Caption := 'Data do contrato';
   gridGerenciar.Columns[7].FieldName := 'TCONTRATO_DATA_CONTRATO';
   gridGerenciar.Columns[7].Width := 170;
end;

constructor TFrGerenciarContratos.create(AOwner: TComponent;controleDB: TcontroleDB);
begin
  inherited Create(AOwner);
  FcontroleDB := controleDB;
  atualizaGridContrato;
  carregarColunasGrid;
end;

procedure TFrGerenciarContratos.edtCNPJGerenciarChange(Sender: TObject);
begin
  pesquisaContratos;
end;

procedure TFrGerenciarContratos.imprimirContratos;
var
  linha:integer;
  tamanho:integer;
  coluna:integer;
begin
  printer.Orientation := poLandscape;
  printer.BeginDoc;

  printer.Canvas.Pen.Width := 5;
  printer.Canvas.Font.Name := 'Times New Roman';
  printer.Canvas.Font.Size := 10;

  linha := 20;
  coluna:= 20;
  tamanho := Printer.Canvas.TextWidth('a');

  dscGridGerenciar.DataSet.DisableControls;
  dscGridGerenciar.DataSet.First;
  while not dscGridGerenciar.DataSet.Eof do
  begin
    if linha = 20 then
    begin
      coluna := 20;
      printer.Canvas.TextOut(0,linha,'Relatorio de todos os contratos');
      linha := Linha - printer.Canvas.Font.Height + 5 ;
      printer.Canvas.TextOut(coluna,linha,'Nome produto');
      coluna:= Coluna + (tamanho * 30 );
      printer.Canvas.TextOut(coluna,linha,'Nome do produtor');
      coluna:= Coluna + (tamanho * 30);
      printer.Canvas.TextOut(coluna,linha,'Nome da trade');
      coluna:= Coluna + (tamanho * 30);
      printer.Canvas.TextOut(coluna,linha,'Grão contratado');
      coluna:= Coluna + (tamanho * 30);
      printer.Canvas.TextOut(coluna,linha,'Quantidade armazenada Kg');
      coluna:= Coluna + (tamanho * 30);
      printer.Canvas.TextOut(coluna,linha,'Data do contrato');
      coluna:= Coluna + (tamanho * 30);
      linha := linha - printer.Canvas.Font.Height + 5 ;
    end;
    coluna := 20 ;
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TCONTRATO_NOME_PROD').AsString);
    coluna:= coluna + (tamanho * 30 );
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TPRODUTOR_NOME').AsString);
    coluna:= coluna + (tamanho * 30);
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TTRADER_NOME').AsString);
    coluna:= coluna + (tamanho * 30);
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TCONTRATO_TIPO_GRAO').AsString);
    coluna:= coluna + (tamanho * 30);
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TCONTRATO_KG_GRAO').AsString);
    coluna:= coluna + (tamanho * 30);
    printer.Canvas.TextOut(coluna,linha,dscGridGerenciar.DataSet.FieldByName('TCONTRATO_DATA_CONTRATO').AsString);
    coluna:= coluna + (tamanho * 30);
    linha := linha - printer.Canvas.Font.Height + 5 ;

    dscGridGerenciar.DataSet.Next;
    if linha > printer.PageHeight-20 then
    Begin
      printer.NewPage;
      linha := 20;
    end;
  end;
  printer.EndDoc;
  dscGridGerenciar.DataSet.EnableControls;

  ShowMessage('Relatório salvo.');
end;

procedure TFrGerenciarContratos.pesquisaContratos;
begin
   if rgGerenciar.ItemIndex = 0 then
    begin
      edtCNPJGerenciar.Clear;
      FcontroleDB.sqlGlobal.Open(SQL_GRID_CONTRATOS);
    end;
    if rgGerenciar.ItemIndex = 1 then
    begin
      FcontroleDB.sqlGlobal.Open(SQL_GRID_CONTRATOS + ' where b.TPRODUTOR_CNPJ = :cnpj', [edtCNPJGerenciar.Text]);
    end else
    if rgGerenciar.ItemIndex = 2 then
    begin
      FcontroleDB.sqlGlobal.Open(SQL_GRID_CONTRATOS + ' where c.TTRADER_CNPJ = :cnpj', [edtCNPJGerenciar.Text]);
    end;
end;

procedure TFrGerenciarContratos.rgGerenciarClick(Sender: TObject);
begin
  pesquisaContratos;
end;

procedure TFrGerenciarContratos.SpeedButton11Click(Sender: TObject);
var
  FmEditarContrato : TFmEditarContrato;
begin
  FmEditarContrato := TFmEditarContrato.Create(Application);
  try
    if dscGridGerenciar.DataSet.FieldByName('tcontrato_id').AsString = EmptyStr then
    begin
      ShowMessage('Selecione um contrato para editar.');
      exit;
    end;

    FmEditarContrato.carregarContrato(dscGridGerenciar.DataSet.FieldByName('tcontrato_id').AsString);
    FmEditarContrato.ShowModal();
    atualizaGridContrato;
  finally
    FmEditarContrato.Free;
  end;
end;

procedure TFrGerenciarContratos.SpeedButton9Click(Sender: TObject);
var
  contrato : Tcontrato;
begin
  if dscGridGerenciar.DataSet.FieldByName('tcontrato_id').AsString = EmptyStr then
  begin
    ShowMessage('Selecione um contrato para excluir.');
    exit;
  end;

  if MessageDlg('Deseja realmente excluir o contrato "' + dscGridGerenciar.DataSet.FieldByName('TCONTRATO_NOME_PROD').AsString+ '"?' ,mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
      contrato := TContrato.Create(FcontroleDB);
      try
        contrato.ContratoID :=  dscGridGerenciar.DataSet.FieldByName('TCONTRATO_ID').AsString;
        contrato.TraderID := dscGridGerenciar.DataSet.FieldByName('TCONTRATO_ID_TRADER').AsString;
        contrato.KGGrao := dscGridGerenciar.DataSet.FieldByName('TCONTRATO_KG_GRAO').AsFloat;
        contrato.ExcluirContrato;
        adicionarCapacidadeTrader(contrato.TraderID,contrato.KGGrao);
      finally
        contrato.Free;
      end;
  end;
  atualizaGrid;
end;

end.
