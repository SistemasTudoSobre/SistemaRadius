unit uFirebird;

interface

uses Winapi.Windows;

function fireBirdStarted(): Boolean;

implementation

uses uWindows;

function fireBirdStarted(): Boolean;
begin
  Result := verificarProcessoAberto('fbguard.exe');
end;

end.
