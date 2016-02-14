unit uDialAtualizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, IdHTTP,
  IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient, IdAuthentication;

type
  TfrmAtualizacao = class(TForm)
    Label1: TLabel;
    pbprogresso: TProgressBar;
    statusBar: TStatusBar;
    IdHTTP: TIdHTTP;
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    function RetornaFluxo(ValorAtual: real): string;
    function ConvertePorcentagem(ValorMaximo, ValorAtual: real): string;
    procedure baixarAtualizacao(url: string; arqDestino: string = '');
    { Private declarations }
  public
    { Public declarations }
    class function abrirJanelaAtualizacao(urlBuid: string;
      arqDestino: string = ''): Boolean;
  end;

const
  NOME_EXE_TMP = 'Radius_aux.exe';

implementation

var
  frmAtualizacao: TfrmAtualizacao;

{$R *.dfm}
  { TfrmAtualizacao }

class function TfrmAtualizacao.abrirJanelaAtualizacao(urlBuid: string;
  arqDestino: string = ''): Boolean;
begin
  Result := True;
  try
    if frmAtualizacao = nil then
      Application.CreateForm(TfrmAtualizacao, frmAtualizacao);

    frmAtualizacao.Show;
    frmAtualizacao.baixarAtualizacao(urlBuid, arqDestino);
  except
    Result := False;
  end;

end;

function TfrmAtualizacao.ConvertePorcentagem(ValorMaximo,
  ValorAtual: real): string;
var
  resultado: real;
begin
  resultado := ((ValorAtual * 100) / ValorMaximo);
  Result := FormatFloat('0%', resultado);
end;

function TfrmAtualizacao.RetornaFluxo(ValorAtual: real): string;
var
  resultado: real;
begin
  resultado := ((ValorAtual / 1024) / 1024);
  Result := FormatFloat('0.000 KBs', resultado);
end;

procedure TfrmAtualizacao.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  pbprogresso.Position := AWorkCount;
  statusBar.Panels[0].Text := 'Baixando ... ' + RetornaFluxo(AWorkCount);
  statusBar.Panels[1].Text := 'Download em ... ' + ConvertePorcentagem
    (pbprogresso.Max, AWorkCount);
  Application.ProcessMessages;
end;

procedure TfrmAtualizacao.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  pbprogresso.Max := AWorkCountMax;
end;

procedure TfrmAtualizacao.IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  pbprogresso.Position := 0;
  statusBar.Panels[1].Text := 'Finalizado ...';
  statusBar.Panels[0].Text := 'Download Finalizado ...';
  Close;
end;

procedure TfrmAtualizacao.baixarAtualizacao(url: string;
  arqDestino: string = '');
var
  fileDownload: TFileStream;
begin
  if arqDestino = '' then
    arqDestino := NOME_EXE_TMP;

  fileDownload := TFileStream.Create(arqDestino, fmCreate);
  try
    IdHTTP.Get(url, fileDownload);
  finally
    FreeAndNil(fileDownload);
  end;
end;

end.
