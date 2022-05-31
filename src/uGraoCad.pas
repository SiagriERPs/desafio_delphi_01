unit uGraoCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmGraoCad = class(TForm)
    GroupBox1: TGroupBox;
    txt_Descricao: TEdit;
    btn_Salvar: TButton;
    btn_Fechar: TButton;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraoCad: TfrmGraoCad;

implementation

{$R *.dfm}

end.
