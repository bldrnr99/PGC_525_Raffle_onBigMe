UNIT Cash2Clients;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.DateUtils, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Data.DB,GridsEh, DBAxisGridsEh,
  DBGridEh, edbcomps, Vcl.StdCtrls, AdvGroupBox, AdvOfficeButtons, Vcl.Buttons,
  AdvSmoothCalendar, Vcl.Mask, RzEdit, RzBtnEdt, AdvGlassButton, EhLibVclUtils;

TYPE
  TForm5 = CLASS(TForm)
    sc_Cash2Clients: TDataSource;
    qy_Cash2Client: TEDBQuery;
    dbgd_Cash2Client: TDBGridEh;
    rg_cash2client: TAdvOfficeRadioGroup;
    dbgd_Cash2ClientDaily: TDBGridEh;
    sc_Cash2ClientDaily: TDataSource;
    qy_Cash2ClientDaily: TEDBQuery;
    rg_DayMode: TAdvOfficeRadioGroup;
    cal_CC: TAdvSmoothCalendar;
    Label1: TLabel;
    ed_CC_QRCode: TRzButtonEdit;
    bt_Print: TAdvGlassButton;
    bt_PayCard: TAdvGlassButton;
    lb_PayMsg: TLabel;
    PROCEDURE rg_cash2clientClick(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE rg_DayModeClick(Sender: TObject);
    PROCEDURE cal_CCSelectDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
    PROCEDURE cal_CCSelectMultiDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
    PROCEDURE ed_CC_QRCodeButtonClick(Sender: TObject);
    PROCEDURE ed_CC_QRCodeChange(Sender: TObject);
    PROCEDURE PrintSummaryPeriod(Sender: TObject);
    PROCEDURE bt_PayCardClick(Sender: TObject);
    PROCEDURE GetPrintDescr;
    PROCEDURE bt_PrintClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  Form5: TForm5;
  fDt, tdt, fromDt, todt: TDateTime;
  ccPrintDescr, dayMode: STRING;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

PROCEDURE TForm5.bt_PayCardClick(Sender: TObject);
BEGIN
  WITH qy_Cash2Client DO
    BEGIN
      IF (RecordCount = 1) AND
        (FieldByName('Closed').AsBoolean = False) AND
        (Length(ed_CC_QRCode.Text) = 13) THEN // Register payment
        IF MessageDLG('Stai per registrare il pagamento alla cliente della carta di credito.' + #13#10 +
          'Procedi con la registrazione?', mtConfirmation, [mbOk, mbNo], 0, mbOk) = mrOk THEN
          BEGIN
            Form1.bt_Read_Click(Sender);
            IF Form1.ThisClient.ID <> FieldByName('ID').AsInteger THEN
              BEGIN
                ShowMessage('Errore lettura tessera. ID Cliente non corrisponde alla tessera sul lettore!');
                Exit;
              END;

            Form2.t_executequery('UPDATE ClCCLedger SET Closed = True, ' +
              'DataPayedOut = Current_TimeStamp ' +
              'WHERE TxID = ' + QuotedStr(ed_CC_QRCode.Text), 'PGC_DB_Main_Unicode',
              'PGC_DB_Unicode', 'ClCCLedger');
            Sleep(500);

            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Add('SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, '
              + 'Clients.FirstName, Dare, Closed, TxID '
              + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
              + ' WHERE TxID = ' + QuotedStr(ed_CC_QRCode.Text) + ' AND Dare > 0');
            Active := True;
            bt_Print.Font.Color := clRed;
            bt_Print.Caption := 'Ricevuta Carta';
            bt_PayCard.Enabled := False;
            dbgd_Cash2Client.Refresh;
          END;
    END;
END;

PROCEDURE TForm5.bt_PrintClick(Sender: TObject);
BEGIN
  IF bt_Print.Caption = 'Ricevuta Carta' THEN
    WITH qy_Cash2Client DO
      BEGIN
        Form1.nPrintCCReceipt(FieldByName('Dare').AsFloat, ed_CC_QRCode.Text, 25, 2);
        ed_CC_QRCode.Clear;
        rg_DayMode.Enabled := True;
        rg_cash2client.Enabled := True;
        bt_PayCard.Enabled := False;
        bt_Print.Font.Color := clBlue;
        bt_Print.Caption := ccPrintDescr;
      END
  ELSE
    PrintSummaryPeriod(Sender);
END;

PROCEDURE TForm5.PrintSummaryPeriod(Sender: TObject);
VAR
  tmpPrntStr: TStringList;
  s, n, payedDate: STRING;
  t: Double;
BEGIN
  t := 0;
  GetPrintDescr;
  tmpPrntStr := TStringList.Create;
  tmpPrntStr.Add(ccPrintDescr + ': ' + dayMode);
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add('dal ' + DateTimeToStr(fromDt));
  tmpPrntStr.Add('al  ' + DateTimeToStr(todt));
  tmpPrntStr.Add(' ');
  IF rg_cash2client.ItemIndex IN [0, 1, 3, 4, 5] THEN
    BEGIN
      tmpPrntStr.Add('-----------------------------------------');
      tmpPrntStr.Add('CARTA PAGATO BENEFICIARIO         CHF');
      tmpPrntStr.Add('-----------------------------------------');
      WITH qy_Cash2Client DO
        BEGIN
          FIRST;
          WHILE NOT EOF DO
            BEGIN
              t := t + FieldByName('DARE').AsFloat;
              n := Format('%2.2n', [FieldByName('DARE').AsFloat]);
              CASE rg_cash2client.ItemIndex OF
                0: // Ricap clients
                  BEGIN
                    s := Copy(FieldByName('FirstName').AsString, 0, 1) + '.' +
                      FieldByName('LastName').AsString.PadRight(20, ' ') + '   ' +
                      n.PadLeft(7)
                  END;
                1, 3: // Detail clients or day
                  BEGIN
                    IF FieldByName('DataPayedOut').AsVariant <> NULL THEN
                      payedDate := Copy(FieldByName('DataPayedOut').AsString, 0, 5)
                    ELSE
                      payedDate := '     ';
                    s := Copy(FieldByName('Data').AsString, 0, 5) + ' ' +
                      payedDate + ' ' +
                      Copy(FieldByName('FirstName').AsString, 0, 1) + '.' +
                      FieldByName('LastName').AsString.PadRight(17, ' ') + '   ' +
                      n.PadLeft(7);
                  END;
                4: // Detail only payed out CC
                  BEGIN
                    IF FieldByName('Closed').AsBoolean = True THEN
                      BEGIN
                        s := Copy(FieldByName('Data').AsString, 0, 5) + ' ' +
                          Copy(FieldByName('DataPayedOut').AsString, 0, 5) + ' ' +
                          Copy(FieldByName('FirstName').AsString, 0, 1) + '.' +
                          FieldByName('LastName').AsString.PadRight(17, ' ') + '   ' +
                          n.PadLeft(7);
                      END
                    ELSE
                      NEXT;
                  END;
                5: // Detail only still to pay
                  BEGIN
                    IF FieldByName('Closed').AsBoolean = False THEN
                      BEGIN
                        s := Copy(FieldByName('Data').AsString, 0, 5) + ' ' +
                          Copy(FieldByName('DataPayedOut').AsString, 0, 5) + ' ' +
                          Copy(FieldByName('FirstName').AsString, 0, 1) + '.' +
                          FieldByName('LastName').AsString.PadRight(17, ' ') + '   ' +
                          n.PadLeft(7);
                      END
                    ELSE
                      NEXT;
                  END;
              END;
              tmpPrntStr.Add(s);
              NEXT;
            END;
        END;
      tmpPrntStr.Add('-----------------------------------------');
      n := Format('%2.2n', [t]);
      tmpPrntStr.Add('TOTALE'.PadRight(31, ' ') + n.PadLeft(10));
      tmpPrntStr.Add('-----------------------------------------');
      tmpPrntStr.Add('');
      tmpPrntStr.Add('');
    END
  ELSE
    BEGIN
      tmpPrntStr.Add('DATA               CHF');
      tmpPrntStr.Add('----------------------');
      WITH qy_Cash2ClientDaily DO
        BEGIN
          FIRST;
          WHILE NOT EOF DO
            BEGIN
              t := t + FieldByName('CHF').AsFloat;
              n := Format('%2.2n', [FieldByName('CHF').AsFloat]);
              s := FieldByName('Giorno').AsString.PadLeft(2, '0') + '/' +
                FieldByName('Mese').AsString.PadLeft(2, '0') + '/' +
                FieldByName('Anno').AsString.PadLeft(4) + ': ' + n.PadLeft(10);
              tmpPrntStr.Add(s);
              NEXT;
            END;
        END;
      tmpPrntStr.Add('-----------------------------------');
      n := Format('%2.2n', [t]);
      tmpPrntStr.Add('TOTALE'.PadRight(12, ' ') + n.PadLeft(10));
    END;
  tmpPrntStr.Add('-----------------------------------');
  tmpPrntStr.Add('');

  IF Form1.GetCurrentPrinterStatus = 0 THEN
    Form2.t_executePrint(Form1.rg_Printers.Items[Form1.rg_Printers.ItemIndex],
      tmpPrntStr, 0, 1, 11, 120, False)
  ELSE
    ShowMessage('ATTENZIONE, Errore stampante no: ' +
      intToStr(Form1.GetCurrentPrinterStatus));
END;

PROCEDURE TForm5.cal_CCSelectDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
BEGIN
  fDt := RecodeTime(Date, 12, 0, 1, 0);
  tdt := RecodeTime(IncDay(Date, 1), 11, 59, 59, 0);
  rg_cash2clientClick(Sender);
END;

PROCEDURE TForm5.cal_CCSelectMultiDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
BEGIN
  fDt := RecodeTime(StartDate, 12, 0, 0, 0);
  tdt := RecodeTime(IncDay(EndDate, 1), 11, 59, 0, 0);
  rg_cash2clientClick(Sender);
END;

PROCEDURE TForm5.ed_CC_QRCodeButtonClick(Sender: TObject);
BEGIN
  ed_CC_QRCode.Clear;
  bt_PayCard.Enabled := False;
  lb_PayMsg.Caption := '';
  rg_DayMode.Enabled := True;
  rg_cash2client.Enabled := True;
END;

PROCEDURE TForm5.ed_CC_QRCodeChange(Sender: TObject);
BEGIN

  BEGIN
    // Check Credit Card payments
    // --------------------------
    IF Length(ed_CC_QRCode.Text) = 13 THEN
      BEGIN
        rg_DayMode.Enabled := False;
        rg_cash2client.Enabled := False;
        rg_cash2client.ItemIndex := 1;

        WITH qy_Cash2Client DO
          BEGIN
            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Add('SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, '
              + 'Clients.FirstName, Dare, Closed, TxID '
              + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
              + ' WHERE TxID = ' + QuotedStr(ed_CC_QRCode.Text) + ' AND Dare > 0');
            Active := True;
            IF RecordCount > 0 THEN
              IF FieldByName('Closed').AsBoolean = False THEN
                BEGIN
                  dbgd_Cash2Client.Refresh;
                  bt_PayCard.Enabled := True;
                  lb_PayMsg.Caption := 'Paga Carta';
                END
              ELSE
                BEGIN
                  bt_PayCard.Enabled := False;
                  lb_PayMsg.Caption := 'Carta già pagata';
                END
            ELSE
              BEGIN
                bt_PayCard.Enabled := False;
                lb_PayMsg.Caption := 'QR code non esiste';
              END;
          END;
      END;
  END;
END;

PROCEDURE TForm5.FormShow(Sender: TObject);
BEGIN
  dbgd_Cash2Client.Visible := rg_cash2client.ItemIndex IN [0, 1, 3, 4, 5];
  dbgd_Cash2ClientDaily.Visible := rg_cash2client.ItemIndex = 2;
  cal_CC.SelectedDate := Form1.cl_Closing_Cal.Date;
  WITH Form1 DO
    IF HourSpan(sDt, eDT) > 24 THEN
      BEGIN
        fDt := sDt;
        tdt := eDT;
      END
    ELSE
      BEGIN
        fDt := CalsDT;
        tdt := CaleDT;
      END;
  rg_cash2clientClick(Sender);
  cal_CC.MultiSelect := Form1.ClubAccPermissions.ClosingP > 3;
  ed_CC_QRCode.Clear;
  ed_CC_QRCode.SetFocus;
  bt_PayCard.Enabled := False;
  lb_PayMsg.Caption := '';
  rg_DayMode.Enabled := True;
  rg_cash2client.Enabled := True;
  GetPrintDescr;
END;

PROCEDURE TForm5.GetPrintDescr;
BEGIN
  CASE rg_DayMode.ItemIndex OF
    0:
      dayMode := 'Giorno lavoro';
    1:
      dayMode := 'Giorno calendario';
  END;

  CASE rg_cash2client.ItemIndex OF
    0:
      ccPrintDescr := 'Ricap clienti';
    1:
      ccPrintDescr := 'Dettaglio clienti';
    2:
      ccPrintDescr := 'Ricap giorno';
    3:
      ccPrintDescr := 'Dettaglio giorno';
    4:
      ccPrintDescr := 'Dett. pagamenti';
    5:
      ccPrintDescr := 'Dett. da pagare';
  END;
  bt_Print.Caption := ccPrintDescr;
  bt_Print.Font.Color := clBlue;
END;

PROCEDURE TForm5.rg_cash2clientClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  WITH Form1 DO
    BEGIN
      IF rg_DayMode.ItemIndex = 0 THEN
        BEGIN
          fromDt := fDt;
          todt := tdt;
        END
      ELSE
        BEGIN
          todt := IncDay(tdt, -1);
          fromDt := EncodeDateTime(YearOF(fDt), MonthOf(fDt), DayOf(fDt), 00, 00, 00, 0);
          todt := EncodeDateTime(YearOF(todt), MonthOf(todt), DayOf(todt), 23, 59, 59, 999);
        END;
    END;

  CASE rg_cash2client.ItemIndex OF

    0: // Ricap Clients
      BEGIN
        s := 'SELECT Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, '
          + ' sum(clCCledger.Dare) AS Dare FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
          + ' WHERE clCCLedger.Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp)' + ' GROUP BY Clients.Lastname ORDER BY Clients.Alias ASC';
      END;
    1: // Detail clients
      BEGIN
        s := 'SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Dare, clCCLedger.Closed, clCCLedger.TxID '
          + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
          + ' WHERE Dare > 0 AND clCCLedger.Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp)' + ' ORDER BY Clients.Alias ASC, Data';
      END;
    2: // Ricap day
      BEGIN
        s := 'SELECT EXTRACT(DAY FROM Data) as Giorno, EXTRACT(MONTH FROM Data) as Mese, ' +
          ' EXTRACT(YEAR FROM Data) as Anno, sum(clCCledger.Dare) AS CHF FROM ClCCledger ' + 'WHERE Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp) ' + 'GROUP BY Anno, Mese, Giorno ' +
          'ORDER BY Anno, Mese, Giorno';
      END;
    3: // Detail day
      BEGIN
        s := 'SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Dare,clCCLedger.Closed, clCCLedger.TxID '
          + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
          + ' WHERE Dare > 0 AND clCCLedger.Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp)' + ' ORDER BY  Data';
      END;
    4: // Detail only payed
      BEGIN
        s := 'SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Dare,clCCLedger.Closed, clCCLedger.TxID '
          + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
          + ' WHERE Dare > 0 AND Closed = True AND clCCLedger.Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp)' + ' ORDER BY  DataPayedOut';
      END;
    5: // Detail only still to pay
      BEGIN
        s := 'SELECT Data, DataPayedOut, Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Dare,clCCLedger.Closed, clCCLedger.TxID '
          + ' FROM Clients INNER JOIN clCCLedger On Clients.id = clCCLedger.ClientID '
          + ' WHERE Dare > 0 AND Closed = False AND clCCLedger.Data BETWEEN CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', fromDt)) +
          ' AS Timestamp) ' + ' AND CAST(' +
          QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', todt)) +
          ' as Timestamp)' + ' ORDER BY  Data';
      END;

  END;

  dbgd_Cash2Client.Visible := rg_cash2client.ItemIndex IN [0, 1, 3, 4, 5];
  dbgd_Cash2ClientDaily.Visible := (rg_cash2client.ItemIndex = 2);
  IF rg_cash2client.ItemIndex IN [0, 1, 3, 4, 5] THEN
    WITH qy_Cash2Client DO
      BEGIN
        Active := False;
        SQL.Clear;
        SQL.Add(s);
        Active := True;
        Last;
      END
  ELSE
    WITH qy_Cash2ClientDaily DO
      BEGIN
        Active := False;
        SQL.Clear;
        SQL.Add(s);
        Active := True;
      END;
  rg_cash2client.Caption := 'Periodo dal ' + DateTimeToStr(fromDt) +
    ' al ' + DateTimeToStr(todt);
  GetPrintDescr;
  Show;
END;

PROCEDURE TForm5.rg_DayModeClick(Sender: TObject);
BEGIN
  rg_cash2clientClick(Sender);
END;

END.
