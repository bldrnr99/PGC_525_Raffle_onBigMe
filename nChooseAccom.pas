UNIT nChooseAccom;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  AdvGlassButton,
  AdvSmoothPanel, Vcl.ComCtrls, AdvCheckTreeView,
  // AdvCustomControl,
  AdvTreeViewBase, AdvTreeViewData, AdvCustomTreeView, AdvTreeView,
  AdvCheckedTreeView, JvExComCtrls, JvComCtrls, JvCheckTreeView, Vcl.StdCtrls,
  AdvGroupBox, AdvOfficeButtons, Vcl.WinXCtrls, Vcl.DBCtrls, Vcl.ExtCtrls;

TYPE
  TnChooseAccomodation = CLASS(TForm)
    pl_ChooseAccom: TAdvSmoothPanel;
    bt_OkAccom: TAdvGlassButton;
    AdvGlassButton7: TAdvGlassButton;
    rg_Deposit: TAdvOfficeRadioGroup;
    gd_Rooms: TDBGridEh;
    lb_OccupancyInfo: TLabel;
    DBNavigator1: TDBNavigator;
    lb_Alias: TLabel;
    PROCEDURE AdvGlassButton7Click(Sender: TObject);
    PROCEDURE dbgd_RoomsRowDetailPanelShow(Sender: TCustomDBGridEh;
      VAR CanShow: Boolean);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE gd_RoomsCellClick(Column: TColumnEh);
    FUNCTION CheckOccupancy(room: STRING; WantsSingle: Boolean): Boolean;
    PROCEDURE gd_RoomsGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; VAR Background: TColor; State: TGridDrawState);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  nChooseAccomodation: TnChooseAccomodation;
  P: TPoint;
  dSpan: Integer;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

PROCEDURE TnChooseAccomodation.AdvGlassButton7Click(Sender: TObject);
BEGIN

  Form2.tb_Clienti_Clients.Refresh;
  nChooseAccomodation.Close;
END;

PROCEDURE TnChooseAccomodation.gd_RoomsGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; VAR Background: TColor;
  State: TGridDrawState);
VAR
  fColor, bColor: TColor;
  room: STRING;
BEGIN
  fColor := AFont.Color;
  bColor := Background;
  WITH Form2.qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT Room, RoomRate AS rdR FROM RR_Dates rd ' +
        'JOIN RR_Rooms rr ON rd.Room = rr.RoomID ' +
        'WHERE (rd.DepartureDate IS Null ' +
        'OR CURRENT_DATE <= rd.DepartureDate) ' +
        'AND rd.RoomRate = rr.SingleUseRate ');
      Active := True;
      IF RecordCount > 0 THEN
        room := FieldByName('Room').AsString;
      Active := False;
    END;

  WITH Form2.tb_RR_Rooms DO
    BEGIN
      IF (FieldByName('Beds').AsInteger - FieldByName('BedsOccupied').AsInteger = 0) THEN
        BEGIN
          AFont.Color := clRed;
        END
      ELSE
        BEGIN
          AFont.Color := fColor;
          Background := bColor;
        END;
    END
END;

PROCEDURE TnChooseAccomodation.dbgd_RoomsRowDetailPanelShow(
  Sender: TCustomDBGridEh; VAR CanShow: Boolean);
BEGIN
  WITH Form2, qy_Tmp2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT Clients.Alias, ch.RoomRate FROM Clients c ' +
        'JOIN RR_Dates ch ON Clients.ID = ch.Clientid ' +
        'JOIN RR_Rooms rr ON rr.RoomID = ch.Room ' +
        'WHERE (ch.DepartureDate IS Null ' +
        'OR CURRENT_DATE <= ch.DepartureDate) ' +
        'AND rr.RoomID = ' + QuotedStr(tb_RR_Rooms.FieldByName('RoomID').AsString));
      Active := True;
      // dbgd_AliasInRoom.DataSource := scqy_Tmp2;
      // dbgd_AliasInRoom.Refresh;
    END;
END;

PROCEDURE TnChooseAccomodation.FormClose(Sender: TObject;
  VAR Action: TCloseAction);
BEGIN
  lb_Alias.caption := '';
  gd_Rooms.RowDetailPanel.Active := False;
  Form2.tb_RentDates.Last;
END;

FUNCTION TnChooseAccomodation.CheckOccupancy(room: STRING; WantsSingle: Boolean): Boolean;
BEGIN
  WITH Form2.qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT Beds, BedsOccupied FROM RR_Rooms Where RoomID = ' + QuotedStr(room));
      Active := True;
      IF WantsSingle THEN
        Result := FieldValues['BedsOccupied'] = 0
      ELSE
        Result := FieldValues['Beds'] - FieldValues['BedsOccupied'] > 0;
      Active := False;
    END;
  lb_OccupancyInfo.caption := '';
END;

PROCEDURE TnChooseAccomodation.gd_RoomsCellClick(Column: TColumnEh);
VAR
  rrRate: Double;
  s: STRING;
