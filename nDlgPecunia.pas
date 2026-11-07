UNIT nDlgPecunia;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Math,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothTouchKeyBoard,
  AdvGlassButton, Vcl.Mask, DBCtrlsEh, System.StrUtils, Vcl.ExtCtrls,
  JvExControls, JvLED, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.ComCtrls, System.Types, DateUtils, Vcl.Menus,
  Vcl.ImgList, PictureContainer, System.ImageList, System.UiTypes, // EhLibVCL,
  AdvSmoothLedLabel, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh,GridsEh, DBAxisGridsEh, DBGridEh, GDIPPictureContainer,
  Vcl.Imaging.pngimage, JvExExtCtrls, ShellApi, JvBaseDlg, JvCalc, Data.DB,
  edbcomps;

TYPE
  TdlgnPecunia = CLASS(TForm)
    tkb: TAdvSmoothTouchKeyBoard;
    bt_CHF: TAdvGlassButton;
    bt_Euro: TAdvGlassButton;
    bt_CC: TAdvGlassButton;
    bt_Offered: TAdvGlassButton;
    bt_PagaDopo: TAdvGlassButton;
    Edit2: TEdit;
    DoNotRemove: TPictureContainer;
    GDIPPictureContainer1: TGDIPPictureContainer;
    bt_QR: TAdvGlassButton;
    ed_PecQrCode: TEdit;
    mm_Raffle: TMemo;
    PROCEDURE tkbKeyClick(Sender: TObject; Index: Integer);
    PROCEDURE bt_CCClick(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE nEnableButtons(ch, eu, cc, off, pd: Boolean);
    PROCEDURE WritePayment(pecunia: STRING; pecuniaID: Integer);
    PROCEDURE bt_OfferedClick(Sender: TObject);
    PROCEDURE bt_PagaDopoClick(Sender: TObject);
    PROCEDURE bt_EuroClick(Sender: TObject);
    PROCEDURE bt_CHFClick(Sender: TObject);
    FUNCTION CalcClientCost: Double;
    PROCEDURE nPrepareForParty(isPay, isDrinks: Boolean);
    PROCEDURE bt_QRClick(Sender: TObject);
    PROCEDURE ed_PecQrCodeChange(Sender: TObject);
  PRIVATE
    { Private declarations }

  PUBLIC
    { Public declarations }
  END;

VAR
  dlgnPecunia: TdlgnPecunia;
  tmpkbAmtStr, kbAmtStr, kbInfo, tx, raffleTx: STRING;
  kbAmt, assignedPdAmt, allowedPdAmt, cCost, nPartyAmt: Double;
  decimalCount: Integer;
  canBeOffered, openFeeAmt, isVipParty, nIsPay, nIsdrinks: Boolean;
  P: TPoint;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main, nDlgAmt;

PROCEDURE TdlgnPecunia.FormShow(Sender: TObject);
BEGIN
  dlgnPecunia.Left := 802;
  dlgnPecunia.Top := 500;
  P := Form1.ClientToScreen(Point(0, 0));
  dlgnPecunia.Left := dlgnPecunia.Left + P.X;
  dlgnPecunia.Top := dlgnPecunia.Top + P.Y;
  kbInfo := '';
  tkb.SetFocus;
  WITH Form1, Form2 DO
    BEGIN
      // ManageAds('PayType', nSubFeeID);
      cc1 := False;
      dbgd_CashierDisplay.SumList.RecalcAll;
      dbgd_CashierDisplay.Refresh;
      IF (tb_OTab.RecordCount > 0) AND (tb_OTab.FieldByName('TxID').AsString <> '')
        AND (tb_OTab.FieldByName('Registered').AsBoolean = True) THEN
        tx := tb_OTab.FieldByName('TxID').AsString;
      canBeOffered := tb_Fees.FieldByName('CanBeOffered').AsBoolean;
      kbAmt := 0;
      tmpkbAmtStr := '';

      IF (tb_OTab.FieldByName('FeeID').AsInteger = 1) AND (FeeEuro > 0) THEN
        bt_Euro.Caption := '€ ' + FormatFloat('#,##0.00', FeeEuro)
      ELSE
        bt_Euro.Caption := '€';

      IF VTtxId <> '' THEN
        BEGIN
          WITH qy_Tmp DO
            BEGIN
              IF Active THEN // Get possible PD amt
                Close;
              SQL.Clear;
              DataBaseName := 'DB_Bar';
              SQL.Add('SELECT MAX(Data) FROM Bar_SoldByDetail ' +
                'WHERE SoldBy = ' + IntToStr(ThisClient.ID) +
                ' AND AVERE = 0 AND Data >  CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', IncDay(sDt, -30))) +
                ' AS Timestamp) ');
              Active := True;
              IF RecordCount > 0 THEN
                tkb.Keys[1].Caption := 'VT ' + FormatFloat('#,##0.00', (ed_amtMarchetta.Value / 100) * ed_VatTax.Value)
              ELSE
                tkb.Keys[1].Caption := '';
            END;
        END
      ELSE
        tkb.Keys[1].Caption := '';

      WITH qy_Tmp DO
        BEGIN
          IF Active THEN // Get possible PD amt
            Close;
          SQL.Clear;
          DataBaseName := 'PGC_DB_Unicode';
          SQL.Add('SELECT COALESCE(SUM(Dare),0) - COALESCE(SUM(Avere),0) AS sB FROM OpenTab WHERE DirectDebit = False' +
            ' AND Registered = False');
          Active := True;
          IF RecordCount > 0 THEN
            allowedPdAmt := FieldValues['sB'];
          Active := False;
        END;
      nEnableButtons(True, True, True, False, True);
      WITH tb_OTab DO
        BEGIN
          First;
          IF FieldByName('SubfeeID').AsInteger = 899 THEN // Bar to reception deferred payment
            BEGIN
              allowedPdAmt := 0;
            END;
        END;

      IF (allowedPdAmt > 0) THEN
        BEGIN
          bt_PagaDopo.Caption := FormatFloat('#,##0.00', allowedPdAmt);
          bt_PagaDopo.Enabled := True;
        END
      ELSE
        BEGIN
          bt_PagaDopo.Caption := '';
          bt_PagaDopo.Enabled := False;
        END;

      CASE tb_Fees.FieldByName('ID').AsInteger OF
        1, 2:
          BEGIN
            kbInfo := 'Importo Entrata: ';

          END;
        3:
          BEGIN
            nnWriteCashierDisplay(0, False, clLime, '', 2);
            nnWriteCashierDisplay(0, False, clLime, 'Entrata giornaliera ' + tb_Fees.FieldByName('Description').AsString, 1);
            kbInfo := 'Importo Giornaliera: ';

          END;
        900:
          BEGIN
            IF Form2.tb_Fees.FieldByName('SubID').AsInteger = 9999 THEN
              BEGIN
                nEnableButtons(True, True, True, False, False);
                kbInfo := 'Imposta giornaliera: ';

              END;
          END
      ELSE
        BEGIN
          nnWriteCashierDisplay(0, True, clWhite, 'Immetti valuta o importo e valuta!', 1);
        END;
      END;

      IF nClosingOldBal THEN
        BEGIN
          // nnWriteCashierDisplay(0,False, clWhite, 'Stai per chiudere la posizione aperta di ' + ThisClient.alias, 0);
          nnWriteCashierDisplay(0, False, clLime, 'Procedi all''incasso >', 1);
        END;

      nnWriteCashierDisplay(0, False, clWhite, 'Tessera in uso: ' + IntToStr(ThisCard.cardID) + '  ' + ThisClient.alias, 2);
      tb_OTab.First;
      IF tb_OTab.FieldByName('SubFeeID').AsInteger = 990 THEN // VIP Party
        nPrepareForParty(False, False)
      ELSE
        isVipParty := False;

      // ManageAds(tb_OTab.FieldByName('SubFeeID').AsInteger, 3);
    END;

