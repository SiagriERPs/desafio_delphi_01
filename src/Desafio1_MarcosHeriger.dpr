program Desafio1_MarcosHeriger;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uGraoCad in 'uGraoCad.pas' {frmGraoCad},
  uGraoCons in 'uGraoCons.pas' {frmGraoCons},
  uTradeCons in 'uTradeCons.pas' {frmTradeCons},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFuncoes_Globais in 'Funcoes_Globais\uFuncoes_Globais.pas',
  uClasseProdutor in 'Classes\uClasseProdutor.pas',
  uClasseGrao in 'Classes\uClasseGrao.pas',
  uTradeCad in 'uTradeCad.pas' {frmTradeCad},
  uClasseTrade in 'Classes\uClasseTrade.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
