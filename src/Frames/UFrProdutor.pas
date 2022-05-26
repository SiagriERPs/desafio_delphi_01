unit UFrProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ExtCtrls, UControleDB, UFuncoesBasicas, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrProdutor = class(TFrame)
    Panel4: TPanel;
    btnCadastrarProdutor: TButton;
    Panel3: TPanel;
    Label2: TLabel;
    edtNomeProdutor: TEdit;
    Panel1: TPanel;
    Label1: TLabel;
    edtCNPJProdutor: TMaskEdit;
    Label17: TLabel;
    Label3: TLabel;
    dbGridProdutor: TDBGrid;
    dscGridProdutor: TDataSource;
    procedure btnCadastrarProdutorClick(Sender: TObject);
  private
    { Private declarations }
    FcontroleDB : TControleDB;
    function validarProdutor(const pCNPJ,pNome:string; pControleDB : TControleDB): Boolean;
    procedure limparCamposProdutor;
    procedure carregarGridProdutor;
  public
    { Public declarations }
    constructor create(AOwner: TComponent; controleDB:TcontroleDB); reintroduce;
    procedure atualizaGridProdutor;
  end;

implementation

uses
  UClasseEmpresa;

{$R *.dfm}

{ TFrProdutor }
const
SQL_GRID_PRODUTOR = 'SELECT  TPRODUTOR_NOME, TPRODUTOR_CNPJ FROM TPRODUTOR ORDER BY TPRODUTOR_NOME ASC';
procedure TFrProdutor.atualizaGridProdutor;
begin
  FcontroleDB.sqlGlobal.Open(SQL_GRID_PRODUTOR);
end;

procedure TFrProdutor.btnCadastrarProdutorClick(Sender: TObject);
var
  produtor : Tprodutor;
begin
  if validarProdutor(edtCNPJProdutor.Text, edtNomeProdutor.Text, FcontroleDB) then
  begin
    produtor := TProdutor.Create(FcontroleDB);
    produtor.CNPJ := edtCNPJProdutor.Text;
    produtor.nome := edtNomeProdutor.Text;
    try
      if  produtor.InserirProdutor then
      begin
        ShowMessage('Produtor cadastrado.');
        limparCamposProdutor;
      end
      else
        ShowMessage('Erro ao inserir');
      finally
        produtor.Free;
    end;
  end;
  atualizaGridProdutor;
end;

procedure TFrProdutor.carregarGridProdutor;
begin
   dscGridProdutor.DataSet := FcontroleDB.sqlGlobal;

   dbGridProdutor.Columns[0].Title.Caption := 'CNPJ do produtor';
   dbGridProdutor.Columns[0].FieldName := 'TPRODUTOR_CNPJ';
   dbGridProdutor.Columns[0].Width := 220;

   dbGridProdutor.Columns[1].Title.Caption := 'Nome do produtor';
   dbGridProdutor.Columns[1].FieldName := 'TPRODUTOR_NOME';
   dbGridProdutor.Columns[1].Width := 220;
end;

constructor TFrProdutor.create(AOwner: TComponent; controleDB: TcontroleDB);
begin
  inherited Create(AOwner);
  FcontroleDB := controleDB;
  atualizaGridProdutor;
  carregarGridProdutor;
end;

procedure TFrProdutor.limparCamposProdutor;
begin
  edtCNPJProdutor.Clear;
  edtNomeProdutor.Clear;
end;

function TFrProdutor.validarProdutor(const pCNPJ, pNome: string;pControleDB : TControleDB): Boolean;
begin
  Result := false;

  if not cnpjValido(pCNPJ) then
  begin
    ShowMessage('CNPJ Inválido.');
    Exit
  end else
  pControleDB.sqlGlobal.Open('select tprodutor_id from tprodutor where tprodutor_cnpj =:cnpj' , [pCNPJ]);
  if pControleDB.sqlGlobal.RecordCount > 0 then
  begin
    ShowMessage('Este CNPJ já está cadastrado.');
    Exit
  end else
  pControleDB.sqlGlobal.Open('select ttrader_id from ttrader where ttrader_cnpj =:cnpj' , [pCNPJ]);
  if pControleDB.sqlGlobal.RecordCount > 0 then
  begin
    ShowMessage('Este CNPJ já está cadastrado como trader.');
    Exit
  end else
  if pNome = EmptyStr then
  begin
    ShowMessage('O nome não pode ser vazio.');
    Exit;
  end;

  Result := true;
end;

end.
