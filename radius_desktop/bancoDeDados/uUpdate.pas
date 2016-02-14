unit uUpdate;

interface

uses FireDAC.Comp.Client, System.SysUtils;

function AtualizarRegistro(conexao: TFDConnection; tabela: string;
  campoNovoValor, novoValor, campoCondicao, valorCampoCondicao: string)
  : Boolean;

implementation

function AtualizarRegistro(conexao: TFDConnection; tabela: string;
  campoNovoValor, novoValor, campoCondicao, valorCampoCondicao: string)
  : Boolean;
{ TODO -oJonathan -c : Fazer overload qnd tiver tempo 13/12/2015 15:52:19 }
var
  strSQL: string;
begin
  Result := True;
  strSQL := 'UPDATE ' + tabela + ' SET ' + campoNovoValor + ' = ' +
    QuotedStr(novoValor) + ' WHERE (' + campoCondicao + ' = ' +
    QuotedStr(valorCampoCondicao) + ');';
  try
    conexao.ExecSQL(strSQL);
  except
    Result := False;
  end;
end;

end.
