UNIT DlgFreeAmount;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothTouchKeyBoard, Vcl.StdCtrls,
  Vcl.ExtCtrls, AdvTouchKeyboard, StrUtils,
  AdvGlassButton, DBCtrlsEh, Vcl.Mask, JvExControls, JvLabel;

TYPE
  TdlgFreePecunia = CLASS(TForm)
    edEH_Amt: TDBNumberEditEh;
    tkb: TAdvSmoothTouchKeyBoard;
    lb_Info: TJvLabel;
    PROCEDURE tkbKeyClick(Sender: TObject; Index: Integer);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  dlgFreePecunia: TdlgFreePecunia;

IMPLEMENTATION

{$R *.dfm}


USES Main, DM1, nDlgPecunia;

PROCEDURE TdlgFreePecunia.tkbKeyClick(Sender: TObject; Index: Integer);
BEGIN
  WITH Form1 DO
    BEGIN
      CASE INDEX OF
        0:
          BEGIN // Exit key
            kbAmt := 0;
            kbAmtStr := '';
            edEH_Amt.Value := 0;
            dlgFreePecunia.ModalResult := mrCancel;
          END;
        2: // Cancel kay
          BEGIN
            nCC2ClientAmt := 0;
            nCCCommAmt := 0;
            edEH_Amt.Value := 0;
          END;
        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14: // Num keys
          BEGIN
            // ---------------------------------
            // Build kb amount
            // ---------------------------------
            IF ContainsText(tmpkbAmtStr, '.') THEN
              BEGIN
                Inc(decimalCount);
                IF decimalCount > 2 THEN
                  EXIT;
              END;
            tmpkbAmtStr := tmpkbAmtStr + tkb.Keys[INDEX].Caption;
            kbAmt := StrToFloat(tmpkbAmtStr);
            kbAmtStr := FormatFloat('#,##0.00', kbAmt);
            edEH_Amt.Value := kbAmt;
          END;
        12: // Register key
          BEGIN

          END;
      END;
    END;
END;

END.
