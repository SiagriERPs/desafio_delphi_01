unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Menus, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.OleCtrls, SHDocVw,
  UControleDB, Vcl.Mask, UClasseContrato, UClasseEmpresa, UClasseTrader, UConexaoDB,UFuncoesBasicas,
  Vcl.Samples.Spin, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, UEditarContrato,Printers,
  UFrProdutor,  UFrTrader, UFrContrato, UFrGerenciarContratos;


type
  TForm1 = class(TForm)
    pgMain: TPageControl;
    tsProdutor: TTabSheet;
    tsTrader: TTabSheet;
    tsNovoContrato: TTabSheet;
    tsGerenciarContratos: TTabSheet;
    pnlMenu: TPanel;
    btnSair: TSpeedButton;
    btnNovoContrato: TSpeedButton;
    btnNovoTrader: TSpeedButton;
    btnNovoProdutor: TSpeedButton;
    btnMenu: TSpeedButton;
    btnGerenciarContratos: TSpeedButton;
    procedure btnMenuClick(Sender: TObject);
    procedure btnNovoProdutorClick(Sender: TObject);
    procedure btnNovoTraderClick(Sender: TObject);
    procedure btnNovoContratoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGerenciarContratosClick(Sender: TObject);
  private
    { Private declarations }
    FControleDBTProdutor, FControleDBTTrader, FControleDBTContrato, FControleGerenciarContrato : TControleDB;
    frProdutor : TFrProdutor;
    frTrader : TFrTrader;
    frContrato : TFrContrato;
    frGerenciarContratos : TFrGerenciarContratos;
    procedure CarregarFrames;
    procedure menu;
    procedure tabsInsiviveis;
    procedure tabInicial;
    procedure sair;
    procedure iniciarControleDb;
    procedure terminarControleDb;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  xExpandido : Boolean;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  xExpandido := true;
  tabsInsiviveis;
  tabInicial;
  iniciarControleDb;

  CarregarFrames;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  terminarControleDb;
end;

procedure TForm1.iniciarControleDb;
begin
  FControleDBTProdutor := TControleDB.Create;
  FControleDBTTrader := TControleDB.Create;
  FControleDBTContrato := TControleDB.Create;
  FControleGerenciarContrato := TControleDB.Create;
end;

procedure TForm1.menu;
begin
  if xExpandido then
    pnlMenu.Width := 43
  else
    pnlMenu.Width := 201;

  xExpandido := not xExpandido;
end;

procedure TForm1.sair;
begin
   if MessageDlg('Deseja realmente sair do sistema?' ,mtConfirmation, [mbYes,mbNo],0) = mrYes then
    Application.Terminate;
end;

procedure TForm1.tabInicial;
begin
  pgMain.ActivePage := tsGerenciarContratos;
end;

procedure TForm1.tabsInsiviveis;
begin
  tsProdutor.TabVisible := false;
  tsTrader.TabVisible := false;
  tsNovoContrato.TabVisible := false;
  tsGerenciarContratos.TabVisible := false;
end;

procedure TForm1.terminarControleDb;
begin
  FControleDBTProdutor.Free;
  FControleDBTTrader.Free;
  FControleDBTContrato.Free;
  FControleGerenciarContrato.Free;
end;

procedure TForm1.btnSairClick(Sender: TObject);
begin
  sair;
end;

procedure TForm1.CarregarFrames;
begin
  frProdutor := TFrProdutor.create(Application,FControleDBTProdutor);
  frProdutor.Parent := tsProdutor;

  frTrader := TFrTrader.create(Application,FControleDBTTrader);
  frTrader.Parent := tsTrader;

  frContrato  := TFrContrato.create(Application, FControleDBTContrato);
  frContrato.Parent := tsNovoContrato;

  frGerenciarContratos := TfrGerenciarContratos.create(Application, FControleGerenciarContrato);
  frGerenciarContratos.Parent := tsGerenciarContratos;
end;

procedure TForm1.btnNovoContratoClick(Sender: TObject);
begin
  pgMain.ActivePageIndex := 2;
end;

procedure TForm1.btnNovoTraderClick(Sender: TObject);
begin
  pgMain.ActivePageIndex := 1;
  frTrader.atualizaGridTrader;
end;

procedure TForm1.btnNovoProdutorClick(Sender: TObject);
begin
  pgMain.ActivePageIndex := 0;
  frProdutor.atualizaGridProdutor;
end;

procedure TForm1.btnMenuClick(Sender: TObject);
begin
  menu;
end;

procedure TForm1.btnGerenciarContratosClick(Sender: TObject);
begin
  pgMain.ActivePageIndex := 3;
  frGerenciarContratos.atualizaGrid;
end;

end.
