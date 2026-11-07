unit frmHandoverUnit;

{
  frmHandoverUnit.pas
  -------------------
  Shift handover form for dual-currency (CHF / EUR) bar POS system.

  Responsibilities:
    - Denomination entry for CHF cash and EUR cash
    - Live variance display with colour coding
    - Supervisor PIN override when variance exceeds tolerance
    - Calls TShiftManager.ProcessHandover atomically on confirmation

  Dependencies:
    - ShiftManagerUnit  : TShiftManager, TCashCount, TShiftTotals,
                          THandoverResult, THandoverType
    - ConfigUnit        : TConfig.GetLocalTillID, GetDayRateEURtoCHF
    - ElevateDB         : TEDBQuery (used only for staff combo and PIN lookup)

  Usage:
    frmHandover := TfrmHandover.Create(Self);
    try
      frmHandover.Initialise(ShiftManager, FromShiftID, TillID);
      if frmHandover.ShowModal = mrOk then
        // handover was committed
    finally
      frmHandover.Free;
    end;
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Grids, ComCtrls, ExtCtrls, Buttons,
  Math, StrUtils,
  EDBComps, EDBQuery,
  ShiftManagerUnit,   // TCashCount, TShiftTotals, THandoverResult, THandoverType
  ConfigUnit;         // GetLocalTillID, GetDayRateEURtoCHF, DB_NAME

{$REGION 'Constants'}
const
  // CHF denominations in descending order (notes then coins)
  CHF_DENOMS: array[0..11] of Currency = (
    1000.00, 200.00, 100.00, 50.00, 20.00, 10.00,
       5.00,   2.00,   1.00,  0.50,  0.20,  0.10
  );

  // EUR denominations accepted in Swiss bars
  // (0.20, 0.10, 0.05 coins typically not accepted)
  EUR_DENOMS: array[0..9] of Currency = (
    500.00, 200.00, 100.00, 50.00, 20.00, 10.00,
      5.00,   2.00,   1.00,  0.50
  );

  // Acceptable cash variance before supervisor override is required
  CHF_CASH_TOLERANCE = 1.00;
  EUR_CASH_TOLERANCE = 0.50;

  // StringGrid column indexes
  COL_DENOM = 0;
  COL_QTY   = 1;
  COL_TOTAL = 2;

  // Variance level thresholds (multiples of tolerance)
  WARN_FACTOR = 3.0;   // > 1x tolerance = warning (amber)
                        // > 3x tolerance = bad (red)

  // Colours
  CLR_OK      = $005C8A00;  // dark green
  CLR_WARN    = $0000A5FF;  // amber
  CLR_BAD     = clRed;
  CLR_PIN_OK  = $00C8FFC8;  // light green
  CLR_PIN_FAIL= $00C8C8FF;  // light red
{$ENDREGION}

type
  TfrmHandover = class(TForm)
    {--- Header ---}
    pnlHeader       : TPanel;
    lblTillLabel    : TLabel;
    lblTill         : TLabel;
    lblDateLabel    : TLabel;
    lblDateTime     : TLabel;
    lblFromLabel    : TLabel;
    cmbFromStaff    : TComboBox;
    lblToLabel      : TLabel;
    cmbToStaff      : TComboBox;
    lblSeparator    : TLabel;    // visual divider

    {--- Left: denomination entry ---}
    pnlLeft         : TPanel;
    pcCurrencies    : TPageControl;
      tsCHF         : TTabSheet;
        sgCHF       : TStringGrid;
        lblCHFTotal : TLabel;
      tsEUR         : TTabSheet;
        sgEUR       : TStringGrid;
        lblEURTotal : TLabel;

    {--- Right: summary ---}
    pnlSummary      : TPanel;
    lblSumTitle     : TLabel;

    // CHF cash row
    lblCHFExpLbl    : TLabel;
    lblCHFExp       : TLabel;
    lblCHFCntLbl    : TLabel;
    lblCHFCnt       : TLabel;
    lblCHFVarLbl    : TLabel;
    lblCHFVar       : TLabel;
    shpCHFStatus    : TShape;

    // EUR cash row
    lblEURExpLbl    : TLabel;
    lblEURExp       : TLabel;
    lblEURCntLbl    : TLabel;
    lblEURCnt       : TLabel;
    lblEURVarLbl    : TLabel;
    lblEURVar       : TLabel;
    shpEURStatus    : TShape;

    // Cards
    lblCardsTitle   : TLabel;
    lblCardExpLbl   : TLabel;
    lblCardExp      : TLabel;
    lblCardRefLbl   : TLabel;
    edCardBatch     : TEdit;    // barman types in terminal Z-total

    // Section titles and dividers (visual only, no code reference needed)
    lblCHFSecTitle  : TLabel;
    lblEURSecTitle  : TLabel;
    bvlCHFEUR       : TBevel;
    bvlEURCards     : TBevel;
    bvlGrand        : TBevel;
    lblGrandLbl     : TLabel;
    lblGrandTotal   : TLabel;
    lblDayRateNote  : TLabel;

    {--- Supervisor override (hidden when variance is OK) ---}
    pnlOverride     : TPanel;
    lblOverrideIcon : TLabel;   // "!" icon
    lblOverrideMsg  : TLabel;
    lblPINLbl       : TLabel;
    edSuperPIN      : TEdit;
    shpPINStatus    : TShape;
    lblReasonLbl    : TLabel;
    edReason        : TEdit;

    {--- Footer ---}
    pnlFooter       : TPanel;
    lblNotesLbl     : TLabel;
    edNotes         : TEdit;
    btnCancel       : TButton;
    btnProcess      : TButton;

    {--- Event handlers ---}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgCHFSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sgCHFSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgCHFKeyPress(Sender: TObject; var Key: Char);
    procedure sgEURSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sgEURSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgEURKeyPress(Sender: TObject; var Key: Char);
    procedure edCardBatchChange(Sender: TObject);
    procedure edCardBatchKeyPress(Sender: TObject; var Key: Char);
    procedure edSuperPINChange(Sender: TObject);
    procedure edSuperPINKeyPress(Sender: TObject; var Key: Char);
    procedure btnProcessClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmbToStaffChange(Sender: TObject);

  private
    FFromShiftID  : Integer;
    FTillID       : Integer;
    FTotals       : TShiftTotals;
    FShiftManager : TShiftManager;
    FVerifierID   : Integer;
    FPINValidated : Boolean;
    FLastHandoverResult : THandoverResult;

    procedure WMValidatePIN(var Msg: TMessage); message WM_APP + 1;

    {--- Grid helpers ---}
    procedure InitGrid(sg: TStringGrid;
      const Denoms: array of Currency;
      const CurrLabel: String);
    function  SumGrid(sg: TStringGrid;
      const Denoms: array of Currency): Currency;
    procedure RecalcGridRow(sg: TStringGrid;
      const Denoms: array of Currency; ARow: Integer);
    procedure GridKeyPressHandler(sg: TStringGrid; var Key: Char);
    procedure GridSelectCellHandler(sg: TStringGrid; ACol, ARow: Integer;
      var CanSelect: Boolean);

    {--- Summary and variance ---}
    procedure UpdateSummary;
    procedure UpdateVarianceLabel(lbl: TLabel; shp: TShape;
      Variance, Tolerance: Currency; const CurrCode: String);
    function  FormatVariance(V: Currency;
      const CurrCode: String): String;
    function  VarianceLevel(V, Tolerance: Currency): Integer;
      // returns 0=OK, 1=Warn, 2=Bad

    {--- Override panel ---}
    procedure CheckOverrideRequired;
    procedure ShowOverridePanel(const CHFVar, EURVar: Currency);
    procedure HideOverridePanel;
    procedure AttemptPINValidation;
    function  ValidateSupervisorPIN(const PIN: String): Integer;

    {--- Validation ---}
    function  IsOutOfTolerance: Boolean;
    function  CanProcess: Boolean;
    procedure UpdateProcessButton;

    {--- Data ---}
    procedure LoadStaffCombo;
    function  BuildCashCount: TCashCount;
    function  GetSelectedToStaffID: Integer;

    {--- Confirmation ---}
    procedure ShowHandoverConfirmation;

  public
    procedure Initialise(AShiftManager: TShiftManager;
      AFromShiftID, ATillID: Integer);

    property LastHandoverResult: THandoverResult read FLastHandoverResult;
  end;

var
  frmHandover: TfrmHandover;

implementation

{$R *.dfm}

uses
  EDBQuery;

{$REGION 'Form lifecycle'}

procedure TfrmHandover.FormCreate(Sender: TObject);
begin
  FFromShiftID  := 0;
  FTillID       := 0;
  FVerifierID   := 0;
  FPINValidated := False;

  // Grids are initialised in Initialise(), not here,
  // because they depend on knowing the currency context.
  // We just set safe defaults so the form can open without crashing.

  HideOverridePanel;

  edSuperPIN.PasswordChar := '*';
  edSuperPIN.MaxLength    := 4;

  edCardBatch.Text := '0.00';

  btnProcess.Enabled := False;
end;

procedure TfrmHandover.FormDestroy(Sender: TObject);
begin
  // FShiftManager is owned externally — do not free here
end;

procedure TfrmHandover.FormShow(Sender: TObject);
begin
  lblDateTime.Caption := FormatDateTime('dd.mm.yyyy   hh:nn', Now);

  // Put focus in the first editable grid cell
  pcCurrencies.ActivePage := tsCHF;
  if sgCHF.RowCount > 1 then
  begin
    sgCHF.Col := COL_QTY;
    sgCHF.Row := 1;
    sgCHF.SetFocus;
  end;
end;

{$ENDREGION}

{$REGION 'Public initialisation'}

procedure TfrmHandover.Initialise(AShiftManager: TShiftManager;
  AFromShiftID, ATillID: Integer);
var
  StaffID : Integer;
begin
  if not Assigned(AShiftManager) then
    raise Exception.Create('TfrmHandover.Initialise: ShiftManager not assigned');
  if AFromShiftID <= 0 then
    raise Exception.Create('TfrmHandover.Initialise: invalid FromShiftID');

  FShiftManager := AShiftManager;
  FFromShiftID  := AFromShiftID;
  FTillID       := ATillID;

  // Fetch expected totals for this shift
  FTotals := FShiftManager.GetShiftTotals(AFromShiftID);

  // Set header
  lblTill.Caption     := IntToStr(ATillID);
  lblDateTime.Caption := FormatDateTime('dd.mm.yyyy   hh:nn', Now);

  // Build staff combos
  LoadStaffCombo;

  // Lock From combo to the outgoing barman
  StaffID := FShiftManager.GetStaffIDForShift(AFromShiftID);
  cmbFromStaff.ItemIndex :=
    cmbFromStaff.Items.IndexOfObject(TObject(Pointer(StaffID)));
  cmbFromStaff.Enabled := False;

  // Set expected figures in summary
  lblCHFExp.Caption  := FormatCurr('0.00', FTotals.ExpectedCHFCash);
  lblEURExp.Caption  := FormatCurr('0.00', FTotals.ExpectedEURCash);
  lblCardExp.Caption := FormatCurr('0.00', FTotals.ExpectedCHFCards);

  // Build denomination grids
  InitGrid(sgCHF, CHF_DENOMS, 'CHF');
  InitGrid(sgEUR, EUR_DENOMS, 'EUR');

  UpdateSummary;
end;

{$ENDREGION}

{$REGION 'Staff combo'}

procedure TfrmHandover.LoadStaffCombo;
var
  qry : TEDBQuery;
begin
  cmbFromStaff.Items.Clear;
  cmbToStaff.Items.Clear;

  qry := TEDBQuery.Create(nil);
  try
    qry.DatabaseName := DB_NAME;
    qry.SQL.Text :=
      'SELECT StaffID, StaffName ' +
      'FROM Staff ' +
      'WHERE Active = TRUE ' +
      'ORDER BY StaffName';
    qry.Open;
    while not qry.Eof do
    begin
      cmbFromStaff.Items.AddObject(
        qry.FieldByName('StaffName').AsString,
        TObject(Pointer(qry.FieldByName('StaffID').AsInteger)));
      cmbToStaff.Items.AddObject(
        qry.FieldByName('StaffName').AsString,
        TObject(Pointer(qry.FieldByName('StaffID').AsInteger)));
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmHandover.cmbToStaffChange(Sender: TObject);
begin
  UpdateProcessButton;
end;

function TfrmHandover.GetSelectedToStaffID: Integer;
begin
  if cmbToStaff.ItemIndex < 0 then
    Result := 0
  else
    Result := Integer(Pointer(
      cmbToStaff.Items.Objects[cmbToStaff.ItemIndex]));
end;

{$ENDREGION}

{$REGION 'Grid setup and editing'}

procedure TfrmHandover.InitGrid(sg: TStringGrid;
  const Denoms: array of Currency;
  const CurrLabel: String);
var
  i: Integer;
begin
  sg.ColCount     := 3;
  sg.RowCount     := Length(Denoms) + 1;
  sg.FixedRows    := 1;
  sg.FixedCols    := 0;
  sg.DefaultRowHeight := 22;
  sg.Options      := sg.Options + [goEditing, goAlwaysShowEditor];

  // Column headers
  sg.Cells[COL_DENOM, 0] := CurrLabel;
  sg.Cells[COL_QTY,   0] := 'Qty';
  sg.Cells[COL_TOTAL, 0] := 'Total';

  // Column widths
  sg.ColWidths[COL_DENOM] := 85;
  sg.ColWidths[COL_QTY]   := 55;
  sg.ColWidths[COL_TOTAL] := 85;

  // Data rows
  for i := 0 to High(Denoms) do
  begin
    sg.Cells[COL_DENOM, i + 1] := FormatFloat('#,##0.00', Denoms[i]);
    sg.Cells[COL_QTY,   i + 1] := '0';
    sg.Cells[COL_TOTAL, i + 1] := '0.00';
  end;
end;

procedure TfrmHandover.GridSelectCellHandler(sg: TStringGrid;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // Only the Qty column is editable; everything else is read-only
  CanSelect := True;
  if ARow > 0 then
    sg.Options := sg.Options +
      IfThen(ACol = COL_QTY, [goEditing], []) - [goEditing]
  else
    Exclude(sg.Options, goEditing);
end;

procedure TfrmHandover.GridKeyPressHandler(sg: TStringGrid; var Key: Char);
begin
  // Only allow digits and backspace in the Qty column
  if sg.Col = COL_QTY then
  begin
    if not (Key in ['0'..'9', #8]) then
      Key := #0;
  end
  else
    Key := #0;  // block typing outside Qty column
end;

procedure TfrmHandover.sgCHFSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  GridSelectCellHandler(sgCHF, ACol, ARow, CanSelect);
end;

procedure TfrmHandover.sgCHFKeyPress(Sender: TObject; var Key: Char);
begin
  GridKeyPressHandler(sgCHF, Key);
end;

procedure TfrmHandover.sgEURSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  GridSelectCellHandler(sgEUR, ACol, ARow, CanSelect);
end;

procedure TfrmHandover.sgEURKeyPress(Sender: TObject; var Key: Char);
begin
  GridKeyPressHandler(sgEUR, Key);
end;

procedure TfrmHandover.RecalcGridRow(sg: TStringGrid;
  const Denoms: array of Currency; ARow: Integer);
var
  Qty     : Integer;
  LineAmt : Currency;
begin
  if (ARow < 1) or (ARow > High(Denoms) + 1) then Exit;

  Qty     := Max(0, StrToIntDef(sg.Cells[COL_QTY, ARow], 0));
  LineAmt := Denoms[ARow - 1] * Qty;

  // Write back a clean Qty (strips negatives or non-numeric input)
  sg.Cells[COL_QTY,   ARow] := IntToStr(Qty);
  sg.Cells[COL_TOTAL, ARow] := FormatFloat('0.00', LineAmt);
end;

procedure TfrmHandover.sgCHFSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
begin
  if ACol <> COL_QTY then Exit;
  RecalcGridRow(sgCHF, CHF_DENOMS, ARow);
  UpdateSummary;
end;

procedure TfrmHandover.sgEURSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
begin
  if ACol <> COL_QTY then Exit;
  RecalcGridRow(sgEUR, EUR_DENOMS, ARow);
  UpdateSummary;
end;

function TfrmHandover.SumGrid(sg: TStringGrid;
  const Denoms: array of Currency): Currency;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Denoms) do
    Result := Result + StrToCurrDef(sg.Cells[COL_TOTAL, i], 0);
end;

{$ENDREGION}

{$REGION 'Card batch entry'}

procedure TfrmHandover.edCardBatchKeyPress(Sender: TObject;
  var Key: Char);
begin
  // Allow digits, one decimal point, and backspace only
  if Key = '.' then
  begin
    if Pos('.', edCardBatch.Text) > 0 then
      Key := #0;  // already has a decimal point
  end
  else if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmHandover.edCardBatchChange(Sender: TObject);
begin
  UpdateSummary;
end;

{$ENDREGION}

{$REGION 'Summary and variance display'}

procedure TfrmHandover.UpdateSummary;
var
  CHFCounted : Currency;
  EURCounted : Currency;
  CHFVar     : Currency;
  EURVar     : Currency;
begin
  CHFCounted := SumGrid(sgCHF, CHF_DENOMS);
  EURCounted := SumGrid(sgEUR, EUR_DENOMS);
  CHFVar     := CHFCounted - FTotals.ExpectedCHFCash;
  EURVar     := EURCounted - FTotals.ExpectedEURCash;

  // Grid running totals
  lblCHFTotal.Caption := 'Total:  CHF ' + FormatCurr('0.00', CHFCounted);
  lblEURTotal.Caption := 'Total:  EUR ' + FormatCurr('0.00', EURCounted);

  // Summary panel — counted rows
  lblCHFCnt.Caption := FormatCurr('0.00', CHFCounted);
  lblEURCnt.Caption := FormatCurr('0.00', EURCounted);

  // Variance rows with colour
  UpdateVarianceLabel(lblCHFVar, shpCHFStatus,
    CHFVar, CHF_CASH_TOLERANCE, 'CHF');
  UpdateVarianceLabel(lblEURVar, shpEURStatus,
    EURVar, EUR_CASH_TOLERANCE, 'EUR');

  // Grand total in CHF equivalent (informational)
  lblGrandTotal.Caption := FormatCurr('CHF 0.00',
    CHFCounted
    + (EURCounted * GetDayRateEURtoCHF)
    + StrToCurrDef(edCardBatch.Text, 0));

  CheckOverrideRequired;
  UpdateProcessButton;
end;

procedure TfrmHandover.UpdateVarianceLabel(lbl: TLabel; shp: TShape;
  Variance, Tolerance: Currency; const CurrCode: String);
var
  Level : Integer;
  Clr   : TColor;
begin
  lbl.Caption := FormatVariance(Variance, CurrCode);

  Level := VarianceLevel(Variance, Tolerance);
  case Level of
    0: Clr := CLR_OK;
    1: Clr := CLR_WARN;
  else  Clr := CLR_BAD;
  end;

  lbl.Font.Color  := Clr;
  lbl.Font.Style  := [fsBold];
  shp.Brush.Color := Clr;
  shp.Pen.Color   := Clr;
end;

function TfrmHandover.FormatVariance(V: Currency;
  const CurrCode: String): String;
begin
  if V > 0 then
    Result := CurrCode + ' +' + FormatCurr('0.00', V)
  else if V < 0 then
    Result := CurrCode + ' '  + FormatCurr('0.00', V)  // minus included
  else
    Result := CurrCode + '  0.00  ✓';
end;

function TfrmHandover.VarianceLevel(V, Tolerance: Currency): Integer;
var
  Abs_V: Currency;
begin
  Abs_V := Abs(V);
  if Abs_V <= Tolerance then
    Result := 0           // OK
  else if Abs_V <= Tolerance * WARN_FACTOR then
    Result := 1           // Warning
  else
    Result := 2;          // Bad — supervisor required
end;

{$ENDREGION}

{$REGION 'Supervisor override panel'}

function TfrmHandover.IsOutOfTolerance: Boolean;
var
  CHFVar, EURVar: Currency;
begin
  CHFVar := SumGrid(sgCHF, CHF_DENOMS) - FTotals.ExpectedCHFCash;
  EURVar := SumGrid(sgEUR, EUR_DENOMS) - FTotals.ExpectedEURCash;
  Result := (Abs(CHFVar) > CHF_CASH_TOLERANCE)
         or (Abs(EURVar) > EUR_CASH_TOLERANCE);
end;

procedure TfrmHandover.CheckOverrideRequired;
var
  CHFVar, EURVar: Currency;
begin
  CHFVar := SumGrid(sgCHF, CHF_DENOMS) - FTotals.ExpectedCHFCash;
  EURVar := SumGrid(sgEUR, EUR_DENOMS) - FTotals.ExpectedEURCash;

  if IsOutOfTolerance then
  begin
    if not pnlOverride.Visible then
      ShowOverridePanel(CHFVar, EURVar);
  end
  else
  begin
    if pnlOverride.Visible then
      HideOverridePanel;
  end;
end;

procedure TfrmHandover.ShowOverridePanel(const CHFVar, EURVar: Currency);
var
  Msg: String;
begin
  Msg := 'Variance outside tolerance:';
  if Abs(CHFVar) > CHF_CASH_TOLERANCE then
    Msg := Msg + Format('  CHF %s', [FormatVariance(CHFVar, '')]);
  if Abs(EURVar) > EUR_CASH_TOLERANCE then
    Msg := Msg + Format('  EUR %s', [FormatVariance(EURVar, '')]);
  Msg := Msg + '  —  supervisor authorisation required.';

  lblOverrideMsg.Caption := Msg;

  // Reset override state
  edSuperPIN.Text  := '';
  edSuperPIN.Color := clWindow;
  edReason.Text    := '';
  FVerifierID      := 0;
  FPINValidated    := False;

  pnlOverride.Visible := True;

  // Update shape indicator
  shpPINStatus.Brush.Color := clSilver;
  shpPINStatus.Pen.Color   := clGray;
end;

procedure TfrmHandover.HideOverridePanel;
begin
  pnlOverride.Visible := False;
  FVerifierID         := 0;
  FPINValidated       := False;
end;

procedure TfrmHandover.edSuperPINKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
  begin
    Key := #0;
    Exit;
  end;

  // Auto-validate once 4th digit is typed
  if (Key <> #8) and (Length(edSuperPIN.Text) = 3) then
    // Post to avoid modifying the edit while it is processing a keystroke
    PostMessage(Handle, WM_APP + 1, 0, 0);
end;

// Custom message handler for deferred PIN validation
// Declare in the private section:
//   procedure WMValidatePIN(var Msg: TMessage); message WM_APP + 1;
procedure TfrmHandover.WMValidatePIN(var Msg: TMessage);
begin
  AttemptPINValidation;
end;

procedure TfrmHandover.edSuperPINChange(Sender: TObject);
begin
  // Reset validation state if the user edits the PIN after validation
  if FPINValidated then
  begin
    FPINValidated        := False;
    FVerifierID          := 0;
    edSuperPIN.Color     := clWindow;
    shpPINStatus.Brush.Color := clSilver;
    UpdateProcessButton;
  end;
end;

procedure TfrmHandover.AttemptPINValidation;
var
  VerID: Integer;
begin
  VerID := ValidateSupervisorPIN(edSuperPIN.Text);

  if VerID > 0 then
  begin
    FVerifierID              := VerID;
    FPINValidated            := True;
    edSuperPIN.Color         := CLR_PIN_OK;
    shpPINStatus.Brush.Color := clGreen;
    shpPINStatus.Pen.Color   := clGreen;
  end
  else
  begin
    FVerifierID              := 0;
    FPINValidated            := False;
    edSuperPIN.Color         := CLR_PIN_FAIL;
    shpPINStatus.Brush.Color := CLR_BAD;
    shpPINStatus.Pen.Color   := CLR_BAD;
    edSuperPIN.SelectAll;
    // Brief visual flash then reset colour
    Application.ProcessMessages;
    Sleep(600);
    edSuperPIN.Color := clWindow;
    edSuperPIN.Text  := '';
  end;

  UpdateProcessButton;
end;

function TfrmHandover.ValidateSupervisorPIN(
  const PIN: String): Integer;
begin
  Result := 0;
  if Length(PIN) < 4 then Exit;

  with TEDBQuery.Create(nil) do
  try
    DatabaseName := DB_NAME;
    SQL.Text :=
      'SELECT StaffID FROM Staff ' +
      'WHERE PIN = :pin ' +
      '  AND Role IN (''SUP'', ''MGR'') ' +
      '  AND Active = TRUE';
    ParamByName('pin').AsString := PIN;
    Open;
    if not IsEmpty then
      Result := FieldByName('StaffID').AsInteger;
  finally
    Free;
  end;
end;

{$ENDREGION}

{$REGION 'Validation and process button'}

function TfrmHandover.CanProcess: Boolean;
var
  ToStaffOK      : Boolean;
  OverrideOK     : Boolean;
begin
  // Must have selected an incoming barman
  ToStaffOK  := GetSelectedToStaffID > 0;

  // If out of tolerance, need both valid PIN and a reason
  if IsOutOfTolerance then
    OverrideOK := FPINValidated
               and (Trim(edReason.Text) <> '')
  else
    OverrideOK := True;  // no override needed

  Result := ToStaffOK and OverrideOK;
end;

procedure TfrmHandover.UpdateProcessButton;
begin
  btnProcess.Enabled := CanProcess;
end;

{$ENDREGION}

{$REGION 'Building the cash count'}

function TfrmHandover.BuildCashCount: TCashCount;
var
  i: Integer;
begin
  SetLength(Result.CHF, Length(CHF_DENOMS));
  for i := 0 to High(CHF_DENOMS) do
  begin
    Result.CHF[i].Currency := curCHF;
    Result.CHF[i].Value    := CHF_DENOMS[i];
    Result.CHF[i].Quantity :=
      Max(0, StrToIntDef(sgCHF.Cells[COL_QTY, i + 1], 0));
  end;

  SetLength(Result.EUR, Length(EUR_DENOMS));
  for i := 0 to High(EUR_DENOMS) do
  begin
    Result.EUR[i].Currency := curEUR;
    Result.EUR[i].Value    := EUR_DENOMS[i];
    Result.EUR[i].Quantity :=
      Max(0, StrToIntDef(sgEUR.Cells[COL_QTY, i + 1], 0));
  end;
end;

{$ENDREGION}

{$REGION 'Process handover'}

procedure TfrmHandover.btnProcessClick(Sender: TObject);
var
  Count      : TCashCount;
  NewStaffID : Integer;
  ConfirmMsg : String;
begin
  if not CanProcess then Exit;

  NewStaffID := GetSelectedToStaffID;

  // Confirmation dialog
  ConfirmMsg :=
    Format('Confirm handover on Till %d' + sLineBreak +
           'From:  %s' + sLineBreak +
           'To:    %s' + sLineBreak + sLineBreak +
           'CHF Cash counted:  %s' + sLineBreak +
           'EUR Cash counted:  %s' + sLineBreak +
           'Card batch total:  %s',
           [FTillID,
            cmbFromStaff.Text,
            cmbToStaff.Text,
            FormatCurr('CHF 0.00', SumGrid(sgCHF, CHF_DENOMS)),
            FormatCurr('EUR 0.00', SumGrid(sgEUR, EUR_DENOMS)),
            FormatCurr('CHF 0.00', StrToCurrDef(edCardBatch.Text, 0))]);

  if IsOutOfTolerance then
    ConfirmMsg := ConfirmMsg + sLineBreak + sLineBreak +
      '⚠  Variance override authorised by supervisor.';

  if MessageDlg(ConfirmMsg, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Count := BuildCashCount;

  Screen.Cursor := crHourGlass;
  try
    try
      FLastHandoverResult := FShiftManager.ProcessHandover(
        FFromShiftID,
        NewStaffID,
        Count,
        StrToCurrDef(edCardBatch.Text, 0),  // CardBatchAmountCHF
        '',                                  // CardBatchRef (extend if needed)
        htHandover,
        edNotes.Text,
        FVerifierID                          // 0 when no override needed
      );
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg(
        'Handover could not be completed.' + sLineBreak + sLineBreak +
        E.Message,
        mtError, [mbOk], 0);
      Exit;
    end;
  end;

  ShowHandoverConfirmation;
  ModalResult := mrOk;
end;

procedure TfrmHandover.ShowHandoverConfirmation;
var
  Msg : String;
  R   : THandoverResult;
begin
  R := FLastHandoverResult;

  Msg :=
    'Handover recorded successfully.' + sLineBreak + sLineBreak +
    Format('CHF Cash  expected: %s   counted: %s   variance: %s',
      [FormatCurr('0.00', R.ExpectedCHFCash),
       FormatCurr('0.00', R.CountedCHFCash),
       FormatVariance(R.VarianceCHFCash, 'CHF')]) + sLineBreak +
    Format('EUR Cash  expected: %s   counted: %s   variance: %s',
      [FormatCurr('0.00', R.ExpectedEURCash),
       FormatCurr('0.00', R.CountedEURCash),
       FormatVariance(R.VarianceEURCash, 'EUR')]);

  if FVerifierID > 0 then
    Msg := Msg + sLineBreak + sLineBreak +
      'Supervisor override applied.';

  ShowMessage(Msg);
end;

procedure TfrmHandover.btnCancelClick(Sender: TObject);
begin
  if MessageDlg(
    'Cancel handover? No changes will be saved.',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrCancel;
end;

{$ENDREGION}

end.
