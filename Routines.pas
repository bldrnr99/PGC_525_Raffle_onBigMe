unit Routines;

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
	System.JSON,
	Registry,
	ShlObj, ActiveX,

	// VCL
	// ---------------------------------------------
	Vcl.DBCtrls,
	Vcl.Graphics,

	StrUtils,
	Printers, RzButton,
	JPEG, PNGImage, Data.DB, ExtCtrls,
	GIFImg, Dialogs, edbcomps;

function GenerateTxID: STRING;
function IsValidEmail(const Email: string): Boolean;
Function isValidAge(bDate: TDate): Boolean;
Function GetClientIDFromCardID(CardID: Integer): Integer;
Function GetClientData(ID: Integer): Boolean;
Function VerifyValidityCard(CardID: Integer): Boolean;
function DateTimeToSQLString(isStartDT: Boolean; DateTime: TDateTime): string;
procedure LoadImageFromBlob(field: TBlobField; ImageControl: TImage);
function GetImageTypeFromBlob(field: TBlobField): string;
procedure SaveImageToBlobField(const FileName: string; field: TBlobField);
procedure LoadImage(Sender: TObject; field: TBlobField; table: TEDBTable;
	ImageControl: TImage; dbImageControl: TDBImage);
procedure FillAttendanceCalendar(FeeID, ClientID: Integer);
Procedure FilterAndSortClients(ColIndex, RadioGroupIndex: Integer;
	filterStr: String);
procedure CashRegistryValues(write: Boolean);
Procedure RefreshClientsQy;
Procedure Empty_0000;
Function WriteSaleTo0000(rDate: TDateTime; Description, txID: String;
	FeeID, SubFeeID, dAccount, aAccount: Integer; Sale: Double; ch, eu, cc, pd, off: Boolean): Boolean;
Function WritePaymentTo0000(rDate: TDateTime; Description, PayMethod: String;
	Payment: Double): Boolean;
Function CheckPayment(DateTime: TDateTime;
	FeeID, SubFeeID, ClientID: Integer): Integer;
Function CheckIfSaleClosed: Boolean;
Procedure SetVisiblePecuniaBtn(aSubId: Integer; surcharge: Boolean);
Procedure SetSinglePecuniaBtState(button, state: Integer);
Procedure GetClubOpeningDT(FromDT, ToDT: TDateTime);
Procedure GetClubOpeningDTNow;
function GetDocumentsFolder: string;
function GetApplicationName: string;
procedure RefreshCashierTables(empty0000: Boolean);
procedure WriteToRegistry;
procedure ReadFromRegistry;
Procedure SetStepIndicatorLB(s: String; blink, tEnabled: Boolean;
	tInterval: Integer; fCol: TColor);
Procedure GetShowClientData(cID: Integer);
Function ShowCustomTaskDialog(aCaption, aTitle, aText, aFooterTxt: String;
	ACommonButtons: TTaskDialogCommonButtons; AFlags: TTaskDialogFlags;
	AMainIcon: TTaskDialogIcon): TModalResult;
Function Show1200Period(sDT, eDt: TDateTime; ClientID: Integer): Integer;
Function WriteExpenseTo0000(rDate: TDateTime; Description, txID: String;
	FeeID, SubFeeID, dAccount, aAccount: Integer; Amt: Double): Boolean;
Procedure SetXRateData(xR: Double);
Function GetFeeAgain(SubFeeID: Integer; surchargeFee, euroFee: Boolean): Double;
Procedure ShowHideStepIcons(Img, imgShown: Byte; ShowIt, ActivateIt: Boolean);
Procedure WriteEuroInfo(txt1, txt2: String; Amt: Double);
Procedure WriteFooters(txt0, txt1, txt2: String; f: Integer);
Procedure Cancel0000Footers;
Function CanSetPecunia: Boolean;
Function GetBalance: Double;

implementation

uses Main, DM1, CalcPecunia, Tabulae, KeyBoard;

Function GetBalance: Double;
Var
	dSum, aSum: Double;
begin
	WITH Form1.dbgd_0000 do
	begin
		IF Columns[1].Footers[0].SumValue = NULL Then
			dSum := 0
		else
			dSum := Columns[1].Footers[0].SumValue;

		IF Columns[2].Footers[0].SumValue = NULL Then
			aSum := 0
		else
			aSum := Columns[2].Footers[0].SumValue;
		Result := dSum - aSum;
	end;
end;

Function CanSetPecunia: Boolean;
var
	ModalResult: TModalResult;
begin
	With DM.tb_0000 do
	begin
		IF not FieldByName('PayMethod').IsNull Then
		begin

			ModalResult := ShowCustomTaskDialog(
				'Cambio valuta pagamento',
				// Window caption
				FieldByName('Description').AsString + ' è messa su ' + FieldByName('PayMethod').AsString,
				// Dialog title
				'Vuoi cambiarlo?', // Message text
				'',
				[tcbOK, tcbNo], // Common buttons: OK and Cancel
				[tfAllowDialogCancellation], // Flags: Allow dialog cancellation
				tdiInformation // Icon: Information icon
				);

			case ModalResult of
				mrOK:
					Result := True;
				mrNo:
					Result := False;
				mrCancel:
					Result := False;
			end;
		end
		else
			Result := True;
	end;
end;

Procedure WriteFooters(txt0, txt1, txt2: String; f: Integer);
Var
	i: Integer;
begin
	{
		With Form1.dbgd_0000 do
		begin
		For i := 1 To 3 Do
		begin
		IF Columns[1].Footers[i].Value = '' Then
		begin
		Columns[0].Footers[i].Value := txt0;
		Columns[1].Footers[i].Value := txt1;
		Columns[3333].Footers[i].Value := txt2;
		Exit;
		end;
		end;
		end;
	}
