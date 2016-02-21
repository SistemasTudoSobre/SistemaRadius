unit internet;

interface

uses WinInet, Winapi.Windows, System.SysUtils;

function verificarConexaoComInternet(): Boolean;
function checkUrl(url: string): boolean;

implementation

function verificarConexaoComInternet(): Boolean;
var
  i: dword;
begin
  Result := InternetGetConnectedState(@i, 0);
end;

function checkUrl(url: string): boolean;
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: dword;
  dwcode: array[1..20] of char;
  res: pchar;
begin
  if pos('http://', LowerCase(url)) = 0 then
    url := 'http://' + url;
  Result := false;
  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if assigned(hsession) then
  begin
    hfile := InternetOpenUrl(hsession, pchar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwIndex := 0;
    dwCodeLen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodeLen, dwIndex);
    res := pchar(@dwcode);
    result := (res = '200') or (res = '302');
    if assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hsession);
  end;
end;

end.
