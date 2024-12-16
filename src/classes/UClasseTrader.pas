unit UClasseTrader;

interface
  uses
    UClasseEmpresa, UControleDB,System.SysUtils;

  type
    /// <summary> Classe de criação de um trader</summary>
    TTrader = class
    private
     Fid   : string;
     FCNPJ : string;
     Fnome : string;
     FQtdeSilos : integer;
     FQtdeArmazenamento : double;
     Fcontrole : TControleDB;
    public
     property id : string read Fid write Fid;
     property CNPJ : string read FCNPJ write FCNPJ;
     property nome : string read Fnome write Fnome;
     property qtdeSilos : integer read FQtdeSilos write FQtdeSilos;
     property QtdeArmazenamento : double read FQtdeArmazenamento write FQtdeArmazenamento;

     constructor Create(pConexaoControleDB:TControleDB);
     destructor Destroy; override;

     function InserirTrader : Boolean;
     function AlterarTrader : Boolean;
     function ExcluirTrader : Boolean;
     function PesquisarTrader (pCodigo:string):TTrader;
  end;
implementation

{ TTrader }

function TTrader.AlterarTrader: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' UPDATE TTRADER SET ');
  FControle.sqlGlobal.SQL.Add(' TTRADER_NOME = :TTRADERNOME , ');
  FControle.sqlGlobal.SQL.Add(' TTRADER_CNPJ = :TTRADERCNPJ , ');
  Fcontrole.sqlGlobal.SQL.Add(' TTRADER_QTDE_SILOS = :TTRADERQTDESILOS , ');
  Fcontrole.sqlGlobal.SQL.Add(' TTRADER_ARMAZENAMENTO = :TTRADERARMAZENAMENTO ');
  FControle.sqlGlobal.SQL.Add(' WHERE TTRADER_ID = :TTRADERID ');

  FControle.sqlGlobal.ParamByName('TTRADERNOME').AsString := Self.Nome;
  FControle.sqlGlobal.ParamByName('TTRADERCNPJ').AsString := Self.CNPJ;
  FControle.sqlGlobal.ParamByName('TTRADERQTDESILOS').AsInteger := Self.qtdeSilos;
  Fcontrole.sqlGlobal.ParamByName('TTRADERARMAZENAMENTO').AsFloat := Self.QtdeArmazenamento;
  FControle.sqlGlobal.ParamByName('TPRODUTORID').AsString := Self.id;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TTrader.Create(pConexaoControleDB: TControleDB);
begin
  Fcontrole := pConexaoControleDB;
end;

destructor TTrader.Destroy;
begin

  inherited;
end;

function TTrader.ExcluirTrader: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' DELETE FROM TTRADER WHERE TTRADER_ID = :ID ');

  FControle.sqlGlobal.ParamByName('ID').AsString := Self.ID;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TTrader.InserirTrader: Boolean;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' INSERT INTO TTRADER (TTRADER_ID, TTRADER_NOME, TTRADER_CNPJ, TTRADER_QTDE_SILOS, TTRADER_ARMAZENAMENTO)');
  Fcontrole.sqlGlobal.SQL.Add(' VALUES (');
  Fcontrole.sqlGlobal.SQL.Add(' :TTRADER_ID , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TTRADER_NOME , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TTRADER_CNPJ, ');
  Fcontrole.sqlGlobal.SQL.Add(' :TTRADER_QTDE_SILOS, ');
  Fcontrole.sqlGlobal.SQL.Add(' :TTRADER_ARMAZENAMENTO ');
  Fcontrole.sqlGlobal.SQL.Add(' );');

  FControle.sqlGlobal.ParamByName('TTRADER_ID').AsString := TGUID.NewGuid.ToString();
  FControle.sqlGlobal.ParamByName('TTRADER_NOME').AsString := Self.nome;
  FControle.sqlGlobal.ParamByName('TTRADER_CNPJ').AsString := Self.CNPJ;
  FControle.sqlGlobal.ParamByName('TTRADER_QTDE_SILOS').AsInteger := Self.qtdeSilos;
  FControle.sqlGlobal.ParamByName('TTRADER_ARMAZENAMENTO').AsFloat := Self.QtdeArmazenamento;
  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TTrader.PesquisarTrader(pCodigo: string): TTrader;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' SELECT * FROM TTRADER WHERE TTRADER_CNPJ = :CNPJ)');
  Fcontrole.sqlGlobal.ParamByName('CNPJ').AsString := pCodigo;
end;

end.
