unit uGerarSerial;

interface

uses System.SysUtils, Vcl.Dialogs, uString;

function getNovoSerial(Formatado:Boolean; validade:TDate; cnpj:String):string;

implementation

uses uValidaSerial, uAuxValidacao;

function inverterDataValidade(dataValidade:TDate):string;
var
  validade : string;
begin
  validade := DateToStr(dataValidade);
  validade := Copy(validade, 4, 2) + Copy(validade, 9, 2);
  validade := Copy(validade, 4, 1) + Copy(validade, 3, 1) + Copy(validade, 2, 1) + Copy(validade, 1, 1);
  Result   := validade;
end;


function getPrimeiraSequencia(dataValidade:TDate):string;
begin
//  Result := FormatFloat('0000', Random(9999));
  Result := inverterDataValidade(dataValidade);
end;


function getSegundaSequencia(primeiraSequenciaGerada:string; cnpj:string):string;
var
  primeiraSequencia : string[4];
  totalCnpj     : Integer;
begin
  totalCnpj         := StrToInt(resultadoCnpj(cnpj));
  primeiraSequencia := primeiraSequenciaGerada;
  Result            := FormatFloat('0000', StrToInt(primeiraSequencia) + 854 + totalCnpj);
  Result            := Copy(Result, 1, 3) + IntToStr(Random(9));
end;


function getTerceiraSequencia(SegundaSequenciaGerada:string):string;
var
  segundaSequencia : string[4];
begin
  segundaSequencia  := SegundaSequenciaGerada;
  Result            := FormatFloat('0000', StrToInt(segundaSequencia) + 437);
end;


function getNovoSerial(Formatado:Boolean; validade:TDate; cnpj:String):string;
var
  strPrimeiraSequencia : string[4];
  strSegundaSeguencia  : string[4];
  strTerceiraSequencia : string[4];
begin

  strPrimeiraSequencia := getPrimeiraSequencia(validade);
  strSegundaSeguencia  := getSegundaSequencia(strPrimeiraSequencia, cnpj);
  strTerceiraSequencia := getTerceiraSequencia(strSegundaSeguencia);

  if Formatado then
    Result := strPrimeiraSequencia + '-' + strSegundaSeguencia + '-' + strTerceiraSequencia
  else
    Result := strPrimeiraSequencia + strSegundaSeguencia + strTerceiraSequencia;

end;

end.
