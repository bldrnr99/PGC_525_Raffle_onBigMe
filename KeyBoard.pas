UNIT KeyBoard;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Dateutils, Data.DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh,
  AdvGlassButton, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBCtrls, AdvEdit, JvComponentBase, JvThread, Math, JvExStdCtrls,
  JvBehaviorLabel, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVclUtils, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.Buttons, Vcl.NumberBox,
  JvExMask, JvToolEdit;

TYPE
  TNumKeyboard = CLASS(TForm)
    pl_Keys: TPanel;
    bt_7: TAdvGlassButton;
    bt_8: TAdvGlassButton;
    bt_9: TAdvGlassButton;
    bt_6: TAdvGlassButton;
    bt_3: TAdvGlassButton;
    bt_dot: TAdvGlassButton;
    bt_0: TAdvGlassButton;
    bt_1: TAdvGlassButton;
    bt_4: TAdvGlassButton;
    bt_5: TAdvGlassButton;
    bt_2: TAdvGlassButton;
    bt_Receipt: TAdvGlassButton;
    pl_Buttons: TPanel;
    bt_fCassaB: TAdvGlassButton;
    bt_fCassaR: TAdvGlassButton;
    bt_CashSpesa: TAdvGlassButton;
    bt_CashDepositOut: TAdvGlassButton;
    bt_CashDepositIn: TAdvGlassButton;
    bt_CashIncasso: TAdvGlassButton;
    bt_CCgIN: TAdvGlassButton;
    bt_CCgOut: TAdvGlassButton;
    lb_ChoseCategory: TJvBehaviorLabel;
    ed_Description: TDBEditEh;
    dbgd_CCtoG: TDBGridEh;
    DBText1: TDBText;
    DBText2: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBText3: TDBText;
    Label3: TLabel;
    dtBusta1: TJvDateEdit;
    dtBusta2: TJvDateEdit;
    dtBusta3: TJvDateEdit;
    Label4: TLabel;
    amtBusta1: TNumberBox;
    amtBusta2: TNumberBox;
    amtBusta3: TNumberBox;
    Shape1: TShape;
    Label5: TLabel;
    amtTotBuste: TNumberBox;
    Label6: TLabel;
    btnCloseBustaPL: TSpeedButton;
    plCashBuste: TPanel;
    btnOkBuste: TAdvGlassButton;
    lblAmt1: TLabel;
    lblAmt2: TLabel;
    lblAmt3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape2: TShape;

    FUNCTION Calculator(aKey: Integer): Double;
    PROCEDURE FormShow(Sender: TObject);
    FUNCTION VerifyIfComplete: Boolean;
    PROCEDURE ed_Description_Change(Sender: TObject);
    PROCEDURE WriteReceiptToOtab(Sender: TObject);
    PROCEDURE OnKbAmtChanging;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE bt_0Click(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE bt_ReceiptClick(Sender: TObject);
    Procedure UpdateFondoCassaToOtab(Description, costCenter: String);
    Procedure xx_PrepareCashToOtab(btTag, subID: Integer; aDate: TDateTime;
      amt: Double; PayMethod: String);
    procedure bt_CashIncassoClick(Sender: TObject);
    procedure bt_CashSpesaClick(Sender: TObject);
    procedure bt_CashDepositInClick(Sender: TObject);
    procedure bt_CashDepositOutClick(Sender: TObject);
    procedure bt_fCassaRClick(Sender: TObject);
    procedure bt_fCassaBClick(Sender: TObject);
    procedure bt_CCgINClick(Sender: TObject);
    procedure bt_CCgOutClick(Sender: TObject);
    procedure CheckCashPayment(txID: String; out InDate, bustaInDate: TDateTime;
      out AValue, in1000, in1010, out2900: Double;
      out aPayMethod, alias: String; out inEnvelope: Boolean;
      out aClientID: Integer);
    Procedure HandleCCPayments;
    procedure btnCloseBustaPLClick(Sender: TObject);
    procedure AmtCHFTotBuste;
    procedure amtBusta2ChangeValue(Sender: TObject);
    procedure amtBusta3ChangeValue(Sender: TObject);
    procedure dtBusta1AcceptDate(Sender: TObject; var aDate: TDateTime;
      var Action: Boolean);
    function CheckBusta(dataBusta: TDateTime; aTag: Integer): Double;
    procedure amtBusta1ChangeValue(Sender: TObject);
    procedure dtBusta2AcceptDate(Sender: TObject; var aDate: TDateTime;
      var Action: Boolean);
    procedure dtBusta3AcceptDate(Sender: TObject; var aDate: TDateTime;
      var Action: Boolean);
    Function CheckBustaDate(aDate: TDateTime): Boolean;
    procedure btnOkBusteClick(Sender: TObject);
  PRIVATE
    { Private declarations }
    FDateOK: Boolean;
    FInitialized: Boolean;
    FClosingID: array [0 .. 2] of string;
    Famt: array [0 .. 2] of Double;
  PUBLIC
    { Public declarations }

  END;

VAR
  NumKeyboard: TNumKeyboard;
  dollars, cents, tmpStr, mixPecuniaStr, PayMethod, receiptTxID: STRING;
  hasCents: Boolean;
  P: TPoint;
  ccCommission, oTabBackUpCHF, oTabBackUpEuro: Double;
  amt, commissionPerc: Double;

IMPLEMENTATION

{$R *.dfm}


USES Main, DM1, nRoutines, GCC, TaskDlgHelperF, uClientStore,
  uWriteCashierDisplay;

PROCEDURE TNumKeyboard.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  // Form1.bt_Receipt.Visible := True;
  ed_Description.Clear;
  bt_Receipt.Down := False;

  bt_fCassaR.Down := False;
  bt_fCassaB.Down := False;
  Calculator(14);
  NumKeyboard.pl_Buttons.Enabled := True;
  NumKeyboard.pl_Keys.Enabled := True;
  NumKeyboard.pl_Keys.Visible := True;
  NumKeyboard.ed_Description.Enabled := True;
  lb_ChoseCategory.BehaviorOptions.Active := False;
  lb_ChoseCategory.Visible := True;
  Form1.ShowDetailOpenBarTab;
  Form1.ShowHideBottomBtns(True, True, True, True);
END;

PROCEDURE TNumKeyboard.FormCreate(Sender: TObject);
BEGIN
  FInitialized := False;
END;

PROCEDURE TNumKeyboard.FormShow(Sender: TObject);
BEGIN
  // Fee structure (*****DO NOT CHANGE*****)
  // ---------------------------------------------------------------------------
  // Income club                             FeeIDs 1,2,3,4,5,6
  // Goodwill                                       7
  // Bar sale at reception                          8
  // Show & VIP                                     12
  // CC commission received                         30
  // Income received, Dare Fondo Cassa              99 SubID 9950
  // Expenses payed, Avere Fondo Cassa              99 SubID 9940
  // Credit cards for girls                         99 SubID 900
  // Credit cards to girls                          99 subId  999
  // Rental Room deposit                            200 subID  299
  // Rental Room paymente                           200 subID  222
  // ---------------------------------------------------------------------------
  If Form1.StartUp Then
    Exit;
  // bt_Receipt.Visible := Form2.tb_AllFees.FieldByName('SubID').AsInteger = 9940;

  // amt := 0;
  dtBusta1.Clear;
  dtBusta2.Clear;
  dtBusta3.Clear;
  plCashBuste.Visible := False;
  pl_Keys.Enabled := False;
  // prevent the form’s Position property from moving it elsewhere
  NumKeyboard.Position := poDesigned;

  Form1.ShowHideBottomBtns(True, True, True, True);
  bt_CashIncasso.Enabled := True;
  bt_CashSpesa.Enabled := True;
  bt_CashDepositIn.Enabled := InRange(uClientStore.ThisCard.cardID, 3000, 5999);
  bt_CashDepositOut.Enabled := InRange(uClientStore.ThisCard.cardID,
    3000, 5999);
  bt_fCassaR.Enabled := InRange(uClientStore.ThisCard.cardID, 9000, 9099);
  bt_fCassaB.Enabled := InRange(uClientStore.ThisCard.cardID, 9000, 9099);
  bt_CCgOut.Enabled := InRange(uClientStore.ThisCard.cardID, 3000, 5999);
  bt_CCgIN.Enabled := InRange(uClientStore.ThisCard.cardID, 3000, 5999);

  Form1.bt_Cancel.Enabled := False;
  Form1.bt_Register.Enabled := False;
  commissionPerc := Form1.ed_CcCommissionAmt.Value;
  lb_ChoseCategory.BehaviorOptions.Active := True;
  dbgd_CCtoG.Visible := False;
end;

FUNCTION TNumKeyboard.VerifyIfComplete: Boolean;
BEGIN
  WITH Form2.tb_OTab DO
  BEGIN
    IF FieldByName('Description').IsNull THEN
    BEGIN
      Form1.nnWriteCashierDisplay(0, False, clYellow,
        'Manca la descrizione', 2);
      ed_Description.SetFocus;
      Result := False;
    END
    ELSE IF (FieldByName('amountCHF').IsNull) AND
      (FieldByName('amountEuro').IsNull) THEN
    BEGIN
      Form1.nnWriteCashierDisplay(0, False, clYellow, 'Manca l''importo', 2);
      Result := False;
    END
    ELSE IF (FieldByName('Paymethod').IsNull) THEN
    BEGIN
      Form1.nnWriteCashierDisplay(0, False, clYellow,
        'Manca l''indicazione della valuta', 2);
      Result := False;
    END
    ELSE
    BEGIN
      Form1.nnWriteCashierDisplay(0, False, clYellow, '', 2);
      Result := True;
    END;
  END;
END;

Procedure TNumKeyboard.UpdateFondoCassaToOtab(Description, costCenter: String);
begin
  With Form2, qy_TMP2 do
  begin
    SQL.Clear;
    SQL.Add('UPDATE OpenTab SET Description = ' + QuotedStr(Description) +
      ', CostCenter = ' + QuotedStr(costCenter) + ' WHERE SubFeeID = 995');
    ExecSQL;
    tb_OTab.Refresh;
  end;
end;

Procedure TNumKeyboard.HandleCCPayments;
Var
  InDate, bustaInDate: TDateTime;
  AValue, in1000, in1010, out2900: Double;
  aPayMethod, alias, workingDay, workingDayPeriod: String;
  aClient, ReceiptCopies: Integer;
  inEnvelope, proceedtoPayment: Boolean;
  cashBalance: Currency;
begin
  Form1.SetDatePeriod(Now, Now, Now, workingDay, workingDayPeriod,
    False, False);

  CheckCashPayment(ed_Description.Text, InDate, bustaInDate, AValue, in1000,
    in1010, out2900, aPayMethod, alias, inEnvelope, aClient);

  If (InDate = 0) AND (AValue = 0) Then
  begin
    Form1.nnWriteCashierDisplay(0, True, clYellow,
      'La ricevuta non esiste o apartiene ad un periodo già chiuso.', 0);
    Exit;
  end;

  If aClient = uClientStore.ThisClient.ID Then
  begin

    (* Function GetCashBalance moved to procedure Form1.xx_SwitchOTabPecunia
      // Get the reception CHF cash balance
      // -------------------------------------------------------------------
      cashBalance := Form2.GetCashBalance;
      if cashBalance < AValue then
      begin
      Form1.nnWriteCashierDisplay(0, True, clYellow,
      'Il saldo cassa non basta per pagare ' + FloatToStr(AValue) +
      ' CHF', 0);
      end;
    *)

    // No such receipt exists
    // ---------------------------------------------------------------------
    IF (InDate = 0) AND (AValue = 0) then
    begin
      Form1.nnWriteCashierDisplay(0, False, clYellow,
        'Non esiste una ricevuta con il codice ' + receiptTxID, 2);
      proceedtoPayment := False;
      Form1.bt_Register.Enabled := False;
      NumKeyboard.Calculator(14);
      Form1.nn_EnablePecuniaBt(False);
      ed_Description.SetFocus;
    end;

    // Check envelope situation (cassa  -> envelope -> payment)
    // ---------------------------------------------------------------------
    IF Form2.tb_AllFees.FieldByName('SubID').AsInteger = 990 Then
    // CC payment to g
    begin
      // CC tx exists - not in envelope, not yet payed
      // -------------------------------------------------------------------
      IF (AValue > 0) AND (in1000 > 0) AND (inEnvelope = False) AND
        (out2900 = 0) Then
      begin
        If DaySpan(InDate, Today) > 2 Then
          Form1.nnWriteCashierDisplay(0, False, clYellow,
            'Da ' + FloatToStr(Trunc(DaySpan(InDate, Today))) +
            ' gg non esiste CASSA > BUSTA. Avvisare ammin.!', 1);
        Form1.nnWriteCashierDisplay(0, False, clWhite,
          'Pagamento di ' + FloatToStr(AValue) +
          ' Euro da CASSA, non da busta .', 2);
      end;
      proceedtoPayment := True;
    end;
    // CC tx exists - in envelope, not yet payed
    // -------------------------------------------------------------------
    IF (AValue > 0) AND (in1000 = in1010) AND (out2900 = 0) AND
      (inEnvelope = True) Then
    begin
      Form1.nnWriteCashierDisplay(0, False, clWhite,
        'Pagamento di ' + FloatToStr(AValue) + ' Euro  da BUSTA del ' +
        DateTimeToStr(DateOf(bustaInDate)) + ' non da cassa.', 2);
      proceedtoPayment := True;
    end;

    // CC tx exists - already payed
    // ---------------------------------------------------------------------
    IF (AValue > 0) AND (in1000 = out2900) Then
    begin
      Form1.nnWriteCashierDisplay(0, False, clWhite,
        'Pagamento di ' + FloatToStr(AValue) + ' già efftuato in data ' +
        DateTimeToStr(InDate), 2);
      proceedtoPayment := False;
      WITH Form2, qy_Tmp DO
      BEGIN
        IF Active THEN
          Close;
        DataBaseName := 'DB_Main';
        SQL.Clear;
        SQL.Add('DELETE FROM OpenTab');
        ExecSQL;
        tb_OTab.Refresh
      END;

      WITH Form2, qy_Tmp DO
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('DELETE FROM OpenTabMemory');
        ExecSQL;
        tb_OTabMemory.Refresh
      END;
    end;
    var
      aAccount: Integer;
      // Now proceed to payment
      // ---------------------------------------------------------------------
    if proceedtoPayment = True then
    begin
      If in1010 = AValue Then
        // cash already set aside in envelope ready for payout
        aAccount := 1010
      else
        aAccount := 1000;

      IF (Form2.tb_OTab.FieldByName('SubFeeID').AsInteger = 990) Then
      aPayMethod := 'EU';
      // only for CC payments. code to verify for deposit reemboursements
      With Form2.tb_OTab do
      begin
        Edit;
         IF aPayMethod = 'EU' Then
        begin
          FieldByName('AmountEuro').AsFloat := AValue;
          FieldByName('PayMethod').AsString := 'EU';
          // FieldByName('CH').AsBoolean := False;
        end
         else
        begin
          FieldByName('AmountCHF').AsFloat := AValue;
          FieldByName('PayMethod').AsString := 'CH';
          // FieldByName('EU').AsBoolean := False;
          If aAccount = 1010 Then
            FieldByName('aAccount').AsInteger := aAccount;
        end;
        FieldByName('ClientID').AsInteger := uClientStore.ThisClient.ID;
        FieldByName('TxID').AsString := ed_Description.Text;
        // FieldByName('TxID').AsString := txid1000;
        FieldByName('AmountToPrint').AsFloat := AValue;
        Post;
      end;
      Form1.bt_Register.Enabled := True;
      Form1.nn_SetPecuniaBtToFieldValue;
    end
    else
    begin
      Form1.bt_Register.Enabled := False;
      NumKeyboard.Calculator(14);
      // Form1.nn_EnablePecuniaBt(True);
      Form1.nn_SetPecuniaBtToFieldValue;
    end;
  end
  else
  begin
    Form1.nnWriteCashierDisplay(0, False, clYellow,
      'La tessera ' + IntToStr(uClientStore.ThisClient.ID) +
      ' sul lettor non corrisponde a ' + alias, 1);
    Exit;
  end;
end;

PROCEDURE TNumKeyboard.ed_Description_Change(Sender: TObject);
BEGIN
  pl_Keys.Enabled := ed_Description.Text <> '';

  With Form2 do
  begin
    IF (tb_OTab.FieldByName('SubFeeID').AsInteger = 990) OR // CC paymento to g
      (tb_OTab.FieldByName('SubFeeID').AsInteger = 289) then
    // Deposit remboursment
    BEGIN
      // Check remboursments
      // -----------------------------------------------------------------------
      IF Length(ed_Description.Text) = 13 THEN
      begin
        HandleCCPayments;
      end;
    end;
  end;
END;

Procedure TNumKeyboard.CheckCashPayment(txID: String;
  out InDate, bustaInDate: TDateTime; out AValue, in1000, in1010,
  out2900: Double; out aPayMethod, alias: String; out inEnvelope: Boolean;
  out aClientID: Integer);
begin
  aClientID := -1;
  With Form2.qy_Tmp do
  begin
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT ' + 'Clients.ID AS ID, ' + 'Clients.Alias, ' +
      'Clients.LastName, ' + 'Clients.FirstName, ' + 'c1000.data AS data1000, '
      + 'c1010.data AS data1010, ' + 'COALESCE(c1000.dare,0) AS dare1000, ' +
      'COALESCE(c1000.avere,0) AS avere1000, ' +
      'COALESCE(c1010.avere,0) AS avere1010, ' +
      'COALESCE(c1010.dare,0) AS dare1010, ' +
      'COALESCE(c1000.cpartita,0) AS cp1000, ' +
      'COALESCE(c1010.cpartita,0) AS cp1010, ' +
      'COALESCE(c2900.dare,0) AS dare2900, ' +
      'COALESCE(c2900.avere,0) AS avere2900, ' + 'c2900.data AS data2900 ' +
      'FROM ' + '(SELECT MIN(data) AS data, MAX(dare) AS dare,MAX(avere) AS avere, MAX(cpartita) AS cpartita, ClientID '
      + 'FROM C_1000 ' + 'WHERE txid = :txid AND SubFeeID IN (990, 999) ' +
      'GROUP BY ClientID) c1000 ' +
      'INNER JOIN Clients ON Clients.ID = c1000.ClientID ' + 'LEFT JOIN ' +
      '(SELECT MIN(data) AS data, MAX(Dare) AS dare, MAX(avere) AS avere, MAX(cpartita) AS cpartita '
      + 'FROM C_1010 ' +
      'WHERE txid = :txid AND SubFeeID IN (990, 999)) c1010 ON 1=1 ' +
      'LEFT JOIN ' +
      '(SELECT MAX(dare) AS dare, MAX(avere) AS avere, MAX(data) AS data ' +
      'FROM C_2900 ' +
      'WHERE txid = :txid AND SubFeeID IN (990, 999)) c2900 ON 1=1';

    Params.ParamByName('txid').AsString := txID;
    Open;
    // no such payment registration
    // ----------------------------------------------------------------------

    If RecordCount = 0 Then
    begin
      InDate := 0;
      bustaInDate := 0;
      AValue := 0;
      in1000 := 0;
      in1010 := 0;
      out2900 := 0;
      aPayMethod := ''; // ??
      inEnvelope := False;
    end
    else
    begin
      InDate := FieldByName('Data1000').AsDateTime;
      bustaInDate := FieldByName('Data1010').AsDateTime;
      AValue := FieldByName('dare1000').AsFloat;
      in1000 := FieldByName('Dare1000').AsFloat;
      in1010 := FieldByName('Dare1010').AsFloat;;
      out2900 := FieldByName('Dare2900').AsFloat;
      aClientID := FieldByName('ID').AsInteger;
      aPayMethod := ''; // ??
      inEnvelope := in1010 > 0;
      alias := FieldByName('Alias').AsString;
    end;
    Close;
  end;
end;

procedure TNumKeyboard.dtBusta1AcceptDate(Sender: TObject; var aDate: TDateTime;
  var Action: Boolean);
begin
  Action := (DaysBetween(aDate, Now) < 4) And (CheckBustaDate(aDate));
  amtBusta1.Enabled := Action;
  if Action then
    lblAmt1.Caption := FloatToStr(CheckBusta(aDate, 1)) + ' CHF'
  else
  begin
    lblAmt1.Caption := '';
    dtBusta1.Clear;
  end;
end;

procedure TNumKeyboard.dtBusta2AcceptDate(Sender: TObject; var aDate: TDateTime;
  var Action: Boolean);
begin
  Action := (DaysBetween(aDate, Now) < 4) And (CheckBustaDate(aDate));
  amtBusta2.Enabled := Action;
  if Action then
    lblAmt2.Caption := FloatToStr(CheckBusta(aDate, 2)) + ' CHF'
  else
  begin
    lblAmt2.Caption := '';
    dtBusta2.Clear;
  end;
end;

procedure TNumKeyboard.dtBusta3AcceptDate(Sender: TObject; var aDate: TDateTime;
  var Action: Boolean);
begin
  Action := (DaysBetween(aDate, Now) < 4) And (CheckBustaDate(aDate));
  amtBusta3.Enabled := Action;
  if Action = True then
    lblAmt3.Caption := FloatToStr(CheckBusta(aDate, 3)) + ' CHF'
  else
  begin
    lblAmt3.Caption := '';
    dtBusta3.Clear;
  end;
end;

Function TNumKeyboard.CheckBustaDate(aDate: TDateTime): Boolean;
begin
  IF ((dtBusta1.Date <> 0) and
    (DateOf(dtBusta1.Date) = DateOf(aDate))) or

    ((dtBusta2.Date <> 0) and
    (DateOf(dtBusta2.Date) = DateOf(aDate))) or

    ((dtBusta3.Date <> 0) and
    (DateOf(dtBusta3.Date) = DateOf(aDate))) then
  begin
    Result := False;
    ShowMessage('Due Date sono identiche!');
  end
  else
  begin

    Result := True;
  end;
end;

function TNumKeyboard.CheckBusta(dataBusta: TDateTime; aTag: Integer): Double;
var
  d, m, y, s: String;
begin
  With Form2.qy_Tmp do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT SUM(Dare) - SUM(Avere) as Saldo from C_1000 ' +
      ' WHERE ClosingID = :cid ' +
      ' AND PayMethod = :pM ';
    d := IntToStr(DayOf(dataBusta));
    m := IntToStr(MonthOf(dataBusta));
    if Length(m) = 1 then
      m := '0' + m;
    y := IntToStr(YearOf(dataBusta));
    ParamByName('cID').AsString := y + '-' + m + '-' + d;
    ParamByName('pM').AsString := 'CH';
    s := y + '-' + m + '-' + d;
    Open;
    If RecordCount > 0 Then
    begin
      Result := Trunc(FieldByName('Saldo').AsFloat);
      FClosingID[aTag - 1] := s;
    end
    else
    begin
      FClosingID[aTag] := '';
      Result := 0;
      Active := False;
    end;
  end;
end;

procedure TNumKeyboard.amtBusta1ChangeValue(Sender: TObject);
begin
  CheckBusta(dtBusta1.Date, dtBusta1.Tag);
  Famt[0] := amtBusta1.Value;
  AmtCHFTotBuste;
end;

procedure TNumKeyboard.amtBusta2ChangeValue(Sender: TObject);
begin
  CheckBusta(dtBusta2.Date, dtBusta2.Tag);
  Famt[1] := amtBusta2.Value;
  AmtCHFTotBuste;
end;

procedure TNumKeyboard.amtBusta3ChangeValue(Sender: TObject);
begin
  CheckBusta(dtBusta3.Date, dtBusta3.Tag);
  Famt[2] := amtBusta3.Value;
  AmtCHFTotBuste;
end;

procedure TNumKeyboard.AmtCHFTotBuste;
begin
  amtTotBuste.ValueFloat := amtBusta1.ValueFloat + amtBusta2.ValueFloat + amtBusta3.ValueFloat;
  IF amtTotBuste.ValueFloat > Form2.tb_OTab.FieldByName('AmountCHF').AsFloat Then
  begin
    ShowMessage(' L''importo immesso è maggiore dell''importo da versare.');
    // btnOkBuste.Enabled := False;
  end;
end;

PROCEDURE TNumKeyboard.bt_0Click(Sender: TObject);
BEGIN
  Calculator(TButton(Sender).Tag);
  OnKbAmtChanging;
END;

procedure TNumKeyboard.bt_CashDepositInClick(Sender: TObject);
begin
  // Check if guest has already payed deposit
  // ---------------------------------------------------------------------------
  With Form2.qy_Tmp do
  begin
    If Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT (COALESCE(SUM(Dare),0) - COALESCE(SUM(AVERE),0)) AS bal FROM c_1000 '
      + 'WHERE ClientID = ' + IntToStr(uClientStore.ThisClient.ID) +
      ' AND SubFeeID IN (289,299) ');
    Active := True;
    IF FieldByName('bal').AsFloat > 0 Then
    begin
      Form1.nnWriteCashierDisplay(0, True, clWhite,
        'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
      Form1.nnWriteCashierDisplay(0, False, clYellow,
        uClientStore.ThisClient.alias + ' ha già un saldo di ' +
        FloatToStrF(FieldByName('bal').AsFloat, ffCurrency, 8, 2) +
        ' di cauzione versata!', 2);
      Exit;
    end;
  end;
  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

procedure TNumKeyboard.bt_CashDepositOutClick(Sender: TObject);
begin
  // Check if there is a un-remboursed deposit payment
  // ---------------------------------------------------------------------------
  With Form2.qy_TMP2 do
  begin
    If Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(SUM(Avere),0) AS AvereSum, COALESCE(SUM(Dare),0) AS DareSum '
      + ' FROM c_1000 WHERE ClientID = ' + IntToStr(uClientStore.ThisClient.ID)
      + ' AND SubFeeID IN (289,299) HAVING COALESCE(SUM(Avere),0) <> 0 ' +
      ' OR COALESCE(SUM(Dare),0)  <> 0');
    Active := True;
    If RecordCount > 0 then
    begin
      IF FieldByName('DareSum').AsFloat - FieldByName('AvereSum')
        .AsFloat = 0 Then
      begin
        Form1.nnWriteCashierDisplay(0, True, clWhite,
          'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
        Form1.nnWriteCashierDisplay(0, False, clYellow,
          'La cauzione è già stata rimborsata a ' +
          uClientStore.ThisClient.alias, 2);
        Active := False;
        Exit;
      end;
    end
    else
    begin
      Form1.nnWriteCashierDisplay(0, False, clYellow,
        'Non risulta nessuna cauzione versata da ' +
        uClientStore.ThisClient.alias, 2);
      Active := False;
      Exit;
    end;
    IF FieldByName('DareSum').AsFloat - FieldByName('AvereSum').AsFloat > 0 Then
      xx_PrepareCashToOtab((Sender as TComponent).Tag, 299, 0, 0, '')
  end;
end;

procedure TNumKeyboard.bt_CashIncassoClick(Sender: TObject);
begin
  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

procedure TNumKeyboard.bt_CashSpesaClick(Sender: TObject);
begin
  With Form1 do
    xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

procedure TNumKeyboard.bt_CCgINClick(Sender: TObject);
begin
  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

procedure TNumKeyboard.bt_CCgOutClick(Sender: TObject);
begin
  With Form2.qy_1000_GCCkeyboard do
  begin
    SQL.Clear;
    SQL.Add('SELECT Data,cl.Alias,Dare, Avere,c.clientID,TxID  ' +
      'FROM c_2900 AS c ' + 'LEFT JOIN Clients AS cl ON c.ClientID = cl.ID ' +
      'WHERE  Canceled <> True AND SubFeeID IN (990,999) ' + ' AND ClientID = '
      + IntToStr(uClientStore.ThisClient.ID) + ' ORDER BY txID, Data ASC ');
    Active := True;
    Refresh;
    Last;
  end;
  ed_Description.Clear;

  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, 'EU');