end;

Procedure Cancel0000Footers;
begin
	{
		With Form1.dbgd_0000 do
		begin
		Columns[0].Footers[0].Value := '';
		Columns[0].Footers[1].Value := '';
		Columns[0].Footers[2].Value := '';
		Columns[0].Footers[3].Value := '';

		Columns[1].Footers[1].Value := '';
		Columns[1].Footers[2].Value := '';
		Columns[1].Footers[3].Value := '';

		Columns[2].Footers[0].Value := '';
		Columns[2].Footers[1].Value := '';
		Columns[2].Footers[2].Value := '';
		Columns[2].Footers[3].Value := '';
		end;
	}
end;

Procedure WriteEuroInfo(txt1, txt2: String; Amt: Double);
begin
	{
		With Form1 do
		begin
		dbgd_0000.Columns[0].Footers[1].Value := txt1;
		dbgd_0000.Columns[1].Footers[1].Font.Style := [fsBold];
		dbgd_0000.Columns[1].Footers[1].Font.Color := clBlue;
		dbgd_0000.Columns[1].Footers[1].Value := FloatToStrF(Amt, ffNumber, 4, 2);
		end;
	}
end;

Procedure ShowHideStepIcons(Img, imgShown: Byte; ShowIt, ActivateIt: Boolean);
begin
	With Form1 do
	begin
		JvGIFAnimator_left.Animate := False;
		JvGIFAnimator_left.Visible := False;
		JvGIFAnimator_Right.Animate := False;
		JvGIFAnimator_Right.Visible := False;
		JvGIFAnimatorUP.Visible := False;
		JvImageTransform_UpDownThumbs.Visible := False;
		Case Img of
			1:
				begin
					JvGIFAnimator_left.Animate := ActivateIt;
					JvGIFAnimator_left.Visible := ShowIt;
				end;
			2:
				begin
					JvGIFAnimator_Right.Animate := ActivateIt;
					JvGIFAnimator_Right.Visible := ShowIt;
				end;
			3:
				begin
					JvImageTransform_UpDownThumbs.Visible := ShowIt;
					JvImageTransform_UpDownThumbs.Transform;
					// IF ImgShown = 0, Then switch from one image to the other; else 1 = Thumb down 2 = thumb up
					JvImageTransform_UpDownThumbs.ImageShown := imgShown;
				end;
			4:
				begin
					JvGIFAnimatorUP.Animate := ActivateIt;
					JvGIFAnimatorUP.Visible := ShowIt;
				end;
		End;
	End;
end;

Procedure SetVisiblePecuniaBtn(aSubId: Integer; surcharge: Boolean);
Var
	s: String;
begin
	If surcharge then
		s := 'X'
	else
		s := '';
	WITH Form1, DM.qy_AllFees do
	begin
		If Locate('SubID', aSubId, []) then
		begin
			bt_CHF.Visible := FieldByName(s + 'CHF').AsBoolean;
			bt_EU.Visible := FieldByName(s + 'EURO').AsBoolean;
			bt_CC.Visible := FieldByName(s + 'CC').AsBoolean;
			bt_pLater.Visible := FieldByName(s + 'PayLater').AsBoolean;
			bt_Off.Visible := FieldByName(s + 'CanBeOffered').AsBoolean;
			bt_MixPec.Visible := FieldByName(s + 'MixPecunia').AsBoolean;

			bt_CHF.Enabled := FieldByName(s + 'CHF').AsBoolean;
			bt_EU.Enabled := FieldByName(s + 'EURO').AsBoolean;
			bt_CC.Enabled := FieldByName(s + 'CC').AsBoolean;
			bt_pLater.Enabled := FieldByName(s + 'PayLater').AsBoolean;
			bt_Off.Enabled := FieldByName(s + 'CanBeOffered').AsBoolean;
			bt_MixPec.Enabled := FieldByName(s + 'MixPecunia').AsBoolean;
		end;
	end;
end;

Function GetFeeAgain(SubFeeID: Integer; surchargeFee, euroFee: Boolean): Double;
Var
	s, dataField: String;
begin
	IF not surchargeFee then
	begin
		If euroFee then
			dataField := 'FeeEuro'
		else
			dataField := 'Fee';
	end
	else
	begin
		If euroFee Then
			dataField := 'BeforeCutOffEuroAmt'
		else
			dataField := 'BeforeCutOffAmt';
	end;

	With DM.qy_AllFees do
	begin
		IF Locate('SubID', SubFeeID, []) Then
			IF Not euroFee Then
				Result := FieldByName(dataField).AsFloat
			else
				IF FieldByName('UseExchangeRate').AsBoolean = False Then
				Result := FieldByName(dataField).AsFloat
			else
				IF Not surchargeFee then
				Result := CEIL(FieldByName('Fee').AsFloat / StrToFloatDef(Form1.lb_ourXRate.Caption, 1))
			else
				Result := CEIL(FieldByName('BeforeCutOffAmt').AsFloat / StrToFloatDef(Form1.lb_ourXRate.Caption, 1));
	end;
end;

Procedure SetXRateData(xR: Double);
begin
	With Form1 do
	begin
		If (xR > 0) Then
		begin
			lb_EurChf.Caption := '1€= ' + FloatTostr(xR) + ' CHF';
			lb_OfficEuChf_XRate.Caption := FloatTostr(xR);
			lb_ourXRate.Caption := FloatTostr(xRate - (xR / 100 * 10));
			lb_TodaysXrate.Caption := 'Cambio ufficiale del ' + DateToStr(lstxRateDT);
		end;
	end;
end;

Function Show1200Period(sDT, eDt: TDateTime; ClientID: Integer): Integer;
Var
	s: String;
