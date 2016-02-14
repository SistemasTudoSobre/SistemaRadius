unit uComanda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.DBCGrids, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.Client, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, System.Actions, Vcl.ActnList, Vcl.BandActn;

type
  TStatusMesa = (stsMesaLIVRE, stsMesaOCUPADA, stsMesaCANCELADA,
    stsMesaADMINISTRATIVA);

  TfrmComanda = class(TfrmMaster)
    pnlTopo: TPanel;
    pnlItens: TPanel;
    pnlTotal: TPanel;
    edtNomeStatusMesa: TEdit;
    DBGrid1: TDBGrid;
    pnlAdicionarItem: TPanel;
    edtNomeProduto: TEdit;
    Label1: TLabel;
    edtTotal: TEdit;
    edtCodigoComanda: TEdit;
    edtMesa: TEdit;
    edtProduto: TEdit;
    edtStatusComanda: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    fdqProdutos: TFDQuery;
    dsProdutos: TDataSource;
    bbAlterarMesa: TBitBtn;
    bbCancelarComanda: TBitBtn;
    Label5: TLabel;
    edtQtdt: TEdit;
    procedure edtCodigoComandaExit(Sender: TObject);
    procedure edtCodigoComandaChange(Sender: TObject);
    procedure edtMesaChange(Sender: TObject);
    procedure edtProdutoChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtTotalExit(Sender: TObject);
    procedure bbCancelarComandaClick(Sender: TObject);
    procedure bbAlterarMesaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ControlAction1Execute(Sender: TObject);
    procedure CustomizeActionBars1Execute(Sender: TObject);
    procedure edtQtdtKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdtEnter(Sender: TObject);
    procedure edtQtdtExit(Sender: TObject);
  private
    { Private declarations }
    FComanda: Integer;
    FCodigoComanda: Integer;
    FMesa: Integer;

    procedure setComanda(value: Integer);
    function getComanda(): Integer;

    function getCodigoComanda(): Integer;
    procedure setCodigoComanda(value: Integer);

    function getMesa(): Integer;
    procedure setMesa(value: Integer);
    function buscarProximoCodigoComanda: string;
    function ultimoCodigoComanda: Integer;
    function SalvarComanda: Boolean;
    procedure inserirNovaComanda(novoCodigo, mesa: Integer);
    procedure mudarStatusMesa(mesa: Integer; novoStatus: TStatusMesa);
    function adicionarProdutoNaComanda(codigoComanda, produto: Integer)
      : Boolean;
    function getIdComanda(codigo: string): string;
    procedure listarProdutos(conexao: TFDConnection; codigoComanda: string);
    function getValorTotalProdutos(conexao: TFDConnection;
      codigoComanda: string): Currency;
    procedure alterarMesa(mesaAtual, novaMesa: string);
    function getMesaDisponivel(codMesa: string): Boolean;
    procedure adicionarProduto(codProduto: string; quantidade: Integer = 1);
  public
    { Public declarations }
    class procedure abrirComanda(codigoComanda: string = '');
  end;

implementation

uses uConsulta, uConstantes, uConsultaComanda, uInsert, uUsuario, uUpdate,
  uConsultaCaixa, uData, uHora, uAlteraStatusComanda,
  uEstoque;

var
  frmComanda: TfrmComanda;

{$R *.dfm}
  { TfrmMaster1 }

class procedure TfrmComanda.abrirComanda(codigoComanda: string = '');
begin
  if buscarCaixaAberto(conexaoSistema, getCodigoUsuario()) <> '' then
  begin
    frmComanda := TfrmComanda.Create(Application);
    if codigoComanda <> '' then
      frmComanda.setCodigoComanda(StrToInt(codigoComanda));
    frmComanda.ShowModal;
  end
  else
    ShowMessage('Para utilizar a comanda primeiramente abra o caixa.');
end;

procedure TfrmComanda.edtCodigoComandaChange(Sender: TObject);
var
  comandaCancelada: Boolean;
