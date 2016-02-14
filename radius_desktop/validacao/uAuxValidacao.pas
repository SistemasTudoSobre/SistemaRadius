unit uAuxValidacao;

interface

uses System.SysUtils;

function resultadoCnpj(cnpj: string): string;

implementation

function resultadoCnpj(cnpj: string): string;
var
  cnpjNumeral: string;
  i: Integer;
  total: Integer;
begin
  total := 0;
  for i := 1 to Length(cnpj) do
    total := total + StrToInt(Copy(cnpj, i, 1));
  Result := IntToStr(total);
end;

end.
