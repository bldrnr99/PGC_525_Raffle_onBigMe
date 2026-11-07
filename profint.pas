//PROFILE-NO
{$O-}
{$D-}
{$Q-}
{$R-}
{$B-}
{$I-}
{$X+}
{$WARNINGS OFF }

unit Profint;

interface

USES
{$IFNDEF CONSOLE }
  Dialogs,
{$ENDIF }
  Windows;

{$IFDEF CONDITIONALEXPRESSIONS }
  {$DEFINE PROFD6ORBETTER}
  {$IF CompilerVersion > 16 }
    {$DEFINE PROFD2005ORBETTER}
    {$IF CompilerVersion > 19 }
      {$DEFINE PROFD2009ORBETTER}
      {$IF CompilerVersion > 33 }
        {$DEFINE PROFD104ORBETTER }
      {$IFEND }
    {$IFEND }
  {$IFEND }
{$ENDIF }

CONST
{$IFDEF WIN64 }
  ProDLLMeas = 'PROFMEAS64.DLL';
  ProDLLCali = 'PROFCALI64.DLL';
  ProDLLOnfo = 'PROFONFO64.DLL';
{$ELSE }
  ProDLLMeas = 'PROFMEAS.DLL';
  ProDLLCali = 'PROFCALI.DLL';
  ProDLLOnfo = 'PROFONFO.DLL';
{$ENDIF }
// Profiler-Measurement-Functions
PROCEDURE ProfStop;                                       external ProDLLMeas;
PROCEDURE ProfEnter( mptr  : Pointer; prozNr : LongWord); external ProDLLMeas;
PROCEDURE ProfExit( prozNr : Integer);                    external ProDLLMeas;

PROCEDURE ProfActivate;     external ProDLLMeas;
PROCEDURE ProfDeActivate;   external ProDLLMeas;

{$IFNDEF ANSICODEVERSION }
PROCEDURE ProfSetComment    ( comm    : String);
PROCEDURE ProfSetCommentA   ( comm    : PAnsiChar);external ProDLLMeas;
{$ELSE }
PROCEDURE ProfSetComment    ( comm    : PAnsiChar );  external ProDLLMeas;
{$ENDIF }
PROCEDURE ProfAppendResults ( progEnd : Boolean );external ProDLLMeas;

// Post-Mortem-Review-Functions
PROCEDURE PomoEnter       ( prozNr : Word );      external ProDLLMeas;
PROCEDURE PomoExceStr     ( name   : PChar );     external ProDLLMeas;
PROCEDURE PomoExce;
PROCEDURE PomoExit        ( prozNr : Word );      external ProDLLMeas;

// Functions to interrupt and continue measurement for calls which could set the
//  Process idle. Use these calls to implement own Non-measured Calls. If METHODS
//  can set a process idle, the only possibility is, to put these calls into your
//  sources (included by an IFDEF-statement).
//  USE 2 or more spaces between IFDEF and PROFILE, otherwise it will be deleted
//  by the ProDelphi. Example:
//
//  {$IFDEF     PROFILE } StopCounting;     {$ENDIF }
//    ObjectReference.MethodThatMightSetProcessIdle;
//  {$IFDEF     PROFILE } ContinueCounting; {$ENDIF }

// Normal procedures that set the process idle can be handled like the Sleep-
//  function in this unit.
PROCEDURE StopCounting;                           external ProDLLMeas;
PROCEDURE ContinueCounting;                       external ProDLLMeas;

// Function for Starting the Online-Operation windoe
PROCEDURE ProfOnlineOperation;                    external ProDLLOnfo;
PROCEDURE ProfCloseOnlineOperation;               external ProDLLOnfo;

// Delphi-Functions that set process idle
{$IFNDEF CONSOLE }
PROCEDURE ShowMessage ( CONST Msg  : String );

PROCEDURE ShowMessageFmt(const Msg : string; Params : array of const );

          // If you need to compile the VCL, the next functions must be deleted,
          // Sorry ! The USES statement for Dialogs has to be moved to the
          // Implementation part !!!
  {$IFDEF PROFD2005ORBETTER }
function  MessageDlg( const Msg : String;         AType   : TMsgDlgType;
                      AButtons  : TMsgDlgButtons; HelpCtx : Longint ) : Integer; Overload;

