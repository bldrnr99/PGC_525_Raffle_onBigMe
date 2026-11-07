UNIT nDlgRaffles;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.DateUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, JvDBImage,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  GridsEh, DBAxisGridsEh, DBGridEh, AdvGlassButton, Vcl.StdCtrls, Vcl.DBCGrids,
  Vcl.Mask, DBCtrlsEh, Vcl.ExtCtrls, Vcl.Printers, EhLibVclUtils;

TYPE
  TnDlgRaffle = CLASS(TForm)
    DBGridEh1: TDBGridEh;
    cg_RafflePrices: TDBCtrlGrid;
    db_FeeTxt: TDBText;
    img_Fee: TJvDBImage;
    bt_Read: TAdvGlassButton;
    bt_Choose: TAdvGlassButton;
    bt_print: TAdvGlassButton;
    bt_Cancel: TAdvGlassButton;
    AdvGlassButton4: TAdvGlassButton;
    Label1: TLabel;
    Edit1: TEdit;
    pl_rPrint: TPanel;
    Label2: TLabel;
    lb_rPrice: TLabel;
    Label3: TLabel;
    lb_rValue: TLabel;
    Label5: TLabel;
    lb_rValidUntil: TLabel;
    lb_rQrCode: TLabel;
    lb_QrCode: TLabel;
    DBGridEh2: TDBGridEh;
    PROCEDURE bt_ReadClick(Sender: TObject);
    PROCEDURE Edit1Change(Sender: TObject);
    PROCEDURE AdvGlassButton4Click(Sender: TObject);
    PROCEDURE cg_RafflePricesClick(Sender: TObject);
    PROCEDURE ResetAll;
    PROCEDURE bt_CancelClick(Sender: TObject);
    PROCEDURE bt_ChooseClick(Sender: TObject);
    PROCEDURE bt_printClick(Sender: TObject);
    PROCEDURE PrintPrizeTicket;
    PROCEDURE FormShow(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  nDlgRaffle: TnDlgRaffle;
  ticketTxID, s: STRING;
  cancelSequenze, subFeeID: Integer;
  rValue: Double;
  printPreview: Boolean;
  P: TPoint;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

PROCEDURE TnDlgRaffle.AdvGlassButton4Click(Sender: TObject);
BEGIN
  ResetAll;
  nDlgRaffle.Close;
END;

PROCEDURE TnDlgRaffle.bt_CancelClick(Sender: TObject);
BEGIN
  IF (printPreview = False) AND (MessageDlg('Stai per eliminare il ticket premio appena stampato. Procedi?',
    mtConfirmation, [mbOk, mbNo], 0, mbOk) = mrOk) THEN
    WITH Form2, qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('DELETE FROM RafflePrices WHERE TxID = ' + QuotedStr(ticketTxID));
      ExecSQL;
      tb_Raffle.Refresh;
      ShowMessage('Il premio *' + copy(ticketTxID, 9, 5) + '* è stato eliminato. ' + #10#13 +
        'Ricordati di strappare il ticket stampato.');
    END;
  ResetAll;
END;

PROCEDURE TnDlgRaffle.bt_ChooseClick(Sender: TObject);
BEGIN
  cg_RafflePrices.Visible := True;
  bt_Read.Enabled := False;
  cancelSequenze := 2;
END;

PROCEDURE TnDlgRaffle.bt_ReadClick(Sender: TObject);
BEGIN
  Edit1.Enabled := True;
  ActiveControl := Edit1;
  bt_Choose.Enabled := False;
  ticketTxID := '';
  Edit1.Clear;
  lb_QrCode.Caption := 'Scannerizza ora il ticket..';
END;

PROCEDURE TnDlgRaffle.Edit1Change(Sender: TObject);
BEGIN
  IF length(Edit1.Text) = 14 THEN
  BEGIN
    ticketTxID := copy(Edit1.Text, 2, 13);
    WITH Form2, qy_Tmp DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM RafflePrices WHERE TxID = ' + QuotedStr(ticketTxID));
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        lb_QrCode.Caption := 'Questo biglietto ha già un premio assegnato!';
        tb_Raffle.Locate('TxID', Edit1.Text, []);
        bt_Read.Caption := 'Leggi ticket';
        Exit;
      END;
      bt_Read.Enabled := RecordCount > 0;
      bt_Read.Caption := copy(ticketTxID, 9, 5);
      bt_Choose.Enabled := NOT bt_Read.Enabled;
      bt_Cancel.Enabled := True;
      cg_RafflePrices.Enabled := bt_Choose.Enabled;
      bt_Choose.Enabled := bt_Choose.Enabled;
      cancelSequenze := 1;
      lb_QrCode.Caption := '*' + copy(ticketTxID, 9, 5) + '*';
      Edit1.Enabled := False;
      WITH Form1 DO
      BEGIN
        // Barcode1.InputText := 'P' + ticketTxID;
        TRY
          // Image3.Picture.Assign(Barcode1.Bitmap);
        EXCEPT
          ON E: Exception DO
          BEGIN
            img_QRcode.Picture.Assign(NIL);
          END;
        END;
      END;
    END;
  END;
END;

PROCEDURE TnDlgRaffle.FormShow(Sender: TObject);
BEGIN
  WITH nDlgRaffle DO
  BEGIN
    Left := 802;
    Top := 500;
    P := Form1.ClientToScreen(Point(0, 0));
    Left := Left + P.X;
    Top := Top + P.Y;
  END;
END;

PROCEDURE TnDlgRaffle.cg_RafflePricesClick(Sender: TObject);
BEGIN
  (*
    WITH Form2.tb_RaffleFees DO
    BEGIN
    IF FieldByName('SubID').AsInteger = 800 THEN
    BEGIN
    bt_Choose.Caption := 'Bar ' + Form1.ed_BarRValue.Text;
    rValue := Form1.ed_BarRValue.Value;
    END
    ELSE
    BEGIN
    bt_Choose.Caption := FieldByName('Description').AsString;
    rValue := FieldByName('Fee').AsFloat;
    END;
    bt_print.Enabled := True;
    subFeeID := FieldByName('SubID').AsInteger;
    cancelSequenze := 2;
    printPreview := True;
    cancelSequenze := 1;
    END;
  *)
END;

PROCEDURE TnDlgRaffle.bt_printClick(Sender: TObject);
BEGIN
  (*
    IF printPreview THEN
    BEGIN
    cg_RafflePrices.Visible := False;
    pl_rPrint.Visible := True;
    lb_rPrice.Caption := Form2.tb_RaffleFees.FieldByName('Description').AsString;
    lb_rValue.Caption := FloatToStr(rValue);
    lb_rQrCode.Caption := '*' + copy(Edit1.Text, 9, 5) + '*';
    lb_rValidUntil.Caption := DateTostr(IncDay(Now, Form1.ed_rValidUntil.Value));
    bt_print.Caption := 'Stampa premio';
    printPreview := False;
    END
    ELSE
    BEGIN
    PrintPrizeTicket;

    s := 'INSERT INTO RafflePrices (Data,RaffleDate,Value,SubfeeID,Valid,TxID,' +
    'ValidHowManyDays,Printed) ' +
    'VALUES(CURRENT_TIMESTAMP, ' +
    'CURRENT_DATE, ' + FloatToStr(rValue) + ', ' +
    IntToStr(subFeeID) + ', True, ' +
    QuotedStr(ticketTxID) + ', ' +
    Form1.ed_rValidUntil.Text + ', True)';
    Form2.t_executequery(s, 'PGC_DB_Main_Unicode', 'PGC_DB_Unicode', 'RafflePrices');
    END;
    cancelSequenze := 3;
  *)
END;

PROCEDURE TnDlgRaffle.PrintPrizeTicket;
VAR
  myPrinter: TPrinter;
  Device: ARRAY [0 .. 255] OF Char;
  Driver: ARRAY [0 .. 255] OF Char;
  Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
  TextAR: TStrings;
  PName: STRING;
  Y: Integer;
BEGIN
  Printer.PrinterIndex := Printer.Printers.IndexOf(PName);
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  myPrinter := Printer;
  WITH myPrinter DO
  BEGIN
    BeginDoc;
    Y := 110;
    SetTextAlign(myPrinter.Handle, TA_Center);
    Canvas.Font.Style := [];
    Canvas.Font.Size := 12;
    Canvas.TextOut(250, Y, 'LA FORTUNA TI HA BACIATO AL');
    Canvas.Font.Size := 20;
    Canvas.Font.name := 'Times New Roman';
    Canvas.Font.Style := [fsBold];
    INC(Y, 30);
    Canvas.TextOut(250, Y, 'POMPEII');
    Canvas.Font.name := 'Tahoma';
    Canvas.Font.Style := [];
    Canvas.Font.Size := 12;
    INC(Y, 50);
    Canvas.TextOut(250, Y, 'Gentlemen''s Club');
    Canvas.Font.Size := 14;
    Canvas.Font.Style := [fsBold];
    INC(Y, 50);
    IF subFeeID = 800 THEN
      Canvas.TextOut(250, Y, 'POMPEII CASH')
    ELSE
      Canvas.TextOut(250, Y, 'BUONO PER UNA');
    INC(Y, 50);
    IF subFeeID = 800 THEN
      Canvas.TextOut(250, Y, FloatToStr(rValue) + ' SESTERZI')
    ELSE
      Canvas.TextOut(250, Y, Form2.tb_RaffleFees.FieldByName('Description').AsString);
    Canvas.Font.Style := [];
    Canvas.Font.Size := 12;
    INC(Y, 100);
    Canvas.Draw(200, Y, Form1.img_QRcode.Picture.Graphic);
    IF subFeeID = 800 THEN
    BEGIN
      INC(Y, 120);
      Canvas.TextOut(250, Y, '(Da utilizzare al club)');
      INC(Y, 50);
    END
    ELSE
      INC(Y, 120);
    Canvas.TextOut(250, Y, 'Grazie  per la tua visita');
    INC(Y, 30);
    Canvas.TextOut(250, Y, 'A presto');
    INC(Y, 60);
    Canvas.TextOut(250, Y, 'Estrazione del ' + DateTostr(DateOf(Now)));
    INC(Y, 40);
    // Canvas.TextOut(250, Y, 'Scade il ' + DateTostr(IncDay(Now, Form1.ed_rValidUntil.Value)));
    INC(Y, 50);
    Canvas.TextOut(250, Y, Edit1.Text);
    IF subFeeID = 800 THEN
    BEGIN
      INC(Y, 50);
      Canvas.TextOut(250, Y, 'Pagato da: (firma cassiere)');
      INC(Y, 120);
      Canvas.TextOut(250, Y, '_____________________________________');
      INC(Y, 50);
      Canvas.TextOut(250, Y, 'In data:');
      INC(Y, 120);
      Canvas.TextOut(250, Y, '____________________________________');
    END;
    INC(Y, 40);
    Canvas.TextOut(250, Y, '.');
    EndDoc;
  END;
END;

PROCEDURE TnDlgRaffle.ResetAll;
BEGIN
  Edit1.Clear;
  lb_QrCode.Caption := '';
  lb_QrCode.Caption := '*Numero vincente*';
  ticketTxID := '';
  cancelSequenze := 0;
  subFeeID := 0;
  bt_Cancel.Enabled := False;
  bt_Read.Enabled := True;
  bt_Read.Caption := 'Leggi ticket';
  bt_Choose.Enabled := False;
  bt_Choose.Caption := 'Scegli premio';
  bt_print.Enabled := False;
  bt_print.Caption := 'Anteprima stampa';
  cg_RafflePrices.Visible := False;
  pl_rPrint.Visible := False;
END;

END.
