unit uAlteraStatusComanda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.ImgList, System.ImageList;

type
  TfrmAlterarStatusComanda = class(TfrmMaster)
    edtCodigoComanda: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigoMesa: TEdit;
    Label4: TLabel;
    edtMotivo: TEdit;
    Memo1: TMemo;
    bbCancelarComanda: TButton;
    btnEdtNomeMotivo: TButtonedEdit;
    edtStatusMesa: TEdit;
    ImgList: TImageList;
    edtStatusComanda: TEdit;
    Label5: TLabel;
    edtNovoStatus: TEdit;
    btnEditNovoStatus: TButtonedEdit;
    procedure btnEdtNomeMotivoRightButtonClick(Sender: TObject);
    procedure edtCodigoComandaChange(Sender: TObject);
    procedure edtCodigoMesaChange(Sender: TObject);
    procedure edtCodigoComandaExit(Sender: TObject);
    procedure edtMotivoChange(Sender: TObject);
    procedure btnEditNovoStatusRightButtonClick(Sender: TObject);
    procedure edtNovoStatusChange(Sender: TObject);
    procedure bbCancelarComandaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure AlterarStatus(idComanda, novoStatus, novoMotivo: string);
    { Private declarations }
  public
    { Public declarations }
    class procedure AbrirTelaAlteracaoStatus(codComanda: string = '';
      novoStatus: string = '');
  end;

implementation

uses uPesquisa, uConstantes, uConsultaComanda, uData, uConsulta, uUsuario,
  uLogin, uConsultaCaixa, uUpdate;

var
  frmAlterarStatusComanda: TfrmAlterarStatusComanda;

{$R *.dfm}

function getConsultaMotivo(): string;
begin
  Result := 'SELECT ' + #13 + '      C.ID_CNC_CMD AS CODIGO, ' + #13 +
    '      C.NOME_STATUS_CNC_CMD AS MOTIVO ' + #13 + '  FROM RADIUS_STS_CNC C ';
end;

function getConsultaStatusComanda(): string;
begin
  Result := 'SELECT' + #13#10 + 'S.ID_STATUS AS "CODIGO", ' + #13#10 +
    'S.NOME_STATUS AS "STATUS"' + #13#10 + 'FROM RADIUS_STATUS_COMANDA S';
end;

procedure TfrmAlterarStatusComanda.btnEdtNomeMotivoRightButtonClick
  (Sender: TObject);
var
  pesquisa: TfrmPesquisar;
begin
  pesquisa := TfrmPesquisar.Create(Application, conexaoSistema,
    getConsultaMotivo());
  try
    pesquisa.pesquisar();
    edtMotivo.Text := pesquisa.getValorCampoAsString('CODIGO');
  finally
    FreeAndNil(pesquisa);
  end;
end;

procedure TfrmAlterarStatusComanda.AlterarStatus(idComanda, novoStatus,
  novoMotivo: string);
begin
  if AtualizarRegistro(conexaoSistema, 'RADIUS_COMANDA', 'ID_STATUS',
    novoStatus, 'ID_COMANDA', idComanda) then
  begin
    AtualizarRegistro(conexaoSistema, 'RADIUS_COMANDA', 'ID_CNC_CMD',
      novoMotivo, 'ID_COMANDA', idComanda);
    AtualizarRegistro(conexaoSistema, 'RADIUS_MESA', 'ID_STATUS_MESA', '1',
      'ID_MESA', edtCodigoMesa.Text);
    Close;
  end;
end;

procedure TfrmAlterarStatusComanda.bbCancelarComandaClick(Sender: TObject);
var
  idComanda: string;
begin
  idComanda := buscarIDComanda(edtCodigoComanda.Text);
  inherited;
  frmAlterarStatusComanda.Visible := False;
  if TfmrLogin.logarUsuario(Sender, False, getUsuario()) <> '' then
    AlterarStatus(idComanda, edtNovoStatus.Text, edtMotivo.Text);
  if frmAlterarStatusComanda <> nil then
    frmAlterarStatusComanda.Visible := True;
end;

procedure TfrmAlterarStatusComanda.btnEditNovoStatusRightButtonClick
  (Sender: TObject);
var
  pesquisa: TfrmPesquisar;