end;

procedure TNumKeyboard.bt_fCassaBClick(Sender: TObject);
begin
  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

procedure TNumKeyboard.bt_fCassaRClick(Sender: TObject);
begin
  xx_PrepareCashToOtab((Sender as TComponent).Tag, 0, 0, 0, '');
end;

PROCEDURE TNumKeyboard.bt_ReceiptClick(Sender: TObject);
BEGIN
  WITH Form2.tb_OTab DO
  BEGIN
    Edit;
    FieldByName('Receipt').AsBoolean := bt_Receipt.Down;
    Post;
  END;
END;

Procedure TNumKeyboard.xx_PrepareCashToOtab(btTag, subID: Integer;
  aDate: TDateTime; amt: Double; PayMethod: String);
begin
  Sleep(50); // needed for tb_Otab updates
  lb_ChoseCategory.BehaviorOptions.Active := False;
  lb_ChoseCategory.Visible := False;
  NumKeyboard.pl_Keys.Visible := True;
  pl_Keys.Enabled := True;
  ed_Description.EmptyDataInfo.Text := 'Immetti causale entrata/uscita cassa';
  WITH Form2, qy_Tmp DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('DELETE FROM OpenTab');
    ExecSQL;
    tb_OTab.Refresh
  END;

  WITH Form2, qy_Tmp DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('DELETE FROM OpenTabMemory');
    ExecSQL;
    tb_OTabMemory.Refresh
  END;
  Calculator(14);
  Form1.bt_CC.Caption := 'CC';
  With Form1, Form2.tb_AllFees do
  begin
    ed_Description.Clear;
    Case btTag Of
      1: // Incasso
        begin
          nnWriteCashierDisplay(0, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Immetti la causale e poi l''importo dell''incasso!', 2);
          Locate('SubID', 9950, []);
          dbgd_CCtoG.Visible := False;
          xx_WriteFeeToOtab;
        end;
      2: // Spesa
        begin
          nnWriteCashierDisplay(0, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Immetti la causale e poi l''importo della spesa!', 2);
          Locate('SubID', 9940, []);
          dbgd_CCtoG.Visible := False;
          xx_WriteFeeToOtab;
        end;
      3: // Rental deposit in
        begin
          nnWriteCashierDisplay(0, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Immetti l''importo della cauzione camera!', 2);
          ed_Description.Text := ThisClient.alias + ' pag. Cauzione Camera';
          Locate('SubID', 299, []);
          dbgd_CCtoG.Visible := False;
          xx_WriteFeeToOtab;
        end;
      4: // Rental deposit out
        begin
          ed_Description.SetFocus;
          nnWriteCashierDisplay(0, False, clWhite,
            'Scansiona il codice QR della ricevuta oppure aggiungilo manualmente.',
            2);
          Locate('SubID', 289, []); // locate the row for xx_WriteFeeOtab
          dbgd_CCtoG.Visible := False;
          xx_WriteFeeToOtab;
        end;
      5: // Fondo Cassa Club
        begin
          dbgd_CCtoG.Visible := False;
          Locate('SubID', 995, []);
          xx_WriteFeeToOtab;
          ed_Description.Text := 'Fondo cassa Club';
          UpdateFondoCassaToOtab('Fondo cassa Club', 'c');
          nnWriteCashierDisplay(0, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Immetti l''importo del fondo cassa club!', 2);
        end;
      6: // Fondo Cassa Bar
        begin
          dbgd_CCtoG.Visible := False;
          Locate('SubID', 995, []);
          xx_WriteFeeToOtab;
          ed_Description.Text := 'Fondo cassa Bar';
          UpdateFondoCassaToOtab('Fondo cassa Bar', 'b');
          nnWriteCashierDisplay(0, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Immetti l''importo del fondo cassa bar!', 2);
        end;
      7: // CC payments from clients for g
        begin
          dbgd_CCtoG.Visible := False;
          IF NOT InRange(uClientStore.ThisCard.cardID, 3000, 5999) Then
          begin
            nnWriteCashierDisplay(0, True, clYellow,
              'Tessera ' + IntToStr(uClientStore.ThisCard.cardID) +
              ' non valida ', 1);
            nnWriteCashierDisplay(0, False, clWhite,
              'Tessera valide dal 3000 al 5999', 2);
            // pl_Keys.Visible := False;
            Exit;
          end
          else
          begin
            If uClientStore.ThisClient.ID <= 0 Then
            begin
              nnWriteCashierDisplay(0, True, clYellow,
                'La Tessera ' + IntToStr(uClientStore.ThisCard.cardID) +
                ' non appartiene a nessun cliente!', 2);
              Exit;
            end;
            If NOT InRange(uClientStore.ThisClient.entrySubFeeID, 300, 399) Then
            begin
              // pl_Keys.Visible := False;
              Form1.nnWriteCashierDisplay(0, False, clYellow,
                uClientStore.ThisClient.alias +
                ' non ha ancora una entrata valida per oggi!', 1);
              Form1.nnWriteCashierDisplay(0, False, clYellow,
                'Incassi CC unicamente con entrata club valida', 2);
              Exit;
            end
            else
            begin
              nnWriteCashierDisplay(0, True, clYellow,
                'Tessera ' + IntToStr(uClientStore.ThisCard.cardID), 1);
              nnWriteCashierDisplay(0, False, clWhite,
                'Incasso carta di credito per ' + ThisClient.alias, 2);
              ed_Description.Text := 'Incasso cc per ' + ThisClient.fName + '' +
                ThisClient.lName;
              Locate('SubID', 999, []);
              xx_WriteFeeToOtab;
            end;
          end;
        end;
      8: // CC payment to g
        begin
          Form1.bt_CC.Caption := 'IBAN';
          dbgd_CCtoG.Visible := True;
          ed_Description.SetFocus;
          nnWriteCashierDisplay(1, True, clWhite,
            'Tessera ' + IntToStr(uClientStore.ThisCard.cardID) + ': ' +
            ThisClient.alias, 1);
          nnWriteCashierDisplay(0, False, clWhite,
            'Scansiona il codice QR della ricevuta CC oppure aggiungilo manualmente.',
            2);
          ed_Description.EmptyDataInfo.Text :=
            'Scansiona il codice QR della ricevuta CC oppure aggiungilo manualmente.';
          Locate('SubID', 990, []);
          xx_WriteFeeToOtab;
        end;
    End;
  end;
end;

FUNCTION TNumKeyboard.Calculator(aKey: Integer): Double;
BEGIN

  BEGIN
    CASE aKey OF
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
        BEGIN
          tmpStr := tmpStr + IntToStr(aKey);

          Form1.dbgd_CashierDisplay.SumList.RecalcAll;
        END;
      10:
        IF hasCents THEN
          Result := StrToFloat(dollars + '.' + cents)
        ELSE
        BEGIN
          hasCents := True;
          tmpStr := '';
        END;
      13:
        BEGIN
          //
        END;
      14:
        BEGIN
          tmpStr := '';
          dollars := '';
          cents := '';
          hasCents := False;
          amt := 0;
          ccCommission := 0;
          Form2.t_executequery
            ('UPDATE OpenTab SET amountCHF = NULL, amountEuro = NULL,' +
            'AmountToPrint = NULL, PayMethod = '''' ', 'DB_Main',
            'PGC_DB_Main_Euro', 'OpenTab');
          Form1.dbgd_CashierDisplay.SumList.RecalcAll;
        END;
    END;
  END;
  IF NOT hasCents THEN
    dollars := tmpStr
  ELSE
    cents := Copy(tmpStr, 1, 2);
  IF (dollars <> '') OR (cents <> '') THEN
    amt := StrToFloat(dollars + '.' + cents)
  ELSE
    amt := 0;
  Result := amt;
  Form1.bt_Cancel.Enabled := amt > 0;
  IF (Form2.tb_AllFees.FieldByName('SubID').AsInteger = 999) AND (amt > 0) THEN
  // CC commission
  BEGIN
    CASE Form1.rg_CommissionCC.ItemIndex OF
      0:
        ccCommission := Ceil((amt / 100) * commissionPerc);
      1:
        ccCommission := Ceil((amt / 100) * commissionPerc);
    END;
  END;

END;

PROCEDURE TNumKeyboard.OnKbAmtChanging;
VAR
  s0, s1: STRING;
BEGIN
  IF NOT Form1.StartUp THEN
  BEGIN
    WITH Form2 DO
      CASE tb_AllFees.FieldByName('SubID').AsInteger OF
        999: // Credit card to girl
          BEGIN
            s0 := 'UPDATE OpenTab SET amountCHF = ' + FloatToStr(amt) +
              ', amountEuro = NULL,' + 'AmountToPrint = ' + FloatToStr(amt) +
              ', PayMethod = ''CC'' ' + 'WHERE SubFeeID = 999';

            s1 := 'UPDATE OpenTab SET amountCHF = ' + FloatToStr(ccCommission) +
              ', amountEuro = NULL,' + 'PayMethod = ''CC'' ' +
              'WHERE SubfeeID = 998';
          END;
        222, 289, 299: // Bar, Rental payments, Deposits out or in
          BEGIN
            s0 := 'UPDATE OpenTab SET amountCHF = ' + FloatToStr(amt) +
              ', AmountToPrint = ' + FloatToStr(amt) + ', amountEuro = ' +
              FloatToStr(amt) + 'WHERE SubfeeID = ' +
              IntToStr(tb_AllFees.FieldByName('SubID').AsInteger);

            s1 := 'UPDATE OpenTabMemory SET amountCHF = ' + FloatToStr(amt) +
              ', amountEuro = ' + FloatToStr(amt) + 'WHERE SubfeeID = ' +
              IntToStr(tb_AllFees.FieldByName('SubID').AsInteger);
          END;
        9940 .. 9949: // Expenses
          BEGIN
            s0 := 'UPDATE OpenTab SET ' + 'AmountToPrint = ' + FloatToStr(amt) +
              ', ' + 'Description = CASE WHEN ' + QuotedStr(ed_Description.Text)
              + ' = '''' ' + 'THEN Description ELSE ' +
              QuotedStr(ed_Description.Text) + ' END, ' + 'amountCHF = ' +
              FloatToStr(amt) + ', ' + 'amountEuro = ' + FloatToStr(amt) + ' ' +
              'WHERE SubfeeID = ' + IntToStr(tb_AllFees.FieldByName('SubID')
              .AsInteger);
          END;
        900, 950, 995, 9950 .. 9959: // Income
          BEGIN
            IF tb_OTab.FieldByName('SubFeeID').AsInteger = 995 Then
              s0 := 'UPDATE OpenTab SET AmountToPrint = ' + FloatToStr(amt) +
                ', amountCHF = ' + FloatToStr(amt) + ', amountEuro = ' +
                FloatToStr(amt) + ' WHERE SubfeeID = 995'
            else
              s0 := 'UPDATE OpenTab SET AmountToPrint = ' + FloatToStr(amt) +
                ', amountCHF = ' + FloatToStr(amt) + ', amountEuro = ' +
                FloatToStr(amt) + ' WHERE SubfeeID = ' +
                IntToStr(tb_AllFees.FieldByName('SubID').AsInteger);
          END;
      END;

    WITH Form2, qy_TMP2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add(s0);
      ExecSQL;
      IF s1 <> '' THEN
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add(s1);
        ExecSQL;
      END;
      Form1.dbgd_CashierDisplay.SumList.RecalcAll;
      Form2.tb_OTab.Refresh;
    END;
  END;
END;

procedure TNumKeyboard.btnCloseBustaPLClick(Sender: TObject);
begin
  plCashBuste.Visible := False;
  dtBusta1.Clear;
  dtBusta2.Clear;
  dtBusta3.Clear;
  amtBusta1.Clear;
  amtBusta2.Clear;
  amtBusta3.Clear;
  lblAmt1.Caption := '';
  lblAmt2.Caption := '';
  lblAmt3.Caption := '';
end;

procedure TNumKeyboard.btnOkBusteClick(Sender: TObject);
Var
  aD: TDateTime;
  FS: TFormatSettings;
  x: Integer;
begin
  If MessageDlg('Procedi per la registrazione?', mtInformation,
    mbOKCancel, 0) <> mrOk Then
    Exit
  else
  begin
    FS := TFormatSettings.Create;
    FS.DateSeparator := '-';
    FS.ShortDateFormat := 'yyyy-mm-dd';
    for x := 0 to 2 do
      With Form2, qy_TMP2 do
      begin
        If FClosingID[x] = '1899-12-30' Then
          Continue;
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO c_2900' +
          ' (Data, ClientID, CardID, Description, Dare' +
          ', FeeID, SubFeeID,' +
          '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID, ClosingID)'
          + ' VALUES (:aData, :clientID, :cardID, :descr, :amt,' +
          '         :feeID, :subFeeID, :verified, :canceled,' +
          '         :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid, :cID)';
        aD := StrToDate(FClosingID[x], FS);
        // aD := StrToDateTime(FClosingID[x]+' '+'00:00:00');
        Params.ParamByName('aData').AsDateTime := aD;
        Params.ParamByName('clientID').AsInteger := tb_OTab.FieldByName('ClientID').AsInteger;
        Params.ParamByName('cardID').AsInteger := ThisClient.cardID;
        Params.ParamByName('descr').AsString := 'Pagam CC Rag ' + FormatDateTime('dd/mm/yy', Date);
        Params.ParamByName('amt').AsFloat := Famt[x];
        Params.ParamByName('feeID').AsInteger := 99;
        Params.ParamByName('subFeeID').AsInteger := 990;
        Params.ParamByName('verified').AsBoolean := False;
        Params.ParamByName('canceled').AsBoolean := False;
        Params.ParamByName('payMethod').AsString := 'CH';
        Params.ParamByName('costCenter').AsString := 'c';
        Params.ParamByName('operator').AsString := Trim(Form1.cashier);
        Params.ParamByName('receipt').AsBoolean := False;
        Params.ParamByName('cPartita').AsInteger := 1000;
        Params.ParamByName('txid').AsString := tb_OTab.FieldByName('TxID').AsString;
        Params.ParamByName('cID').AsString := FClosingID[x];
        ExecSQL;

        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO c_1000' +
          ' (Data, ClientID, CardID, Description, Avere' +
          ', FeeID, SubFeeID,' +
          '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID, ClosingID)'
          + ' VALUES (:aData, :clientID, :cardID, :descr, :amt,' +
          '         :feeID, :subFeeID, :verified, :canceled,' +
          '         :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid, :cID)';
        aD := StrToDate(FClosingID[x], FS);
        // aD := StrToDateTime(FClosingID[x]+' '+'00:00:00');
        Params.ParamByName('aData').AsDateTime := aD;
        Params.ParamByName('clientID').AsInteger := tb_OTab.FieldByName('ClientID').AsInteger;
        Params.ParamByName('cardID').AsInteger := ThisClient.cardID;
        Params.ParamByName('descr').AsString := 'Pagam CC Rag ' + FormatDateTime('dd/mm/yy', Date);
        Params.ParamByName('amt').AsFloat := Famt[x];
        Params.ParamByName('feeID').AsInteger := 99;
        Params.ParamByName('subFeeID').AsInteger := 990;
        Params.ParamByName('verified').AsBoolean := False;
        Params.ParamByName('canceled').AsBoolean := False;
        Params.ParamByName('payMethod').AsString := 'CH';
        Params.ParamByName('costCenter').AsString := 'c';
        Params.ParamByName('operator').AsString := Trim(Form1.cashier);
        Params.ParamByName('receipt').AsBoolean := False;
        Params.ParamByName('cPartita').AsInteger := 2900;
        Params.ParamByName('txid').AsString := tb_OTab.FieldByName('TxID').AsString;
        Params.ParamByName('cID').AsString := FClosingID[x];
        ExecSQL;
      end;
  end;
end;

PROCEDURE TNumKeyboard.WriteReceiptToOtab(Sender: TObject);
BEGIN
  WITH Form2, tb_OTab DO
  BEGIN
    Edit;
    // FieldByName('Receipt').AsBoolean := Form1.bt_Receipt.Down;
    Post;
  END;
END;

END.
