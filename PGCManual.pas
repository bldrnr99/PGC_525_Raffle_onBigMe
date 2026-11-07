UNIT PGCManual;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, edbcomps, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls, Vcl.ComCtrls,
  DBCtrlsEh, GridsEh, DBAxisGridsEh, DBGridEh, EhLibVclUtils;

TYPE
  TManual = CLASS(TForm)
    DBGridEh1: TDBGridEh;
    scqy_Manual: TDataSource;
    DBRichEditEh1: TDBRichEditEh;
    DBGridEh2: TDBGridEh;
    DBRichEditEh2: TDBRichEditEh;
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  Manual: TManual;

IMPLEMENTATION

{$R *.dfm}


USES DM1, Main;

END.
