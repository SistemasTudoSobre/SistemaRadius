unit uTesteuConstantes;

interface

uses
  DUnitX.TestFramework, uConstantes;

type

  [TestFixture]
  TTesteuConstantes = class(TObject) 
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('PROTOCOLO', PROTOCOLO)]
    [TestCase('DOMINIO', DOMINIO)]
    [TestCase('SITE_OFICIAL', SITE_OFICIAL)]
    [TestCase('RADIUS_SUB_DOMINIO', RADIUS_SUB_DOMINIO)]
    [TestCase('RADIUS_URL_ATUALIZACAO', RADIUS_URL_ATUALIZACAO)]
    [TestCase('RADIUS_ARQUIVO_WEB_ATUALIZACAO', RADIUS_ARQUIVO_WEB_ATUALIZACAO)]
    [TestCase('RADIUS_WEB_SERVICE_ATUALIZACAO', RADIUS_WEB_SERVICE_ATUALIZACAO)]
    [TestCase('RADIUS_URL_SUPORTE', RADIUS_URL_SUPORTE)]
    [TestCase('RADIUS_ARQUIVO_WEB_SUPORTE', RADIUS_ARQUIVO_WEB_SUPORTE)]
    [TestCase('RADIUS_WEB_SERVICE_SUPORTE', RADIUS_WEB_SERVICE_SUPORTE)]
    [TestCase('RADIUS_BUILD', RADIUS_BUILD)]
    procedure testeConstantePreenchidas(const constante:string);

    [Test]
    [TestCase('DOMINIO', DOMINIO)]
    [TestCase('SITE_OFICIAL', SITE_OFICIAL)]
    [TestCase('RADIUS_SUB_DOMINIO', RADIUS_SUB_DOMINIO)]
    procedure testeEnderecosValidos(const endereco:string);

    [Test]
    procedure testeConexaoPrincipal();

  end;

implementation

uses uInternet;

procedure TTesteuConstantes.Setup;
begin
end;

procedure TTesteuConstantes.TearDown;
begin
end;

procedure TTesteuConstantes.testeConexaoPrincipal;
begin
  Assert.IsTrue(conexaoSistema <> nil, 'Conexão não instanciada!');
end;

procedure TTesteuConstantes.testeConstantePreenchidas(const constante:string);
begin
  Assert.IsNotEmpty(constante);
end;

procedure TTesteuConstantes.testeEnderecosValidos(const endereco:string);
begin
  Assert.IsTrue(checkUrl(endereco));
end;


initialization
  TDUnitX.RegisterTestFixture(TTesteuConstantes);
end.
