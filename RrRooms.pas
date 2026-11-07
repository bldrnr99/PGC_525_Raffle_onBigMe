UNIT RrRooms;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, System.StrUtils, System.Generics.Collections, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvExComCtrls,
  JvDBTreeView, AdvGlassButton, Vcl.DBCGrids, AdvUtil, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Data.DB, edbcomps, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, JvExExtCtrls, JvImage,
  Vcl.Touch.GestureMgr, Math, DateUtils, Vcl.Mask, DBCtrlsEh, AdvSmoothSlider,
  DBAdvSmoothSlider,
  Vcl.Menus, AdvMenus, AdvGroupBox, JvShape,
  AdvSmoothTabPager, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, EhLibVclUtils, asgcheck,
  AsgSpellCheck, AdvOfficeButtons, RzButton, RzRadChk;

TYPE
  TRR_Rooms = CLASS(TForm)
    AdvSmoothTabPager1: TAdvSmoothTabPager;
    AdvSmoothTabPager11: TAdvSmoothTabPage;
    AdvSmoothTabPager12: TAdvSmoothTabPage;
    AdvStringGrid1: TAdvStringGrid;
    img_CheckIN: TJvImage;
    lb_Checkin: TLabel;
    JvShape1: TJvShape;
    JvShape2: TJvShape;
    lb_CheckOut: TLabel;
    img_CheckOut: TJvImage;
    Label5: TLabel;
    Label4: TLabel;
    dbgd_Bookings: TDBGridEh;
    rg_CheckOutDate: TAdvOfficeRadioGroup;

    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE ChangeSelectionColor(cGrid: TDBCtrlGrid; color: TColor);

    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE CreateDragCursor(CONST Text: STRING);
    FUNCTION BitmapToIconHandle(Bitmap: TBitmap): HICON;
    PROCEDURE MoveCursorToCellByValue(CONST TargetValue: STRING);
    PROCEDURE FillRoomGrid;
    PROCEDURE AdvStringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE AdvStringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; VAR Accept: Boolean);
    PROCEDURE AdvStringGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    PROCEDURE AdvStringGrid1GetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    PROCEDURE AdvStringGrid1CanClickCell(Sender: TObject; ARow, ACol: Integer;
      VAR Allow: Boolean);
    PROCEDURE AdvStringGrid1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      VAR HAlign: TAlignment; VAR VAlign: TVAlignment);
    PROCEDURE AdvStringGrid1CheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    PROCEDURE AdvStringGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      VAR CanEdit: Boolean);
    FUNCTION RegisterCheckIN(Guest: Integer; bID, aId, rID, bedID: STRING;
      sOcc, shortTerm: Boolean): Boolean;
    FUNCTION RegisterCheckOut(Guest: Integer; bookingID: STRING;
      deleteBooking: Boolean): Boolean;
    PROCEDURE img_CheckINMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE img_CheckOutDragDrop(Sender, Source: TObject; X, Y: Integer);
    PROCEDURE img_CheckOutDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; VAR Accept: Boolean);
    FUNCTION CheckIfHasBooking: Boolean;
    PROCEDURE AdvStringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      VAR CanSelect: Boolean);
    PROCEDURE JvShape1MouseLeave(Sender: TObject);
    PROCEDURE AdvStringGrid1DblClickCell(Sender: TObject; ARow, ACol: Integer);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE AdvSmoothTabPager1Changing(Sender: TObject;
      FromPage, ToPage: Integer; VAR AllowChange: Boolean);
    PROCEDURE rg_CheckOutDateClick(Sender: TObject);
    PROCEDURE dbgd_BookingsTitleClick(Column: TColumnEh);
    PROCEDURE UpdateBookingsDBGrid(s1, s2: STRING);
    function GenerateBookingID(BuildingID, ApartmentID, RoomID,
      bedID: Integer): string;
    function AskCheckInOptions(const GuestName: string;
      out SingleOcc, shortTerm: Boolean): Boolean;
    function FindFirstFreeBed(ARow: Integer): Integer;
    function GetOpenBookingID(GuestID: Integer): string;
    procedure DoCheckInToGridRow(ARow: Integer);

    {
      TYPE
      TClientR = RECORD
      ID, entrySubFeeID, cardID: Integer;
      fName, lName, alias, Address, Cap, City, SIMIC, IDTeseu, Permit, clType,
      room, iban: STRING;
      InHouse, Enabled, NettoFee, Taxed, SleepsHere: Boolean;
      bdate: TDate;
      lstTaxDate: TDateTime;
      balanceDue: Double;
      END;
    }

  TYPE
    TBooking = RECORD
      GuestID, bookingID, BuildingID, ApartmentID, RoomID, bedID: Integer;
      singleOccupancy, reemboursment: Boolean;
      checkInDt, checkOutDt, DepositINdt: TDate;
      depositAmtPayed, roomRateToPay: Double;
      Address, alias, depositPayMethod, txID: STRING;
    END;

  TYPE
    TRentalD = RECORD
      Description: STRING;
      TotalRentToPayCHF, TotalRentToPayEuro: Double;
      DaysToPay: Integer;
      PayedUntilDate, ToPayUntilDate: TDate;
    END;

  PRIVATE
    { Private declarations }
    FDragCol, FDragRow: Integer;
    orderBy, whereS: STRING;

    FLoadingGrid: Boolean;
    FUNCTION GetBedCountForRow(CONST ARow: Integer): Integer;

  PUBLIC
    { Public declarations }
  Var
    // ThisClientR: TClientR;
    ThisTaxDate: TDateTime;
    RentalDataR: TRentalD;
    // ThisBookingR: TBooking;

  END;

VAR
  RR_Rooms: TRR_Rooms;
  P: TPoint;
  dragAlias: STRING;
  tgtCol, tgtRow: Integer;
  deleteBooking: Boolean;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main, Notes, uClientStore;

PROCEDURE TRR_Rooms.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  lb_Checkin.Caption := '';
  lb_CheckOut.Caption := '';
END;

PROCEDURE TRR_Rooms.FormCreate(Sender: TObject);
BEGIN
  lb_Checkin.DragMode := dmManual;
  img_CheckIN.OnMouseDown := img_CheckINMouseDown;
  // CheckOut label just receives drops:
  img_CheckOut.OnDragOver := img_CheckOutDragOver;
  img_CheckOut.OnDragDrop := img_CheckOutDragDrop;
  RR_Rooms.Visible := False;
END;

PROCEDURE TRR_Rooms.FormShow(Sender: TObject);
var
  ci: String;
BEGIN
  With Form1 do
  begin
    If InRange(uClientStore.ThisCard.cardID, 3000, 5999) Then
    begin
      If ThisBooking.checkInDt = 0 Then
        ci := 'Nessun check in - '
      else
        ci := DateTimeToStr(ThisBooking.checkInDt);

      nnWriteCashierDisplay(0, True, clWhite, uClientStore.ThisClient.alias +
        ' ' + IntToStr(uClientStore.ThisClient.cardID), 0);
      nnWriteCashierDisplay(0, False, clWhite, 'CheckIn il: ' + ci, 1);
      nnWriteCashierDisplay(0, False, clYellow, 'Saldo affitti scoperti: ' +
        FormatFloat('#,##0.00', RentalData.TotalFeeCHF +
        RentalData.TotalShortTerm + RentalData.TotalSingle) + ' CHF', 2);
    end
    else
      nnWriteCashierDisplay(0, True, clWhite,
        'Tessera: ' + IntToStr(uClientStore.ThisCard.cardID), 0);
  end;
  whereS := ' WHERE CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
    QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)) + ' ';
  IF InRange(uClientStore.ThisClient.cardID, 3000, 5999) AND
    NOT(CheckIfHasBooking) THEN
  BEGIN
    lb_Checkin.Caption := uClientStore.ThisClient.alias + #13#10 +
      'Pronta per Check IN';
    img_CheckIN.Enabled := True;
  END
  ELSE
  BEGIN
    lb_Checkin.Caption := '';
    img_CheckIN.Enabled := False;
  END;
  img_CheckOut.State := stDisabled;
  AdvStringGrid1.DragMode := dmManual;
  FillRoomGrid;
  AdvSmoothTabPager1.ActivePageIndex := 0;
