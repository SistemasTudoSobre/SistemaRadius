unit uValidarSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMaster, Vcl.Mask;

type
  TfrmValidarSistema = class(TfrmMaster)
    Button1: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Edit2: TMaskEdit;
    GroupBox1: TGroupBox;
    edtNomeNovoUsuario: TEdit;
    edtSenhaNovoUsuario: TEdit;
    edtConfirmSenha: TEdit;
    edtDicaSenha: TEdit;
    edtemail: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure AbrirValidacaoSistema();
  end;

function entradaValida(serialCliente: String;
  verificarSerialGravadoNoBanco: Boolean = True): Boolean;

implementation

uses dmPrincipal, uCliente, uSeriaisLogicos, uConsultasCliente, uWindows,
  uHardware;

var
  frmValidarSistema: TfrmValidarSistema;

{$R *.dfm}

  // Todos os tratamentos para o sistema ser validado
function entradaValida(serialCliente: String;
  verificarSerialGravadoNoBanco: Boolean = True): Boolean;
begin
  Result := False;

  if verificarSerialGravadoNoBanco then
    if (serialCliente <> buscarSerialCliente()) then
    begin
      ShowMessage('Serial do cliente não confere!');
      Exit
    end;

  if not verificarSerialGravadoNoBanco then
  begin
    adicionarMaquina(getSerialNumberDrive('C'), getUusuarioLogado(),
      getMacAddress(), getIpLocal(), '1');
    Result := True;
  end
  else
  begin
    if verificarSerialHDCliente(serialCliente, getSerialNumberDrive('C')) then
      Result := True
    else
      ShowMessage('Maquina não autorizada para a utilização deste sistema!')
  end;

end;

class procedure TfrmValidarSistema.AbrirValidacaoSistema;
begin
  if frmValidarSistema = nil then
    Application.CreateForm(TfrmValidarSistema, frmValidarSistema);

  frmValidarSistema.ShowModal;

end;

procedure TfrmValidarSistema.Button1Click(Sender: TObject);
begin
  inherited;

  if edtNomeNovoUsuario.Text = '' then
  begin
    ShowMessage('Nome do usuário inválido!');
    Exit;
  end;

  if edtSenhaNovoUsuario.Text = '' then
  begin
    ShowMessage('Senha do usuário inválido!');
    Exit;
  end;

  if edtConfirmSenha.Text = '' then
  begin
    ShowMessage('Confirmação de senha do usuário inválido!');
    Exit;
  end;

  if edtDicaSenha.Text = '' then
  begin
    ShowMessage('Dica de senha do usuário inválido!');
    Exit;
  end;

  adicionarCliente(Edit3.Text, Edit5.Text, Edit4.Text, Edit2.Text,
    edtNomeNovoUsuario.Text, edtSenhaNovoUsuario.Text, Edit4.Text,
    edtDicaSenha.Text, edtemail.Text)
end;

end.
