unit uClasseGrao;

interface

uses
   System.SysUtils, Vcl.StdCtrls;

  type
  /// <summary> Classe de criação de um grão</summary>
    TGrao = class
      private
        fId   : Integer;
        fDescricao : string;
        fStatus : string;
      public

        property vId : Integer read fId write fId;
        property vDescricao: string read fDescricao write fDescricao;
        property vStatus: string read fStatus write fStatus;

        function InserirGrao : Boolean;
        function AlterarGrao : Boolean;
        function ExcluirGrao : Boolean;
        function MudarStatus : Boolean;
        function PesquisarGrao(vCampo, vValor : string):Boolean;
  end;
implementation

uses
   Data.DB, uDM;

{ TGrao }
function TGrao.InserirGrao: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' INSERT INTO GRAO(DESCRICAO, STATUS) VALUES(:vDescricao, :vStatus) ';

  DM.qryGlobal.ParamByName('vDESCRICAO').AsString := Self.vDescricao;
  DM.qryGlobal.ParamByName('vStatus').AsString    := 'Ativo';
  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TGrao.AlterarGrao: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE GRAO SET DESCRICAO =:vDescricao WHERE ID =:vId ';

  DM.qryGlobal.ParamByName('vDescricao').AsString := Self.vDescricao;
  DM.qryGlobal.ParamByName('vId').asInteger       := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TGrao.MudarStatus: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    ' UPDATE GRAO SET STATUS =:vSTATUS WHERE ID =:vId ';

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

function TGrao.ExcluirGrao: Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' DELETE FROM GRAO WHERE ID =:vID ';

  DM.qryGlobal.ParamByName('vID').asInteger := Self.vId;

  try
    DM.qryGlobal.ExecSQL;
    DM.Trans.CommitRetaining;
    Result := True;
  except
    Result := False;
  end;
end;

function TGrao.PesquisarGrao(vCampo, vValor : string): Boolean;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text := ' SELECT * FROM GRAO WHERE ' + vCampo + ' =:v' +vCampo ;
  DM.qryGlobal.ParamByName('v'+vCampo).AsString := vValor;
  DM.qryGlobal.Open;
  DM.qryGlobal.First;

  Self.vId        := DM.qryGlobal.FieldByName('ID').AsInteger;
  Self.vDescricao := DM.qryGlobal.FieldByName('DESCRICAO').AsString;
  Self.vStatus    := DM.qryGlobal.FieldByName('STATUS').AsString;

  Result := (not DM.qryGlobal.Eof);
end;

end.
