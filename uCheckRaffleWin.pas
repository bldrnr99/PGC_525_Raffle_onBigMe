unit uCheckRaffleWin;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, edbcomps;

type
  TfrmCheckRaffleWin = class(TForm)
    lblTxID: TLabel;
    edTxID: TEdit;
    btnCheck: TButton;
    pnlResult: TPanel;
    lblResult: TLabel;
    lblDetail: TLabel;
    btnRedeemNow: TButton;
    EDBQuery1: TEDBQuery;
    procedure FormShow(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnRedeemNowClick(Sender: TObject);
    procedure edTxIDKeyPress(Sender: TObject; var Key: Char);
    procedure edTxIDChange(Sender: TObject);
  private
    FRedeemTxID: string; // code of the win currently shown as valid
    FRedeemValidDays: Integer; // -1 = no expiry
    function GetQry: TEDBQuery;
    property qryWin: TEDBQuery read GetQry; // forwards to Form2.qry_RaffleCheck
    procedure ShowResult(AColor, AFontColor: TColor; const ATitle, ADetail: string);
    procedure DoCheck;
  end;

implementation

{$R *.dfm}


uses
  DM1; // replace with the real unit name of Form2

function TfrmCheckRaffleWin.GetQry: TEDBQuery;
begin
  Result := Form2.qry_RaffleCheck;
end;

procedure TfrmCheckRaffleWin.FormShow(Sender: TObject);
begin
  edTxID.Clear;
  edTxID.SetFocus;
end;

procedure TfrmCheckRaffleWin.edTxIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // barcode readers normally end the code with Enter
  begin
    Key := #0; // no beep
    DoCheck;
  end;
end;

procedure TfrmCheckRaffleWin.edTxIDChange(Sender: TObject);
begin
  // any edit invalidates the last check, so a stale code can't be redeemed
  btnRedeemNow.Enabled := False;
  FRedeemTxID := '';
end;

procedure TfrmCheckRaffleWin.btnCheckClick(Sender: TObject);
begin
  DoCheck;
end;

procedure TfrmCheckRaffleWin.ShowResult(AColor, AFontColor: TColor;
  const ATitle, ADetail: string);
begin
  pnlResult.Color := AColor;
  lblResult.Font.Color := AFontColor;
  lblDetail.Font.Color := AFontColor;
  lblResult.Caption := ATitle;
  lblDetail.Caption := ADetail;
end;

procedure TfrmCheckRaffleWin.DoCheck;
var
  Code, Detail: string;
  RedeemedF, ValidF: TField;
  IssueDate: TDateTime;
  DaysElapsed: Integer;
begin
  Code := Trim(edTxID.Text);
  if Code = '' then
    Exit;

  btnRedeemNow.Enabled := False;
  FRedeemTxID := '';
  FRedeemValidDays := -1;

  qryWin.Close;
  qryWin.SQL.Text :=
    'SELECT "Data", "Value", ValidHowManyDays, RedeemedDate ' +
    'FROM RaffleWins ' +
    'WHERE TxID = :TxID';
  qryWin.ParamByName('TxID').AsString := Code;
  qryWin.Open;
  try
    if qryWin.IsEmpty then
      ShowResult($0040A0FF, clBlack, // orange
        'Vincita non trovata', 'Nessuna vincita con il codice ' + Code)
    else
    begin
      IssueDate := qryWin.FieldByName('Data').AsDateTime;
      Detail := 'Valore: ' + qryWin.FieldByName('Value').AsString + sLineBreak +
        'Emessa il: ' + FormatDateTime('dd/mm/yyyy hh:nn', IssueDate);
      RedeemedF := qryWin.FieldByName('RedeemedDate');
      ValidF := qryWin.FieldByName('ValidHowManyDays');

      if not RedeemedF.IsNull then
        ShowResult($003C3CD0, clWhite, // red
          'GIÀ RISCOSSA', Detail + sLineBreak + 'Riscossa il: ' +
          FormatDateTime('dd/mm/yyyy hh:nn', RedeemedF.AsDateTime))
      else
      begin
        DaysElapsed := Trunc(Date) - Trunc(IssueDate); // calendar days since issue

        if (not ValidF.IsNull) and (DaysElapsed > ValidF.AsInteger) then
          ShowResult($00808080, clWhite, // grey
            'VINCITA SCADUTA',
            Detail + sLineBreak +
            'Valida per ' + ValidF.AsString + ' giorni' + sLineBreak +
            'Trascorsi: ' + IntToStr(DaysElapsed) + ' giorni')
        else
        begin
          ShowResult($0050B000, clWhite, // green
            'Vincita VALIDA' + sLineBreak + '(non ancora riscossa)', Detail);
          FRedeemTxID := Code;
          if ValidF.IsNull then
            FRedeemValidDays := -1
          else
            FRedeemValidDays := ValidF.AsInteger;
          btnRedeemNow.Enabled := True;
        end;
      end;
    end;
  finally
    qryWin.Close;
  end;

  edTxID.SelectAll; // the next scan or entry replaces this one
  edTxID.SetFocus;
end;

procedure TfrmCheckRaffleWin.btnRedeemNowClick(Sender: TObject);
var
  Stamp, MinIssue: TDateTime;
begin
  if FRedeemTxID = '' then
    Exit;

  if MessageDlg('Confermi la riscossione di questa vincita?',
    mtConfirmation, [mbYes, mbNo], 0, mbNo) <> mrYes then // defaults to "No"
    Exit;

  Stamp := Now;

  // earliest issue date still redeemable today (calendar days, same rule as DoCheck)
  if FRedeemValidDays < 0 then
    MinIssue := EncodeDate(1900, 1, 1) // no expiry
  else
    MinIssue := Trunc(Date) - FRedeemValidDays;

  qryWin.Close;
  qryWin.SQL.Text :=
    'UPDATE RaffleWins SET RedeemedDate = :RDT ' +
    'WHERE TxID = :TxID ' +
    '  AND RedeemedDate IS NULL ' + // never overwrite an earlier redemption
    '  AND "Data" >= :MinIssue'; // not expired
  qryWin.ParamByName('RDT').AsDateTime := Stamp;
  qryWin.ParamByName('TxID').AsString := FRedeemTxID;
  qryWin.ParamByName('MinIssue').AsDateTime := MinIssue;
  qryWin.ExecSQL;

  if qryWin.RowsAffected = 0 then
    ShowMessage('Impossibile riscuotere: la vincita risulta già riscossa, scaduta o non esiste.')
  else
    ShowMessage('Vincita riscossa il ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Stamp));

  DoCheck; // refresh the panel with the new status
end;

end.
