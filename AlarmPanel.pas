UNIT AlarmPanel;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlassButton, MMSystem,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, System.StrUtils, JvExStdCtrls,
  JvBehaviorLabel;

TYPE
  Tpl_Alarm = CLASS(TForm)
    Shape1: TShape;
    lb_Alias: TLabel;
    lb_RoomID: TLabel;
    bt_Cancel: TAdvGlassButton;
    AdvGlassButton1: TAdvGlassButton;
    lb_Alarm: TJvBehaviorLabel;
    PROCEDURE bt_CancelClick(Sender: TObject);
    PROCEDURE AdvGlassButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  pl_Alarm: Tpl_Alarm;

IMPLEMENTATION

{$R *.dfm}


USES Main, DM1;

PROCEDURE Tpl_Alarm.AdvGlassButton1Click(Sender: TObject);
BEGIN
  sndPlaySound(NIL, SND_ASYNC);
  WITH Form1 DO
  BEGIN
    nnWriteCashierDisplay(0, True, clRed, 'Alarme spento ' +
      DateTimeTostr(Now), 0);
    nnWriteCashierDisplay(0, False, clWhite, lb_RoomID.Caption, 1);
    nnWriteCashierDisplay(0, False, clWhite, lb_Alias.Caption, 2);
  END;
  pl_Alarm.Close;
END;

PROCEDURE Tpl_Alarm.bt_CancelClick(Sender: TObject);
BEGIN
  sndPlaySound(NIL, SND_ASYNC);
  WITH Form1 DO
  BEGIN
    nnWriteCashierDisplay(0, True, clRed, 'Alarme spento ' +
      DateTimeTostr(Now), 0);
    nnWriteCashierDisplay(0, False, clWhite, lb_RoomID.Caption, 1);
    nnWriteCashierDisplay(0, False, clWhite, lb_Alias.Caption, 2);
  END;
END;

procedure Tpl_Alarm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  lb_Alarm.BehaviorOptions.Active := False;
end;

procedure Tpl_Alarm.FormShow(Sender: TObject);
begin
  lb_Alarm.BehaviorOptions.Active := True;
end;

END.
