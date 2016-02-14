unit uSuporte;

interface

uses uWindows, IdHTTP, Vcl.Forms, System.SysUtils, Vcl.Dialogs;

function getAutorizacaoSuporte(): string;
function getSenhaSuporte(): string;
function fecharAplicacaoSuporte(): Boolean;
function enviarRequisicaoSuporte(codcliente, acesso,
  autorizacao: string): Boolean;

implementation

uses uConstantes;

const
  NOME_APP_SUPORTE = 'TeamViewer';

function getAutorizacaoSuporte(): string;
begin
  Result := getOtherWindowText(NOME_APP_SUPORTE, 'Edit');
end;

function getSenhaSuporte(): string;
begin
  Result := getOtherWindowText(NOME_APP_SUPORTE, 'ComboBox');
end;

function fecharAplicacaoSuporte(): Boolean;
begin
  terminarProcesso('sp.exe')
end;

function enviarRequisicaoSuporte(codcliente, acesso,
  autorizacao: string): Boolean;
const
  GET = '?ID_CLIENTE=%s&ACESSO=%s&AUTORIZACAO=%s';
  RETORNO = 'OK';
var
  httpRetorno: TidHttp;
begin
  httpRetorno := TidHttp.Create(Application);
  try
    acesso := StringReplace(acesso, ' ', '-', [rfReplaceAll]);
    Result := httpRetorno.GET(RADIUS_WEB_SERVICE_SUPORTE + Format(GET,
      [codcliente, acesso, autorizacao])) = RETORNO;
  finally
    FreeAndNil(httpRetorno);
  end;
end;

end.
