unit Tabulae;

// use new tabulae unit  12.08.24
// =================================
// 1000 Cassa
// 1200 Clients
// 2000 Fornitori
// 2300 CC 2 clients
// 4000 Club revenues
// 6000 Expenses
// 7000 Rettifiche e sconti
// ---------------------------------
// Esempio vendita
// Conto	              Dare	Avere
// ---------------------------------
// 1200 Conto clienti    69.-
// 3200 Ricavi da servizi		   69.-
//
// Esempio incasso
// Conto	              Dare	Avere
// ---------------------------------
// 1000                  69.-
// 1200                        69.-

interface

uses
	// Windows
	// --------------------------------------------
	Winapi.Windows,
	Winapi.Messages,
	Winsock,

	// System
	// --------------------------------------------
	System.SysUtils,
	System.DateUtils,
	System.Math,
	System.UITypes,
	System.Variants,
	System.RegularExpressions,
	System.AnsiStrings, System.Classes,
	ShlObj, ActiveX,

	// VCL
	// ---------------------------------------------
	Vcl.DBCtrls,
	Vcl.Graphics,

	StrUtils,
	Printers, RzButton,
	Data.DB, ExtCtrls, Dialogs, edbcomps;

Procedure ReferoInTabulae;

implementation

uses DM1, Routines, Main, CalcPecunia;

Procedure ReferoInTabulae;
Var
	s, DareQy, AvereQy, pMethod: String;
	saleAmt: Double;
	// i: Integer;
