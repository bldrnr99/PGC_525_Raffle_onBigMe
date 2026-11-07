UNIT nDlgAmt;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh,
  JvExControls, JvLED, Vcl.ExtCtrls, AdvSmoothTouchKeyBoard,
  System.Math, AdvUtil,
  Vcl.ComCtrls, System.Types, DateUtils, Vcl.Menus, Vcl.DBCtrls, JvDBImage;

TYPE
  TnDlgAmounts = CLASS(TForm)
    pTkb: TAdvSmoothTouchKeyBoard;
    pl_VipPartyDrinkValue: TPanel;
    Label1: TLabel;
    ledVipdrinkValue: TJvLED;
    ed_VipPartyDrinkValue: TDBNumberEditEh;
    JvDBImage1: TJvDBImage;
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE ed_VipPartyDrinkValueChange(Sender: TObject);
    PROCEDURE ed_VipPartyDrinkValueExit(Sender: TObject);
    PROCEDURE pTkbKeyClick(Sender: TObject; Index: Integer);
    PROCEDURE GetCcCommission;
    PROCEDURE DoExit;
  PRIVATE
    { Private declarations }

  PUBLIC
    { Public declarations }
  END;

VAR
  nDlgAmounts: TnDlgAmounts;
  pTmpkbAmtStr, pKbAmtStr, pKbInfo, tmpTxID: STRING;
  pDecimalCount: Integer;
  pKbAmt: Double;
  written, okToRegister: Boolean;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main, nDlgPecunia, nBarPList, nPrinterTexts;

PROCEDURE TnDlgAmounts.ed_VipPartyDrinkValueChange(Sender: TObject);
BEGIN
  ledVipdrinkValue.Status := ed_VipPartyDrinkValue.Value > 0;
  ledVipdrinkValue.Active := NOT ed_VipPartyDrinkValue.Value > 0;
END;

PROCEDURE TnDlgAmounts.ed_VipPartyDrinkValueExit(Sender: TObject);
BEGIN
  IF ed_VipPartyDrinkValue.IsEmpty THEN
    ed_VipPartyDrinkValue.Value := 0;
END;

PROCEDURE TnDlgAmounts.FormShow(Sender: TObject);
BEGIN
  okToRegister := False;
  WITH Form1 DO
    BEGIN
      nnWriteCashierDisplay(0, False, clWhite, 'Sei nella modalià IMPORTO LIBERO.', 0);
      nnWriteCashierDisplay(0, False, clWhite, 'Tessera in uso: ' + intTostr(ThisCard.cardID) + '  ' + ThisClient.alias, 2);
      pl_VipPartyDrinkValue.Visible := Form2.tb_Fees.FieldByName('ID').AsInteger = 12;
      CASE Form2.tb_Fees.FieldByName('ID').AsInteger OF
        8:
          BEGIN
            nnWriteCashierDisplay(0, False, clLime, 'Immetti importo acquisto bar!', 1);
            kbInfo := 'Importo acquisto bar: ';
          END;
        12:
          BEGIN
            nnWriteCashierDisplay(0, True, clLime, 'Immetti saldo VIP Party senza ev. acconti!', 1);
            kbInfo := 'Importo a saldo VIP Party: ';
          END;
        99:
          BEGIN
            nnWriteCashierDisplay(0, False, clLime, 'Immetti importo CC senza commissione!', 1);
            kbInfo := 'Importo CC a ' + ThisClient.alias + ': ';
          END;
      END;
    END;
  IF Form2.tb_Fees.FieldByName('ID').AsInteger = 8 THEN
    pTkb.Keys[1].Caption := 'LISTINO'
  ELSE
    pTkb.Keys[1].Caption := '';
END;

PROCEDURE TnDlgAmounts.DoExit;
BEGIN
  WITH Form1 DO
    BEGIN
      IF nBarPriceList.Showing THEN
        nBarPriceList.Close;
      pKbAmt := 0;
      pKbAmtStr := '';
      pTmpkbAmtStr := '';
      written := False;
      xx_CancelAll(True);
      nDlgAmounts.ModalResult := mrCancel;
    END;
END;

PROCEDURE TnDlgAmounts.pTkbKeyClick(Sender: TObject; Index: Integer);
VAR
  s: STRING;
  nrecCopies, nRecID: Integer;
  amt: Double;
  dt: TDateTime;
