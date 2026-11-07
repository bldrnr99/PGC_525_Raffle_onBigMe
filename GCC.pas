unit GCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Vcl.ExtCtrls, RzPanel, RzRadGrp, EhLibVclUtils,
  GridsEh, DBAxisGridsEh, DBGridEh, Data.DB, edbcomps, Vcl.StdCtrls,
  AdvGlassButton, DateUtils;

type
  TCCtoG = class(TForm)
    dbgd_1010_GCC: TDBGridEh;
    rg_CCtoG: TRzRadioGroup;
    AdvGlassButton5: TAdvGlassButton;
    cb_ClientOrder: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure rg_CCtoGClick(Sender: TObject);
    procedure dbgd_1010_GCCDblClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure AdvGlassButton5Click(Sender: TObject);
    Procedure CheckIfReverse1010OK(amountToMove: Double);
    Procedure CheckIfReverse1010OK_wDate(amountToMove: Double);
    procedure cb_ClientOrderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CCtoG: TCCtoG;

implementation

{$R *.dfm}


uses DM1, Main, KeyBoard, TaskDlgHelperF;

procedure TCCtoG.AdvGlassButton5Click(Sender: TObject);
Var
  workingday, workingDayPeriod: String;
begin
  With Form1 do
  begin
    Form1.SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
      cl_Closing_Cal.StartDate, workingday, workingDayPeriod, False,
      rg_DayMode.ItemIndex = 1);
    PrintCCCashtoGClick(workingDayPeriod);
  end;
end;

procedure TCCtoG.dbgd_1010_GCCDblClick(Sender: TObject);
begin
  CheckIfReverse1010OK(Form2.qy_1010_GCC.FieldByName('Dare1000').AsFloat);
end;

procedure TCCtoG.cb_ClientOrderClick(Sender: TObject);
begin
  rg_CCtoG.OnClick(Sender);
end;

(*
  Procedure TCCtoG.CheckIfReverse1010OK(amountToMove: Double);
  Var
    MR: Integer;
    workingDayPeriod, workingday, closingID: String;
    ChosenDate: TDate;
    balance1000, sum1010, sum2900: Double;
  begin
    With Form1 do
      SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
        cl_Closing_Cal.EndDate, workingday, workingDayPeriod, False, False);

    With Form2.qy_Tmp do
    Begin
      IF Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT closingID FROM c_1000 WHERE DATA ' + workingDayPeriod +
        ' AND NOT ClosingID IS NULL ' + ' GROUP BY ClosingID');
      Active := True;
      IF RecordCount > 0 Then
      begin
        ShowMessage('Operazione non possibile - Periodo già chiuso.');
        Exit;
      end;
    End;

    balance1000 := Form1.GetCashBalance('CH');

    With Form2.qy_1010_GCC do
    begin
      If (amountToMove > balance1000) AND (NOT FieldByName('Data1000').IsNull) AND
        (FieldByName('Data1010').IsNull) AND
        (FieldByName('LastData2900').IsNull) Then
      begin
        ShowMessage('Saldo del ' + workingday + ' insufficiente' +
          ' per spostare ' + FormatFloat('0.00', amountToMove) + ' CHF in busta.'
          + sLineBreak + 'Se invece vuoi fare un pagamento diretto a ' +
          Form2.qy_1010_GCC.FieldByName('ShortName').AsString + sLineBreak +
          'fallo da CASSA/Pagam. CC');
        Exit;
      end;

      // Check if already payed
      // -------------------------------------------------------------------------

      If (Not FieldByName('Data1010').IsNull) AND
        (FieldByName('LastData2900').IsNull) then
      begin
        TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
          'Spostamento contanti da cassa in buste CC per ragazze',
          'L''importo di ' + FormatFloat('0.00', amountToMove) + ' CHF per ' +
          Form2.qy_1010_GCC.FieldByName('ShortName').AsString + ' è già in busta.'
          + sLineBreak + 'Versamenti a ragazze da fare in CASSA/Pagam. CC', 'OK',
          '', '', 'envelopeWMoney.ico');
        Exit;
      end;

      If NOT FieldByName('LastData2900').IsNull then
      begin
        TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
          'Spostamento contanti da cassa in buste CC per ragazze',
          'L''importo di ' + FormatFloat('0.00', amountToMove) +
          ' CHF è già stato versato a ' + Form2.qy_1010_GCC.FieldByName
          ('ShortName').AsString, 'OK', '', '', 'envelopeWMoney.ico');
        Exit;
      end;

      IF (NOT FieldByName('Data1000').IsNull) AND (FieldByName('Data1010').IsNull)
        AND (FieldByName('LastData2900').IsNull) Then
        MR := TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
          'Spostamento contanti da cassa in buste CC per ragazze',
          'Confermi l''importo di ' + FormatFloat('0.00', amountToMove) +
          ' CHF per ' + Form2.qy_1010_GCC.FieldByName('ShortName').AsString + '?',
          'SI', '', 'NO', 'envelopeWMoney.ico');

      CASE MR OF
        1:
          begin
            With Form1 do
            begin
              Form2.PostReverseEntry(cl_Closing_Cal.StartDate, closingID);
              UpdateClosingPage(nil, cl_Closing_Cal.StartDate,
                cl_Closing_Cal.EndDate);
              SetDatePeriod(now, now, now, workingday, workingDayPeriod, False,
                rg_DayMode.ItemIndex = 1);
            end;
            Form2.Update_Qy_1010_GCC(workingDayPeriod, sum1010, sum2900);
            DisableControls;
            dbgd_1010_GCC.Refresh;
            Form2.qy_1010_GCC.Last;
            EnableControls;
          end;
        2:
          Exit;
      END;
    end;
  end;

