unit ReceiptPrinterUnit;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.RegularExpressions,
  Vcl.Graphics,
  Vcl.Printers,
  Vcl.ComCtrls,           // for TRichEdit
  Vcl.StdCtrls,
  Vcl.Controls,
  Data.DB,
  System.Generics.Collections,
  Main,                   // Form1 (with img_QRCode)
  DM1;                    // Form2 (with tb_PosImages, tb_PosText, tb_PosPlaceHolders, db_RTEditor)

function BuildReceiptBitmap(
  const Ref: string;
  const PlaceholderDict: TDictionary<string,string>;
  QRSize: Integer
): TBitmap;

procedure PrintReceiptWithDict(
  const PrinterName: string;
  const Ref: string;
  const PlaceholderDict: TDictionary<string,string>;
  const Copies: Integer;
  QRSize: Integer
);

implementation

uses
  Vcl.Forms,
  Vcl.ExtCtrls,   // for TPanel, TImage
  Vcl.Dialogs,    // for ShowMessage
  RichEdit;       // for TRichEdit, EM_FORMATRANGE

type
  // Simple record to hold a token and the pixel-height it will occupy
  TTokenMeasurement = record
    Token: string;
    Height: Integer;
    constructor Create(const AToken: string; AHeight: Integer);
  end;

constructor TTokenMeasurement.Create(const AToken: string; AHeight: Integer);
begin
  Token := AToken;
  Height := AHeight;
end;

//-------------------------------------------------------------------------------
// FormatRangeToBitmap
//
//  - "re" is a TRichEdit that has already been parented to a hidden TPanel
//    and has its RtfText loaded via re.Lines.LoadFromStream(...).
//  - DC is the target HDC (e.g. Bmp.Canvas.Handle).
//  - X,Y are pixel offsets at which to begin drawing.
//  - MaxWidth is the maximum pixel-width for word-wrap.
//  Returns the pixel‐height of the formatted text block.
//-------------------------------------------------------------------------------
function FormatRangeToBitmap(re: TRichEdit; DC: HDC; X, Y, MaxWidth: Integer): Integer;
var
  fmtRange: TFormatRange;
  LogPixelsY: Integer;
  twipsPerInch: Integer;
  rectPage, rectRender: TRect;
  tmpBmp: TBitmap;
  lineHeight, pixelHeight: Integer;
begin
  // 1) Zero out the FormatRange record
  FillChar(fmtRange, SizeOf(fmtRange), 0);

  // 2) Set HDCs
  fmtRange.hdc       := DC;
  fmtRange.hdcTarget := DC;

  // 3) Compute “page” rectangle in TWIPS
  LogPixelsY := GetDeviceCaps(DC, LOGPIXELSY);
  twipsPerInch := 1440;

  rectPage.Left   := 0;
  rectPage.Top    := 0;
  rectPage.Right  := MulDiv(MaxWidth, twipsPerInch, LogPixelsY);
  rectPage.Bottom := MulDiv(20000, twipsPerInch, LogPixelsY);
    // 20000 twips ≈ 13.9" tall – plenty for most receipts

  rectRender := rectPage;
  // (we render into the top‐left corner of rectPage)

  fmtRange.rc      := rectRender;
  fmtRange.rcPage  := rectPage;
  fmtRange.chrg.cpMin := 0;
  fmtRange.chrg.cpMax := -1; // format all text

  // 4) Measure how many characters fit (no drawing yet):
  SendMessage(re.Handle, EM_FORMATRANGE, 0, LPARAM(@fmtRange));

  // 5) Shift DC origin so Y pixels down => draw text at (X=0, Y=Y)
  SetWindowOrgEx(DC, 0, -Y, nil);
  SendMessage(re.Handle, EM_FORMATRANGE, 1, LPARAM(@fmtRange));

  // 6) Cleanup the RTF control
  SendMessage(re.Handle, EM_FORMATRANGE, 0, 0);

  // 7) Calculate pixel height by counting lines × line‐height
  tmpBmp := TBitmap.Create;
  try
    tmpBmp.Canvas.Font.Assign(re.Font);
    lineHeight := tmpBmp.Canvas.TextHeight('Wg') + 2;
    pixelHeight := re.Lines.Count * lineHeight + 20;
  finally
    tmpBmp.Free;
  end;

  Result := pixelHeight;
end;

