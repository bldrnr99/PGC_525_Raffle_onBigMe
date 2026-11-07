UNIT nPrinterTexts;

INTERFACE

USES System.SysUtils, System.Classes, System.DateUtils, System.StrUtils, Windows, Printers, Graphics, JPEG, DB,
  OtlCommon, OtlComm, OtlTask, OtlTaskControl, OtlEventMonitor, Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Math,
  PNGImage, GIFImg;

PROCEDURE nPrintDepositReceipt(depositIN: Boolean; amt: Double; txnID: STRING; pID, copies: Integer);
PROCEDURE PrintABarTicket(vip, tx: STRING; receiptID, copies: Integer; amt: Double);
PROCEDURE t_executePrint(PName: STRING; TextAR: TStrings;
  dCredits, prCopies, header, textPos: Integer; lotteryT, promoT: Boolean);
PROCEDURE OverlayImagesWithResize(BlobField: TBlobField; QRimage: TImage; X, Y, NewWidth, NewHeight: Integer);
PROCEDURE nPrintSwitch;
PROCEDURE nPrintTaxReceipt(amt: Double; tx: STRING; pID, copies: Integer);
PROCEDURE nPrintCCReceipt(amt: Double; tx: STRING; pID, copies: Integer);
PROCEDURE nPrintLotteryTicket;
PROCEDURE nPrintPromoTicket;
PROCEDURE nPrintCCConfirmation(amt: Double; tx: STRING; pID, copies: Integer);

IMPLEMENTATION

// {$R *.dfm}

USES
  DM1, OtlParallel, Main, Cash2Clients;

PROCEDURE nPrintSwitch;
VAR
  sleepTm: Integer;
  amt: Double;
BEGIN
  WITH Form1, Form2, qy_WriteOtabToAccounts DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT *,Count(ReceiptID) as tCopies FROM OpenTab WHERE FeeID > 0 AND ReceiptCopies > 0 ' +
      'Group by FeeID');
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      First;
      WHILE NOT EOF DO
      BEGIN
        TRY
          dbimg_Body.Picture.Assign(dbimg_Body.Picture);
        EXCEPT
          ON E: Exception DO
          BEGIN
            dbimg_Body.Picture.Assign(NIL);
          END;
        END;
        Sleep(10);

        IF RecordCount > 1 THEN
          sleepTm := ed_PrinterSleepTm.Value * 1000
        ELSE
          sleepTm := 0;

        // BAR Entrance, vip and show tickets
        // ----------------------------------
        IF (FieldByName('FeeID').AsInteger IN [1, 2, 12])
          AND (FieldByName('ReceiptCopies').AsInteger > 0) THEN
        BEGIN
          IF FieldByName('ReceiptCopies').AsString <> 'OF' THEN
            nPrinterTexts.PrintABarTicket(FieldByName('FeeID').AsString, txnID,
              FieldByName('ReceiptID').AsInteger,
              FieldByName('tCopies').AsInteger, FieldByName('DrinkCreditValue').AsFloat);
        END;

        // Girl entranc e tickets
        // -----------------------------------
        IF (FieldByName('FeeID').AsInteger = 3)
          AND (FieldValues['DrinkCreditValue'] > 0)
          AND (FieldByName('ReceiptCopies').AsInteger > 0) THEN
        BEGIN
          IF FieldByName('ReceiptCopies').AsString <> 'OF' THEN
            nPrinterTexts.PrintABarTicket(FieldByName('FeeID').AsString, txnID,
              FieldByName('ReceiptID').AsInteger,
              FieldByName('tCopies').AsInteger, FieldByName('DrinkCreditValue').AsFloat);
        END;

        // Tax receipts
        // -----------------------------------
        IF (FieldByName('FeeID').AsInteger = 900)
          AND (FieldByName('ReceiptCopies').AsInteger > 0) THEN
          nPrintTaxReceipt(FieldByName('AmountCHF').AsFloat,
            txnID,
            FieldByName('ReceiptID').AsInteger,
            FieldByName('ReceiptCopies').AsInteger);

        // Room rental deposit receipts
        // -----------------------------------
        IF (FieldByName('SubFeeID').AsInteger = 299)
          AND (FieldByName('ReceiptCopies').AsInteger > 0) THEN
        BEGIN
          IF FieldByName('AmountCHF').AsFloat > 0 THEN
            amt := FieldByName('amountCHF').AsFloat
          ELSE
            amt := FieldByName('AmountEuro').AsFloat;
          nPrinterTexts.nPrintDepositReceipt(ThisBooking.reemboursment,
            amt, txnID, FieldByName('ReceiptID').AsInteger,
            FieldByName('ReceiptCopies').AsInteger);
        END;

        // CC to girls receipts
        // -----------------------------------
        IF (FieldByName('FeeID').AsInteger = 99)
          AND (FieldByName('ReceiptCopies').AsInteger > 0) THEN
          { nPrintCCReceipt(FieldByName('Dare').AsFloat,
            txnID,
            FieldByName('ReceiptID').AsInteger,
            FieldByName('ReceiptCopies').AsInteger); }
          nPrintCCConfirmation(FieldByName('AmountCHF').AsFloat, txnID, FieldByName('ReceiptID').AsInteger,
            FieldByName('ReceiptCopies').AsInteger);
        Sleep(sleepTm);
        Next;
      END;
      Active := False;
    END;
  END;
