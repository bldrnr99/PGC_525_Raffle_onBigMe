unit CalcPecunia;

interface

uses Winapi.Windows,
	Winapi.Messages,
	Winsock,
	System.SysUtils,
	System.DateUtils,
	System.Math,
	System.UITypes,
	System.Variants,
	System.RegularExpressions,
	StrUtils, System.AnsiStrings, System.Classes,
	Vcl.Graphics;

Function Calculator(aKey: Integer): Double;
// Procedure SetPecuniaARIDX(aValue: Integer);
Procedure AllPecuniaBtsUp;
Procedure EnableDisablePecuniaBt(button: Integer; nState: Boolean);
Procedure SetEnabledButtonsImages;
Procedure SwitchPecuniaBtPic(picID: Integer);
Procedure ShowPecuniaBts(button: Integer; showBt: Boolean);
Procedure SetPecuniaBts(btAR: Array of Integer);

// TBooleanArray = array of Boolean;

var
	tmpStr, dollars, cents, activePecunia: String;
	pecuniaIdx: Integer;
	hasCents: Boolean;

implementation

uses Main, DM1, Routines;

Procedure SetPecuniaBts(btAR: Array of Integer);
Var
	i: Integer;
	t: Boolean;
begin
	for i := 0 to 5 - 1 do

	begin
		t := ((btAR[i] div 10) mod 10 = 0);
		t := (btAR[i] mod 10 = 0);
	end;

	With Form1 do
	begin
		bt_CHF.Visible := ((btAR[0] div 10) mod 10 = 1); // 1(1)1 true = 1, false = 0
		bt_CHF.Enabled := (btAR[0] mod 10 = 1); // 11(1) True = 1, False = 0
		bt_EU.Visible := ((btAR[1] div 10) mod 10 = 1);
		bt_EU.Enabled := (btAR[1] mod 10 = 1);
		bt_CC.Visible := ((btAR[2] div 10) mod 10 = 1);
		bt_CC.Enabled := (btAR[2] mod 10 = 1);
		bt_pLater.Visible := ((btAR[3] div 10) mod 10 = 1);
		bt_pLater.Enabled := (btAR[3] mod 10 = 1);
		bt_OFF.Visible := ((btAR[4] div 10) mod 10 = 1);
		bt_OFF.Enabled := (btAR[4] mod 10 = 1);
		bt_MixPec.Visible := ((btAR[5] div 10) mod 10 = 1);
		bt_MixPec.Enabled := (btAR[5] mod 10 = 1);
	end;
end;

Procedure ShowPecuniaBts(button: Integer; showBt: Boolean);
begin
	With Form1 do
	begin
		Case button Of
			0:
				bt_CHF.Visible := showBt;
			1:
				bt_EU.Visible := showBt;
			2:
				bt_CC.Visible := showBt;
			3:
				bt_pLater.Visible := showBt;
			4:
				bt_OFF.Visible := showBt;
			5:
				bt_MixPec.Visible := showBt;
			9:
				begin
					bt_CHF.Visible := showBt;
					bt_EU.Visible := showBt;
					bt_CC.Visible := showBt;
					bt_pLater.Visible := showBt;
					bt_OFF.Visible := showBt;
					bt_MixPec.Visible := showBt;
				end;
		End;
	end;
end;

Procedure EnableDisablePecuniaBt(button: Integer; nState: Boolean);
Begin
	With Form1 do
	begin
		Case button Of
			0:
				bt_CHF.Enabled := nState;
			1:
				bt_EU.Enabled := nState;
			2:
				bt_CC.Enabled := nState;
			3:
				bt_pLater.Enabled := nState;
			4:
				bt_OFF.Enabled := nState;
			5:
				bt_MixPec.Enabled := nState;
			9:
				Begin
					bt_CHF.Enabled := nState;
					bt_EU.Enabled := nState;
					bt_CC.Enabled := nState;
					bt_pLater.Enabled := nState;
					bt_OFF.Enabled := nState;
					bt_MixPec.Enabled := nState;
				End;
		End;
	End;
end;

