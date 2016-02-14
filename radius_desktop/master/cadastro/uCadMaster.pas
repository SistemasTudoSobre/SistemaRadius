unit uCadMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient, SimpleDS,
  Data.SqlExpr, FireDAC.Comp.Client, dmPrincipal, Data.DBXFirebird,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ImgList, System.ImageList;

type
  TChaveTabela = array of string;

  TfrmCadMaster = class(TfrmMaster)
    pnlBotoes: TPanel;
    bbIncluir: TBitBtn;
    bbAlterar: TBitBtn;
    bbCancelar: TBitBtn;
    bbGravar: TBitBtn;
    bbPesquisar: TBitBtn;
    bbImprimir: TBitBtn;
    bbFechar: TBitBtn;
    bbExcluir: TBitBtn;
    pnlGeral: TPanel;
    dsPadrao: TDataSource;
    FDTablePadrao: TFDTable;
    ImgList: TImageList;
    procedure FormCreate(Sender: TObject); overload;
    procedure bbIncluirClick(Sender: TObject);
    procedure bbGravarClick(Sender: TObject);
    procedure bbAlterarClick(Sender: TObject);
    procedure bbExcluirClick(Sender: TObject);
    procedure bbCancelarClick(Sender: TObject);
    procedure bbFecharClick(Sender: TObject);
    procedure bbPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    FSQLConsultaPesquisa: string;
    FConexao: TFDConnection;
    FChaves: TChaveTabela;
    FSQLPesquisa: string;
    procedure setChavesTabela(chaves: TChaveTabela);
    function getChavesTabela(): TChaveTabela;
    procedure setConexao(conexao: TFDConnection);
    function getConexao(): TFDConnection;
    function getSQLConsultaPesquisa(): string;
    procedure setSQLConsultaPesquisa(sql: string);
    procedure HabilitaControles;
    procedure HabilitaControlesVisuais(Status: Boolean);
    procedure somenteMetadados();
    procedure abrirPesquisa();
    procedure ChangeEnter(Sender: TObject);
    procedure ChangeExit(Sender: TObject);
    function getSQLPesquisa: string;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload;
  published
    constructor Create(AOwner: TComponent; conexao: TFDConnection;
      tabela: string; camposChave: array of string); overload;
    procedure setDataField(componente: TWinControl; field: string;
      display: string);
    procedure filtrarDados(filtro: string);
    procedure setProximoCodigo(tabela, campoChave: string;
      condicao: string = '');
    procedure prepararPesquisa(conexao: TFDConnection; consulta: string;
      chaves: TChaveTabela);
    procedure setSQLPesquisa(sql: string);
  end;

var
  frmCadMaster: TfrmCadMaster;
  irParaUltimoRegistro: Boolean;

implementation

uses uConsulta, uConstantes, uPesquisa;

{$R *.dfm}

procedure TfrmCadMaster.abrirPesquisa();
var
  pesquisa: TfrmPesquisar;
  chaves: TChaveTabela;
  i: integer;
  filtro: string;
begin

  // Cria a pesquisa passando os parametros adicionais
  pesquisa := TfrmPesquisar.Create(Application, getConexao(),
    getSQLConsultaPesquisa());
  try

    // Abre em modal para o usuario escolher o registro desejado
    if not pesquisa.pesquisar() then
      Exit;

    // Filtra para o registro que o usuario escolheu
    chaves := getChavesTabela();
    for i := Low(chaves) to High(chaves) do
      if filtro = '' then
        filtro := filtro + chaves[i] + ' = ' + pesquisa.getValorCampoAsString
          (chaves[i])
      else
        filtro := filtro + ' AND ' + chaves[i] + ' = ' +
          pesquisa.getValorCampoAsString(chaves[i]);
    filtrarDados(filtro);

  finally
    FreeAndNil(pesquisa);
  end;
end;

procedure TfrmCadMaster.bbAlterarClick(Sender: TObject);
begin
  inherited;
  dsPadrao.DataSet.Edit;
  HabilitaControles();
  HabilitaControlesVisuais(True);
  irParaUltimoRegistro := False;
end;

procedure TfrmCadMaster.bbCancelarClick(Sender: TObject);
begin
  inherited;
  with dsPadrao.DataSet do
  begin
    Cancel;
    Filtered := False;
  end;
  HabilitaControles();
  HabilitaControlesVisuais(False);
end;