END;

PROCEDURE TdlgnPecunia.nPrepareForParty(isPay, isDrinks: Boolean);
BEGIN
  isVipParty := True;
  nIsPay := isPay;
  nIsdrinks := isDrinks;
  IF NOT isPay THEN
    BEGIN
      IF NOT isDrinks THEN
        BEGIN
          nEnableButtons(False, False, False, False, False);
          Form1.nnWriteCashierDisplay(0, True, clWhite, 'Immetti prima l''importo della VIP Party deducendo ', 1);
          Form1.nnWriteCashierDisplay(0, False, clWhite, 'eventuali acconti..', 2);
        END
      ELSE
        BEGIN
          kbAmt := 0;
          tmpkbAmtStr := '';
          kbAmtStr := '';
          Form1.nnWriteCashierDisplay(0, False, clWhite, 'Ora immetti il valore drinks compreso.. ', 2);
        END;
    END
  ELSE
    BEGIN
      nEnableButtons(True, True, True, False, True);
    END;
END;

PROCEDURE TdlgnPecunia.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  WITH Form1 DO
    BEGIN
      Form1.bt_Cancel.Enabled := True;
      pl_MainButtons.Enabled := True;
    END;
END;

PROCEDURE TdlgnPecunia.bt_CCClick(Sender: TObject);
BEGIN
  WritePayment('CC', bt_CC.Tag);
