unit uPosTCP;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  Vcl.StdCtrls, Vcl.Dialogs,
  IdTCPClient, IdGlobal;

function SendCommand(const AJSON: TJSONObject; AMemo: TMemo): string;

procedure InitMonitorCombo(AComboBox: TComboBox);

procedure DoTestPing(AMemo: TMemo);

procedure DoTestImage(AMemo: TMemo; AMonitorCombo: TComboBox; const AImagePath: string);

procedure DoTestVideo(AMemo: TMemo; AMonitorCombo: TComboBox; const AVideoPath: string);

procedure DoStopMonitor(AMemo: TMemo; AMonitorCombo: TComboBox);

implementation

uses Main;

function SendCommand(const AJSON: TJSONObject; AMemo: TMemo): string;
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

procedure InitMonitorCombo(AComboBox: TComboBox);
begin
  if not Assigned(AComboBox) then
    Exit;

  AComboBox.Items.Clear;
  AComboBox.Items.Add('Monitor 1');
  AComboBox.Items.Add('Monitor 2');
  AComboBox.Items.Add('Monitor 3');
  AComboBox.ItemIndex := 0;
end;

procedure DoTestPing(AMemo: TMemo);
var
  JSON: TJSONObject;
  response: string;
begin
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'ping');

    try
      response := SendCommand(JSON, AMemo);

      if response = 'PONG' then
        ShowMessage('✓ Server is working!')
      else
        ShowMessage('✗ Unexpected response: ' + response);

    except
      on E: Exception do
        ShowMessage('Connection failed: ' + E.Message + #13#10#13#10 +
          'Make sure the playlist application is running!');
    end;
  finally
    JSON.Free;
  end;
end;

procedure DoTestImage(AMemo: TMemo; AMonitorCombo: TComboBox; const AImagePath: string);
var
  JSON: TJSONObject;
  response, imagePath: string;
  monitorNo: Integer;
begin
  imagePath := Trim(AImagePath);

  if imagePath = '' then
  begin
    ShowMessage('Please enter an image path');
    Exit;
  end;

  if not FileExists(imagePath) then
  begin
    ShowMessage('Image file not found: ' + imagePath);
    Exit;
  end;

  if not Assigned(AMonitorCombo) then
  begin
    ShowMessage('Monitor combo not assigned');
    Exit;
  end;

  monitorNo := AMonitorCombo.ItemIndex + 1;

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_image');
    JSON.AddPair('monitor', TJSONNumber.Create(monitorNo));
    JSON.AddPair('image', imagePath);
    JSON.AddPair('duration', TJSONNumber.Create(5));

    try
      response := SendCommand(JSON, AMemo);

      // Show all responses
        (*
        if MainForm.cbgLogEvents.CheckBoxes[0].Checked then
              ShowMessage('Server response: ' + response);
    *)

    except
      on E: Exception do
        ShowMessage('Connection failed: ' + E.Message);
    end;
  finally
    JSON.Free;
  end;
end;

procedure DoTestVideo(AMemo: TMemo; AMonitorCombo: TComboBox; const AVideoPath: string);
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

  if not Assigned(AMonitorCombo) then
  begin
    ShowMessage('Monitor combo not assigned');
    Exit;
  end;

  monitorNo := AMonitorCombo.ItemIndex + 1;
  if (monitorNo < 1) or (monitorNo > 3) then
  begin
    ShowMessage('Please select a monitor');
    Exit;
  end;

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_video');
    JSON.AddPair('monitor', TJSONNumber.Create(monitorNo));
    JSON.AddPair('video', videoPath);

    try
      response := SendCommand(JSON, AMemo);

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

procedure DoStopMonitor(AMemo: TMemo; AMonitorCombo: TComboBox);
var
  JSON: TJSONObject;
  response: string;
  monitorNo: Integer;
begin
  if not Assigned(AMonitorCombo) then
  begin
    ShowMessage('Monitor combo not assigned');
    Exit;
  end;

  monitorNo := AMonitorCombo.ItemIndex + 1;
  if (monitorNo < 1) or (monitorNo > 3) then
  begin
    ShowMessage('Please select a monitor');
    Exit;
  end;

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'stop_monitor');
    JSON.AddPair('monitor', TJSONNumber.Create(monitorNo));

    try
      response := SendCommand(JSON, AMemo);

      if response = 'OK' then
      begin
        if Assigned(AMemo) then
          AMemo.Lines.Add(Format('✓ Monitor %d stopped', [monitorNo]));
      end
      else
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