procedure TfrmCadMaster.bbExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja Excluir o Registro', mtconfirmation, [mbYes, mbNo], 0) = mrYes
  then
  begin
    dsPadrao.DataSet.Delete;
    HabilitaControles();
    HabilitaControlesVisuais(False);
  end;
end;

procedure TfrmCadMaster.bbFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadMaster.bbGravarClick(Sender: TObject);
begin
  inherited;
  dsPadrao.DataSet.Post;
  dsPadrao.DataSet.Filtered := False;
  HabilitaControles();
  HabilitaControlesVisuais(False);

  if irParaUltimoRegistro then
    dsPadrao.DataSet.Last;

end;

procedure TfrmCadMaster.bbIncluirClick(Sender: TObject);
begin
  inherited;
  dsPadrao.DataSet.Insert;
  HabilitaControles();
  irParaUltimoRegistro := True;

  // Comentado pois as telas deverão usar o auto incremento
  // setProximoCodigo(FDTablePadrao.TableName, FDTablePadrao.IndexFieldNames);

  // Como não irá precisar de buscar os ultimos codigos entao coloque como nao requerido a chave primaria, pois será criada pelo generator
  FDTablePadrao.FieldByName(FDTablePadrao.IndexFieldNames).Required := False;

  pnlGeral.SetFocus;
end;

procedure TfrmCadMaster.setSQLPesquisa(sql: string);
begin
  FSQLPesquisa := sql;
end;

function TfrmCadMaster.getSQLPesquisa(): string;
begin
  Result := FSQLPesquisa;
end;

procedure TfrmCadMaster.bbPesquisarClick(Sender: TObject);
var
  sqlPesquisa: string;
begin
  sqlPesquisa := getSQLPesquisa();
  if sqlPesquisa = '' then
    sqlPesquisa := 'SELECT * FROM ' + FDTablePadrao.TableName;

  prepararPesquisa(conexaoSistema, sqlPesquisa,
    [FDTablePadrao.IndexFieldNames]);
  inherited;
  abrirPesquisa();
  HabilitaControles();
  HabilitaControlesVisuais(False);

  setSQLPesquisa('');
end;

constructor TfrmCadMaster.Create(AOwner: TComponent);
begin
  inherited;
  FormCreate(TObject(AOwner));
end;

procedure TfrmCadMaster.filtrarDados(filtro: string);
begin
  FDTablePadrao.Filter := filtro;
  FDTablePadrao.Filtered := FDTablePadrao.Filter <> '';
end;

procedure TfrmCadMaster.somenteMetadados;
begin
  filtrarDados(FDTablePadrao.IndexFieldNames + ' IS NULL');
end;

constructor TfrmCadMaster.Create(AOwner: TComponent; conexao: TFDConnection;
  tabela: string; camposChave: array of string);
begin
  Create(AOwner);

  FDTablePadrao.Connection := conexao;
  FDTablePadrao.TableName := tabela;
  FDTablePadrao.Active := True;
  somenteMetadados();

end;

procedure TfrmCadMaster.ChangeEnter(Sender: TObject);
begin
  if Sender is TDBEdit then
    TDBEdit(Sender).Color := $00E6FED8
  else if Sender is TDBLookupComboBox then
    TDBLookupComboBox(Sender).Color := $00E6FED8
  else if Sender is TDBComboBox then
    TDBComboBox(Sender).Color := $00E6FED8
  else if Sender is TDBMemo then
    TDBMemo(Sender).Color := $00E6FED8;
end;

procedure TfrmCadMaster.ChangeExit(Sender: TObject);
begin
  if Sender is TDBEdit then
    TDBEdit(Sender).Color := clWindow
  else if Sender is TDBLookupComboBox then
    TDBLookupComboBox(Sender).Color := clWindow
  else if Sender is TDBComboBox then
    TDBComboBox(Sender).Color := clWindow
  else if Sender is TDBMemo then
    TDBMemo(Sender).Color := clWindow;
end;

