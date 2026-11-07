unit uVideoCommands;

interface

uses
  System.Classes,
  System.JSON,
  Vcl.StdCtrls;

type
  // Function type used to send JSON commands to the video server
  TSendVideoCommandFunc = function(JSON: TJSONObject; AMemo: TMemo): string;

var
  // Must be assigned by your application, e.g.:
  //   VideoSendCommand := SendCommand;
  VideoSendCommand: TSendVideoCommandFunc;

{
  Shared helpers to send "show_video" commands to the video server.

  Overloads:

    1) DoTestVideo(AMemo, AMonitorCombo, AVideoPath)
       - For your Playlist app: uses a TComboBox to select the monitor.

    2) DoTestVideo(AMemo, AMonitorNo, AVideoPath)
       - For your POS app: pass a fixed monitor number (1..3).
}

function DoTestVideo(AMemo: TMemo; AMonitorCombo: TComboBox;
  const AVideoPath: string): Boolean; overload;

function DoTestVideo(AMemo: TMemo; AMonitorNo: Integer;
  const AVideoPath: string): Boolean; overload;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs;

function DoTestVideoCore(AMemo: TMemo; AMonitorNo: Integer;
  const AVideoPath: string): Boolean;
var
  JSON: TJSONObject;
  response, videoPath: string;
  monitorNo: Integer;
begin
  Result := False;

  videoPath := Trim(AVideoPath);

  if videoPath = '' then
  begin
    ShowMessage('Please enter a video path');
    Exit;
  end;

  if not FileExists(videoPath) then
  begin
    ShowMessage('Video file not found: ' + videoPath);
    Exit;
  end;

  monitorNo := AMonitorNo;
  if (monitorNo < 1) or (monitorNo > 3) then
  begin
    ShowMessage('Please select a valid monitor (1..3)');
    Exit;
  end;

  if not Assigned(VideoSendCommand) then
  begin
    ShowMessage('VideoSendCommand is not assigned');
    Exit;
  end;

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_video');
    JSON.AddPair('monitor', TJSONNumber.Create(monitorNo));
    JSON.AddPair('video', videoPath);

    try
      // Call the app-provided sender
      response := VideoSendCommand(JSON, AMemo);

      if SameText(response, 'OK') then
        Result := True
      else
      begin
        ShowMessage('✗ Error: ' + response);
        Result := False;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Connection failed: ' + E.Message);
        Result := False;
      end;
    end;
  finally
    JSON.Free;
  end;
end;

// Playlist-style version: uses TComboBox to select monitor
function DoTestVideo(AMemo: TMemo; AMonitorCombo: TComboBox;
  const AVideoPath: string): Boolean;
var
  monitorNo: Integer;
begin
  if not Assigned(AMonitorCombo) then
  begin
    ShowMessage('Monitor combo not assigned');
    Exit(False);
  end;

  monitorNo := AMonitorCombo.ItemIndex + 1;
  Result := DoTestVideoCore(AMemo, monitorNo, AVideoPath);
end;

// POS-style version: directly specify a monitor number
function DoTestVideo(AMemo: TMemo; AMonitorNo: Integer;
  const AVideoPath: string): Boolean;
begin
  Result := DoTestVideoCore(AMemo, AMonitorNo, AVideoPath);
end;

end.

