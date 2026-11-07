unit DM1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Math,
  System.Variants,
  System.Classes, System.DateUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, edbcomps, Vcl.ExtCtrls,
  Vcl.StdCtrls, DBSumLst, OtlCommon, OtlComm, OtlTask, OtlTaskControl,
  OtlEventMonitor, MMSystem;

type
  TForm2 = class(TForm)
    EDBEngine1: TEDBEngine;
    PGC_Session: TEDBSession;
    PGC_Database: TEDBDatabase;
    Shape4: TShape;
    tb_Anomalies: TEDBTable;
    tb_CardCategories: TEDBTable;
    tb_Cards: TEDBTable;
    tb_CleanLog: TEDBTable;
    tb_ClientHistory: TEDBTable;
    tb_Clients: TEDBTable;
    tb_ClLedger: TEDBTable;
    tb_Discounts: TEDBTable;
    tb_ExpLedger: TEDBTable;
    tb_Fees: TEDBTable;
    tb_Operators: TEDBTable;
    tb_OpLedger: TEDBTable;
    tb_Pecuniam: TEDBTable;
    tb_Personnel: TEDBTable;
    tb_PersonnelHistory: TEDBTable;
    tb_ReceiptText: TEDBTable;
    tb_Services: TEDBTable;
    tb_ServicesMaintenance: TEDBTable;
    tb_SS: TEDBTable;
    PGC_Query: TEDBQuery;
    DataSource1: TDataSource;
    procedure PGC_SessionBeforeConnect(Sender: TObject);
    procedure PGC_SessionStatusMessage(Sender: TObject; const StatusMessage: string);
    procedure PGC_DatabaseLogMessage(Sender: TObject; const LogMessage: string);
    procedure PGC_DatabaseStatusMessage(Sender: TObject; const StatusMessage: string);
    procedure PGC_DatabaseProgress(Sender: TObject; PercentDone: Integer; var Continue: Boolean);
  private
  { Private declarations }

    const

  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Main, SyncObjs, DSiWin32;

procedure TForm2.PGC_DatabaseLogMessage(Sender: TObject; const LogMessage: string);
begin
  Form1.Memo1.Lines.Add(LogMessage);
end;

procedure TForm2.PGC_DatabaseProgress(Sender: TObject; PercentDone: Integer; var Continue: Boolean);
begin
form1.ProgressBar1.Position:= PercentDone;
end;

procedure TForm2.PGC_DatabaseStatusMessage(Sender: TObject; const StatusMessage: string);
begin
 Form1.Memo1.Lines.Add(StatusMessage);
end;

procedure TForm2.PGC_SessionBeforeConnect(Sender: TObject);
begin
  PGC_Session.LoginUser := 'Operator';
  PGC_Session.LoginPassword := '1234';
end;

procedure TForm2.PGC_SessionStatusMessage(Sender: TObject; const StatusMessage: string);
begin
  Form1.Memo1.Lines.Add(StatusMessage);
end;

initialization

finalization

end.