begin
	If ClientID > -1 Then
		s := ' AND ClientID = ' + IntToStr(ClientID) + ' '
	else
		s := '';
	WITH DM.qy_1200nAlias do
	begin
		If Active Then
			Close;
		SQL.Clear;
		SQL.Add('SELECT Data, CAST(Data AS TIME) AS Ora,cl.Alias, ClientID, CardID, Description, Dare, Avere, PayMethod, TxID '
			+ 'FROM c_1200 c ' + 'Left JOIN Clients cl ON cl.ID = c.ClientID ' +
			'WHERE Data BETWEEN CAST(' +
			QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', sDT)) +
			' AS TIMESTAMP) AND ' + 'CAST(' +
			QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', eDt)) + ' AS TIMESTAMP) ' + s +
			' ORDER BY Data');
		Active := True;
		Refresh;
		Last;

		With Form1.dbgd_1200_nAlias do
		begin
			DisableControls;
			Refresh;
			EnableControls;
		end;
		Result := RecordCount;
	end;
end;

Function ShowCustomTaskDialog(aCaption, aTitle, aText, aFooterTxt: String;
	ACommonButtons: TTaskDialogCommonButtons; AFlags: TTaskDialogFlags;
	AMainIcon: TTaskDialogIcon): TModalResult;
var
	TaskDialog: TTaskDialog;
begin
	TaskDialog := TTaskDialog.Create(nil);
	With TaskDialog do
		try
			Caption := aCaption;
			Title := aTitle;
			Text := aText;
			CommonButtons := ACommonButtons;
			Flags := AFlags;
			MainIcon := AMainIcon;
			TaskDialog.FooterText := aFooterTxt;

			// Execute the task dialog
			if TaskDialog.Execute then
				Result := TaskDialog.ModalResult
			else
				Result := mrNone;
		finally
			TaskDialog.Free;
		end;
end;

Procedure GetShowClientData(cID: Integer);
begin
	// -------------------------------------------------------------------------
	// Get and show client data
	// ------------------------
	With Form1 do
		IF (GetClientData(cID)) then
		begin
			IF thisClient.Enabled Then
			begin
				lb_Cashier_Alias.Caption := thisClient.Alias + '  ' + IntToStr(thisClient.CardID) + '  ' +
					IntToStr(thisClient.ClientID);

				DM.qy_Clients.Locate('ID', thisClient.ClientID, []);

			end
			else
			begin
				ShowMessage('Cliente non autorizzato!');
				Exit;
			end;
			Show1200Period(thisStartEndDT.clubStartDtToday,
				thisStartEndDT.clubEndDtToday, thisClient.ClientID);
		end
		else
		begin
			lb_Cashier_Alias.Caption := '';
		end;

end;

Procedure SetStepIndicatorLB(s: String; blink, tEnabled: Boolean; tInterval: Integer; fCol: TColor);
begin
	With Form1.lb_StepIndicator do
	begin
		Caption := s;
		BehaviorOptions.Active := blink;
		Form1.lb_StepIndicator.Font.Color := fCol;
	end;
	{ With Form1.JvThreadTimer1 do
		begin
		Interval := tInterval;
		Enabled := tEnabled;
		end; }
end;

procedure WriteToRegistry;
var
	Reg: TRegistry;
begin
	Reg := TRegistry.Create(KEY_WRITE);
	With Reg do
		try
			RootKey := HKEY_CURRENT_USER;
			// Or HKEY_LOCAL_MACHINE, depending on the requirements
			if OpenKey('Software\' + ExtractFileName(ChangeFileExt(ParamStr(0), '')) +
				'\Settings', True) then
				With Form1 do
				begin
					WriteString('Icon_Directory', ed_IconDir.Text);
					WriteInteger('RG_Commision', rg_CC_Commission.ItemIndex);
					WriteFloat('ED_CC_Amt', ed_CC_Amt.Value);
					WriteFloat('ED_CC_Perc', ed_CC_Perc.Value);
					IF StrToFloat(lb_OfficEuChf_XRate.Caption) > 0 Then
						WriteFloat('LstXRate', StrToFloat(lb_OfficEuChf_XRate.Caption));
					// IF lstXRateDT <> 0 then
					WriteDateTime('LstXRate_DateTime', lstxRateDT);
					WriteTime('tmOpenMon', tm_openMon.Time);
					WriteTime('tmOpenTue', tm_openTue.Time);
					WriteTime('tmOpenWed', tm_openWed.Time);
					WriteTime('tmOpenThu', tm_openThu.Time);
					WriteTime('tmOpenFri', tm_openFri.Time);
					WriteTime('tmOpenSat', tm_openSat.Time);
					WriteTime('tmOpenSun', tm_openSun.Time);
					WriteTime('tmOpenSQL', tm_openSQL.Time);

					WriteTime('tmCloseMon', tm_closeMon.Time);
					WriteTime('tmCloseTue', tm_closeTue.Time);
					WriteTime('tmCloseWed', tm_closeWed.Time);
					WriteTime('tmCloseThu', tm_closeThu.Time);
					WriteTime('tmCloseFri', tm_closeFri.Time);
					WriteTime('tmCloseSat', tm_closeSat.Time);
					WriteTime('tmCloseSun', tm_closeSun.Time);
					WriteTime('tmCloseSQL', tm_closeSQL.Time);
					CloseKey;
				end;
		finally
			Free;
		end;
end;

procedure ReadFromRegistry;
var
	Reg: TRegistry;
