UNIT Unit4;

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
  TForm4 = CLASS(TForm)
    OmniEventMonitor1: TOmniEventMonitor;
    Image1: TImage;
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE ShowAds(adImg: STRING; monID: Integer);
    PROCEDURE ShowTheAd(CONST task: IOmniTask);

  PRIVATE
    { Private declarations }

  PUBLIC
    { Public declarations }
  END;

VAR
  Form4: TForm4;
  t_ShowAd: IOmniTaskControl;

IMPLEMENTATION

{$R *.dfm}


USES Main, DM1, OtlParallel;

PROCEDURE TForm4.FormShow(Sender: TObject);
BEGIN
  Left := Screen.Monitors[1].Left;
  // Place the form at the left edge of the second monitor
  Top := Screen.Monitors[1].Top;
  // Place the form at the top edge of the second monitor
  Show;
  Form1.SetFocus;
END;

// Thread
// ----------------------------------------------------------------
PROCEDURE TForm4.ShowAds(adImg: STRING; monID: Integer);
BEGIN
  t_ShowAd := CreateTask(ShowTheAd, 'ShowTheAd').MonitorWith(OmniEventMonitor1)
    .SetParameter('adImg', adImg).SetParameter('monID', monID);
  t_ShowAd.Run;
END;

PROCEDURE TForm4.ShowTheAd(CONST task: IOmniTask);
VAR
  fName: STRING;
  MonitorBounds: TRect;
  monID: Integer;
  runAd: Boolean;
BEGIN

  WITH Form2.tb_AdMonitors DO
  BEGIN
    fName := task.Param.ByName('adImg');
    monID := task.Param.ByName('monID');
    Image1.Picture.LoadFromFile(fName);
    Form1.lb_ShowAdsMonID.Caption := IntTostr(monID);
    // Position the form on the second monitor
    Form4.Left := Screen.Monitors[monID].Left;
    Form4.Top := Screen.Monitors[monID].Top;

    // Set the form to fullscreen
    Form4.WindowState := wsMaximized;
    Form4.BorderStyle := bsNone;
    Form4.Width := Screen.Monitors[monID].Width;
    Form4.Height := Screen.Monitors[monID].Height;

    { MonitorBounds := Screen.Monitors[task.Param.ByName('monID')].BoundsRect;
      Left := (MonitorBounds.Width - Width) DIV 2 + MonitorBounds.Left;
      Top := (MonitorBounds.Height - Height) DIV 2 + MonitorBounds.Top; }
    IF monID > 1 THEN
      // Do not show on pc monitor (on a AllInOne pc monitor ID = 0, on a tower pc monitor ID = 1)!!!!
      Show;
    Form1.SetFocus;
  END;
  task.Terminate;
END;
// End Thread
// ----------------------------------------------------------------

END.
