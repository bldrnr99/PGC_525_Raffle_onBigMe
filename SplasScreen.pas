UNIT SplasScreen;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvExComCtrls, JvStatusBar,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

TYPE
  TSplashScreen = CLASS(TForm)
    Image1: TImage;
    JvStatusBar1: TJvStatusBar;
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  SplashScreen: TSplashScreen;

IMPLEMENTATION

{$R *.dfm}

END.
