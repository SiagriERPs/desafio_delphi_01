unit UControleDB;

interface

uses
   Windows, Messages, SysUtils, Classes,  Controls, Forms, Dialogs,
   Variants, Contnrs, SqlExpr,  StrUtils, inifiles,UConexaoDB,
  FireDAC.Comp.Client;

type
  /// <summary> Classe de manipulação para acesso a dados</summary>
  TControleDB = class
  private
    FConexao  : TConexaoDB;
    FSqlGglobal : TFDQuery;
  public
    constructor Create;
    destructor  Destroy; override;
    property sqlGlobal : TFDQuery read FSqlGglobal write FSqlGglobal;
  end;

implementation
{ TControleDB }

constructor TControleDB.Create;
begin
  FConexao  := TConexaoDB.Create;
  FSqlGglobal := TFDQuery.Create(Application);
  FSqlGglobal.Connection := FConexao.ConexaoDB;
end;

destructor TControleDB.Destroy;
begin
  inherited;
end;

end.
