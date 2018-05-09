program TestVideoPrevew;

uses
  Forms,
  UnitVideoPreviewMain in 'UnitVideoPreviewMain.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
