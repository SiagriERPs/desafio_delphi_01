unit UFuncoesBasicas;

interface

uses
  system.RegularExpressions;

 function cnpjValido(Cnpj: String): Boolean;
implementation

uses
  System.SysUtils;
  function cnpjValido(Cnpj: String): Boolean;
var
  dig13, dig14: string;
  sm, i, r, peso: integer;

const
  LISTA_CNPJ_INVALIDO: TArray<String> = [
    '00000000000000',
    '11111111111111',
    '22222222222222',
    '33333333333333',
    '44444444444444',
    '55555555555555',
    '66666666666666',
    '77777777777777',
    '88888888888888',
    '99999999999999'
  ];
begin
  Result := False;

  Cnpj := TRegEx.Replace(Cnpj, '[^0-9]', '');

  // O CNPJ tem que ter 14 dígitos e os dígitos não podem ser todos iguais!
  if (Cnpj.Length <> 14) then
    Exit();

  // Não pode ter todos os números iguais
  for I := 0 to Length(LISTA_CNPJ_INVALIDO) - 1 do
    if Cnpj = LISTA_CNPJ_INVALIDO[I] then
      Exit();

  try
  { -- Cálculo do 1o. Digito Verificador -- }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
    // StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(Cnpj[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig13 := '0'
    else str((11-r):1, dig13); // converte um número no respectivo caractere numérico

    { -- Cálculo do 2o. Digito Verificador -- }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(Cnpj[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig14 := '0'
    else str((11-r):1, dig14);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = Cnpj[13]) and (dig14 = Cnpj[14])) then
      Result := True;
  except
  end;
end;
end.
