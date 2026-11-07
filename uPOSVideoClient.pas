unit uPOSVideoClient;

interface

uses
  System.JSON,
  Vcl.StdCtrls;

procedure POS_ShowVideo(AMemo: TMemo; AMonitorNo: Integer; const AVideoPath: string);

implementation

uses
  System.SysUtils, Vcl.Dialogs,
  IdTCPClient, IdGlobal;

function POS_SendCommand(const AJSON: TJSONObject; AMemo: TMemo): string;
var
  Client: TIdTCPClient;
  cmd: string;
begin
  Result := '';
  Client := TIdTCPClient.Create(nil);
  try
    Client.Host := 'localhost';
    Client.Port := 9999;
    Client.ConnectTimeout := 3000;
    Client.ReadTimeout := 3000;

    try
      if Assigned(AMemo) then
        AMemo.Lines.Add('Connecting to localhost:9999...');
      Client.Connect;
      if Assigned(AMemo) then
        AMemo.Lines.Add('Connected!');

      cmd := AJSON.ToString;
      if Assigned(AMemo) then
        AMemo.Lines.Add('Sending: ' + cmd);

      Client.IOHandler.WriteLn(cmd, IndyTextEncoding_UTF8);
      Result := Client.IOHandler.ReadLn(IndyTextEncoding_UTF8);

      if Assigned(AMemo) then
      begin
        AMemo.Lines.Add('Response: ' + Result);
        AMemo.Lines.Add('---');
      end;

    except
      on E: Exception do
      begin
        if Assigned(AMemo) then
        begin
          AMemo.Lines.Add('ERROR: ' + E.Message);
          AMemo.Lines.Add('---');
        end;
        raise;
      end;
    end;
  finally
    if Client.Connected then
      Client.Disconnect;
    Client.Free;
  end;
end;

procedure POS_ShowVideo(AMemo: TMemo; AMonitorNo: Integer; const AVideoPath: string);
var
  JSON: TJSONObject;
  response, videoPath: string;
  monitorNo: Integer;
begin
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

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_video');
    JSON.AddPair('monitor', TJSONNumber.Create(monitorNo));
    JSON.AddPair('video', videoPath);

    try
      response := POS_SendCommand(JSON, AMemo);

      if response <> 'OK' then
        ShowMessage('✗ Error: ' + response);

    except
      on E: Exception do
        ShowMessage('Connection failed: ' + E.Message);
    end;
  finally
    JSON.Free;
  end;
end;

end.