END;

function TRR_Rooms.FindFirstFreeBed(ARow: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i := 4 to 7 do
  begin
    if (AdvStringGrid1.Cells[i, ARow] = '') and
      (AdvStringGrid1.Colors[i, ARow] <> $00363636) and
      (AdvStringGrid1.Colors[i, ARow] <> clBlack) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TRR_Rooms.GetOpenBookingID(GuestID: Integer): string;
begin
  Result := '';

  with Form2.qy_Tmp do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT BookingID FROM RREU_Bookings ' + 'WHERE GuestID = :GuestID '
      + 'AND (CheckOutDate IS NULL OR CheckOutDate > CURRENT_TIMESTAMP)');

    ParamByName('GuestID').AsInteger := GuestID;

    Open;

    if not IsEmpty then
      Result := FieldByName('BookingID').AsString;
  end;
end;

procedure TRR_Rooms.DoCheckInToGridRow(ARow: Integer);
var
  BedCol: Integer;
  bedID: Integer;
  SingleOcc: Boolean;
  shortTerm: Boolean;
  bookingID: string;
begin
  if lb_Checkin.Caption = '' then
    Exit;

  if not AskCheckInOptions(uClientStore.ThisClient.alias, SingleOcc, shortTerm)
  then
    Exit;

  BedCol := FindFirstFreeBed(ARow);

  if BedCol = -1 then
  begin
    MessageDlg('Non ci sono letti disponibili in questa stanza!', mtError,
      [mbOK], 0);
    Exit;
  end;

  bedID := BedCol - 3;

  RegisterCheckIN(uClientStore.ThisClient.ID, AdvStringGrid1.Cells[13, ARow],
    // BuildingID
    AdvStringGrid1.Cells[14, ARow], // ApartmentID
    AdvStringGrid1.Cells[3, ARow], // RoomID
    IntToStr(bedID), SingleOcc, shortTerm);

  bookingID := GetOpenBookingID(uClientStore.ThisClient.ID);

  AdvStringGrid1.Cells[BedCol, ARow] := uClientStore.ThisClient.alias;
  AdvStringGrid1.Cells[BedCol + 5, ARow] := bookingID;

  lb_Checkin.Caption := '';
  lb_CheckOut.Caption := '';
  img_CheckIN.Enabled := False;
  JvShape1.Pen.color := clGreen;
end;

FUNCTION TRR_Rooms.CheckIfHasBooking: Boolean;
BEGIN
  WITH Form2.qy_Tmp DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT GuestID FROM RREU_Bookings WHERE GuestID = ' +
      IntToStr(uClientStore.ThisClient.ID) +
      ' AND CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)));
    Active := True;
    IF RecordCount > 0 THEN
      Result := True
    ELSE
      Result := False;
  END;
END;

function TRR_Rooms.GenerateBookingID(BuildingID, ApartmentID, RoomID,
  bedID: Integer): string;
begin
  Result := Format('%.2d-%.2d-%.2d-%.2d', [BuildingID, ApartmentID,
    RoomID, bedID]);
end;

FUNCTION TRR_Rooms.RegisterCheckIN(Guest: Integer; bID, aId, rID, bedID: STRING;
  sOcc, shortTerm: Boolean): Boolean;
VAR
  // s: STRING;
  SupShortTermSQL: string;
  SupSingleSQL: String;
BEGIN
  Result := False;
  // s := BoolToStr(sOcc, True);
  Var
  bookStatus := GenerateBookingID(StrToInt(bID), StrToInt(aId), StrToInt(rID),
    StrToInt(bedID));
  TRY
    WITH Form2.qy_Tmp DO
    BEGIN
      if Active then
        Close;

      if shortTerm then
        SupShortTermSQL := 'rr.SupShortTerm'
      else
        SupShortTermSQL := '0';

      if sOcc then
        SupSingleSQL := 'rr.SupSingle'
      else
        SupSingleSQL := '0';

      SQL.Clear;

      SQL.Add('INSERT INTO RREU_Bookings ' +
        '(Data, CheckInDate, GuestID, SingleOccupancy, RoomRate, ' +
        'SupSingleRoom, SupShortTerm, BookingStatus) ' +
        'SELECT CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ' + IntToStr(Guest) + ', '
        + IntToStr(Ord(sOcc)) + ', ' + 'rr.FeeCHF, ' + SupSingleSQL + ', ' +
        SupShortTermSQL + ', ' + QuotedStr(bookStatus) + ' ' +
        'FROM RREU_RentalRooms rr ' + 'WHERE rr.BuildingID = :BuildingID ' +
        'AND rr.ApartmentID = :ApartmentID ' + 'AND rr.RoomID = :RoomID ' +
        'AND rr.BedID = :BedID');

      ParamByName('BuildingID').AsInteger := StrToInt(bID);
      ParamByName('ApartmentID').AsInteger := StrToInt(aId);
      ParamByName('RoomID').AsInteger := StrToInt(rID);
      ParamByName('BedID').AsInteger := StrToInt(bedID);

      ExecSQL;
      Close;
      SQL.Clear;
      // Update Rental Rooms table with new booking id
      SQL.Add('UPDATE RREU_RentalRooms ' + 'SET BookingID = ( ' +
        '  SELECT MAX(BookingID) ' + '  FROM RREU_Bookings ' +
        '  WHERE GuestID = ' + IntToStr(Guest) + ' ' + ') ' +
        'WHERE BuildingID = ' + bID + ' AND ' + 'ApartmentID = ' + aId + ' AND '
        + 'RoomID = ' + rID + ' AND ' + 'BedID = ' + bedID);
      ExecSQL;
      Close;
      // Update Clients InHouse field
      SQL.Clear;
      // Set Rental room table's bookingID to null (deprecated InHouse)
      SQL.Add('UPDATE Clients SET InHouse = True ' + 'WHERE ID = ' +
        IntToStr(Guest));
      ExecSQL;
      Close;
    END;
  FINALLY
    Result := True;
  END;
END;

FUNCTION TRR_Rooms.RegisterCheckOut(Guest: Integer; bookingID: STRING;
  deleteBooking: Boolean): Boolean;
BEGIN
  Result := False;
  TRY
    WITH Form2.qy_Tmp2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      // Set Bookings table's checkout date to now
      IF deleteBooking THEN
        SQL.Add('DELETE FROM RREU_Bookings ' + 'WHERE BookingID = ' + bookingID
          + ' AND GuestID = ' + IntToStr(Guest))
      ELSE
        SQL.Add('UPDATE RREU_Bookings SET Data = CURRENT_TIMESTAMP, ' +
          ' PayedUntilDate = CURRENT_DATE, ' + ' CheckOutDate = CURRENT_Date ' +
          ' WHERE BookingID = ' + bookingID + ' AND GuestID = ' +
          IntToStr(Guest) + ' AND CheckOutDate IS NULL');
      ExecSQL;
      Close;
      IF Active THEN
        Close;
      SQL.Clear;
      // Set Rental room table's bookingID to null
      SQL.Add('UPDATE RREU_RentalRooms SET BookingID = NULL ' +
        'WHERE BookingID = ' + bookingID);
      ExecSQL;
      Close;
      // Update Clients InHouse field
      SQL.Clear;
      // (deprecated InHouse)
      SQL.Add('UPDATE Clients SET InHouse = False ' + 'WHERE ID = ' +
        IntToStr(Guest));
      ExecSQL;
      Close;
      FillRoomGrid;
      Form1.xx_CheckIfStillPresent;
    END;
  FINALLY
    Result := True;
  END;
