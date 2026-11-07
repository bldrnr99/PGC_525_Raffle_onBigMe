unit CreditCards;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlassButton, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TForm5 = class(TForm)
    bt_CC: TImage;
    pl_Pecunia: TPanel;
    bt_CHF: TAdvGlassButton;
    bt_Euro: TAdvGlassButton;
    bt_Cancel: TAdvGlassButton;
    procedure bt_CancelClick(Sender: TObject);
    procedure bt_CCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Main;

procedure TForm5.bt_CancelClick(Sender: TObject);
begin
Form5.Close;
end;

procedure TForm5.bt_CCClick(Sender: TObject);
begin
Form1.bt_RegisterClick(Sender);
end;

end.
