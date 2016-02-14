unit dmPrincipal;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, Data.SqlExpr;

type
  TfrmDmPrincipal = class(TDataModule)
    FDConnexao: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    configuracao: TIniFile;
  public
    { Public declarations }
  end;

var
  frmDmPrincipal: TfrmDmPrincipal;

implementation

const
  BANCO_RADIUS = 'radius.gdb';

  { %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TfrmDmPrincipal.DataModuleCreate(Sender: TObject);
begin
  configuracao := TIniFile.Create(ExtractFilePath(Application.ExeName) +
    'Radius.ini');

  FDConnexao.Params.Clear();
  FDConnexao.Params.Add('User_Name=' + 'sysdba');
  FDConnexao.Params.Add('Password=' + 'masterkey');
  FDConnexao.Params.Add('DriverID=' + 'FB');
  FDConnexao.Params.Add('Server=' + configuracao.ReadString('CONEXAO',
    'IntProtoc', ''));
  FDConnexao.Params.Add('Database=' + configuracao.ReadString('CONEXAO',
    'Diretorio', '') + BANCO_RADIUS);

  try
    FDConnexao.Connected := True;
  except
    ShowMessage('Erro ao se conectar com base de dados!' + #13 +
                'Por favor, verifique o arquivo de configuração: Radius.ini ');
    Application.Terminate;
  end;

end;

procedure TfrmDmPrincipal.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(configuracao);
end;

end.
