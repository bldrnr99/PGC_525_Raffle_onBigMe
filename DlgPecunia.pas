UNIT DlgPecunia;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlassButton, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh, JvExControls, JvLED,
  AdvSmoothTouchKeyBoard, System.StrUtils, AdvSmoothMessageDialog;

TYPE
  Tdlg_Pecunia = CLASS(TForm)
    Label1: TLabel;
    DBNumberEditEh3: TDBNumberEditEh;
    pl_Recpayment: TPanel;
    lb_TabTxID: TLabel;
    Label6: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    ed_BarTabTotal: TDBNumberEditEh;
    ed_firstTabAmt: TDBNumberEditEh;
    ed_BarBalance: TDBNumberEditEh;
    Label7: TLabel;
    ed_tkAmt: TDBNumberEditEh;
    Label3: TLabel;
    ed_BarBalance2: TDBNumberEditEh;
    Shape2: TShape;
    lb_balToPay: TLabel;
    ed_BalToPay: TDBNumberEditEh;
    Label2: TLabel;

  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  dlg_Pecunia: Tdlg_Pecunia;
 
IMPLEMENTATION

{$R *.dfm}


USES Main, DM1;

END.
