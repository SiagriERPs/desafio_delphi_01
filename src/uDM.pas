unit uDM;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBSQL,
  IBX.IBCustomDataSet, IBX.IBQuery;

type
  TDM = class(TDataModule)
    Conexao: TIBDatabase;
    Trans: TIBTransaction;
    qryGlobal: TIBQuery;
    qryGraos: TIBQuery;
    dsGraos: TDataSource;
    qryGraosID: TIntegerField;
    qryGraosDESCRICAO: TIBStringField;
    qryGraosSTATUS: TIBStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
