UNIT Notes;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RzPanel, RzDBNav,
  Vcl.StdCtrls, Vcl.DBCtrls, RzDBEdit, System.ImageList, Vcl.ImgList,
  JvImageList;

TYPE
  TNotes_ = CLASS(TForm)
    RzDBMemo1: TRzDBMemo;
    RzDBNavigator1: TRzDBNavigator;
    JvImageList1: TJvImageList;
    PROCEDURE FormShow(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  Notes_: TNotes_;

IMPLEMENTATION

{$R *.dfm}


USES RrRooms, DM1;

PROCEDURE TNotes_.FormShow(Sender: TObject);
BEGIN
  Self.BringToFront;
END;

END.