END;

PROCEDURE TdlgnPecunia.bt_CHFClick(Sender: TObject);
BEGIN
  WritePayment('CH', bt_CHF.Tag);
END;

PROCEDURE TdlgnPecunia.bt_EuroClick(Sender: TObject);
BEGIN
  WritePayment('EU', bt_Euro.Tag);
END;

PROCEDURE TdlgnPecunia.bt_OfferedClick(Sender: TObject);
BEGIN
  WritePayment('OF', bt_Offered.Tag);
END;

PROCEDURE TdlgnPecunia.bt_PagaDopoClick(Sender: TObject);
BEGIN
  WritePayment('PD', bt_PagaDopo.Tag);
END;

PROCEDURE TdlgnPecunia.bt_QRClick(Sender: TObject);
VAR
  s: STRING;
  dir: WideString;
BEGIN
  dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0)))) + '\Images & Icons\PosPrinterDis.png';
  IF StrToFloatDef(bt_QR.Caption, 0) > 0 THEN
    BEGIN
      WritePayment('OF', bt_QR.Tag);
      bt_QR.Caption := '';
      bt_QR.Enabled := True;
      ed_PecQrCode.Clear;
      bt_QR.Picture.LoadFromFile(dir);
    END
  ELSE
    BEGIN
      ed_PecQrCode.Clear;
      mm_Raffle.Clear;
      mm_Raffle.Lines.Add('Scanneriza il ticket..');
      ActiveControl := ed_PecQrCode;
      bt_QR.Caption := '0.00';
    END;

END;

PROCEDURE TdlgnPecunia.nEnableButtons(ch, eu, cc, off, pd: Boolean);
BEGIN
  bt_CHF.Enabled := ch;
  IF ch = False THEN
    bt_CHF.BackColor := $00444444
  ELSE
    bt_CHF.BackColor := clRed;
  bt_Euro.Enabled := eu;
  IF eu = False THEN
    bt_Euro.BackColor := $00444444
  ELSE
    bt_Euro.BackColor := clNavy;
  bt_CC.Enabled := cc;

  IF off THEN
    bt_Offered.Enabled := (canBeOffered) AND (Form1.ClubAccPermissions.CanOffer)
  ELSE
    bt_Offered.Enabled := off;

  bt_PagaDopo.Enabled := pd;
END;

FUNCTION TdlgnPecunia.CalcClientCost: Double;
BEGIN
  WITH Form2.qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT COALESCE(SUM(Dare),0) AS sD FROM OpenTab WHERE FeeID = 3 OR SubFeeID = 9998');
      Active := True;
      Result := FieldValues['sD'];
      Active := False;
    END;
END;

PROCEDURE TdlgnPecunia.ed_PecQrCodeChange(Sender: TObject);
VAR
  dir: WideString;
