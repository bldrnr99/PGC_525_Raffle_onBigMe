unit uRecapCreditCards;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  System.DateUtils,
  DBGridEhToolCtrls, DynVarsEh, AdvGlassButton, Vcl.StdCtrls, AdvGroupBox,
  AdvOfficeButtons, EhLibVclUtils, GridsEh, DBAxisGridsEh, DBGridEh,
  AdvSmoothTabPager;

type
  TRecapCreditCards = class(TForm)
    procedure cb_ShowMonthCCtoGClick(Sender: TObject);
    procedure cb_CCtoGClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecapCreditCards: TRecapCreditCards;

implementation

{$R *.dfm}

uses DM1, GCC, Main;

procedure TRecapCreditCards.cb_CCtoGClick(Sender: TObject);
begin
  Form1.FilterCCandDeposits(cb_CCtoG.Checked, cb_Deposits.Checked);
end;

end.
