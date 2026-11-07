unit uPlaylistClient;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  System.JSON,
  IdException,
  IdTCPClient,
  IdExceptionCore,
  IdGlobal,
  IdStack; // EIdException (base Indy exception)

type
  TPlaylistClient = class
  private
    FHost: string;
    FPort: Integer;
    FClient: TIdTCPClient;
    function SendCommandJSON(AJSON: TJSONObject): string;
  public
    constructor Create(const AHost: string; APort: Integer);
    destructor Destroy; override;

    function ShowImage(AMonitor: Integer; const AImagePath: string;
      ADurationSeconds: Integer): Boolean;
    function ShowVideo(AMonitor: Integer; const AVideoPath: string): Boolean;
    function StopInterrupt(AMonitor: Integer): Boolean;
    function SetOverlayText(AMonitor: Integer; const AText: string): Boolean;
    function StopMonitor(AMonitor: Integer): Boolean;
    function Ping: Boolean;
    function ShutdownServer: Boolean;
  end;

implementation

{ TPlaylistClient }

constructor TPlaylistClient.Create(const AHost: string; APort: Integer);
begin
  inherited Create;
  FHost := AHost;
  FPort := APort;

  FClient := TIdTCPClient.Create(nil);
  FClient.Host := FHost;
  FClient.Port := FPort;
  FClient.ReadTimeout := 5000; // 5 seconds, adjust if needed
end;

destructor TPlaylistClient.Destroy;
begin
  FClient.Free;
  inherited;
end;

{
  function TPlaylistClient.SendCommandJSON(AJSON: TJSONObject): string;
  var
  s: string;
  begin
  Result := '';
  try
  s := AJSON.ToString;
  FClient.ConnectTimeout := 500;  // Reduced from 3000
  FClient.ReadTimeout := 2000;

  try
  FClient.Connect;
  except
  Exit; // Connection failed, return empty
  end;

  try
  // Send JSON line
  FClient.IOHandler.WriteLn(s, IndyTextEncoding_UTF8);

  // Try to read response, but don't fail if connection closes
  try
  Result := FClient.IOHandler.ReadLn(IndyTextEncoding_UTF8);
  except
  // Connection closed before response - that's OK for shutdown
  Result := 'OK';
  end;
  finally
  try
  if FClient.Connected then
  FClient.Disconnect;
  except
  // Ignore disconnect errors
  end;
  end;
  except
  Result := '';
  end;
  end;
}

function TPlaylistClient.SendCommandJSON(AJSON: TJSONObject): string;
var
  s: string;
begin
  Result := '';
  try
    s := AJSON.ToString;
    // ShowMessage('Sending: ' + s);  // ← Add this
    FClient.ConnectTimeout := 500;
    FClient.ReadTimeout := 2000;

    try
      FClient.Connect;
      // ShowMessage('Connected successfully');  // ← Add this
    except
      on E: Exception do
      begin
        ShowMessage('Connect failed: ' + E.Message); // ← Add this
        Exit;
      end;
    end;

    try
      FClient.IOHandler.WriteLn(s, IndyTextEncoding_UTF8);
      // ShowMessage('Command sent');  // ← Add this

      try
        Result := FClient.IOHandler.ReadLn(IndyTextEncoding_UTF8);
        // ShowMessage('Response received: ' + Result);  // ← Add this
      except
        on E: Exception do
        begin
          ShowMessage('ReadLn exception: ' + E.Message); // ← Add this
          Result := 'OK';
        end;
      end;
    finally
      try
        if FClient.Connected then
          FClient.Disconnect;
      except
      end;
    end;
  except
    on E: Exception do
      ShowMessage('SendCommandJSON exception: ' + E.Message); // ← Add this
  end;
end;

function TPlaylistClient.ShowImage(AMonitor: Integer; const AImagePath: string;
  ADurationSeconds: Integer): Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_image');
    JSON.AddPair('monitor', TJSONNumber.Create(AMonitor));
    JSON.AddPair('image', AImagePath);
    JSON.AddPair('duration', TJSONNumber.Create(ADurationSeconds)); // <=0 => POS-controlled

    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

function TPlaylistClient.ShowVideo(AMonitor: Integer; const AVideoPath: string): Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'show_video');
    JSON.AddPair('monitor', TJSONNumber.Create(AMonitor));
    JSON.AddPair('video', AVideoPath);

    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

function TPlaylistClient.StopInterrupt(AMonitor: Integer): Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'stop_interrupt');
    JSON.AddPair('monitor', TJSONNumber.Create(AMonitor));

    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

function TPlaylistClient.SetOverlayText(AMonitor: Integer; const AText: string): Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'set_text');
    JSON.AddPair('monitor', TJSONNumber.Create(AMonitor));
    JSON.AddPair('text', AText);

    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

function TPlaylistClient.StopMonitor(AMonitor: Integer): Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'stop_monitor');
    JSON.AddPair('monitor', TJSONNumber.Create(AMonitor));

    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

{
  function TPlaylistClient.Ping: Boolean;
  var
  JSON: TJSONObject;
  resp: string;
  begin
  Result := False;
  JSON := TJSONObject.Create;
  try
  JSON.AddPair('command', 'ping');
  resp := SendCommandJSON(JSON);
  Result := SameText(resp, 'PONG');
  finally
  JSON.Free;
  end;
  end;
}

function TPlaylistClient.Ping: Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'ping');

    try
      resp := SendCommandJSON(JSON);
      Result := SameText(resp, 'PONG');
    except
      on E: Exception do
      begin
        // Optional: log E.ClassName + ': ' + E.Message
        Result := False;
      end;
    end;

  finally
    JSON.Free;
  end;
end;

function TPlaylistClient.ShutdownServer: Boolean;
var
  JSON: TJSONObject;
  resp: string;
begin
  Result := False;
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('command', 'shutdown');
    resp := SendCommandJSON(JSON);
    Result := SameText(resp, 'OK');
  finally
    JSON.Free;
  end;
end;

end.