begin
	Reg := TRegistry.Create(KEY_READ);
	With Reg do
		try
			RootKey := HKEY_CURRENT_USER;
			// Or HKEY_LOCAL_MACHINE, depending on the requirements
			With Form1 do
				if OpenKey('Software\' + ExtractFileName(ChangeFileExt(ParamStr(0), ''))
					+ '\Settings', False) then
				begin
					if ValueExists('Icon_Directory') then
						ed_IconDir.Text := ReadString('Icon_Directory');
					If ed_IconDir.Text = '' Then
						ed_IconDir.Text := ExtractFilePath(ParamStr(0));
					if ValueExists('RG_Commision') then
						rg_CC_Commission.ItemIndex := ReadInteger('RG_Commision');
					if ValueExists('ED_CC_Amt') then
						ed_CC_Amt.Value := ReadFloat('ED_CC_Amt');
					if ValueExists('ED_CC_Perc') then
						ed_CC_Perc.Value := ReadFloat('ED_CC_Perc');
					if ValueExists('LstXRate') then
						xRate := ReadFloat('LstXRate')
					else
						xRate := 1;
					IF ValueExists('LstXRate_DateTime') Then
						lstxRateDT := ReadDateTime('LstXRate_DateTime');
					tm_openMon.Time := ReadTime('tmOpenMon');
					tm_openTue.Time := ReadTime('tmOpenTue');
					tm_openWed.Time := ReadTime('tmOpenWed');
					tm_openThu.Time := ReadTime('tmOpenThu');
					tm_openFri.Time := ReadTime('tmOpenFri');
					tm_openSat.Time := ReadTime('tmOpenSat');
					tm_openSun.Time := ReadTime('tmOpenSun');
					tm_openSQL.Time := ReadTime('tmOpenSQL');

					tm_closeMon.Time := ReadTime('tmCloseMon');
					tm_closeTue.Time := ReadTime('tmCloseTue');
					tm_closeWed.Time := ReadTime('tmCloseWed');
					tm_closeThu.Time := ReadTime('tmCloseThu');
					tm_closeFri.Time := ReadTime('tmCloseFri');
					tm_closeSat.Time := ReadTime('tmCloseSat');
					tm_closeSun.Time := ReadTime('tmCloseSun');
					tm_closeSQL.Time := ReadTime('tmCloseSQL');
					CloseKey;
				end;
		finally
			Free;
		end;
end;

procedure RefreshCashierTables(empty0000: Boolean);
begin
	With DM do
	begin
		if empty0000 then
			Empty_0000
		else
			tb_0000.Refresh;
		qy_1000_Cashier.Refresh;
		qy_1000_Cashier.Last;
		qy_pLater.Refresh;
	end;
	With Form1 do
	begin
		dbgd_0000.Refresh;
		dbgd_pLater.Refresh;
	end;
end;

function GetApplicationName: string;
begin
	Result := ExtractFileName(ChangeFileExt(ParamStr(0), ''));
end;

function GetDocumentsFolder: string;
var
	Path: array [0 .. MAX_PATH] of Char;
begin
	SHGetFolderPath(0, CSIDL_PERSONAL, 0, SHGFP_TYPE_CURRENT, @Path[0]);
	Result := StrPas(Path);
end;

Procedure GetClubOpeningDT(FromDT, ToDT: TDateTime);
begin
	With Form1.thisStartEndDT do
	begin
		clubStartDT := FromDT;
		clubStartDT := RecodeTime(clubStartDT, 12, 0, 0, 0);
		// Club opening hour set to noon
		clubEndDT := INCDay(ToDT, 1);
		clubEndDT := RecodeTime(clubEndDT, 11, 59, 59, 999);
		// Club closing hour set to 11:59:59:999
	end;
end;

Procedure GetClubOpeningDTNow;
begin
	With Form1.thisStartEndDT do
	begin
		IF (TimeOf(Now) >= StrToTime('12:00:00')) and
			(TimeOf(Now) <= StrToTime('23:59:59.999')) Then
		begin
			clubStartDtToday := RecodeTime(Today, 12, 0, 0, 0);
			clubEndDtToday := RecodeTime(Tomorrow, 11, 59, 59, 999);
		end;
		IF (TimeOf(Now) >= StrToTime('00:00:00')) and
			(TimeOf(Now) <= StrToTime('11:59:59.999')) Then
		begin
			clubStartDtToday := Yesterday;
			clubStartDtToday := RecodeTime(Yesterday, 12, 0, 0, 0);
			clubEndDtToday := RecodeTime(Today, 11, 59, 59, 999);
		end;
	end;
end;

Procedure SetSinglePecuniaBtState(button, state: Integer);
begin
	// state values: 0 = make choice (const: makeChoice, chosen, disabled)
	// 1 = chosen
	// 2 = disabled
	If button = 0 Then
		With Form1.bt_CHF do
		begin
			CASE state of
				0:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CHF_48_ena.png');
					end;
				1:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CHF_48.png');
					end;
				2:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CHF_48_dis.png');
					end;
			END;
		end;

	If button = 1 Then
		With Form1.bt_CC do
		begin
			CASE state of
				0:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\EURO_48_ena.png');
					end;
				1:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\EURO_48.png');
					end;
				2:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\EURO_48_dis.png');
					end;
			END;
		End;

	If button = 2 Then
		With Form1.bt_CC do
		begin
			CASE state of
				0:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CC_48_ena.png');
					end;
				1:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CC_48.png');
					end;
				2:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\CC_48_dis.png');
					end;
			END;
		end;

	If button = 3 Then
		With Form1.bt_pLater do
		begin
			CASE state of
				0:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\HG_48_ena.png');
					end;
				1:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\HG_48.png');
					end;
				2:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\HG_48_dis.png');
					end;
			END;
		end;

	If button = 4 Then
		With Form1.bt_Off do
		begin
			CASE state of
				0:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\Gift_48_ena.png');
					end;
				1:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\Gift_48.png');
					end;
				2:
					begin
						Picture.Graphic.LoadFromFile
							('D:\Program Files (x86)\PGC_624_Athens\Icons\Gift_48_dis.png');
					end;
			END;
		end;