function  MessageDlg( const Msg : String;         AType   : TMsgDlgType;
                      AButtons  : TMsgDlgButtons; HelpCtx : Longint;
                      DefaultButton : TMsgDlgBtn) : Integer; Overload;

function  MessageDlgPos( const Msg : string;         DlgType : TMsgDlgType;
                         Buttons   : TMsgDlgButtons; HelpCtx: Longint;
                         X, Y      : Integer) : Integer; Overload;

function  MessageDlgPos( const Msg : string;         DlgType : TMsgDlgType;
                         Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y      : Integer;        DefaultButton : TMsgDlgBtn) : Integer; Overload;

  {$ELSE }
function  MessageDlg( const Msg : String;         AType   : TMsgDlgType;
                      AButtons  : TMsgDlgButtons; HelpCtx : Longint ) : Integer;

function  MessageDlgPos( const Msg : string;         DlgType : TMsgDlgType;
                         Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y      : Integer) : Integer;
  {$ENDIF }

  {$IFDEF PROFD2005ORBETTER }
  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string)
                             : Integer; Overload;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string;
                              DefaultButton : TMsgDlgBtn)
                             : Integer; Overload;

  {$ELSE }
  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string)
                             : Integer;
  {$ENDIF }
  {$IFDEF PROFD104ORBETTER }

  function MessageDlg(const Msg       : string;
                      DlgType         : TMsgDlgType;
                      Buttons         : TMsgDlgButtons;
          					  HelpCtx         : Longint;
					            DefaultButton   : TMsgDlgBtn;
                      CustomButtonCaptions: array of string): Integer; Overload;

  function MessageDlgPos(const Msg    : string;
                         DlgType      : TMsgDlgType;
                         Buttons      : TMsgDlgButtons;
			                   HelpCtx      : Longint;
					               X, Y         : Integer;
                         DefaultButton: TMsgDlgBtn;
					               TaskDlgFlags : TTaskDialogFlags;
					               CustomButtonCaptions: array of string): Integer; Overload;

  function MessageDlgPos(const Msg   : string;         DlgType : TMsgDlgType;
                         Buttons     : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y        : Integer;        TaskDlgFlags : TTaskDialogFlags): Integer; overload;

  function MessageDlgPos(const Msg   : string;         DlgType : TMsgDlgType;
                         Buttons     : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y        : Integer;        DefaultButton: TMsgDlgBtn;
                         TaskDlgFlags: TTaskDialogFlags): Integer; overload;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName: string;
                              TaskDlgFlags: TTaskDialogFlags)
                             : Integer; overload;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName: string;
                              DefaultButton : TMsgDlgBtn; TaskDlgFlags: TTaskDialogFlags)
                             : Integer; overload;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string;
                              DefaultButton : TMsgDlgBtn; TaskDlgFlags : TTaskDialogFlags;
                              CustomButtonCaptions : array of string)
                             : Integer; overload;
  {$ENDIF }

{$ENDIF }

// Delphi-TApplication-Functions that set process idle (handled in DLL)
VAR
  ProcessMessages : Procedure Of Object;
  HandleMessage : Procedure Of Object;

{$IFNDEF CONSOLE }
  {$IFDEF PROFD6ORBETTER}
  FUNCTION  AMessageBox( Text, Caption   : PChar;
                         Flags : Longint = MB_OK): Integer;
  {$ELSE }
  FUNCTION  AMessageBox( Text, Caption   : PChar;
                         Flags : Longint): Integer;
  {$ENDIF }
{$ENDIF}

// Windows-Functions that set process idle
FUNCTION  DialogBoxIndirect( hInstance  : HINST; const lpDialogTemplate : TDlgTemplate;
                             hWndParent : HWND;        lpDialogFunc     : TFNDlgProc): Integer;
{$IFDEF PROFD2009ORBETTER }
FUNCTION  DialogBox( hInstance  : HINST; lpTemplate   : PChar;
                     hWndParent : HWND;  lpDialogFunc : TFNDlgProc): Integer; Overload;
FUNCTION  DialogBox( hInstance  : HINST; lpTemplate   : PAnsiChar;
                     hWndParent : HWND;  lpDialogFunc : TFNDlgProc): Integer; Overload;
