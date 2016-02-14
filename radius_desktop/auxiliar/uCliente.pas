unit uCliente;

interface

uses System.SysUtils, Vcl.Forms;

procedure adicionarCliente(nomeCliente, cnpj, responsavel, serial: string;
  nomeNovoUsuario: string = ''; senhaNovoUsuario: string = '';
  nomeCompletoNovoUsuario: String = ''; dicaSenhaNovoUsuario: string = '';
  emailNovoUsuario: string = '');
procedure adicionarUsuario(nomeNovoUsuario, senhaNovoUsuario,
  nomeCompletoNovoUsuario, dicaSenhaNovoUsuario, emailNovoUsuario: string);
procedure adicionarMaquina(serialHD, nomeUsuarioSO, enderecoMAC, ip,
  codigoCliente: string);

implementation

uses dmPrincipal, uSeriaisLogicos, uWindows, uHardware, uConsultasCliente,
  uData;

procedure adicionarUsuario(nomeNovoUsuario, senhaNovoUsuario,
  nomeCompletoNovoUsuario, dicaSenhaNovoUsuario, emailNovoUsuario: string);
var
  sqlNovoUsuario: string;
begin
  sqlNovoUsuario :=
    ' INSERT INTO RADIUS_USUARIO (NOME, NOME_COMPLETO, SENHA, DICA_SENHA, EMAIL) '
    + ' VALUES (' + QuotedStr(nomeNovoUsuario) + ', ' +
    QuotedStr(nomeCompletoNovoUsuario) + ', ' + QuotedStr(senhaNovoUsuario) +
    ', ' + QuotedStr(dicaSenhaNovoUsuario) + ', ' +
    QuotedStr(emailNovoUsuario) + ');';
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL(sqlNovoUsuario);
end;

procedure adicionarMaquina(serialHD, nomeUsuarioSO, enderecoMAC, ip,
  codigoCliente: string);
var
  sqlNovaMaquinaAutorizada: string;
begin
  sqlNovaMaquinaAutorizada :=
    'INSERT INTO RADIUS_MAQUINAS_CLIENTE (SERIAL_HD, NOME_USUARIO, MAC, IP, ID_CLIENTE)  '
    + '  VALUES (' + QuotedStr(serialHD) + ', ' + QuotedStr(nomeUsuarioSO) +
    ', ' + QuotedStr(enderecoMAC) + ', ' + QuotedStr(ip) + ', ' +
    QuotedStr(codigoCliente) + ');';
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL(sqlNovaMaquinaAutorizada);
end;

procedure adicionarCliente(nomeCliente, cnpj, responsavel, serial: string;
  nomeNovoUsuario: string = ''; senhaNovoUsuario: string = '';
  nomeCompletoNovoUsuario: String = ''; dicaSenhaNovoUsuario: string = '';
  emailNovoUsuario: string = '');
var
  sqlNovoCliente: string;
  codProximoCliente, usuario, mac, ip: string;
begin
  codProximoCliente := proximoCliente();

  sqlNovoCliente :=
    'INSERT INTO RADIUS_CLIENTE (ID_CLIENTE, NOME_CLIENTE, CNPJ, RESPONSAVEL, SERIAL, DATA_AQUISICAO) '
    + ' VALUES (' + QuotedStr(codProximoCliente) + ', ' + QuotedStr(nomeCliente)
    + ', ' + QuotedStr(cnpj) + ', ' + QuotedStr(responsavel) + ', ' +
    QuotedStr(serial) + ', ' + QuotedStr(FormatDateTime('dd.mm.yyyy',
    getDataHoje())) + ') ;';
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL(sqlNovoCliente);

  if nomeNovoUsuario <> '' then
    adicionarUsuario(nomeNovoUsuario, senhaNovoUsuario, nomeCompletoNovoUsuario,
      dicaSenhaNovoUsuario, emailNovoUsuario);

  // Adicionar automaticamente essa maquina
  adicionarMaquina(getSerialNumberDrive('C'), getUusuarioLogado(),
    getMacAddress(), getIpLocal(), codProximoCliente);

  Application.Terminate;
end;

end.
