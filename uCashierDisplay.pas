unit uCashierDisplay;

interface

uses
  System.SysUtils,
  Vcl.Graphics,
  AdvGrid; // or AdvStringGrid, depending on your component unit

procedure WriteCashierDisplay(AGrid: TAdvStringGrid; ADelete: Boolean;
  AFontColor: TColor; const ATxt: string; ARowIndex: Integer);

implementation

procedure WriteCashierDisplay(AGrid: TAdvStringGrid; ADelete: Boolean;
  AFontColor: TColor; const ATxt: string; ARowIndex: Integer);
begin
  if AGrid = nil then
    Exit;

  if ADelete then
  begin
    AGrid.Clear;
    AGrid.RowCount := 3;
  end;

  // (Optional safety)
  if (ARowIndex < 0) then Exit;
  if (ARowIndex >= AGrid.RowCount) then
    AGrid.RowCount := ARowIndex + 1;

  AGrid.CellProperties[0, ARowIndex].FontColor := AFontColor;
  AGrid.Cells[0, ARowIndex] := ATxt;
end;

end.