FUNCTION  MessageBox ( hWnd : HWND; lpText, lpCaption: PAnsiChar; uType : UINT ) : Integer; Overload;
FUNCTION  MessageBoxEx( hWnd : HWND; lpText, lpCaption: PAnsiChar; uType : UINT; lang : Word ) : Integer; Overload;
FUNCTION  MessageBox ( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT ) : Integer; Overload;
FUNCTION  MessageBoxEx( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT; lang : Word ) : Integer; Overload;
{$ELSE }
FUNCTION  DialogBox( hInstance  : HINST; lpTemplate   : PChar;
                     hWndParent : HWND;  lpDialogFunc : TFNDlgProc): Integer;
FUNCTION  MessageBox ( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT ) : Integer;
FUNCTION  MessageBoxEx( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT; lang : Word ) : Integer;
{$ENDIF }
{$IFDEF UNICODE }
  FUNCTION SignalObjectAndWait ( h1, h2 : Cardinal;
                                 ms     : Cardinal;
                                 al     : LongBool) : Cardinal;
  {$ELSE }
  FUNCTION  SignalObjectAndWait ( h1, h2 : THandle;
                                  ms     : DWord;
                                  al     : BOOL) : BOOL;
{$ENDIF }

FUNCTION  WaitForSingleObject ( h1     : THandle;
                                MS     : DWORD ) : DWORD;

FUNCTION  WaitForSingleObjectEx ( h1   : THandle;
                                  MS   : DWORD;
                                  al   : BOOL ) : DWORD;

FUNCTION  WaitForMultipleObjects ( ct  : DWORD;
                                   CONST pH : PWOHandleArray;
                                   wait     : BOOL;
                                   ms       : DWORD ) : DWORD;

FUNCTION  WaitForMultipleObjectsEx ( ct  : DWORD;
                                     CONST pH : PWOHandleArray;
                                     wait     : BOOL;
                                     ms       : DWORD;
                                     al       : Boolean) : DWORD;

FUNCTION  MsgWaitForMultipleObjects ( ct      : DWORD;
                                      VAR pHandles;
                                      wait    : BOOL;
                                      ms      : DWORD;
                                      wm      : DWORD ) : DWORD;

FUNCTION  MsgWaitForMultipleObjectsEx ( ct     : DWORD;
                                        VAR pHandles;
                                        ms     : DWORD;
                                        wm     : DWORD;
                                        fl     : DWORD ) : DWORD;

PROCEDURE Sleep   (zeit : DWORD );
FUNCTION  SleepEx (zeit : DWORD; alertable : BOOL ) : DWORD;
FUNCTION  WaitCommEvent ( hd  : THandle; VAR em : DWORD;
                          lpo : POverlapped ) : BOOL;
FUNCTION  WaitForInputIdle ( hp : THandle; ms : DWORD ) : DWORD;
FUNCTION  WaitMessage : BOOL;

{$IFDEF UNICODE }
FUNCTION WaitNamedPipe ( np : PWideChar; ms : Cardinal ) : BOOL;
{$ELSE }
FUNCTION  WaitNamedPipe ( np : PAnsiChar; ms : DWORD ) : BOOL;
{$ENDIF }


{$IFNDEF CONSOLE }
TYPE
  TProfIntApp = Class
    PROCEDURE ProcessMessages;
    PROCEDURE HandleMessage;
  end;
VAR
  ProfintApplication : TProfIntApp;
{$ENDIF }


IMPLEMENTATION
USES
{$IFNDEF CONSOLE }
  Forms,
{$ENDIF }
{$IFDEF CPUX86 }
  UITypes,
{$ENDIF }
{$IFDEF CPUX64 }
  UITypes,
{$ENDIF }
  SysUtils;

TYPE
  TObjProzedur = PROCEDURE OF Object;

// Profiler-Internal-Functions, DO NOT USE
FUNCTION  ProfGlobalInit1 : Boolean;              external ProDLLMeas;
PROCEDURE ProfGlobalInit2 ( j : Integer );        external ProDLLMeas;
PROCEDURE ProfUnInitTimer;                        external ProDLLMeas;
FUNCTION  ProfIsInitialised : Integer;            external ProDLLMeas;
FUNCTION  ProfMustBeUnInitialised : Integer;      external ProDLLMeas;