*)

// ===========================================================================
//  2) GCC.pas — CheckIfReverse1010OK, now currency-aware
// ===========================================================================
Procedure TCCtoG.CheckIfReverse1010OK(amountToMove: Double);
Var
  MR: Integer;
  workingDayPeriod, workingday, closingID: String;
  balance1000, sum1010, sum2900: Double;
  CurCode: String;  // 'CH' / 'EU'  -> for GetCashBalance
  CurName: String;  // 'CHF' / 'EUR' -> for messages
  AmountStr: String;
begin
  MR := 2; // default = NO (was uninitialised if no dialog was shown)

  With Form1 do
    SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
      cl_Closing_Cal.EndDate, workingday, workingDayPeriod, False, False);

  With Form2.qy_Tmp do
  Begin
    IF Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT  closingID FROM c_1000 WHERE DATA ' + workingDayPeriod +
      ' AND NOT ClosingID IS NULL ' + ' GROUP BY ClosingID');
    Active := True;
    IF RecordCount > 0 Then
    begin
      ShowMessage('Operazione non possibile - Periodo già chiuso.');
      Exit;
    end;
  End;

  With Form2.qy_1010_GCC do
  begin
    // Currency of the selected row
    if SameText(Trim(FieldByName('Paymethod').AsString), 'EU') then
    begin
      CurCode := 'EU';
      CurName := 'EUR';
    end
    else
    begin
      CurCode := 'CH';
      CurName := 'CHF';
    end;

    AmountStr := FormatFloat('0.00', amountToMove) + ' '; // + CurName;
    balance1000 := Form1.GetCashBalance(CurCode);

    If (amountToMove > balance1000) AND (NOT FieldByName('Data1000').IsNull) AND
      (FieldByName('Data1010').IsNull) AND
      (FieldByName('LastData2900').IsNull) Then
    begin
      ShowMessage('Saldo ' + CurName + ' del ' + workingday + ' insufficiente' +
        ' per spostare ' + AmountStr + ' in busta.' + sLineBreak +
        'Se invece vuoi fare un pagamento diretto a ' +
        FieldByName('ShortName').AsString + sLineBreak +
        'fallo da CASSA/Pagam. CC');
      Exit;
    end;

    // Check if already paid
    // -------------------------------------------------------------------------
    If NOT FieldByName('LastData2900').IsNull then
    begin
      TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
        'Spostamento contanti da cassa in buste CC per ragazze',
        'L''importo di ' + AmountStr + ' è già stato versato a ' +
        FieldByName('ShortName').AsString, 'OK', '', '', 'envelopeWMoney.ico');
      Exit;
    end;

    // Check if already in envelope
    // -------------------------------------------------------------------------
    If (Not FieldByName('Data1010').IsNull) AND
      (FieldByName('LastData2900').IsNull) then
    begin
      TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
        'Spostamento contanti da cassa in buste CC per ragazze',
        'L''importo di ' + AmountStr + ' per ' +
        FieldByName('ShortName').AsString + ' è già in busta.' + sLineBreak +
        'Versamenti a ragazze da fare in CASSA/Pagam. CC', 'OK', '', '',
        'envelopeWMoney.ico');
      Exit;
    end;


    IF (NOT FieldByName('Data1000').IsNull) AND (FieldByName('Data1010').IsNull)
      AND (FieldByName('LastData2900').IsNull) Then
      MR := TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
        'Spostamento contanti da cassa in buste CC per ragazze',
        'Confermi l''importo di ' + AmountStr + ' per ' +
        FieldByName('ShortName').AsString + '?', 'SI', '', 'NO',
        'envelopeWMoney.ico');

    CASE MR OF
      1:
        begin
          With Form1 do
          begin
            Form2.PostReverseEntry(cl_Closing_Cal.StartDate, closingID);
            UpdateClosingPage(nil, cl_Closing_Cal.StartDate,
              cl_Closing_Cal.EndDate);
            SetDatePeriod(now, now, now, workingday, workingDayPeriod, False,
              rg_DayMode.ItemIndex = 1);
          end;
          Form2.Update_Qy_1010_GCC(workingDayPeriod, sum1010, sum2900);
          DisableControls;
          dbgd_1010_GCC.Refresh;
          Form2.qy_1010_GCC.Last;
          EnableControls;
        end;
      2:
        Exit;
    END;
  end;
