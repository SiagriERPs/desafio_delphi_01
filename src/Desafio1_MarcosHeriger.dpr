program Desafio1_MarcosHeriger;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uGraoCad in 'uGraoCad.pas' {frmGraoCad},
  uGraoCons in 'uGraoCons.pas' {frmGraoCons},
  uTradeCons in 'uTradeCons.pas' {frmTradeCons};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGraoCad, frmGraoCad);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmGraoCons, frmGraoCons);
  Application.CreateForm(TfrmTradeCons, frmTradeCons);
  Application.Run;
end.
