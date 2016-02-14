unit uPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TResultadoPesquisa = array of string;

  TfrmPesquisar = class(TfrmMaster)
    Panel1: TPanel;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    DataSource: TDataSource;
    FDQuery: TFDQuery;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FConsulta: string;
    FConexao: TFDConnection;
    procedure setConexao(conexao: TFDConnection);
    function getConexao(): TFDConnection;
    function getConsulta: string;
    procedure setConsulta(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    function pesquisar(PesquisarAoAbrir: Boolean = True): Boolean;
    function getValorCampoAsString(nomeCampo: string): string;
  published
    constructor Create(AOwner: TComponent; conexao: TFDConnection;
      SQLConsulta: string); overload;

  end;

var
  frmPesquisar: TfrmPesquisar;

implementation

{$R *.dfm}
{ TfrmMaster1 }

constructor TfrmPesquisar.Create(AOwner: TComponent; conexao: TFDConnection;
  SQLConsulta: string);
begin
  Create(AOwner);
  setConsulta(SQLConsulta);
  setConexao(conexao);
end;

procedure TfrmPesquisar.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPesquisar.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if not odd(FDQuery.RecNo) then
  begin
    if not(gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color := $00FFF8F0;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
    end;
  end;
end;

function TfrmPesquisar.getConexao: TFDConnection;
begin
  Result := FConexao
end;

function TfrmPesquisar.getConsulta: string;
begin
  Result := FConsulta;
end;

function TfrmPesquisar.getValorCampoAsString(nomeCampo: string): string;
begin
  if not FDQuery.IsEmpty then
    Result := FDQuery.FieldByName(nomeCampo).AsString;
end;

function TfrmPesquisar.pesquisar(PesquisarAoAbrir: Boolean = True): Boolean;
begin
  FDQuery.Connection := getConexao();
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(getConsulta());
  FDQuery.Active := PesquisarAoAbrir;
  Result := True;

  if FDQuery.IsEmpty then
  begin
    Result := False;
    ShowMessage('Não existe dados para serem exibidos!');
    Exit;
  end;

  ShowModal;
end;

procedure TfrmPesquisar.setConexao(conexao: TFDConnection);
begin
  FConexao := conexao
end;

procedure TfrmPesquisar.setConsulta(const Value: string);
begin
  FConsulta := Value;
end;

end.
