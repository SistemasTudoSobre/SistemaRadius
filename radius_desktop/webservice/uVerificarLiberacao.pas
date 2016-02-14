unit uVerificarLiberacao;

interface

uses IdHTTP, vcl.Forms, System.SysUtils, vcl.Dialogs, StrUtils;

function getValidadeSistema(serial: string): Boolean;

implementation

const
  RADIUS_URL_LIBERACAO = 'http://radius.tudosobre.info/liberacao';
  RADIUS_ARQUIVO_WEB_LIBERACAO = 'liberacao.php';
  RADIUS_CODIGO_GET = 'SERIAL';
  RADIUS_WEB_SERVICE = RADIUS_URL_LIBERACAO + '/' + RADIUS_ARQUIVO_WEB_LIBERACAO
    + '?' + RADIUS_CODIGO_GET + '=';

function getRetornoWebservice(serial: string): string;
var
  httpRetorno: TidHttp;
begin
  try
    httpRetorno := TidHttp.Create(Application);
    try
      Result := httpRetorno.Get(RADIUS_WEB_SERVICE + serial);
    finally
      FreeAndNil(httpRetorno);
    end;
  except
    ShowMessage('Erro de conexão!' + #13 +
      'Verifica sua internet para poder liberar o sistema!');
  end;
end;

function getValidadeSistema(serial: string): Boolean;
var
  retornoCompleto: string;
  validade: TDate;
  status: string;
  acesso: Boolean;
begin

  Result := False;

  retornoCompleto := getRetornoWebservice(serial);
  try
    status := Copy(retornoCompleto, 12, 14);

    case AnsiIndexStr(UpperCase(status), ['SISTEMA_VALIDO', 'ULTIMO_DIA_PER',
      'SISTEMA_EXPIRA']) of
      0:
        begin
          validade := StrToDate(Copy(retornoCompleto, 1, 10));
          acesso := True;
        end;
      1:
        begin
          validade := StrToDate(Copy(retornoCompleto, 1, 10));
          acesso := True;
        end;
      2:
        begin
          validade := StrToDate(Copy(retornoCompleto, 1, 10));
          acesso := False;
          ShowMessage('Sistema com validade expirada!');
          // Application.Terminate;
        end;
    else
      acesso := False;
      ShowMessage('Erro ao verificar liberação do sistema!');
      // Application.Terminate;
    end;

    Result := acesso;
  except
    ShowMessage('Erro ao verificar liberação do sistema!');
    Application.Terminate;
  end;
end;

end.
