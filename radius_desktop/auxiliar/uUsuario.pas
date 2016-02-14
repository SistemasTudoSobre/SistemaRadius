unit uUsuario;

interface

procedure setUsuario(nomeUsuario: string);
procedure setCodigoUsuario(codigo: string);

function getCodigoUsuario(): string;
function getUsuario(): string;

implementation

var
  usuarioLogado: string[10];
  codUsuarioLogado: string;

function getUsuario(): string;
begin
  Result := usuarioLogado;
end;

procedure setUsuario(nomeUsuario: string);
begin
  usuarioLogado := nomeUsuario
end;

procedure setCodigoUsuario(codigo: string);
begin
  codUsuarioLogado := codigo;
end;

function getCodigoUsuario(): string;
begin
  Result := codUsuarioLogado;
end;

end.
