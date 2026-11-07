UNIT DlgNewClient;

INTERFACE

USES Winapi.Windows, System.SysUtils, System.Classes, System.Dateutils,
  Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Dialogs,
  JvExExtCtrls,
  JvExtComponent, JvDBRadioPanel, Vcl.Mask, DBCtrlsEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,  GridsEh, DBAxisGridsEh,
  DBGridEh, Vcl.DBCtrls, JvDBImage, Data.DB, Vcl.WinXCalendars, Vcl.ComCtrls,
  AdvMemo, EhLibVclUtils;

TYPE
  Tdlg_NewClient = CLASS(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbgd_DlgClients: TDBGridEh;
    dbimg_DlgClients: TJvDBImage;
    dbtxt_DlgClients: TDBText;
    ed_DlgNC_LName: TEdit;
    ed_DlgNC_FName: TEdit;
    DateTimePicker1: TDateTimePicker;
    Label4: TLabel;
    AdvMemo1: TAdvMemo;
    Label5: TLabel;
    sc_Clients: TDataSource;
    DBGridEh1: TDBGridEh;
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE ed_DlgNC_LNameChange(Sender: TObject);
    PROCEDURE CancelBtnClick(Sender: TObject);
    PROCEDURE DateTimePicker1Change(Sender: TObject);
    PROCEDURE OKBtnClick(Sender: TObject);
    PROCEDURE ed_DlgNC_LNameExit(Sender: TObject);
    PROCEDURE ed_DlgNC_FNameExit(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  dlg_NewClient: Tdlg_NewClient;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

PROCEDURE Tdlg_NewClient.CancelBtnClick(Sender: TObject);
BEGIN
  ed_DlgNC_LName.Text := '';
  ed_DlgNC_FName.Text := '';
  DateTimePicker1.Date := Now;
  dlg_NewClient.Close;
END;

PROCEDURE Tdlg_NewClient.DateTimePicker1Change(Sender: TObject);
VAR
  age: Integer;
BEGIN
  age := YearsBetween(DateTimePicker1.DateTime, Now);
  Label4.Caption := 'Età: ' + IntToStr(age);
  OKBtn.Enabled := (ed_DlgNC_LName.Text <> '') AND (ed_DlgNC_FName.Text <> '')
    AND (age > 17);
END;

PROCEDURE Tdlg_NewClient.ed_DlgNC_FNameExit(Sender: TObject);
BEGIN
  ed_DlgNC_FName.Text := Form1.TitleCase(ed_DlgNC_FName.Text);
END;

PROCEDURE Tdlg_NewClient.ed_DlgNC_LNameChange(Sender: TObject);
BEGIN
  WITH Form2.tb_Clients DO
    BEGIN
      IF trim(ed_DlgNC_LName.Text) > '' THEN
        BEGIN
          Filter := 'LastName like ' + quotedstr(trim(ed_DlgNC_LName.Text) + '%');
          Filtered := True
        END
      ELSE
        Filtered := False
    END;
END;

PROCEDURE Tdlg_NewClient.ed_DlgNC_LNameExit(Sender: TObject);
BEGIN
  ed_DlgNC_LName.Text := Form1.TitleCase(ed_DlgNC_LName.Text);
END;

PROCEDURE Tdlg_NewClient.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  Form2.tb_Clients.Filter := 'InHouse = True';
  Form2.tb_Clients.Filtered := True;
  ed_DlgNC_LName.Clear;
  ed_DlgNC_FName.Clear;
  DateTimePicker1.Date := Now;
END;

PROCEDURE Tdlg_NewClient.FormShow(Sender: TObject);
BEGIN
  Form2.tb_Clients.Filtered := False;
  Form2.tb_Clients.First;
END;

PROCEDURE Tdlg_NewClient.OKBtnClick(Sender: TObject);
VAR
  cID: Integer;
BEGIN
  IF (ed_DlgNC_LName.Text <> '') AND (ed_DlgNC_FName.Text <> '') AND
    (YearsBetween(DateTimePicker1.DateTime, Now) > 17) THEN
    WITH Form2, tb_ClientiClients DO
      BEGIN
        Edit;
        Append;
        FieldByName('ID').AsInteger := GetMaxClientID;
        FieldByName('LastName').AsString := ed_DlgNC_LName.Text;
        FieldByName('FirstName').AsString := ed_DlgNC_FName.Text;
        FieldByName('BirthDate').AsDateTime := DateTimePicker1.DateTime;
        FieldByName('Type').AsString := 'Regolare';
        Post;
        tb_Clients.Refresh;
      END
  ELSE
    BEGIN
      ShowMessage('Mancano i dati!');
      Form2.tb_ClientiClients.Cancel;
    END;

END;

END.
