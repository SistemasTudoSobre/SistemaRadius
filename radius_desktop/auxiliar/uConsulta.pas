unit uConsulta;

interface

uses Vcl.Forms, System.SysUtils, FireDAC.Comp.Client;

function ultimoCodigo(conexao: TFDConnection; tabela, campo: string;
  condicao: string = ''): string;
function buscarDado(conexao: TFDConnection; tabela: string; campoChave: string;
  campoDesejado: string; value: string; condicao: string = ''): string;
function CreateQuery(sql:string):TFDQuery; overload;
function CreateQuery(sql:string; conexao:TFDConnection):TFDQuery; overload;

implementation

uses uConstantes;

function ultimoCodigo(conexao: TFDConnection; tabela, campo: string;
  condicao: string = ''): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 + '    MAX(U.' + campo + ') AS "ULTIMO"  ' +
    #13 + 'FROM ' + tabela + ' U ';

  if condicao <> '' then
    strSQLConsulta := strSQLConsulta + ' WHERE ' + condicao;

  dsConsulta := TFDQuery.Create(Application);
  // dmPrincipal.frmDmPrincipal.FDConnexao
  dsConsulta.Connection := conexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    if dsConsulta.FieldByName('ULTIMO').IsNull then
      Result := '0'
    else
      Result := dsConsulta.FieldByName('ULTIMO').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function buscarDado(conexao: TFDConnection; tabela: string; campoChave: string;
  campoDesejado: string; value: string; condicao: string = ''): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  if value = '' then
    Exit;
  strSQLConsulta := 'SELECT ' + #13 + campoDesejado + #13 + ' FROM ' + tabela +
    ' U ' + #13 + ' WHERE U.' + campoChave + ' = ' + QuotedStr(value);

  if condicao <> '' then
    strSQLConsulta := strSQLConsulta + ' AND ' + condicao;

  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName(campoDesejado).AsString;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function CreateQuery(sql:string):TFDQuery;
begin
  try
    Result := CreateQuery(sql, conexaoSistema);
  except

  end;
end;

function CreateQuery(sql:string; conexao:TFDConnection):TFDQuery;
begin
  Result  := TFDQuery.Create(Application);
  try
    Result.Connection := conexao;
    Result.SQL.Text := sql;
    Result.Active := True;
  except

  end;
end;

end.