// Calibration - Function - DO NOT USE
PROCEDURE CalcQPCTime802;                         external ProDLLCali;
PROCEDURE ProfSetDelphiVersion ( vers : Integer );external ProDLLCali;

{$IFDEF PROFD2005ORBETTER }
FUNCTION RDTSC : Int64;
ASM
  RDTSC;
END;
{$ELSE }
FUNCTION RDTSC : Int64;
ASM
  DW 310FH;
END;
{$ENDIF }
// Check if CPU is intel-Compatible
PROCEDURE PruefeKompatibilitaet;
BEGIN
  Try
    RDTSC;
  Except
    Windows.MessageBox(0, 'This CPU is not Intel-Compatible', 'ProDelphi - ERROR', MB_OK);
    halt(0);
  End;
END;

{$IFNDEF CONSOLE }
PROCEDURE ShowMessage ( CONST Msg  : String );
BEGIN
  StopCounting;
  Dialogs.ShowMessage(Msg);
  ContinueCounting;
END;

PROCEDURE ShowMessageFmt(const Msg : string; Params : array of const );
BEGIN
  StopCounting;
  Dialogs.ShowMessageFmt(Msg, Params);
  ContinueCounting;
END;

FUNCTION AMessageBox( Text, Caption     : PChar;
                      Flags : LongInt ) : Integer;
BEGIN
  StopCounting;
  Result := Application.MessageBox(Text, Caption,Flags);
  ContinueCounting;
END;

PROCEDURE TProfIntApp.HandleMessage;
BEGIN
  ProfStop; Try; ProfEnter(0,1);
  Application.HandleMessage;
  finally; ProfExit(1); end;
END;

PROCEDURE TProfIntApp.ProcessMessages;
BEGIN
  ProfStop; Try; ProfEnter(0,1);
  Application.ProcessMessages;
  finally; ProfExit(1); end;
END;

FUNCTION MessageDlg( const Msg : String;         AType   : TMsgDlgType;
                     AButtons  : TMsgDlgButtons; HelpCtx : Longint ) : Integer;
BEGIN
  StopCounting;
  Result := Dialogs.MessageDlg(Msg,
                               AType,
                               AButtons,
                               HelpCtx);
  ContinueCounting;
END;

FUNCTION MessageDlgPos( const Msg : string;         DlgType : TMsgDlgType;
                        Buttons   : TMsgDlgButtons; HelpCtx: Longint;
                        X, Y      : Integer) : Integer;
BEGIN
  StopCounting;
  Result := Dialogs.MessageDlgPos(Msg,
                                  DlgType,
                                  Buttons,
                                  HelpCtx,
                                  X, Y);
  ContinueCounting;
END;

  {$IFDEF PROFD2005ORBETTER }
function MessageDlg( const Msg     : String;         AType   : TMsgDlgType;
                     AButtons      : TMsgDlgButtons; HelpCtx : Longint;
                     DefaultButton : TMsgDlgBtn ) : Integer;
BEGIN
  StopCounting;
  Result := Dialogs.MessageDlg(Msg,
                               AType,
                               AButtons,
                               HelpCtx,
                               DefaultButton);
  ContinueCounting;
END;

FUNCTION MessageDlgPos( const Msg : string;         DlgType       : TMsgDlgType;
                        Buttons   : TMsgDlgButtons; HelpCtx       : Longint;
                        X, Y      : Integer;        DefaultButton : TMsgDlgBtn ) : Integer;
BEGIN
  StopCounting;
  Result := Dialogs.MessageDlgPos(Msg,
                                  DlgType,
                                  Buttons,
                                  HelpCtx,
                                  X, Y,
                                  DefaultButton);
  ContinueCounting;
END;
  {$ENDIF }
function MessageDlgPosHelp( const Msg : string;         DlgType      : TMsgDlgType;
                            Buttons   : TMsgDlgButtons; HelpCtx      : Longint;
                            X, Y      : Integer;  const HelpFileName : string)
                           : Integer;