END;

PROCEDURE nPrintPromoTicket;
VAR
  tmpPrntStr: TStrings;
BEGIN
  WITH Form1 DO
  BEGIN
    (*
      tmpPrntStr := TStringList.Create;
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add('- XXXXXXXXXXXX -');
      tmpPrntStr.Add(RightStr(txnID, 5));
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      ///tmpPrntStr.Add('Data: ' + DateTimeToStr(now));
      tmpPrntStr.Add(' ');
      //tmpPrntStr.Add(txnID + ' ' + intToStr(ThisClient.ID));
      tmpPrntStr.Add('XXXXXXXXXXXX ');
      tmpPrntStr.Add('_');
      IF GetCurrentPrinterStatus = 0 THEN
      t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
      0, 2, 10, 270, False)
      ELSE
      BEGIN
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
      intToStr(GetCurrentPrinterStatus));
      c_Fee := 0;
      c_sameFeeItem := 0;
      c_DrinkCredits := 0;
      END;
    *)
  END;
END;

PROCEDURE nPrintLotteryTicket;
VAR
  tmpPrntStr: TStrings;
BEGIN
  WITH Form1 DO
  BEGIN
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('- CODICE -');
    tmpPrntStr.Add(RightStr(txnID, 5));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('Data: ' + DateTimeToStr(now));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(txnID + ' ' + intToStr(ThisClient.ID));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF GetCurrentPrinterStatus = 0 THEN
      nPrinterTexts.t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        0, 2, 9, 270, False, False)
    ELSE
    BEGIN
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
      c_Fee := 0;
      c_sameFeeItem := 0;
      c_DrinkCredits := 0;
    END;
  END;
END;

PROCEDURE nPrintDepositReceipt(depositIN: Boolean; amt: Double; txnID: STRING; pID, copies: Integer);
VAR
  tmpPrntStr: TStrings;
  paymethod: STRING;
