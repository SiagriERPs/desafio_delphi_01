unit UConexaoDB;

interface


uses

  SqlExpr, inifiles, SysUtils, Forms, FireDAC.Comp.Client, FireDAC.Phys.FB,
  System.Classes, Data.DBXInterBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  /// <summary> Classe de conexão com o db</summary>
   TConexaoDB = class
    private
      FConexaoDB : TFDConnection;
    public
      constructor Create;
      destructor  Destroy; override;
      function GetConexao : TFDConnection;
      property ConexaoDB : TFDConnection   read GetConexao;
   end;

implementation
{ TConexaoDB }

constructor TConexaoDB.Create;
var
  arquivoINI, servidor, path, driverName, userName, password : string;
  localServer : Integer;
  configuracoes : TIniFile;
begin
  arquivoINI := ExtractFilePath(Application.ExeName) + 'config.ini';

  if not FileExists(arquivoINI) then
  begin
    raise Exception.Create('Arquivo de Config não Encontrado - Entre em contato como suporte técnico!');
    Exit;

  end;

  Configuracoes := TIniFile.Create(ArquivoINI);
  Try
    servidor   := Configuracoes.ReadString('database', 'Servidor',   Servidor);
    path       := Configuracoes.ReadString('database', 'DataBase',   path);
    driverName := Configuracoes.ReadString('database', 'DriverName', DriverName);
    userName   := Configuracoes.ReadString('database', 'UserName',   UserName);
    password   := Configuracoes.ReadString('database', 'PassWord',   PassWord);
  Finally
    Configuracoes.Free;
  end;

  try
   FConexaoDB := TFDConnection.Create(nil);
   FConexaoDB.DriverName     := 'FB';
   FConexaoDB.LoginPrompt    := False;

   FConexaoDB.Connected  := False;
   FConexaoDB.Params.Values['Servidor'] := servidor;
   FConexaoDB.Params.Values['DataBase']   := path;
   FConexaoDB.Params.Values['User_Name']  := userName;
   FConexaoDB.Params.Values['Password']   := passWord;
   FConexaoDB.Connected  := True;
  except
    raise Exception.Create('Erro ao Conectar o Banco de dados. Verifique as informações do Config.ini!');
  end;
end;

destructor TConexaoDB.Destroy;
begin
  FConexaoDB.Free;

  inherited;
end;

function TConexaoDB.GetConexao: TFDConnection;
begin
  Result := FConexaoDB;
end;

end.
