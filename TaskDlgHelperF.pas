unit TaskDlgHelperF;

interface

uses
  System.SysUtils,
  System.IOUtils, // TFile
  System.UITypes, // mrOk/mrNo/mrCancel
  Vcl.Dialogs, // TTaskDialog
  Vcl.Graphics, // icons
  Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg,
  Vcl.Forms, Vcl.Controls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;
// for Overload 3

{ ------------------------------------------------------------------------------
  Overload 1: SIMPLE — no radio group
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string): Integer; overload;

{ ------------------------------------------------------------------------------
  Overload 2: EXTENDED — with radio group
  - RadioItems: [] means no radio group.
  - DefaultRadioIndex: 0-based; use -1 for "no default selection".
  - SelectedRadioIndex: returns 0-based index or -1.
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string; const RadioItems: array of string;
  DefaultRadioIndex: Integer; out SelectedRadioIndex: Integer)
  : Integer; overload;

{ ------------------------------------------------------------------------------
  Overload 3: DATE PICKER — with TMonthCalendar
  - SelectedDate: returns the picked date if user presses OK, 0 otherwise.
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string; out SelectedDate: TDate): Integer; overload;

implementation

uses
  Main;

{ ------------------------------------------------------------------------------
  Overload 1
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string): Integer; overload;
var
  DummySel: Integer;
begin
  Result := TaskDlg_Default(Cap, Titl, Txt, Btn0Caption, Btn1Caption,
    Btn2Caption, IconPath, [], -1, DummySel);
end;

{ ------------------------------------------------------------------------------
  Overload 2: EXTENDED — with radio group
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string; const RadioItems: array of string;
  DefaultRadioIndex: Integer; out SelectedRadioIndex: Integer)
  : Integer; overload;
var
  Dlg: TTaskDialog;
  Btn, RB: TTaskDialogBaseButtonItem;
  I: Integer;
  ThisIcon: string;
begin
  SelectedRadioIndex := -1;

  Dlg := TTaskDialog.Create(nil);
  try
    // Basic text
    Dlg.Caption := Cap;
    Dlg.Title := Titl;
    Dlg.Text := Txt;

    // Custom buttons only
    Dlg.CommonButtons := [];
    Dlg.Flags := Dlg.Flags + [tfUseHIconMain] - [tfAllowDialogCancellation];

    // Optional icon
    ThisIcon := '';
    if IconPath <> '' then
    begin
      ThisIcon := TPath.Combine(Form1.ed_ImgDir.Text, IconPath);

      if not TFile.Exists(ThisIcon) then
        raise Exception.Create('Icon file not found: ' + ThisIcon);

      // TaskDialog main icon should be an .ICO (HICON-based)
      if not SameText(ExtractFileExt(ThisIcon), '.ico') then
        raise Exception.Create('TaskDialog main icon must be .ICO, got: ' +
          ThisIcon);

      try
        Dlg.CustomMainIcon.LoadFromFile(ThisIcon);
      except
        on E: Exception do
          raise Exception.CreateFmt('Failed to load TaskDialog icon: %s (%s)',
            [ThisIcon, E.Message]);
      end;
    end
    else
      Dlg.Flags := Dlg.Flags - [tfUseHIconMain];

    // --- Custom buttons with modal results ---
    if Btn0Caption <> '' then
    begin
      Btn := Dlg.Buttons.Add;
      Btn.Caption := Btn0Caption;
      Btn.ModalResult := System.UITypes.mrOk;
    end;

    if Btn1Caption <> '' then
    begin
      Btn := Dlg.Buttons.Add;
      Btn.Caption := Btn1Caption;
      Btn.ModalResult := System.UITypes.mrNo;
    end;

    if Btn2Caption <> '' then
    begin
      Btn := Dlg.Buttons.Add;
      Btn.Caption := Btn2Caption;
      Btn.ModalResult := System.UITypes.mrCancel;
    end;

    // Optional radio group
    if Length(RadioItems) > 0 then
    begin
      for I := 0 to High(RadioItems) do
      begin
        RB := Dlg.RadioButtons.Add;
        RB.Caption := RadioItems[I];
        if I = DefaultRadioIndex then
          RB.Default := True;
      end;

      if (DefaultRadioIndex < 0) or (DefaultRadioIndex > High(RadioItems)) then
        Dlg.Flags := Dlg.Flags + [tfNoDefaultRadioButton]
      else
        Dlg.Flags := Dlg.Flags - [tfNoDefaultRadioButton];
    end
    else
      Dlg.Flags := Dlg.Flags + [tfNoDefaultRadioButton];

    // Execute and collect results
    if Dlg.Execute then
    begin
      Result := Dlg.ModalResult;

      if Length(RadioItems) > 0 then
      begin
        if Assigned(Dlg.RadioButton) then
          SelectedRadioIndex := Dlg.RadioButton.Index
        else
          SelectedRadioIndex := -1;
      end
      else
        SelectedRadioIndex := -1;
    end
    else
      Result := -1;
  finally
    Dlg.Free;
  end;
