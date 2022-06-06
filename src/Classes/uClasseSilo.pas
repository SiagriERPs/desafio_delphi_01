unit uClasseSilo;

interface

uses
   System.SysUtils, Vcl.StdCtrls, uClasseGrao, uClasseTrade;

  type
  /// <summary> Classe de criação de um SILO</summary>
   TSilo = class
      private
        fId   : Integer;
        fDescricao  : string;
        fcapacidade : Double;
        fGrao       : TGrao;
        fTrade      : TTrade;
        fStatus : string;
      public
        Constructor Create;     // declaração do metodo construtor

        property vId         : Integer read fId write fId;
        property vDescricao  : string read fDescricao write fDescricao;
        property vcapacidade : Double read fcapacidade write fcapacidade;
        property vGrao       : TGrao read fGrao write fGrao;
        property vTrade      : TTrade read fTrade write fTrade;
        property vStatus     : string read fStatus write fStatus;

        Destructor  Destroy; Override; // declaração do metodo destrutor


        function InserirSilo : Boolean;
        function AlterarSilo: Boolean;
        function ExcluirSilo : Boolean;
        function MudarStatus : Boolean;
        function PesquisarSilo(vCampo, vValor : string):Boolean;
  end;
implementation

uses
   Data.DB, uDM;

{TSilo}

constructor TSilo.Create;
begin
  vGrao       := TGrao.Create;
  vTrade      := TTrade.Create;
end;

destructor TSilo.Destroy;
begin
  vGrao.Destroy;
  vTrade.Destroy;

  inherited;
end;

function TSilo.InserirSilo: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' INSERT INTO SILO(DESCRICAO, CAPACIDADE, ID_GRAO, ID_TRADE, STATUS) ' +
    ' VALUES(:vDESCRICAO, :vCAPACIDADE, :vID_GRAO, :vID_TRADE, :vSTATUS) ';

  DM.qryGlobal.ParamByName('vDESCRICAO').AsString := Self.vDescricao;
  DM.qryGlobal.ParamByName('vCAPACIDADE').asFloat := Self.vcapacidade;
  DM.qryGlobal.ParamByName('vID_GRAO').asInteger  := Self.vGrao.vId;
  DM.qryGlobal.ParamByName('vID_TRADE').asInteger := Self.vTrade.vId;
  DM.qryGlobal.ParamByName('vSTATUS').AsString    := 'Ativo';

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TSilo.AlterarSilo: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE SILO SET DESCRICAO =:vDescricao, CAPACIDADE =:vCapacidade, ' +
    '             ID_GRAO =:vGrao, ID_TRADE =:vTrade, STATUS =:vStatus  ' +
    ' WHERE (ID=:vID)';

  DM.qryGlobal.ParamByName('vDESCRICAO').AsString := Self.vDescricao;
  DM.qryGlobal.ParamByName('vCapacidade').asFloat := Self.vcapacidade;
  DM.qryGlobal.ParamByName('vGrao').asInteger     := Self.vGrao.vId;
  DM.qryGlobal.ParamByName('vTrade').asInteger    := Self.vTrade.vId;
  DM.qryGlobal.ParamByName('vStatus').AsString    := Self.vStatus;
  DM.qryGlobal.ParamByName('vID').asInteger       := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TSilo.MudarStatus: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE SILO SET STATUS =:vSTATUS WHERE ID =:vId ';

  DM.qryGlobal.ParamByName('vSTATUS').AsString := Self.vStatus;
  DM.qryGlobal.ParamByName('vId').asInteger    := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TSilo.ExcluirSilo: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' DELETE FROM SILO WHERE ID =:vID ';

  DM.qryGlobal.ParamByName('vID').asInteger := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TSilo.PesquisarSilo(vCampo, vValor : string):Boolean;
begin
  DM.qrySilo.Close;
  DM.qrySilo.SQL.Text :=
    ' SELECT s.id, s.descricao, s.capacidade, s.STATUS, ' +
    '        s.id_grao, g.descricao graos,              ' +
    '        s.id_trade, t.descricao Trades             ' +
    ' FROM SILO s                                       ' +
    ' INNER JOIN GRAO g on g.id = s.id_grao             ' +
    ' INNER JOIN TRADE t on t.id = s.id_trade           ' +
    ' WHERE s.ID=:vID ';
  DM.qrySilo.ParamByName('vID').AsString := vValor;
  DM.qrySilo.Open;
  DM.qrySilo.First;

  Self.vId        := DM.qrySilo.FieldByName('ID').AsInteger;
  Self.vDescricao := DM.qrySilo.FieldByName('DESCRICAO').AsString;
  Self.vcapacidade:= DM.qrySilo.FieldByName('CAPACIDADE').asFloat;
  Self.vStatus    := DM.qrySilo.FieldByName('STATUS').AsString;

  self.vGrao.PesquisarGrao('ID', DM.qrySilo.FieldByName('ID_GRAO').AsString);
  self.vTrade.PesquisarTrade('ID', DM.qrySilo.FieldByName('ID_TRADE').AsString);

  Result := (not DM.qrySilo.eof);
end;

end.