Procedure SetEnabledButtonsImages;
begin
	With Form1 do
	begin
		if bt_CHF.Enabled then
			bt_CHF.Picture.Graphic.LoadFromFile
				(dirStr + 'CHF_48_ena.png')
		else
			bt_CHF.Picture.Graphic.LoadFromFile
				(dirStr + 'CHF_48_dis.png');
		if bt_EU.Enabled then
			bt_EU.Picture.Graphic.LoadFromFile
				(dirStr + 'EURO_48_ena.png')
		else
			bt_EU.Picture.Graphic.LoadFromFile
				(dirStr + 'EURO_48_dis.png');
		if bt_CC.Enabled then
			bt_CC.Picture.Graphic.LoadFromFile
				(dirStr + 'CC_48_ena.png')
		else
			bt_CC.Picture.Graphic.LoadFromFile
				(dirStr + 'CC_48_dis.png');
		if bt_pLater.Enabled then
			bt_pLater.Picture.Graphic.LoadFromFile
				(dirStr + 'HG_48_ena.png')
		else
			bt_pLater.Picture.Graphic.LoadFromFile
				(dirStr + 'HG_48_dis.png');
		if bt_OFF.Enabled then
			bt_OFF.Picture.Graphic.LoadFromFile
				(dirStr + 'Gift_48_ena.png')
		else
			bt_OFF.Picture.Graphic.LoadFromFile
				(dirStr + 'Gift_48_dis.png');

		if bt_MixPec.Enabled then
			bt_MixPec.Picture.Graphic.LoadFromFile
				(dirStr + 'MixPecunia_48_ena.png')
		else
			bt_MixPec.Picture.Graphic.LoadFromFile
				(dirStr + 'MixPecunia_48_dis.png');
	end;
end;

Procedure AllPecuniaBtsUp;
begin
	With Form1 do
	begin
		bt_CHF.Down := False;
		bt_EU.Down := False;
		bt_CC.Down := False;
		bt_pLater.Down := False;
		bt_OFF.Down := False;
		bt_MixPec.Down := False;
		SwitchPecuniaBtPic(2); // set to disabled pics
	end;
end;

Procedure SwitchPecuniaBtPic(picID: Integer);
begin
	With Form1 do
	Begin
		CASE picID OF
			0: // Buttons enabled, ready for pecunia choice
				begin
					bt_CHF.Picture.Graphic.LoadFromFile
						(dirStr + 'CHF_48_ena.png');
					bt_EU.Picture.Graphic.LoadFromFile
						(dirStr + 'EURO_48_ena.png');
					bt_CC.Picture.Graphic.LoadFromFile
						(dirStr + 'CC_48_ena.png');
					bt_pLater.Picture.Graphic.LoadFromFile
						(dirStr + 'HG_48_ena.png');
					bt_OFF.Picture.Graphic.LoadFromFile
						(dirStr + 'Gift_48_ena.png');
					bt_MixPec.Picture.Graphic.LoadFromFile
						(dirStr + 'MixPecunia_48_ena.png');
				end;
			1: // Buttons enabled, single button already chosen
				Begin
					if bt_CHF.Down Then
						bt_CHF.Picture.Graphic.LoadFromFile
							(dirStr + 'CHF_48.png');
					if bt_EU.Down Then
						bt_EU.Picture.Graphic.LoadFromFile
							(dirStr + 'EURO_48.png');
					if bt_CC.Down Then
						bt_CC.Picture.Graphic.LoadFromFile
							(dirStr + 'CC_48.png');
					if bt_pLater.Down Then
						bt_pLater.Picture.Graphic.LoadFromFile
							(dirStr + 'HG_48.png');
					if bt_OFF.Down Then
						bt_OFF.Picture.Graphic.LoadFromFile
							(dirStr + 'Gift_48.png');
					if bt_MixPec.Down Then
						bt_OFF.Picture.Graphic.LoadFromFile
							(dirStr + 'MixPecunia_48.png');
				End;
			2: // Buttons disabled
				Begin
					bt_CHF.Picture.Graphic.LoadFromFile
						(dirStr + 'CHF_48_dis.png');
					bt_EU.Picture.Graphic.LoadFromFile
						(dirStr + 'EURO_48_dis.png');
					bt_CC.Picture.Graphic.LoadFromFile
						(dirStr + 'CC_48_dis.png');
					bt_pLater.Picture.Graphic.LoadFromFile
						(dirStr + 'HG_48_dis.png');
					bt_OFF.Picture.Graphic.LoadFromFile
						(dirStr + 'Gift_48_dis.png');
					bt_MixPec.Picture.Graphic.LoadFromFile
						(dirStr + 'MixPecunia_48_dis.png');
				End;
		END;
	End;
end;

// Numeric keyboard
// ----------------
Function Calculator(aKey: Integer): Double;
begin
	begin
		Case aKey of
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
				tmpStr := tmpStr + IntTostr(aKey);
			10:
				if hasCents then
					Result := StrToFloat(dollars + '.' + cents)
				else
				begin
					hasCents := True;
					tmpStr := '';
				end;
			13:
				begin
					//
				end;
			14:
				begin
					tmpStr := '';
					dollars := '';
					cents := '';
					hasCents := False;
				end;
		End;
	end;
	If not hasCents Then
		dollars := tmpStr
	else
		cents := Copy(tmpStr, 1, 2);
	if (dollars <> '') OR (cents <> '') then
		Result := StrToFloat(dollars + '.' + cents)
	else
		Result := 0;
end;

end.
