unit uHora;

interface

uses System.SysUtils;

function getHoraAgora(): TTime;

implementation

function getHoraAgora(): TTime;
begin
  Result := Time;
end;

end.
