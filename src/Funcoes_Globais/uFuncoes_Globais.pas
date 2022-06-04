unit uFuncoes_Globais;

interface

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Winapi.Windows;

procedure Validar_Campo_Obrigatorio(Sender: TObject; vMensagem:String = 'Atenção Existe Campos que São Obrigatório, Sem Preencher!!');
function ApenasNumero(Key: Char; Texto: string; EhDecimal: Boolean = False; DecimalSeparator :Char = ','): Char;
procedure Verificar_Pressed_Enter(Sender: TObject; var Key: Char);
Function RemoveCaractere(texto: String): String;

implementation


procedure Validar_Campo_Obrigatorio(Sender: TObject; vMensagem:String = 'Atenção Existe Campos que São Obrigatório, Sem Preencher!!');
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

procedure Verificar_Pressed_Enter(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    keybd_event(VK_Tab, 0, 0, 0);   Key := #0;
  end;
end;

Function RemoveCaractere(texto: String): String;
begin
  While pos(' ', texto) <> 0 Do delete(texto, pos(' ', texto), 1);
  While pos('/', texto) <> 0 Do delete(texto, pos('/', texto), 1);
  While pos('-', texto) <> 0 Do delete(texto, pos('-', texto), 1);
  While pos('\', texto) <> 0 Do delete(texto, pos('\', texto), 1);
  While pos('.', texto) <> 0 Do delete(texto, pos('.', texto), 1);

  Result := texto;
end;

end.