end;

{ ------------------------------------------------------------------------------
  Overload 3: DATE PICKER — with TMonthCalendar
  ------------------------------------------------------------------------------ }
function TaskDlg_Default(const Cap, Titl, Txt, Btn0Caption, Btn1Caption,
  Btn2Caption, IconPath: string; out SelectedDate: TDate): Integer; overload;
var
  Frm: TForm;
  Cal: TMonthCalendar;
  LblTitle, LblText: TLabel;
  BtnOK, BtnNo, BtnCancel: TButton;
  Img: TImage;
  ThisIcon: string;
  IconOffset: Integer;
begin
  SelectedDate := 0;
  Result := -1;

  Frm := TForm.Create(nil);
  try
    Frm.Caption := Cap;
    Frm.Width := 380;
    Frm.Height := 320;
    Frm.Position := poScreenCenter;
    Frm.BorderStyle := bsDialog;
    Frm.Font.Name := 'Segoe UI';
    Frm.Font.Size := 9;

    IconOffset := 12;

    // Optional icon (image formats OK: BMP/PNG/JPG/etc, as supported by VCL)
    ThisIcon := '';
    if IconPath <> '' then
    begin
      ThisIcon := TPath.Combine(Form1.ed_ImgDir.Text, IconPath);

      if not TFile.Exists(ThisIcon) then
        raise Exception.Create('Icon file not found: ' + ThisIcon);

      Img := TImage.Create(Frm);
      Img.Parent := Frm;
      try
        Img.Picture.LoadFromFile(ThisIcon);
      except
        on E: EInvalidGraphic do
          raise EInvalidGraphic.CreateFmt('Invalid image file: %s (%s)',
            [ThisIcon, E.Message]);
        on E: Exception do
          raise Exception.CreateFmt('Failed to load image file: %s (%s)',
            [ThisIcon, E.Message]);
      end;

      Img.AutoSize := True;
      Img.Top := 16;
      Img.Left := 16;
      IconOffset := Img.Width + 24;
    end;

    // Title (bold)
    LblTitle := TLabel.Create(Frm);
    LblTitle.Parent := Frm;
    LblTitle.Caption := Titl;
    LblTitle.Left := IconOffset;
    LblTitle.Top := 16;
    LblTitle.Font.Style := [fsBold];
    LblTitle.Font.Size := 10;
    LblTitle.AutoSize := True;

    // Content text
    LblText := TLabel.Create(Frm);
    LblText.Parent := Frm;
    LblText.Caption := Txt;
    LblText.Left := IconOffset;
    LblText.Top := LblTitle.Top + LblTitle.Height + 6;
    LblText.Width := Frm.ClientWidth - IconOffset - 16;
    LblText.WordWrap := True;

    // Month calendar
    Cal := TMonthCalendar.Create(Frm);
    Cal.Parent := Frm;
    Cal.Date := Now;
    Cal.Top := LblText.Top + LblText.Height + 10;
    Cal.Left := (Frm.ClientWidth - Cal.Width) div 2;

    // Buttons bottom-right
    BtnCancel := TButton.Create(Frm);
    BtnCancel.Parent := Frm;
    BtnCancel.Caption := Btn2Caption;
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Top := Frm.ClientHeight - 45;
    BtnCancel.Left := Frm.ClientWidth - BtnCancel.Width - 16;
    BtnCancel.Anchors := [akRight, akBottom];

    BtnNo := TButton.Create(Frm);
    BtnNo.Parent := Frm;
    BtnNo.Caption := Btn1Caption;
    BtnNo.ModalResult := mrNo;
    BtnNo.Top := BtnCancel.Top;
    BtnNo.Left := BtnCancel.Left - BtnNo.Width - 8;
    BtnNo.Anchors := [akRight, akBottom];

    BtnOK := TButton.Create(Frm);
    BtnOK.Parent := Frm;
    BtnOK.Caption := Btn0Caption;
    BtnOK.ModalResult := mrOk;
    BtnOK.Top := BtnCancel.Top;
    BtnOK.Left := BtnNo.Left - BtnOK.Width - 8;
    BtnOK.Anchors := [akRight, akBottom];
    Frm.ActiveControl := BtnOK;

    // Show modal
    Result := Frm.ShowModal;
    if Result = mrOk then
      SelectedDate := Cal.Date;
  finally
    Frm.Free;
  end;
end;

end.
