unit uRealCadEntradaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadMaster, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ImgList, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, System.ImageList;

type
  TMovimentoProduto = (tMpvProdENTRADA, tMpvProdSAIDA);

type
  TfrmEntradaEstoque = class(TfrmCadMaster)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    btnEdtNomeProduto: TButtonedEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    ButtonedEdit1: TButtonedEdit;
    DBEdit5: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure bbIncluirClick(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure DBEdit4Change(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
  private
    { Private declarations }
    FMovimentacao: TMovimentoProduto;
    procedure setMovimentacao(movimentacao: TMovimentoProduto);
    function getMovimentacao(): TMovimentoProduto;
    function getCodigoMovimento(): string;
    procedure ajustarTituloJanela();
  public
    { Public declarations }
    class procedure abrirCadastroEntradaEstoque(Sender: TObject;
      movimentacao: TMovimentoProduto);
  end;

implementation

uses uConstantes, uHora, uData, uUsuario, uConsulta;

var
  frmEntradaEstoque: TfrmEntradaEstoque;

{$R *.dfm}

const
  NOME_TABELA = 'RADIUS_ESTOQUE';

  { TfrmEntradaEstoque }

class procedure TfrmEntradaEstoque.abrirCadastroEntradaEstoque(Sender: TObject;
  movimentacao: TMovimentoProduto);
begin
  if frmEntradaEstoque = nil then
    frmEntradaEstoque := TfrmEntradaEstoque.Create(TComponent(Sender),
      conexaoSistema, NOME_TABELA, ['', '']);
  frmEntradaEstoque.setMovimentacao(movimentacao);
  frmEntradaEstoque.ajustarTituloJanela();
  frmEntradaEstoque.Show;
end;

procedure TfrmEntradaEstoque.ajustarTituloJanela;
const
  SUFIXO = '%s de produto em estoque';
begin
  case getMovimentacao of
    tMpvProdENTRADA:
      Caption := Format(SUFIXO, ['Entrada']);
    tMpvProdSAIDA:
      Caption := Format(SUFIXO, ['Saída']);
  end;
end;

procedure TfrmEntradaEstoque.bbIncluirClick(Sender: TObject);
begin
  inherited;
  FDTablePadrao.FieldByName('ID_MOVIMENTO').AsString := getCodigoMovimento();
  FDTablePadrao.FieldByName('DATA_ESTOQUE').AsDateTime := getDataHoje();
  FDTablePadrao.FieldByName('HORA_ESTOQUE').AsDateTime := getHoraAgora();
  FDTablePadrao.FieldByName('ID_USUARIO').AsString := getCodigoUsuario();
end;

procedure TfrmEntradaEstoque.DBEdit2Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
    btnEdtNomeProduto.Text := buscarDado(conexaoSistema, 'RADIUS_PRODUTO',
      'ID_PRODUTO', 'NOME_PRODUTO', TDBEdit(Sender).Text)
  else
    btnEdtNomeProduto.Clear;
end;

procedure TfrmEntradaEstoque.DBEdit4Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
    ButtonedEdit1.Text := buscarDado(conexaoSistema, 'RADIUS_MOV_ESTQ',
      'ID_MOVIMENTO', 'NOME_MOVIMENTO', TDBEdit(Sender).Text)
  else
    ButtonedEdit1.Clear;
end;

procedure TfrmEntradaEstoque.DBEdit5Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
    Edit1.Text := buscarDado(conexaoSistema, 'RADIUS_USUARIO', 'ID_USUARIO',
      'NOME', TDBEdit(Sender).Text)
  else
    Edit1.Clear;
end;

procedure TfrmEntradaEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  setDataField(DBEdit1, 'ID_COD_ESTOQUE', 'Estoque');
  setDataField(DBEdit2, 'ID_PRODUTO', 'Produto');
  setDataField(DBEdit3, 'QTD_ESTOQUE', 'Quantidade');
  setDataField(DBEdit4, 'ID_MOVIMENTO', 'Movimento');
  setDataField(DBEdit5, 'ID_USUARIO', 'Usuario');
end;

function TfrmEntradaEstoque.getCodigoMovimento: string;
begin
  case getMovimentacao of
    tMpvProdENTRADA:
      Result := '1';
    tMpvProdSAIDA:
      Result := '2';
  end;
end;

function TfrmEntradaEstoque.getMovimentacao: TMovimentoProduto;
begin
  Result := FMovimentacao;
end;

procedure TfrmEntradaEstoque.setMovimentacao(movimentacao: TMovimentoProduto);
begin
  FMovimentacao := movimentacao;
end;

end.
