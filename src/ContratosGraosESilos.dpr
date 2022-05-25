program ContratosGraosESilos;

uses
  Vcl.Forms,
  UMain in 'main\UMain.pas' {Form1},
  UClasseContrato in 'classes\UClasseContrato.pas',
  UClasseEmpresa in 'classes\UClasseEmpresa.pas',
  UClasseTrader in 'classes\UClasseTrader.pas',
  UConexaoDB in 'Db\UConexaoDB.pas',
  UControleDB in 'Db\UControleDB.pas',
  UFuncoesBasicas in 'funcoes\UFuncoesBasicas.pas',
  UEditarContrato in 'Forms\UEditarContrato.pas' {FmEditarContrato},
  UFrProdutor in 'Frames\UFrProdutor.pas' {FrProdutor: TFrame},
  UFrTrader in 'Frames\UFrTrader.pas' {FrTrader: TFrame},
  UFrContrato in 'Frames\UFrContrato.pas' {FrContrato: TFrame},
  UFrGerenciarContratos in 'Frames\UFrGerenciarContratos.pas' {FrGerenciarContratos: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
