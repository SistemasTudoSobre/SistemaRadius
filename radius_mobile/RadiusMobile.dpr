program RadiusMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  Radius in 'Radius.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
