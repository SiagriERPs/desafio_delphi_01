unit UClasseEmpresa;

interface

uses
  UControleDB,System.SysUtils;

  type
  /// <summary> Classe de criação de um produtor</summary>
    TProdutor = class
      private
        Fid   : string;
        FCNPJ : string;
        Fnome : string;
        Fcontrole :TControleDB;
      public
        property id : string read Fid write Fid;
        property CNPJ : string read FCNPJ write FCNPJ;
        property nome : string read Fnome write Fnome;

        constructor Create(pConexaoControleDB:TControleDB);
        destructor Destroy; override;

        function InserirProdutor : Boolean;
        function AlterarProdutor : Boolean;
        function ExcluirProdutor : Boolean;
        function PesquisarProdutor (pCodigo:string):TProdutor;
  end;
implementation

uses
   Data.DB;

{ TProdutor }

function TProdutor.AlterarProdutor: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' UPDATE TPRODUTOR SET ');
  FControle.sqlGlobal.SQL.Add(' TPRODUTOR_NOME = :TPRODUTORNOME , ');
  FControle.sqlGlobal.SQL.Add(' TPRODUTOR_CNPJ = :TPRODUTORCNPJ , ');
  FControle.sqlGlobal.SQL.Add(' WHERE TPRODUTOR_ID = :TPRODUTORID ');

  FControle.sqlGlobal.ParamByName('TPRODUTORNOME').AsString := Self.Nome;
  FControle.sqlGlobal.ParamByName('TPRODUTORCNPJ').AsString := Self.CNPJ;
  FControle.sqlGlobal.ParamByName('TPRODUTORID').AsString := Self.ID;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TProdutor.Create(pConexaoControleDB: TControleDB);
begin
  Fcontrole := pConexaoControleDB;
end;

destructor TProdutor.Destroy;
begin
  inherited;
end;

function TProdutor.ExcluirProdutor: Boolean;
begin
  FControle.sqlGlobal.Close;

  FControle.sqlGlobal.SQL.Clear;
  FControle.sqlGlobal.SQL.Add(' DELETE FROM TPRODUTOR WHERE TPRODUTOR_ID = :ID ');

  FControle.sqlGlobal.ParamByName('ID').AsString := Self.ID;

  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TProdutor.InserirProdutor: Boolean;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' INSERT INTO TPRODUTOR (TPRODUTOR_ID, TPRODUTOR_NOME, TPRODUTOR_CNPJ)');
  Fcontrole.sqlGlobal.SQL.Add(' VALUES (');
  Fcontrole.sqlGlobal.SQL.Add(' :TPRODUTOR_ID , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TPRODUTOR_NOME , ');
  Fcontrole.sqlGlobal.SQL.Add(' :TPRODUTOR_CNPJ ');
  Fcontrole.sqlGlobal.SQL.Add(' );');

  FControle.sqlGlobal.ParamByName('TPRODUTOR_ID').AsString := TGUID.NewGuid.ToString();
  FControle.sqlGlobal.ParamByName('TPRODUTOR_NOME').AsString := Self.nome;
  FControle.sqlGlobal.ParamByName('TPRODUTOR_CNPJ').AsString := Self.CNPJ;
  try
    FControle.sqlGlobal.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TProdutor.PesquisarProdutor(pCodigo: string): TProdutor;
begin
  Fcontrole.sqlGlobal.Close;
  Fcontrole.sqlGlobal.SQL.Clear;
  Fcontrole.sqlGlobal.SQL.Add(' SELECT * FROM TPRODUTOR WHERE TPRODUTOR_CNPJ = :CNPJ)');
  Fcontrole.sqlGlobal.ParamByName('CNPJ').AsString := pCodigo;
end;

end.
