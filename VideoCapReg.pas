unit VideoCapReg;

interface

 Procedure Register;

implementation

uses
  Classes,
  Videocap,
  VideoDisp;

procedure Register;
begin
  RegisterComponents( 'Video', [TVideoCap]);
  RegisterComponents( 'Video', [TVideoDisp]);
end;

end.
 