program HandOver;

uses
  Vcl.Forms,
  frmHandoverUnit in 'frmHandoverUnit.pas' {frmHandover};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHandover, frmHandover);
  Application.Run;
end.
