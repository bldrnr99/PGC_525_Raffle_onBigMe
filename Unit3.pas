unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  Tn_routines = class(TForm)
    Edit1: TEdit;
    procedure GetCardData(cID,clID,dtID:Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  n_routines: Tn_routines;

implementation

{$R *.dfm}

uses DlgPecunia, DM1, Main;

end.