END;

PROCEDURE TRR_Rooms.rg_CheckOutDateClick(Sender: TObject);
BEGIN
  CASE rg_CheckOutDate.ItemIndex OF
    0:
      whereS := ' WHERE CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)) + ' ';
    1:
      whereS := ' WHERE NOT CheckOutDate IS NULL ';
  END;
  UpdateBookingsDBGrid(whereS, orderBy);
END;

PROCEDURE TRR_Rooms.dbgd_BookingsTitleClick(Column: TColumnEh);
VAR
  s: STRING;
BEGIN
  IF AnsiContainsText(orderBy, 'Asc') THEN
    s := 'Desc'
  ELSE
    s := 'Asc';
  orderBy := 'ORDER BY ' + Column.FieldName + ' ' + s;
  UpdateBookingsDBGrid(whereS, orderBy);
END;

PROCEDURE TRR_Rooms.UpdateBookingsDBGrid(s1, s2: STRING);
VAR
  s: STRING;
BEGIN
  s := 'SELECT bookingID, cl.Alias,CheckInDate, CheckOutDate, PayedUntilDate,' +
    ' RoomRate, supSingleRoom,supShortTerm,SingleOccupancy,' +
    'DataDepositIn,DepositAmountPayed,DepositAmountPayMethod ' +
    'FROM RREU_Bookings b ' + 'Left JOIN Clients cl ON cl.ID = b.GuestID ';

  WITH Form2.qy_RREU_Bookings DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add(s + s1 + s2);
    Active := True;
    dbgd_Bookings.Refresh;
  END;
END;

FUNCTION TRR_Rooms.GetBedCountForRow(CONST ARow: Integer): Integer;
VAR
  i: Integer;
BEGIN
  Result := 0;
  // columns 4..7 map to Bed1–Bed4
  FOR i := 4 TO 7 DO
    IF (Trim(AdvStringGrid1.Cells[i, ARow]) = '') AND
      (AdvStringGrid1.Colors[i, ARow] <> $00363636) THEN
      Inc(Result);
END;

PROCEDURE TRR_Rooms.img_CheckINMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  IF lb_Checkin.Caption <> '' THEN
  BEGIN
    img_CheckOut.Enabled := False;
    lb_Checkin.BeginDrag(False);
    JvShape1.Pen.color := ClLime;
  END;
END;

PROCEDURE TRR_Rooms.img_CheckOutDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  cellVal, bookID: string;
  ok: Boolean;
  mr: Integer;
begin
  // Only handle drags from our grid
  if Source <> AdvStringGrid1 then
    Exit;
  With Form1 do
  begin
    // Capture cell values
    cellVal := AdvStringGrid1.Cells[FDragCol, FDragRow];
    bookID := AdvStringGrid1.Cells[FDragCol + 5, FDragRow];
    ok := False;

    // Determine action: delete check-in or regular check-out
    if deleteBooking then
    begin
      img_CheckOut.State := stDown;
      lb_CheckOut.Caption := cellVal + #13#10 + 'Elimina CHECKIN';

      if MyTaskDlg_Default('Check-In', 'Stai per eliminare il checkin di ' +
        cellVal, 'Non ha ancora pagato e il Check-In é avvenuto meno di 3 ore fa.'
        + #13#10 + 'Vuoi eliminarlo ?', 'Elimina', 'No', '',
        'CancelCheckin48.ico') = mrOK then
      begin
        if RegisterCheckOut(ThisBooking.GuestID, bookID, deleteBooking) then
        begin
          img_CheckOut.State := stDown;
          lb_CheckOut.Caption := cellVal + #13#10 + 'CHECKIN annullato';
          ok := True;
        end
        else
          ShowMessage('Eliminazione Check In NON riuscito!');
      end;
    end
    else
    begin
      img_CheckOut.State := stDown;
      lb_CheckOut.Caption := '';
      xx_GetRentalData(uClientStore.ThisBooking.GuestID);

      // Payed until today and checking out before 18:00)
      // or payed until tomorrow but checking out today)
      IF ((DateOf(RentalData.PayedUntilDate) = DateOf(Today)) AND
        (HourOf(NOW) <= 18)) OR
        (DateOf(RentalData.PayedUntilDate) > DateOf(Today)) Then
      begin
        if MyTaskDlg_Default('Check-Out', '', 'Confermi il CheckOut di ' +
          cellVal + '?', 'Conferma', 'No', '', 'checkout48.ico') = mrOK then
        begin
          if RegisterCheckOut(uClientStore.ThisBooking.GuestID, bookID,
            deleteBooking) then
          begin
            img_CheckOut.State := stDown;
            lb_CheckOut.Caption := cellVal + #13#10 + 'CHECKOUT eseguito';
            ok := True;
          end
          else
            ShowMessage('Check Out NON riuscito!');
        end;
      end
      else
      begin
        Var
        rentOwed := RentalData.TotalFeeCHF + RentalData.TotalShortTerm +
          RentalData.TotalSingle;
        If (dbgd_CashierDisplay.columns[1].Footers[0].SumValue > 0) OR
          (rentOwed > 0) Then
        begin
          var
            rOtxt: String;
          If rentOwed > 0 Then
            rOtxt := ' Il saldo affitti è di ' + FormatFloat('#,##0.00',
              rentOwed) + ' CHF.'
          else
            rOtxt := '';

          mr := MyTaskDlg_Default('Check-Out in ritardo',
            ' CheckIn avvenuto oggi e la stanza occupata oltre le ore 18:00.',
            cellVal + ' Il saldo affitti è di ' + FormatFloat('#,##0.00',
            rentOwed) + ' CHF.', 'Ns Dimenticanza', '', 'Abbandona',
            'debt_48.ico');
          CASE mr Of
            1:
              begin
                if RegisterCheckOut(uClientStore.ThisBooking.GuestID, bookID,
                  deleteBooking) then
                begin
                  img_CheckOut.State := stDown;
                  lb_CheckOut.Caption := cellVal + #13#10 + 'CHECKOUT eseguito';
                  ok := True;
                end
                else
                  ShowMessage('Check Out NON riuscito!');
              end;
            2:
              begin
                Exit;
              end;
            7:
              begin
                // Addebitare
              end;
          END;
          nnWriteCashierDisplay(0, False, clWhite,
            'Data CheckIn ' + DateTimeToStr(ThisBooking.checkInDt), 1);
          IF DateOf(RentalData.PayedUntilDate) > DateOf(NOW) Then
            nnWriteCashierDisplay(0, False, clWhite,
              'Pagato fino  ' + DateTimeToStr(RentalData.PayedUntilDate), 2);
          ok := False;
          // willCheckoutToday to reset the rent beeing charged from today till tomorrow if actually checks out
          ThisBooking.willCheckOutToday := NOW;
        end;
      end;
    end;

    // If action was cancelled or failed, reset state and exit
    if not ok then
    begin
      img_CheckOut.State := stDefault;
      lb_CheckOut.Caption := '';
      Exit;
    end;

    // Common post-success cleanup
    AdvStringGrid1.SetCheckBoxState(8, FDragRow, FDragRow = 7);
    AdvStringGrid1.Cells[FDragCol, FDragRow] := '';
    AdvStringGrid1.Cells[FDragCol + 5, FDragRow] := '';
    img_CheckOut.Enabled := False;
    lb_Checkin.Caption := '';
    if AdvStringGrid1.Colors[FDragCol, FDragRow] = clYellow then
      AdvStringGrid1.Colors[FDragCol, FDragRow] := clWhite;
  END;
