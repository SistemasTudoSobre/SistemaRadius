unit uWindows;

interface

uses Vcl.Dialogs, Winapi.Windows, System.SysUtils, Winapi.Messages,
  Winapi.TlHelp32, Winapi.PsAPI, IdIPWatch;
{ IdComponent, IdBaseComponent }

function getOtherWindowText(const sCaption, nomeClasse: String): WideString;
function terminarProcesso(sFile: String): Boolean;
function escreverArquivoTexto(Arquivo: string; sTexto: string): Boolean;
function isDebug(): Boolean;
function getUusuarioLogado(): string;
function getIpLocal(): string;
function verificarProcessoAberto(ExeFileName: String): Boolean;

implementation

function verificarProcessoAberto(ExeFileName: String): Boolean;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(ExeFileName))) then
    begin
      Result := True;
      Exit;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

// Capturar texto dentro de programa externo
function getOtherWindowText(const sCaption, nomeClasse: String): WideString;
var
  hWindow: THandle;
  hChild: THandle;
  aTemp: array [0 .. 512] of Char;
  sClassName: String;
begin
  Result := '';
  hWindow := FindWindow(Nil, PChar(sCaption));
  if hWindow = 0 then
    Exit;
  hChild := GetWindow(hWindow, GW_CHILD);
  while hChild <> 0 do
  begin
    if GetClassName(hChild, aTemp, sizeof(aTemp)) > 0 then
    begin
      sClassName := StrPAS(aTemp);
      if sClassName = nomeClasse then
      begin
        SendMessage(hChild, WM_GETTEXT, sizeof(aTemp), Integer(@aTemp));
        Result := StrPAS(aTemp);
      end;
    end;
    hChild := GetWindow(hChild, GW_HWNDNEXT);
  end;
end;

function terminarProcesso(sFile: String): Boolean;
var
  verSystem: TOSVersionInfo;
  hdlSnap, hdlProcess: THandle;
  bPath, bLoop: BOOL;
  peEntry: TProcessEntry32;
  arrPid: Array [0 .. 1023] of DWORD;
  iC: DWORD;
  k, iCount: Integer;
  arrModul: Array [0 .. 299] of Char;
  hdlModul: HMODULE;
begin
  Result := False;

  if ExtractFileName(sFile) = sFile then
    bPath := False
  else
    bPath := True;

  verSystem.dwOSVersionInfoSize := sizeof(TOSVersionInfo);
  GetVersionEx(verSystem);
  if verSystem.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
  begin
    hdlSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    peEntry.dwSize := sizeof(peEntry);
    bLoop := Process32First(hdlSnap, peEntry);
    while Integer(bLoop) <> 0 do
    begin
      if bPath then
      begin
        if CompareText(peEntry.szExeFile, sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, False,
            peEntry.th32ProcessID), 0);
          Result := True;
        end;
      end
      else
      begin
        if CompareText(ExtractFileName(peEntry.szExeFile), sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, False,
            peEntry.th32ProcessID), 0);
          Result := True;
        end;
      end;
      bLoop := Process32Next(hdlSnap, peEntry);
    end;
    CloseHandle(hdlSnap);
  end
  else if verSystem.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
    EnumProcesses(@arrPid, sizeof(arrPid), iC);
    iCount := iC div sizeof(DWORD);
    for k := 0 to Pred(iCount) do
    begin
      hdlProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
        False, arrPid[k]);
      if (hdlProcess <> 0) then
      begin
        EnumProcessModules(hdlProcess, @hdlModul, sizeof(hdlModul), iC);
        GetModuleFilenameEx(hdlProcess, hdlModul, arrModul, sizeof(arrModul));
        if bPath then
        begin
          if CompareText(arrModul, sFile) = 0 then
          begin
            TerminateProcess(OpenProcess(PROCESS_TERMINATE or
              PROCESS_QUERY_INFORMATION, False, arrPid[k]), 0);
            Result := True;
          end;
        end
        else
        begin
          if CompareText(ExtractFileName(arrModul), sFile) = 0 then
          begin
            TerminateProcess(OpenProcess(PROCESS_TERMINATE or
              PROCESS_QUERY_INFORMATION, False, arrPid[k]), 0);
            Result := True;
          end;
        end;
        CloseHandle(hdlProcess);
      end;
    end;
  end;
end;

function escreverArquivoTexto(Arquivo: string; sTexto: string): Boolean;
var
  ArquivoTexto: TextFile;
begin
  if not DirectoryExists(ExtractFilePath(Arquivo)) then
    CreateDir(ExtractFilePath(Arquivo));

  try
    AssignFile(ArquivoTexto, Arquivo);
    if FileExists(Arquivo) then
      Append(ArquivoTexto)
    else
      ReWrite(ArquivoTexto);
    Writeln(ArquivoTexto, sTexto);
  finally
    CloseFile(ArquivoTexto);
  end;
end;

function isDebug(): Boolean;
begin
  Result := DebugHook = 1
end;

function getUusuarioLogado(): string;
var
  NetUserNameLength: DWORD;
begin
  NetUserNameLength := 50;
  SetLength(Result, NetUserNameLength);
  GetUserName(PChar(Result), NetUserNameLength);
  SetLength(Result, StrLen(PChar(Result)));
end;

function getIpLocal(): string;
var
  r: TIdIPWatch;
begin
  try
    r := TIdIPWatch.Create(nil);
    Result := r.LocalIP;
  finally
    r.free;
  end;
end;

end.
