unit uGraoCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uClasseGrao, StrUtils,
  Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TfrmGraoCad = class(TForm)
    GroupBox1: TGroupBox;
    txt_Descricao: TEdit;
    btn_Fechar: TBitBtn;
    btn_Salvar: TBitBtn;
    btn_Inativar: TBitBtn;
    ImageList1: TImageList;
    procedure btn_SalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_InativarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Grao: TGrao;
    { Private declarations }
  public
    vForm, vID :String;
    { Public declarations }
  end;

var
  frmGraoCad: TfrmGraoCad;

implementation

{$R *.dfm}

uses uFuncoes_Globais;

procedure TfrmGraoCad.btn_SalvarClick(Sender: TObject);
Var
  vSalvo :Boolean;
begin
  Validar_Campo_Obrigatorio(txt_Descricao);

  Grao.vDescricao := txt_Descricao.Text;

  if vForm = 'Alteracao' then
    vSalvo := Grao.AlterarGrao
  else
    vSalvo := Grao.InserirGrao;

  if not vSalvo then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Salvar. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  close;
end;

procedure TfrmGraoCad.btn_InativarClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Deseja Realmente ' + btn_Inativar.Caption + '?'),'Desafio 1', MB_ICONEXCLAMATION + MB_YESNOCANCEL) = mrYes then
  begin
    grao.vStatus := ifthen(btn_Inativar.Caption = 'Inativar','Inativo', 'Ativo');

    if not Grao.MudarStatus then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Mudar o Status. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;

    close;
  end;
end;

procedure TfrmGraoCad.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmGraoCad.FormShow(Sender: TObject);
begin
  Grao := TGrao.Create;

  if vForm = 'Alteracao' then begin
    Grao.PesquisarGrao('ID', vID);

    if Grao.vStatus = 'Ativo' then begin
      btn_Inativar.Caption := 'Inativar';
      ImageList1.GetBitmap(0, btn_Inativar.Glyph);
    end
    else begin
      btn_Inativar.Caption := 'Ativar';
      ImageList1.GetBitmap(1, btn_Inativar.Glyph);
    end;

    btn_Inativar.Visible := True;
  end;

  txt_Descricao.Text := Grao.vDescricao;
end;

procedure TfrmGraoCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Grao.Destroy;
end;

end.
