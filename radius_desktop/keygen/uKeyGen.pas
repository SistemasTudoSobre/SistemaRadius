unit uKeyGen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uMaster, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmKeyGen = class(TfrmMaster)
    Button1: TButton;
    Button2: TButton;
    maskSerial: TMaskEdit;
    edtValidade: TEdit;
    lblResultado: TLabel;
    edtCnj: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyGen: TfrmKeyGen;

implementation

uses uGerarSerial, uValidaSerial, uData;

{$R *.dfm}

procedure TfrmKeyGen.Button1Click(Sender: TObject);
begin
  inherited;
  maskSerial.Text := getNovoSerial(True, StrToDate(edtValidade.Text), edtCnj.Text);
end;

procedure TfrmKeyGen.Button2Click(Sender: TObject);
var
  validadeDeUso : TDate;
begin
  inherited;
  validadeDeUso := validarSerial(maskSerial.Text, edtCnj.Text);
  validadeDeUso := StrToDateDef(DateToStr(validadeDeUso), 0);

  if validadeDeUso <> 0 then
    begin
      if validadeDeUso < getDataHoje() then
        ShowMessage('Serial correto porém vencido!')
      else
        ShowMessage('Serial correto e ainda está na validade!')
    end
  else
    ShowMessage('Serial invalido!');
end;

end.
