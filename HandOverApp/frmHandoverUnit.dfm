object frmHandover: TfrmHandover
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Shift Handover'
  ClientHeight = 630
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow

  { =========================================================
    HEADER PANEL
    Full width across the top. Contains till number, date/time,
    From and To staff combos.
    ========================================================= }
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 880
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Color = $00303030
    ParentBackground = False
    TabOrder = 0

    object lblTillLabel: TLabel
      Left = 16
      Top = 12
      Width = 28
      Height = 17
      Caption = 'Till:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00C0C0C0
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end

    object lblTill: TLabel
      Left = 50
      Top = 10
      Width = 30
      Height = 21
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object lblDateLabel: TLabel
      Left = 90
      Top = 12
      Width = 36
      Height = 17
      Caption = 'Date:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00C0C0C0
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end

    object lblDateTime: TLabel
      Left = 132
      Top = 10
      Width = 160
      Height = 21
      Caption = '12.02.2026   23:41'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end

    object lblSeparator: TLabel
      Left = 16
      Top = 42
      Width = 848
      Height = 1
      AutoSize = False
      Color = $00505050
      ParentColor = False
      Transparent = False
    end

    object lblFromLabel: TLabel
      Left = 16
      Top = 52
      Width = 40
      Height = 17
      Caption = 'From:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00C0C0C0
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end

    object cmbFromStaff: TComboBox
      Left = 62
      Top = 48
      Width = 200
      Height = 25
      Style = csDropDownList
      Color = $00404040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = cmbToStaffChange
    end

    object lblToLabel: TLabel
      Left = 290
      Top = 52
      Width = 20
      Height = 17
      Caption = 'To:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00C0C0C0
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end

    object cmbToStaff: TComboBox
      Left = 316
      Top = 48
      Width = 200
      Height = 25
      Style = csDropDownList
      Color = $00404040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = cmbToStaffChange
    end
  end

  { =========================================================
    FOOTER PANEL
    Full width across the bottom. Notes field and buttons.
    ========================================================= }
  object pnlFooter: TPanel
    Left = 0
    Top = 582
    Width = 880
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    Color = $00F0F0F0
    TabOrder = 1

    object lblNotesLbl: TLabel
      Left = 12
      Top = 15
      Width = 38
      Height = 17
      Caption = 'Notes:'
    end

    object edNotes: TEdit
      Left = 56
      Top = 12
      Width = 580
      Height = 25
      MaxLength = 200
      TabOrder = 0
    end

    object btnCancel: TButton
      Left = 716
      Top = 11
      Width = 70
      Height = 28
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 0
      TabOrder = 1
      OnClick = btnCancelClick
    end

    object btnProcess: TButton
      Left = 794
      Top = 11
      Width = 74
      Height = 28
      Caption = 'Handover ►'
      Default = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnProcessClick
    end
  end

  { =========================================================
    SUPERVISOR OVERRIDE PANEL
    Visible = False at design time.
    Appears above footer when variance exceeds tolerance.
    ========================================================= }
  object pnlOverride: TPanel
    Left = 0
    Top = 504
    Width = 880
    Height = 78
    Align = alBottom
    BevelOuter = bvNone
    BevelInner = bvNone
    BorderWidth = 0
    Color = $00EEF5FF
    ParentBackground = False
    TabOrder = 2
    Visible = False

    object lblOverrideIcon: TLabel
      Left = 12
      Top = 10
      Width = 22
      Height = 28
      Caption = '⚠'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $000080FF
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object lblOverrideMsg: TLabel
      Left = 42
      Top = 10
      Width = 580
      Height = 17
      AutoSize = False
      Caption = 'Variance outside tolerance — supervisor authorisation required.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00004080
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end

    object lblPINLbl: TLabel
      Left = 42
      Top = 38
      Width = 90
      Height = 17
      Caption = 'Supervisor PIN:'
    end

    object edSuperPIN: TEdit
      Left = 138
      Top = 34
      Width = 70
      Height = 25
      MaxLength = 4
      PasswordChar = '*'
      TabOrder = 0
      OnChange = edSuperPINChange
      OnKeyPress = edSuperPINKeyPress
    end

    object shpPINStatus: TShape
      Left = 216
      Top = 40
      Width = 14
      Height = 14
      Brush.Color = clSilver
      Pen.Color = clGray
      Shape = stCircle
    end

    object lblReasonLbl: TLabel
      Left = 244
      Top = 38
      Width = 48
      Height = 17
      Caption = 'Reason:'
    end

    object edReason: TEdit
      Left = 298
      Top = 34
      Width = 360
      Height = 25
      MaxLength = 200
      TabOrder = 1
    end
  end

  { =========================================================
    LEFT PANEL — DENOMINATION ENTRY
    Occupies left ~54% of body area.
    Contains PageControl with CHF and EUR tab sheets.
    ========================================================= }
  object pnlLeft: TPanel
    Left = 0
    Top = 80
    Width = 480
    Height = 424
    Align = alNone
    BevelOuter = bvNone
    TabOrder = 3

    object pcCurrencies: TPageControl
      Left = 8
      Top = 8
      Width = 464
      Height = 390
      ActivePage = tsCHF
      TabOrder = 0

      object tsCHF: TTabSheet
        Caption = 'CHF Cash'
        ImageIndex = -1

        object sgCHF: TStringGrid
          Left = 4
          Top = 4
          Width = 444
          Height = 308
          ColCount = 3
          DefaultColWidth = 85
          DefaultRowHeight = 22
          FixedCols = 0
          FixedRows = 1
          RowCount = 13
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine,
                     goHorzLine, goRangeSelect, goEditing,
                     goAlwaysShowEditor]
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyPress = sgCHFKeyPress
          OnSelectCell = sgCHFSelectCell
          OnSetEditText = sgCHFSetEditText
          ColWidths = (85 55 85)
        end

        object lblCHFTotal: TLabel
          Left = 4
          Top = 320
          Width = 444
          Height = 22
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total:  CHF 0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end

      object tsEUR: TTabSheet
        Caption = 'EUR Cash'
        ImageIndex = -1

        object sgEUR: TStringGrid
          Left = 4
          Top = 4
          Width = 444
          Height = 308
          ColCount = 3
          DefaultColWidth = 85
          DefaultRowHeight = 22
          FixedCols = 0
          FixedRows = 1
          RowCount = 11
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine,
                     goHorzLine, goRangeSelect, goEditing,
                     goAlwaysShowEditor]
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyPress = sgEURKeyPress
          OnSelectCell = sgEURSelectCell
          OnSetEditText = sgEURSetEditText
          ColWidths = (85 55 85)
        end

        object lblEURTotal: TLabel
          Left = 4
          Top = 320
          Width = 444
          Height = 22
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total:  EUR 0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end

  { =========================================================
    RIGHT PANEL — SUMMARY
    Occupies right ~46% of body area.
    Shows Expected / Counted / Variance for CHF, EUR, Cards.
    ========================================================= }
  object pnlSummary: TPanel
    Left = 480
    Top = 80
    Width = 400
    Height = 424
    Align = alNone
    BevelOuter = bvLowered
    Color = $00FAFAFA
    ParentBackground = False
    TabOrder = 4

    object lblSumTitle: TLabel
      Left = 12
      Top = 10
      Width = 376
      Height = 20
      AutoSize = False
      Caption = 'SUMMARY'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00505050
      Font.Height = -14
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end

    { ----- CHF CASH SECTION ----- }

    object lblCHFSecTitle: TLabel
      Left = 12
      Top = 38
      Width = 376
      Height = 17
      AutoSize = False
      Caption = 'CHF Cash'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00707070
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
    end

    object lblCHFExpLbl: TLabel
      Left = 20
      Top = 60
      Width = 80
      Height = 17
      Caption = 'Expected'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblCHFExp: TLabel
      Left = 220
      Top = 60
      Width = 120
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = []
      ParentFont = False
    end

    object lblCHFCntLbl: TLabel
      Left = 20
      Top = 82
      Width = 80
      Height = 17
      Caption = 'Counted'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblCHFCnt: TLabel
      Left = 220
      Top = 82
      Width = 120
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = []
      ParentFont = False
    end

    object lblCHFVarLbl: TLabel
      Left = 20
      Top = 104
      Width = 80
      Height = 17
      Caption = 'Variance'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblCHFVar: TLabel
      Left = 180
      Top = 104
      Width = 160
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CHF  0.00  ✓'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $005C8A00
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object shpCHFStatus: TShape
      Left = 350
      Top = 108
      Width = 12
      Height = 12
      Brush.Color = clGreen
      Pen.Color = clGreen
      Shape = stCircle
    end

    { --- Divider --- }
    object bvlCHFEUR: TBevel
      Left = 12
      Top = 128
      Width = 368
      Height = 6
      Shape = bsTopLine
    end

    { ----- EUR CASH SECTION ----- }

    object lblEURSecTitle: TLabel
      Left = 12
      Top = 140
      Width = 376
      Height = 17
      AutoSize = False
      Caption = 'EUR Cash'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00707070
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
    end

    object lblEURExpLbl: TLabel
      Left = 20
      Top = 162
      Width = 80
      Height = 17
      Caption = 'Expected'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblEURExp: TLabel
      Left = 220
      Top = 162
      Width = 120
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = []
      ParentFont = False
    end

    object lblEURCntLbl: TLabel
      Left = 20
      Top = 184
      Width = 80
      Height = 17
      Caption = 'Counted'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblEURCnt: TLabel
      Left = 220
      Top = 184
      Width = 120
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = []
      ParentFont = False
    end

    object lblEURVarLbl: TLabel
      Left = 20
      Top = 206
      Width = 80
      Height = 17
      Caption = 'Variance'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblEURVar: TLabel
      Left = 180
      Top = 206
      Width = 160
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'EUR  0.00  ✓'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $005C8A00
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object shpEURStatus: TShape
      Left = 350
      Top = 210
      Width = 12
      Height = 12
      Brush.Color = clGreen
      Pen.Color = clGreen
      Shape = stCircle
    end

    { --- Divider --- }
    object bvlEURCards: TBevel
      Left = 12
      Top = 230
      Width = 368
      Height = 6
      Shape = bsTopLine
    end

    { ----- CHF CARDS SECTION ----- }

    object lblCardsTitle: TLabel
      Left = 12
      Top = 242
      Width = 376
      Height = 17
      AutoSize = False
      Caption = 'CHF Cards (terminal Z-total)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00707070
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
    end

    object lblCardExpLbl: TLabel
      Left = 20
      Top = 264
      Width = 80
      Height = 17
      Caption = 'Expected'
      Font.Color = $00505050
      ParentFont = False
    end

    object lblCardExp: TLabel
      Left = 220
      Top = 264
      Width = 120
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Mono'
      Font.Style = []
      ParentFont = False
    end

    object lblCardRefLbl: TLabel
      Left = 20
      Top = 290
      Width = 100
      Height = 17
      Caption = 'Z-total entered:'
      Font.Color = $00505050
      ParentFont = False
    end

    object edCardBatch: TEdit
      Left = 126
      Top = 286
      Width = 110
      Height = 25
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0.00'
      OnChange = edCardBatchChange
      OnKeyPress = edCardBatchKeyPress
    end

    { --- Grand total divider --- }
    object bvlGrand: TBevel
      Left = 12
      Top = 332
      Width = 368
      Height = 6
      Shape = bsTopLine
    end

    object lblGrandLbl: TLabel
      Left = 12
      Top = 344
      Width = 200
      Height = 20
      Caption = 'Total turnover (CHF equiv.)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00303030
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object lblGrandTotal: TLabel
      Left = 180
      Top = 344
      Width = 160
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CHF 0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00303030
      Font.Height = -14
      Font.Name = 'Segoe UI Mono'
      Font.Style = [fsBold]
      ParentFont = False
    end

    object lblDayRateNote: TLabel
      Left = 20
      Top = 370
      Width = 340
      Height = 15
      AutoSize = False
      Caption = 'EUR converted at today''s rate — informational only'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = $00909090
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
    end
  end

end