end;

Function CheckPayment(DateTime: TDateTime;
	FeeID, SubFeeID, ClientID: Integer): Integer;
begin
	With DM.qy_Temporary do
	begin
		If Active then
			Close;
		SQL.Clear;
		SQL.Add('SELECT SubFeeID FROM c_1200 WHERE ClientID = ' +
			IntToStr(Form1.thisClient.ClientID) + ' AND FeeID = ' + IntToStr(FeeID) +
			' AND SubFeeID = ' + IntToStr(SubFeeID) + ' AND Data >= CAST(' +
			QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', RecodeTime(DateTime, 12,
			0, 0, 0))) + ' AS TimeStamp)');
		Active := True;
		IF RecordCount = 1 Then
			Result := FieldValues[('SubFeeID')]
		else
			Result := -1;
	end;
end;

Function CheckIfSaleClosed: Boolean;
begin
	With DM.qy_Temporary do
	begin
		If Active then
			Close;
		SQL.Clear;
		SQL.Add('SELECT (SUM(Sale) AS - SUM(Payment)) AS bal FROM c_0000');
		Active := True;
		IF FieldValues[('bal')] <> 0 Then
			Result := False
		else
			Result := True;
	end;
end;

Function WriteSaleTo0000(rDate: TDateTime; Description, txID: String;
	FeeID, SubFeeID, dAccount, aAccount: Integer; Sale: Double; ch, eu, cc, pd, off: Boolean): Boolean;
begin

	With DM, tb_0000 do
		Try
			begin
				DisableControls;
				Insert;
				FieldByName('Data').AsDateTime := rDate;
				FieldByName('Description').AsString := Description;
				FieldByName('Sale').AsFloat := Sale;
				FieldByName('FeeID').AsInteger := FeeID;
				FieldByName('SubFeeID').AsInteger := SubFeeID;
				FieldByName('D_Account').AsInteger := dAccount;
				// sale to clients account
				FieldByName('A_Account').AsInteger := aAccount;
				FieldByName('ClientID').AsInteger := Form1.thisClient.ClientID;
				FieldByName('CardID').AsInteger := Form1.thisClient.CardID;
				FieldByName('TxID').AsString := txID;
				FieldByName('CHF').AsBoolean := ch;
				FieldByName('EU').AsBoolean := eu;
				FieldByName('CC').AsBoolean := cc;
				FieldByName('PD').AsBoolean := pd;
				FieldByName('OFF').AsBoolean := off;
				Post;
				First;
				Result := True;
				EnableControls;
			end;
		Except
			Result := False;
		End;
end;

Function WriteExpenseTo0000(rDate: TDateTime; Description, txID: String;
	FeeID, SubFeeID, dAccount, aAccount: Integer; Amt: Double): Boolean;
begin
	With DM, tb_0000 do
		Try
			begin
				Insert;
				FieldByName('Data').AsDateTime := rDate;
				FieldByName('Description').AsString := Description;
				FieldByName('Sale').AsFloat := Amt;
				FieldByName('FeeID').AsInteger := FeeID;
				FieldByName('SubFeeID').AsInteger := SubFeeID;
				FieldByName('D_Account').AsInteger := dAccount;
				FieldByName('A_Account').AsInteger := aAccount;
				FieldByName('ClientID').AsInteger := Form1.thisClient.ClientID;
				FieldByName('CardID').AsInteger := Form1.thisClient.CardID;
				FieldByName('TxID').AsString := txID;
				Post;
				Result := True
			end;
		Except
			Result := False;
		End;
end;

Function WritePaymentTo0000(rDate: TDateTime; Description, PayMethod: String; Payment: Double): Boolean;
Var
	txID, queryS: String;
	account: Integer;
begin
	IF PayMethod = 'OFF' Then
		account := 7000 // Discount or Offered
	else
		account := 1000;

	txID := DM.tb_0000.FieldByName('TxID').AsString;

	queryS := 'INSERT INTO c_0000 (Data, Description, Payment,D_Account,A_Account, ClientID, CardID, TxID,PayMethod) '
		+ 'VALUES(CURRENT_TIMESTAMP, ' +
		QuotedStr(Description) + ', ' +
		FloatTostr(Payment) + ', ' +
		IntToStr(account) + ', ' +
		' 1200 ,' +
		IntToStr(Form1.thisClient.ClientID) + ', ' +
		IntToStr(Form1.thisClient.CardID) + ', ' +
		QuotedStr(txID) + ', ' +
		QuotedStr(PayMethod) + ')';

	IF DM.WriteAllData(queryS) = False Then
		ShowMessage('Errore registrazione pagamento!');
end;

Function VerifyValidityCard(CardID: Integer): Boolean;
var
	s: String;
begin
	With DM.qy_Fees do
	begin
		IF (CardID >= FieldByName('CardsFrom').AsInteger) AND
			(CardID <= FieldByName('CardsTo').AsInteger) then
			Result := True
		else
			Result := False;
	end;
	With DM.qy_Temporary do
	begin
		IF Active Then
			Close;
		SQL.Clear;
		s := 'SELECT Description FROM CardTypes ' + 'WHERE ' + IntToStr(CardID) +
			' >= CardFromID ' + 'AND ' + IntToStr(CardID) + ' <= CardToID ';
		SQL.Add('SELECT Description FROM CardTypes ' + 'WHERE ' + IntToStr(CardID) +
			' >= CardFromID ' + 'AND ' + IntToStr(CardID) + ' <= CardToID ');
		Active := True;
		If RecordCount > 0 Then
			Form1.thisClient.clType := FieldByName('Description').AsString;
		Active := False;
	end;
end;

