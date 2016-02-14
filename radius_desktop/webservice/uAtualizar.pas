unit uAtualizar;

interface

uses
  System.SysUtils, IdHTTP, FMX.Dialogs, Forms, Winapi.ShellAPI, Vcl.Controls,
  Winapi.Windows;

function verificarAtualizacao(mostrarMsg: Boolean = False): Boolean;

implementation

uses
  uMD5, uDialAtualizar, uWindows, uLogs, uConstantes;

const
  RADIUS_SUPORTE = 'sp';
  RADIUS_SUPORTE_DLL = 'Teamviewer_Resource_pt';

function executarAplicacaoNova(): Boolean;
begin
  if ExtractFileName(Application.ExeName) = NOME_EXE_TMP then
  begin
    terminarProcesso(RADIUS_BUILD + '.exe');
    if DeleteFile(RADIUS_BUILD + '.exe') then
    begin
      if CopyFile(PWideChar(Application.ExeName), RADIUS_BUILD + '.exe', True)
      then
        if ShellExecute(0, 'Open', RADIUS_BUILD + '.exe', '', '', SW_SHOW) > 0
        then
          Application.Terminate;
    end;
  end
  else if FileExists(ExtractFilePath(Application.ExeName) + NOME_EXE_TMP) then
    DeleteFile(PWideChar(ExtractFilePath(Application.ExeName) + NOME_EXE_TMP))
end;

function baixarAtualizacao(): Boolean;
begin
  TfrmAtualizacao.abrirJanelaAtualizacao(RADIUS_URL_ATUALIZACAO + '/' +
    RADIUS_BUILD);
  if ShellExecute(0, 'Open', NOME_EXE_TMP, '', '', SW_SHOW) > 0 then
    Application.Terminate;
end;

function verificarArquivosSuporte(): Boolean;
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + RADIUS_SUPORTE +
    '.exe') then
    TfrmAtualizacao.abrirJanelaAtualizacao(RADIUS_URL_ATUALIZACAO + '/' +
      RADIUS_SUPORTE, RADIUS_SUPORTE + '.exe');

  if not FileExists(ExtractFilePath(Application.ExeName) + RADIUS_SUPORTE_DLL +
    '.dll') then
    TfrmAtualizacao.abrirJanelaAtualizacao(RADIUS_URL_ATUALIZACAO + '/' +
      RADIUS_SUPORTE_DLL, RADIUS_SUPORTE_DLL + '.dll');
end;

function verificarArquivosNecessarios(): Boolean;
begin
  verificarArquivosSuporte();
end;

// Retorna se é para atualziar
function verificarAtualizacao(mostrarMsg: Boolean = False): Boolean;
var
  httpRetorno: TidHttp;
  md5ExecutavalAtualLocal: string[34];
  md5UltimaVersaoSite: string[34];
begin

  executarAplicacaoNova();

  Result := True;

  // Verificar se possui os arquivos necessários para o sistema
  verificarArquivosNecessarios();

  md5ExecutavalAtualLocal := getMD5Arquivo(Application.ExeName);
  try
    httpRetorno := TidHttp.Create(Application);
    try
      md5UltimaVersaoSite := httpRetorno.Get(RADIUS_WEB_SERVICE_ATUALIZACAO);

      if AnsiUpperCase(Trim(md5ExecutavalAtualLocal)) <>
        AnsiUpperCase(Trim(md5UltimaVersaoSite)) then
      // Então está desatualizado
      begin
        // ShowMessage('O executavel precisa ser Atualizado!' + #13 +
        // 'Cod local: ' + AnsiUpperCase(Trim(md5ExecutavalAtualLocal)) + #13 +
        // 'Cod Atual: ' + AnsiUpperCase(Trim(md5UltimaVersaoSite)));
        baixarAtualizacao();
      end
      else if mostrarMsg then
        ShowMessage('O sistema já se encontra atualizado!');

    finally
      FreeAndNil(httpRetorno);
    end;
  except
    ShowMessage('Erro! Na busca por atualizacao!');
  end;

end;

end.