BEGIN
  StopCounting;
  Result := Dialogs.MessageDlgPosHelp(Msg,
                                      DlgType,
                                      Buttons,
                                      HelpCtx,
                                      X, Y,
                                      HelpFileName);
  ContinueCounting;
END;
  {$IFDEF PROFD2005ORBETTER }
  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string;
                              DefaultButton : TMsgDlgBtn)
                             : Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPosHelp(Msg,
                                        DlgType,
                                        Buttons,
                                        HelpCtx,
                                        X, Y,
                                        HelpFileName,
                                        DefaultButton);
    ContinueCounting;
  END;
  {$ENDIF }

  {$IFDEF PROFD104ORBETTER }

  function MessageDlg(const Msg    : string;
                      DlgType      : TMsgDlgType;
                      Buttons      : TMsgDlgButtons;
          					  HelpCtx      : Longint;
					            DefaultButton: TMsgDlgBtn;
                      CustomButtonCaptions: array of string): Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlg(Msg,
                                 DlgType,
                                 Buttons,
                                 HelpCtx,
                                 DefaultButton,
                                 CustomButtonCaptions);
    ContinueCounting;
  END;

  function MessageDlgPos(const Msg     : string;
                         DlgType       : TMsgDlgType;
                         Buttons       : TMsgDlgButtons;
			                   HelpCtx       : Longint;
					               X, Y          : Integer;
                         DefaultButton : TMsgDlgBtn;
					               TaskDlgFlags  : TTaskDialogFlags;
					               CustomButtonCaptions: array of string): Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPos(Msg,
                                    DlgType,
                                    Buttons,
                                    HelpCtx,
                                    X, Y,
                                    DefaultButton,
                                    TaskDlgFlags,
                                    CustomButtonCaptions);
    ContinueCounting;
  END;

  function MessageDlgPos(const Msg   : string;         DlgType : TMsgDlgType;
                         Buttons     : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y        : Integer;        TaskDlgFlags : TTaskDialogFlags): Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPos(Msg,
                                    DlgType,
                                    Buttons,
                                    HelpCtx,
                                    X, Y,
                                    TaskDlgFlags);
    ContinueCounting;
  END;

  function MessageDlgPos(const Msg   : string;         DlgType : TMsgDlgType;
                         Buttons     : TMsgDlgButtons; HelpCtx : Longint;
                         X, Y        : Integer;        DefaultButton: TMsgDlgBtn;
                         TaskDlgFlags: TTaskDialogFlags): Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPos(Msg,
                                    DlgType,
                                    Buttons,
                                    HelpCtx,
                                    X, Y,
                                    DefaultButton,
                                    TaskDlgFlags);
    ContinueCounting;
  END;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName: string;
                              TaskDlgFlags: TTaskDialogFlags) : Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPosHelp(Msg,
                                        DlgType,
                                        Buttons,
                                        HelpCtx,
                                        X, Y,
                                        HelpFileName,
                                        TaskDlgFlags);
    ContinueCounting;
  END;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName: string;
                              DefaultButton : TMsgDlgBtn; TaskDlgFlags: TTaskDialogFlags) : Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPosHelp(Msg,
                                        DlgType,
                                        Buttons,
                                        HelpCtx,
                                        X, Y,
                                        HelpFileName,
                                        DefaultButton,
                                        TaskDlgFlags);
    ContinueCounting;
  END;

  function MessageDlgPosHelp( const Msg : string;         DlgType : TMsgDlgType;
                              Buttons   : TMsgDlgButtons; HelpCtx : Longint;
                              X, Y      : Integer;  const HelpFileName : string;
                              DefaultButton : TMsgDlgBtn; TaskDlgFlags : TTaskDialogFlags;
                              CustomButtonCaptions : array of string) : Integer;
  BEGIN
    StopCounting;
    Result := Dialogs.MessageDlgPosHelp(Msg,
                                        DlgType,
                                        Buttons,
                                        HelpCtx,
                                        X, Y,
                                        HelpFileName,
                                        DefaultButton,
                                        TaskDlgFlags,
                                        CustomButtonCaptions);
    ContinueCounting;
  END;


  {$ENDIF }
{$ENDIF }

FUNCTION  DialogBoxIndirect( hInstance  : HINST; const lpDialogTemplate : TDlgTemplate;
                             hWndParent : HWND;        lpDialogFunc     : TFNDlgProc): Integer;
