unit uWriteCashierDisplay;

interface

uses
  System.SysUtils, System.StrUtils,
  Vcl.Graphics,
  AdvGrid, // or AdvStringGrid, depending on your component unit
  Winapi.Windows;

procedure WriteCashierDisplay(AGrid: TAdvStringGrid; ADelete: Boolean;
  AFontColor: TColor; const ATxt: string; ARowIndex: Integer);

implementation

uses Main, KeyBoard;

procedure WriteCashierDisplay(AGrid: TAdvStringGrid; ADelete: Boolean;
  AFontColor: TColor; const ATxt: string; ARowIndex: Integer);
begin
  OutputDebugString(PChar(Format('WriteCashierDisplay: AGrid=%p Name=%s',
    [Pointer(AGrid), IfThen(AGrid <> nil, AGrid.Name, '<nil>')])));

  if not Assigned(AGrid) then
    Exit;

  try
    if ADelete then
    begin
      AGrid.Clear;
      AGrid.RowCount := 3;
    end;

    AGrid.CellProperties[0, ARowIndex].FontColor := AFontColor;
    AGrid.Cells[0, ARowIndex] := ATxt;

    OutputDebugString(PChar('After set: ' + AGrid.Cells[0, ARowIndex]));
  except
    on E: Exception do
      OutputDebugString(PChar('WriteCashierDisplay EXCEPTION: ' + E.ClassName +
        ': ' + E.Message));
  end;

  AGrid.Invalidate;
end;

end.
