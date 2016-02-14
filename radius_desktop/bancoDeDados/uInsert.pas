unit uInsert;

interface

uses FireDAC.Comp.Client, System.SysUtils;

function inserirRegistro(conexao: TFDConnection; tabela: string;
  campos: array of string; valores: array of string): Boolean;

implementation

function inserirRegistro(conexao: TFDConnection; tabela: string;
  campos: array of string; valores: array of string): Boolean;
var
  sql: string;
  i: integer;
  todosCampos, todosValores: string;
begin
  Result := True;

  for i := Low(campos) to High(campos) do
  begin
    if todosCampos = '' then
      todosCampos := campos[i]
    else
      todosCampos := todosCampos + ', ' + campos[i];
  end;

  for i := Low(valores) to High(valores) do
  begin
    if todosValores = '' then
      todosValores := QuotedStr(valores[i])
    else
      todosValores := todosValores + ', ' + QuotedStr(valores[i]);
  end;

  sql := 'INSERT INTO ' + tabela + ' (' + todosCampos + ') VALUES (' +
    todosValores + ')';
  try
    conexao.ExecSQL(sql);
  except
    Result := False;
  end;
end;

end.
