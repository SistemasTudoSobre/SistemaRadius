unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Winapi.ShellAPI,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.OleCtrls,
  SHDocVw, System.ImageList {, cefvcl};

type
  TfrmPrincipal = class(TForm)
    stsRadius: TStatusBar;
    ImageList1: TImageList;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    CategoryPanel7: TCategoryPanel;
    CategoryPanel8: TCategoryPanel;
    CategoryPanel9: TCategoryPanel;
    CategoryPanel10: TCategoryPanel;
    Panel1: TPanel;
    pnlCabecalho: TPanel;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    wbTelaInicial: TWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure Suporte1Click(Sender: TObject);
    procedure FecharSuporte1Click(Sender: TObject);
    procedure VerificarporAtualizaes1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DetranEmpresas1Click(Sender: TObject);
    procedure WebBrouwer1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure SolicitarSuporte;
    procedure EncerrarSuporte;
    procedure buscarDescrcao(codSistema: Integer; var rotuloDescricao: TLabel);
    procedure AbrirModulo(codSistema: Integer);

    { Private declarations }
  public
    { Public declarations }
    class procedure AbrirFormularioPrincipal(Sender: TObject);
  end;

implementation

uses
  uMD5, uSuporte, uAtualizar, uLogin, uUsuario, uWebNavegacao,
  uConstantes, uPrincipalRadiusReal;

var
  frmPrincipal: TfrmPrincipal;

{$R *.dfm}

procedure TfrmPrincipal.Abrir1Click(Sender: TObject);
begin
  frmPrincipal.WindowState := wsMaximized;
end;

class procedure TfrmPrincipal.AbrirFormularioPrincipal(Sender: TObject);
begin
  if frmPrincipal = nil then
    Application.CreateForm(TfrmPrincipal, frmPrincipal);

  frmPrincipal.Show;
end;

procedure TfrmPrincipal.SolicitarSuporte();
var
  autorizacao: string;
  senha: string;
begin

  if ShellExecute(Handle, 'open', 'sp.exe', '', '', sw_Hide) > 0 then
  begin
    Sleep(3000);

    autorizacao := getAutorizacaoSuporte();
    senha := getSenhaSuporte();

    stsRadius.Panels[3].Text := 'AUTORIZAÇÃO: ' + autorizacao + ' - ' + senha;

    if not enviarRequisicaoSuporte('00002', autorizacao, senha)
    then { TODO -oJonathan -c : Capturar codigo do cliente no banco de dados 22/11/2015 23:00:55 }
      EncerrarSuporte();

    if (getAutorizacaoSuporte() = '') or (getSenhaSuporte() = '') then
    begin
      stsRadius.Panels[3].Text := 'SUPORTE NÃO AUTORIZADO!';
      EncerrarSuporte();
    end;

  end;
end;

procedure TfrmPrincipal.Suporte1Click(Sender: TObject);
begin
  SolicitarSuporte();
end;

procedure TfrmPrincipal.VerificarporAtualizaes1Click(Sender: TObject);
begin
  verificarAtualizacao(True);
end;

procedure TfrmPrincipal.WebBrouwer1Click(Sender: TObject);
begin
  TfrmNavegacao.abrirTelaNavegacao(Sender);
end;

procedure TfrmPrincipal.AbrirModulo(codSistema: Integer);
begin
  case codSistema of
    01:
      TfrmPrincipalRadiusReal.abrirSistema();
  end;
  // frmPrincipal.WindowState := wsMinimized;
end;

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
begin
  AbrirModulo(TBitBtn(Sender).Tag);
end;

procedure TfrmPrincipal.buscarDescrcao(codSistema: Integer;
  var rotuloDescricao: TLabel);
var
  tste: tagMSG;
begin
  rotuloDescricao.Caption := IntToStr(codSistema);
  CategoryPanel2.Visible := False;
  CategoryPanel2.Visible := True;
  Application.ProcessMessages;
  Sleep(10000);
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  SolicitarSuporte();
end;

procedure TfrmPrincipal.DetranEmpresas1Click(Sender: TObject);
begin
  TfrmNavegacao.abrirTelaNavegacao(Sender, 'https://www.detrannet.empresas.mg.gov.br/');
end;

procedure TfrmPrincipal.EncerrarSuporte();
begin
  stsRadius.Panels[2].Text := '';
  fecharAplicacaoSuporte();
end;

procedure TfrmPrincipal.FecharSuporte1Click(Sender: TObject);
begin
  EncerrarSuporte();
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
  Application.Terminate;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  stsRadius.Panels[1].Text := 'USUARIO: ' + getUsuario();
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   wbTelaInicial.Navigate(RADIUS_SUB_DOMINIO); //'http://www.embarcadero.com'
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
