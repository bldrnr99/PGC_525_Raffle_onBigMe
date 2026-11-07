unit Routine;

interface

USES
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
	DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
	// Define a record type to hold the two doubles
	TSumListResult = record
		dSum: Double;
		aSum: Double;
		bal: Double;
	end;

Function CheckSumList(dbgrid: TDBGridEh; colA, footerA, colB, FooterB: Integer): TSumListResult;

implementation

uses DM1, Main;

Function CheckSumList(dbgrid: TDBGridEh; colA, footerA, colB, FooterB: Integer): TSumListResult;
Var
	dS, avS: Double;
begin
	dS := 0;
	avS := 0;
	With dbgrid do
	begin
		IF colA <> null then
			IF Columns[colA].Footers[footerA].SumValue <> null then
				dS := Columns[colA].Footers[footerA].SumValue
			else
				dS := 0;
		If colB <> null Then
			IF Columns[colB].Footers[FooterB].SumValue <> null then
				avS := Columns[colB].Footers[FooterB].SumValue
			else
				avS := 0;

		Result.dSum := dS;
		Result.aSum := avS;
		Result.bal := dS - avS;
	end;
end;

end.
