unit uValidaSerial;

interface

uses System.SysUtils;

function validarSerial(Serial: string; cnpj: string): TDate;

implementation

uses uAuxValidacao;

var
  Serial: string;

procedure setSerial(pSerial: string);
begin
  Serial := StringReplace(pSerial, '-', '', [rfReplaceAll]);
end;

function getSerial(): string;
begin
  Result := Serial;
end;

function getPrimeiraSequencia(): string;
begin
  Result := Copy(getSerial, 1, 4);
end;

function getSegundaSequencia(): string;
begin
  Result := Copy(getSerial, 5, 4);
end;

function getTerceiraSequencia(): string;
begin
  Result := Copy(getSerial, 9, 4);
end;

function inverterDataValidade(dataValidade: string): TDate;
begin
  dataValidade := Copy(dataValidade, 4, 1) + Copy(dataValidade, 3, 1) +
    Copy(dataValidade, 2, 1) + Copy(dataValidade, 1, 1);
  Result := StrToDateDef('20' + '/' + Copy(dataValidade, 1, 2) + '/' +
    Copy(dataValidade, 3, 2), 0);
end;

function buscarPrimeiraSequenciaTratada(primeiraSequencia: string;
  totalCNPJ: Integer): string;
begin
  Result := FormatFloat('0000', (StrToInt(primeiraSequencia) + 854 +
    totalCNPJ));
  Result := Copy(Result, 1, 3);
end;

function buscarSegundaSequenciaTratada(): string;
begin
  Result := FormatFloat('0000', (StrToInt(getSegundaSequencia()) + 437));
end;

// Se retornar uma data entao é validade, se retornar zero entao é inválida
function validarSerial(Serial: string; cnpj: string): TDate;
var
  primeiraSeq: string;
  segundaSeq: string;
  terceiraSeq: string;
  primeiraSequenciaSomada: string[4];
  segundaSequenciaSomada: string[4];
  segundaSequenciaValida: Boolean;
  terceiraSequenciaValida: Boolean;
  totalCNPJ: Integer;
begin
  setSerial(Serial);

  primeiraSeq := getPrimeiraSequencia();
  segundaSeq := getSegundaSequencia();
  terceiraSeq := getTerceiraSequencia();

  totalCNPJ := StrToInt(resultadoCnpj(cnpj));
  primeiraSequenciaSomada := buscarPrimeiraSequenciaTratada(primeiraSeq,
    totalCNPJ);
  segundaSequenciaSomada := buscarSegundaSequenciaTratada();
  segundaSequenciaValida := Copy(segundaSeq, 1, 3) = primeiraSequenciaSomada;
  terceiraSequenciaValida := terceiraSeq = segundaSequenciaSomada;

  if segundaSequenciaValida and terceiraSequenciaValida then
    Result := inverterDataValidade(primeiraSeq);
end;

end.
