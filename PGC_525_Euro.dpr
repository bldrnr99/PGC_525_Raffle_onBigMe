PROGRAM PGC_525_Euro;

uses
  Winapi.Windows,
  Vcl.Forms,
  System.SysUtils,
  TagC32 in 'TagC32.pas' {TagReader: TDataModule} ,
  Vcl.Themes,
  Vcl.Styles,
  DM1 in 'DM1.pas' {Form2} ,
  Unit6 in 'Unit6.pas' {SplashScreen} ,
  AlarmPanel in 'AlarmPanel.pas' {pl_Alarm} ,
  Unit4 in 'Unit4.pas' {Form4} ,
  KeyBoard in 'KeyBoard.pas' {NumKeyboard} ,
  PGCManual in 'PGCManual.pas' {Manual} ,
  HelpForm in 'HelpForm.pas' {frmHelp} ,
  HelpEditorForm in 'HelpEditorForm.pas' {frmHelpEditor} ,
  Main in 'Main.pas' {Form1} ,
  RawPrinter in 'RawPrinter.pas',
  TaskDlgHelperF in 'TaskDlgHelperF.pas',
  GCC in 'GCC.pas' {CCtoG} ,
  uClientStore in 'uClientStore.pas',
  RrRooms in 'RrRooms.pas' {RR_Rooms} ,
  uWriteCashierDisplay in 'uWriteCashierDisplay.pas',
  uCheckRaffleWin in 'uCheckRaffleWin.pas' {frmCheckRaffleWin};

{$R *.res}


var
  MutexHandle: THandle;
  LastError: DWORD;

procedure KillExistingInstance;
var
  Wnd: HWND;
  PID: DWORD;
  ProcHandle: THandle;
begin
  Wnd := FindWindow('TForm1', nil);
  if Wnd = 0 then
    Wnd := FindWindow('TApplication', 'PGC 523-030526 EURO');
  if Wnd = 0 then
    Exit;

  GetWindowThreadProcessId(Wnd, @PID);
  if PID = 0 then
    Exit;

  ProcHandle := OpenProcess(PROCESS_TERMINATE, False, PID);
  if ProcHandle <> 0 then
  begin
    TerminateProcess(ProcHandle, 0);
    CloseHandle(ProcHandle);
    Sleep(500); // give Windows time to release the mutex and clean up
  end;
end;

BEGIN
  MutexHandle := CreateMutex(nil, True, 'Local\PGC_525_Euro_SingleInstance');
  LastError := GetLastError;
  if MutexHandle = 0 then
    Halt;

  if LastError = ERROR_ALREADY_EXISTS then
  begin
    KillExistingInstance;
    CloseHandle(MutexHandle);
    // Re-acquire mutex now that old instance is dead
    MutexHandle := CreateMutex(nil, True, 'Local\PGC_525_Euro_SingleInstance');
    LastError := GetLastError;
    if (MutexHandle = 0) or (LastError = ERROR_ALREADY_EXISTS) then
      Halt; // still running somehow, give up
  end;

  Application.Initialize;
  SplashScreen := TSplashScreen.Create(NIL);
  SplashScreen.Show;
  SplashScreen.Update;
  Application.Title := 'PGC 523-030526 EURO';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTagReader, TagReader);
  SplashScreen.Label1.Caption := '.. loading Form1..';
  Application.CreateForm(TForm1, Form1);
  SplashScreen.Label1.Caption := '.. loading Database';
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tpl_Alarm, pl_Alarm);
  pl_Alarm.Close;
  Application.CreateForm(TForm4, Form4);
  Form4.Close;
  pl_Alarm.Close;
  Application.CreateForm(TManual, Manual);
  Manual.Close;
  Application.CreateForm(TRR_Rooms, RR_Rooms);
  RR_Rooms.Close;
  Application.CreateForm(TfrmHelp, frmHelp);
  frmHelp.Close;
  Application.CreateForm(TfrmHelpEditor, frmHelpEditor);
  frmHelpEditor.Close;
  Application.CreateForm(TNumKeyboard, NumKeyboard);
  NumKeyboard.Close;
  Application.CreateForm(TCCtoG, CCtoG);
  CCtoG.Close;
  SplashScreen.Hide;
  SplashScreen.Free;
  Application.Run;
  CloseHandle(MutexHandle);

END.
