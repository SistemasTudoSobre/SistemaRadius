unit uFechaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmFechamentoCaixa = class(TfrmMaster)
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Timer1: TTimer;
    Edit6: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FCaixaAberto: string;
    function getCaixaAberto(): string;
    procedure setCaixaAberto(codCaixa: string);
    function fecharCaixa(codigoCaixa: string): Boolean;
    function AtualizarValorRecebido(codigoCaixa: string;
      valorRecebido: currency): Boolean;
    { Private declarations }
  public
    { Public declarations }
    class procedure abrriFechamentoDeCaixa(Sender: TObject);
  end;

implementation

uses uConsultaCaixa, uConstantes, uUsuario, uUpdate, uLogin, uConsulta, uData,
  uConsultasMesa;

var
  frmFechamentoCaixa: TfrmFechamentoCaixa;

{$R *.dfm}

class procedure TfrmFechamentoCaixa.abrriFechamentoDeCaixa(Sender: TObject);
var
  caixa: string;
begin
  caixa := buscarCaixaAberto(conexaoSistema, getCodigoUsuario());

  if caixa = '' then
  begin
    ShowMessage('Nenhum caixa aberto para esse usuário foi encontrado.');
    Exit;
  end;

  if frmFechamentoCaixa = nil then
    Application.CreateForm(TfrmFechamentoCaixa, frmFechamentoCaixa);

  frmFechamentoCaixa.setCaixaAberto(caixa);
  frmFechamentoCaixa.Show;
end;


procedure TfrmFechamentoCaixa.Button1Click(Sender: TObject);
var
  codCaixaAberto: string;
  valorTratado: string;
begin
  inherited;
  codCaixaAberto := buscarCaixaAberto(conexaoSistema, getCodigoUsuario());
  if TfmrLogin.logarUsuario(Sender, False, getUsuario()) <> '' then
    begin
      valorTratado := StringReplace(Edit6.Text, '.', ',', [rfReplaceAll]);
      AtualizarValorRecebido(codCaixaAberto, StrToCurr(valorTratado));
      fecharCaixa(codCaixaAberto);
      Close;
    end;
end;

function TfrmFechamentoCaixa.fecharCaixa(codigoCaixa: string): Boolean;
begin
  AtualizarRegistro(conexaoSistema, 'RADIUS_ABERTURA_CAIXA', 'ID_STS_CAIXA',
    '2', 'ID_ABERTURA_CAIXA', codigoCaixa);
end;

function TfrmFechamentoCaixa.AtualizarValorRecebido(codigoCaixa: string;
  valorRecebido: currency): Boolean;
var
  valorTratado: string;
begin
  valorTratado := StringReplace(CurrToStr(valorRecebido), ',', '.',
    [rfReplaceAll]);
  AtualizarRegistro(conexaoSistema, 'RADIUS_ABERTURA_CAIXA', 'VALOR_RECEBIDO',
    valorTratado, 'ID_ABERTURA_CAIXA', codigoCaixa);
end;

procedure TfrmFechamentoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  buscarCaixaAberto(conexaoSistema, getCodigoUsuario())
end;

procedure TfrmFechamentoCaixa.FormShow(Sender: TObject);
begin
  inherited;
  Edit1.Text := FormatDateTime('dd/mm/yyy', getDataHoje());
  Edit3.Text := buscarDado(conexaoSistema, 'RADIUS_ABERTURA_CAIXA',
    'ID_ABERTURA_CAIXA', 'VALOR_INICIAL', getCaixaAberto());
  Edit4.Text := getUsuario();
end;

function TfrmFechamentoCaixa.getCaixaAberto: string;
begin
  Result := FCaixaAberto;
end;

procedure TfrmFechamentoCaixa.setCaixaAberto(codCaixa: string);
begin
  FCaixaAberto := codCaixa;
end;

procedure TfrmFechamentoCaixa.Timer1Timer(Sender: TObject);
begin
  inherited;
  Edit2.Text := FormatDateTime('hh:MM:ss', Time());
end;

end.