begin
  inherited;
  if Length(edtCodigoComanda.Text) >= 7 then
  begin

    edtStatusComanda.Text := buscarStatusComanda(conexaoSistema,
      getIdComanda(edtCodigoComanda.Text));
    edtMesa.Text := buscarMesaComanda(conexaoSistema,
      getIdComanda(edtCodigoComanda.Text));

    comandaCancelada := edtStatusComanda.Text = 'CANCELADA';

    edtProduto.ReadOnly := comandaCancelada;

    if edtMesa.Text <> '' then // Se a comanda ja existe
    begin
      edtProduto.SetFocus;
      setComanda(StrToInt(getIdComanda(edtCodigoComanda.Text)));
    end;

    bbCancelarComanda.Enabled := (getComanda() <> 0) and (not comandaCancelada);
    bbAlterarMesa.Enabled := (getComanda() <> 0) and (not comandaCancelada);

  end
  else
  begin
    setComanda(0);
    edtStatusComanda.Clear;
    edtMesa.Clear;
    edtProduto.Clear;
    bbCancelarComanda.Enabled := False;
    bbAlterarMesa.Enabled := False;
  end;

  if (edtStatusComanda.Text <> '') then
    setCodigoComanda(StrToInt(edtCodigoComanda.Text))
  else
    setCodigoComanda(0);

  edtMesa.Enabled := getCodigoComanda() = 0;

  listarProdutos(conexaoSistema, IntToStr(getComanda()));
  edtTotal.Text := FormatFloat('###,#0.00',
    getValorTotalProdutos(conexaoSistema, IntToStr(getComanda())));
end;

procedure TfrmComanda.mudarStatusMesa(mesa: Integer; novoStatus: TStatusMesa);
begin
  case novoStatus of
    stsMesaLIVRE:
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '1',
        'ID_MESA', IntToStr(mesa));
    stsMesaOCUPADA:
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '2',
        'ID_MESA', IntToStr(mesa));
    stsMesaCANCELADA:
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '3',
        'ID_MESA', IntToStr(mesa));
    stsMesaADMINISTRATIVA:
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '4',
        'ID_MESA', IntToStr(mesa));
  end;
end;

procedure TfrmComanda.edtCodigoComandaExit(Sender: TObject);
begin
  inherited;
  if edtCodigoComanda.Text <> '' then
    edtCodigoComanda.Text :=
      FormatFloat(StringOfChar('0', edtCodigoComanda.MaxLength),
      StrToFloat(edtCodigoComanda.Text));

  if edtCodigoComanda.Text = '' then
    edtCodigoComanda.Text := buscarProximoCodigoComanda();

  if edtStatusComanda.Text = '' then
    edtStatusComanda.Text := 'NOVA';

end;

procedure TfrmComanda.edtMesaChange(Sender: TObject);
var
  strMesa: string;
begin
  inherited;
  if Length(TEdit(Sender).Text) > 0 then
  begin
    strMesa := buscarDado(conexaoSistema, 'RADIUS_MESA', 'ID_MESA',
      'ID_STATUS_MESA', TEdit(Sender).Text);
    edtNomeStatusMesa.Text := buscarDado(conexaoSistema, 'RADIUS_STATUS_MESA',
      'ID_STATUS_MESA', 'NOME_STATUS_MESA', strMesa);
  end
  else
    edtNomeStatusMesa.Clear;

end;

procedure TfrmComanda.edtProdutoChange(Sender: TObject);
begin
  inherited;
  if Length(TEdit(Sender).Text) > 0 then
    edtNomeProduto.Text := buscarDado(conexaoSistema, 'RADIUS_PRODUTO',
      'ID_PRODUTO', 'NOME_PRODUTO', TEdit(Sender).Text)
  else
    edtNomeProduto.Text := '';
end;

procedure TfrmComanda.adicionarProduto(codProduto: string;
  quantidade: Integer = 1);
var
  qtdEntrada, qtdSaida, qtdTotal: Integer;
  produtoMovimentaEstoque: Boolean;
  idComandaGerada: Integer;
  i: Integer;
begin

  if codProduto = '' then
    Exit;

  if quantidade < 1 then
    Exit;

  // Verifica se é para controlar movimentação de produto em estoque
  produtoMovimentaEstoque := verificarProdutoMovimentaEstoque(codProduto);
  if produtoMovimentaEstoque then
  begin
    if not(verificarProdutoEmEstoque(codProduto, qtdEntrada, qtdSaida, qtdTotal,
      quantidade)) then
    begin
      ShowMessage
        ('Este produto e/ou quantidade não está disponível em estoque!');
      edtQtdt.SelectAll;
      Abort;
    end;
  end;

  // Cria a comanda case seja nova
  if getComanda() = 0 then
    SalvarComanda();

  // Adiciona os produtos na comanda
  for i := 1 to quantidade do
    adicionarProdutoNaComanda(getCodigoComanda(), StrToInt(codProduto));

  // Adiciona movimentação de estoca caso seja produto controlado por tal
  if produtoMovimentaEstoque then
    adicionarMovimentacaoEstoque(tMovimentoEstoqueSAIDA, codProduto, quantidade,
      IntToStr(getComanda()));

  // Controle da tela
  edtProduto.Clear;
  if edtMesa.Enabled then
    edtMesa.SetFocus
  else
    edtCodigoComanda.SetFocus;
  listarProdutos(conexaoSistema, IntToStr(getComanda()));
  edtTotal.Text := FormatFloat('###,#0.00',
    getValorTotalProdutos(conexaoSistema, IntToStr(getComanda())));

