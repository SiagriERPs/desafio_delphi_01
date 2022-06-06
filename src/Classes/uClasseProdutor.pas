unit uClasseProdutor;

interface

uses
  System.SysUtils, Vcl.StdCtrls;

  type
  /// <summary> Classe de criação de um produtor</summary>
    TProdutor = class
      private
        fId   : Integer;
        fCNPJ : string;
        fNome : string;
        fStatus : string;
      public
        property vId : Integer read fId write fId;
        property vCNPJ : string read fCNPJ write fCNPJ;
        property vNome : string read fNome write fNome;
        property vStatus : string read fStatus write fStatus;

        function InserirProdutor : Boolean;
        function AlterarProdutor : Boolean;
        function ExcluirProdutor : Boolean;
        function MudarStatus     : Boolean;
        function PesquisarProdutor (vCampo, vValor : string):Boolean;
        function ValidarCNPJ(): Integer;
  end;
implementation

uses
   Data.DB, uDM;

{ TProdutor }

function TProdutor.InserirProdutor: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' INSERT INTO PRODUTOR(NOME, CNPJ, STATUS) VALUES(:vNOME, :vCNPJ, :vSTATUS) ';

  DM.qryGlobal.ParamByName('vNOME').AsString   := Self.vNome;
  DM.qryGlobal.ParamByName('vCNPJ').AsString   := Self.vCNPJ;
  DM.qryGlobal.ParamByName('vSTATUS').AsString := 'Ativo';

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TProdutor.AlterarProdutor: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE PRODUTOR SET NOME =:vNome, CNPJ =:vCNPJ ' +
    ' WHERE ID =:vId ';

  DM.qryGlobal.ParamByName('vNome').AsString := Self.vNome;
  DM.qryGlobal.ParamByName('vCNPJ').AsString := Self.vCNPJ;
  DM.qryGlobal.ParamByName('vId').asInteger  := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TProdutor.ExcluirProdutor: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' DELETE FROM TPRODUTOR WHERE TPRODUTOR_ID =:ID ';

  DM.qryGlobal.ParamByName('ID').asInteger := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TProdutor.MudarStatus: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE PRODUTOR SET STATUS =:vSTATUS WHERE ID =:vId ';

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

function TProdutor.ValidarCNPJ(): Integer;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' SELECT * FROM PRODUTOR WHERE CNPJ=:vCNPJ AND ID <> :vID ';
  DM.qryGlobal.ParamByName('vCNPJ').AsString := vCNPJ;
  DM.qryGlobal.ParamByName('vID').AsInteger  := vId;
  DM.qryGlobal.Open;
  DM.qryGlobal.Last;
  DM.qryGlobal.First;

  Result :=  DM.qryGlobal.RecordCount;
end;
function TProdutor.PesquisarProdutor(vCampo, vValor : string): Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' SELECT * FROM PRODUTOR WHERE ' + vCampo + ' =:v' +vCampo ;
  DM.qryGlobal.ParamByName('v'+vCampo).AsString := vValor;
  DM.qryGlobal.Open;
  DM.qryGlobal.First;

  vId     := DM.qryGlobal.FieldByName('ID').AsInteger;
  vCNPJ   := DM.qryGlobal.FieldByName('CNPJ').AsString;
  vNome   := DM.qryGlobal.FieldByName('NOME').AsString;
  vStatus := DM.qryGlobal.FieldByName('STATUS').AsString;

  Result := (not DM.qryGlobal.Eof);
end;
end.
