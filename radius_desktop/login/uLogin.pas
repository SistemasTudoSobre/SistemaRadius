unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.XPMan,
  Vcl.ShellAnimations, System.Win.TaskbarCore, Vcl.Taskbar, Vcl.JumpList,
  Vcl.CategoryButtons, Vcl.StdCtrls, Vcl.Buttons, Vcl.Themes;

type
  TfmrLogin = class(TForm)
    edtUsuario: TEdit;
    edtSenha: TEdit;
    bbEntrar: TBitBtn;
    bbCancela: TBitBtn;
    cbVisual: TComboBox;
    procedure bbEntrarClick(Sender: TObject);
    procedure bbCancelaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbVisualChange(Sender: TObject);
  private
    { Private declarations }
    FSenhaCorreta: Boolean;
  public
    { Public declarations }
    class function logarUsuario(Sender: TObject; setarUsuario: Boolean;
      usuario: string = ''): string;
  end;

implementation

uses uUsuario, uConsultasCliente;

var
  fmrLogin: TfmrLogin;

{$R *.dfm}

procedure TfmrLogin.bbEntrarClick(Sender: TObject);
begin
  if buscarCodigoUsuario(edtUsuario.Text) <> '' then
    if edtSenha.Text = getSenhaUsuario(edtUsuario.Text) then
      FSenhaCorreta := True
    else
      ShowMessage('Senha incorreta!');

  if FSenhaCorreta then
    Close;
end;

procedure TfmrLogin.Button1Click(Sender: TObject);
begin
  bbCancela.Enabled := not bbCancela.Enabled
end;

procedure TfmrLogin.cbVisualChange(Sender: TObject);
begin
  TStyleManager.SetStyle(cbVisual.Text);
end;

procedure TfmrLogin.FormCreate(Sender: TObject);
var
  StyleName: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbVisual.Items.Add(StyleName);
  cbVisual.ItemIndex := cbVisual.Items.IndexOf(TStyleManager.ActiveStyle.Name);
end;

procedure TfmrLogin.bbCancelaClick(Sender: TObject);
begin
  FSenhaCorreta := False;
  Close;
end;

class function TfmrLogin.logarUsuario(Sender: TObject; setarUsuario: Boolean;
  usuario: string = ''): string;
begin
  Result := '';

  if fmrLogin = nil then
    Application.CreateForm(TfmrLogin, fmrLogin);

  try
    fmrLogin.FSenhaCorreta := False;

    if usuario <> '' then
    begin
      fmrLogin.edtUsuario.Text := usuario;
      fmrLogin.edtUsuario.ReadOnly := True;
      fmrLogin.edtUsuario.Color := clBtnFace;
      fmrLogin.edtUsuario.TabStop := False;
    end;

    fmrLogin.ShowModal;

    // Se acertou a senha entao retorna o nome do usuario (Caso seja para setar o usuario entao sete-o)
    if fmrLogin.FSenhaCorreta then
    begin
      if setarUsuario then
      begin
        setUsuario(fmrLogin.edtUsuario.Text);
        setCodigoUsuario(buscarCodigoUsuario(getUsuario()));
      end;
      Result := fmrLogin.edtUsuario.Text;
    end;

  finally
    if fmrLogin <> nil then
      FreeAndNil(fmrLogin);

  end;

end;

end.