//-------------------------------------------------------------------------------
// BuildReceiptBitmap
//-------------------------------------------------------------------------------
function BuildReceiptBitmap(
  const Ref: string;
  const PlaceholderDict: TDictionary<string,string>;
  QRSize: Integer
): TBitmap;
var
  parts: TArray<string>;
  token: string;
  idx: Integer;
  measurements: TList<TTokenMeasurement>;
  totalHeight, pageWidth: Integer;
  Bmp: TBitmap;
  CurrentY: Integer;

  BlobStream: TMemoryStream;
  pict: TPicture;
  scale: Double;
  RawRTF, PlainText, ReplacementText: string;
  reTemp: TRichEdit;
  RegexPattern: string;
  Matches: TMatchCollection;
  Match: TMatch;
  NameOnly, PlaceholderToken: string;
  SeenNames: TDictionary<string, Boolean>;
  lineHt, thisHeight: Integer;
  bmpMeas: TBitmap;
  QRPanel: TPanel;
  QR: TImage;
  bmpQR: TBitmap;
  ss: TStringStream;

  hiddenPanel: TPanel;
begin
  // 1) Get printer page width in pixels
  Printer.Orientation := poPortrait;
  pageWidth := Printer.PageWidth;

  // 2) First pass: measure token heights
  measurements := TList<TTokenMeasurement>.Create;
  try
    parts := Ref.Split([',']);
    for token in parts do
    begin
      if token.IsEmpty then
        Continue;

      thisHeight := 0;

      // --- IQ<n>: background + centered QR overlay ---
      if token.StartsWith('IQ') and TryStrToInt(Copy(token, 3, MaxInt), idx) then
      begin
        if not Form2.tb_PosImages.Active then
          Form2.tb_PosImages.Open;
        if Form2.tb_PosImages.Locate('id', idx, []) then
        begin
          BlobStream := TMemoryStream.Create;
          try
            (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField).SaveToStream(BlobStream);
            BlobStream.Position := 0;
            pict := TPicture.Create;
            try
              pict.LoadFromStream(BlobStream);
              scale := pageWidth / pict.Width;
              thisHeight := Round(pict.Height * scale) + 20;
            finally
              pict.Free;
            end;
          finally
            BlobStream.Free;
          end;
        end;
      end

      // --- I<n>: plain image only ---
      else if (Length(token) >= 2) and (UpCase(token[1]) = 'I')
              and not token.StartsWith('IQ')
              and TryStrToInt(Copy(token, 2, MaxInt), idx) then
      begin
        if not Form2.tb_PosImages.Active then
          Form2.tb_PosImages.Open;
        if Form2.tb_PosImages.Locate('id', idx, []) then
        begin
          BlobStream := TMemoryStream.Create;
          try
            (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField).SaveToStream(BlobStream);
            BlobStream.Position := 0;
            pict := TPicture.Create;
            try
              pict.LoadFromStream(BlobStream);
              scale := pageWidth / pict.Width;
              thisHeight := Round(pict.Height * scale) + 20;
            finally
              pict.Free;
            end;
          finally
            BlobStream.Free;
          end;
        end;
      end

      // --- T<n>: RTF block with placeholders ---
      else if (Length(token) >= 2) and (UpCase(token[1]) = 'T')
              and TryStrToInt(Copy(token, 2, MaxInt), idx) then
      begin
        if not Form2.tb_PosText.Active then
          Form2.tb_PosText.Open;
        if Form2.tb_PosText.Locate('id', idx, []) then
        begin
          // Grab raw RTF from Form2.db_RTEditor
          RawRTF := Form1.db_RTEditor.RtfText;

          // Create a hidden panel as parent for our off-screen RichEdit
          hiddenPanel := TPanel.Create(Application.MainForm);
          try
            hiddenPanel.Parent := Application.MainForm;
            hiddenPanel.Visible := False;
            hiddenPanel.Left := -10000;    // keep it off-screen
            hiddenPanel.Top := -10000;

            // 1) Load RTF to extract PlainText (for regex)
            reTemp := TRichEdit.Create(Application.MainForm);
            try
              reTemp.Parent := hiddenPanel;
              reTemp.Visible := False;
              reTemp.PlainText := False;
              reTemp.WordWrap := True;
              reTemp.ScrollBars := ssNone;
              reTemp.Width := pageWidth;

              ss := TStringStream.Create(RawRTF, TEncoding.UTF8);
              try
                ss.Position := 0;
                reTemp.Lines.LoadFromStream(ss);
              finally
                ss.Free;
              end;

              PlainText := reTemp.Text;
            finally
              reTemp.Free;
            end;

            // 2) Run regex on PlainText to find {Name} tokens
            RegexPattern := '\{([^}]+)\}';
            Matches := TRegEx.Matches(PlainText, RegexPattern);

            SeenNames := TDictionary<string, Boolean>.Create;
            try
              for Match in Matches do
              begin
                NameOnly := Match.Groups[1].Value.Trim;
                if NameOnly.IsEmpty then
                  Continue;
                if SeenNames.ContainsKey(NameOnly) then
                  Continue;
                SeenNames.Add(NameOnly, True);

                if PlaceholderDict.TryGetValue(NameOnly, ReplacementText) then
                begin
                  PlaceholderToken := '\{' + NameOnly + '\}';
                  RawRTF := StringReplace(
                    RawRTF,
                    PlaceholderToken,
                    ReplacementText,
                    [rfReplaceAll, rfIgnoreCase]
                  );
                end;
              end;
            finally
              SeenNames.Free;
            end;

            // 3) Create a second TRichEdit to draw final RTF via EM_FORMATRANGE
            reTemp := TRichEdit.Create(Application.MainForm);
            try
              reTemp.Parent := hiddenPanel;
              reTemp.Visible := False;
              reTemp.PlainText := False;
              reTemp.WordWrap := True;
              reTemp.ScrollBars := ssNone;
              reTemp.Width := pageWidth;

              ss := TStringStream.Create(RawRTF, TEncoding.UTF8);
              try
                ss.Position := 0;
                reTemp.Lines.LoadFromStream(ss);
              finally
                ss.Free;
              end;

              // EM_FORMATRANGE requires the control to have a valid handle,
              // but since Parent is a real (albeit hidden) panel, it does.
              reTemp.HandleNeeded;

              // Measure pixel height using a temporary bitmap:
              bmpMeas := TBitmap.Create;
              try
                bmpMeas.Canvas.Font.Assign(reTemp.Font);
                lineHt := bmpMeas.Canvas.TextHeight('Wg') + 2;
                thisHeight := reTemp.Lines.Count * lineHt + 20;
              finally
                bmpMeas.Free;
              end;

              // Now render into the big bitmap at Y = CurrentY
              FormatRangeToBitmap(reTemp, Bmp.Canvas.Handle, 0, CurrentY, pageWidth);
            finally
              reTemp.Free;
            end;

          finally
            hiddenPanel.Free;
          end;

          Inc(CurrentY, thisHeight);
        end;
      end

      // --- Q: Standalone QR panel (no background) ---
      else if (UpCase(token[1]) = 'Q') then
      begin
        thisHeight := QRSize + 20;
      end;

      measurements.Add(TTokenMeasurement.Create(token, thisHeight));
    end;

    // 3) Sum up all heights
    totalHeight := 0;
    for var m in measurements do
      Inc(totalHeight, m.Height);

    // 4) Create the final big bitmap (pageWidth × totalHeight)
    Bmp := TBitmap.Create;
    Bmp.PixelFormat := pf24bit;
    Bmp.Width := pageWidth;
    Bmp.Height := totalHeight;
    Bmp.Canvas.Brush.Color := clWhite;
    Bmp.Canvas.FillRect(Rect(0, 0, pageWidth, totalHeight));

    // 5) Draw each token into Bmp.Canvas
    CurrentY := 0;
    for var m in measurements do
    begin
      token := m.Token;

      // --- IQ<n>: background + QR overlay ---
      if token.StartsWith('IQ') and TryStrToInt(Copy(token, 3, MaxInt), idx) then
      begin
        if Form2.tb_PosImages.Locate('id', idx, []) then
        begin
          BlobStream := TMemoryStream.Create;
          try
            (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField).SaveToStream(BlobStream);
            BlobStream.Position := 0;

            pict := TPicture.Create;
            try
              pict.LoadFromStream(BlobStream);
              scale := pageWidth / pict.Width;
              var destRect := Rect(
                0,
                CurrentY,
                pageWidth,
                CurrentY + Round(pict.Height * scale)
              );
              Bmp.Canvas.StretchDraw(destRect, pict.Graphic);

              QR := TImage.Create(nil);
              try
                QR.Picture.Assign(TForm1(Application.MainForm).img_QRCode.Picture);
                var qrX := (pageWidth - QR.Width) div 2;
                var qrY := CurrentY + (Round(pict.Height * scale) - QR.Height) div 2;
                Bmp.Canvas.Draw(qrX, qrY, QR.Picture.Bitmap);
              finally
                QR.Free;
              end;
            finally
              pict.Free;
            end;
          finally
            BlobStream.Free;
          end;
        end;
        Inc(CurrentY, m.Height);
      end

      // --- I<n>: plain image only ---
      else if (Length(token) >= 2) and (UpCase(token[1]) = 'I')
              and not token.StartsWith('IQ')
              and TryStrToInt(Copy(token, 2, MaxInt), idx) then
      begin
        if Form2.tb_PosImages.Locate('id', idx, []) then
        begin
          BlobStream := TMemoryStream.Create;
          try
            (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField).SaveToStream(BlobStream);
            BlobStream.Position := 0;

            pict := TPicture.Create;
            try
              pict.LoadFromStream(BlobStream);
              scale := pageWidth / pict.Width;
              var destRect := Rect(
                0,
                CurrentY,
                pageWidth,
                CurrentY + Round(pict.Height * scale)
              );
              Bmp.Canvas.StretchDraw(destRect, pict.Graphic);
            finally
              pict.Free;
            end;
          finally
            BlobStream.Free;
          end;
        end;
        Inc(CurrentY, m.Height);
      end

      // --- T<n>: already drawn via FormatRangeToBitmap (nothing to do) ---
      else if (Length(token) >= 2) and (UpCase(token[1]) = 'T')
              and TryStrToInt(Copy(token, 2, MaxInt), idx) then
      begin
        // no extra drawing here, since we already called FormatRangeToBitmap
      end

      // --- Q: standalone QR panel ---
      else if (UpCase(token[1]) = 'Q') then
      begin
        QRPanel := TPanel.Create(nil);
        try
          QRPanel.Width := QRSize;
          QRPanel.Height := QRSize;
          QRPanel.BorderStyle := bsNone;

          QR := TImage.Create(QRPanel);
          try
            QR.Parent := QRPanel;
            QR.Transparent := True;
            QR.AutoSize := False;
            QR.Width := QRSize;
            QR.Height := QRSize;
            QR.Picture.Assign(TForm1(Application.MainForm).img_QRCode.Picture);
            QR.Stretch := True;
            QR.Proportional := True;
            QR.Left := 0;
            QR.Top := 0;

            bmpQR := TBitmap.Create;
            try
              bmpQR.PixelFormat := pf24bit;
              bmpQR.Width := QRPanel.Width;
              bmpQR.Height := QRPanel.Height;
              QRPanel.PaintTo(bmpQR.Canvas.Handle, 0, 0);

              Bmp.Canvas.StretchDraw(
                Rect(0, CurrentY, pageWidth, CurrentY + QRSize),
                bmpQR
              );
            finally
              bmpQR.Free;
            end;
          finally
            QR.Free;
          end;
        finally
          QRPanel.Free;
        end;
        Inc(CurrentY, QRSize + 20);
      end;
    end;

    Result := Bmp;
  finally
    measurements.Free;
  end;
end;

procedure PrintReceiptWithDict(
  const PrinterName: string;
  const Ref: string;
  const PlaceholderDict: TDictionary<string,string>;
  const Copies: Integer;
  QRSize: Integer
);
var
  ReceiptBmp: TBitmap;
  copyIndex: Integer;
begin
  ReceiptBmp := BuildReceiptBitmap(Ref, PlaceholderDict, QRSize);
  try
    for copyIndex := 1 to Copies do
    begin
      Printer.PrinterIndex := Printer.Printers.IndexOf(PrinterName);
      if Printer.PrinterIndex < 0 then
      begin
        ShowMessage(Format('Printer "%s" not found.', [PrinterName]));
        Exit;
      end;

      Printer.Orientation := poPortrait;
      Printer.BeginDoc;
      try
        Printer.Canvas.Draw(0, 0, ReceiptBmp);
      finally
        Printer.EndDoc;
      end;
    end;
  finally
    ReceiptBmp.Free;
  end;
end;

end.