procedure TfrmCadMaster.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TDBEdit then
    begin
      TDBEdit(Components[i]).OnEnter := ChangeEnter;
      TDBEdit(Components[i]).OnExit := ChangeExit;
    end
    else if Components[i] is TDBLookupComboBox then
    begin
      TDBLookupComboBox(Components[i]).OnEnter := ChangeEnter;
      TDBLookupComboBox(Components[i]).OnExit := ChangeExit;
    end
    else if Components[i] is TDBComboBox then
    begin
      TDBComboBox(Components[i]).OnEnter := ChangeEnter;
      TDBComboBox(Components[i]).OnExit := ChangeExit;
    end
    else if Components[i] is TDBMemo then
    begin
      TDBMemo(Components[i]).OnEnter := ChangeEnter;
      TDBMemo(Components[i]).OnExit := ChangeExit;
    end
  end;
  try
    HabilitaControles;
    HabilitaControlesVisuais(False);
  except
    on e: Exception do
      ShowMessage('Erro ao conectar base de dados' + #13 + 'Erro : ' + e.Message
        + #13 + 'Classe : ' + e.ClassName);
  end;

end;

function TfrmCadMaster.getChavesTabela: TChaveTabela;
begin
  Result := FChaves;
end;

function TfrmCadMaster.getConexao: TFDConnection;
begin
  Result := FConexao
end;

function TfrmCadMaster.getSQLConsultaPesquisa: string;
begin
  Result := FSQLConsultaPesquisa
end;

procedure TfrmCadMaster.HabilitaControles;
begin
  bbIncluir.Enabled := not(dsPadrao.DataSet.State in [dsInsert, dsEdit]);
  bbGravar.Enabled := (dsPadrao.DataSet.State in [dsInsert, dsEdit]);
  bbAlterar.Enabled := (dsPadrao.DataSet.State in [dsBrowse]) and
    not(dsPadrao.DataSet.IsEmpty);
  bbExcluir.Enabled := (dsPadrao.DataSet.State in [dsBrowse]) and
    not(dsPadrao.DataSet.IsEmpty);
  bbCancelar.Enabled := (dsPadrao.DataSet.State in [dsInsert, dsEdit]);
  bbPesquisar.Enabled := not(dsPadrao.DataSet.State in [dsInsert, dsEdit]);
  HabilitaControlesVisuais(True);
end;

procedure TfrmCadMaster.HabilitaControlesVisuais(Status: Boolean);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TDBEdit then
      TDBEdit(Components[i]).Enabled := Status
    else if Components[i] is TDBLookupComboBox then
      TDBLookupComboBox(Components[i]).Enabled := Status
    else if Components[i] is TDBComboBox then
      TDBComboBox(Components[i]).Enabled := Status
    else if Components[i] is TDBMemo then
      TDBMemo(Components[i]).Enabled := Status
    else if Components[i] is TButtonedEdit then
    begin
      TButtonedEdit(Components[i]).Images := ImgList;
      TButtonedEdit(Components[i]).RightButton.Visible := True;
      TButtonedEdit(Components[i]).RightButton.Enabled := True;
      TButtonedEdit(Components[i]).RightButton.ImageIndex := 0;
      TButtonedEdit(Components[i]).Color := clBtnFace;
      TButtonedEdit(Components[i]).ReadOnly := True;
      TButtonedEdit(Components[i]).TabStop := False;
    end;
  end;
end;

procedure TfrmCadMaster.prepararPesquisa(conexao: TFDConnection;
  consulta: string; chaves: TChaveTabela);
begin
  setConexao(conexao);
  setSQLConsultaPesquisa(consulta);
  setChavesTabela(chaves);
end;

procedure TfrmCadMaster.setChavesTabela(chaves: TChaveTabela);
begin
  FChaves := chaves
end;

procedure TfrmCadMaster.setConexao(conexao: TFDConnection);
begin
  FConexao := conexao
end;

procedure TfrmCadMaster.setDataField(componente: TWinControl; field: string;
  display: string);
begin
  if componente is TDBEdit then
    TDBEdit(componente).DataField := field
  else if componente is TDBMemo then
    TDBMemo(componente).DataField := field
  else if componente is TDBCheckBox then
    TDBCheckBox(componente).DataField := field;

  FDTablePadrao.FieldByName(field).DisplayLabel := AnsiUpperCase(Trim(display));
end;

procedure TfrmCadMaster.setProximoCodigo(tabela, campoChave: string;
  condicao: string = '');
begin
  FDTablePadrao.FieldByName(campoChave).AsInteger :=
    StrToInt(ultimoCodigo(conexaoSistema, tabela, campoChave, condicao)) + 1;
end;

procedure TfrmCadMaster.setSQLConsultaPesquisa(sql: string);
begin
  FSQLConsultaPesquisa := sql
end;

end.
