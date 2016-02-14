unit uString;

interface

function somenteNumeros(texto: string): string;

implementation

function somenteNumeros(texto: string): string;
var
  I: integer;
  S: string;
  Virgula: Boolean; // Pra verificar se ja Possui virgula
begin
  S := '';
  Virgula := False;

  for I := 1 To Length(texto) Do
  begin
    if (texto[I] in ['0' .. '9']) or ((texto[I] in [',']) and (Virgula <> True))
    then
    begin
      if (texto[I] in [',']) then
        Virgula := True;
      S := S + Copy(texto, I, 1);
    end;
  end;

  Result := S;
end;

end.
