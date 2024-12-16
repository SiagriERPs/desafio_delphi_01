unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    btn_Graos: TSpeedButton;
    btn_Produtor: TSpeedButton;
    B_OsConsulta: TSpeedButton;
    btn_Trade: TSpeedButton;
    B_Fechar: TSpeedButton;
    B_CC: TSpeedButton;
    procedure B_FecharClick(Sender: TObject);
    procedure btn_GraosClick(Sender: TObject);
    procedure btn_TradeClick(Sender: TObject);
    procedure B_CCClick(Sender: TObject);
    procedure btn_ProdutorClick(Sender: TObject);
    procedure B_OsConsultaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uGraoCons, uTradeCons, uSiloCons, uProdutorCons, uContratoCons;

procedure TForm1.btn_ProdutorClick(Sender: TObject);
begin
  if frmProdutorCons= nil then Application.CreateForm(TfrmProdutorCons, frmProdutorCons);
  frmProdutorCons.vForm := 'Novo';
  frmProdutorCons.ShowModal;
  FreeAndNil(frmProdutorCons);

end;

procedure TForm1.btn_TradeClick(Sender: TObject);
begin
  if frmTradeCons= nil then Application.CreateForm(TfrmTradeCons, frmTradeCons);
  frmTradeCons.vForm := 'Novo';
  frmTradeCons.ShowModal;
  FreeAndNil(frmTradeCons);
end;

procedure TForm1.B_CCClick(Sender: TObject);
begin
  if frmSiloCons = nil then Application.CreateForm(TfrmSiloCons, frmSiloCons);
  frmSiloCons.vForm := 'Novo';
  frmSiloCons.ShowModal;
  FreeAndNil(frmSiloCons);
end;

procedure TForm1.B_FecharClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja Sair do Sistema? ', 'Desafio 1', mb_YesNo + mb_IconQuestion) = mrYes then close;
end;

procedure TForm1.B_OsConsultaClick(Sender: TObject);
begin

  if frmContratoCons= nil then Application.CreateForm(TfrmContratoCons, frmContratoCons);
  frmContratoCons.vForm := 'Novo';
  frmContratoCons.ShowModal;
  FreeAndNil(frmContratoCons);
end;

procedure TForm1.btn_GraosClick(Sender: TObject);
begin
  if frmGraoCons= nil then Application.CreateForm(TfrmGraoCons, frmGraoCons);
  frmGraoCons.vForm := 'Novo';
  frmGraoCons.ShowModal;
  FreeAndNil(frmGraoCons);
end;

end.
