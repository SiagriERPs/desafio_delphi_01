unit uTradeCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmTradeCons = class(TForm)
    grp_Filtros: TGroupBox;
    lbl_Tipo: TLabel;
    lbl_Filtro: TLabel;
    lbl_Status: TLabel;
    txt_Filtro: TEdit;
    cbo_Tipo: TComboBox;
    cbo_Status: TComboBox;
    grp_ListaTrades: TGroupBox;
    lbl_Info: TLabel;
    lbl_Legenda: TLabel;
    grd_ListaTrades: TDBGrid;
    pnl_CorLegenda: TPanel;
    btn_Salvar: TButton;
    btn_Fechar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTradeCons: TfrmTradeCons;

implementation

{$R *.dfm}

end.
