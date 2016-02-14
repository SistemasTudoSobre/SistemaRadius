unit uWebNavegacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls;

type
  TfrmNavegacao = class(TfrmMaster)
    WebBrowser1: TWebBrowser;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure abrirTelaNavegacao(Sender: TObject); overload;
    class procedure abrirTelaNavegacao(Sender: TObject; URL: string); overload;
  end;

implementation

var
  frmNavegacao: TfrmNavegacao;

{$R *.dfm}
  { TForm1 }

class procedure TfrmNavegacao.abrirTelaNavegacao(Sender: TObject);
var
  Browser: TfrmNavegacao;
begin
  Browser := TfrmNavegacao.Create(Application);
  try
    Browser.Show;
  except
    FreeAndNil(Browser);
  end;
end;

class procedure TfrmNavegacao.abrirTelaNavegacao(Sender: TObject; URL: string);
var
  Browser: TfrmNavegacao;
begin
  Browser := TfrmNavegacao.Create(Application);
  try
    Browser.WebBrowser1.Navigate(URL);
    Browser.Show;
  except
    FreeAndNil(Browser);
  end;
end;

procedure TfrmNavegacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //
end;

procedure TfrmNavegacao.SpeedButton1Click(Sender: TObject);
begin
  WebBrowser1.Navigate(Edit1.Text);
end;

end.
