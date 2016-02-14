unit uEstoque;

interface

uses System.SysUtils, FireDAC.Comp.Client;

type
  tMovimentoEstoque = (tMovimentoEstoqueENTRADA, tMovimentoEstoqueSAIDA);

procedure adicionarMovimentacaoEstoque(movimentacao: tMovimentoEstoque;
  codProduto: string; quantidade: integer; codComanda: string = '');
function verificarProdutoEmEstoque(codProduto: string;
  var qtdEntrada, qtdSaida, qtdTotal: integer; qntMinima: integer = 1): Boolean;
function verificarProdutoMovimentaEstoque(codProduto: string): Boolean;

implementation

uses dmPrincipal, uConstantes, uData, uHora, uUsuario, uConsulta;

function getCodigoMovimentacao(mvmtc: tMovimentoEstoque): string;
begin
  case mvmtc of
    tMovimentoEstoqueENTRADA:
      Result := '1';
    tMovimentoEstoqueSAIDA:
      Result := '2';
  end;
end;

function verificarProdutoMovimentaEstoque(codProduto: string): Boolean;
begin
  Result := buscarDado(conexaoSistema, 'RADIUS_PRODUTO', 'ID_PRODUTO',
    'LG_CONTROLE_ESTOQUE', codProduto) = '1';
end;

procedure adicionarMovimentacaoEstoque(movimentacao: tMovimentoEstoque;
  codProduto: string; quantidade: integer; codComanda: string = '');
const
  LINHA_SQL =
    'INSERT INTO RADIUS_ESTOQUE (ID_MOVIMENTO, DATA_ESTOQUE, HORA_ESTOQUE, ID_USUARIO, ID_PRODUTO, QTD_ESTOQUE, ID_COMANDA) VALUES (%s, ''%s'', ''%s'', %s, %s, %d, %s);';
var
  dataMovimentacao: string[10];
  horaMovimentacao: string[8];
begin
  dataMovimentacao := FormatDateTime('dd.mm.yyyy', getDataHoje);
  horaMovimentacao := FormatDateTime('hh.MM.SS', getHoraAgora);
  dmPrincipal.frmDmPrincipal.FDConnexao.ExecSQL
    (Format(LINHA_SQL, [getCodigoMovimentacao(movimentacao), dataMovimentacao,
    horaMovimentacao, getCodigoUsuario, codProduto, quantidade, codComanda]))
end;

// qntMinima = Parametro para que se verifique no banco se a quantidade do produto que tem no estoque é maior ou igual a "qnt mínima" que deverá ter em estoque
function verificarProdutoEmEstoque(codProduto: string;
  var qtdEntrada, qtdSaida, qtdTotal: integer; qntMinima: integer = 1): Boolean;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'WITH TMP_ENTRADA AS (' + #13 + 'SELECT' + #13 +
    'P.ID_PRODUTO AS "PRODUTO_ENTRADA",' + #13 +
    'SUM(P.QTD_ESTOQUE) AS QTD_ENTRADA' + #13 + 'FROM RADIUS_ESTOQUE P' + #13 +
    'WHERE P.ID_MOVIMENTO = 1' + #13 + 'GROUP BY 1' + #13 + '), TMP_SAIDA AS ('
    + #13 + 'SELECT' + #13 + 'Q.ID_PRODUTO AS "PRODUTO_SAIDA",' + #13 +
    'SUM(Q.QTD_ESTOQUE) AS QTD_SAIDA' + #13 + 'FROM RADIUS_ESTOQUE Q' + #13 +
    'INNER JOIN RADIUS_COMANDA N ON (N.ID_COMANDA = Q.ID_COMANDA)' + #13 +
    'WHERE' + #13 + 'Q.ID_PRODUTO = 16' + #13 + 'AND Q.ID_MOVIMENTO = 2' + #13 +
    'AND ((N.ID_CNC_CMD <> 1) OR (N.ID_CNC_CMD IS NULL))' + #13 + 'GROUP BY 1' +
    #13 + ')' + #13 + 'SELECT DISTINCT' + #13 +
    'IIF(E.QTD_ENTRADA IS NULL, ''0'', E.QTD_ENTRADA) AS ENTRADA,' + #13 +
    'IIF(S.QTD_SAIDA IS NULL, ''0'', S.QTD_SAIDA) AS SAIDA' + #13 +
    'FROM RADIUS_ESTOQUE T' + #13 +
    'INNER JOIN TMP_ENTRADA E ON (T.ID_PRODUTO = E.PRODUTO_ENTRADA)' + #13 +
    'INNER JOIN RADIUS_PRODUTO R ON (R.ID_PRODUTO = T.ID_PRODUTO)' + #13 +
    'LEFT JOIN TMP_SAIDA S ON (T.ID_PRODUTO = S.PRODUTO_SAIDA)' + #13 + 'WHERE'
    + #13 + 'T.ID_PRODUTO = ' + codProduto + #13 +
    'AND R.LG_CONTROLE_ESTOQUE = 1';

  dsConsulta := TFDQuery.Create(dmPrincipal.frmDmPrincipal.FDConnexao);
  dsConsulta.Connection := dmPrincipal.frmDmPrincipal.FDConnexao;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    qtdEntrada := StrToIntDef(dsConsulta.FieldByName('ENTRADA').AsString, 0);
    qtdSaida := StrToIntDef(dsConsulta.FieldByName('SAIDA').AsString, 0);
    qtdTotal := qtdEntrada - qtdSaida;
    Result := (qtdEntrada - qtdSaida) >= qntMinima;
  finally
    FreeAndNil(dsConsulta)
  end;
end;

end.
