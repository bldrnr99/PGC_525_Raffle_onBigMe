unit nFeedlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVclUtils, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TNewFeeDlg = class(TForm)
    DBGridEh1: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewFeeDlg: TNewFeeDlg;

implementation

{$R *.dfm}

uses DM1, Main;

end.
