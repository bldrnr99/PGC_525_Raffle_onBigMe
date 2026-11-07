UNIT dlg_ClosingDiscrepancy;

INTERFACE

USES Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

TYPE
  Tdlg_ClosingDiscr = CLASS(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    mm_ClosingDiscr: TMemo;
    PROCEDURE FormShow(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  dlg_ClosingDiscr: Tdlg_ClosingDiscr;

IMPLEMENTATION

{$R *.dfm}


USES Main;

PROCEDURE Tdlg_ClosingDiscr.FormShow(Sender: TObject);
BEGIN
  dlg_ClosingDiscr.ActiveControl := mm_ClosingDiscr;
  mm_ClosingDiscr.Lines.Clear;
END;

END.
