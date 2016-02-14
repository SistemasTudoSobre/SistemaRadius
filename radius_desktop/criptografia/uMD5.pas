unit uMD5;

interface

uses
  IdHashMessageDigest, IdHash, System.Classes, System.SysUtils;

function getMD5Arquivo(const FileName: string): string;

implementation

function getMD5Arquivo(const FileName: string): string;
var
  IdMD5: TIdHashMessageDigest5;
  FS: TFileStream;
begin
  IdMD5 := nil;
  FS := nil;
  try
    IdMD5 := TIdHashMessageDigest5.Create;
    FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    Result := IdMD5.HashStreamAsHex(FS)
  finally
    FS.Free;
    IdMD5.Free;
  end;
end;

end.
