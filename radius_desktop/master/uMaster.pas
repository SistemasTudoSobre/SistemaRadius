unit uMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ImgList;

type
  TfrmMaster = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    constructor Create(AOwner: TComponent); override;
    procedure tabPeloEnter(var Msg: TMsg; var Handled: Boolean);
  end;

var
  frmMaster: TfrmMaster;

implementation

{$R *.dfm}

constructor TfrmMaster.Create(AOwner: TComponent);
begin
  inherited;
  FormStyle := fsStayOnTop;
  Application.OnMessage := tabPeloEnter;
end;

procedure TfrmMaster.FormCreate(Sender: TObject);
begin
  // Este método deve existir devido herança
end;

procedure TfrmMaster.tabPeloEnter(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = WM_KeyDown then
    if Msg.wParam = VK_Return then
      keybd_event(VK_TAB, 0, 0, 0);
end;

end.
