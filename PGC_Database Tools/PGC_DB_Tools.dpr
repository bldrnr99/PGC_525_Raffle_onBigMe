program PGC_DB_Tools;

uses
  Vcl.Forms,
  DM1 in 'DM1.pas' {Form2} ,
  Main in 'Main.pas' {Form1} ,
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
