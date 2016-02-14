unit uRealCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadMaster, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, SimpleDS, Data.DBXFirebird,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ImgList, System.ImageList;

type
  TfrmRealCadProduto = class(TfrmCadMaster)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    btnEdtNomeFornecedor: TButtonedEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    btnEdtTipoProduto: TButtonedEdit;
    salvarRelacaoProdutos: TSaveDialog;
    DBContrEstoq: TDBCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure bbIncluirClick(Sender: TObject);
    procedure bbPesquisarClick(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
    procedure bbImprimirClick(Sender: TObject);
    procedure DBEdit4Enter(Sender: TObject);
    procedure bbCancelarClick(Sender: TObject);
    procedure bbGravarClick(Sender: TObject);
  private
    procedure imprimirRelacaoDeProdutos;
    procedure FormatarValor;
    { Private declarations }
  public
    { Public declarations }
    class procedure cadastrarProduto(Sender: TObject);
  end;

implementation

uses uConstantes, uConsulta, uPesquisasPadrao, uWindows;

{$R *.dfm}

const
  NOME_TABELA = 'RADIUS_PRODUTO';

var
  frmRealCadProduto: TfrmRealCadProduto;

  { TfrmCadMaster1 }

procedure TfrmRealCadProduto.imprimirRelacaoDeProdutos();
var
  strSQLConsulta, arquivo: string;
  sdConsultaProdutos: TFDQuery;
  codigoProduto, nomeProduto: string;
  separacao: string;
begin
  if salvarRelacaoProdutos.Execute then
    arquivo := salvarRelacaoProdutos.FileName
  else
    Exit;

  strSQLConsulta := 'SELECT * FROM RADIUS_PRODUTO';
  sdConsultaProdutos := TFDQuery.Create(Application);
  try
    sdConsultaProdutos.Connection := conexaoSistema;
    sdConsultaProdutos.SQL.Text := strSQLConsulta;
    sdConsultaProdutos.Active := True;
    while not sdConsultaProdutos.Eof do
    begin
      codigoProduto := sdConsultaProdutos.FieldByName('ID_PRODUTO').AsString;
      nomeProduto := sdConsultaProdutos.FieldByName('NOME_PRODUTO').AsString;
      case Length(codigoProduto) of
        1:
          separacao := StringOfChar('.', 8) + ': ';
        2:
          separacao := StringOfChar('.', 7) + ': ';
        3:
          separacao := StringOfChar('.', 6) + ': ';
      end;
      EscreverArquivoTexto(arquivo, codigoProduto + separacao + nomeProduto);
      sdConsultaProdutos.Next();
    end;
  finally
    ShowMessage('Arquivo com a listagem de produtos em: ' + #13 + arquivo);
    FreeAndNil(sdConsultaProdutos)
  end;

end;

procedure TfrmRealCadProduto.bbCancelarClick(Sender: TObject);
begin
  inherited;
  FormatarValor();
end;

procedure TfrmRealCadProduto.bbGravarClick(Sender: TObject);
begin
  inherited;
  FormatarValor();
end;

procedure TfrmRealCadProduto.bbImprimirClick(Sender: TObject);
begin
  // inherited;
  imprimirRelacaoDeProdutos();
end;

procedure TfrmRealCadProduto.bbIncluirClick(Sender: TObject);
begin
  inherited;
  FDTablePadrao.FieldByName('ID_FORNECEDOR').AsString := '1';
  FDTablePadrao.FieldByName('LG_CONTROLE_ESTOQUE').AsString := '1';
end;

procedure TfrmRealCadProduto.bbPesquisarClick(Sender: TObject);
begin
  setSQLPesquisa(getSQLProduto());
  inherited;
end;

class procedure TfrmRealCadProduto.cadastrarProduto(Sender: TObject);
begin
  try
    if frmRealCadProduto = nil then
      frmRealCadProduto := TfrmRealCadProduto.Create(TComponent(Sender),
        conexaoSistema, NOME_TABELA, ['', '']);
    frmRealCadProduto.Show;
  except
    if frmRealCadProduto <> nil then
      FreeAndNil(frmRealCadProduto);
  end;
end;

procedure TfrmRealCadProduto.DBEdit2Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
    btnEdtNomeFornecedor.Text := buscarDado(conexaoSistema, 'RADIUS_FORNECEDOR',
      'ID_FORNECEDOR', 'NOME_FORNECEDOR', TDBEdit(Sender).Text)
  else
    btnEdtNomeFornecedor.Clear;
end;

procedure TfrmRealCadProduto.DBEdit4Enter(Sender: TObject);
begin
  inherited;
  ShowMessage('Entrei');
end;

procedure TfrmRealCadProduto.FormatarValor();
begin
  if DBEdit4.Text <> '' then
    DBEdit4.Text := FormatFloat('###,###,##0.00', StrToFloat(DBEdit4.Text));
end;

procedure TfrmRealCadProduto.DBEdit5Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
    btnEdtTipoProduto.Text := buscarDado(conexaoSistema, 'RADIUS_TP_ALIMENTO',
      'TP_ALIMENTO', 'NOME_TP_ALIMENTO', TDBEdit(Sender).Text)
  else
    btnEdtTipoProduto.Clear;
end;

procedure TfrmRealCadProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if frmRealCadProduto <> nil then
    FreeAndNil(frmRealCadProduto);
end;

procedure TfrmRealCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  setDataField(DBEdit1, 'ID_PRODUTO', 'Produto');
  setDataField(DBEdit3, 'NOME_PRODUTO', 'Nome Produto');
  setDataField(DBEdit4, 'VALOR_PRODUTO', 'Valor');
  setDataField(DBEdit2, 'ID_FORNECEDOR', 'Fornecedor');
  setDataField(DBEdit5, 'ID_TP_ALIMENTO', 'Alimento');
  setDataField(DBContrEstoq, 'LG_CONTROLE_ESTOQUE', 'Controle Estoque');
end;

end.
