unit UPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,UControleDB, UConexaoDB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfmPesquisar = class(TForm)
    dbGrid: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    edtCNPJPesquisa: TMaskEdit;
    Panel2: TPanel;
    Button2: TButton;
    Button3: TButton;
    rgPesquisa: TRadioGroup;
    dsQry: TDataSource;
    qry: TFDQuery;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FId: string;
    tipoPesquisa:string;
  public

    { Public declarations }
//    constructor create(AOwner: Tcomponent; const pTipo:string); reintroduce;
    procedure configurar(const ptipo: string);
    property id : string read fId;
  end;

var
  fmPesquisar: TfmPesquisar;
  controleDBPesquisa : TConexaoDB;
implementation


{$R *.dfm}


{ TForm2 }


procedure TfmPesquisar.Button1Click(Sender: TObject);
begin
  if tipoPesquisa = 'produtor' then
  begin
    qry.Open('select tprodutor_id as id, tprodutor_cnpj as CNPJ, tprodutor_nome as Nome from tprodutor where tprodutor_cnpj = :cnpj', [edtCNPJPesquisa.Text]);
  end else
  if tipoPesquisa = 'trader' then
  begin
    qry.Open('select ttarder_id as id, ttrader_cnpj as CNPJ, trader_nome as Nome from ttrader where trader_cnpj = :cnpj', [edtCNPJPesquisa.Text]);
  end else
  if tipoPesquisa = 'contrato' then
  begin

  end;
end;

procedure TfmPesquisar.Button2Click(Sender: TObject);
begin
  if qry.RecNo = 0 then Exit;

  ModalResult := mrOk;
  FId := qry.FieldByName('id').AsString;
end;

procedure TfmPesquisar.Button3Click(Sender: TObject);
begin
  FId := EmptyStr;
  ModalResult := mrCancel;
  Close;
end;

procedure TfmPesquisar.configurar(const ptipo: string);
begin
  controleDBPesquisa := TConexaoDB.Create;
  tipoPesquisa := ptipo;
  if ptipo = 'produtor' then
  begin
    rgPesquisa.Visible := false;
    qry.Connection := controleDBPesquisa.GetConexao;
    qry.Open('select tprodutor_id as id, tprodutor_cnpj as CNPJ, tprodutor_nome as Nome from tprodutor');

    dbGrid.Columns[0].Title.Caption := 'CNPJ';
    dbGrid.Columns[0].FieldName := 'CNPJ';
    dbGrid.Columns[1].Title.Caption := 'Nome';
    dbGrid.Columns[1].FieldName := 'Nome';
  end
  else if ptipo = 'trader' then
  begin
    rgPesquisa.Visible := false;
    rgPesquisa.Visible := false;
    qry.Connection := controleDBPesquisa.GetConexao;
    qry.Open('select ttrader_id as id, ttrader_cnpj as CNPJ, ttrader_nome as Nome from trader');

    dbGrid.Columns[0].Title.Caption := 'CNPJ';
    dbGrid.Columns[0].FieldName := 'CNPJ';
    dbGrid.Columns[1].Title.Caption := 'Nome';
    dbGrid.Columns[1].FieldName := 'Nome';

  end
  else if ptipo = 'contrato' then
  begin

  end;
end;

procedure TfmPesquisar.FormDestroy(Sender: TObject);
begin
//  controleDBPesquisa.Free;
end;

end.
