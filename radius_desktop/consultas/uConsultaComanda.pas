unit uConsultaComanda;

interface

uses Vcl.Forms, System.SysUtils, FireDAC.Comp.Client;

function buscarMesaComanda(conexao: TFDConnection; idComanda: string): string;
function buscarStatusComanda(conexao: TFDConnection; idComanda: string): string;
function buscarIDComanda(codigoDiario: string): string;

implementation

uses uConsulta, uConsultaCaixa, uConstantes, uUsuario;

function buscarIDComanda(codigoDiario: string): string;
var
  codAberturaCaixa: string;
begin
  codAberturaCaixa := buscarCaixaAberto(conexaoSistema, getCodigoUsuario());
  Result := buscarDado(conexaoSistema, 'RADIUS_COMANDA', 'ID_ABERTURA_CAIXA',
    'ID_COMANDA', codAberturaCaixa, 'CODIGO_DIARIO = ' +
    QuotedStr(codigoDiario));
end;

function buscarMesaComanda(conexao: TFDConnection; idComanda: string): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  if idComanda = '' then
    Exit;
  strSQLConsulta := 'SELECT ' + #13 + '    C.ID_MESA ' + #13 +
    'FROM RADIUS_COMANDA C ' + #13 + 'WHERE ' + #13 + '    C.ID_COMANDA = ' +
    QuotedStr(idComanda);
  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexao;
  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;
  try
    Result := dsConsulta.FieldByName('ID_MESA').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

function buscarStatusComanda(conexao: TFDConnection; idComanda: string): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  if idComanda = '' then
    Exit;
  strSQLConsulta := 'SELECT ' + #13 + '    S.NOME_STATUS ' + #13 +
    'FROM RADIUS_COMANDA C ' + #13 +
    'INNER JOIN RADIUS_STATUS_COMANDA S ON (S.ID_STATUS = C.ID_STATUS) ' + #13 +
    'WHERE ' + #13 + '    C.ID_COMANDA = ' + QuotedStr(idComanda);
  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexao;
  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;
  try
    Result := dsConsulta.FieldByName('NOME_STATUS').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

end.
