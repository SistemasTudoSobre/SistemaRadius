unit uConsultasCliente;

interface

uses Vcl.Forms, dmPrincipal, System.SysUtils, FireDAC.Comp.Client;

function adicionarNovoSerial(serial: String): Boolean;
function buscarSerialCliente(): string;
function buscarCodigoUsuario(nomeUsuario: string): string;
function buscarCNPJCliente(): string;
function getSenhaUsuario(nomeUsuario: string): string;
function verificarSerialHDCliente(serialCliente, serialHD: string): Boolean;
function proximoCliente(): String;
function getNomeCliente(): String;

implementation

uses uConstantes, uConsulta;

function proximoCliente(): String;
begin
  Result := IntToStr(StrToInt(ultimoCodigo(conexaoSistema, 'RADIUS_CLIENTE',
    'ID_CLIENTE')) + 1);
end;

function buscarSerialCliente(): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT FIRST 1 ' + '      R.SERIAL  ' +
    '  FROM RADIUS_CLIENTE R ';;

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('SERIAL').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

function adicionarNovoSerial(serial: String): Boolean;
begin
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL
    ('UPDATE RADIUS_CLIENTE SET SERIAL = ' + QuotedStr(serial) +
    ' WHERE (ID_CLIENTE = 1);')
end;

function buscarCodigoUsuario(nomeUsuario: string): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 + '      U.ID_USUARIO ' + #13 +
    '  FROM RADIUS_USUARIO U ' + #13 + '  WHERE ' + #13 + '      U.NOME = ' +
    QuotedStr(nomeUsuario);

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('ID_USUARIO').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function getSenhaUsuario(nomeUsuario: string): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 + '      U.SENHA ' + #13 +
    '  FROM RADIUS_USUARIO U ' + #13 + '  WHERE ' + #13 + '      U.NOME = ' +
    QuotedStr(nomeUsuario);

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('SENHA').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function verificarSerialHDCliente(serialCliente, serialHD: string): Boolean;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 + '      M.SERIAL_HD  ' + #13 +
    '  FROM RADIUS_CLIENTE U ' + #13 +
    '  INNER JOIN RADIUS_MAQUINAS_CLIENTE M ON (M.ID_CLIENTE = U.ID_CLIENTE)  '
    + #13 + '  WHERE ' + #13 + '      U.SERIAL = ' + QuotedStr(serialCliente) +
    #13 + '      AND M.SERIAL_HD = ' + QuotedStr(serialHD);

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('SERIAL_HD').AsString = serialHD;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function buscarCNPJCliente(): string;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT' + #13#10 + 'C.CNPJ' + #13#10 +
    'FROM RADIUS_CLIENTE C' + #13#10 + 'WHERE C.ID_CLIENTE = 1';

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('CNPJ').AsString;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function getNomeCliente(): String;
begin
  Result := buscarDado(conexaoSistema, 'RADIUS_CLIENTE', 'ID_CLIENTE',
    'NOME_CLIENTE', '1');
end;

end.