BEGIN
  IF length(ed_PecQrCode.Text) = 14 THEN
    BEGIN
      bt_QR.Caption := '';
      dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0)))) + '\Images & Icons\PosPrinterDis.png';
      bt_QR.Picture.LoadFromFile(dir);
      // bt_QR.Picture.LoadFromFile('D:\Program Files (x86)\PGC_522 - Tokyo - Chiasso - EXP\Images & Icons\PosPrinterDis.png');
      mm_Raffle.Lines.Clear;
      WITH Form2.qy_Tmp DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add('SELECT RaffleDate,PayedOutDate,Valid,Value,SubFeeID,ValidHowManydays,Printed,Fees.SubID,Fees.Description,TxID ' +
            'FROM RafflePrices ' +
            'LEFT JOIN Fees ON SubFeeID = SubID ' +
            'WHERE TxID = ' + QuotedStr(Copy(ed_PecQrCode.Text, 2, 13)));
          Active := True;
          IF RecordCount > 0 THEN
            BEGIN
              mm_Raffle.Lines.Add('Estrazione del ' + DateTostr(FieldByName('RaffleDate').AsDateTime));
              mm_Raffle.Lines.Add('Premio ' + FieldByName('Description').AsString);
              mm_Raffle.Lines.Add('Valore ' + FormatFloat('#,##0.00', FieldByName('Value').AsFloat) + ' CHF');
              IF FieldByName('RaffleDate').AsDateTime < IncDay(Now, -FieldByName('ValidHowManydays').AsInteger) THEN
                mm_Raffle.Lines.Add('Scaduto il ' + DateTostr(IncDay(FieldByName('RaffleDate').AsDateTime,
                  FieldByName('ValidHowManydays').AsInteger)))
              ELSE
                mm_Raffle.Lines.Add('Scade il ' + DateTostr(IncDay(FieldByName('RaffleDate').AsDateTime,
                  FieldByName('ValidHowManyDays').AsInteger)));
              IF FieldByName('PayedOutDate').AsDateTime > 0 THEN
                mm_Raffle.Lines.Add('Premio riscosso il ' + DateTimeToStr(FieldByName('PayedOutDate').AsDateTime));
              IF FieldByName('Valid').AsBoolean = True THEN
                BEGIN
                  IF FieldByName('RaffleDate').AsDateTime > Now THEN
                    BEGIN
                      Form1.nnWriteCashierDisplay(0, True, clYellow, 'Estrazione non ancora avvenuta!', 2);
                      Exit;
                    END;

                  IF DaysBetween(FieldByName('RaffleDate').AsDateTime, Now) <= FieldByName('ValidHowManyDays').AsInteger THEN
                    BEGIN
                      IF FieldByName('SubFeeID').AsInteger <> Form2.tb_Fees.FieldByName('SubID').AsInteger THEN
                        // This feeid cannot be useed as fee payment
                        BEGIN
                          bt_QR.Caption := '(' + FormatFloat('#,##0.00', FieldByName('Value').AsFloat) + ')';
                          bt_QR.Enabled := False;
                          Form1.nnWriteCashierDisplay(0, True, clYellow, 'Ticket non valido per questo prezzo!', 2);
                        END
                      ELSE
                        BEGIN
                          bt_QR.Caption := FormatFloat('#,##0.00', FieldByName('Value').AsFloat);
                          kbAmt := FieldByName('Value').AsFloat;
                          raffleTx := FieldByName('TxID').AsString;
                          bt_QR.Picture.LoadFromFile
                            ('C:\Program Files (x86)\PGC_522 - Tokyo - Chiasso - EXP\Images & Icons\PosPrinter.png');
                          Form1.nnWriteCashierDisplay(0, True, clWhite, 'Ticket OK!', 2);
                        END;
                    END
                  ELSE
                    Form1.nnWriteCashierDisplay(0, True, clYellow, 'Ticket scaduto da ' +
                      IntToStr(DaysBetween(FieldByName('RaffleDate').AsDateTime, Now) - FieldByName('ValidHowManyDays').AsInteger) +
                      ' giorni!', 2);
                END
              ELSE
                Form1.nnWriteCashierDisplay(0, True, clYellow, 'Ticket già usato il ' +
                  DateTimeToStr(FieldByName('PayedOutDate').AsDateTime), 2);
            END
          ELSE
            Form1.nnWriteCashierDisplay(0, True, clYellow, 'Ticket non esiste!', 2);
        END
    END;
END;

PROCEDURE TdlgnPecunia.WritePayment(pecunia: STRING; pecuniaID: Integer);
VAR
  balAmt, dAmt: Double;
  n: Integer;
