unit uSiloCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, uClasseGrao, uClasseSilo, uClasseTrade;

type
  TfrmSiloCad = class(TForm)
    GroupBox1: TGroupBox;
    btn_Fechar: TBitBtn;
    btn_Salvar: TBitBtn;
    btn_Inativar: TBitBtn;
    ImageList1: TImageList;
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
    txt_Descricao: TEdit;
    lbl_Filtro: TLabel;
    txt_Capacidade: TEdit;
    Label3: TLabel;
    procedure btn_SalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_InativarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDTradeExit(Sender: TObject);
    procedure txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
    procedure txt_IDGraoExit(Sender: TObject);
    procedure txt_CapacidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Pesq_TradeClick(Sender: TObject);
    procedure btn_Pesq_GraoClick(Sender: TObject);
  private
    Trade : TTrade;
    Grao  : TGrao;
    Silo  : TSilo;
    { Private declarations }
  public
    vForm, vID, vID_Pesquisa:String;
    { Public declarations }
  end;

var
  frmSiloCad: TfrmSiloCad;

implementation

{$R *.dfm}

uses uFuncoes_Globais, uTradeCons, uGraoCons;

procedure TfrmSiloCad.btn_SalvarClick(Sender: TObject);
Var
  vSalvo :Boolean;
begin
  Validar_Campo_Obrigatorio(txt_Descricao);
  Validar_Campo_Obrigatorio(txt_Capacidade);
  Validar_Campo_Obrigatorio(txt_IDTrade);
  Validar_Campo_Obrigatorio(txt_IDGrao);

  Silo.vDescricao  := txt_Descricao.Text;
  Silo.vcapacidade := StrToFloat(txt_Capacidade.Text);

  if vForm = 'Alteracao' then
    vSalvo := Silo.AlterarSilo
  else
    vSalvo := Silo.InserirSilo;

  if not vSalvo then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Salvar. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  close;
end;

procedure TfrmSiloCad.btn_InativarClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Deseja Realmente ' + btn_Inativar.Caption + '?'),'Desafio 1', MB_ICONEXCLAMATION + MB_YESNOCANCEL) = mrYes then
  begin
    Silo.vStatus := ifthen(btn_Inativar.Caption = 'Inativar','Inativo', 'Ativo');

    if not Silo.MudarStatus then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Mudar o Status. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;

    close;
  end;
end;

procedure TfrmSiloCad.btn_Pesq_GraoClick(Sender: TObject);
begin
  if frmGraoCons = nil then Application.CreateForm(TfrmGraoCons, frmGraoCons);
  frmGraoCons.vForm := 'CONSULTA_SILOCAD';
  frmGraoCons.ShowModal;
  FreeAndNil(frmGraoCons);

  txt_IDGrao.Text := vID_Pesquisa;
  txt_IDGrao.SetFocus;
end;

procedure TfrmSiloCad.btn_Pesq_TradeClick(Sender: TObject);
begin
  if frmTradeCons = nil then Application.CreateForm(TfrmTradeCons, frmTradeCons);
  frmTradeCons.vForm := 'CONSULTA_SILOCAD';
  frmTradeCons.ShowModal;
  FreeAndNil(frmTradeCons);

  txt_IDTrade.Text := vID_Pesquisa;
  txt_IDTrade.SetFocus;
end;

procedure TfrmSiloCad.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSiloCad.FormShow(Sender: TObject);
begin
  Silo  := TSilo.Create;

  if vForm = 'Alteracao' then begin
    Silo.PesquisarSilo('s.ID', vID);

    if Silo.vStatus = 'Ativo' then begin
      btn_Inativar.Caption := 'Inativar';
      ImageList1.GetBitmap(0, btn_Inativar.Glyph);
    end
    else begin
      btn_Inativar.Caption := 'Ativar';
      ImageList1.GetBitmap(1, btn_Inativar.Glyph);
    end;

    btn_Inativar.Visible := True;

    txt_IDTrade.Text    := IntToStr(Silo.vTrade.vId);
    txt_IDGrao.Text     := IntToStr(Silo.vGrao.vId);
  end;

  txt_Descricao.Text  := Silo.vDescricao;
  txt_Capacidade.Text := FormatFloat('##0.00', Silo.vcapacidade);

  txt_IDTradeExit(Sender);
  txt_IDGraoExit(Sender);
end;

procedure TfrmSiloCad.txt_CapacidadeKeyPress(Sender: TObject; var Key: Char);
begin
  Key := ApenasNumero(Key, txt_IDTrade.Text, True);
end;

procedure TfrmSiloCad.txt_IDGraoExit(Sender: TObject);
begin
  txt_Grao.Text := '';

  if trim(txt_IDGrao.Text) <> '' then begin
    if NOT Silo.vGrao.PesquisarGrao('ID', txt_IDGrao.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Grão Não Localizado'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDGrao.Text := '';
      abort;
    end;

    if Silo.vGrao.vStatus = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Grão Se Encontra Inativo'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDGrao.Text := '';
      abort;
    end;

    txt_Grao.Text := Silo.vGrao.vDescricao;
  end;
end;

procedure TfrmSiloCad.txt_IDGraoKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDGrao.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDGrao.Text);
end;

procedure TfrmSiloCad.txt_IDTradeExit(Sender: TObject);
begin
  txt_Trade.Text := '';

  if trim(txt_IDTrade.Text) <> '' then begin
    if NOT Silo.vTrade.PesquisarTrade('ID', txt_IDTrade.Text) then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Não Localizada'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDTrade.Text := '';
      abort;
    end;

    if Silo.vTrade.vStatus = 'Inativo' then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 + ' Trade Se Encontra Inativa'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      txt_IDTrade.Text := '';
      abort;
    end;

    txt_Trade.Text := Silo.vTrade.vDescricao;
  end;
end;

procedure TfrmSiloCad.txt_IDTradeKeyPress(Sender: TObject; var Key: Char);
begin
  Verificar_Pressed_Enter(Sender, Key);

  if trim(txt_IDTrade.Text) <> '' then
    Key := ApenasNumero(Key, txt_IDTrade.Text);
end;

procedure TfrmSiloCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Silo.Destroy;
end;

procedure TfrmSiloCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key= VK_F1) then
    btn_Pesq_Trade.Click;

  if (key= VK_F2) then
    btn_Pesq_Grao.Click;
end;

end.
