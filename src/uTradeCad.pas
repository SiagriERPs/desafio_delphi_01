unit uTradeCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uClasseTrade, StrUtils,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TfrmTradeCad = class(TForm)
    GroupBox1: TGroupBox;
    txt_Descricao: TEdit;
    btn_Fechar: TBitBtn;
    btn_Salvar: TBitBtn;
    btn_Inativar: TBitBtn;
    ImageList1: TImageList;
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_InativarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    Trade : TTrade;
    { Private declarations }
  public
    vForm, vID :String;
    { Public declarations }
  end;

var
  frmTradeCad: TfrmTradeCad;

implementation

{$R *.dfm}

uses uFuncoes_Globais;

procedure TfrmTradeCad.FormShow(Sender: TObject);
begin
  Trade := TTrade.Create;

  if vForm = 'Alteracao' then begin
    Trade.PesquisarTrade('ID', vID);

    if Trade.vStatus = 'Ativo' then begin
      btn_Inativar.Caption := 'Inativar';
      ImageList1.GetBitmap(0, btn_Inativar.Glyph);
    end
    else begin
      btn_Inativar.Caption := 'Ativar';
      ImageList1.GetBitmap(1, btn_Inativar.Glyph);
    end;

    btn_Inativar.Visible := True;
  end;

  txt_Descricao.Text := Trade.vDescricao;
end;

procedure TfrmTradeCad.btn_SalvarClick(Sender: TObject);
Var
  vSalvo :Boolean;
begin
  Validar_Campo_Obrigatorio(txt_Descricao);

  Trade.vDescricao := txt_Descricao.Text;

  if vForm = 'Alteracao' then
    vSalvo := Trade.AlterarTrade
  else
    vSalvo := Trade.InserirTrade;

  if not vSalvo then begin
    Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Salvar. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    abort;
  end;

  close;
end;

procedure TfrmTradeCad.btn_InativarClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Deseja Realmente ' + btn_Inativar.Caption + '?'),'Desafio 1', MB_ICONEXCLAMATION + MB_YESNO) = mrYes then
  begin
    Trade.vStatus := ifthen(btn_Inativar.Caption = 'Inativar','Inativo', 'Ativo');

    if not Trade.MudarStatus then begin
      Application.MessageBox(PWideChar('ATENÇÃO!!' + #13 +'Erro ao Mudar o Status. Tente Novamente'), 'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;

    close;
  end;
end;

procedure TfrmTradeCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Trade.Destroy;
end;

procedure TfrmTradeCad.btn_FecharClick(Sender: TObject);
begin
  close;
end;

end.
