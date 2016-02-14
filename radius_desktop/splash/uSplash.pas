 unit uSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.Buttons,
  Winapi.ShellAPI, Vcl.Menus, Vcl.Imaging.pngimage;

type
  TfrmSplash = class(TForm)
    ProgressBar1: TProgressBar;
    tmpProgresso: TTimer;
    maskSerial: TMaskEdit;
    bbVerificarLogin: TBitBtn;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure tmpProgressoTimer(Sender: TObject);
    procedure bbVerificarLoginClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure abrirFormualrioPrincipal(Sender: TObject);
    procedure EntrarNoSistema(Sender: TObject);
    procedure Entrar(verificarSerialGravadoNoBanco: Boolean = True);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;
  serialValido: Boolean = True;

implementation

uses uVerificarLiberacao, uPrincipal, dmPrincipal, uConsultasCliente,
  uAtualizar, uLogin, internet, uValidarSistema, uWindows, uValidaSerial,
  uFirebird, uData;

{$R *.dfm}

procedure TfrmSplash.EntrarNoSistema(Sender: TObject);
begin
  frmSplash.Visible := False;
  if TfmrLogin.logarUsuario(Sender, True) <> '' then
  begin
    // ...
    abrirFormualrioPrincipal(Sender);
  end
  else
    Application.Terminate;

end;

procedure TfrmSplash.abrirFormualrioPrincipal(Sender: TObject);
begin
  TfrmPrincipal.AbrirFormularioPrincipal(Sender);
end;

procedure TfrmSplash.Entrar(verificarSerialGravadoNoBanco: Boolean = True);
begin
  if entradaValida(maskSerial.Text, verificarSerialGravadoNoBanco) then
  begin
    adicionarNovoSerial(Trim(maskSerial.Text));
    tmpProgresso.Enabled := True;
  end;
end;

function verificarValidade(serial: string; cnpj: string): Boolean;
var
  dataValidade: TDate;
begin
  Result := False;
  serial := StringReplace(serial, '-', '', [rfReplaceAll]);
  dataValidade := validarSerial(serial, cnpj);
  if dataValidade <> 0 then  ////aa
    Result := dataValidade <= getDataHoje();
end;

procedure TfrmSplash.bbVerificarLoginClick(Sender: TObject);
var
  serialCliente: string;
begin
  setDataVerdadeira();

  serialCliente := buscarSerialCliente();

  if serialCliente = '' then
  begin
    TfrmValidarSistema.AbrirValidacaoSistema();
    Exit;
  end;

  if verificarValidade(Trim(maskSerial.Text), buscarCNPJCliente()) then
  // Buscar cnpj do cliente
    begin
      ShowMessage('Serial não esperado!' + #13 +
        'Por favor, entre em contato com o suporte.');
      serialValido := False;
      Exit;
    end;

  if True { isDebug() } then { TODO -oJonathan -c : Criar configuração para determinar se cliente pode entrar sem vericar a internet 29/11/2015 23:06:42 }
    begin
      Entrar(serialValido);
      Exit;
    end;

  if verificarConexaoComInternet() then
    if getValidadeSistema(Trim(maskSerial.Text)) then
      if verificarAtualizacao(False) then
        Entrar(serialValido);

  serialValido := True;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  if not fireBirdStarted() then
    begin
      ShowMessage('Não foi possivel encontrar gerenciador de banco de dados.' +
        #13 + 'Por favor instale a versão mais recente do Firebird para seu sistema operacional.');
      Application.Terminate;
    end;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
var
  serialCadastrado: string[14];
begin
  bbVerificarLogin.Caption := '';
  serialCadastrado := buscarSerialCliente();

  if serialCadastrado = '' then
    begin
      maskSerial.Visible := True;
      bbVerificarLogin.Visible := True;
    end
  else
    begin
      maskSerial.Text := serialCadastrado;
      bbVerificarLogin.Click;
    end;

end;

procedure TfrmSplash.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmSplash.tmpProgressoTimer(Sender: TObject);
begin
  if ProgressBar1.Visible = False then
    ProgressBar1.Visible := True;

  ProgressBar1.Position := ProgressBar1.Position + 1;

  if ProgressBar1.Position = ProgressBar1.Max then
    begin
      tmpProgresso.Enabled := False;
      EntrarNoSistema(Sender);
    end;

end;

end.
