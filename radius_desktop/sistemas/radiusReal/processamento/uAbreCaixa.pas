unit uAbreCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAberturaCaixa = class(TfrmMaster)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Edit4: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure AbrirCaixa(Sender: TObject);
  end;

implementation

uses uInsert, uConstantes, uUsuario, UConsultaCaixa, uData;

var
  frmAberturaCaixa: TfrmAberturaCaixa;

{$R *.dfm}

class procedure TfrmAberturaCaixa.AbrirCaixa(Sender: TObject);
begin
  frmAberturaCaixa := TfrmAberturaCaixa.Create(Application);
  frmAberturaCaixa.Edit1.Text := FormatDateTime('dd/mm/yyyy', getDataHoje());
  frmAberturaCaixa.Edit2.Text := FormatDateTime('hh:MM', Time());
  frmAberturaCaixa.ShowModal();
end;

procedure TfrmAberturaCaixa.Button1Click(Sender: TObject);
begin
  inherited;
  if buscarCaixaAberto(conexaoSistema, getCodigoUsuario()) = '' then
  begin
    if inserirRegistro(conexaoSistema, 'RADIUS_ABERTURA_CAIXA',
      ['DATA_ABERTURA_CAIXA', 'HORA_ABERTURA_CAIXA', 'ID_USUARIO',
      'VALOR_INICIAL', 'ID_STS_CAIXA'],
      [FormatDateTime('dd.mm.yyyy', getDataHoje()), FormatDateTime('hh:MM:ss',
      Time()), getCodigoUsuario(), StringReplace(Edit3.Text, ',', '.',
      [rfReplaceAll]), '1']) then
    begin
      ShowMessage('Abertura de Caixa realizada com sucesso!');
      Close;
    end;
  end
  else
    ShowMessage
      ('O caixa aberto anteriormente por este usuário ainda não foi fechado. ' +
      #13 + 'Feche-o antes de abrir um novo caixa!');
end;

procedure TfrmAberturaCaixa.FormShow(Sender: TObject);
begin
  inherited;
  Edit1.Text := FormatDateTime('dd/mm/yyy', getDataHoje());
  Edit4.Text := getUsuario();
end;

procedure TfrmAberturaCaixa.Timer1Timer(Sender: TObject);
begin
  inherited;
  Edit2.Text := FormatDateTime('hh:MM:ss', Time());
end;

end.
