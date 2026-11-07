UNIT DlgExpDetail;

INTERFACE

USES Winapi.Windows, System.SysUtils, System.Classes, System.UITypes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, JvExExtCtrls,
  Vcl.Dialogs, Variants,
  Vcl.Mask, DBCtrlsEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,  GridsEh, DBAxisGridsEh,//EhLibVCL,
  DBGridEh, Vcl.DBCtrls, JvDBImage, Data.DB, AdvGroupBox,
  AdvGlassButton, AdvPanel, AdvOfficeButtons, EhLibVclUtils;

TYPE
  Tdlg_ExpensesDetail = CLASS(TForm)
    sc_dlgClients: TDataSource;
    dbgd_DlgClients: TDBGridEh;
    Label2: TLabel;
    Label3: TLabel;
    ed_DlgDare: TDBNumberEditEh;
    ed_DlgAvere: TDBNumberEditEh;
    rg_PmChange: TAdvOfficeRadioGroup;
    bt_OK: TAdvGlassButton;
    bt_Cancel: TAdvGlassButton;
    rg_DlgCostCentr: TAdvOfficeRadioGroup;
    ed_DlgDescr: TDBEditEh;
    bt_Close: TAdvGlassButton;
    Label1: TLabel;
    dbgd_ClLedger: TDBGridEh;
    rg_Storno: TAdvOfficeRadioGroup;
    lb_receipt: TLabel;
    Memo1: TMemo;
    PROCEDURE rg_DlgCostCentrClick(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE ed_DlgDareExit(Sender: TObject);
    PROCEDURE ed_DlgAvereExit(Sender: TObject);
    PROCEDURE ed_DlgDescrExit(Sender: TObject);
    PROCEDURE ed_DlgDareChange(Sender: TObject);
    PROCEDURE ed_DlgAvereChange(Sender: TObject);
    PROCEDURE ed_DlgDescrChange(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE bt_CancelClick(Sender: TObject);
    PROCEDURE CheckIfComplete;
    PROCEDURE rg_PmChangeClick(Sender: TObject);
    PROCEDURE CancelAll;
    PROCEDURE CheckDepositBalance;
    PROCEDURE dbgd_DlgClientsCellClick(Column: TColumnEh);
    PROCEDURE bt_CloseClick(Sender: TObject);
    PROCEDURE rg_StornoClick(Sender: TObject);
    PROCEDURE dbgd_ClLedgerCellClick(Column: TColumnEh);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  dlg_ExpensesDetail: Tdlg_ExpensesDetail;
  pecuniaStr, nTID, cCenter, tType: STRING;
  nDBal: Double;
  caID: Integer;
  receipt: Boolean;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main, nDlgPecunia;

PROCEDURE Tdlg_ExpensesDetail.rg_StornoClick(Sender: TObject);
BEGIN
  CASE rg_Storno.ItemIndex OF
    0:
      BEGIN
        dbgd_DlgClients.BringToFront;
        dlg_ExpensesDetail.Left := 1280;
      END;
    1:
      BEGIN
        dlg_ExpensesDetail.dbgd_ClLedger.BringToFront;
        Left := 700;
      END;
  END;
  rg_DlgCostCentr.Enabled := rg_Storno.ItemIndex = 0;
  rg_PmChange.Enabled := rg_Storno.ItemIndex = 0;
  ed_DlgDescr.Enabled := rg_Storno.ItemIndex = 0;
  ed_DlgDare.Enabled := rg_Storno.ItemIndex = 0;
  ed_DlgAvere.Enabled := rg_Storno.ItemIndex = 0;
  bt_Cancel.Enabled := rg_Storno.ItemIndex = 1;
  CancelAll;
END;

PROCEDURE Tdlg_ExpensesDetail.bt_CancelClick(Sender: TObject);
BEGIN
  CancelAll;
END;

PROCEDURE Tdlg_ExpensesDetail.bt_CloseClick(Sender: TObject);
BEGIN
  CancelAll;
  dlg_ExpensesDetail.Close;
END;

PROCEDURE Tdlg_ExpensesDetail.CancelAll;
BEGIN
  Form1.ThisClient.ID := 0;
  caID := 0;
  nTID := '';
  ed_DlgDescr.Clear;
  ed_DlgAvere.Value := 0;
  ed_DlgDare.Value := 0;
  rg_DlgCostCentr.ItemIndex := -1;
  rg_PmChange.ItemIndex := -1;
  dbgd_DlgClients.Enabled := False;
  ed_DlgDescr.Enabled := False;
  ed_DlgDare.Enabled := False;
  ed_DlgAvere.Enabled := False;
  bt_OK.Enabled := False;
  Form2.qy_dlg_Clients.First;
END;

PROCEDURE Tdlg_ExpensesDetail.CheckIfComplete;
BEGIN
  bt_OK.Enabled := (rg_PmChange.ItemIndex > -1) AND
    (rg_DlgCostCentr.ItemIndex > -1) AND (ed_DlgDescr.Text <> '') AND
    ((ed_DlgDare.Value > 0) OR (ed_DlgAvere.Value > 0));
END;

PROCEDURE Tdlg_ExpensesDetail.dbgd_ClLedgerCellClick(Column: TColumnEh);
BEGIN
  bt_OK.Enabled := True;
END;

PROCEDURE Tdlg_ExpensesDetail.dbgd_DlgClientsCellClick(Column: TColumnEh);
BEGIN
  WITH Form2 DO
    BEGIN
      IF rg_DlgCostCentr.ItemIndex = 3 THEN
        BEGIN
          CheckDepositBalance;
          ed_DlgDescr.Text := ed_DlgDescr.Text + ' ' + qy_dlg_Clients.FieldByName('Alias').AsString;
        END;
      IF rg_DlgCostCentr.ItemIndex IN [0, 3] THEN
        BEGIN
          Form1.ThisClient.ID := qy_dlg_Clients.FieldByName('ClientID').AsInteger;
          caID := qy_dlg_Clients.FieldByName('CardID').AsInteger;
          Form1.ThisClient.ID := qy_dlg_Clients.FieldByName('ClientID').AsInteger;
          Form1.nGetClientData;
        END;
    END;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgAvereChange(Sender: TObject);
BEGIN
  ed_DlgDare.Enabled := ed_DlgAvere.Value = 0;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgAvereExit(Sender: TObject);
BEGIN
  ed_DlgDare.Enabled := ed_DlgAvere.Value = 0;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgDareChange(Sender: TObject);
BEGIN
  ed_DlgAvere.Enabled := ed_DlgDare.Value = 0;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgDareExit(Sender: TObject);
BEGIN
  ed_DlgAvere.Enabled := ed_DlgDare.Value = 0;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgDescrChange(Sender: TObject);
BEGIN
  ed_DlgAvere.Enabled := ed_DlgDare.Value = 0;
  ed_DlgDare.Enabled := ed_DlgAvere.Value = 0;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.ed_DlgDescrExit(Sender: TObject);
BEGIN
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.FormClose(Sender: TObject;
  VAR Action: TCloseAction);
BEGIN
  rg_DlgCostCentr.ItemIndex := -1;
END;

PROCEDURE Tdlg_ExpensesDetail.FormShow(Sender: TObject);
BEGIN
  IF Form1.resetIncExpDlg THEN
    BEGIN
      Form1.c_PayNow := True;
      bt_OK.Enabled := False;
      ed_DlgDescr.Clear;
      ed_DlgDare.Clear;
      ed_DlgAvere.Clear;
      ed_DlgDare.Enabled := receipt;
      IF rg_PmChange.Items.Count = 2 THEN
        rg_PmChange.Items.Add('Carta di Credito');
      IF receipt THEN
        lb_receipt.Caption := 'Registrazione con ricevuta'
      ELSE
        lb_receipt.Caption := 'Registrazione senza ricevuta';
      rg_DlgCostCentr.ItemIndex := -1;
    END;
END;

PROCEDURE Tdlg_ExpensesDetail.rg_DlgCostCentrClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  ed_DlgDescr.Clear;
  cCenter := '';
  tType := '';
  ed_DlgDare.Value := 0;
  ed_DlgAvere.Value := 0;
  dbgd_DlgClients.Enabled := (rg_DlgCostCentr.ItemIndex = 0) OR
    (rg_DlgCostCentr.ItemIndex = 3);
  ed_DlgDescr.Enabled := (rg_DlgCostCentr.ItemIndex <> -1);
  ed_DlgDare.Enabled := (rg_DlgCostCentr.ItemIndex <> -1) AND (receipt);
  ed_DlgAvere.Enabled := (rg_DlgCostCentr.ItemIndex <> -1);

  CASE rg_DlgCostCentr.ItemIndex OF
    0:
      s := 'SELECT c.id as ClientID,c.alias,c.FirstName,c.LastName,c.image,ca.ID as CardID ' +
        'FROM Clients c ' +
        'RIGHT JOIN Cards ca ON ' +
        'ca.Clientid = c.ID ' +
        'WHERE c.InHouse = True OR c.CheckedIn = True ' +
        'GROUP BY c.ID ' +
        'ORDER BY Alias';

    3: // Only who has accomodation
      BEGIN
        rg_Storno.ItemIndex := -1;
        s := 'SELECT c.id as ClientID,c.alias,c.FirstName,c.LastName,c.image,ca.ID as CardID ' +
          'FROM Clients c ' +
          'RIGHT JOIN Cards ca ON ' +
          'ca.Clientid = c.ID ' +
          'WHERE c.InHouse = True ' +
          'GROUP BY c.ID ' +
          'ORDER BY Alias';
      END;
  END;

  IF rg_DlgCostCentr.ItemIndex IN [0, 3] THEN
    BEGIN
      WITH Form2.qy_dlg_Clients DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear;
          SQL.Add(s);
          Active := True;
          dbgd_DlgClients.Refresh;
        END;
    END;
  CheckIfComplete;
END;

PROCEDURE Tdlg_ExpensesDetail.CheckDepositBalance;
VAR
  payedDep, remboursedDep: Double;
BEGIN
  // Check deposit balance
  // ---------------------
  payedDep := 0;
  remboursedDep := 0;
  WITH Form1, Form2 DO
    BEGIN
      WITH qy_Tmp DO
        BEGIN
          IF Active THEN
            Close;
          SQL.Clear; // Get payed deposit
          SQL.Add('SELECT TxID, COALESCE(SUM(Avere),0) AS aSum FROM RR_Deposits c1 ' +
            'WHERE c1.TxType = ''IR'' AND NOT PayMethod IS NULL ' +
            'AND Avere > 0 AND clientid = ' + qy_dlg_Clients.FieldByName('ClientID').AsString +
            ' GROUP BY ClientID');
          Active := True;
          IF RecordCount > 0 THEN
            payedDep := FieldValues['aSum'];
          Active := False;

          IF Active THEN
            Close;
          SQL.Clear; // Get remboursed deposit
          SQL.Add('SELECT TxID, COALESCE(SUM(Dare),0) AS dSum FROM RR_Deposits c1 ' +
            'WHERE c1.TxType = ''ER'' AND NOT PayMethod IS NULL ' +
            'AND Dare > 0 AND clientid = ' + qy_dlg_Clients.FieldByName('ClientID').AsString +
            ' GROUP BY ClientID');
          Active := True;
          IF RecordCount > 0 THEN
            remboursedDep := FieldValues['dSum'];
          Active := False;
          IF payedDep > remboursedDep THEN // Client has rental depsoit
            BEGIN
              ed_DlgDescr.Text := 'Rimborso Cauzione';
              ed_DlgDare.Clear;
              ed_DlgAvere.Value := abs(payedDep - remboursedDep);
            END
          ELSE
            BEGIN
              IF Active THEN // Get deposit amount for this room and client
                Close;
              SQL.Clear;
              SQL.Add('SELECT ClientID, Room, rr.Deposit FROM RR_Dates rd ' +
                'JOIN RR_Rooms rr ON rd.Room = rr.RoomID ' +
                'WHERE (rd.DepartureDate IS Null ' +
                'OR CURRENT_DATE <= rd.DepartureDate) ' +
                'AND ClientID = ' + qy_dlg_Clients.FieldByName('ClientID').AsString);
              Active := True;
              IF RecordCount > 0 THEN
                BEGIN
                  ed_DlgDescr.Text := 'Pagamento Cauzione';
                  ed_DlgAvere.Clear;
                  ed_DlgDare.Value := FieldValues['Deposit'];
                  // nTID := GenerateTxID;
                END;
            END;
          Active := False;
          CheckIfComplete;
        END;
    END;
END;

PROCEDURE Tdlg_ExpensesDetail.rg_PmChangeClick(Sender: TObject);
BEGIN
  CASE rg_PmChange.ItemIndex OF
    0:
      pecuniaStr := 'CH';
    1:
      pecuniaStr := 'EU ';
    2:
      pecuniaStr := 'CC';
  ELSE
    pecuniaStr := '';
  END;
  CheckIfComplete;
END;

END.
