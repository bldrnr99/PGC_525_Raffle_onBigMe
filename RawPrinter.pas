unit RawPrinter;

interface

uses
  Winapi.Windows,
  Winapi.Winspool,
  System.SysUtils,
  System.Classes;

implementation

{ ---------------------------------------------------------------------------
  Send an AnsiString directly to the printer using the Win32 Spooler API }

uses Main;

function SendStringToPrinter(const PrinterName: string;
  const Data: AnsiString): Boolean;
var
  hPrinter: THandle;
  DocInfo: DOC_INFO_1A;
  BytesWritten: DWORD;
begin
  Result := False;
  if not OpenPrinter(PChar(PrinterName), hPrinter, nil) then
    Exit;
  try
    ZeroMemory(@DocInfo, SizeOf(DOC_INFO_1A));
    DocInfo.pDocName := 'Receipt';
    DocInfo.pDatatype := 'RAW';
    if StartDocPrinter(hPrinter, 1, @DocInfo) = 0 then
      Exit;
    try
      if not StartPagePrinter(hPrinter) then
        Exit;
      try
        Result := WritePrinter(hPrinter, PAnsiChar(Data), Length(Data),
          BytesWritten) and (BytesWritten = Cardinal(Length(Data)));
      finally
        EndPagePrinter(hPrinter);
      end;
    finally
      EndDocPrinter(hPrinter);
    end;
  finally
    ClosePrinter(hPrinter);
  end;
end;

{ ---------------------------------------------------------------------------
  Build a single AnsiString from a TStrings, appending CRLF on each line }
procedure PrintLinesRaw(const PrinterName: string; Lines: TStrings);
var
  i: Integer;
  Raw: AnsiString;
begin
  // Initialize printer (ESC @), then lines, then cut (GS V 1)
  Raw := AnsiString(#27 + '@');
  for i := 0 to Lines.Count - 1 do
    Raw := Raw + AnsiString(Lines[i]) + #13#10;
  Raw := Raw + AnsiString(#29 + 'V' + #1);

  if not SendStringToPrinter(PrinterName, Raw) then
    raise Exception.Create('Failed to send data to "' + PrinterName + '"');
end;

end.
