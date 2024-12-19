unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDM, uGrao, uProdutor, uTrade, uContrato;

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  try
    if not Assigned(frmProdutor) then
      Application.CreateForm(TfrmProdutor, frmProdutor);
    frmProdutor.ShowModal;
  finally
    frmProdutor := nil;
  end;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  try
    if not Assigned(frmTrade) then
      Application.CreateForm(TfrmTrade, frmTrade);
    frmTrade.ShowModal;
  finally
    frmTrade := nil;
  end;
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  try
    if not Assigned(frmGrao) then
      Application.CreateForm(TfrmGrao, frmGrao);
    frmGrao.ShowModal;
  finally
    frmGrao := nil;
  end;
end;

procedure TfrmPrincipal.Button4Click(Sender: TObject);
begin
  try
    if not Assigned(frmContrato) then
      Application.CreateForm(TfrmContrato, frmContrato);
    frmContrato.ShowModal;
  finally
    frmGrao := nil;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM := Nil;
  Application.Terminate;
end;

end.