BEGIN
  CASE INDEX OF
    0: // Exit
      DoExit;

    1: // Listino
      BEGIN
        IF Form2.tb_Fees.FieldByName('ID').AsInteger = 8 THEN
          IF NOT nBarPriceList.Showing THEN
            nBarPriceList.Show
          ELSE
            nBarPriceList.Close;
      END;

    2: // Cancel
      BEGIN
        DoExit;
        { pKbAmt := 0;
          pKbAmtStr := '';
          pTmpkbAmtStr := '';
          written := False;
          Form1.nWriteCashierDisplay(False, clLime, 'IMPORTO : ', 1);
          // Cancel bar amount
          // -----------------
          WITH Form2, tb_OTab DO
          BEGIN
          Last;
          IF FieldByName('Registered').AsBoolean = True THEN
          Exit;
          IF (FieldByName('FeeID').AsInteger = 8) AND (FieldByName('Dare').AsFloat > 0) THEN // Bar transaction
          BEGIN
          Edit;
          Delete;
          Refresh;
          Last;
          END;
          IF (Form2.tb_Fees.FieldByName('ID').AsInteger = 99) THEN
          WITH Form2.qy_Tmp DO
          BEGIN
          tmpTxID := tb_OTab.FieldByName('TmpTxID').AsString;
          IF Active THEN
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM OpenTab WHERE Registered = False ' +
          ' AND TmpTxID = ' + QuotedStr(tmpTxID));
          ExecSQL;
          tb_OTab.Refresh;
          END;
          Form1.dbgd_CashierDisplay.SumList.RecalcAll;
          Form1.nDebit2GirlAmt;
          END; }
      END;

    3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14: // Num keys
      BEGIN
        // ---------------------------------
        // Build kb amount
        // ---------------------------------
        IF ContainsText(tmpkbAmtStr, '.') THEN
          BEGIN
            inc(pDecimalCount);
            IF pDecimalCount > 2 THEN
              Exit;
          END;
        pTmpkbAmtStr := pTmpkbAmtStr + pTkb.Keys[INDEX].Caption;
        pKbAmt := StrToFloat(pTmpkbAmtStr);
        pKbAmtStr := FormatFloat('#,##0.00', pKbAmt);
        Form1.nnWriteCashierDisplay(0, False, clLime, pKbInfo + pKbAmtStr, 1);
      END;

    12: // Register
      IF (written) AND (pKbAmt = 0) THEN
        BEGIN
          DoExit;
        END
      ELSE
        WITH Form1, Form2, tb_OTab DO
          BEGIN
            IF (pKbAmt > 0) THEN
              BEGIN
                IF tb_Fees.FieldByName('ID').AsInteger <> 99 THEN // Bar or Vip Party
                  BEGIN
                    GetCcCommission;
                    tmpTxID := GenerateTxID;
                    Insert;
                    FieldByName('Data').AsDateTime := Now;
                    FieldByName('FeeID').AsInteger := tb_Fees.FieldByName('ID').AsInteger;
                    FieldByName('SubFeeID').AsInteger := tb_Fees.FieldByName('SubID').AsInteger;
                    FieldByName('Description').AsString := tb_Fees.FieldByName('Description').AsString;
                    FieldByName('Dare').AsFloat := pKbAmt;
                    FieldByName('CostCenter').AsString := tb_Fees.FieldByName('CostCenter').AsString;
                    FieldByName('DebitToGirl').AsBoolean := tb_Fees.FieldByName('DebitToGirl').AsBoolean;
                    FieldByName('Registered').AsBoolean := False;
                    FieldByName('ReceiptID').AsInteger := tb_Fees.FieldByName('ReceiptID').AsInteger;
                    FieldByName('ReceiptCopies').AsInteger := tb_Fees.FieldByName('ReceiptCopies').AsInteger;
                    Post;
                    Refresh;
                    written := True;
                    IF nBarPriceList.Showing THEN
                      nBarPriceList.Close;
                  END;
                IF NOT okToRegister THEN
                  BEGIN
                    IF tb_Fees.FieldByName('ID').AsInteger = 99 THEN // CC to client
                      BEGIN
                        GetCcCommission;
                        tmpTxID := GenerateTxID;
                        // Dare
                        // -----
                        Insert;
                        FieldByName('Data').AsDateTime := Now;
                        FieldByName('FeeID').AsInteger := tb_Fees.FieldByName('ID').AsInteger;
                        FieldByName('SubFeeID').AsInteger := tb_Fees.FieldByName('SubID').AsInteger;
                        FieldByName('Description').AsString := tb_Fees.FieldByName('Description').AsString;
                        FieldByName('Dare').AsFloat := pKbAmt;
                        FieldByName('CostCenter').AsString := tb_Fees.FieldByName('CostCenter').AsString;
                        FieldByName('DebitToGirl').AsBoolean := tb_Fees.FieldByName('DebitToGirl').AsBoolean;
                        FieldByName('Registered').AsBoolean := False;
                        FieldByName('TmpTxID').AsString := tmpTxID;
                        FieldByName('ReceiptID').AsInteger := tb_Fees.FieldByName('ReceiptID').AsInteger;
                        FieldByName('ReceiptCopies').AsInteger := tb_Fees.FieldByName('ReceiptCopies').AsInteger;
                        Post;

                        Insert; // CC Commission
                        FieldByName('Data').AsDateTime := Now;
                        FieldByName('FeeID').AsInteger := 98;
                        FieldByName('SubFeeID').AsInteger := 998;
                        FieldByName('Description').AsString := 'Commissione CC ';
                        FieldByName('Dare').AsFloat := nCCCommAmt;
                        FieldByName('CostCenter').AsString := tb_Fees.FieldByName('CostCenter').AsString;
                        FieldByName('DebitToGirl').AsBoolean := False;
                        FieldByName('Registered').AsBoolean := False;
                        FieldByName('TmpTxID').AsString := tmpTxID;
                        // no print
                        Post;
                        Refresh;
                        // Dare
                        // ----
                        Insert;
                        FieldByName('Data').AsDateTime := Now;
                        FieldByName('Description').AsString := tb_Fees.FieldByName('Description').AsString;
                        FieldByName('Avere').AsFloat := pKbAmt;
                        FieldByName('PayMethod').AsString := 'CC';
                        FieldByName('Registered').AsBoolean := False;
                        FieldByName('TmpTxID').AsString := tmpTxID;
                        Post;

                        Insert; // CC commission
                        FieldByName('Data').AsDateTime := Now;
                        FieldByName('Description').AsString := 'Commissione CC ';
                        FieldByName('Avere').AsFloat := nCCCommAmt;
                        FieldByName('PayMethod').AsString := 'CC';
                        FieldByName('Registered').AsBoolean := False;
                        FieldByName('TmpTxID').AsString := tmpTxID;
                        Post;
                        Refresh;
                        written := True;
                        // Now register cc to client

                      END;
                    nnWriteCashierDisplay(0, True, clLime, 'Pronto per registrare..', 1);
                    okToRegister := True;
                  END
                ELSE
                  BEGIN
                    IF ThisClient.ID = 0 THEN
                      BEGIN
                        ShowMessage('Errore numero cliente. Azzera, rileggi di nuovo la tessera e poi riprova!');
                        DoExit;
                      END
                    ELSE
                      BEGIN
                        FIRST;
                        WHILE NOT EoF DO
                          BEGIN
                            IF FieldByName('ReceiptCopies').AsInteger > 0 THEN
                              BEGIN
                                nrecCopies := FieldByName('ReceiptCopies').AsInteger;
                                nRecID := FieldByName('ReceiptID').AsInteger;
                                amt := FieldByName('Dare').AsFloat;
                              END;

                            IF (FieldByName('Dare').AsFloat > 0) AND (FieldByName('SubFeeID').AsInteger = 999) THEN
                              BEGIN
                                s := 'INSERT INTO ClCCLedger (DATA,CLIENTID,CARDID,DESCRIPTION,Dare,TXID,Operator) ' +
                                  'VALUES(CURRENT_TIMESTAMP, ' +
                                  intTostr(ThisClient.ID) + ',' + intTostr(ThisCard.cardID) + ',' +
                                  QuotedStr(FieldByName('Description').AsString) + ',' + FieldByName('Dare').AsString + ',' +
                                  QuotedStr(tmpTxID) + ', ' + QuotedStr(Cashier) + ')';
                                Form2.t_executequery(s, 'PGC_DB_Main_Unicode', 'PGC_DB_Unicode', 'ClCCLedger');
                                Sleep(50);
                                s := 'INSERT INTO ClCCLedger (DATA,CLIENTID,CARDID,DESCRIPTION,Avere,TXID,Operator) ' +
                                  'VALUES(CURRENT_TIMESTAMP, ' +
                                  intTostr(ThisClient.ID) + ',' + intTostr(ThisCard.cardID) + ',' +
                                  QuotedStr(FieldByName('Description').AsString) + ',' + FieldByName('Dare').AsString + ',' +
                                  QuotedStr(tmpTxID) + ', ' + QuotedStr(Cashier) + ')';
                                Form2.t_executequery(s, 'PGC_DB_Main_Unicode', 'PGC_DB_Unicode', 'ClCCLedger');
                              END;
                            // CC Commission
                            IF (FieldByName('Dare').AsFloat > 0) AND (FieldByName('SubFeeID').AsInteger = 998) THEN
                              BEGIN
                                s := 'INSERT INTO ClLedger (DATA,CLIENTID,CARDID,FeeID,SubFeeID,CostCenter,DESCRIPTION,Dare,TXID,Operator,TxType) '
                                  +
                                  'VALUES(CURRENT_TIMESTAMP, ' +
                                  intTostr(ThisClient.ID) + ',' + intTostr(ThisCard.cardID) + ',' +
                                  FieldByName('FeeID').AsString + ', ' + FieldByName('SubFeeID').AsString + ', ' +
                                  QuotedStr('clu') + ', ' +
                                  QuotedStr(FieldByName('Description').AsString) + ',' + FieldByName('Dare').AsString + ',' +
                                  QuotedStr(tmpTxID) + ', ' + QuotedStr(Cashier) + ',' +
                                  QuotedStr('IN') + ')';
                                Form2.t_executequery(s, 'PGC_DB_Main_Unicode', 'PGC_DB_Unicode', 'ClLedger');
                                Sleep(50);
                                s := 'INSERT INTO ClLedger (DATA,CLIENTID,CARDID,DESCRIPTION,Avere,TXID,PayMethod,Operator,TxType) ' +
                                  'VALUES(CURRENT_TIMESTAMP, ' +
                                  intTostr(ThisClient.ID) + ',' + intTostr(ThisCard.cardID) + ',' +
                                  QuotedStr(FieldByName('Description').AsString) + ',' + FieldByName('Dare').AsString + ',' +
                                  QuotedStr(tmpTxID) + ', ' + QuotedStr('CC') + ', ' + QuotedStr(Cashier) + ',' +
                                  QuotedStr('IN') + ')';
                                Form2.t_executequery(s, 'PGC_DB_Main_Unicode', 'PGC_DB_Unicode', 'ClLedger');
                              END;
                            Next;
                          END;

                        dbgd_CashierDisplay.SumList.RecalcAll;
                        WITH dbgd_CashierDisplay DO
                          BEGIN
                            Font.Color := clAqua;
                            FooterFont.Color := clAqua;
                          END;

                        // Print Receipt
                        // -------------
                        IF nrecCopies > 0 THEN
                          BEGIN
                            IF Form2.tb_Fees.FieldByName('PrintQRCode').AsBoolean = True THEN
                              BEGIN
                           //     Barcode1.InputText := tmpTxID;
                                TRY
                       //          img_QRcode.Picture.Assign(Barcode1.Bitmap);
                                EXCEPT
                                  ON E: Exception DO
                                    BEGIN
                                      img_QRcode.Picture.Assign(NIL);
                                    END;
                                END;
                              END
                            ELSE
                              img_QRcode.Picture.Assign(NIL);
                            nPrinterTexts.nPrintCCConfirmation(amt, tmpTxID, nRecID, nrecCopies);
                            // nPrintCCReceipt(amt, tmpTxID, nRecID, nrecCopies);
                          END;
                        nnWriteCashierDisplay(0, True, clAqua, 'Registrazione eseguita', 1);
                        pKbAmt := 0;
                        pKbAmtStr := '';
                        pTmpkbAmtStr := '';
                        nDlgAmounts.ModalResult := mrOk;
                        Finalize(ThisClient);
                        FillChar(ThisClient, sizeof(ThisClient), 0);
                      END;
                  END;
              END;
          END;
  END;
END;

PROCEDURE TnDlgAmounts.GetCcCommission;
BEGIN
  WITH Form1 DO
    BEGIN
      nCC2ClientAmt := pKbAmt;
      IF rg_CommissionCC.ItemIndex = 0 THEN
        nCCCommAmt := Ceil(nCC2ClientAmt / 100) * ed_CcCommissionAmt.Value
      ELSE
        BEGIN
          nCCCommAmt := (nCC2ClientAmt / 100) * ed_CcCommissionAmt.Value;
          nCCCommAmt := floor(nCCCommAmt);
        END;
    END;
END;

END.
