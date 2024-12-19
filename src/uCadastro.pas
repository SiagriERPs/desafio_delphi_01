unit uCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, System.Actions,
  Vcl.ActnList;

type
  TfrmCadastro = class(TForm)
    qrCadastro: TFDQuery;
    dsCadastro: TDataSource;
    pcCadastro: TPageControl;
    pnFiltro: TPanel;
    tsConsulta: TTabSheet;
    tsCadastro: TTabSheet;
    grdCadastro: TDBGrid;
    rgFiltro: TRadioGroup;
    pnTextoConsulta: TPanel;
    edConsulta: TEdit;
    Panel3: TPanel;
    btAdicionar: TButton;
    btFechar: TButton;
    btCancelar: TButton;
    btExcluir: TButton;
    btConsultar: TButton;
    lbConsultar: TLabel;
    btGravar: TButton;
    btImprimir: TButton;
    procedure edConsultaChange(Sender: TObject);
    procedure grdCadastroDblClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tsConsultaShow(Sender: TObject);
    procedure tsCadastroShow(Sender: TObject);
    procedure grdCadastroKeyPress(Sender: TObject; var Key: Char);
    procedure edConsultaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btGravarClick(Sender: TObject);
    procedure grdCadastroKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizaEstadoBotoes(stAdicionar, stCancelar, stGravar, stExcluir, stConsultar, stTxtConsulta: Boolean);
    procedure AtualizaAcaoBotoes;
    procedure ConfirmarAlteracoesDados;
    function HouveAlteracaoDados: Boolean;
    procedure EditarCadastro;
  public
    { Public declarations }
  published
  end;

var
  frmCadastro: TfrmCadastro;

implementation

uses
  uDM;

{$R *.dfm}

procedure TfrmCadastro.AtualizaAcaoBotoes;
begin
  with dsCadastro do
  begin
    btAdicionar.Enabled := state in [dsBrowse];
    btCancelar .Enabled := state in [dsInsert, dsEdit];
    btGravar   .Enabled := state in [dsInsert, dsEdit];
    btExcluir  .Enabled := not (state in [dsInsert, dsEdit]);
  end;
end;

procedure TfrmCadastro.AtualizaEstadoBotoes(stAdicionar, stCancelar,
  stGravar, stExcluir, stConsultar, stTxtConsulta: Boolean);
begin
  btAdicionar.Visible := stAdicionar;
  btCancelar.Visible  := stCancelar;
  btGravar.Visible    := stGravar;
  btExcluir.Visible := stExcluir;
  btConsultar.Visible := stConsultar;
  pnTextoConsulta.Visible := stTxtConsulta;
end;

procedure TfrmCadastro.btAdicionarClick(Sender: TObject);
begin
  pcCadastro.ActivePage := tsCadastro;
  qrCadastro.Insert;
end;

procedure TfrmCadastro.btCancelarClick(Sender: TObject);
begin
  qrCadastro.Cancel;
end;

procedure TfrmCadastro.btConsultarClick(Sender: TObject);
begin
  ConfirmarAlteracoesDados;
  pcCadastro.ActivePage := tsConsulta;
  qrCadastro.Refresh;
end;

procedure TfrmCadastro.btExcluirClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza de que deseja excluir o registro?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    qrCadastro.Delete;
end;

procedure TfrmCadastro.btGravarClick(Sender: TObject);
begin
  qrCadastro.Post;
end;

procedure TfrmCadastro.ConfirmarAlteracoesDados;
begin
  if qrCadastro.Modified then
    if MessageDlg('Gravar alterações', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      qrCadastro.Post
    else
      qrCadastro.Cancel;
end;

procedure TfrmCadastro.grdCadastroDblClick(Sender: TObject);
begin
  EditarCadastro;
end;

procedure TfrmCadastro.grdCadastroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    EditarCadastro;
end;

procedure TfrmCadastro.grdCadastroKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    edConsulta.SetFocus;
end;

function TfrmCadastro.HouveAlteracaoDados: Boolean;
var
  regIndex: integer;
  diferente: Boolean;
begin
  diferente := False;
  if qrCadastro.Modified then
   Result := true;

end;

procedure TfrmCadastro.tsCadastroShow(Sender: TObject);
begin
  AtualizaEstadoBotoes(True, True, True, True, True, False);
end;

procedure TfrmCadastro.tsConsultaShow(Sender: TObject);
begin
  AtualizaEstadoBotoes(True, False, False, True, False, True);
end;

procedure TfrmCadastro.dsCadastroStateChange(Sender: TObject);
begin
  AtualizaAcaoBotoes;
end;

procedure TfrmCadastro.edConsultaChange(Sender: TObject);
begin
  qrCadastro.Filter   := 'upper(nome) like upper(''%'+edConsulta.Text+'%'')';
  qrCadastro.Filtered := True;
end;

procedure TfrmCadastro.edConsultaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DOWN then
    grdCadastro.SetFocus;
end;

procedure TfrmCadastro.EditarCadastro;
begin
  pcCadastro.ActivePage := tsCadastro;
  qrCadastro.Edit;
end;

procedure TfrmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.SelectNext(TCustomEdit(Sender), True, True);
  ConfirmarAlteracoesDados;

  qrCadastro.Close;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
  qrCadastro.Open;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
begin
  pcCadastro.ActivePage := tsConsulta;
  btExcluir.Visible := False;
end;

end.
