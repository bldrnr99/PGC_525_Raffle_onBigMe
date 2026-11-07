unit USB;

interface
Uses SysUtils, Forms, Windows;

{******************************************************************************}
{*                       USB - Read / Write Unit                              *}
{*                                                          *}
{*                                                                            *}
{*  How To USE:                                                               *}
{*  Sending and Reading Data to Device:                                       *}
{*  string_result:= RWUSB('DATA TO SEND IN HEX', Read, Timeout);              *}
{*                                                                            *}
{*  EXAMPLE (ONLY SENDING):                                                   *}
{*  s:= RWUSB('FF FF FF');                                                    *}
{*                                                                            *}
{*  s is String Result of Readed Data from Device                             *}
{*  'FF FF FF' is Data to Send in Hex  (this will send FFFFFF to Device       *}
{*                                                                            *}
{*                                                                            *}
{*  EXAMPLE WITH READING AFTER WRITING:                                       *}
{*  s:= RWUSB('FFFF', 16);                                                    *}
{*                                                                            *}
(*  16 = How mutch to Read / 0 for no Reading                                 *)
{*                                                                            *}
{*  EXAMPLE WITH TIMEOUT:                                                     *}
{*  s:= RWUSB('FFFF', 16, 100);                                               *}
{*                                                                            *}
{*  100 is the Reading Timeout, Standart is 500/ms.                           *}



type
TSetofChars = Set of Char;

  Function USBOpenDriver:boolean;
  Function USBCloseDriver:boolean;
  function USBReadText(BytesRead: cardinal; timeout: cardinal = 500): string;
  function USBReadHEX(BytesRead: cardinal; timeout: cardinal = 500): string;
  function RWUSB(frame: string; readLen:integer = 0; ReadTimeout: integer = 500; Typ : String = 'HEX') : string;
  procedure USBWriteHEX(frame: string);

implementation


{ Get Handle of DeviceDriver }
var USBPORT:Thandle = INVALID_HANDLE_VALUE;

{$HINTS OFF}
{ Open USB Driver }
Function USBOpenDriver:boolean;
begin
  // Open Device Path  \\?\USB#Vid_058b&Pid_0015#5&25ea51ff&0&1#{a5dcbf10-6530-11d2-901f-00c04fb951ed}
  USBPORT:= CreateFile('\\?\USB1', GENERIC_WRITE or GENERIC_READ,
  FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED OR FILE_ATTRIBUTE_NORMAL, 0);
  USBOpenDriver:= USBPORT <> INVALID_HANDLE_VALUE;
  if USBPORT = INVALID_HANDLE_VALUE then // error at open port
    begin
      result:=false;
    end else result:=true;
end;
{$HINTS ON}


Function USBCloseDriver:boolean;
begin
  USBCloseDriver := CloseHandle(USBPORT);
  USBPORT := INVALID_HANDLE_VALUE;
end;


function NurBestimmteZeichen (const aValue : String; aChars : TSetofChars) : String;
var
  i: Integer;
  newString : string;
begin
  newString := '';
  for i := 0 to Length(aValue) do
  begin
    if aValue[i] in aChars then
    begin
      newString := newString + aValue[i];
    end;
  end;
  result := newString;
end;


function HexToStr(H: String): String;
var I : Integer;
begin
  Result:= '';
  for I := 1 to length (H) div 2 do
    Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;

function StrToHex(const S: String): String;
const
  HexDigits: array[0..15] of Char = '0123456789ABCDEF';
var
  I: Integer;
  P1: PChar;
  P2: PChar;
  B: Byte;
begin

  SetLength(Result, Length(S) * 2);
  P1 := @S[1];
  P2 := @Result[1];

  for I := 1 to Length(S) do
  begin
    B := Byte(P1^);
    P2^ := HexDigits[B shr 4];
    Inc(P2);
    P2^ := HexDigits[B and $F];
    Inc(P1);
    Inc(P2);
  end;

end;



Function USBReadTEXT(BytesRead : dWord; timeout: cardinal = 500) : string;
var
  d: array[0..10000] of byte; {Readed Data}
  s, buffer: string;
  i, Tmp: Integer;
  Ovr : TOverlapped;
  count :cardinal; {Count = How mutch Readed Bytes}
begin
  Result := '';
  count:=0;
  Fillchar( d, sizeof(d), 0 );
  FillChar(Ovr, SizeOf(TOverlapped), 0);
  Ovr.hEvent := CreateEvent(nil, true, FALSE, nil);
  if not ReadFile(USBPORT, d, BytesRead, count, @ovr) then
    if GetLastError=Error_IO_Pending then
      if WaitForSingleObject(ovr.hEvent, timeout) = WAIT_OBJECT_0 then
        GetOverlappedResult(USBPORT, ovr, count, false)
  else CancelIo(USBPORT);
  CloseHandle(Ovr.hEvent);
  s := '';
  for i := 0 to count-1 do
  begin
    Tmp:=ord(d[i]);
    s := s + Char(Tmp);
  end;
  {Convert to String Text}
  s := strtohex(s);
  buffer:='';
  for i:=1 to length(s) do
  begin
    if Odd(i) then
    begin
      buffer := '';
      buffer := hextostr(s[i] + s[i+1]);
      buffer := NurBestimmteZeichen(buffer,['0'..'9','a'..'z','A'..'Z','.'..':',' '..'?']);
      result := result+buffer;
    end;
  end;
end;



Function USBReadHEX(BytesRead : dWord; timeout: cardinal = 500) : string;
var
  d: array[0..10000] of byte; {Readed Data}
  s: string;
  i, Tmp: Integer;
  Ovr : TOverlapped;
  count :cardinal; {Count = How mutch Readed Bytes}
begin
  Result := '';
  count:=0;
  Fillchar( d, sizeof(d), 0 );
  FillChar(Ovr, SizeOf(TOverlapped), 0);
  Ovr.hEvent := CreateEvent(nil, true, FALSE, nil);
  if not ReadFile(USBPORT, d, BytesRead, count, @ovr) then
    if GetLastError=Error_IO_Pending then
      if WaitForSingleObject(ovr.hEvent, timeout) = WAIT_OBJECT_0 then
        GetOverlappedResult(USBPORT, ovr, count, false)
  else CancelIo(USBPORT);
  CloseHandle(Ovr.hEvent);
  s := '';
  for i := 0 to count-1 do
  begin
    Tmp:=ord(d[i]);
    s := s + Char(Tmp);
  end;
  Result := strtohex(s);
end;



Function _USBWritePointerA(bp : Pointer; SizeToSend : DWord; timeout: integer) : Cardinal;
var
  Ovr : TOverlapped;
begin
    Result := 0;
    FillChar(Ovr, SizeOf(TOverlapped), 0);
    Ovr.hEvent := CreateEvent(nil, true, FALSE, nil);
    if not WriteFile(USBPort, bp^, SizeToSend, Result, @ovr) then
        if GetLastError=Error_IO_Pending then
            if WaitForSingleObject(ovr.hEvent, timeout) = WAIT_OBJECT_0 then
                GetOverlappedResult(USBPORT, ovr, Result, false)
            else CancelIo(USBPORT);
    CloseHandle(Ovr.hEvent);
end;



procedure USBWriteHEX(frame: string);
var
  BytesWritten: DWord;
begin
  while Pos(' ', FRAME) > 0 do Delete(FRAME,Pos(' ', FRAME),1);
  frame:=hextostr(frame);
  WriteFile(USBPORT, (Pchar(frame))^, SizeOf(frame), BytesWritten, nil);
end;




Function USBWritePointerA(bp : Pointer; SizeToSend : DWord) : boolean;
begin
  Result := _USBWritePointerA(bp, SizeToSend, $688) = SizeToSend;
end;



Function USBWriteStringA(SendString : String) : boolean;
var
  StrSize : Word;
begin
  StrSize := Length(SendString);
  Result := _USBWritePointerA(@SendString[1], StrSize, $688) = StrSize;
end;


function RWUSB(frame: string; readLen:integer = 0; ReadTimeout: integer = 500; Typ : String = 'HEX') : string;
begin
  while Pos(' ', FRAME) > 0 do Delete(FRAME,Pos(' ', FRAME),1);
  if length(frame) >0 then USBWriteStringA(hextostr(frame));
  Application.ProcessMessages;
  sleep(ReadTimeout);
  if (ReadLen >0) and (Typ='HEX')    then result:=USBReadHEX(readLen, ReadTimeout);
  if (ReadLen >0) and (Typ='STRING') then result:=USBReadText(readLen, ReadTimeout);
end;


end.
