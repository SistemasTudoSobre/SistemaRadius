unit dmRelatoriosFast;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Data.DB,
  Datasnap.DBClient, Vcl.Forms, SimpleDS, dmPrincipal, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DBXFirebird, Data.SqlExpr;

type
  TdmRelatorioFast = class(TDataModule)
    frxReportModelo: TfrxReport;
    frxDBDatasetModelo: TfrxDBDataset;
    cdsModelo: TClientDataSet;
    cdsModeloCODIGO: TIntegerField;
    frxReportListagemProduto: TfrxReport;
    frxDBDatasetListagemProduto: TfrxDBDataset;
    cdsListagemProduto: TClientDataSet;
    cdsListagemProdutoID_PRODUTO: TIntegerField;
    cdsListagemProdutoNOME_PRODUTO: TStringField;
    cdsListagemProdutoVALOR_PRODUTO: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function abrirModuloRelatorio(): TdmRelatorioFast;
procedure fecharModuloRelatorio();
procedure abrirRelatorio(relatorio: TfrxReport;
  camposAdicionais: array of string;
  valoresAdicionais: array of string); overload;
procedure abrirRelatorio(relatorio: TfrxReport); overload;
procedure abrirRelatorio(relatorio: TfrxReport;
  tituloRelatorio: string); overload;

var
  dmRelatorioFast: TdmRelatorioFast;

implementation

uses uUsuario, uConsultasCliente;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function abrirModuloRelatorio(): TdmRelatorioFast;
begin
  if dmRelatorioFast = nil then
    dmRelatorioFast := TdmRelatorioFast.Create(Application);
  Result := dmRelatorioFast;
end;

procedure fecharModuloRelatorio();
begin
  if dmRelatorioFast <> nil then
    FreeAndNil(dmRelatorioFast);
end;

procedure setVariaveisRelatorio(relatorio: TfrxReport;
  camposAdicionais: array of string; valoresAdicionais: array of string);
var
  i: integer;
begin
  // Variaveis padrão do sistema
  relatorio.Script.AddVariable('usuario', 'String', getUsuario());
  relatorio.Script.AddVariable('cliente', 'String', getNomeCliente());

  // Define caso existam novas variaveis
  for i := Low(camposAdicionais) to High(camposAdicionais) do
    relatorio.Script.AddVariable(camposAdicionais[i], 'String',
      valoresAdicionais[i]);
end;

procedure abrirRelatorio(relatorio: TfrxReport;
  camposAdicionais: array of string; valoresAdicionais: array of string);
begin
  setVariaveisRelatorio(relatorio, camposAdicionais, valoresAdicionais);
  relatorio.ShowReport();
end;

procedure abrirRelatorio(relatorio: TfrxReport);
begin
  setVariaveisRelatorio(relatorio, [], []);
  relatorio.ShowReport();
end;

procedure abrirRelatorio(relatorio: TfrxReport; tituloRelatorio: string);
begin
  setVariaveisRelatorio(relatorio, ['tituloRelatorio'], [tituloRelatorio]);
  relatorio.ShowReport();
end;

end.