end;

procedure TfrmComanda.edtQtdtEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := '1';
  TEdit(Sender).SelectAll;
end;

procedure TfrmComanda.edtQtdtExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := '';
end;

procedure TfrmComanda.edtQtdtKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    adicionarProduto(edtProduto.Text, StrToIntDef(TEdit(Sender).Text, 0));
end;

procedure TfrmComanda.edtTotalExit(Sender: TObject);
begin
  inherited;
  edtCodigoComanda.Clear;
end;

procedure TfrmComanda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // inherited;
  if Key = VK_F2 then
    ShowMessage('');
end;

procedure TfrmComanda.FormShow(Sender: TObject);
begin
  inherited;
  if getCodigoComanda() <> 0 then
    edtCodigoComanda.Text := FormatFloat('0000000', getCodigoComanda());
end;

function TfrmComanda.ultimoCodigoComanda(): Integer;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 +
    '      IIF(MAX(C.CODIGO_DIARIO) IS NULL, 0, MAX(C.CODIGO_DIARIO)) AS ULTIMO_CODIGO_COMANDA '
    + #13 + '  FROM RADIUS_COMANDA C ' + #13 + '  WHERE ' + #13 +
    '      C.ID_ABERTURA_CAIXA = ' + QuotedStr(buscarCaixaAberto(conexaoSistema,
    getCodigoUsuario()));

  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexaoSistema;

  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;

  try
    Result := dsConsulta.FieldByName('ULTIMO_CODIGO_COMANDA').AsInteger;
  finally
    FreeAndNil(dsConsulta)
  end;

end;

function TfrmComanda.getIdComanda(codigo: string): string;
begin
  Result := buscarIdComanda(codigo);
end;

procedure TfrmComanda.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if not odd(fdqProdutos.RecNo) then
  begin
    if not(gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color := $00FFF8F0;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
    end;
  end;
end;

procedure TfrmComanda.inserirNovaComanda(novoCodigo, mesa: Integer);
var
  codUsuarioAtual: string;
begin
  codUsuarioAtual := getCodigoUsuario();
  if inserirRegistro(conexaoSistema, 'RADIUS_COMANDA',
    ['ID_STATUS', 'DATA', 'HORA', 'ID_USUARIO', 'CODIGO_DIARIO', 'ID_MESA',
    'ID_ABERTURA_CAIXA'], ['1', FormatDateTime('dd.mm.yyyy', getdataHoje()),
    FormatDateTime('hh.MM.ss', getHoraAgora()), codUsuarioAtual,
    IntToStr(novoCodigo), IntToStr(mesa), buscarCaixaAberto(conexaoSistema,
    getCodigoUsuario())]) then
    mudarStatusMesa(mesa, stsMesaOCUPADA);
end;

function TfrmComanda.getMesaDisponivel(codMesa: string): Boolean;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT' + #13#10 + 'M.ID_STATUS_MESA' + #13#10 +
    'FROM RADIUS_MESA M' + #13#10 + 'WHERE' + #13#10 + 'M.ID_MESA = ' +
    QuotedStr(codMesa);
  dsConsulta := TFDQuery.Create(Application);
  dsConsulta.Connection := conexaoSistema;
  dsConsulta.SQL.Text := strSQLConsulta;
  dsConsulta.Active := True;
  try
    Result := dsConsulta.FieldByName('ID_STATUS_MESA').AsString = '1';
  finally
    FreeAndNil(dsConsulta)
  end;
end;

function TfrmComanda.SalvarComanda(): Boolean;
begin
  if getMesaDisponivel(edtMesa.Text) then
  begin
    inserirNovaComanda(StrToInt(edtCodigoComanda.Text), StrToInt(edtMesa.Text));
    setComanda(StrToInt(getIdComanda(edtCodigoComanda.Text)));
  end
  else
    ShowMessage('Esta mesa não está disponível!');
end;

function TfrmComanda.adicionarProdutoNaComanda(codigoComanda,
  produto: Integer): Boolean;
var
  idComanda: string;
begin
  idComanda := IntToStr(getComanda());
  inserirRegistro(conexaoSistema, 'RADIUS_ITENS_COMANDA',
    ['ID_COMANDA', 'DATA', 'ID_PRODUTO', 'HORA', 'ID_USUARIO'],
    [idComanda, FormatDateTime('dd.mm.yyyy', getdataHoje()), IntToStr(produto),
    FormatDateTime('hh.MM.ss', getHoraAgora()), getCodigoUsuario()])
end;

procedure TfrmComanda.alterarMesa(mesaAtual, novaMesa: string);
begin
  if (novaMesa <> '') and getMesaDisponivel(novaMesa) then
    if AtualizarRegistro(conexaoSistema, 'RADIUS_COMANDA', 'ID_MESA', novaMesa,
      'ID_COMANDA', IntToStr(getComanda())) then
    begin
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '2',
        'ID_MESA', novaMesa);
      AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '1',
        'ID_MESA', mesaAtual);
    end;
