unit UEditarContrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask,
  UControleDB, Vcl.ExtCtrls;

type
  TFmEditarContrato = class(TForm)
    Panel12: TPanel;
    Label9: TLabel;
    edtContratoCNPJProdutor: TMaskEdit;
    Panel10: TPanel;
    Label10: TLabel;
    edtContratoNomeProdutor: TEdit;
    Panel11: TPanel;
    Label11: TLabel;
    edtContratoNomeProduto: TEdit;
    Panel13: TPanel;
    Label12: TLabel;
    Panel14: TPanel;
    Label13: TLabel;
    edtContratoQtdeGrao: TEdit;
    Label14: TLabel;
    Panel15: TPanel;
    Label15: TLabel;
    edtContratoCNPJTrader: TMaskEdit;
    Panel16: TPanel;
    Label16: TLabel;
    edtContratoNomeTrader: TEdit;
    Panel17: TPanel;
    btnCadastrarContrato: TButton;
    edtContratoTipoGrao: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastrarContratoClick(Sender: TObject);
  private
    { Private declarations }
    FContrato_Id: string;
    FIDContradoProdutor : string;
    FIDContratoTrader : string;

    function validarEdicaoContrato(const pNomeProd, pTpoGrao: string): Boolean;
    function retornaItemSelecionado(const ptipoGrao: string):Integer;
  public
    { Public declarations }
    procedure carregarContrato(const pId: string);
  end;

var
  FmEditarContrato: TFmEditarContrato;
  controleDBEditar : TControleDB;
implementation

uses
  UClasseContrato;

{$R *.dfm}

{ TFmEditarContrato }

procedure TFmEditarContrato.btnCadastrarContratoClick(Sender: TObject);
var
  contrato : TContrato;
begin
  if validarEdicaoContrato(edtContratoNomeProduto.Text, edtContratoTipoGrao.Text) then
  begin
    contrato := TContrato.Create(controleDBEditar);
    contrato.ContratoID := FContrato_Id;
    contrato.ProdutorID := FIDContradoProdutor;
    contrato.TraderID := FIDContratoTrader;
    contrato.NomeProduto := edtContratoNomeProduto.Text;
    contrato.TipoGrao := edtContratoTipoGrao.Text;
    contrato.KGGrao := StrToFloat(edtContratoQtdeGrao.Text);

    try
      if  contrato.AlterarContrato then
      begin
        ShowMessage('Contrato atualizado');
      end
      else
        ShowMessage('Erro ao alterar');
      finally
        contrato.Free;
    end;
  end;

end;

procedure TFmEditarContrato.carregarContrato(const pId: string);
begin
  controleDBEditar.sqlGlobal.Open('SELECT a.TCONTRATO_ID,  a.TCONTRATO_ID_PRODUTOR, a.TCONTRATO_ID_TRADER, ' +
                            ' a.TCONTRATO_NOME_PROD, a.TCONTRATO_TIPO_GRAO, a.TCONTRATO_DATA_CONTRATO , ' +
                            ' a.TCONTRATO_KG_GRAO, b.TPRODUTOR_NOME,b.TPRODUTOR_CNPJ, c.TTRADER_NOME, c.TTRADER_CNPJ ' +
                            ' FROM TCONTRATO a ' +
                            ' inner join TPRODUTOR b on b.TPRODUTOR_ID = a.TCONTRATO_ID_PRODUTOR ' +
                            ' inner join TTRADER c on c.TTRADER_ID = a.TCONTRATO_ID_TRADER where a.TCONTRATO_ID = :id', [pId]);

  FContrato_Id := controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_ID').AsString;
  FIDContradoProdutor := controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_ID_PRODUTOR').AsString;
  FIDContratoTrader := controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_ID_TRADER').AsString;
  edtContratoCNPJProdutor.Text := controleDBEditar.sqlGlobal.FieldByName('TPRODUTOR_CNPJ').AsString;
  edtContratoNomeProdutor.Text := controleDBEditar.sqlGlobal.FieldByName('TPRODUTOR_NOME').AsString;
  edtContratoNomeProduto.Text :=  controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_NOME_PROD').AsString;
  edtContratoTipoGrao.ItemIndex := retornaItemSelecionado(controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_TIPO_GRAO').AsString);
  edtContratoQtdeGrao.Text :=  controleDBEditar.sqlGlobal.FieldByName('TCONTRATO_KG_GRAO').AsString;
  edtContratoCNPJTrader.Text := controleDBEditar.sqlGlobal.FieldByName('TTRADER_CNPJ').AsString;
  edtContratoNomeTrader.Text := controleDBEditar.sqlGlobal.FieldByName('TTRADER_NOME').AsString;
end;

procedure TFmEditarContrato.FormCreate(Sender: TObject);
begin
  controleDBEditar := TControleDB.Create;
end;

procedure TFmEditarContrato.FormDestroy(Sender: TObject);
begin
  controleDBEditar.Free;
end;

function TFmEditarContrato.retornaItemSelecionado(const ptipoGrao: string): Integer;
begin
  if ptipoGrao = 'Soja amarela' then
    Result := 0
  else if ptipoGrao = 'Soja edamame' then
    Result := 1
  else if ptipoGrao = 'Soja preta' then
    Result := 2
end;

function TFmEditarContrato.validarEdicaoContrato(const pNomeProd,pTpoGrao: string): Boolean;
begin
  Result := false;
  if pNomeProd = EmptyStr then
  begin
    ShowMessage('O nome do produto não pode ser vazio');
    Exit
  end else
  if pTpoGrao = EmptyStr then
  begin
    ShowMessage('O tipo do grão não pode ser vazio');
    Exit
  end;

  Result := true;
end;

end.