BEGIN
  StopCounting;
  Result := Windows.DialogBoxIndirect(hInstance, lpDialogTemplate, hWndParent, lpDialogFunc);
  ContinueCounting;
END;

FUNCTION  DialogBox( hInstance  : HINST; lpTemplate   : PChar;
                     hWndParent : HWND;  lpDialogFunc : TFNDlgProc): Integer;
BEGIN
  StopCounting;
  Result := Windows.DialogBox(hInstance, lpTemplate, hWndParent, lpDialogFunc);
  ContinueCounting;
END;

FUNCTION MessageBox ( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT ) : Integer;
BEGIN
  StopCounting;
  Result := Windows.MessageBox(hWnd, lpText, lpCaption, uType);
  ContinueCounting;
END;

FUNCTION MessageBoxEx ( hWnd : HWND; lpText, lpCaption: PChar; uType : UINT; lang : Word ) : Integer;
BEGIN
  StopCounting;
  Result := Windows.MessageBoxEx(hWnd, lpText, lpCaption, uType, lang);
  ContinueCounting;
END;

{$IFDEF PROFD2009ORBETTER }
FUNCTION  DialogBox( hInstance  : HINST; lpTemplate   : PAnsiChar;
                     hWndParent : HWND;  lpDialogFunc : TFNDlgProc): Integer;
BEGIN
  StopCounting;
  Result := Windows.DialogBoxA(hInstance, lpTemplate, hWndParent, lpDialogFunc);
  ContinueCounting;
END;

FUNCTION MessageBox ( hWnd : HWND; lpText, lpCaption: PAnsiChar; uType : UINT ) : Integer;
BEGIN
  StopCounting;
  Result := Windows.MessageBoxA(hWnd, lpText, lpCaption, uType);
  ContinueCounting;
END;

FUNCTION MessageBoxEx ( hWnd : HWND; lpText, lpCaption: PAnsiChar; uType : UINT; lang : Word ) : Integer;
BEGIN
  StopCounting;
  Result := Windows.MessageBoxExA(hWnd, lpText, lpCaption, uType, lang);
  ContinueCounting;
END;
{$ENDIF }

PROCEDURE Sleep( zeit : DWORD );
BEGIN
  StopCounting;
  Windows.Sleep(zeit);
  ContinueCounting;
END;

