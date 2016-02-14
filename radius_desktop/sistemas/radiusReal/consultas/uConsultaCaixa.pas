unit uConsultaCaixa;

interface

uses Vcl.Forms, System.SysUtils, FireDAC.Comp.Client;

function buscarCaixaAberto(conexao: TFDConnection; codUsuario: string): string;

implementation

function buscarTotalRecebidoEmCaixa(conexao: TFDConnection;
  usuario: string): string;
begin

end;

function buscarCaixaAberto(conexao: TFDConnection; codUsuario: string): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + '    A.ID_ABERTURA_CAIXA ' +
    'FROM RADIUS_ABERTURA_CAIXA A ' + 'WHERE ' + '    A.ID_STS_CAIXA = 1 ' +
    '    AND A.ID_USUARIO = ' + QuotedStr(codUsuario);

  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('ID_ABERTURA_CAIXA').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

end.