BEGIN
  mm_Raffle.Clear;
  // Rental deposit payment
  // ----------------------
  IF Form2.tb_OTab.FieldByName('SubFeeID').AsInteger = 299 THEN
    WITH Form2.tb_OTab DO
      BEGIN
        First;
        Edit;
        FieldByName('PayMethod').AsString := pecunia;
        Post;
        balAmt := 0;
        kbAmt := 0;
        IF FieldByName('Avere').AsFloat > 0 THEN
          Form1.nnWriteCashierDisplay(0, False, clWhite, 'Cauzione camera: ' + FormatFloat('#,##0.00', FieldByName('Avere').AsFloat) + ' ' +
            pecunia, 0);
        IF FieldByName('Dare').AsFloat > 0 THEN
          Form1.nnWriteCashierDisplay(0, False, clWhite, 'Rimborso Cauzione: ' + FormatFloat('#,##0.00', FieldByName('Avere').AsFloat) +
            ' ' +
            pecunia, 0);
        Form1.nnWriteCashierDisplay(0, False, clLime, 'Pronto per registrare..', 1);
        Exit;
      END;

  // If payment in € then check first exchange rate €/CHF
  // 26-01-24 for now Only for entrance fees because of the drop of the exchange rate
  // 12-09-24 Modified code - set to apply all euro fees
  // --------------------------------------------------------------------------------------

  IF (pecunia = 'EU') THEN
    BEGIN
      // make a copy of the OpenTab table just in case the cashier wants to reset to CHF
      // ----------------------------------------------------------------------------------
      // work in progress 13.09.2024
      { WITH Form2.qy_OTab_Backup do
        begin
        if Active then Close;
        SQL.Clear;
        DatabaseName :=  'PGC_DB_Unicode';
        SQL.Add('SELECT * FROM OpenTab');
        Active := True;
        end; }
      // ----------------------------------------------------------------------------------

      IF payLaterCount > 0 THEN // * ??????????
        BEGIN
          IF MessageDlg
            ('Questo Paga Dopo è registrato con il costo in CHF ' +
            'mentre la valuta per pagare è in Euro! Procedendi si aggiornerà ' +
            'automaticamente il relativo costo!',
            mtConfirmation, [mbOK, mbNo], 0, mbOK) <> mrOK THEN
            BEGIN
              // isPayLater := False;
              tkbKeyClick(NIL, 2);
              // *  Form1.feePecuniaChanged := False;
            END;
          WITH Form2.qy_Tmp2 DO
            BEGIN
              IF Active THEN
                Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM OpenTab');
              Active := True;
              IF Locate('PayMethod', 'VT', []) THEN
                Form1.vatBarCredit := True;
              Active := False;
            END;
        END;

      BEGIN
        WITH Form2 DO
          BEGIN
            WITH qy_Tmp2 DO
              BEGIN
                IF Active THEN
                  Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM Fees');
                Active := True;
              END;
            WITH tb_OTab DO
              BEGIN
                First;
                WHILE NOT EoF DO
                  BEGIN
                    n := tb_OTab.FieldByName('SubfeeID').AsInteger;
                    IF n <> Null THEN
                      IF (n <> 9998) OR ((n = 9998) AND (Form1.vatBarCredit = False)) THEN
                        BEGIN
                          IF qy_Tmp2.Locate('SubID', FieldByName('SubfeeID').AsInteger, []) THEN
                            BEGIN
                              Edit;
                              IF FieldByName('SubfeeID').AsInteger = 222 THEN // RR fee
                                FieldByName('Dare').AsFloat := FieldByName('Dare').AsFloat + 2 // add 2 euros to the chf fee
                              ELSE
                                FieldByName('Dare').AsFloat := qy_Tmp2.FieldByName('FeeEuro').AsFloat;
                              Post;
                              // *   Form1.feePecuniaChanged := True;
                            END;

                        END;
                    Next;
                  END;
                WITH Form1.dbgd_CashierDisplay DO
                  BEGIN
                    SumList.RecalcAll;
                    bt_PagaDopo.Caption := FormatFloat('#,##0.00', Columns[2].Footers[0].SumValue);
                  END;
              END;
          END;
      END;
    END;

  // Check pecunia
  // -------------
  balAmt := Form1.dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
    Form1.dbgd_CashierDisplay.Columns[2].Footers[0].SumValue;

  IF (balAmt = 0) AND (kbAmt = 0) THEN
    Exit;

  // Write pecunia
  // -------------
  WITH Form1, Form2 DO
    BEGIN
      IF balAmt > 0 THEN
        BEGIN
          WITH tb_OTab DO
            BEGIN
              Insert;
              FieldByName('Data').AsDateTime := Now;
              IF pecunia = 'PD' THEN
                FieldByName('Description').AsString := 'Paga dopo'
              ELSE
                BEGIN
                  IF pecuniaID = 5 THEN
                    BEGIN
                      FieldByName('Description').AsString := 'Estrazione ' + raffleTx;
                      FieldByName('TmpTxID').AsString := raffleTx;
                    END
                  ELSE
                    FieldByName('Description').AsString := 'Pagamento';
                END;
              IF (kbAmt < balAmt) AND (kbAmt > 0) THEN
                BEGIN
                  FieldByName('Avere').AsFloat := kbAmt;
                  kbAmt := 0;
                END
              ELSE
                FieldByName('Avere').AsFloat := balAmt;
              FieldByName('PayMethod').AsString := pecunia;

              FieldByName('Registered').AsBoolean := False;
              IF tx <> '' THEN
                FieldByName('TxID').AsString := tx;
              Post;
              Refresh;
              dbgd_CashierDisplay.SumList.RecalcAll;
            END;
        END;

      // Disable already used pecunia button or disable all if bal = 0
      // -------------------------------------------------------------

      IF dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
        dbgd_CashierDisplay.Columns[2].Footers[0].SumValue = 0 THEN
        BEGIN
          isVipParty := False;
          nnWriteCashierDisplay(0, True, clLime, 'Pronto per registrare >', 1);
        END
      ELSE
        BEGIN
          CASE pecuniaID OF
            0:
              bt_Offered.Enabled := False;
            1:
              BEGIN
                bt_CHF.Enabled := False;
                bt_CHF.BackColor := $00444444;
              END;
            2:
              BEGIN
                bt_Euro.Enabled := False;
                bt_Euro.BackColor := $00444444;
              END;
            3:
              bt_CC.Enabled := False;
            // 4:
            // bt_PagaDopo.Enabled := False;
            5:
              bt_QR.Enabled := False;
          END;
          nnWriteCashierDisplay(0, True, clLime, 'Mancano ' + FormatFloat('#,##0.00', dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
            dbgd_CashierDisplay.Columns[2].Footers[0].SumValue) + ' da registrare', 1);
        END;
      IF allowedPdAmt > 0 THEN
        BEGIN
          bt_PagaDopo.Caption := FormatFloat('#,##0.00', dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
            dbgd_CashierDisplay.Columns[2].Footers[0].SumValue);
        END
      ELSE
        BEGIN
          bt_PagaDopo.Caption := '0.00';
          bt_PagaDopo.Enabled := False;
        END;
      kbAmt := 0;
      tmpkbAmtStr := '';
      nnWriteCashierDisplay(0, False, clWhite, 'Tessera in uso: ' + IntToStr(ThisCard.cardID) + '  ' + ThisClient.alias, 2);
    END;