BEGIN
  IF (Form1.ThisBooking.depositPaymethod = 'CH') OR (Form1.ThisBooking.depositPaymethod = 'CC') THEN
    paymethod := 'CHF'
  ELSE
    paymethod := '€';
  WITH Form1 DO
  BEGIN
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    IF NOT ThisBooking.reemboursment THEN
    BEGIN
      tmpPrntStr.Add('Con la presente la ' + ed_CompanyName.Text + ' dichiara');
      tmpPrntStr.Add('di aver ricevuto in data odierna da:');
      tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' +
        TrimRight(ThisClient.lName));
      tmpPrntStr.Add(TrimRight(ThisClient.Address));
      tmpPrntStr.Add(TrimRight(ThisClient.Cap) + ' ' +
        TrimRight(ThisClient.City));
      tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
      tmpPrntStr.Add('ID Teseu: ' + TrimRight(ThisClient.IDTeseu));
      tmpPrntStr.Add('la somma di ' + FormatFloat('#,##0.00', amt) + ' ' + paymethod);
      tmpPrntStr.Add('quale garanzia per l''inventario ');
      tmpPrntStr.Add('e l''affitto inerente l''abitazione');
      tmpPrntStr.Add('in via ' + ThisBooking.Address);
      tmpPrntStr.Add('messa a sua disposizione per ');
      tmpPrntStr.Add('soggiornare.');
    END
    ELSE
    BEGIN
      tmpPrntStr.Add('La sottoscritta ');
      tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' +
        TrimRight(ThisClient.lName));
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add('dichiara di aver ricevuto ');
      tmpPrntStr.Add('in data odierna  dalla ' + ed_CompanyName.Text);
      tmpPrntStr.Add('la somma di ' + FormatFloat('#,##0.00', amt) + ' ' + paymethod);
      tmpPrntStr.Add('quale rimborso della cauzione ');
      tmpPrntStr.Add('abitazione del ' + DateTimeToStr(DateOF(ThisBooking.DepositInDt)));
    END;
    tmpPrntStr.Add('-----------------------------------');
    IF ThisBooking.reemboursment THEN
    BEGIN
      tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' +
        TrimRight(ThisClient.lName));
      tmpPrntStr.Add(TrimRight(ThisClient.Address));
      tmpPrntStr.Add(TrimRight(ThisClient.Cap) + ' ' +
        TrimRight(ThisClient.City));
      tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
    END;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('(Firma) ');
    tmpPrntStr.Add('Chiasso, il ' + DateToStr(Date));
    tmpPrntStr.Add('Reg:' + txnID);
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF GetCurrentPrinterStatus = 0 THEN
      t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        0, copies, pID, 120, False, False)
    ELSE
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
  END;
END;

PROCEDURE PrintABarTicket(vip, tx: STRING; receiptID, copies: Integer; amt: Double);
VAR
  tmpPrntStr: TStrings;
  Y: Integer;
BEGIN
  WITH Form1 DO
  BEGIN
    Y := dbimg_Body.Picture.Graphic.Height;
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ' + DateTimeToStr(now));
    tmpPrntStr.Add(' ' + txnID + ' ' + intToStr(ThisClient.ID));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF GetCurrentPrinterStatus = 0 THEN
      t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        c_DrinkCredits, copies, receiptID, Y - 100, lotteryT, promoT)
    ELSE
    BEGIN
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
      c_Fee := 0;
      c_sameFeeItem := 0;
      c_DrinkCredits := 0;
    END;
  END;
END;

PROCEDURE nPrintCCReceipt(amt: Double;
  tx: STRING; pID, copies: Integer);
VAR
  tmpPrntStr: TStrings;
BEGIN
  WITH Form1 DO
  BEGIN
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('Con la presente confermo ');
    IF ThisClient.iban <> '' THEN
    BEGIN
      tmpPrntStr.Add('di voler ricevere sul conto IBAN');
      tmpPrntStr.Add(ThisClient.iban);
    END
    ELSE
    BEGIN
      tmpPrntStr.Add('di aver ricevuto dalla ' + ed_CompanyName.Text + ',');
      tmpPrntStr.Add('Chiasso, in data odierna ');
    END;
    tmpPrntStr.Add('l''intero importo ');
    tmpPrntStr.Add('di ' + FormatFloat('#,##0.00', amt) + ' CHF');
    tmpPrntStr.Add('incassato da quest''ultima ');
    tmpPrntStr.Add('per mio conto da un mio cliente.');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' +
      TrimRight(ThisClient.lName));
    tmpPrntStr.Add(TrimRight(ThisClient.Address));
    tmpPrntStr.Add(TrimRight(ThisClient.Cap) + ' ' +
      TrimRight(ThisClient.City));
    tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('(Firma) ');
    tmpPrntStr.Add('Chiasso, il ' + DateToStr(Date));
    tmpPrntStr.Add('Reg:' + tx);
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF ThisClient.iban <> '' THEN
      pID := 22;
    IF GetCurrentPrinterStatus = 0 THEN
      nPrinterTexts.t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        0, copies, pID, 190, False, False)
    ELSE
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
  END;
