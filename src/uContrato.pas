unit uContrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastro, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmContrato = class(TfrmCadastro)
    qrCadastroID: TIntegerField;
    qrCadastroIDPRODUTOR: TIntegerField;
    qrCadastroIDTRADE: TIntegerField;
    qrCadastroIDGRAO: TIntegerField;
    qrCadastroQUANTIDADE: TCurrencyField;
    qrCadastroDTEMISSAO: TSQLTimeStampField;
    qrCadastroDTVIGENCIA: TSQLTimeStampField;
    qrCadastroNMPRODUTOR: TStringField;
    qrCadastroNMTRADE: TStringField;
    qrCadastroNMGRAO: TStringField;
    lbIdContrato: TLabel;
    edIdContrato: TDBEdit;
    lbProdutor: TLabel;
    edIdProdutor: TDBEdit;
    lbTrade: TLabel;
    edIdTrade: TDBEdit;
    lbGrao: TLabel;
    edIdGrao: TDBEdit;
    lbQuantidade: TLabel;
    edIdQuantidade: TDBEdit;
    lbEmissao: TLabel;
    edDataEmissao: TDBEdit;
    lbVigencia: TLabel;
    edDataVigencia: TDBEdit;
    grdSilos: TDBGrid;
    qrSilo: TFDQuery;
    dsSilo: TDataSource;
    lbNomeProdutor: TLabel;
    lbNomeTrade: TLabel;
    lbNomeGrao: TLabel;
    qrSiloIDTRADE: TIntegerField;
    qrSiloIDCONTRATO: TIntegerField;
    qrSiloIDENTIFICADOR: TStringField;
    qrSiloQUANTIDADE: TCurrencyField;
    qrProdutor: TFDQuery;
    dsProdutor: TDataSource;
    qrTrade: TFDQuery;
    dsTrade: TDataSource;
    qrGrao: TFDQuery;
    dsGrao: TDataSource;
    qrProdutorID: TIntegerField;
    qrProdutorCNPJ: TStringField;
    qrProdutorNOME: TStringField;
    qrTradeID: TIntegerField;
    qrTradeCNPJ: TStringField;
    qrTradeNOME: TStringField;
    qrGraoID: TIntegerField;
    qrGraoNOME: TStringField;
    qrCadastrolkpProdutor: TStringField;
    qrCadastrolkpTrade: TStringField;
    qrCadastrolkpGrao: TStringField;
    edNomeProdutor: TDBLookupComboBox;
    edTrade: TDBLookupComboBox;
    edGrao: TDBLookupComboBox;
    Label1: TLabel;
    qrCadastroCNPJ_P: TStringField;
    qrCadastroCNPJ_T: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsCadastroDataChange(Sender: TObject; Field: TField);
    procedure tsCadastroShow(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure qrCadastroAfterPost(DataSet: TDataSet);
    procedure edConsultaChange(Sender: TObject);
    procedure tsConsultaShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation

{$R *.dfm}

procedure TfrmContrato.btAdicionarClick(Sender: TObject);
begin
  inherited;
  tsCadastro.Enabled := True;
  edDataVigencia.Text := DateToStr(IncMonth(Now, 12));
end;

procedure TfrmContrato.dsCadastroDataChange(Sender: TObject; Field: TField);
var
  idC, idT: integer;
begin
  idC := 0;
  idt := 0;

  if qrCadastroID.Value <> -1 then
  begin
    idC := qrCadastro.FieldByName('id').AsInteger;
    idT := qrCadastro.FieldByName('idTrade').AsInteger;
  end;

  qrSilo.Filter   := 'idContrato = ' + IntToStr(idC) +
                     ' and idTrade = ' + IntToStr(idT);
  qrSilo.Filtered := True;

  inherited;
end;

procedure TfrmContrato.edConsultaChange(Sender: TObject);
var
  sCampoFiltro: string;
begin
  case rgFiltro.ItemIndex of
    0: sCampoFiltro := 'cnpj_p';
    1: sCampoFiltro := 'cnpj_t';
  end;

  qrCadastro.Filter   := sCampoFiltro +' like ''%'+edConsulta.Text+'%''';
  qrCadastro.Filtered := True;

end;

procedure TfrmContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qrProdutor.Close;
  qrTrade.Close;
  qrGrao.Close;
  qrSilo.Close;
end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  inherited;
  qrProdutor.Open;
  qrTrade.Open;
  qrGrao.Open;
  qrSilo.Open;
end;

procedure TfrmContrato.qrCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  qrCadastro.Refresh;
  qrSilo.Refresh;
end;

procedure TfrmContrato.tsCadastroShow(Sender: TObject);
begin
  inherited;
  pnFiltro.Visible := False;

  if qrSilo.RecordCount <> 0 then
    tsCadastro.Enabled := False
  else begin
    tsCadastro.Enabled := True;
    edNomeProdutor.SetFocus;
  end;
end;

procedure TfrmContrato.tsConsultaShow(Sender: TObject);
begin
  inherited;
  pnFiltro.Visible := True;
end;

end.
