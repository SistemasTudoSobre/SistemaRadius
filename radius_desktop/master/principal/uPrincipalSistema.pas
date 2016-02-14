unit uPrincipalSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.ImgList,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.XPMan,
  System.ImageList;

type
  TfrmPrincipalSistema = class(TForm)
    ListaImagens: TImageList;
    Image1: TImage;
    XPManifest1: TXPManifest;
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

var
  frmPrincipalSistema: TfrmPrincipalSistema;

procedure TfrmPrincipalSistema.ToolButton1Click(Sender: TObject);
begin
  ShowMessage('');
end;

end.
