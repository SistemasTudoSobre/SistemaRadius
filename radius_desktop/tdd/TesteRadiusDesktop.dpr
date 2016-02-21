program TesteRadiusDesktop;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  uTesteuConstantes in 'uTesteuConstantes.pas',
  uConstantes in '..\constantes\uConstantes.pas',
  dmPrincipal in '..\dataModule\dmPrincipal.pas' {frmDmPrincipal: TDataModule},
  uInternet in '..\internet\uInternet.pas',
  uTestedmPrincipal in 'uTestedmPrincipal.pas',
  uTesteuKeyGen in 'uTesteuKeyGen.pas',
  uKeyGen in '..\keygen\uKeyGen.pas' {frmKeyGen},
  uMaster in '..\master\uMaster.pas' {frmMaster},
  uGerarSerial in '..\keygen\uGerarSerial.pas',
  uString in '..\auxiliar\uString.pas',
  uValidaSerial in '..\validacao\uValidaSerial.pas',
  uAuxValidacao in '..\validacao\uAuxValidacao.pas',
  uData in '..\auxiliar\uData.pas',
  internet in '..\webservice\internet.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('');
      System.Write('Terminou! Pressione enter para sair.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