begin
  pesquisa := TfrmPesquisar.Create(Application, conexaoSistema,
    getConsultaStatusComanda());
  try
    pesquisa.pesquisar();
    edtNovoStatus.Text := pesquisa.getValorCampoAsString('CODIGO');
  finally
    FreeAndNil(pesquisa);
  end;
end;

class procedure TfrmAlterarStatusComanda.AbrirTelaAlteracaoStatus
  (codComanda: string = ''; novoStatus: string = '');
begin
  if frmAlterarStatusComanda = nil then
    Application.CreateForm(TfrmAlterarStatusComanda, frmAlterarStatusComanda);

  if codComanda <> '' then
  begin
    frmAlterarStatusComanda.edtCodigoComanda.Text := codComanda;
    frmAlterarStatusComanda.edtCodigoComanda.Color := clBtnFace;
    frmAlterarStatusComanda.edtCodigoComanda.TabStop := False;
    frmAlterarStatusComanda.edtCodigoComanda.ReadOnly := True;
  end;

  if novoStatus <> '' then
  begin
    frmAlterarStatusComanda.edtNovoStatus.Text := novoStatus;
    frmAlterarStatusComanda.edtNovoStatus.Color := clBtnFace;
    frmAlterarStatusComanda.edtNovoStatus.TabStop := False;
    frmAlterarStatusComanda.edtNovoStatus.ReadOnly := True;
  end;

  frmAlterarStatusComanda.Show;
end;

procedure TfrmAlterarStatusComanda.edtNovoStatusChange(Sender: TObject);
begin
  inherited;
  if Length(TEdit(Sender).Text) > 0 then
    btnEditNovoStatus.Text := buscarDado(conexaoSistema,
      'RADIUS_STATUS_COMANDA', 'ID_STATUS', 'NOME_STATUS', TEdit(Sender).Text)
  else
    btnEditNovoStatus.Clear;
end;

procedure TfrmAlterarStatusComanda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if frmAlterarStatusComanda <> nil then
    FreeAndNil(frmAlterarStatusComanda);
end;

procedure TfrmAlterarStatusComanda.edtMotivoChange(Sender: TObject);
var
  strMotivo: string;
begin
  inherited;
  if Length(TEdit(Sender).Text) > 0 then
    btnEdtNomeMotivo.Text := buscarDado(conexaoSistema, 'RADIUS_STS_CNC',
      'ID_CNC_CMD', 'NOME_STATUS_CNC_CMD', TEdit(Sender).Text)
  else
    btnEdtNomeMotivo.Clear;
end;

procedure TfrmAlterarStatusComanda.edtCodigoComandaChange(Sender: TObject);
var
  codAberturaCaixa: string;
  idComanda: string;
begin
  inherited;
  codAberturaCaixa := buscarCaixaAberto(conexaoSistema, getCodigoUsuario());
  idComanda := buscarDado(conexaoSistema, 'RADIUS_COMANDA', 'ID_ABERTURA_CAIXA',
    'ID_COMANDA', codAberturaCaixa, 'CODIGO_DIARIO = ' +
    QuotedStr(edtCodigoComanda.Text));
  if Length(TEdit(Sender).Text) >= 7 then
  begin
    edtStatusComanda.Text := buscarStatusComanda(conexaoSistema, idComanda);
    edtCodigoMesa.Text := buscarMesaComanda(conexaoSistema, idComanda);
  end;
end;

procedure TfrmAlterarStatusComanda.edtCodigoComandaExit(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Text <> '' then
    TEdit(Sender).Text :=
      FormatFloat(StringOfChar('0', TEdit(Sender).MaxLength),
      StrToFloat(TEdit(Sender).Text));

end;

procedure TfrmAlterarStatusComanda.edtCodigoMesaChange(Sender: TObject);
var
  strMesa: string;
begin
  inherited;
  if Length(TEdit(Sender).Text) > 0 then
  begin
    strMesa := buscarDado(conexaoSistema, 'RADIUS_MESA', 'ID_MESA',
      'ID_STATUS_MESA', TEdit(Sender).Text);
    edtStatusMesa.Text := buscarDado(conexaoSistema, 'RADIUS_STATUS_MESA',
      'ID_STATUS_MESA', 'NOME_STATUS_MESA', strMesa);
  end
  else
    edtStatusMesa.Clear;
end;

end.