Procedure Empty_0000;
begin
	With DM.qy_Tmp do
	begin
		IF Active then
			Active := False;
		SQL.Clear;
		SQL.Add('EMPTY TABLE c_0000 IGNORE CONSTRAINTS');
		ExecSQL;
		DM.tb_0000.Refresh;
	end;
	With Form1 do
	begin
		dbgd_0000.Font.Color := clBlack;
		dbgd_0000.Repaint;
		dbgd_0000.SumList.RecalcAll;
		dbgd_Fees.Enabled := True;
	end;
end;

// Generate unique transaction ID for accounting purposes
// Each transaction has its own id (same dare and avere share same id)
// ======================================================
FUNCTION GenerateTxID: STRING;
VAR
	TrID: Variant;
BEGIN
	TrID := Now;
	Result := IntToHex(TrID * 10000000000, 13);
END;

function IsValidEmail(const Email: string): Boolean;
var
	Regex: TRegEx;
begin
	Regex := TRegEx.Create('^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
		[roIgnoreCase, roMultiline]);
	Result := Regex.IsMatch(Email);
end;

Function isValidAge(bDate: TDate): Boolean;
Var
	DateNow: TDate;
	FullYears: Integer;
begin
	// Example dates
	DateNow := EncodeDate(YearOf(Now), MonthOf(Now), dAYoF(Now));
	bDate := EncodeDate(YearOf(bDate), MonthOf(bDate), dAYoF(bDate));
	FullYears := YearsBetween(DateNow, bDate);
	If FullYears >= 18 then
		Result := True
	else
		Result := False;
end;

Function GetClientIDFromCardID(CardID: Integer): Integer;
begin
	With DM.qy_Temporary do
	begin
		If Active then
			Active := False;
		SQL.Clear;
		SQL.Add('SELECT ClientID FROM Cards WHERE ID = ' + IntToStr(CardID));
		Active := True;
		If Not FieldByName('ClientID').IsNull then
			Result := FieldByName('ClientID').AsInteger
		else
			Result := -1;
	end;
end;

function GetClientData(ID: Integer): Boolean;
begin
	WITH DM.qy_AllClients do
	begin
		If Active then
			Active := False;
		SQL.Clear;
		SQL.Add('SELECT ca.ID as CardID, * FROM Clients ' + 'LEFT JOIN Cards ca ON '
			+ 'Clients.id = ca.clientid ' + 'WHERE ID = ' + IntToStr(ID));
		Active := True;
		If RecordCount = 1 then
		begin
			with Form1.thisClient do
			begin
				Enabled := FieldByName('Enabled').AsBoolean;
				ClientID := FieldByName('ID').AsInteger;
				CardID := FieldByName('CardID').AsInteger;
				fName := Trim(FieldByName('FirstName').AsString);
				Lname := Trim(FieldByName('LastName').AsString);
				Alias := Trim(FieldByName('Alias').AsString);
				InHouse := FieldByName('InHouse').AsBoolean;
				Registered := FieldByName('Registered').AsBoolean;
				Taxed := FieldByName('Taxed').AsBoolean;
				Result := True;
			end;
		end
		else
			Result := False;
		Active := False;
	end;

	WITH DM.qy_Temporary do
	begin
		If Active then
			Active := False;
		SQL.Clear;
		SQL.Add('SELECT * FROM c_1200 WHERE ClientID = ' + IntToStr(ID) +
			' AND FeeID = 3');
		Active := True;
		If RecordCount = 1 then
			Form1.thisClient.EntranceFee_SubID := FieldValues[('SubFeeID')];
		Active := False;
	end;

end;

// This function returns start and end datetimes base on opening hours of the establishment
// One working day for example goes from 14:00 on the start day till the next days closing time 03:00
// =================================================================================================
function DateTimeToSQLString(isStartDT: Boolean; DateTime: TDateTime): string;
Var
	aDT: TDateTime;
	aDay, aMonth, aYear, aHour, aMinute, aSecond, aThous: Integer;
begin
	aDay := dAYoF(DateTime);
	aMonth := MonthOf(DateTime);
	aYear := YearOf(DateTime);
	aThous := 999;
	aDT := DateTime;
	If isStartDT then
	begin
		With Form1.thisStartEndDT do
		begin
			aHour := HourOf(clubStartTiMe);
			aMinute := MinuteOf(clubStartTiMe);
			aSecond := SecondOf(clubStartTiMe);
		end;
	end
	else
	begin
		With Form1.thisStartEndDT do
		begin
			aHour := HourOf(clubEndTm);
			aMinute := MinuteOf(clubEndTm);
			aSecond := SecondOf(clubEndTm);
		end;
		IF DaysInAMonth(YearOf(aDT), MonthOf(aDT)) = DaysInMonth(DateTime) Then
		begin
			IF aMonth = 12 then
			begin // It's the end of a year
				Inc(aYear, 1);
				aMonth := 1;
				// Set month to first month in new year
				aDay := 1;
				// Set day to first day in first month
			end
			else
			begin // It's the end of a month
				Inc(aMonth, 1); // set month to next month
				aDay := 1; // set day to first day in new month;
			end;
		end
		else
		begin
			Inc(aDay, 1); // Set day to next day in same month
		end;
		aDT := EncodeDateTime(aYear, aMonth, aDay, aHour, aMinute, aSecond, aThous);
	end;

	Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', aDT);
end;

procedure LoadImageFromBlob(field: TBlobField; ImageControl: TImage);
var
	Stream: TMemoryStream;
	// Picture: TPicture;
	JPEGImage: TJPEGImage;
	PNGImage: TPngImage;
	Bitmap: TBitmap;
	ImageType: String;