END;

PROCEDURE nPrintTaxReceipt(amt: Double;
  tx:
  STRING;
  pID, copies: Integer);
VAR
  tmpPrntStr: TStrings;
BEGIN
  WITH Form1 DO
  BEGIN
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('Con la presente la ' + ed_CompanyName.Text + ' dichiara');
    tmpPrntStr.Add('di aver ricevuto in data odierna da:');
    tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' +
      TrimRight(ThisClient.lName));
    tmpPrntStr.Add(TrimRight(ThisClient.Address));
    tmpPrntStr.Add(TrimRight(ThisClient.Cap) + ' ' +
      TrimRight(ThisClient.City));
    tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
    tmpPrntStr.Add('ID Teseu: ' + TrimRight(ThisClient.IDTeseu));
    tmpPrntStr.Add('di ' + FormatFloat('#,##0.00', amt) + ' CHF');
    tmpPrntStr.Add('destinato al pagamento di  imposte ');
    tmpPrntStr.Add('come da LProst del 5.6.2019, ');
    tmpPrntStr.Add('dovute per l''odierno giorno lavorativo.');
    tmpPrntStr.Add('La ' + ed_CompanyName.Text + ' s''impegna');
    tmpPrntStr.Add('di versare tale importo in tempo utile  ');
    tmpPrntStr.Add('alle autorità fiscali ticinesi.');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('(Firma per la Opas SA) ');
    tmpPrntStr.Add('Chiasso, il ' + DateToStr(Date));
    tmpPrntStr.Add('Reg:' + tx);
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF GetCurrentPrinterStatus = 0 THEN
      nPrinterTexts.t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        0, copies, pID, 120, False, False)
    ELSE
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
  END;
END;

PROCEDURE nPrintCCConfirmation(amt: Double; tx: STRING; pID, copies: Integer);
VAR
  tmpPrntStr: TStrings;
