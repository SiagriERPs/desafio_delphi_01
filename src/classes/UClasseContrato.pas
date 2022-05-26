unit UClasseContrato;

interface

uses
  UControleDB,System.SysUtils;
  type
    /// <summary> Classe de criação de um contrato</summary>
    TContrato = class
    private
      FContratoID: string;
      FProdutorID: string;
      FTraderID:   string;
      FNomeProduto:string;
      FTipoGrao: string;
      FDataContrato: Tdatetime;
      FKGGrao: Double;
      Fcontrole :TControleDB;
    public
      property ContratoID : string read FContratoID write FContratoID;
      property ProdutorID: string read FProdutorID write FProdutorID;
      property TraderID: string read FTraderID write FTraderID;
      property NomeProduto: string read FNomeProduto write FNomeProduto;
      property TipoGrao: string read FTipoGrao write FTipoGrao;
      property DataContrato: Tdatetime read FDataContrato write FDataContrato;
      property KGGrao: double read FKGGrao write FKGGrao;

      constructor Create(pConexaoControleDB:TControleDB);
      destructor Destroy; override;

      function InserirContrato : Boolean;
      function AlterarContrato : Boolean;
      function ExcluirContrato : Boolean;
      function PesquisarContrato (pCodigo:string):TContrato;
  end;
implementation

{ TContrato }

function TContrato.AlterarContrato: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' UPDATE TCONTRATO SET ');
  FControle.sqlGlobal.SQL.Add(' TCONTRATO_ID_PRODUTOR = :TCONTRATOIDPRODUTOR , ');
  FControle.sqlGlobal.SQL.Add(' TCONTRATO_ID_TRADER = :TCONTRATOIDTRADER , ');
  FControle.sqlGlobal.SQL.Add(' TCONTRATO_NOME_PROD = :TCONTRATONOMEPROD , ');
  FControle.sqlGlobal.SQL.Add(' TCONTRATO_TIPO_GRAO = :TCONTRATOTIPOGRAO , ');
  FControle.sqlGlobal.SQL.Add(' TCONTRATO_KG_GRAO = :TCONTRATOKGGRAO  ');
  FControle.sqlGlobal.SQL.Add(' WHERE TCONTRATO_ID = :TCONTRATOID ');

  FControle.sqlGlobal.ParamByName('TCONTRATOIDPRODUTOR').AsString := Self.ProdutorID;
  FControle.sqlGlobal.ParamByName('TCONTRATOIDTRADER').AsString := Self.TraderID;
  FControle.sqlGlobal.ParamByName('TCONTRATONOMEPROD').AsString := Self.NomeProduto;
  FControle.sqlGlobal.ParamByName('TCONTRATOTIPOGRAO').AsString := Self.TipoGrao;
  FControle.sqlGlobal.ParamByName('TCONTRATOKGGRAO').AsFloat := Self.KGGrao;
  Fcontrole.sqlGlobal.ParamByName('TCONTRATOID').AsString := Self.ContratoID;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TContrato.Create(pConexaoControleDB: TControleDB);
begin
  Fcontrole := pConexaoControleDB;
end;

destructor TContrato.Destroy;
begin
  inherited;
end;

function TContrato.ExcluirContrato: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' DELETE FROM TCONTRATO WHERE TCONTRATO_ID = :ID ');

  FControle.sqlGlobal.ParamByName('ID').AsString := Self.ContratoID;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TContrato.InserirContrato: Boolean;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' INSERT INTO TCONTRATO (TCONTRATO_ID, TCONTRATO_ID_PRODUTOR, TCONTRATO_ID_TRADER,TCONTRATO_NOME_PROD, TCONTRATO_TIPO_GRAO, TCONTRATO_DATA_CONTRATO,TCONTRATO_KG_GRAO )');
  Fcontrole.sqlGlobal.SQL.Add(' VALUES (');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_ID , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_ID_PRODUTOR , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_ID_TRADER , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_NOME_PROD , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_TIPO_GRAO , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_DATA_CONTRATO, ');
  Fcontrole.sqlGlobal.SQL.Add(' :TCONTRATO_KG_GRAO ');
  Fcontrole.sqlGlobal.SQL.Add(' );');

  FControle.sqlGlobal.ParamByName('TCONTRATO_ID').AsString := TGUID.NewGuid.ToString();
  FControle.sqlGlobal.ParamByName('TCONTRATO_ID_PRODUTOR').AsString := Self.ProdutorID;
  FControle.sqlGlobal.ParamByName('TCONTRATO_ID_TRADER').AsString := Self.TraderID;
  FControle.sqlGlobal.ParamByName('TCONTRATO_NOME_PROD').AsString := Self.NomeProduto;
  FControle.sqlGlobal.ParamByName('TCONTRATO_TIPO_GRAO').AsString := SelF.TipoGrao;
  FControle.sqlGlobal.ParamByName('TCONTRATO_DATA_CONTRATO').AsDateTime := Self.DataContrato;
  FControle.sqlGlobal.ParamByName('TCONTRATO_KG_GRAO').AsFloat := Self.KGGrao;


  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TContrato.PesquisarContrato(pCodigo: string): TContrato;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' SELECT * FROM TCONTRATO WHERE TCONTRATO_ID = :ID)');
  Fcontrole.sqlGlobal.ParamByName('ID').AsString := pCodigo;
end;

end.
