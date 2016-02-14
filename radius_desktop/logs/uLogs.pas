unit uLogs;

interface

uses System.SysUtils, Vcl.Forms;

function gravarLog(strLog: string): Boolean;

implementation

uses uWindows, uData;

const
  ARQUIVO_LOG = 'logs\Radius.log';

function gravarLog(strLog: string): Boolean;
begin
  strLog := '[' + FormatDateTime('dd/mm/yyyy', getDataHoje()) + ' ' +
    FormatDateTime('hh:mm:ss', Time) + ']' + ' ' +
    Copy(ExtractFileName(Application.ExeName), 10) + ' |-> ' + strLog;
  escreverArquivoTexto(ExtractFilePath(Application.ExeName) +
    ARQUIVO_LOG, strLog);
end;

end.
