program prjTrade;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDM in 'uDM.pas' {DM: TDataModule},
  uCadastro in 'uCadastro.pas' {frmCadastro},
  uGrao in 'uGrao.pas' {frmGrao},
  uProdutor in 'uProdutor.pas' {frmProdutor},
  uTrade in 'uTrade.pas' {frmTrade},
  uContrato in 'uContrato.pas' {frmContrato};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Projeto Trade';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmTrade, frmTrade);
  Application.CreateForm(TfrmContrato, frmContrato);
  Application.Run;
end.