end;


Procedure TCCtoG.CheckIfReverse1010OK_wDate(amountToMove: Double);
Var
  MR: Integer;
  workingDayPeriod, workingday, closingID: String;
  ChosenDate: TDate;
begin

  MR := TaskDlg_Default('Pagamento CC', // Window caption
    'Calendario incassi', // Title (bold)
    'Scegli la data della busta', // Text message
    'OK', // Button 1 caption
    'No', // Button 2 caption
    'Cancel', // Button 3 caption
    'calendar48.ico', // Icon file (inside Form1.ed_ImgDir.Text)
    ChosenDate // Out parameter for the picked date
    );
  With Form1 do
  begin
    SetDatePeriod(ChosenDate, ChosenDate, ChosenDate, workingday,
      workingDayPeriod, False, rg_DayMode.ItemIndex = 1);
  end;

  case MR of
    mrOk:
      begin
        ShowMessage('hai scelto la busta del giorno: ' + DateToStr(ChosenDate));

        ChosenDate := RecodeTime(ChosenDate, 23, 59, 59, 0);
        With Form2.qy_Tmp do
        Begin
          IF Active Then
            Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('    SUM(c1000.Avere) AS SumAvere1000');
          SQL.Add('FROM C_1000 c1000');
          SQL.Add('WHERE c1000.Avere > 0');
          SQL.Add('  AND c1000.SubFeeID = 990');
          SQL.Add('  AND c1000.cPartita = 2900');
          SQL.Add('  AND c1000.Data ' + workingDayPeriod);
          SQL.Add('  AND EXISTS (');
          SQL.Add('      SELECT 1');
          SQL.Add('      FROM C_2900 c2900');
          SQL.Add('      WHERE  c2900.cPartita = 1000');
          SQL.Add('  )');
          Active := True;
          Var
          sumAvere1000 := FieldByName('SumAvere1000').AsFloat;
          // Now get CH sum of chosen date
          With Form2.qy_Tmp do
          Begin
            IF Active Then
              Close;
            SQL.Clear;
            SQL.Add('SELECT closingID, ');
            SQL.Add(' (Coalesce(SUM(c1000.Dare),0) - Coalesce(SUM(c1000.Avere),0)) AS Balance1000 ');
            SQL.Add('FROM C_1000 c1000');
            SQL.Add(' Where c1000.Data ' + workingDayPeriod);
            SQL.Add(' AND PayMethod = ' + QuotedStr('CH'));
            SQL.Add(' GROUP BY ClosingID ');
            Active := True;

            Var
            balance1000 := FieldByName('Balance1000').AsFloat;

            IF NOT FieldByName('ClosingID').IsNull Then
              closingID := FieldByName('ClosingID').AsString
            else
              closingID := '';

            If amountToMove > balance1000 Then
            begin
              ShowMessage('Saldo del ' + DateTimeToStr(ChosenDate) +
                ' insufficiente' + #13#10 + ' per metter ' +
                FloattoStr(amountToMove) + ' in busta.');
              Exit;
            end;
          End;

        End;
      end;
    mrNo:
      Exit;
    mrCancel:
      Exit;
  else
    ShowMessage('Dialog closed unexpectedly.');
  end;

  With Form2.qy_1010_GCC do
  begin
    If (Not FieldByName('Data1010').IsNull) AND
      (FieldByName('LastData2900').IsNull) then
    begin
      TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
        'Spostamento contanti da cassa in buste CC per ragazze',
        'L''importo di ' + Form2.qy_1010_GCC.FieldByName('Dare1000').AsString +
        ' per ' + Form2.qy_1010_GCC.FieldByName('ShortName').AsString +
        ' è già stato messo in busta.', 'OK', '', '', 'envelopeWMoney.ico');
      Exit;
    end;
    If NOT FieldByName('LastData2900').IsNull then
    begin
      TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
        'Spostamento contanti da cassa in buste CC per ragazze',
        'L''importo di ' + Form2.qy_1010_GCC.FieldByName('Dare1000').AsString +
        ' è già stato versato a ' + Form2.qy_1010_GCC.FieldByName('ShortName')
        .AsString, 'OK', '', '', 'envelopeWMoney.ico');
      Exit;
    end;

    MR := TaskDlgHelperF.TaskDlg_Default('Gestione contanti buste',
      'Spostamento contanti da cassa in buste CC per ragazze',
      'Confermi l''importo di ' + Form2.qy_1010_GCC.FieldByName('Dare1000')
      .AsString + ' per ' + Form2.qy_1010_GCC.FieldByName('ShortName').AsString
      + '?', 'SI', '', 'NO', 'envelopeWMoney.ico');
    CASE MR OF
      1:
        begin
          Form2.PostReverseEntry(ChosenDate, closingID);
          With Form1 do
            UpdateClosingPage(nil, cl_Closing_Cal.StartDate,
              cl_Closing_Cal.EndDate);
        end;
      2:
        Exit;
    END;

  end;
