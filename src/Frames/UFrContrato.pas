unit UFrContrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ExtCtrls, UFuncoesBasicas,UControleDB;

type
  TFrContrato = class(TFrame)
    Panel17: TPanel;
    btnCadastrarContrato: TButton;
    Panel16: TPanel;
    Label16: TLabel;
    edtContratoNomeTrader: TEdit;
    Panel15: TPanel;
    Label15: TLabel;
    edtContratoCNPJTrader: TMaskEdit;
    Label14: TLabel;
    Panel14: TPanel;
    Label13: TLabel;
    edtContratoQtdeGrao: TEdit;
    Panel13: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    Label11: TLabel;
    edtContratoNomeProduto: TEdit;
    Panel10: TPanel;
    Label10: TLabel;
    edtContratoNomeProdutor: TEdit;
    Panel12: TPanel;
    Label9: TLabel;
    edtContratoCNPJProdutor: TMaskEdit;
    Label8: TLabel;
    edtContratoTipoGrao: TComboBox;
    procedure edtContratoCNPJProdutorChange(Sender: TObject);
    procedure btnCadastrarContratoClick(Sender: TObject);
    procedure edtContratoQtdeGraoChange(Sender: TObject);
  private
    { Private declarations }
    FIDContradoProdutor : string;
    FIDContratoTrader: string;
    FcontroleDB : TControleDB;
    function validarContrato(const pCNPJ, pNomeProd, pTpGrao, pNomeTrader : string; pQtdeGrao:double): Boolean;
    procedure atualizaCapacidadeTrader(const pTraderId : string; pQtde: double);
    procedure limparCamposContrato;
  public
    { Public declarations }
    constructor create(AOwner: TComponent; controleDB:TcontroleDB); reintroduce;
  end;

implementation

uses
   UClasseContrato;

{$R *.dfm}

{ TFrContrato }

procedure TFrContrato.atualizaCapacidadeTrader(const pTraderId: string;pQtde: double);
var
  novaQtdeArmazenamento : double;
begin
  FcontroleDB.sqlGlobal.Open('select ttrader_armazenamento from ttrader where ttrader_id = :id',[pTraderId]);

  novaQtdeArmazenamento := FcontroleDB.sqlGlobal.FieldByName('ttrader_armazenamento').AsFloat - pQtde;
  FcontroleDB.sqlGlobal.ExecSQL('update ttrader set ttrader_armazenamento = :qtde where ttrader_id = :id', [novaQtdeArmazenamento,pTraderId]);
end;

procedure TFrContrato.btnCadastrarContratoClick(Sender: TObject);
var
  contrato : TContrato;
begin
  if validarContrato(edtContratoCNPJProdutor.Text, edtContratoNomeProduto.Text,edtContratoTipoGrao.Text,edtContratoNomeTrader.Text ,StrToFloat(edtContratoQtdeGrao.Text)) then
  begin
    contrato := TContrato.Create(FcontroleDB);
    contrato.ProdutorID := FIDContradoProdutor;
    contrato.TraderID := FIDContratoTrader;
    contrato.NomeProduto := edtContratoNomeProduto.Text;
    contrato.TipoGrao := edtContratoTipoGrao.Text;
    contrato.KGGrao := StrToFloat(edtContratoQtdeGrao.Text);
    contrato.DataContrato := Now();

    try
      if  contrato.InserirContrato then
      begin
        ShowMessage('Contrato cadastrado.');
        atualizaCapacidadeTrader(contrato.TraderID,contrato.KGGrao);
        limparCamposContrato
      end
      else
        ShowMessage('Erro ao inserir.');
      finally
        contrato.Free;
    end;
  end;

end;

constructor TFrContrato.create(AOwner: TComponent; controleDB: TcontroleDB);
begin
  inherited Create(AOwner);
  FcontroleDB := controleDB;
end;

procedure TFrContrato.edtContratoCNPJProdutorChange(Sender: TObject);
begin
  FIDContradoProdutor:= EmptyStr;
  edtContratoNomeProdutor.Clear;
  FcontroleDB.sqlGlobal.Open('select tprodutor_id, tprodutor_nome from tprodutor where tprodutor_cnpj = :cnpj',[edtContratoCNPJProdutor.Text]);

  if FcontroleDB.sqlGlobal.RecordCount > 0 then
  begin
    FIDContradoProdutor := FcontroleDB.sqlGlobal.FieldByName('tprodutor_id').AsString;
    edtContratoNomeProdutor.Text := FcontroleDB.sqlGlobal.FieldByName('tprodutor_nome').AsString;
  end
  else
  if cnpjValido(edtContratoCNPJProdutor.Text) then
  begin
    ShowMessage('CNPJ não encontrado como produtor.');
  end;
end;

procedure TFrContrato.edtContratoQtdeGraoChange(Sender: TObject);
begin
  FIDContratoTrader := EmptyStr;
  edtContratoCNPJTrader.Clear;
  edtContratoNomeTrader.Clear;
  if edtContratoQtdeGrao.Text > '1' then
  begin
    FcontroleDB.sqlGlobal.Open('SELECT FIRST 1 TTRADER_ID, TTRADER_NOME, TTRADER_CNPJ FROM TTRADER WHERE TTRADER_ARMAZENAMENTO >= :CAPACIDADE',[StrToFloat(edtContratoQtdeGrao.Text)]);
    if FcontroleDB.sqlGlobal.RecordCount > 0 then
    begin
      FIDContratoTrader := FcontroleDB.sqlGlobal.FieldByName('ttrader_id').AsString;
      edtContratoCNPJTrader.Text := FcontroleDB.sqlGlobal.FieldByName('ttrader_cnpj').AsString;
      edtContratoNomeTrader.Text := FcontroleDB.sqlGlobal.FieldByName('ttrader_nome').AsString;
    end;
  end;
end;

procedure TFrContrato.limparCamposContrato;
begin
  edtContratoCNPJProdutor.Clear;
  edtContratoNomeProdutor.Clear;
  edtContratoNomeProduto.Clear;
  edtContratoTipoGrao.ItemIndex := 0;
  edtContratoQtdeGrao.Text := IntToStr(0);
  edtContratoCNPJTrader.Clear;
  edtContratoNomeTrader.Clear;
  FIDContradoProdutor := EmptyStr;
  FIDContratoTrader := EmptyStr;
end;

function TFrContrato.validarContrato(const pCNPJ, pNomeProd, pTpGrao,pNomeTrader: string; pQtdeGrao: double): Boolean;
begin
  Result := false;

  if not cnpjValido(pCNPJ) then
  begin
    ShowMessage('CNPJ inválido.');
    Exit
  end else
  if pNomeProd = EmptyStr then
  begin
    ShowMessage('O nome do produto não pode ser vazio.');
    Exit
  end else
  if pTpGrao = EmptyStr then
  begin
    ShowMessage('O tipo do grão não pode ser vazio.');
    Exit
  end else
  if pQtdeGrao = 0 then
  begin
    ShowMessage('Informe quantidade de kg do grão.');
    Exit;
  end else
  if pNomeTrader = EmptyStr then
  begin
    ShowMessage('Nenhum trader com armazenamento disponivel para essa quantidade.');
    Exit;
  end;

  Result := true;
end;

end.
