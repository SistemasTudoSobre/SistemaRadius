unit uSeriaisLogicos;

interface

uses Winapi.Windows, System.SysUtils;

function getSerialNumberDrive(FDrive: String): String;

implementation

function getSerialNumberDrive(FDrive: String): String;
var
  Serial: DWord;
  DirLen, Flags: DWord;
  DLabel: Array [0 .. 11] of Char;
begin
  try
    GetVolumeInformation(PChar(FDrive + ':\'), DLabel, 12, @Serial, DirLen,
      Flags, nil, 0);
    Result := IntToHex(Serial, 8);
  except
    Result := '';
  end;
end;

end.
