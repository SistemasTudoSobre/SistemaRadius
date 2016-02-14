unit uData;

(*
  1 - Caso o servidor de banco de dados for Linux buscar a data de lá
  2 - Caso não tenha internet buscar da tabela que armazena a ultima data
  3 - Caso o servidor nao for linux tentar buscar da internet
*)

interface

uses System.SysUtils, FireDAC.Comp.Client, IdSNTP, Vcl.Dialogs, Vcl.Forms;

function getDataHoje(Maquina: Boolean = True): TDate;
function getUltimaDataLigado(): TDate;
procedure setUltimaDataLigado(data: TDate);
function setDataVerdadeira(): Boolean;

implementation

uses dmPrincipal, uConstantes, internet;

function getDataWeb(): TDateTime;
var
  IdSNTP: TIDSntp;
begin
  IdSNTP := TIDSntp.Create(nil);
  try
    IdSNTP.Host := 'pool.ntp.br';
    Result := IdSNTP.DateTime;
  finally
    FreeAndNil(IdSNTP);
  end;
end;

{ TODO -oJonathan -c : Alterar qnd estiver trabalhando com servidor 21/01/2016 20:33:33 }
function getDataHoje(Maquina: Boolean = True): TDate;
var
  ultimaData: TDate;
begin

  // Implementar
  // if servidorLinux() then
  // begin
  // Result := getdataServidor();
  // Exit;
  // end;

  ultimaData := getUltimaDataLigado();
  if ultimaData <> Date() then // Verifica se a data da maquina está correta!
  begin
    Result := ultimaData;

    // Ja que houve algum problema verifique com a internet
    if verificarConexaoComInternet() then
    begin
      Result := getDataWeb();
      setUltimaDataLigado(Result);
    end;

    // Implementar
    // enviarInformacaoClienteMudandoDataSistema();

    Exit;
  end
  else
    Result := ultimaData;

  // if Maquina then
  // Result := getDataHoje()
  // else
  // Result := getUltimaDataLigado()

end;

procedure setUltimaDataLigado(data: TDate);
const
  INSERT = 'INSERT INTO RADIUS_DATA (ULT_DATA) VALUES (''%s'');';
begin
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL
    (Format(INSERT, [FormatDateTime('dd.mm.yyyy', data)]))
end;

function getUltimaDataLigado(): TDate;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT' + #13#10 + 'MAX(U.ULT_DATA) AS ULT_DATA ' + #13#10
    + 'FROM RADIUS_DATA U';
  dsConsulta := TFDQuery.Create(conexaoSistema);
  dsConsulta.Connection := conexaoSistema;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('ULT_DATA').AsDateTime;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

// Caso tenha internet garante que a data do sistema será a buscada online
// pois será buscada pela função: getDataHoje()
function setDataVerdadeira(): Boolean;
begin
  if getUltimaDataLigado() <> Date() then
    if verificarConexaoComInternet() then
      setUltimaDataLigado(getDataWeb())
    else
    begin
      ShowMessage
        ('Por favor corrija a data e hora atual do computador, ou conecte-o com a '
        + 'internet para que isso se faça automaticamente!');
      Application.Terminate();
    end;
end;

end.
