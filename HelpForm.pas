unit HelpForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.IOUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SHDocVw,
  Vcl.ExtCtrls, Vcl.OleCtrls, MSHTML, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;
// WebBrowser

type
  TfrmHelp = class(TForm)
    Panel1: TPanel;
    lblTopic: TLabel;
    WebBrowser: TWebBrowser;
    procedure ShowHelpTopic(const TopicFile: string);
  private
    { Private declarations }
    FEdgeReady: Boolean;
    FPendingURL: string;
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

{$R *.dfm}


uses Main;

procedure TfrmHelp.ShowHelpTopic(const TopicFile: string);
var
  FullPath, URL: string;
begin
  FullPath := ExtractFilePath(Application.ExeName) + 'help\' + TopicFile;

  if not FileExists(FullPath) then
  begin
    ShowMessage('Help topic not found: ' + FullPath);
    Exit;
  end;

  URL := 'file:///' + StringReplace(FullPath, '\', '/', [rfReplaceAll]);
  WebBrowser.Navigate(URL);
  lblTopic.Caption := TopicFile;
  Show;
  BringToFront;
end;

end.
