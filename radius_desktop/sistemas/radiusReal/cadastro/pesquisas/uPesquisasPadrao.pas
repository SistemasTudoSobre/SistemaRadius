unit uPesquisasPadrao;

interface

function getSQLProduto(condicao: string = ''): string;

implementation

function getSQLProduto(condicao: string = ''): string;
begin
  Result := 'SELECT ' + #13 + '   R.ID_PRODUTO, ' + #13 +
    '   CAST(R.NOME_PRODUTO AS VARCHAR(50)) AS "NOME DO PRODUTO", ' + #13 +
    '   R.ID_FORNECEDOR AS "FORNECEDOR", ' + #13 +
    '   F.NOME_FORNECEDOR AS "NOME DO FORNECEDOR" ' + #13 +
    'FROM RADIUS_PRODUTO R ' + #13 +
    'INNER JOIN RADIUS_FORNECEDOR F ON (R.ID_FORNECEDOR = F.ID_FORNECEDOR) ';
  if condicao <> '' then
    Result := Result + ' WHERE ' + condicao;
end;

end.
