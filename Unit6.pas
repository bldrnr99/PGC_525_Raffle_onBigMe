UNIT Unit6;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, AdvPanel, Vcl.StdCtrls, AdvProgressBar,
  Vcl.Imaging.pngimage;

TYPE
  TSplashScreen = CLASS(TForm)
    Label1: TLabel;
    JvImage1: TJvImage;
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