BEGIN
  WITH Form1 DO
  BEGIN
    tmpPrntStr := TStringList.Create;
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('Con la presente la ' + ed_CompanyName.Text + ' conferma ');
    tmpPrntStr.Add('di aver eseguito per ordine di ');
    tmpPrntStr.Add('un cliente esterno e a favore di ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(TrimRight(ThisClient.fName) + ' ' + TrimRight(ThisClient.lName));
    tmpPrntStr.Add(TrimRight(ThisClient.Address));
    tmpPrntStr.Add(TrimRight(ThisClient.Cap) + ' ' +
      TrimRight(ThisClient.City));
    tmpPrntStr.Add('SIMIC: ' + TrimRight(ThisClient.SIMIC));
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('un incasso da carta di credito per ');
    tmpPrntStr.Add('un importo netto di ' + FormatFloat('#,##0.00', amt) + ' CHF.');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('Il relativo importo potrà essere ');
    tmpPrntStr.Add('riscosso dalla beneficiaria, ');
    tmpPrntStr.Add('salvo buon fine e non appena la società ');
    tmpPrntStr.Add('delle carte di credito avrà');
    tmpPrntStr.Add('effettuato il relativo versamento ');
    tmpPrntStr.Add('sul conto corrente della ' + ed_CompanyName.Text + '.');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('-----------------------------------');
    tmpPrntStr.Add('(Firma) ');
    tmpPrntStr.Add('Chiasso, il ' + DateToStr(Date));
    tmpPrntStr.Add('Reg:' + tx);
    tmpPrntStr.Add(' ');
    tmpPrntStr.Add('_');
    IF ThisClient.iban <> '' THEN
      pID := 22;
    IF GetCurrentPrinterStatus = 0 THEN
      nPrinterTexts.t_executePrint(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
        0, copies, pID, 190, False, False)
    ELSE
      ShowMessage('ATTENZIONE, Errore stampante no: ' +
        intToStr(GetCurrentPrinterStatus));
  END;
END;

PROCEDURE t_executePrint(PName: STRING; TextAR: TStrings; dCredits, prCopies, header, textPos: Integer;
  lotteryT, promoT: Boolean);
VAR
  myPrinter: TPrinter;
  Device: ARRAY [0 .. 255] OF Char;
  Driver: ARRAY [0 .. 255] OF Char;
  Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
  I, X: word;
BEGIN
  Async(
    PROCEDURE
    BEGIN
      Form1.nPrintJobDone := False;
      Printer.PrinterIndex := Printer.Printers.IndexOf(PName);
      Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
      myPrinter := Printer;
      X := 0;
      TRY
        Form1.dbimg_Body.Picture.Assign(Form1.dbimg_Body.Picture);
      EXCEPT
        ON E: Exception DO
        BEGIN
          Form1.dbimg_Body.Picture.Assign(NIL);
        END;
      END;
      Sleep(10);

      WHILE (X < prCopies) DO
        WITH myPrinter DO
        BEGIN
          // Print Headers
          BeginDoc;
          CASE header OF
            0:
              Exit;

            1: // Bar ticket header
              BEGIN
                Sleep(10);
                SetTextAlign(myPrinter.Handle, TA_Center);
                Canvas.Draw(0, 0, Form1.dbimg_Body.Picture.Graphic);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                IF Form1.dbimg_Body.Picture.Height < 130 THEN
                BEGIN
                  Canvas.TextOut(250, 140, 'Benvenuto al');
                  Canvas.Font.Size := 20;
                  Canvas.Font.Name := 'Times New Roman';
                  Canvas.Font.Style := [fsBold];
                  Canvas.TextOut(250, 170, 'POMPEII');
                  Canvas.Font.Name := 'Tahoma';
                  Canvas.Font.Style := [];
                  Canvas.Font.Size := 12;
                  Canvas.TextOut(250, 220, 'Gentlemen''s Club');
                END;
                SetTextAlign(myPrinter.Handle, TA_LEFT);
              END;

            2: // Credit card receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Draw(220, 0, Form1.Barcode1.Bitmap);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 110, 'CONFERMA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 170, 'Carta di Credito');
              END;
            3: // Liberatoria fotografica header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 18;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'LIBERATORIA');
                Canvas.TextOut(20, 100, 'FOTOGRAFICA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            4: // Rooms to clean header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'Info per pulizia');
                Canvas.TextOut(20, 100, 'Utilizzo stanze');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            5: // Evaluation header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'Valutazione tempi');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
              END;
            6: // Daily Tax receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per imposta giornaliera');
              END;
            7: // Recap Expenses receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 20, 'R i c a p i t o l a z i o n e');
                Canvas.TextOut(20, 50, 'ricevute spese');
                Canvas.TextOut(20, 80, '-----------------------------');
                Canvas.TextOut(20, 110, ' ');
                Canvas.Font.Size := 12;
              END;
            8: // Girl Promo Entrance fee header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Draw(0, 0, Form1.dbimg_Body.Picture.Graphic);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 140, 'WISH YOU A LUCKY DAY');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 170, '        POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 220, '              Gentlemen''s Club');
              END;
            9: // Lottery ticket header
              BEGIN
                SetTextAlign(myPrinter.Handle, TA_Center);
                Canvas.Draw(0, 0, Form1.Image4.Picture.Graphic);
                Canvas.Draw(220, 0, Form1.Barcode1.Bitmap);
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 140, 'LA FORTUNA BENDATA AL');
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Times New Roman';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(250, 170, 'POMPEII');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(250, 220, 'Gentlemen''s Club');
                SetTextAlign(Printer.Handle, TA_LEFT);
              END;

            11: // Credit Card to clients recap header for administrative purposes
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 12;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 50, 'POMPEII');
                Canvas.Font.Name := 'Times New Roman';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 10;
                Canvas.TextOut(20, 80, 'Gentlemen''s Club');
                Canvas.Font.Size := 12;
                SetTextAlign(Printer.Handle, TA_LEFT);
              END;
            22: // Credit card receipt header with IBAN
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'CONFERMA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per rimborso da carta di credito');
              END;

            25: // Credit card CASH receipt header
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                Canvas.TextOut(20, 90, 'per rimborso da carta di credito');
              END;
            29: // Rental Deposit
              BEGIN
                SetTextAlign(Printer.Handle, TA_LEFT);
                Canvas.Font.Size := 20;
                Canvas.Font.Name := 'Trajan Pro';
                Canvas.Font.Style := [fsBold];
                Canvas.TextOut(20, 40, 'RICEVUTA');
                Canvas.Font.Name := 'Tahoma';
                Canvas.Font.Style := [];
                Canvas.Font.Size := 12;
                IF Form1.ThisBooking.reemboursment THEN
                  Canvas.TextOut(20, 90, 'RIMBORSO CAUZIONE AFFITTO')
                ELSE
                  Canvas.TextOut(20, 90, 'CAUZIONE AFFITTO CAMERA');
              END;
          END;
          // Print text
          I := 0;
          SetTextAlign(Printer.Handle, TA_LEFT);
          WHILE I < TextAR.Count DO
          BEGIN
            Canvas.TextOut(20, textPos + (I * 30), TextAR.Strings[I]);
            inc(I);
          END;
          EndDoc;
          inc(X);
        END;

      // Print Lottery ticket
      IF lotteryT THEN
      BEGIN
        // Add the letter R (Raffle) to txID
        WITH Form1 DO
        BEGIN
          Barcode1.InputText := 'R' + txnID;
          TRY
            img_QRcode.Picture.Assign(Barcode1.Bitmap);
          EXCEPT
            ON E: Exception DO
            BEGIN
              img_QRcode.Picture.Assign(NIL);
            END;
          END;
        END;
        X := 0;
        WHILE (X < 2) DO
        BEGIN
          WITH myPrinter DO
          BEGIN
            BeginDoc;
            IF X = 0 THEN
            BEGIN
              SetTextAlign(myPrinter.Handle, TA_Center);
              // Canvas.Draw(0, 0, Form1.Image4.Picture.Graphic);
              Canvas.Draw(0, 0, Form1.dbimg_Body.Picture.Graphic);
              Canvas.Draw(220, 0, Form1.img_QRcode.Picture.Graphic);
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 140, Form1.ed_LotteryT.Text);
              Canvas.Font.Size := 20;
              Canvas.Font.Name := 'Times New Roman';
              Canvas.Font.Style := [fsBold];
              Canvas.TextOut(250, 170, 'POMPEII');
              Canvas.Font.Name := 'Tahoma';
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 220, 'Gentlemen''s Club');
            END;
            IF X > 0 THEN
            BEGIN
              Canvas.Font.Name := 'Tahoma';
              Canvas.Font.Style := [];
              Canvas.Font.Size := 12;
              Canvas.TextOut(250, 220, 'Ticket Club');
            END;
            Canvas.Font.Style := [fsBold];
            Canvas.Font.Size := 24;
            Canvas.TextOut(250, 300, '*' + RightStr(Form1.txnID, 5) + '*');
            Canvas.Font.Style := [];
            Canvas.Font.Size := 12;
            Canvas.TextOut(250, 500, DateTimeToStr(now));
            EndDoc;
          END;
          inc(X);
        END;
      END;

      IF promoT THEN
      BEGIN
        WITH myPrinter DO
        BEGIN
          (*
            BeginDoc;
            SetTextAlign(myPrinter.Handle, TA_Center);
            Canvas.Font.Size := 20;
            Canvas.Font.Name := 'Times New Roman';
            Canvas.Font.Style := [fsBold];
            Canvas.TextOut(250, 0, 'POMPEII');

            Canvas.Font.Name := 'Tahoma';
            Canvas.Font.Style := [];
            Canvas.Font.Size := 12;
            // Canvas.TextOut(250, 50, Form1.ed_PromoTxt0.Text);
            // Canvas.Draw(120, 110, Form1.db_PromoImage.Picture.Graphic);
            Canvas.Draw(120, 110, Form1.Image5.Picture.Graphic);

            Canvas.TextOut(257, 400, Form1.ed_PromoTxt1.Text);
            Canvas.TextOut(257, 440, Form1.ed_PromoTxt2.Text);
            Canvas.Font.Size := 10;

            Canvas.TextOut(257, 490, Form1.ed_PromoTxt3.Text);
            Canvas.TextOut(250, 540, DateTimeToStr(now));
            EndDoc;
          *)
        END;
      END;
    END).Await(
    PROCEDURE
    BEGIN
      TextAR.Free;
      Form1.nPrintJobDone := True;
    END);