end;

PROCEDURE TRR_Rooms.img_CheckOutDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; VAR Accept: Boolean);
VAR
  daysToPayAtCheckOut: Integer;
BEGIN
  Accept := (Source = AdvStringGrid1) AND (FDragCol IN [4 .. 7]) AND
    (AdvStringGrid1.Cells[FDragCol, FDragRow] <> '');
  IF Accept THEN
  BEGIN
    lb_CheckOut.Caption := AdvStringGrid1.Cells[FDragCol, FDragRow];
    JvShape2.Pen.color := ClRed;
    IF deleteBooking THEN
    BEGIN
      lb_CheckOut.Caption := AdvStringGrid1.Cells[FDragCol, FDragRow] + #13#10 +
        'Cancella CHECKIN';
      img_CheckOut.State := stDown;
    END
    ELSE
      img_CheckOut.State := stDefault;
  END
  ELSE
  BEGIN
    lb_CheckOut.Caption := '';
    JvShape2.Pen.color := ClMaroon;
    img_CheckOut.State := stDefault;
    WITH Form1 DO
    BEGIN
      IF (RentalData.ToPayUntilDate = Tomorrow) THEN
        Inc(uClientStore.RentalData.DaysToPay, -1);
    END;

  END;

  IF State = dsDragLeave THEN
  BEGIN
    lb_CheckOut.Caption := '';
    JvShape2.Pen.color := ClMaroon;
    img_CheckOut.State := stDefault;
  END;
END;

PROCEDURE TRR_Rooms.JvShape1MouseLeave(Sender: TObject);
BEGIN
  IF lb_Checkin.Caption <> '' THEN
    JvShape1.Pen.color := clGreen;
END;

PROCEDURE TRR_Rooms.ChangeSelectionColor(cGrid: TDBCtrlGrid; color: TColor);
VAR
  CtrlGrid: TDBCtrlGrid;
BEGIN
  cGrid.SelectedColor := color;
END;

PROCEDURE TRR_Rooms.AdvSmoothTabPager1Changing(Sender: TObject;
  FromPage, ToPage: Integer; VAR AllowChange: Boolean);
BEGIN
  CASE ToPage OF
    1:
      BEGIN
        rg_CheckOutDate.ItemIndex := 0;
        UpdateBookingsDBGrid(whereS, orderBy);
      END;
  END;
END;

PROCEDURE TRR_Rooms.AdvStringGrid1CanClickCell(Sender: TObject;
  ARow, ACol: Integer; VAR Allow: Boolean);
BEGIN
  Allow := (ARow > 0) AND (ACol IN [0, 3, 4, 5, 6, 7, 8]) AND
    (AdvStringGrid1.Colors[ACol, ARow] <> $00363636);
  IF (Allow) AND (ACol > 3) THEN
    dragAlias := AdvStringGrid1.Cells[ACol, ARow];
END;

PROCEDURE TRR_Rooms.FillRoomGrid;
VAR
  bedCountMap: TDictionary<STRING, Integer>;
  Key: STRING;
  prevBuildingName, curBuildingName: STRING;
  prevAptID, curAptID: Integer;
  RowCount, newRow, c, r: Integer;
  bc: Integer;
  colu: Integer;
  rrSO, rrbSO, rrOK: Boolean;
