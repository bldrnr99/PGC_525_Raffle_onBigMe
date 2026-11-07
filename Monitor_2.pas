UNIT Monitor_2;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, JvExExtCtrls, JvImage,
  JvComponentBase, OtlEventMonitor, OoMisc,
  OtlCommon,
  OtlComm,
  OtlTask,
  OtlTaskControl, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.WinXCtrls;

TYPE
  TForm7 = CLASS(TForm)
    Image1: TImage;
    OmniEventMonitor1: TOmniEventMonitor;
    PROCEDURE ShowAds7(adImg: STRING; monID: Integer);
    PROCEDURE ShowTheAd7(CONST task: IOmniTask);
    PROCEDURE FormShow(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  Form7: TForm7;
  t_ShowAd: IOmniTaskControl;
  fMonitor: Integer;

IMPLEMENTATION

{$R *.dfm}


USES Main, OtlParallel, DM1;

// Thread
// ----------------------------------------------------------------
PROCEDURE TForm7.FormShow(Sender: TObject);
BEGIN
  IF NOT Screen.Monitors[fMonitor].Primary THEN
  BEGIN
    Left := Screen.Monitors[fMonitor].Left;
    // Place the form at the left edge of the second monitor
    Top := Screen.Monitors[fMonitor].Top;
    // Place the form at the top edge of the second monitor
    Form7.Show;
  END;
  Form1.SetFocus;
END;

PROCEDURE TForm7.ShowAds7(adImg: STRING; monID: Integer);
BEGIN
  t_ShowAd := CreateTask(ShowTheAd7, 'ShowTheAd7')
    .MonitorWith(OmniEventMonitor1).SetParameter('adImg', adImg)
    .SetParameter('monID', monID);
  t_ShowAd.Run;
END;

PROCEDURE TForm7.ShowTheAd7(CONST task: IOmniTask);
VAR
  fName: STRING;
  MonitorBounds: TRect;
  monID: Integer;
  runAd: Boolean;
BEGIN
  monID := -1;
  // WITH Form2.tb_AdMonitors DO
  BEGIN
    fName := task.Param.ByName('adImg');
    monID := task.Param.ByName('monID');
    fMonitor := monID;
    Image1.Picture.LoadFromFile(fName);
    Form1.lb_ShowAdsMonID.Caption := IntTostr(monID);
    // Position the form on the second monitor
    Form7.Left := Screen.Monitors[monID].Left;
    Form7.Top := Screen.Monitors[monID].Top;

    // Set the form to fullscreen
    Form7.WindowState := wsMaximized;
    Form7.BorderStyle := bsNone;
    Form7.Width := Screen.Monitors[monID].Width;
    Form7.Height := Screen.Monitors[monID].Height;

    { MonitorBounds := Screen.Monitors[task.Param.ByName('monID')].BoundsRect;
      Left := (MonitorBounds.Width - Width) DIV 2 + MonitorBounds.Left;
      Top := (MonitorBounds.Height - Height) DIV 2 + MonitorBounds.Top; }
    IF monID > 0 THEN
      // Do not show on pc monitor (on a AllInOne pc monitor ID = 0, on a tower pc monitor ID = 1)!!!!
      Form7.Show;
    Form1.SetFocus;
  END;
  task.Terminate;
END;
// End Thread
// ----------------------------------------------------------------

END.
