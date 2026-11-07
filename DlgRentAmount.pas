UNIT DlgRentAmount;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, advmultibuttonedit,
  AdvUpDownEdit;

TYPE
  TForm4 = CLASS(TForm)
    ed_UpDn_RR: TAdvUpDownEdit;
    OKBtn: TButton;
    bt_Cancel: TButton;
    lb_rr_Alias: TLabel;
    lb_rr_Days: TLabel;
    lb_RR_ID: TLabel;
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE ed_UpDn_RRChange(Sender: TObject);
    PROCEDURE FormDeactivate(Sender: TObject);
    PROCEDURE bt_CancelClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  Form4: TForm4;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

PROCEDURE TForm4.bt_CancelClick(Sender: TObject);
BEGIN
  Form4.Close;
END;

PROCEDURE TForm4.ed_UpDn_RRChange(Sender: TObject);
BEGIN
  IF ed_UpDn_RR.Edit.Value > 0 THEN
    lb_rr_Days.Caption := 'PAGA PER ' +
      IntToStr(ed_UpDn_RR.Edit.Value / Trunc(Form1.c_RR_Rate)) + ' GIORNO(I).';
END;

PROCEDURE TForm4.FormDeactivate(Sender: TObject);
BEGIN
  Form4.Close;
END;

PROCEDURE TForm4.FormShow(Sender: TObject);
BEGIN
  WITH Form1 DO
    BEGIN
      ed_UpDn_RR.MinFloatValue := c_RR_Rate;
      ed_UpDn_RR.IncrementFloat := Trunc(c_RR_Rate);
      ed_UpDn_RR.Edit.Value := c_RR_Rate;
      lb_rr_Alias.Caption := alias;
      lb_RR_ID.Caption := 'Camera ' + c_RR_ID;
    END;

END;

END.
