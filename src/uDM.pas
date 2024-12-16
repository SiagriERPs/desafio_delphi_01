unit uDM;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBSQL,System.StrUtils,
  IBX.IBCustomDataSet, IBX.IBQuery, inifiles,Vcl.Forms, Winapi.Windows, System.Types;

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
    qryContrato: TIBQuery;
    dsContrato: TDataSource;
    qryContratoID: TIntegerField;
    qryContratoQTDE_GERAL: TFloatField;
    qryContratoID_PRODUTOR: TIntegerField;
    qryContratoPRODUTOR: TIBStringField;
    qryContratoID_TRADE: TIntegerField;
    qryContratoTRADE: TIBStringField;
    qryContratoID_GRAO: TIntegerField;
    qryContratoGRAO: TIBStringField;
    qryContratoCNPJ: TIBStringField;
    qryInsert: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CriarINI();
    procedure Conectar_Banco_Firebird;
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.CriarINI();
var
  arq: TextFile;
  sDir, sArquivo:String;
  vIni : TIniFile;
  strSeparada: TArray<string>;
  x,y:Integer;
begin
  try
    x:=0; y:=0;
    sArquivo:= 'Config.ini';
    sDir := GetCurrentDir;
    strSeparada :=  SplitString(sDir, '\');
    sDir := '';

    while length(strSeparada) > x do begin
      if (strSeparada[x] = 'src') or (strSeparada[x] = 'bin') or (strSeparada[x] = 'data') then begin
        break;
      end;

      inc(x);
    end;

    while  y < x do begin
      if y = 0 then
        sDir := sDir+ strSeparada[y]
      else
        sDir := sDir +'\' + strSeparada[y];

      inc(y);
    end;

    AssignFile(arq, GetCurrentDir+'\'+sArquivo);
    Rewrite(arq);

    Writeln(arq, '[Banco]');
    Writeln(arq, 'Caminho='+ sDir + '\DATA\DBALIARE.FDB');
    Writeln(arq, 'User=SYSDBA');
    Writeln(arq, 'Pass=masterkey');
    CloseFile(arq);
  except
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Conectar_Banco_Firebird();
end;

procedure TDM.Conectar_Banco_Firebird;
var
  sDir, sArquivo, sNomeBanco, sUser, sPass :String;
  vIni : TIniFile;
begin
  Conexao.Connected := False;
  Trans.Active      := False;

  sArquivo:= 'Config.ini';
  sDir := ExtractFilePath(Application.ExeName);

  if not FileExists(sDir + '\' + sArquivo) then begin
    Application.MessageBox('Erro ao tentar localizar o banco de dados!!!', 'Desafio 1', MB_OK + MB_ICONERROR);
    CriarINI();
  end;

  vIni := TIniFile.Create(sDir + '\' + sArquivo);
  try
    sNomeBanco := vIni.ReadString('Banco', 'Caminho', '');
    sUser      := vIni.ReadString('Banco', 'User', '');
    sPass      := vIni.ReadString('Banco', 'Pass', '');
  finally
    vIni.Free;
  end;

  try
    Conexao.Params.Clear;
    Conexao.Params.add('user_name='+sUser);
    Conexao.Params.add('password='+sPass);
    Conexao.Params.add('lc_ctype=ISO8859_1');

    Conexao.DatabaseName:= sNomeBanco;
    Conexao.Connected:= True;
    Trans.Active:= True;
  except
    on e : Exception do begin
      MessageBeep(48);
      Application.MessageBox(PChar('Erro ao conectar-se ao banco de dados:' + #13 + e.Message + #13 + #13 + 'Verifique se o Firebird esta Ativo.' + #13 +
      'Verifique se o servidor está ligado.'),'Agus', MB_OK + MB_ICONERROR);
      Application.Terminate;
    end;
  end;
end;

end.
