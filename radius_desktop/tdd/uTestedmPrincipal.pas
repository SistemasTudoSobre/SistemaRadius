unit uTestedmPrincipal;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestedmPrincipal = class(TObject) 
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure testConexao();
  end;

implementation

uses dmPrincipal;

procedure TTestedmPrincipal.Setup;
begin
end;

procedure TTestedmPrincipal.TearDown;
begin

end;


procedure TTestedmPrincipal.testConexao;
begin
  Assert.IsTrue(frmDmPrincipal.FDConnexao.Connected, 'Conexao principal não conectada!');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestedmPrincipal);
end.