end;

procedure TCCtoG.FormClick(Sender: TObject);
begin
  rg_CCtoG.ItemIndex := 0;
end;

procedure TCCtoG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cb_ClientOrder.Checked := False;
end;

procedure TCCtoG.FormShow(Sender: TObject);
Var
  workingday, workingDayPeriod: String;
  sum1010, sum2900: Double;
begin

  {
    With Form2 do
    begin
    qy_1010_GCC.DisableControls;
    try
    // Update params here if needed
    qy_1010_GCC.Close;
    qy_1010_GCC.Open; // re-executes the SELECT
    finally
    qy_1010_GCC.EnableControls;
    // Form2.qy_1010_GCC.Active := True;
    Form2.qy_1010_GCC.Last;
    dbgd_1010_GCC.Refresh;
    end;
    end;
  }
  CASE rg_CCtoG.ItemIndex OF
    0:
      begin
        workingDayPeriod := '';
      end;
    1:
      begin
        Form1.SetDatePeriod(Form1.cl_Closing_Cal.StartDate,
          Form1.cl_Closing_Cal.StartDate, Form1.cl_Closing_Cal.EndDate,
          workingday, workingDayPeriod, False, Form1.rg_DayMode.ItemIndex = 1);
      end;
  end;

  Form2.Update_Qy_1010_GCC(workingDayPeriod, sum1010, sum2900);
  CCtoG.Caption := 'Carte di Credito Clienti ' + Form1.lb_Period.Caption;
end;

procedure TCCtoG.rg_CCtoGClick(Sender: TObject);
Var
  workingday, workingDayPeriod: String;
  aDate: TDateTime;
  sum1010, sum2900: Double;
begin

  CASE rg_CCtoG.ItemIndex OF
    0:
      begin
        Form2.Update_Qy_1010_GCC('', sum1010, sum2900);
      end;
    1:
      begin
        With Form1.cl_Closing_Cal do
        begin
          Form1.SetDatePeriod(StartDate, StartDate, EndDate, workingday,
            workingDayPeriod, True, False);
        end;

        Form2.Update_Qy_1010_GCC(workingDayPeriod, sum1010, sum2900);
      end;
  END;
  Form2.qy_1010_GCC.Refresh;
  Form2.qy_1010_GCC.Last;
end;

end.
