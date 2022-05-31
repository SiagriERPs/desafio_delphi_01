unit uGraoCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfrmGraoCons = class(TForm)
    grp_Filtros: TGroupBox;
    txt_Filtro: TEdit;
    lbl_Tipo: TLabel;
    grp_ListaGraos: TGroupBox;
    grd_ListaGraos: TDBGrid;
    btn_Salvar: TButton;
    btn_Fechar: TButton;
    cbo_Tipo: TComboBox;
    lbl_Filtro: TLabel;
    lbl_Info: TLabel;
    cbo_Status: TComboBox;
    lbl_Status: TLabel;
    lbl_Legenda: TLabel;
    pnl_CorLegenda: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraoCons: TfrmGraoCons;

implementation

{$R *.dfm}

end.