END;

PROCEDURE TdlgnPecunia.tkbKeyClick(Sender: TObject; Index: Integer);
VAR
  bal: Double;
  tmpTx, pecunia: STRING;
  dir: WideString;
BEGIN
  WITH Form1, Form2 DO
    BEGIN
      CASE INDEX OF
        0: // Exit key
          // --------
          WITH Form1 DO
            BEGIN
              cc1 := False;
              kbAmt := 0;
              tmpkbAmtStr := '';
              kbAmtStr := '';
              assignedPdAmt := 0;
              xx_CancelAll(True);
              ed_PecQrCode.Clear;
              mm_Raffle.Lines.Clear;
              raffleTx := '';
              dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0)))) + '\Images & Icons\PosPrinterDis.png';
              bt_QR.Picture.LoadFromFile(dir);
              // bt_QR.Picture.LoadFromFile('D:\Program Files (x86)\PGC_522 - Tokyo - Chiasso - EXP\Images & Icons\PosPrinterDis.png');
              bt_QR.Caption := '';
              bt_register.Enabled := Form2.tb_OTab.RecordCount > 0;
              IF Form2.tb_OTab.RecordCount = 0 THEN
                // mm_Cashier1.Clear
              ELSE
                //nDebit2GirlAmt;
              dlgnPecunia.ModalResult := mrCancel;
            END;
        1:
          IF tkb.Keys[1].Caption <> '' THEN
            WITH Form2.tb_OTab DO
              BEGIN
                Insert;
                FieldByName('Data').AsDateTime := Now;
                FieldByName('Description').AsString := 'Ticket bar';
                FieldByName('Avere').AsFloat := (ed_amtMarchetta.Value / 100) * ed_VatTax.Value;
                FieldByName('PayMethod').AsString := 'VT';
                FieldByName('TmpTxID').AsString := VTtxId;
                Post;
                Refresh;
                dbgd_CashierDisplay.SumList.RecalcAll;
                Form1.dbgd_CashierDisplay.Refresh;
                tkb.Keys[1].Caption := '';
                VTtxId := '';
              END;

        2: // Cancel key
          // ----------
          BEGIN
            cc1 := False;
            kbAmt := 0;
            tmpkbAmtStr := '';
            kbAmtStr := '';
            ed_PecQrCode.Clear;
            bt_QR.Caption := '';
            bt_QR.Enabled := True;
            mm_Raffle.Lines.Clear;
            raffleTx := '';
            dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0)))) + '\Images & Icons\PosPrinterDis.png';
            bt_QR.Picture.LoadFromFile(dir);
            // bt_QR.Picture.LoadFromFile('D:\Program Files (x86)\PGC_522 - Tokyo - Chiasso - EXP\Images & Icons\PosPrinterDis.png');
            tkb.SetFocus;
            WITH tb_OTab DO
              BEGIN
                Last;
                IF (FieldByName('TmpTxID').AsString <> '') THEN // Related registration
                  BEGIN
                    tmpTx := FieldByName('TmpTxID').AsString;
                    nCC2ClientAmt := 0;
                    nCCCommAmt := 0;
                    WITH qy_Tmp DO
                      BEGIN
                        IF Active THEN
                          Close;
                        SQL.Clear;
                        SQL.Add('DELETE FROM OpenTab WHERE Registered = False AND TmpTxID = ' +
                          QuotedStr(tmpTx));
                        ExecSQL;
                      END;
                    Refresh;
                    dbgd_CashierDisplay.SumList.RecalcAll;
                  END
                ELSE
                  BEGIN
                    IF FieldByName('Registered').AsBoolean = True THEN
                      Exit;
                    IF (FieldByName('Dare').AsFloat > 0) AND (FieldByName('SubFeeID').AsInteger = 899) THEN // bar > rec
                      Exit;
                    IF (FieldByName('Avere').AsFloat > 0) OR (FieldByName('FeeID').AsInteger = 8) THEN
                      BEGIN
                        IF FieldByName('PayMethod').AsString = 'PD' THEN
                          assignedPdAmt := assignedPdAmt - FieldByName('Avere').AsFloat;
                        IF FieldByName('PayMethod').AsString = 'OF' THEN
                          bt_Offered.Enabled := canBeOffered;
                        IF FieldByName('PayMethod').AsString = 'CH' THEN
                          BEGIN
                            bt_CHF.Enabled := True;
                            bt_CHF.BackColor := clRed;
                          END;
                        IF FieldByName('PayMethod').AsString = 'EU' THEN
                          BEGIN
                            bt_Euro.Enabled := True;
                            bt_Euro.BackColor := clNavy;
                          END;
                        IF FieldByName('PayMethod').AsString = 'CC' THEN
                          bt_CC.Enabled := True;
                        IF FieldByName('PayMethod').AsString = 'PD' THEN
                          BEGIN
                            bt_PagaDopo.Enabled := True;
                            bt_PagaDopo.Caption := '';
                          END;
                        Edit;
                        Delete;
                        Refresh;
                        Last;
                      END;

                  END;
              END;

            mm_Cashier.Clear;
            tmpkbAmtStr := '';
            kbAmt := 0;
            kbAmtStr := '';
            dbgd_CashierDisplay.SumList.RecalcAll;
            IF (openFeeAmt) AND (Form2.tb_OTab.RecordCount = 0) THEN
              nnWriteCashierDisplay(0, False, clLime, 'Immetti importo libero >', 1)
            ELSE
              IF Form1.dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
              Form1.dbgd_CashierDisplay.Columns[2].Footers[0].SumValue > 0 THEN
              nnWriteCashierDisplay(0, True, clYellow, 'Mancano ' + FormatFloat('#,##0.00',
                Form1.dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
                Form1.dbgd_CashierDisplay.Columns[2].Footers[0].SumValue) + ' da registrare', 1)
            ELSE
              nnWriteCashierDisplay(0, False, clWhite, '', 1);
            nnWriteCashierDisplay(0, False, clWhite, 'Tessera in uso: ' + IntToStr(ThisCard.cardID) + '  ' + ThisClient.alias, 2);
           // nDebit2GirlAmt;
            bal := dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
              dbgd_CashierDisplay.Columns[2].Footers[0].SumValue;
            IF allowedPdAmt > 0 THEN
              BEGIN
                IF Max(allowedPdAmt, bal) > allowedPdAmt THEN
                  bt_PagaDopo.Caption := FormatFloat('#,##0.00', allowedPdAmt)
                ELSE
                  bt_PagaDopo.Caption := FormatFloat('#,##0.00', bal);
                bt_PagaDopo.Enabled := True;
              END
          END;

        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14: // Num keys
          BEGIN
            // ---------------------------------
            // Build kb amount
            // ---------------------------------
            IF ContainsText(tmpkbAmtStr, '.') THEN
              BEGIN
                inc(decimalCount);
                IF decimalCount > 2 THEN
                  Exit;
              END;
            tmpkbAmtStr := tmpkbAmtStr + tkb.Keys[INDEX].Caption;
            kbAmt := StrToFloat(tmpkbAmtStr);
            kbAmtStr := FormatFloat('#,##0.00', kbAmt);
            nnWriteCashierDisplay(0, False, clLime, 'Importo: ' + kbAmtStr, 1);
            nnWriteCashierDisplay(0, False, clWhite, 'Tessera in uso: ' + IntToStr(ThisCard.cardID), 2);
          END;

        12: // Register key
          BEGIN
            // Re-check if fee pecunia changed between sale and Pay Later
            // ----------------------------------------------------------
            WITH Form2.qy_Tmp DO
              BEGIN
                IF Active THEN
                  Close;
                SQL.Clear;
                SQL.Add('SELECT PayMethod FROM OpenTab WHERE PayMethod = ' + QuotedStr('CC'));
                Active := True;
                IF RecordCount > 0 THEN
                  cc1 := True;
                Active := False;
              END;
            IF isVipParty THEN
              BEGIN
                IF NOT(nIsPay) THEN
                  BEGIN
                    WITH tb_OTab DO
                      BEGIN
                        First;
                        Edit;
                        FieldByName('Data').AsDateTime := Now;
                        IF NOT(nIsdrinks) THEN
                          BEGIN
                            FieldByName('Dare').AsFloat := kbAmt;
                            nPartyAmt := kbAmt;
                          END
                        ELSE
                          BEGIN
                            FieldByName('DrinkCreditValue').AsFloat := kbAmt;
                            FieldByName('DrinkCredits').AsFloat := 1;
                            FieldByName('ReceiptCopies').AsInteger := 1;
                            kbAmt := nPartyAmt; // reset kbAmt to Party amount
                          END;
                        Post;
                      END;
                    IF NOT nIsdrinks THEN
                      BEGIN
                        Form1.nnWriteCashierDisplay(0, True, clLime, '', 0);
                        // mm_Cashier1.Rows[1].Text := 'Importo VIP Party: ' + FormatFloat('#,##0.00', tb_OTab.FieldByName('Dare').AsFloat);
                        nPrepareForParty(False, True);
                        Exit;
                      END
                    ELSE
                      // mm_Cashier1.Rows[2].Text := 'Credito drinks     : ' +
                      FormatFloat('#,##0.00', tb_OTab.FieldByName('DrinkCreditValue').AsFloat);
                    Form1.nnWriteCashierDisplay(0, True, clWhite, 'Ora scegli modalità pagamento..', 2);

                    kbAmt := 0;
                    tmpkbAmtStr := '';
                    kbAmtStr := '';
                    ed_PecQrCode.Clear;
                    nPrepareForParty(True, False);
                    Exit;
                  END;
              END;

            IF (tb_OTab.FieldByName('SubFeeID').AsInteger = 299) AND (tb_OTab.FieldByName('PayMethod').IsNull) THEN
              BEGIN
                nnWriteCashierDisplay(0, False, clLime, 'Manca indicazione valuta', 1);
                Exit;
              END;

            IF (dbgd_CashierDisplay.Columns[1].Footers[0].SumValue -
              dbgd_CashierDisplay.Columns[2].Footers[0].SumValue = 0) OR
              (tb_OTab.FieldByName('SubFeeID').AsInteger = 299) THEN
              BEGIN
                Form1.bt_register.Enabled := cb_MultiDebitSameClient.Checked;
                ManageAds('RegSale', nSubFeeID);
                dlgnPecunia.ModalResult := mrOK;
              END
            ELSE
              BEGIN
                nnWriteCashierDisplay(0, True, clYellow, 'Pagamento incompleto, mancano ' + FormatFloat('#,##0.00',
                  dbgd_CashierDisplay.Columns[1].Footers[0].SumValue - dbgd_CashierDisplay.Columns[2].Footers[0].SumValue), 1);
              END;
          END;
      END;
    END;
  tkb.Repaint;
END;

END.
