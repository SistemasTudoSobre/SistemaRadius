unit uConsultasMesa;

interface

uses Vcl.Forms, System.SysUtils, FireDAC.Comp.Client;

function existeMesaOcupada(mesa:string=''):Boolean;

implementation

uses uConstantes, uConsulta;

//Verifica a existencia de alguma mesa que está ocupada
function existeMesaOcupada(mesa:string=''):Boolean;
var
  dsConsulta: TFDQuery;
  strSQLConsulta: string;
begin
  strSQLConsulta := 'SELECT ' + #13 +
                    '    *  ' + #13 +
                    'FROM RADIUS_MESA M' + #13 +
                    'WHERE M.ID_STATUS_MESA = 2 ';

  if mesa <> '' then
    strSQLConsulta := strSQLConsulta + ' AND M.ID_MESA = ' + mesa;

  dsConsulta := CreateQuery(strSQLConsulta);

  try
    Result := dsConsulta.FieldByName('ID_MESA').AsString <> '';
  finally
    FreeAndNil(dsConsulta)
  end;

end;

end.
