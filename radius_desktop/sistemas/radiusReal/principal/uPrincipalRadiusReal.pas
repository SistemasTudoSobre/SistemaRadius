unit uPrincipalRadiusReal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPrincipalSistema, Vcl.Menus,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ImgList, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.ToolWin, Vcl.XPMan, Data.DB,
  Datasnap.DBClient, System.ImageList;

type
  TfrmPrincipalRadiusReal = class(TfrmPrincipalSistema)
    mmRadiusReal: TMainMenu;
    Cadastra1: TMenuItem;
    Produto1: TMenuItem;
    Processamento1: TMenuItem;
    AberturadeCaixa: TMenuItem;
    FechamentodeCaixa: TMenuItem;
    Comanda: TMenuItem;
    alterarStatusComanda: TMenuItem;
    CriarComanda: TMenuItem;
    Caixa: TMenuItem;
    ReceberemCaixa: TMenuItem;
    Relaodecomandaspormesa1: TMenuItem;
    ActionList1: TActionList;
    AberturaCaixa: TAction;
    ReceberCaixa: TAction;
    FechamentoCaixa: TAction;
    Entradanoestoque1: TMenuItem;
    Relatrios1: TMenuItem;
    Saldodeprodutoemestoque1: TMenuItem;
    Produtos1: TMenuItem;
    RelaodeProdutos1: TMenuItem;
    OrdenadoporCdigo1: TMenuItem;
    OrdenadoporNome1: TMenuItem;
    OrdenadoporValor1: TMenuItem;
    Crecente1: TMenuItem;
    Decrescente1: TMenuItem;
    Crecente3: TMenuItem;
    Crecente2: TMenuItem;
    Decrescente2: TMenuItem;
    Decrescente3: TMenuItem;
    Relaes1: TMenuItem;
    procedure Produto1Click(Sender: TObject);
    procedure CriarComandaClick(Sender: TObject);
    procedure alterarStatusComandaClick(Sender: TObject);
    procedure AberturaCaixaExecute(Sender: TObject);
    procedure FechamentoCaixaExecute(Sender: TObject);
    procedure ReceberCaixaExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Entradanoestoque1Click(Sender: TObject);
    procedure Saldodeprodutoemestoque1Click(Sender: TObject);
    procedure Crecente1Click(Sender: TObject);
    procedure Decrescente3Click(Sender: TObject);
    procedure Decrescente1Click(Sender: TObject);
    procedure Crecente3Click(Sender: TObject);
    procedure Decrescente2Click(Sender: TObject);
    procedure Crecente2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure abrirSistema();
  end;

implementation

uses uRealCadProduto, uComanda, uAbreCaixa, uFechaCaixa, uAlteraStatusComanda,
  uRealCadEntradaEstoque, uRealRelatorio;

{$R *.dfm}

var
  frmPrincipalRadiusReal: TfrmPrincipalRadiusReal;

  { TfrmPrincipalSistema1 }

procedure TfrmPrincipalRadiusReal.AberturaCaixaExecute(Sender: TObject);
begin
  inherited;
  TfrmAberturaCaixa.AbrirCaixa(Sender);
end;

class procedure TfrmPrincipalRadiusReal.abrirSistema;
begin
  if frmPrincipalRadiusReal = nil then
    Application.CreateForm(TfrmPrincipalRadiusReal, frmPrincipalRadiusReal);
  frmPrincipalRadiusReal.Show;
  frmPrincipalRadiusReal.WindowState := wsMaximized;
end;

procedure TfrmPrincipalRadiusReal.Action1Execute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmPrincipalRadiusReal.alterarStatusComandaClick(Sender: TObject);
begin
  inherited;
  TfrmAlterarStatusComanda.AbrirTelaAlteracaoStatus();
end;

procedure TfrmPrincipalRadiusReal.Crecente1Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdCODIGO, tOrdemRelatorioCRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.Crecente2Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdVALOR, tOrdemRelatorioCRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.Crecente3Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdNOME, tOrdemRelatorioCRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.CriarComandaClick(Sender: TObject);
begin
  inherited;
  TfrmComanda.abrirComanda();
end;

procedure TfrmPrincipalRadiusReal.Decrescente1Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdCODIGO,
    tOrdemRelatorioDECRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.Decrescente2Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdNOME, tOrdemRelatorioDECRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.Decrescente3Click(Sender: TObject);
begin
  inherited;
  relatorioListagemGeralProdutos(tOrdenRelProdVALOR,
    tOrdemRelatorioDECRESCENTE);
end;

procedure TfrmPrincipalRadiusReal.Entradanoestoque1Click(Sender: TObject);
begin
  inherited;
  TfrmEntradaEstoque.abrirCadastroEntradaEstoque(Sender, tMpvProdENTRADA);
end;

procedure TfrmPrincipalRadiusReal.FechamentoCaixaExecute(Sender: TObject);
begin
  inherited;
  TfrmFechamentoCaixa.abrriFechamentoDeCaixa(Sender);
end;

procedure TfrmPrincipalRadiusReal.Produto1Click(Sender: TObject);
begin
  inherited;
  TfrmRealCadProduto.cadastrarProduto(Sender);
end;

procedure TfrmPrincipalRadiusReal.ReceberCaixaExecute(Sender: TObject);
begin
  inherited;
  ShowMessage('');
end;

procedure TfrmPrincipalRadiusReal.Saldodeprodutoemestoque1Click
  (Sender: TObject);
begin
  inherited;
  relatorioModelo();
end;

end.