begin
	// ImageType := GetImageTypeFromBlob(DM.tb_Fees.FieldByName('TicketHeader')
	ImageType := GetImageTypeFromBlob(field AS TBlobField);
	IF (ImageType = 'Unknown') OR (field.IsNull) then
	begin
		if FileExists('D:\Program Files (x86)\PGC_624\Icons\NoImage.bmp') then
			ImageControl.Picture.LoadFromFile
				('D:\Program Files (x86)\PGC_624\Icons\NoImage.bmp')
		else
			ShowMessage('File not found: ' +
				'D:\Program Files (x86)\PGC_624\Icons\NoImage.bmp');
		Exit;
	end;
	Stream := TMemoryStream.Create;
	try
		field.SaveToStream(Stream);
		Stream.Position := 0;
		// Try to load the image as JPEG
		IF ImageType = 'JPEG' then
		begin
			JPEGImage := TJPEGImage.Create;
			try
				try
					JPEGImage.LoadFromStream(Stream);
					ImageControl.Picture.Graphic := JPEGImage;
					Exit; // Exit if successfully loaded as JPEG
				except
					on E: EInvalidGraphic do
						JPEGImage.Free;
				end;
			except
				JPEGImage.Free;
			end;
		end;

		// Reset the stream position for the next attempt
		Stream.Position := 0;
		// Try to load the image as PNG
		IF ImageType = 'PNG' then
		begin
			PNGImage := TPngImage.Create;
			try
				try
					PNGImage.LoadFromStream(Stream);
					ImageControl.Picture.Graphic := PNGImage;
					Exit; // Exit if successfully loaded as PNG
				except
					on E: EInvalidGraphic do
						PNGImage.Free;
				end;
			except
				PNGImage.Free;
			end;
		end;

		// Reset the stream position for the next attempt
		Stream.Position := 0;

		// Try to load the image as BMP
		IF ImageType = 'BMP' then
		begin
			Bitmap := TBitmap.Create;
			try
				try
					Bitmap.LoadFromStream(Stream);
					ImageControl.Picture.Graphic := Bitmap;
					Exit; // Exit if successfully loaded as BMP
				except
					on E: EInvalidGraphic do
						Bitmap.Free;
				end;
			except
				Bitmap.Free;
			end;
		end;

		// If all attempts fail, raise an error
		raise Exception.Create('Unsupported image format or invalid image data');
	finally
		Stream.Free;
	end;
end;

function GetImageTypeFromBlob(field: TBlobField): string;
const
	JPEG_HEADER: array [0 .. 2] of Byte = ($FF, $D8, $FF);
	PNG_HEADER: array [0 .. 7] of Byte = ($89, $50, $4E, $47, $0D, $0A, $1A, $0A);
	GIF_HEADER: array [0 .. 2] of Byte = ($47, $49, $46);
	BMP_HEADER: array [0 .. 1] of Byte = ($42, $4D);
var
	BlobStream: TStream;
	Header: array [0 .. 7] of Byte;
begin
	Result := 'Unknown';

	// Load the BLOB data into a stream
	BlobStream := field.DataSet.CreateBlobStream(field, bmRead);
	try
		// Read the first few bytes to determine the image format
		BlobStream.Read(Header, SizeOf(Header));

		// Check for BMP
		if CompareMem(@Header, @BMP_HEADER, SizeOf(BMP_HEADER)) then
		begin
			Result := 'BMP';
			Exit;
		end;

		// Check for JPEG
		if CompareMem(@Header, @JPEG_HEADER, SizeOf(JPEG_HEADER)) then
		begin
			Result := 'JPEG';
			Exit;
		end;

		// Check for PNG
		if CompareMem(@Header, @PNG_HEADER, SizeOf(PNG_HEADER)) then
		begin
			Result := 'PNG';
			Exit;
		end;

		// Check for GIF
		if CompareMem(@Header, @GIF_HEADER, SizeOf(GIF_HEADER)) then
		begin
			Result := 'GIF';
			Exit;
		end;
	finally
		BlobStream.Free;
	end;
end;

procedure SaveImageToBlobField(const FileName: string; field: TBlobField);
var
	Bitmap: TBitmap;
	MemoryStream: TMemoryStream;
begin
	Bitmap := TBitmap.Create;
	MemoryStream := TMemoryStream.Create;
	try
		// Load the image from a file
		Bitmap.LoadFromFile(FileName);

		// Save the image to a memory stream
		Bitmap.SaveToStream(MemoryStream);

		// Reset the stream position to the beginning
		MemoryStream.Position := 0;

		// Save the stream data to the BLOB field
		field.LoadFromStream(MemoryStream);
	finally
		Bitmap.Free;
		MemoryStream.Free;
	end;
end;

procedure LoadImage(Sender: TObject; field: TBlobField; table: TEDBTable;
	ImageControl: TImage; dbImageControl: TDBImage);
var
	Bitmap: TBitmap;
	MemoryStream: TMemoryStream;
	BlobField: TBlobField;
	Picture: TPicture;
begin
	// Set up the open dialog filter to select image files
	With Form1 do
	begin
		OpenDialog1.Filter :=
			'Bitmap Files (*.bmp)|*.bmp|JPEG Files (*.jpg;*.jpeg)|*.jpg;*.jpeg|PNG Files (*.png)|*.png|All Files (*.*)|*.*';
		OpenDialog1.FilterIndex := 4; // Default to "All Files"

		if OpenDialog1.Execute then
		begin
			Bitmap := TBitmap.Create;
			MemoryStream := TMemoryStream.Create;
			try
				Picture := TPicture.Create;
				try
					Picture.LoadFromFile(OpenDialog1.FileName);
					Bitmap.Assign(Picture.Graphic);
				finally
					Picture.Free;
				end;

				// Display the image in the TImage component
				IF NOT(ImageControl = nil) then
					ImageControl.Picture.Graphic := Bitmap;

				IF NOT(dbImageControl = nil) Then
					dbImageControl.Picture.Graphic := Bitmap;

				// Save the image to a memory stream
				Bitmap.SaveToStream(MemoryStream);

				// Reset the stream position to the beginning
				MemoryStream.Position := 0;

				// Assuming the dataset is in edit mode and the BLOB field is named 'ImageBlob'
				BlobField := field as TBlobField;

				try
					table.Edit;
					// Save the stream data to the BLOB field
					// Cast the field to TBlobField
					BlobField.LoadFromStream(MemoryStream);
					table.Post;
					// Save changes to the database
					bt_AddClImage.Visible := DM.tb_clients.FieldByName('Image').IsNull;
				except
					table.Cancel;
					// Cancel changes if an error occurs
					raise; // Re-raise the exception
				end;
			finally
				Bitmap.Free;
				MemoryStream.Free;
			end;
		end;
	end;
