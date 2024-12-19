unit uProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastro, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmProdutor = class(TfrmCadastro)
    qrCadastroID: TIntegerField;
    qrCadastroCNPJ: TStringField;
    qrCadastroNOME: TStringField;
    Label1: TLabel;
    edId: TDBEdit;
    Label2: TLabel;
    edCNPJ: TDBEdit;
    Label3: TLabel;
    edNome: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutor: TfrmProdutor;

implementation

{$R *.dfm}

end.