BEGIN
  lb_OccupancyInfo.caption := '';
  dSpan := 1;

  WITH Form2, tb_RR_Rooms DO
    BEGIN
      CASE Column.Index OF
        5:
          rrRate := FieldByName('SharedUseRate').AsFloat;
        6:
          rrRate := FieldByName('SharedLongTermRate').AsFloat;
        7:
          rrRate := FieldByName('SingleUseRate').AsFloat;
        8:
          rrRate := FieldByName('SingleLongTermRate').AsFloat;
      END;

      IF NOT CheckOccupancy(FieldByName('RoomID').AsString, Column.Index IN [7, 8]) THEN
        BEGIN
          lb_Alias.caption := '';
          lb_OccupancyInfo.Font.Color := clYellow;
          lb_OccupancyInfo.caption := 'Camera occupata!';
          bt_OkAccom.caption := '';
          bt_OkAccom.Enabled := False;
          Exit;
        END;

      bt_OkAccom.Enabled := (FieldByName('Beds').AsInteger > FieldByName('BedsOccupied').AsInteger)
        AND (Column.Index IN [5, 6, 7, 8]);
      IF (bt_OkAccom.Enabled) AND ((Column.Index IN [5, 6, 7, 8])) THEN
        BEGIN
          lb_Alias.caption := Form1.ThisClient.alias;
          CASE Column.Index OF
            5: // Shared short term
              IF (FieldByName('SharedUseRate').AsInteger > 0) THEN
                BEGIN
                  dSpan := 1;
                  bt_OkAccom.caption := FloatToStr(rrRate);
                  bt_OkAccom.Enabled := True;
                  WITH lb_OccupancyInfo DO
                    BEGIN
                      caption := Column.Title.caption + #13#10 +
                        'Costo giornaliero ' + FloatToStr(rrRate) + #13#10 +
                        'Giorni 1';
                      Font.Color := clWhite;
                    END;
                END
              ELSE
                BEGIN
                  bt_OkAccom.caption := '';
                  bt_OkAccom.Enabled := False;
                END;
            6: // Shared Long term
              BEGIN
                IF (FieldByName('Beds').AsInteger - FieldByName('BedsOccupied').AsInteger > 0) THEN
                  BEGIN
                    IF Form1.sw_RRLongRatePmt.State = tssOff THEN
                      BEGIN
                        dSpan := 1;
                        s := '';
                      END
                    ELSE
                      BEGIN
                        dSpan := Form1.ed_MinReservDays.Value;
                        s := ' (da pag in anticipo!)';
                      END;

                    bt_OkAccom.caption := FloatToStr(rrRate * dSpan);
                    bt_OkAccom.Enabled := True;
                    WITH lb_OccupancyInfo DO
                      BEGIN
                        caption := Column.Title.caption + #13#10 +
                          'Costo giornaliero ' + FloatToStr(rrRate) + #13#10 +
                          'Giorni ' + IntToStr(dSpan) + s;
                        Font.Color := clWhite;
                      END;
                  END
                ELSE
                  BEGIN
                    bt_OkAccom.caption := '';
                    bt_OkAccom.Enabled := False;
                  END;
              END;
            7: // Single Short term
              IF (FieldByName('SharedLongTermRate').AsInteger > 0) THEN
                BEGIN
                  bt_OkAccom.caption := FloatToStr(rrRate * dSpan);
                  bt_OkAccom.Enabled := True;
                  WITH lb_OccupancyInfo DO
                    BEGIN
                      caption := Column.Title.caption + #13#10 +
                        'Costo giornaliero ' + FloatToStr(rrRate) + #13#10 +
                        'Giorni 1';
                      Font.Color := clWhite;
                    END;
                END
              ELSE
                BEGIN
                  bt_OkAccom.caption := '';
                  bt_OkAccom.Enabled := False;
                END;
            8: // Single long term
              IF (FieldByName('BedsOccupied').AsInteger = 0) THEN
                BEGIN
                  IF Form1.sw_RRLongRatePmt.State = tssOff THEN
                    BEGIN
                      dSpan := 1;
                      s := '';
                    END
                  ELSE
                    BEGIN
                      dSpan := Form1.ed_MinReservDays.Value;
                      s := ' (da pag in anticipo!)';
                    END;
                  bt_OkAccom.caption := FloatToStr(rrRate * dSpan);
                  bt_OkAccom.Enabled := True;
                  WITH lb_OccupancyInfo DO
                    BEGIN
                      caption := Column.Title.caption + #13#10 +
                        'Costo giornaliero ' + FloatToStr(rrRate) + #13#10 +
                        'Giorni ' + IntToStr(dSpan) + s;
                      Font.Color := clWhite;
                    END;
                END
              ELSE
                BEGIN
                  bt_OkAccom.caption := '';
                  bt_OkAccom.Enabled := False;
                END;
          ELSE
            bt_OkAccom.caption := '';
          END;
          lb_Alias.caption := Form1.ThisClient.alias;
        END;
    END;
END;

END.
