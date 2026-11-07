unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, edbcomps, Vcl.StdCtrls, Vcl.ComCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Button1: TButton;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    DBGridEh1: TDBGridEh;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DM1;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, ifx: integer;
  tb_Name, db_Name, ix_Name: String;
begin
  Memo1.Clear;
  ProgressBar1.Position:= 0;
  with Form2 do
  begin

    for i := 0 to (ComponentCount - 1) do
      if Components[i] is TEDBTable then
      begin
        tb_Name := TEDBTable(Components[i]).TableName;
        db_Name := TEDBTable(Components[i]).DatabaseName;
        PGC_DATABASE.Execute('REPAIR TABLE "'+tb_Name+'"');
      end;
      end;
end;

end.