END;

PROCEDURE OverlayImagesWithResize(BlobField: TBlobField; QRimage: TImage; X, Y, NewWidth, NewHeight: Integer);
VAR
  BackgroundBitmap, ResizedBitmap: TBitmap;
  BlobStream: TStream;
  Picture: TPicture;
  ScaleFactor: Double;
BEGIN
  // Check if the BlobField is not empty
  IF BlobField.IsNull THEN
  // raise Exception.Create('BlobField does not contain any image data.');
  BEGIN
    Form1.RzStatusPane1.Caption := 'BlobField does not contain any image data.';
    Exit;
  END
  ELSE
    Form1.RzStatusPane1.Caption := '';
  // Create a stream to read the BLOB data
  BlobStream := BlobField.DataSet.CreateBlobStream(BlobField, bmRead);
  TRY
    // Create a TPicture to handle multiple image formats
    Picture := TPicture.Create;
    TRY
      // Load the image data from the stream
      Picture.LoadFromStream(BlobStream);
    EXCEPT
      ON E: Exception DO
      BEGIN
        Picture.Free;
        RAISE Exception.CreateFmt('Unable to load image from BlobField: %s', [E.Message]);
      END;
    END;
  FINALLY
    BlobStream.Free;
  END;

  TRY
    // Convert the loaded graphic to a bitmap
    BackgroundBitmap := TBitmap.Create;
    TRY
      BackgroundBitmap.SetSize(Picture.Width, Picture.Height);
      BackgroundBitmap.PixelFormat := pf24bit;
      BackgroundBitmap.Canvas.Draw(0, 0, Picture.Graphic);
    FINALLY
      Picture.Free;
    END;

    // Ensure Image3 contains a valid image
    IF QRimage.Picture.Graphic = NIL THEN
      RAISE Exception.Create('Image3 does not contain a valid image.');

    // Calculate ScaleFactor if the overlay exceeds boundaries
    IF (X + NewWidth > BackgroundBitmap.Width) OR (Y + NewHeight > BackgroundBitmap.Height) THEN
    BEGIN
      ScaleFactor := Min(
        (BackgroundBitmap.Width - X) / NewWidth,
        (BackgroundBitmap.Height - Y) / NewHeight
        );
      NewWidth := Round(NewWidth * ScaleFactor);
      NewHeight := Round(NewHeight * ScaleFactor);
    END;

    // Create a temporary bitmap to hold the resized version of Image3
    ResizedBitmap := TBitmap.Create;
    TRY
      ResizedBitmap.Width := NewWidth;
      ResizedBitmap.Height := NewHeight;

      // Resize qrImage by drawing it into ResizedBitmap
      ResizedBitmap.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), QRimage.Picture.Graphic);

      // Draw the resized bitmap on top of BackgroundBitmap at the specified position
      BackgroundBitmap.Canvas.Draw(X, Y, ResizedBitmap);

      // Assign the modified bitmap to printImage
      IF Assigned(Form1.dbimg_Body) THEN
      BEGIN
        Form1.dbimg_Body.Picture.Graphic := BackgroundBitmap;
        Form1.dbimg_Body.Repaint;
      END
      ELSE
        RAISE Exception.Create('printImage component is not assigned.');
    FINALLY
      ResizedBitmap.Free;
    END;
  FINALLY
    BackgroundBitmap.Free;
  END;
END;

END.
