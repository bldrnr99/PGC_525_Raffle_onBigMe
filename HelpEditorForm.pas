unit HelpEditorForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Dialogs, AdvRichEditor, Vcl.Buttons, AdvToolBar,
  AdvToolBarExt, AdvRichEditorToolBar, AdvRichEditorIO, AdvScrollControl,
  AdvRichEditorBase, Vcl.ComCtrls;

type
  TfrmHelpEditor = class(TForm)
    btnNew: TSpeedButton;
    btnOpen: TSpeedButton;
    btnSave: TSpeedButton;
    btnSaveAs: TSpeedButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    StatusBar: TStatusBar;
    AdvRichEditor1: TAdvRichEditor;
    AdvRichEditorHTMLIO1: TAdvRichEditorHTMLIO;
    AdvRichEditorFormatToolBar1: TAdvRichEditorFormatToolBar;
    AdvRichEditorRTFIO1: TAdvRichEditorRTFIO;
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure AdvRichEditor1Change(Sender: TObject);
  private
    FCurrentFile: string;
    procedure UpdateCaption;
    procedure SaveToHTML(const FileName: string);
  public
  end;

var
  frmHelpEditor: TfrmHelpEditor;

implementation

{$R *.dfm}


procedure TfrmHelpEditor.FormCreate(Sender: TObject);
begin
  // Configure save dialog to HTML only
  dlgSave.Filter := 'HTML (*.html)|*.html';
  dlgSave.DefaultExt := 'html';
  dlgSave.FilterIndex := 1;
  // Configure open dialog to HTML only
  dlgOpen.Filter := 'HTML (*.html)|*.html';
  dlgOpen.FilterIndex := 1;
  UpdateCaption;
end;

procedure TfrmHelpEditor.UpdateCaption;
begin
  if FCurrentFile <> '' then
    Caption := 'Help Editor - ' + ExtractFileName(FCurrentFile)
  else
    Caption := 'Help Editor - Untitled';
end;

procedure TfrmHelpEditor.SaveToHTML(const FileName: string);
begin
  AdvRichEditorHTMLIO1.Save(FileName);
  FCurrentFile := FileName;
  StatusBar.SimpleText := 'Saved: ' + FileName;
  UpdateCaption;
end;

procedure TfrmHelpEditor.btnNewClick(Sender: TObject);
begin
  AdvRichEditor1.Clear;
  FCurrentFile := '';
  StatusBar.SimpleText := 'New document';
  UpdateCaption;
end;

procedure TfrmHelpEditor.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    FCurrentFile := dlgOpen.FileName;
    // Load HTML into editor
    AdvRichEditorHTMLIO1.Load(FCurrentFile);
    StatusBar.SimpleText := 'Opened: ' + FCurrentFile;
    UpdateCaption;
  end;
end;

procedure TfrmHelpEditor.btnSaveClick(Sender: TObject);
begin
  if FCurrentFile = '' then
    btnSaveAsClick(Sender)
  else
    SaveToHTML(FCurrentFile);
end;

procedure TfrmHelpEditor.btnSaveAsClick(Sender: TObject);
var
  FileNameToSave: string;
begin
  if dlgSave.Execute then
  begin
    dlgSave.Filter := 'HTML files (*.html)|*.html';
    FileNameToSave := dlgSave.FileName;
    if ExtractFileExt(FileNameToSave) = '' then
      FileNameToSave := FileNameToSave + '.html';
    SaveToHTML(FileNameToSave);
  end;
end;

procedure TfrmHelpEditor.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHelpEditor.AdvRichEditor1Change(Sender: TObject);
begin
  // No live preview
end;

end.e; end;

procedure TfrmHelpEditor.AdvRichEditor1Change
(Sender: TObject); begin
// No live preview
end;

end.