BEGIN
  FLoadingGrid := True;
  bedCountMap := TDictionary<STRING, Integer>.Create;

  TRY
    WITH Form2.qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT b.Name AS Name,rr.buildingID, rr.ApartmentID, rr.RoomID, '
        + 'COUNT(rr.BedID) AS BedCount ' + 'FROM RREU_RentalRooms rr ' +
        'LEFT JOIN RREU_Buildings b ON b.BuildingID = rr.BuildingID ' +
        'LEFT JOIN RREU_Bookings rrb ON rrb.BookingID = rr.BookingID ' +
        'GROUP BY b.Name, rr.ApartmentID, rr.RoomID');
      Active := True;
      WHILE NOT Eof DO
      BEGIN
        // composite key: "Name|Apt|Room"
        Key := FieldByName('Name').AsString + '|' + FieldByName('ApartmentID')
          .AsString + '|' + FieldByName('RoomID').AsString;
        bedCountMap.AddOrSetValue(Key, FieldByName('BedCount').AsInteger);
        Next;
      END;
      Active := False;
    END;

    // 1) Initialize the grid

    WITH AdvStringGrid1 DO
    BEGIN
      Options := Options + [goEditing, goAlwaysShowEditor];
      FixedRows := 1;
      ColCount := 15;
      RowCount := 1; // leave just the header

      // col 0 = Enabled
      ColWidths[0] := 25;

      // col 1 = Building
      ColWidths[1] := 121;

      // col 2 = ApartmentID
      ColWidths[2] := 35;

      // col 3 = RoomID
      ColWidths[3] := 35;

      // col 4–7 = Bed1…Bed4
      ColWidths[4] := 85;
      ColWidths[5] := 85;
      ColWidths[6] := 85;
      ColWidths[7] := 85;

      // col 8 = SingleOccupancy
      ColWidths[8] := 27;

      AdvStringGrid1.Refresh;

      // header captions
      Cells[0, 0] := '';
      Cells[1, 0] := 'Indirizzo';
      Cells[2, 0] := 'Appart.';
      Cells[3, 0] := 'Camera';
      Cells[4, 0] := 'Letto 1';
      Cells[5, 0] := 'Letto 2';
      Cells[6, 0] := 'Letto 3';
      Cells[7, 0] := 'Letto 4';
      Cells[8, 0] := 'SO';

      // --- now *extend* for the 4 hidden BookingID columns: ---
      // ColCount := ColCount + 4;
      // optional: set headers (won’t be visible but can help if we ever unhide them)
      Cells[9, 0] := 'Bed1_BID';
      Cells[10, 0] := 'Bed2_BID';
      Cells[11, 0] := 'Bed3_BID';
      Cells[12, 0] := 'Bed4_BID';
      Cells[13, 0] := 'BuildingID';
      Cells[14, 0] := 'ApartmentID';

      HideColumns(9, 12);
    END;

    // 2) Run the pivoted SQL
    WITH Form2.qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT rr.Enabled as rrOK,b.Name,rr.BuildingID, rr.ApartmentID,rr.BedID, rr.RoomID,c.Alias, '
        + 'rr.SingleOccupancy as rrSO, rrb.SingleOccupancy AS rrbSO, rr.BookingID, '
        + 'MAX(CASE WHEN rr.BedID = 1 THEN COALESCE(c.Alias, '''') ELSE '''' END) AS Bed1, '
        + 'MAX(CASE WHEN rr.BedID = 2 THEN COALESCE(c.Alias, '''') ELSE '''' END) AS Bed2, '
        + 'MAX(CASE WHEN rr.BedID = 3 THEN COALESCE(c.Alias, '''') ELSE '''' END) AS Bed3, '
        + 'MAX(CASE WHEN rr.BedID = 4 THEN COALESCE(c.Alias, '''') ELSE '''' END) AS Bed4,  '
        +

        'MAX(CASE WHEN rr.BedID = 1 THEN COALESCE(rr.BookingID , 0) ELSE 0 END) AS Book1, '
        + 'MAX(CASE WHEN rr.BedID = 2 THEN COALESCE(rr.BookingID , 0) ELSE 0 END) AS Book2, '
        + 'MAX(CASE WHEN rr.BedID = 3 THEN COALESCE(rr.BookingID , 0) ELSE 0 END) AS Book3, '
        + 'MAX(CASE WHEN rr.BedID = 4 THEN COALESCE(rr.BookingID , 0) ELSE 0 END) AS Book4 '
        +

        'FROM RREU_RentalRooms rr ' +
        'LEFT JOIN RREU_Buildings b on b.BuildingID = rr.BuildingID ' +
        'LEFT JOIN RREU_Bookings rrb ON rrb.BookingID = rr.BookingID ' +
        'LEFT JOIN Clients c ON c.ID = rrb.GuestID ' +
        'WHERE rrb.CheckOutDate IS NULL OR  rrb.CheckOutDate > TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)) + ' ' +
        'GROUP BY rr.BuildingID, rr.ApartmentID,rr.RoomID ' +
        'ORDER BY rr.BuildingID, rr.ApartmentID, rr.RoomID');
      Active := True;

      // init previous markers to an impossible value
      prevBuildingName := '';
      prevAptID := -1;
      WITH AdvStringGrid1 DO
      BEGIN
        // 3) Populate
        WHILE NOT Eof DO
        BEGIN
          curBuildingName := Trim(FieldByName('Name').AsString);
          curAptID := FieldByName('ApartmentID').AsInteger;
          rrbSO := FieldByName('rrbSO').AsBoolean;
          rrSO := FieldByName('rrSO').AsBoolean;
          rrOK := FieldByName('rrOK').AsBoolean;
          AdvStringGrid1.RowCount := AdvStringGrid1.RowCount + 1;
          newRow := AdvStringGrid1.RowCount - 1;

          // col 0: Enabled checkbox (default to checked)

          AddCheckBox(0, newRow, rrOK, not rrOK);
          // col 1: BuildingName only on change
          IF NOT SameText(curBuildingName, prevBuildingName) THEN
            Cells[1, newRow] := curBuildingName
          ELSE
            Cells[1, newRow] := '';

          // col 2: ApartmentID on apt or building change
          IF (curAptID <> prevAptID) OR
            (NOT SameText(curBuildingName, prevBuildingName)) THEN
            Cells[2, newRow] := IntToStr(curAptID)
          ELSE
            Cells[2, newRow] := '';

          // col 3: RoomID always
          Cells[3, newRow] := FieldByName('RoomID').AsString;

          // col 4–7: Bed1..Bed4
          Cells[4, newRow] := Trim(FieldByName('Bed1').AsString);
          Cells[5, newRow] := Trim(FieldByName('Bed2').AsString);
          Cells[6, newRow] := Trim(FieldByName('Bed3').AsString);
          Cells[7, newRow] := Trim(FieldByName('Bed4').AsString);

          // col 8: SingleOccupancy checkbox
          // AddCheckBox(8, newRow, rrbSO, False);
          AddCheckBox(8, newRow, rrSO, NOT rrSO);

          // BookingIds
          Cells[9, newRow] := FieldByName('Book1').AsString;

          Cells[10, newRow] := FieldByName('Book2').AsString;

          Cells[11, newRow] := FieldByName('Book3').AsString;

          Cells[12, newRow] := FieldByName('Book4').AsString;

          // Add row ID
          Cells[13, newRow] := FieldByName('BuildingID').AsString;

          Cells[14, newRow] := FieldByName('ApartmentID').AsString;

          // --- Now color empty beds black ---
          // lookup this room’s bed count
          Key := curBuildingName + '|' + IntToStr(curAptID) + '|' +
            FieldByName('RoomID').AsString;
          IF bedCountMap.TryGetValue(Key, bc) THEN
          BEGIN
            // for each Bed column 4..7, if (col-3) > bedCount then color
            FOR colu := 4 TO 7 DO
              IF (colu - 3) > bc THEN
              BEGIN
                Colors[colu, newRow] := $00363636;
                FontColors[colu, newRow] := clWhite;
              END;
          END;

          // advance trackers
          prevBuildingName := curBuildingName;
          prevAptID := curAptID;
          Next;
        END;
      END;
    END;
    // MoveCursorToCellByValue(ThisClient.alias);
  FINALLY
    BEGIN
      bedCountMap.Free;
      FLoadingGrid := False;
    END;
  END;
END;

PROCEDURE TRR_Rooms.CreateDragCursor(CONST Text: STRING);
VAR
  Bitmap: TBitmap;
  IconHandle: HICON;
BEGIN
  Bitmap := TBitmap.Create;
  TRY
    // Set the bitmap size and attributes
    Bitmap.Width := 72; // Adjust width as needed for text
    Bitmap.Height := 22; // Adjust height as needed for text
    Bitmap.Canvas.Brush.color := clBlue; // Background color
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
    Bitmap.Canvas.Font := AdvStringGrid1.Font;
    // Use the grid's font for consistency
    Bitmap.Canvas.Font.color := clWhite; // Ensure the text color is visible
    Bitmap.Canvas.Font.Style := [fsBold];
    Bitmap.Canvas.TextOut(5, 5, Text); // Draw the text onto the bitmap

    // Create a cursor from the bitmap
    IconHandle := BitmapToIconHandle(Bitmap);
    IF IconHandle <> 0 THEN
    BEGIN
      Screen.Cursors[crDrag] := IconHandle;
      // Assign it to a custom cursor index
      AdvStringGrid1.Cursor := crDrag; // Use the custom cursor during drag
    END;
  FINALLY
    Bitmap.Free;
  END;
END;

PROCEDURE TRR_Rooms.MoveCursorToCellByValue(CONST TargetValue: STRING);
VAR
  ColIndex, rowIndex: Integer;
BEGIN
  WITH AdvStringGrid1 DO
  BEGIN
    FOR rowIndex := 0 TO RowCount - 1 DO
    BEGIN
      FOR ColIndex := 0 TO ColCount - 1 DO
      BEGIN
        IF Cells[ColIndex, rowIndex] = TargetValue THEN
        BEGIN
          // Move the cursor to the found cell
          row := rowIndex;
          col := ColIndex;
          // Optionally, set focus on the grid to highlight the cell
          SetFocus;
          Exit; // Exit the procedure after moving to the first found cell
        END;
      END;
      col := FixedCols;
      row := FixedRows;
    END;
  END;
END;

PROCEDURE TRR_Rooms.AdvStringGrid1CanEditCell(Sender: TObject;
  ARow, ACol: Integer; VAR CanEdit: Boolean);
BEGIN
  CanEdit := (ARow > 0) AND (ACol IN [0, 8]);
END;

// *************************************************************************************
PROCEDURE TRR_Rooms.AdvStringGrid1CheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
VAR
  i, emptyBeds, occupiedBeds, bookID: Integer;
  s, txt, bool, SOdateFromTo: STRING;
  isChecked: Boolean;
