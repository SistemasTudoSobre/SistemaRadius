unit uRealRelatorio;

interface

uses Vcl.Forms, System.SysUtils, FMX.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  tOrdemRelatorio = (tOrdemRelatorioCRESCENTE, tOrdemRelatorioDECRESCENTE);
  tOrdenacaoRelacaoProdutos = (tOrdenRelProdCODIGO, tOrdenRelProdNOME,
    tOrdenRelProdVALOR);

procedure relatorioModelo();
procedure relatorioListagemGeralProdutos(ordenacao: tOrdenacaoRelacaoProdutos;
  ordem: tOrdemRelatorio);

implementation

uses dmRelatoriosFast, uConstantes, uUsuario;

procedure relatorioModelo();
const
  RELATORIO_MODELO = 'MODELO DE RELATÓRIO PARA IMPRESSAO';
var
  relatorio: TdmRelatorioFast;
  dsConsulta: TFDQuery;
begin
  relatorio := abrirModuloRelatorio();
  dsConsulta := TFDQuery.Create(Application);
  try
    dsConsulta.Connection := conexaoSistema;
    dsConsulta.SQL.Text := 'SELECT * FROM RADIUS_PRODUTO';
    dsConsulta.Active := True;
    relatorio.cdsModelo.Close;
    relatorio.cdsModelo.CreateDataSet;
    while not dsConsulta.Eof do
    begin
      relatorio.cdsModelo.Insert;
      relatorio.cdsModelo.FieldByName('CODIGO').AsInteger :=
        dsConsulta.FieldByName('ID_PRODUTO').AsInteger;
      relatorio.cdsModelo.Post;
      dsConsulta.Next;
    end;
    abrirRelatorio(relatorio.frxReportModelo, RELATORIO_MODELO);
  finally
    FreeAndNil(dsConsulta);
    fecharModuloRelatorio();
  end;
end;

procedure relatorioListagemGeralProdutos(ordenacao: tOrdenacaoRelacaoProdutos;
  ordem: tOrdemRelatorio);
const
  RELATORIO_MODELO = 'RELAÇÃO GERAL DE PRODUTOS';
var
  relatorio: TdmRelatorioFast;
  dsConsulta: TFDQuery;
  strOrdenacao: string;
  strOrdem: string;
begin
  relatorio := abrirModuloRelatorio();
  dsConsulta := TFDQuery.Create(Application);
  try
    dsConsulta.Connection := conexaoSistema;
    case ordenacao of
      tOrdenRelProdCODIGO:
        strOrdenacao := ' ORDER BY ID_PRODUTO';
      tOrdenRelProdNOME:
        strOrdenacao := ' ORDER BY NOME_PRODUTO';
      tOrdenRelProdVALOR:
        strOrdenacao := ' ORDER BY VALOR_PRODUTO';
    end;
    case ordem of
      tOrdemRelatorioCRESCENTE:
        strOrdem := ' DESC';
      tOrdemRelatorioDECRESCENTE:
        strOrdem := '';
    end;
    dsConsulta.SQL.Text :=
      'SELECT ID_PRODUTO, NOME_PRODUTO, VALOR_PRODUTO FROM RADIUS_PRODUTO ' +
      strOrdenacao + strOrdem;
    dsConsulta.Active := True;
    relatorio.cdsListagemProduto.Close;
    relatorio.cdsListagemProduto.CreateDataSet;
    while not dsConsulta.Eof do
    begin
      relatorio.cdsListagemProduto.Insert;
      relatorio.cdsListagemProduto.FieldByName('ID_PRODUTO').AsInteger :=
        dsConsulta.FieldByName('ID_PRODUTO').AsInteger;
      relatorio.cdsListagemProduto.FieldByName('NOME_PRODUTO').AsString :=
        dsConsulta.FieldByName('NOME_PRODUTO').AsString;
      relatorio.cdsListagemProduto.FieldByName('VALOR_PRODUTO').AsCurrency :=
        dsConsulta.FieldByName('VALOR_PRODUTO').AsCurrency;
      relatorio.cdsListagemProduto.Post;
      dsConsulta.Next;
    end;
    abrirRelatorio(relatorio.frxReportListagemProduto, RELATORIO_MODELO);
  finally
    FreeAndNil(dsConsulta);
    fecharModuloRelatorio();
  end;
end;

end.
