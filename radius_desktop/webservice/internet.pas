unit internet;

interface

uses WinInet, Winapi.Windows;

function verificarConexaoComInternet(): Boolean;

implementation

function verificarConexaoComInternet(): Boolean;
var
  i: dword;
begin
  Result := InternetGetConnectedState(@i, 0);
end;

end.