BEGIN
  i := 0;
  // Room Enabled column (State show new, clicked state, not old checkbox state)
  IF ACol = 0 Then
  begin
    FOR i := 4 TO 7 DO
    BEGIN
      IF (AdvStringGrid1.Cells[i, ARow] <> '') THEN
      begin
        Inc(occupiedBeds);
        txt := 'Stai per disattivare una stanza ancora occupata. ' + #13#10 +
          'Vuoi procedere ?';
        Break;
      end
      else IF State = False Then
        txt := 'Stai per disattivare una stanza. ' + #13#10 +
          'Vuoi procedere ?';
    end;
    AdvStringGrid1.GetCheckBoxState(0, ARow, isChecked);
    bool := BoolToStr(isChecked, True);

    IF (txt <> '') AND (State = False) Then
    (*
      IF (Form1.MyMessageDialog(txt, mtConfirmation, mbOKCancel,
      ['OK', 'NO'],[0,1], 'RR Rooms', 'OK') <> mrOK) THEN
      Exit;
    *)

    begin
      With Form2.qy_Tmp do
      begin
        If Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE RREU_RentalRooms SET Enabled = ' + bool +
          ' WHERE BuildingID = ' + AdvStringGrid1.Cells[13, ARow] +
          ' AND ApartmentID = ' + AdvStringGrid1.Cells[14, ARow] +
          ' AND RoomID = ' + AdvStringGrid1.Cells[3, ARow]);
        ExecSQL;
        AdvStringGrid1.FocusCell(7, ARow);
        // To avoid focusing and not correctly displaying row 1 checkbox cell
        Exit;
      end;
    end;

  end;

  // SingleOccupancy checkbox clicked
  // ---------------------------------------------------------------------------
  IF (ACol = 8) THEN // State=True means " just clicked on checkbox"
  BEGIN
    bookID := 0;
    emptyBeds := 0;
    occupiedBeds := 0;
    FOR i := 4 TO 7 DO
    BEGIN
      IF AdvStringGrid1.Cells[i, ARow] <> '' THEN
      BEGIN
        Inc(occupiedBeds);
        IF occupiedBeds = 1 THEN
          bookID := StrToInt(AdvStringGrid1.Cells[i + 5, ARow]);
      END;
      IF (AdvStringGrid1.Cells[i, ARow].IsEmpty) AND
        (AdvStringGrid1.Colors[i, ARow] <> $00363636) THEN
      begin
        Inc(emptyBeds);
      end;
    END;

    IF (occupiedBeds = 0) and (emptyBeds = 1) Then
    begin
      AdvStringGrid1.SetCheckBoxState(8, ARow, NOT State);
      MessageDlg
        ('Una stanza con un solo letto non puoi far diventare condivisa!',
        mtWarning, [mbOK], 0);
      Exit;
    end;

    IF occupiedBeds = 0 THEN
    BEGIN
      AdvStringGrid1.SetCheckBoxState(8, ARow, NOT State);
      MessageDlg('Puoi cambiare unicamente se un letto è occupato!', mtWarning,
        [mbOK], 0);
      Exit;
    END;

    IF occupiedBeds > 1 THEN
    BEGIN
      // revert the check
      AdvStringGrid1.SetCheckBoxState(8, ARow, False);
      // show the message exactly once
      MessageDlg
        ('Non puoi assegnare una stanza a singola occupazione con più letti occupti!',
        mtWarning, [mbOK], 0);
      Exit;
    END;

    // Form1.bt_Read_Click(Sender);
    IF Trim(uClientStore.ThisClient.alias) <>
      Trim(AdvStringGrid1.Cells[i - 4, ARow]) THEN
    BEGIN
      AdvStringGrid1.SetCheckBoxState(8, ARow, NOT State);

      Form1.MyTaskDlg_Default('Lettura tessera', 'Errore tessera',
        'Tessera sul lettore non corrisponde a ' + AdvStringGrid1.Cells[i - 4,
        ARow] + '!', 'OK', '', '', 'RfidCards_48.ico');
    END;

    IF occupiedBeds = 1 THEN
    BEGIN
      IF State THEN
      BEGIN
        s := 'CONDIVISA a SINGOLA';
        bool := 'True';
        SOdateFromTo := 'SODateFrom';
      END
      ELSE
      BEGIN
        s := 'SINGOLA a CONDIVISA';
        bool := 'False';
        SOdateFromTo := 'SODateTo';
      END;

      // show the message exactly once
      IF MessageDlg('Confermi il cambiamento da ' + s + '?', mtConfirmation,
        [mbOK, mbNo], 0, mbOK) = mrOK THEN
      // confirm the check
      BEGIN
        AdvStringGrid1.SetCheckBoxState(8, ARow, State);
        WITH Form2.qy_Tmp DO
        BEGIN

          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('UPDATE RREU_Bookings b SET ' +
            'SingleOccupancy = :SingleOcc, ' +
            'SupSingleRoom = (SELECT rr.SupSingle FROM RREU_RentalRooms rr ' +
            'WHERE rr.BookingID = b.BookingID), ' + SOdateFromTo +
            ' = CURRENT_DATE ' + 'WHERE b.BookingID = :BookingID ' +
            'AND (b.CheckOutDate IS NULL OR b.CheckOutDate > :NowTS)');

          ParamByName('SingleOcc').AsBoolean := StrToBoolDef(bool, False);
          ParamByName('BookingID').AsInteger := bookID;
          ParamByName('NowTS').AsDateTime := NOW;
          ExecSQL;
        END;
      END
      ELSE
        // revert the check
        AdvStringGrid1.SetCheckBoxState(8, ARow, NOT State);
    END
    ELSE
      AdvStringGrid1.SetCheckBoxState(8, ARow, False);
  END;
END;


// ******************************************************************************************

PROCEDURE TRR_Rooms.AdvStringGrid1DblClickCell(Sender: TObject;
  ARow, ACol: Integer);
VAR
  BuildingID, ApartmentID: Integer;
  adress: STRING;