end;

procedure TfrmComanda.bbAlterarMesaClick(Sender: TObject);
var
  novaMesa: string;
begin
  repeat
    ;
    novaMesa := InputBox('Radius', 'Nova mesa:', '')
  until novaMesa <> '';

  alterarMesa(edtMesa.Text, novaMesa);
  edtCodigoComandaChange(Sender);
end;

procedure TfrmComanda.bbCancelarComandaClick(Sender: TObject);
begin
  inherited;
  TfrmAlterarStatusComanda.AbrirTelaAlteracaoStatus(edtCodigoComanda.Text, '3');
end;

function TfrmComanda.buscarProximoCodigoComanda(): string;
begin
  Result := FormatFloat('0000000', ultimoCodigoComanda() + 1);
end;

procedure TfrmComanda.ControlAction1Execute(Sender: TObject);
begin
  inherited;
  ShowMessage('cntl + c');
end;

procedure TfrmComanda.CustomizeActionBars1Execute(Sender: TObject);
begin
  inherited;
  ShowMessage('');
end;

function TfrmComanda.getCodigoComanda: Integer;
begin
  Result := FCodigoComanda
end;

function TfrmComanda.getComanda: Integer;
begin
  Result := FComanda
end;

function TfrmComanda.getMesa: Integer;
begin
  Result := FMesa
end;

procedure TfrmComanda.setCodigoComanda(value: Integer);
begin
  FCodigoComanda := value;
end;

procedure TfrmComanda.setComanda(value: Integer);
begin
  FComanda := value
end;

procedure TfrmComanda.setMesa(value: Integer);
begin
  FMesa := value
end;

procedure TfrmComanda.listarProdutos(conexao: TFDConnection;
  codigoComanda: string);
var
  strSQLConsulta: string;
begin
  try
    strSQLConsulta := 'SELECT' + #13#10 + 'I.HORA,' + #13#10 +
      'I.ID_PRODUTO AS CODIGO,' + #13#10 +
      'CAST(P.NOME_PRODUTO AS VARCHAR(100)) AS "NOME DO PRODUTO",' + #13#10 +
      'P.VALOR_PRODUTO AS VALOR, ' + #13#10 +
      'CAST(U.NOME AS VARCHAR(25)) AS "NOME DO USUARIO"' + #13#10 +
      'FROM RADIUS_ITENS_COMANDA I' + #13#10 +
      'INNER JOIN RADIUS_PRODUTO P ON (I.ID_PRODUTO = P.ID_PRODUTO)' + #13#10 +
      'INNER JOIN RADIUS_USUARIO U ON (I.ID_USUARIO= U.ID_USUARIO)' + #13#10 +
      'WHERE' + #13#10 + 'I.ID_COMANDA = ' + QuotedStr(codigoComanda) + #13 +
      'ORDER BY I.HORA';
    fdqProdutos.Connection := conexao;
    fdqProdutos.SQL.Text := strSQLConsulta;
    fdqProdutos.Active := True;
    fdqProdutos.Last;
  except

  end;
end;

function TfrmComanda.getValorTotalProdutos(conexao: TFDConnection;
  codigoComanda: string): Currency;
var
  fdQuery: TFDQuery;
  strSQLConsulta: string;
begin
  try
    strSQLConsulta := 'SELECT' + #13#10 + 'SUM(P.VALOR_PRODUTO) AS TOTAL' +
      #13#10 + 'FROM RADIUS_ITENS_COMANDA I' + #13#10 +
      'INNER JOIN RADIUS_PRODUTO P ON (I.ID_PRODUTO = P.ID_PRODUTO)' + #13#10 +
      'WHERE' + #13#10 + 'I.ID_COMANDA = ' + QuotedStr(codigoComanda);
    fdQuery := TFDQuery.Create(Application);
    fdQuery.Connection := conexao;
    fdQuery.SQL.Text := strSQLConsulta;
    fdQuery.Active := True;

    Result := fdQuery.FieldByName('TOTAL').AsCurrency;
  finally
    FreeAndNil(fdQuery);
  end;
end;

end.
