unit uFuncoes_Globais;

interface

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Winapi.Windows;

procedure Validar_Campo_Obrigatorio(Sender: TObject; vMensagem:String = 'Atenção Campo Obrigatório');
function ApenasNumero(Key: Char; Texto: string; EhDecimal: Boolean = False; DecimalSeparator :Char = ','): Char;

implementation


procedure Validar_Campo_Obrigatorio(Sender: TObject; vMensagem:String = 'Atenção Campo Obrigatório');
begin
  if trim(TEdit(Sender).Text) = '' then begin
    Application.MessageBox(PWideChar(vMensagem),'Desafio 1', MB_ICONEXCLAMATION + MB_OK);
    TEdit(Sender).SetFocus;
    Abort;
  end;
end;

function ApenasNumero(Key: Char; Texto: string; EhDecimal: Boolean = False; DecimalSeparator :Char = ','): Char;
begin
  if  not EhDecimal then begin
    if  not ( Key in ['0'..'9', Chr(8)] ) then
      Key := #0
  end
  else begin
    if  Key = #46 then
      Key := DecimalSeparator;

    if  not ( Key in ['0'..'9', Chr(8), DecimalSeparator] ) then
      Key := #0
    else if  ( Key = DecimalSeparator ) and ( Pos( Key, Texto ) > 0 ) then
      Key := #0;
  end;

  Result := Key;
end;

end.
