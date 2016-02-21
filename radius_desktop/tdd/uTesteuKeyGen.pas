unit uTesteuKeyGen;

interface

uses
  DUnitX.TestFramework, System.SysUtils;

type

  [TestFixture]
  TTesteuKeyGen = class(TObject)
  public

  [Test]
  [TestCase('Teste01', '25/09/1990, 912345678912343')]
  [TestCase('Teste02', '25/09/2000, 125351351351351')]
  procedure testGeracaoSerial(const data:Tdate; const cnpj:Int64);

  [Test]
  [TestCase('Teste03', '25/09/2016, 468468768823437')]
  [TestCase('Teste04', '25/09/2017, 998465461201351')]
  procedure testGeracaoNovoSerial(const data:TDate; const cnpj:Int64);

  [Test]
  [TestCase('Teste05', '25/09/2060, 912345321823437')]
  [TestCase('Teste06', '25/09/2060, 784569841201351')]
  procedure testGeracaoNovoSerialNaValidade(const data:TDate; const cnpj:Int64);

  [Test]
  [TestCase('Teste07', '25/09/2015, 782345411823437')]
  [TestCase('Teste08', '21/02/2016, 021547874984684')]
  procedure testGeracaoNovoSerialVencido(const data:TDate; const cnpj:Int64);

  [Test]
  [TestCase('Teste09', '25/09/2021, 782345411823437, 20/09/2021')]
  [TestCase('Teste10', '21/02/2044, 021547874984684, 20/02/2044')]
  procedure testGeracaoValidade(const data:TDate; const cnpj:Int64; const validade:TDate);

  end;

implementation

uses uGerarSerial, uValidaSerial;

{ TTesteuKeyGen }


//Verifica somente se é um serial válido
procedure TTesteuKeyGen.testGeracaoNovoSerial(const data:TDate; const cnpj:Int64);
var
  novoSerial : string;
  validadeDeUso : TDate;
begin
  novoSerial := getNovoSerial(True, data, FloatToStr(cnpj));
  validadeDeUso := validarSerial(novoSerial, FloatToStr(cnpj));
  validadeDeUso := StrToDateDef(DateToStr(validadeDeUso), 0);
  Assert.IsTrue(validadeDeUso <> 0);
end;


//Verifica se é valido e se está dentro da validade
procedure TTesteuKeyGen.testGeracaoNovoSerialNaValidade(const data: TDate;
  const cnpj: Int64);
var
  novoSerial : string;
  validadeDeUso : TDate;
begin
  novoSerial := getNovoSerial(True, data, FloatToStr(cnpj));
  validadeDeUso := validarSerial(novoSerial, FloatToStr(cnpj));
  validadeDeUso := StrToDateDef(DateToStr(validadeDeUso), 0);
  Assert.IsTrue((validadeDeUso <> 0) and (validadeDeUso > Date));
end;


//Verifica se é valido e se ja está vencido
procedure TTesteuKeyGen.testGeracaoNovoSerialVencido(const data: TDate;
  const cnpj: Int64);
var
  novoSerial : string;
  validadeDeUso : TDate;
begin
  novoSerial := getNovoSerial(True, data, FloatToStr(cnpj));
  validadeDeUso := validarSerial(novoSerial, FloatToStr(cnpj));
  validadeDeUso := StrToDateDef(DateToStr(validadeDeUso), 0);
  Assert.IsTrue((validadeDeUso <> 0) and (validadeDeUso < Date));
end;

procedure TTesteuKeyGen.testGeracaoSerial(const data:TDate; const cnpj:Int64);
var
  novoSerial : string;
begin
  novoSerial := getNovoSerial(True, data, IntToStr(cnpj));
  Assert.IsNotEmpty(novoSerial);
end;


//O vencimento cairá sempre no dia 20 de cada mês
procedure TTesteuKeyGen.testGeracaoValidade(const data: TDate;
  const cnpj: Int64; const validade: TDate);
var
  novoSerial : string;
  validadeDeUso : TDate;
begin
  novoSerial := getNovoSerial(True, data, FloatToStr(cnpj));
  validadeDeUso := validarSerial(novoSerial, FloatToStr(cnpj));
  validadeDeUso := StrToDateDef(DateToStr(validadeDeUso), 0);
  Assert.IsTrue(validadeDeUso = validade);
end;

initialization
  TDUnitX.RegisterTestFixture(TTesteuKeyGen);
end.