begin
	saleAmt := 0;
	// -------------------------------------------------------------------------------
	// Register all, sale and payment, to accounts
	// -------------------------------------------------------------------------------
	With Form1, DM.qy_All0000 do
	begin
		If pLaterClosingNow Then
		begin
			IF Active Then
				Close;
			SQL.Clear;
			SQL.Add('SELECT * FROM c_0000');
			Active := True;
			saleAmt := FieldValues[('Sale')];

		end
		else
		begin
			{ Not a paylater payment
				---------------------- }
			IF Active Then
				Close;
			SQL.Clear;
			SQL.Add('SELECT * FROM c_0000');
			Active := True;
			First;
			While Not EoF do
			begin
				IF FieldValues[('Sale')] > 0 Then
					saleAmt := RoundTo(FieldValues[('Sale')], -2);
				IF FieldValues[('Payment')] > 0 Then
					thisPecuniaAmt := RoundTo(FieldValues[('Payment')], -2);
				// Write Dare account values
				// ---------------------------------------------
				IF (saleAmt > 0) Then
				begin
					s := QuotedStr(FieldValues[('Description')]);
					s := IntToStr(FieldValues[('FeeID')]);
					s := IntToStr(FieldValues[('SubFeeID')]);
					s := IntToStr(FieldValues[('A_Account')]);
					s := IntToStr(FieldValues[('ClientID')]);
					s := IntToStr(FieldValues[('CardID')]);
					s := QuotedStr(FieldValues[('TxID')]);
					s := QuotedStr(thisOperator.fName);

					DareQy := 'INSERT INTO c_' +
						IntToStr(FieldValues[('D_Account')]) +
						' (Data, Description, Dare, FeeID, SubFeeID,ControPartita,ClientID, CardID,TxID,Operator) '
						+ 'VALUES(CURRENT_TimeStamp,' +
						QuotedStr(FieldValues[('Description')]) + ', ' + FloatTostr(saleAmt) + ', '
						+ IntToStr(FieldValues[('FeeID')]) +
						', ' + IntToStr(FieldValues[('SubFeeID')]) + ', ' +
						IntToStr(FieldValues[('A_Account')]) +
						', ' + IntToStr(FieldValues[('ClientID')]) + ', ' +
						IntToStr(FieldValues[('CardID')]) +
						', ' + QuotedStr(FieldValues[('TxID')]) + ', ' +
						QuotedStr(thisOperator.fName) + ')';
					IF Not DM.WriteAllData(DareQy) Then
						ShowMessage
							('Errore registrazione vendita Dare');

					// Write Avere account values
					// ---------------------------------------------
					DareQy := 'INSERT INTO c_' +
						IntToStr(FieldValues[('A_Account')]) +
						' (Data, Description, Avere, FeeID, SubFeeID,ControPartita,ClientID, CardID,TxID, Operator) '
						+ 'VALUES(CURRENT_TimeStamp,' +
						QuotedStr(FieldValues[('Description')]
						) + ', ' + FloatTostr(saleAmt) + ', '
						+ IntToStr(FieldValues[('FeeID')]) +
						', ' + IntToStr
						(FieldValues[('SubFeeID')]) + ', ' +
						IntToStr(FieldValues[('D_Account')]) +
						', ' + IntToStr
						(FieldValues[('ClientID')]) + ', ' +
						IntToStr(FieldValues[('CardID')]) +
						', ' + QuotedStr(FieldValues[('TxID')]
						) + ', ' +
						QuotedStr(thisOperator.fName) + ')';
					IF Not DM.WriteAllData(DareQy) Then
						ShowMessage
							('Errore registrazione vendita Avere');
				end;

				// Write Avere account values
				// ---------------------------------------------
				IF (FieldValues[('Payment')] > 0) Then
				// income not expense
				begin
					pMethod := FieldValues[('PayMethod')];
					AvereQy := 'INSERT INTO c_' +
						IntToStr(FieldValues[('A_Account')]) +
						' (Data, Description, Avere,ControPartita,PayMethod, ClientID, CardID, TxID,Operator) '
						+ 'VALUES(CURRENT_TimeStamp,' +
						QuotedStr(FieldValues[('Description')]
						) + ', ' + FloatTostr(thisPecuniaAmt)
						+ ', ' + IntToStr
						(FieldValues[('D_Account')]) + ', ' +
						QuotedStr(FieldValues[('PayMethod')])
						+ ', ' + IntToStr
						(FieldValues[('ClientID')]) + ', ' +
						IntToStr(FieldValues[('CardID')]) +
						', ' + QuotedStr(FieldValues[('TxID')]
						) + ', ' +
						QuotedStr(thisOperator.fName) + ')';
					IF Not DM.WriteAllData(AvereQy) Then
						ShowMessage
							('Errore registrazione pagamento Avere');
					Sleep(50);

					// Write Dare values
					// ---------------------------------------------
					AvereQy := 'INSERT INTO c_' +
						IntToStr(FieldValues[('D_Account')]) +
						' (Data, Description, Dare,ControPartita,PayMethod, ClientID, CardID,TxID,Operator) '
						+ 'VALUES(CURRENT_TimeStamp,' +
						QuotedStr(FieldValues[('Description')]
						) + ', ' + FloatTostr(thisPecuniaAmt)
						+ ', ' + IntToStr
						(FieldValues[('A_Account')]) + ', ' +
						QuotedStr(FieldValues[('PayMethod')])
						+ ', ' + IntToStr
						(FieldValues[('ClientID')]) + ', ' +
						IntToStr(FieldValues[('CardID')]) +
						', ' + QuotedStr(FieldValues[('TxID')]
						) + ', ' +
						QuotedStr(thisOperator.fName) + ')';
					IF Not DM.WriteAllData(AvereQy) Then
						ShowMessage
							('Errore registrazione pagamento Dare');
					Sleep(10);
				end;
				saleAmt := 0;
				thisPecuniaAmt := 0;
				Next;

			end;
			IF Active Then
				Close;
			SQL.Clear;
			SQL.Add('UPDATE c_0000 SET Registered = True');
			ExecSQL;

			dbgd_0000.Font.Color := clTeal;
			dbgd_Fees.Enabled := True;
			With bt_Confirm do
			begin
				Tag := -1;

				Enabled := False;
			end;
			AllPecuniaBtsUp;
			CancelAll(False);
			// SetStepIndicatorLB('Registrazione completata', False,True, 10000, clLime);
			ShowHideStepIcons(3, 2, True, True);
			RefreshCashierTables(False);
		end;
	end;
end;

end.
