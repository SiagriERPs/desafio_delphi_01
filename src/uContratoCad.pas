unit uContratoCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, uClasseContrato;

type
  TfrmContratoCad = class(TForm)
    GroupBox1: TGroupBox;
    btn_Fechar: TBitBtn;
    btn_Salvar: TBitBtn;
    txt_Trade: TEdit;
    txt_IDTrade: TEdit;
    Label1: TLabel;
    btn_Pesq_Trade: TBitBtn;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    txt_Grao: TEdit;
    txt_IDGrao: TEdit;
    btn_Pesq_Grao: TBitBtn;
    GroupBox3: TGroupBox;
    txt_QTDE_GERAL: TEdit;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    txt_Produtor: TEdit;
    txt_IDProdutor: TEdit;
    btn_Pesq_Produtor: TBitBtn;
    procedure btn_SalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_FecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeExit(Sender: TObject);
    procedure txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDGraoExit(Sender: TObject);
    procedure txt_QTDE_GERALKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Pesq_TradeClick(Sender: TObject);
    procedure btn_Pesq_GraoClick(Sender: TObject);
    procedure txt_IDProdutorExit(Sender: TObject);
    procedure btn_Pesq_ProdutorClick(Sender: TObject);
    procedure txt_IDProdutorKeyPress(Sender: TObject; var Key: Char);
  private
    Contrato: TContrato;
    { Private declarations }
  public
    vForm, vID, vID_Pesquisa:String;
    { Public declarations }
  end;

var
  frmContratoCad: TfrmContratoCad;

implementation

{$R *.dfm}

uses uFuncoes_Globais, uTradeCons, uGraoCons, uProdutorCons;


procedure TfrmContratoCad.FormShow(Sender: TObject);
begin
  Contrato  := TContrato.Create;

  if vForm = 'Alteracao' then begin
    Contrato.PesquisarContrato(vID);

    txt_IDTrade.Text    := IntToStr(Contrato.vTrade.vId);
    txt_IDGrao.Text     := IntToStr(Contrato.vGrao.vId);
    txt_IDProdutor.Text := IntToStr(Contrato.vProdutor.vId);
  end;

  txt_QTDE_GERAL.Text := FormatFloat('##0.00', Contrato.vQTDE_GERAL);

  txt_IDTradeExit(Sender);
  txt_IDGraoExit(Sender);
  txt_IDProdutorExit(Sender);
end;

procedure TfrmContratoCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key= VK_F1) then
    btn_Pesq_Trade.Click;

  if (key= VK_F2) then
    btn_Pesq_Grao.Click;

  if (key= VK_F3) then
    btn_Pesq_Produtor.Click;
end;


procedure TfrmContratoCad.btn_Pesq_GraoClick(Sender: TObject);
begin
  if frmGraoCons = nil then Application.CreateForm(TfrmGraoCons, frmGraoCons);
  frmGraoCons.vForm := 'CONSULTA_CONTRATOCAD';
  frmGraoCons.ShowModal;
  FreeAndNil(frmGraoCons);

  txt_IDGrao.Text := vID_Pesquisa;
  txt_IDGrao.SetFocus;
end;

procedure TfrmContratoCad.btn_Pesq_ProdutorClick(Sender: TObject);
begin
  if frmProdutorCons = nil then Application.CreateForm(TfrmProdutorCons, frmProdutorCons);
  frmProdutorCons.vForm := 'CONSULTA_CONTRATOCAD';
  frmProdutorCons.ShowModal;
  FreeAndNil(frmProdutorCons);

  txt_IDProdutor.Text := vID_Pesquisa;
  txt_IDProdutor.SetFocus;
end;

procedure TfrmContratoCad.btn_Pesq_TradeClick(Sender: TObject);
begin
  if frmTradeCons = nil then Application.CreateForm(TfrmTradeCons, frmTradeCons);
  frmTradeCons.vForm := 'CONSULTA_CONTRATOCAD';
  frmTradeCons.ShowModal;
  FreeAndNil(frmTradeCons);

  txt_IDTrade.Text := vID_Pesquisa;
  txt_IDTrade.SetFocus;
end;