FUNCTION SleepEx( zeit : DWORD; alertable : BOOL ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.SleepEx(zeit, alertable);
  ContinueCounting;
END;
{$IFDEF UNICODE }
  FUNCTION SignalObjectAndWait ( h1, h2 : Cardinal;
                                 ms     : Cardinal;
                                 al     : LongBool) : Cardinal;
  BEGIN
    StopCounting;
    Result := Windows.SignalObjectAndWait(h1, h2, ms, al);
    ContinueCounting;
  END;
{$ELSE }
  FUNCTION SignalObjectAndWait ( h1, h2 : THandle;
                                 ms     : DWord;
                                 al     : BOOL) : BOOL;
  BEGIN
    StopCounting;
    Result := Windows.SignalObjectAndWait(h1, h2, ms, al);
    ContinueCounting;
  END;
{$ENDIF }

FUNCTION WaitForSingleObject ( h1     : THandle;
                               MS     : DWORD ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.WaitForSingleObject ( h1, MS );
  ContinueCounting;
END;

FUNCTION WaitForSingleObjectEx ( h1   : THandle;
                                 MS   : DWORD;
                                 al   : BOOL ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.WaitForSingleObjectEx (h1, MS, al);
  ContinueCounting;
END;

FUNCTION WaitForMultipleObjects ( ct  : DWORD;
                                  CONST pH : PWOHandleArray;
                                  wait     : BOOL;
                                  ms       : DWORD ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.WaitForMultipleObjects(ct, pH, wait, ms);
  ContinueCounting;
END;

FUNCTION WaitForMultipleObjectsEx ( ct  : DWORD;
                                    CONST pH : PWOHandleArray;
                                    wait     : BOOL;
                                    ms       : DWORD;
                                    al       : Boolean ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.WaitForMultipleObjectsEx(ct, pH, wait, ms, al);
  ContinueCounting;
END;

FUNCTION MsgWaitForMultipleObjects ( ct     : DWORD;
                                     VAR pHandles;
                                     wait   : BOOL;
                                     ms     : DWORD;
                                     wm     : DWORD ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.MsgWaitForMultipleObjects(ct, pHandles, wait, ms, wm);
  ContinueCounting;
END;

FUNCTION MsgWaitForMultipleObjectsEx ( ct     : DWORD;
                                       VAR pHandles;
                                       ms     : DWORD;
                                       wm     : DWORD;
                                       fl     : DWORD ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.MsgWaitForMultipleObjectsEx(ct, pHandles, ms, wm, fl);
  ContinueCounting;
END;

FUNCTION WaitCommEvent ( hd : THandle; VAR em : DWORD; lpo : POverlapped ) : BOOL;
BEGIN
  StopCounting;
  Result := Windows.WaitCommEvent(hd, em, lpo);
  ContinueCounting;
END;

FUNCTION WaitForInputIdle ( hp : THandle; ms : DWORD ) : DWORD;
BEGIN
  StopCounting;
  Result := Windows.WaitForInputIdle(hp, ms);
  ContinueCounting;
END;

FUNCTION WaitMessage : BOOL;
BEGIN
  StopCounting;
  Result := Windows.WaitMessage;
  ContinueCounting;
END;

{$IFDEF UNICODE }
FUNCTION WaitNamedPipe ( np : PWideChar; ms : Cardinal ) : BOOL;
BEGIN
  StopCounting;
  Result := Windows.WaitNamedPipe(np, ms);
  ContinueCounting;
END;
{$ELSE }
FUNCTION WaitNamedPipe ( np : PAnsiChar; ms : DWORD ) : BOOL;
BEGIN
  StopCounting;
  Result := Windows.WaitNamedPipe(np, ms);
  ContinueCounting;
END;
{$ENDIF }

{$IFNDEF ANSICODEVERSION }
PROCEDURE ProfSetComment( comm : String );
VAR
  comment  : Array[0..255] OF AnsiChar;
  commenta : AnsiString;
BEGIN
{$IFDEF VER130 }
  commenta := comm;
{$ELSE }
  commenta := UTF8Encode(comm);
{$ENDIF }
  StrPLCopy(comment, commenta, SizeOf(comment) DIV SizeOf(AnsiChar));
  ProfSetCommentA(comment);
END;
{$ENDIF }

PROCEDURE PomoExce;
VAR
  exnames : String;
{$IFDEF UNICODE }
  exnamea : UTF8String;
{$ENDIF }
  exname  : Array[0..199] OF Char;
  ExOb    : TObject;
BEGIN
  exname[0] := Char(0);
  ExOb := ExceptObject;
  IF Assigned(ExOb) THEN BEGIN
    IF ExceptObject IS Exception THEN BEGIN
      exnames := Exception(ExceptObject).Message;
{$IFNDEF UNICODE }
      StrPLCopy(exname, exnames, SizeOf(exname) DIV SizeOf(Char));
{$ELSE }
      exnamea := UTF8Encode(exnames);
      StrPLCopy(exname, exnamea, SizeOf(exname) DIV SizeOf(Char));
{$ENDIF }
    END;
  END;
  PomoExceStr(exname);
END;

INITIALIZATION
  IF ProfIsInitialised = 1 THEN BEGIN
    PruefeKompatibilitaet;
    IF ProfGlobalInit1 = TRUE THEN BEGIN
      CalcQPCTime802;
    END;
    ProfGlobalInit2(0);
    ProfSetComment('None');
{$IFNDEF CONSOLE }
    ProfintApplication := TProfIntApp.Create;
    ProcessMessages := ProfintApplication.ProcessMessages;
    HandleMessage   := ProfintApplication.HandleMessage;
{$ENDIF }
  END;
FINALIZATION
  IF ProfMustBeUnInitialised = 1 THEN BEGIN
    ProfSetComment('At finishing application');
    ProfAppendResults(TRUE);
    ProfUnInitTimer;
{$IFNDEF CONSOLE }
    ProfintApplication.Free;
{$ENDIF }
  END;
end.