BEGIN
  BuildingID := 0;
  ApartmentID := 0;

  CASE ACol OF
    3:
      BEGIN
        // Prepare Notes for room id
        // -----------------------------------------------------------------------
        IF (ARow IN [1, 2, 3, 4]) THEN
        BEGIN
          BuildingID := 1;
          ApartmentID := 1;
          adress := AdvStringGrid1.Cells[1, 1];
        END;
        IF (ARow IN [5, 6, 7, 8]) THEN
        BEGIN
          BuildingID := 2;
          ApartmentID := 1;
          adress := AdvStringGrid1.Cells[1, 5];
        END;

        WITH Form2.tb_RREU_RentalRooms DO
        BEGIN
          Active := True;
          IF Locate('BuildingID;ApartmentID;RoomID',
            VarArrayOf([BuildingID, ApartmentID,
            StrToInt(AdvStringGrid1.Cells[3, ARow])]), []) THEN
            IF FieldByName('Notes').IsNull THEN
            BEGIN
              Edit;
              Notes_.RzDBMemo1.Lines.Add(DateTimeToStr(NOW));
              Notes_.RzDBMemo1.Lines.Add(adress + ': Camera: ' +
                AdvStringGrid1.Cells[3, ARow]);
            END;
          Notes_.ShowModal;
        END;
      END;

    4 .. 7:
      BEGIN // Get room rate to pay
        // ---------------------------------------------------------------------
        IF (ARow > 0) AND (FDragCol IN [4 .. 7]) AND
          (StrToIntDef(AdvStringGrid1.Cells[ACol + 5, ARow], 0) > 0) THEN
        BEGIN
          WITH Form1 DO
          BEGIN
            bt_Read_Click(Sender);
            IF (RentalData.TotalFeeCHF > 0) AND
              (Form2.tb_OTab.RecordCount = 0) THEN
            BEGIN
              WITH Form2.qy_Tmp2 DO
              BEGIN
                IF Active THEN
                  Close;
                SQL.Clear;
                {
                  SQL.Add('INSERT INTO OpenTab ' +
                  '(FeeID,SubFeeID,ClientID,CardID,Description,' +
                  'amountCHF,amountEuro,amountToPrint,' +
                  'PosPrintItems,PrintQRCode,TicketHeader,' +
                  'BonusMalusID,CostCenter,dAccount,aAccount,' +
                  'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,' +
                  'PayMethod,DefaultPayMethod,' +
                  'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt,BookingID) ' + 'SELECT '
                  + 'f.ID,f.SubID,' + IntToStr(ThisClient.ID) + ', ' +
                  IntToStr(uClientStore.ThisCard.cardID) + ', ' + QuotedStr('Affitto dal ' +
                  DateTimeToStr(DateOf(RentalData.PayedUntilDate)) + ' al ' +
                  DateTimeToStr(DateOf(RentalData.ToPayUntilDate))) + ',' +
                  FloatToStr(RentalData.TotalRentToPayCHF) + ',' +
                  FloatToStr(RentalData.TotalRentToPayEuro) + ',' +
                  FloatToStr(RentalData.TotalRentToPayCHF) + ',' +
                  'PosPrintItems,PrintQRCode,TicketHeader,BonusMalusID,CostCenter,dAccount,aAccount,'
                  + 'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,'''' ,DefaultPayMethod,'
                  + 'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt, ' +
                  IntToStr(ThisBooking.bookingID) + ' FROM Fees f ' +
                  ' WHERE f.SubID = 222');
                }
                ExecSQL;
                Form2.tb_OTab.Refresh;
              END;
            END;
            bt_Cancel.Enabled := RentalData.TotalFeeCHF > 0;
            Form1.InsertIntoTabMem;
          END;
        END;
      END;
  END;
END;

function TRR_Rooms.AskCheckInOptions(const GuestName: string;
  out SingleOcc, shortTerm: Boolean): Boolean;
begin
  Result := False;

  if Form1.MyTaskDlg_Default('Check-In', 'Conferma Check-In',
    'Confermi il CHECK-IN di ' + GuestName + '?', 'Conferma', 'No', '',
    'checkin48.ico') <> mrOK then
    Exit;

  SingleOcc := Form1.MyTaskDlg_Default('Check-In', 'Occupazione camera',
    'Vuoi registrare ' + GuestName + ' in occupazione singola?', 'Singola',
    'Condivisa', '', 'questionMark_48.ico') = mrOK;

  shortTerm := Form1.MyTaskDlg_Default('Check-In', 'Durata soggiorno',
    'Scegli la permanenza prevista di ' + GuestName, 'Periodo breve',
    'Periodo lungo', '', 'questionMark_48.ico') = mrOK;

  Result := True;
end;

PROCEDURE TRR_Rooms.AdvStringGrid1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
VAR
  isSingle: Boolean;
  filledBeds, BedCol, addressRow, i: Integer;
  nBuID, nAID, nRID, nBedID: String;
  s, bool: STRING;
  shortOccSdate, shortOcceDate: TDateTime;
BEGIN
  addressRow := 0;
  WITH AdvStringGrid1 DO
  BEGIN
    MouseToCell(X, Y, tgtCol, tgtRow);
    // grab the source from the fields you set in OnMouseDown

    // same base checks
    IF ((Source <> AdvStringGrid1) AND (Source <> lb_Checkin)) OR
      NOT(tgtCol IN [4 .. 7]) THEN
      Exit;
    IF (Source = lb_Checkin) AND (lb_Checkin.Caption = '') THEN
      Exit;
    IF Cells[tgtCol, tgtRow] <> '' THEN
      Exit;
    IF Colors[tgtCol, tgtRow] = clBlack THEN
      Exit;
    IF NOT GetCheckBoxState(8, tgtRow, isSingle) THEN
      Exit;
    // If singleOccupancy and already bed(s) occupied then exit
    IF isSingle THEN
    BEGIN
      filledBeds := 0;
      FOR i := 4 TO 7 DO
        IF Cells[i, tgtRow] <> '' THEN
          Inc(filledBeds);
      IF filledBeds > 0 THEN
        Exit
      ELSE
        bool := 'True';
    END
    ELSE
      bool := 'False ';

    // Get building address row
    CASE tgtRow OF
      1, 2, 3, 4:
        addressRow := 1;
      5, 6, 7, 8:
        addressRow := 5;
    END;

    // Choose always first empty bed
    BedCol := -1;
    FOR i := 4 TO 7 DO
      IF (Cells[i, tgtRow] = '') AND (Colors[i, tgtRow] <> $00363636) THEN
      BEGIN
        BedCol := i;
        Break;
      END;

    // If no empty beds, warn and exit
    IF BedCol = -1 THEN
    BEGIN
      MessageDlg('Non ci sono letti disponibili in questa stanza!', mtError,
        [mbOK], 0);
      Exit;
    END;

    // perform the move
    IF Source = AdvStringGrid1 THEN
    BEGIN
      IF (tgtRow = FDragRow) THEN
        Exit;
      IF Form1.MyTaskDlg_Default('Gestione stanze', 'Cambia stanza',
        'Confermi lo spostamento di ' + dragAlias + '?', 'Cambia', 'No', '',
        'switch 48.ico') = mrOK Then
      BEGIN
        s := Cells[FDragCol, FDragRow];
        // Move alias
        Cells[BedCol, tgtRow] := s;
        Cells[FDragCol, FDragRow] := '';
        // Move BookingID
        Cells[BedCol + 5, tgtRow] := Cells[FDragCol + 5, FDragRow];
        IF (GetCheckBoxState(8, FDragRow, isSingle)) AND (isSingle) AND
          (GetBedCountForRow(FDragRow) > 1) THEN
          SetCheckBoxState(8, FDragRow, False);

        WITH Form2.qy_Tmp DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('UPDATE RREU_RentalRooms ' + ' SET BookingID =  CASE ' +
            ' WHEN BookingID = ' + Cells[FDragCol + 5, FDragRow] + ' THEN NULL '
            + ' WHEN BuildingID = (SELECT BuildingID ' +
            ' FROM RREU_Buildings WHERE Name = ' +
            QuotedStr(Cells[1, addressRow]) + ')' + ' AND ApartmentID = ' +
            Cells[2, addressRow] + ' AND RoomID = ' + Cells[3, tgtRow] +
            ' AND BedID = ' + IntToStr(BedCol - 3) + ' THEN  ' +
            Cells[FDragCol + 5, FDragRow] + ' ELSE BookingID END ' +
            ' WHERE BookingID = ' + Cells[FDragCol + 5, FDragRow] +
            ' OR ( BuildingID = ( SELECT BuildingID ' + ' FROM RREU_Buildings '
            + ' WHERE Name = ' + QuotedStr(Cells[1, addressRow]) + ')' +
            ' AND ApartmentID = ' + Cells[2, addressRow] + ' AND RoomID      = '
            + Cells[3, tgtRow] + ' AND BedID       = ' +
            IntToStr(BedCol - 3) + ' )');
          ExecSQL;
        END;

        nBuID := Cells[13, tgtRow];
        nAID := Cells[14, tgtRow];
        nRID := Cells[3, tgtRow];
        nBedID := IntToStr(BedCol - 3);
        Var
        bookStatus := GenerateBookingID(StrToInt(nBuID), StrToInt(nAID),
          StrToInt(nRID), StrToInt(nBedID));
        WITH Form2.qy_Tmp DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('UPDATE RREU_Bookings SET SingleOccupancy = ' + bool +
            ', BookingStatus = ' + QuotedStr(bookStatus) + ' WHERE BookingID = '
            + Cells[FDragCol + 5, tgtRow] +
            ' AND CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
            QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)));
          ExecSQL;
        END;

      END;
    END;
    if Source = lb_Checkin then
    begin
      DoCheckInToGridRow(tgtRow);
      Exit;
    end;

    {
      IF Source = lb_Checkin THEN
      IF Form1.MyTaskDlg_Default('Check-In', 'Conferma Check-In',
      'Confermi il CHECK IN di ' + uClientStore.ThisClient.alias + '?',
      'Conferma', 'No', '', 'checkin48.ico') = mrOK Then
      BEGIN
      var
      shortTerm: Boolean;
      IF Form1.MyTaskDlg_Default('Check-In', 'Periodo breve/lungo',
      'Scegli la permanenza prevvisto di ' + uClientStore.ThisClient.alias +
      '?', 'Periodo Breve', 'Periodo lungo', '', 'questionMark_48.ico')
      = mrOK Then
      shortTerm := True
      else
      shortTerm := False;

      s := Cells[8, tgtRow];
      TRY
      RegisterCheckIN(uClientStore.ThisClient.ID, Cells[13, tgtRow],
      Cells[14, tgtRow], Cells[3, tgtRow], IntToStr(bedCol - 3),
      GetCheckBoxState(8, FDragRow, isSingle), shortTerm);
      FINALLY
      // Now get new BookingID
      WITH Form2.qy_Tmp DO
      BEGIN
      IF active THEN
      Close;
      SQL.Clear;
      SQL.Add('SELECT BookingID FROM RREU_Bookings ' + 'WHERE GuestID = '
      + IntToStr(uClientStore.ThisClient.ID) +
      ' AND CheckOutdate IS NULL OR  CheckOutDate > TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(NOW, True)));
      active := True;
      IF RecordCount = 1 THEN
      Cells[bedCol + 5, tgtRow] := FieldByName('BookingID').AsString;
      END;
      Cells[bedCol, tgtRow] := uClientStore.ThisClient.alias;
      lb_Checkin.Caption := '';
      // lb_Checkin.Caption := Cells[bedCol, tgtRow] + #13#10 + 'CHECK IN OK';
      lb_CheckOut.Caption := '';
      img_CheckIN.Enabled := False;
      JvShape1.Pen.color := ClGreen;
      END;
      END;
    }
  END;
END;

PROCEDURE TRR_Rooms.AdvStringGrid1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; VAR Accept: Boolean);
VAR
  tgtCol, tgtRow: Integer;
  isSingle: Boolean;
  filledBeds, i: Integer;
BEGIN
  AdvStringGrid1.MouseToCell(X, Y, tgtCol, tgtRow);

  IF ((Source = lb_Checkin) AND (lb_Checkin.Caption = '')) THEN
  BEGIN
    Accept := False;
    Exit;
  END;

  Accept := ((Source = AdvStringGrid1) AND (tgtCol IN [4 .. 7])) OR
    ((Source = lb_Checkin) AND (tgtCol IN [4 .. 7]));

  // must be empty
  IF Accept AND (AdvStringGrid1.Cells[tgtCol, tgtRow] <> '') THEN
    Accept := False;

  // must not be a “noBed” cell (colored $00363636)
  IF Accept AND (AdvStringGrid1.Colors[tgtCol, tgtRow] = $00363636) THEN
    Accept := False;

  // check the room’s SingleOccupancy flag
  IF Accept THEN
  BEGIN
    IF NOT AdvStringGrid1.GetCheckBoxState(8, tgtRow, isSingle) THEN
      Exit; // no checkbox → disallow

    IF isSingle THEN
    BEGIN
      filledBeds := 0;
      FOR i := 4 TO 7 DO
        IF AdvStringGrid1.Cells[i, tgtRow] <> '' THEN
          Inc(filledBeds);
      // only allow if no bed already occupied
      Accept := (filledBeds = 0);
    END;
  END;
  IF State = dsDragLeave THEN
    JvShape1.Pen.color := clGreen;

END;

PROCEDURE TRR_Rooms.AdvStringGrid1GetAlignment(Sender: TObject;
  ARow, ACol: Integer; VAR HAlign: TAlignment; VAR VAlign: TVAlignment);
BEGIN
  // center *every* cell:
  HAlign := taCenter;
END;

PROCEDURE TRR_Rooms.AdvStringGrid1GetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
VAR
  defCl: TColor;
BEGIN
  defCl := AFont.color;
  IF ARow > 0 THEN
    IF MatchText(AdvStringGrid1.Cells[ACol, ARow], Form1.FAliases) THEN
      AFont.color := ClRed
    ELSE
      AFont.color := defCl;
END;

PROCEDURE TRR_Rooms.AdvStringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
VAR
  aAlias, rrAlias: String;
BEGIN
  // figure out which cell we clicked
  AdvStringGrid1.MouseToCell(X, Y, FDragCol, FDragRow);
  // only drag if we clicked a nonempty Bed‑cell
  IF (FDragCol IN [4 .. 7]) AND (AdvStringGrid1.Cells[FDragCol, FDragRow]
    <> '') THEN
  BEGIN
    If Form1.xx_ReadCard(Form1.xx_FromCardReader) = 0 then
      Form1.xx_GetClientData(uClientStore.ThisCard.ClientID)
    else
    begin
      Form1.nnWriteCashierDisplay(0, True, clYellow, 'Tessera non valida', 2);
      Exit;
    end;
    IF Trim(AdvStringGrid1.Cells[FDragCol, FDragRow]) <>
      Trim(uClientStore.ThisClient.alias) then
    BEGIN
      Form1.MyTaskDlg_Default('Errore tessere', 'Check-In',
        'Tessera sul lettore non corrisponde a ' + AdvStringGrid1.Cells
        [FDragCol, FDragRow] + '!', 'OK', '', '', 'RfidCards_48.ico');
      Exit;
    END;

    AdvStringGrid1.BeginDrag(False);

  END;
  img_CheckOut.Enabled := AdvStringGrid1.Cells[FDragCol, FDragRow] <> '';
  img_CheckIN.Enabled := NOT img_CheckOut.Enabled;

  // Only for receptionist's info
  // ---------------------------------------------------------------------------
  Form1.xx_GetLastValidTxData('RR_Rooms', uClientStore.ThisClient.ID);
  Var
    s: String;
  IF uClientStore.ThisClient.lstTaxDate > 0 THEN
    s := 'Ultima presenza al club: ' +
      DateTimeToStr(uClientStore.ThisClient.lstTaxDate)
  ELSE
    s := 'Ultima presenza al club: Nessuna';
  Form1.nnWriteCashierDisplay(0, False, clWhite, s, 1);
END;

PROCEDURE TRR_Rooms.AdvStringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; VAR CanSelect: Boolean);
BEGIN
  // if it’s an empty bed cell, block the select and clear any residual selection
  IF (ARow > 0) AND (ACol IN [3 .. 7]) THEN
    CanSelect := True
  ELSE
    CanSelect := False;
END;

FUNCTION TRR_Rooms.BitmapToIconHandle(Bitmap: TBitmap): HICON;
VAR
  IconInfo: TIconInfo;
BEGIN
  IconInfo.fIcon := False;
  IconInfo.xHotspot := 0; // Set the hotspot to the top left
  IconInfo.yHotspot := 0;
  IconInfo.hbmMask := Bitmap.Handle;
  IconInfo.hbmColor := Bitmap.Handle;
  Result := CreateIconIndirect(IconInfo);
END;

INITIALIZATION

END.
