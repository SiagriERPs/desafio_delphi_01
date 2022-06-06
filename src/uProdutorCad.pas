unit uProdutorCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, uClasseProdutor, Vcl.Mask;

type
  TfrmProdutorCad = class(TForm)
    btn_Fechar: TBitBtn;
    btn_Salvar: TBitBtn;
    btn_Inativar: TBitBtn;
    ImageList1: TImageList;
    GroupBox3: TGroupBox;
    txt_Descricao: TEdit;
    lbl_Filtro: TLabel;
    Label3: TLabel;
    txt_CNPJ: TMaskEdit;
    procedure btn_SalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_InativarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Produtor : TProdutor;
    { Private declarations }
  public
    vForm, vID:String;
    { Public declarations }
  end;

var
  frmProdutorCad: TfrmProdutorCad;

implementation

{$R *.dfm}

uses uFuncoes_Globais, uTradeCons, uGraoCons;

procedure TfrmProdutorCad.FormShow(Sender: TObject);
begin
  Produtor  := TProdutor.Create;

  if vForm = 'Alteracao' then begin
    Produtor.PesquisarProdutor('ID', vID);

    if Produtor.vStatus = 'Ativo' then begin
      btn_Inativar.Caption := 'Inativar';
      ImageList1.GetBitmap(0, btn_Inativar.Glyph);
    end
    else begin
      btn_Inativar.Caption := 'Ativar';
      ImageList1.GetBitmap(1, btn_Inativar.Glyph);
    end;

    btn_Inativar.Visible := True;
  end;

  txt_Descricao.Text := Produtor.vNome;
  txt_CNPJ.Text      := Produtor.vCNPJ;
end;

procedure TfrmProdutorCad.btn_SalvarClick(Sender: TObject);
Var
  vSalvo :Boolean;
begin
  Validar_Campo_Obrigatorio(txt_Descricao);
  Validar_Campo_Obrigatorio(txt_CNPJ);

  Produtor.vNome := txt_Descricao.Text;
  Produtor.vCNPJ := RemoveCaractere(txt_CNPJ.Text);

  if Produtor.ValidarCNPJ() >= 1 then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +' Esse CNPJ já possui Cadastro'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  if vForm = 'Alteracao' then
    vSalvo := Produtor.AlterarProdutor
  else
    vSalvo := Produtor.InserirProdutor;

  if not vSalvo then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Salvar. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  close;
end;

procedure TfrmProdutorCad.btn_InativarClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Deseja Realmente ' + btn_Inativar.Caption + '?'),'Desafio 1', MB_ICONEXCLAMATION + MB_YESNOCANCEL) = mrYes then
  begin
    Produtor.vStatus := ifthen(btn_Inativar.Caption = 'Inativar','Inativo', 'Ativo');

    if not Produtor.MudarStatus then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Mudar o Status. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;

    close;
  end;
end;

procedure TfrmProdutorCad.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmProdutorCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Produtor.Destroy;
end;

end.
