unit UFrTrader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, UControleDB, UFuncoesBasicas,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrTrader = class(TFrame)
    Panel9: TPanel;
    btnCadastrarTrader: TButton;
    Panel8: TPanel;
    Label6: TLabel;
    edtArmazenamentoSilosKg: TEdit;
    Panel7: TPanel;
    Label5: TLabel;
    spQtdeSilos: TSpinEdit;
    Panel6: TPanel;
    Label4: TLabel;
    edtNomeTrader: TEdit;
    Panel5: TPanel;
    Label3: TLabel;
    edtCNPJTrader: TMaskEdit;
    Label18: TLabel;
    Label1: TLabel;
    dbGridTrader: TDBGrid;
    dscGridTrader: TDataSource;
    procedure btnCadastrarTraderClick(Sender: TObject);
    procedure spQtdeSilosChange(Sender: TObject);
  private
    { Private declarations }
    FcontroleDB : TControleDB;
    function validarTrader(const pCNPJ, pNome: string; pSilos: integer; pControleDB : TControleDB): Boolean;
    procedure limparCamposTrader;
    procedure carregarGridTrader;
  public
    { Public declarations }
    constructor create(AOwner: TComponent; controleDB:TcontroleDB); reintroduce;
    procedure atualizaGridTrader;
  end;

implementation

uses
  UClasseTrader;

{$R *.dfm}

{ TFrTrader }
const
SQL_GRID_TRADER = 'SELECT TTRADER_NOME, TTRADER_QTDE_SILOS, TTRADER_ARMAZENAMENTO, TTRADER_CNPJ FROM TTRader ORDER BY TTRADER_NOME ASC';
procedure TFrTrader.atualizaGridTrader;
begin
  FcontroleDB.sqlGlobal.Open(SQL_GRID_TRADER);
end;

procedure TFrTrader.btnCadastrarTraderClick(Sender: TObject);
var
  trader : TTrader;
begin
  if validarTrader(edtCNPJTrader.Text, edtNomeTrader.Text, spQtdeSilos.Value, FControleDB) then
  begin
    trader := TTrader.Create(FcontroleDB);
    trader.CNPJ := edtCNPJTrader.Text;
    trader.nome := edtNomeTrader.Text;
    trader.qtdeSilos := spQtdeSilos.Value;
    trader.QtdeArmazenamento :=   StrToFloat(edtArmazenamentoSilosKg.Text);
    try
      if  trader.InserirTrader then
      begin
        ShowMessage('Trader cadastrado');
        limparCamposTrader;
      end
      else
        ShowMessage('Erro ao inserir');
      finally
        Trader.Free;
    end;
  end;
  atualizaGridTrader;
end;

procedure TFrTrader.carregarGridTrader;
begin
   dscGridTrader.DataSet := FcontroleDB.sqlGlobal;

   dbGridTrader.Columns[0].Title.Caption := 'CNPJ do trader';
   dbGridTrader.Columns[0].FieldName := 'TTRADER_CNPJ';
   dbGridTrader.Columns[0].Width := 190;

   dbGridTrader.Columns[1].Title.Caption := 'Nome do trader';
   dbGridTrader.Columns[1].FieldName := 'TTRADER_NOME';
   dbGridTrader.Columns[1].Width := 200;

   dbGridTrader.Columns[2].Title.Caption := 'Quantidade de silos';
   dbGridTrader.Columns[2].FieldName := 'TTRADER_QTDE_SILOS';
   dbGridTrader.Columns[2].Width := 250;

   dbGridTrader.Columns[3].Title.Caption := 'Armazenamento disponivel Kg';
   dbGridTrader.Columns[3].FieldName := 'TTRADER_ARMAZENAMENTO';
   dbGridTrader.Columns[3].Width := 300;
end;

constructor TFrTrader.create(AOwner: TComponent; controleDB: TcontroleDB);
begin
  inherited Create(AOwner);
  FcontroleDB := controleDB;
  atualizaGridTrader;
  carregarGridTrader;
end;

procedure TFrTrader.limparCamposTrader;
begin
  edtCNPJTrader.Text := EmptyStr;
  edtNomeTrader.Text := EmptyStr;
  spQtdeSilos.Value := 0;
  edtArmazenamentoSilosKg.Text := EmptyStr;
end;

const
  CAPACIDADE_SILO = 90000;
procedure TFrTrader.spQtdeSilosChange(Sender: TObject);
var
  qtdeSilos: integer;
  total: double;
begin
  if spQtdeSilos.Value >= 100000 then
  begin
    ShowMessage('Valor maximo atingido.');
    spQtdeSilos.Value := 100000;
    Exit;
  end;

  qtdeSilos :=  spQtdeSilos.Value;
  total :=  qtdeSilos * CAPACIDADE_SILO;
  edtArmazenamentoSilosKg.Text :=  FloatToStr(total);
end;

function TFrTrader.validarTrader(const pCNPJ, pNome: string;pSilos: integer;pControleDB : TControleDB): Boolean;
begin
  Result := false;

  if not cnpjValido(pCNPJ) then
  begin
    ShowMessage('CNPJ inválido.');
    Exit
  end else
  pcontroleDB.sqlGlobal.Open('select ttrader_id from ttrader where ttrader_cnpj = :cnpj' , [pCNPJ]);
  if pcontroleDB.sqlGlobal.RecordCount > 0 then
  begin
    ShowMessage('Este CNPJ já existe.');
    Exit
  end else
  pControleDB.sqlGlobal.Open('select tprodutor_id from tprodutor where tprodutor_cnpj =:cnpj' , [pCNPJ]);
  if pControleDB.sqlGlobal.RecordCount > 0 then
  begin
    ShowMessage('Este CNPJ já está cadastrado como produtor.');
    Exit
  end else
  if pNome = EmptyStr then
  begin
    ShowMessage('O nome não pode ser vazio.');
    Exit
  end else
  if pSilos = 0 then
  begin
    ShowMessage('O silo não pode ser 0.');
    Exit;
  end;

  Result := true;
end;

end.