procedure TfrmContratoCad.txt_QTDE_GERALKeyPress(Sender: TObject; var Key: Char);
begin
  Key := ApenasNumero(Key, txt_QTDE_GERAL.Text, True);
end;

procedure TfrmContratoCad.txt_IDGraoExit(Sender: TObject);
begin
  txt_Grao.Text := '';

  if trim(txt_IDGrao.Text) <> '' then begin
    if NOT Contrato.vGrao.PesquisarGrao('ID', txt_IDGrao.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Grão Não Localizado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDGrao.Text := '';
      abort;
    end;

    if Contrato.vGrao.vStatus = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Grão Se Encontra Inativo'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDGrao.Text := '';
      abort;
    end;

    txt_Grao.Text := Contrato.vGrao.vDescricao;
  end;
end;

procedure TfrmContratoCad.txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDGrao.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDGrao.Text);
end;

procedure TfrmContratoCad.txt_IDProdutorExit(Sender: TObject);
begin
  txt_Produtor.Text := '';

  if trim(txt_IDProdutor.Text) <> '' then begin
    if NOT Contrato.vProdutor.PesquisarProdutor('ID', txt_IDProdutor.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Produtor Não Localizado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDProdutor.Text := '';
      abort;
    end;

    if Contrato.vProdutor.vStatus = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Produtor Se Encontra Inativo'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDProdutor.Text := '';
      abort;
    end;

    txt_Produtor.Text := Contrato.vProdutor.vNome;
  end;
end;

procedure TfrmContratoCad.txt_IDProdutorKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDProdutor.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDProdutor.Text);
end;

procedure TfrmContratoCad.txt_IDTradeExit(Sender: TObject);
begin
  txt_Trade.Text := '';

  if trim(txt_IDTrade.Text) <> '' then begin
    if NOT Contrato.vTrade.PesquisarTrade('ID', txt_IDTrade.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Não Localizada'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDTrade.Text := '';
      abort;
    end;

    if Contrato.vTrade.vStatus = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Se Encontra Inativa'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDTrade.Text := '';
      abort;
    end;

    txt_Trade.Text := Contrato.vTrade.vDescricao;
  end;
end;

procedure TfrmContratoCad.txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDTrade.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDTrade.Text);
end;


procedure TfrmContratoCad.btn_SalvarClick(Sender: TObject);
Var
  vSalvo :Boolean;
  vQtdeDisponivel :Double;
begin
  Validar_Campo_Obrigatorio(txt_QTDE_GERAL);
  Validar_Campo_Obrigatorio(txt_IDTrade);
  Validar_Campo_Obrigatorio(txt_IDGrao);
  Validar_Campo_Obrigatorio(txt_IDProdutor);

  if StrToFloat(txt_QTDE_GERAL.Text) <= 0 then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + 'Quantidade tem que ser maior que 0,00 Kg'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    txt_QTDE_GERAL.SetFocus;
    abort;
  end;


  Contrato.vQTDE_GERAL := StrToFloat(txt_QTDE_GERAL.Text);

  if Contrato.Verificar_Silo_Grao_and_Trade <= 0 then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + 'Essa Trade nao possui Silos Ativos para armazenar o grão Selecionado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  vQtdeDisponivel := Contrato.Verificar_Armazenamento_Silo(ifthen(vForm= 'Alteracao', 'True', 'False'));

  if  vQtdeDisponivel < StrToFloat(FormatFloat('##0.00', StrToFloat(txt_QTDE_GERAL.Text))) then begin
    Application.MessageBox(
      PWideChar('ATENÇÃO!!' + #13 + 'Essa Trade não Possui Silos Ativos, Com a Capacidade de Armazenar: ' + txt_QTDE_GERAL.Text +
                ' kg' + #13 + ' CAPACIDADE MAXIMA SUPORTADA: ' + FormatFloat('##0.00',vQtdeDisponivel)), 'Desafio 1',
        MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Alteracao' then
    vSalvo := Contrato.AlterarContrato
  else
    vSalvo := Contrato.InserirContrato;

  if not vSalvo then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Salvar. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  close;
end;

procedure TfrmContratoCad.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContratoCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Contrato.Destroy;
end;

end.
