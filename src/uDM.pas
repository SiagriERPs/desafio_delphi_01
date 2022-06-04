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
    qrySilo: TIBQuery;
    dsSilo: TDataSource;
    qrySiloID: TIntegerField;
    qrySiloDESCRICAO: TIBStringField;
    qrySiloCAPACIDADE: TFloatField;
    qrySiloSTATUS: TIBStringField;
    qrySiloID_GRAO: TIntegerField;
    qrySiloGRAOS: TIBStringField;
    qrySiloID_TRADE: TIntegerField;
    qrySiloTRADES: TIBStringField;
    qryProdutor: TIBQuery;
    dsProdutor: TDataSource;
    qryProdutorID: TIntegerField;
    qryProdutorNOME: TIBStringField;
    qryProdutorCNPJ: TIBStringField;
    qryProdutorSTATUS: TIBStringField;
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