end;

procedure FillAttendanceCalendar(FeeID, ClientID: Integer);
begin
	With Form1.cal_Attendance do
	begin
		DisjunctDates.ClearAndResetID;
		DateAppearance.SelectedDateFill.Color := clWhite;
		With DM.qy_Attendance do
		begin
			Active := False;
			SQL.Clear;
			SQL.Add('SELECT Data, SubFeeID FROM c_1200 ' + 'WHERE feeid = ' +
				IntToStr(FeeID) + ' AND ClientID = ' + IntToStr(ClientID));
			Active := True;
			IF RecordCount > 0 Then
			begin
				First;
				While Not EoF do
				begin
					With Form1 do
					begin
						attendanceDate := DateOf(FieldByName('Data').AsDateTime);
						DisjunctDates.Add.DateTime := attendanceDate;
					end;
					Next;
				end;
			end;
			MaxDate := attendanceDate;
			DateAppearance.SelectedDateFill.Color := clCorale;
		end;
	end;
end;

// Filter and/or order Client list
// -------------------------------
Procedure FilterAndSortClients(ColIndex, RadioGroupIndex: Integer;
	filterStr: String);
var
	aStr, orderby, andWhere: String;
begin
	With Form1.qygd_Clients do
	begin
		Columns[0].Title.Font.Color := $000000;
		Columns[1].Title.Font.Color := $000000;
		Columns[2].Title.Font.Color := $000000;
		Columns[3].Title.Font.Color := $000000;

		Columns[0].Title.Font.Style := [];
		Columns[1].Title.Font.Style := [];
		Columns[2].Title.Font.Style := [];
		Columns[3].Title.Font.Style := [];

		IF sortOrder = ' ASC' Then
			sortOrder := ' DESC'
		else
			sortOrder := ' ASC';

		Columns[ColIndex].Title.Font.Color := $00507FFF;
		Columns[ColIndex].Title.Font.Style := [fsBold];

		orderby := ' ORDER BY ' + Columns[ColIndex].fieldName;

		Case RadioGroupIndex of
			0: // Presente
				begin
					aStr := 'Select  ID,  FirstName, LastName, Alias  FROM Clients ' +
						'WHERE Registered = True ';
					If filterStr <> '' then
						andWhere := ' AND ' + Columns[ColIndex].fieldName + ' = ' +
							QuotedStr(filterStr)
					else
						andWhere := '';
				end;
			1: // Back one year
				begin
					aStr := 'SELECT DISTINCT(ID),  FirstName, LastName, Alias  FROM Clients CL '
						+ 'Left Join c_1200 AS CA ON CA.ClientID = CL.ID ' +
						'WHERE (CA.Data BETWEEN (Current_Date + INTERVAL ' +
						QuotedStr('-12') + ' Month) AND CURRENT_DATE) AND CA.FeeID = 3 ';
					If filterStr <> '' then
						andWhere := ' AND ' + Columns[ColIndex].fieldName + ' = ' +
							QuotedStr(filterStr)
					else
						andWhere := '';
				end;
			2: // All
				begin
					aStr := 'Select  ID,  FirstName, LastName, Alias  FROM Clients ';
					If filterStr <> '' then
						andWhere := ' WHERE ' + Columns[ColIndex].fieldName + ' = ' +
							QuotedStr(filterStr)
					else
						andWhere := '';
				end;
		End;
	end;
	With DM.qy_Clients do
	begin
		Active := False;
		SQL.Clear;
		SQL.Add(aStr + andWhere + orderby + sortOrder);
		Active := True;
	end;
end;

procedure CashRegistryValues(write: Boolean);
VAR
	Reg: TRegistry;
begin
	Reg := TRegistry.Create;
	TRY
		Reg.RootKey := HKEY_CURRENT_USER; // Set the Root Key
		// Open the key, and create it if it doesn't exist
		IF Reg.OpenKey('\SOFTWARE\PGC_624\Cash', True) THEN
			WITH Reg, Form1 DO
			BEGIN
				If write then
				begin
					WriteString('CHF', lb_fc_CH.Text);
					WriteString('EU', lb_fc_EU.Text);
					WriteString('Operator', localConfigPath);
					WriteString('LastDateChecked', DateTimeToStr(Now));
				end
				else
				begin
					IF Reg.ValueExists('CHF') THEN
						lb_fc_CH.Text := ReadString('CHF');
					IF Reg.ValueExists('EU') THEN
						lb_fc_EU.Text := ReadString('EU');
					IF Reg.ValueExists('Operator') THEN
						localConfigPath := ReadString('Operator');
					IF Reg.ValueExists('LastDateChecked') THEN
						localConfigPath := ReadString('LastDateChecked');
				end;
			END;
	FINALLY
		Reg.Free;
	END;
end;

Procedure RefreshClientsQy;
begin
	With DM do
		IF qy_Clients.Active then
		begin
			qy_Clients.Refresh;
			Form1.qygd_Clients.Refresh;
		end;
end;

end.
