object dlg_NewClient: Tdlg_NewClient
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Registrazione nuova cliente'
  ClientHeight = 490
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowFrame
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 766
    Height = 353
    Hint = 'Et'#224' minima 18'
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 17
    Top = 274
    Width = 59
    Height = 16
    Caption = 'Cognome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 247
    Top = 274
    Width = 35
    Height = 16
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 442
    Top = 274
    Width = 97
    Height = 16
    Hint = 'Et'#224' minima 18'
    Caption = 'Data di nascit'#224
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object dbtxt_DlgClients: TDBText
    Left = 640
    Top = 176
    Width = 121
    Height = 17
    DataField = 'Alias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 442
    Top = 326
    Width = 23
    Height = 16
    Hint = 'Et'#224' minima 18'
    Caption = 'Et'#224':'
    ParentShowHint = False
    ShowHint = True
  end
  object Label5: TLabel
    Left = 8
    Top = 469
    Width = 656
    Height = 16
    Caption = 
      'IMPORTANTISSIMO: NON IMMETTERE DOPPIONI DI CLIENTI !  (stesso cl' +
      'iente pi'#249' volte con ID differente)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object OKBtn: TButton
    Left = 648
    Top = 293
    Width = 110
    Height = 25
    Hint = 'Cognome, nome e data di nascit'#224' devono essere completi'
    Default = True
    DisabledImageIndex = 23
    Enabled = False
    ImageIndex = 14
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 648
    Top = 324
    Width = 110
    Height = 25
    Cancel = True
    ImageIndex = 15
    ModalResult = 2
    TabOrder = 4
    OnClick = CancelBtnClick
  end
  object dbgd_DlgClients: TDBGridEh
    Left = 17
    Top = 27
    Width = 617
    Height = 241
    Hint = 'Scegli cliente esistente con doppio click'
    DataSource = sc_Clients
    DynProps = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghExtendVertLines]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TitleParams.Font.Charset = DEFAULT_CHARSET
    TitleParams.Font.Color = clWindowFrame
    TitleParams.Font.Height = -13
    TitleParams.Font.Name = 'Tahoma'
    TitleParams.Font.Style = [fsBold]
    TitleParams.ParentFont = False
    Columns = <
      item
        Alignment = taCenter
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Title.Alignment = taCenter
        Width = 46
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastName'
        Footers = <>
        Title.Caption = 'Cognome'
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'FirstName'
        Footers = <>
        Title.Caption = 'Nome'
        Width = 127
      end
      item
        Alignment = taCenter
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'BirthDate'
        Footers = <>
        Title.Caption = 'Data di nascit'#224
        Width = 108
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Alias'
        Footers = <>
        Title.Caption = 'Nome d'#39'arte'
        Width = 113
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dbimg_DlgClients: TJvDBImage
    Left = 640
    Top = 24
    Width = 121
    Height = 145
    DataField = 'Image'
    DataSource = sc_Clients
    Enabled = False
    Proportional = True
    TabOrder = 6
    Visible = False
  end
  object ed_DlgNC_LName: TEdit
    Left = 16
    Top = 296
    Width = 225
    Height = 24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = 'Cognome'
    OnChange = ed_DlgNC_LNameChange
    OnExit = ed_DlgNC_LNameExit
  end
  object ed_DlgNC_FName: TEdit
    Left = 247
    Top = 296
    Width = 189
    Height = 24
    TabOrder = 1
    TextHint = 'Nome'
    OnExit = ed_DlgNC_FNameExit
  end
  object DateTimePicker1: TDateTimePicker
    Left = 442
    Top = 296
    Width = 134
    Height = 24
    Date = 43762.000000000000000000
    Time = 0.710581840277882300
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = DateTimePicker1Change
  end
  object AdvMemo1: TAdvMemo
    Left = 8
    Top = 367
    Width = 766
    Height = 98
    Cursor = crIBeam
    ActiveLineSettings.ShowActiveLine = False
    ActiveLineSettings.ShowActiveLineIndicator = False
    AutoCompletion.Font.Charset = DEFAULT_CHARSET
    AutoCompletion.Font.Color = clWindowText
    AutoCompletion.Font.Height = -11
    AutoCompletion.Font.Name = 'Tahoma'
    AutoCompletion.Font.Style = []
    AutoCompletion.StartToken = '(.'
    AutoCorrect.Active = True
    AutoHintParameterPosition = hpBelowCode
    BkColor = clWindow
    BookmarkGlyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFD25252525
      2525252525252525FDFDFD2E25FFFFFFFFFFFFFFFFFFFF25FDFDFD2525252525
      2525252525252525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25B7B7B7B7
      B7B7B7B7B7B72525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25BFB7BFBF
      B7B7B7B7B7B72525FDFD9A9ABFBFBFB7BFBFB7B7B7B72525FDFDFD25BFBFBFBF
      BFB7BFBFB7B72525FDFD9A9ABFBFBFB7BFBFBFB7BFB72525FDFDFD25BFBFBFBF
      BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFB7BFBFB7B72525FDFDFD25BFBFBFBF
      BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFBFBFBFBFB725FDFDFDFD2525252525
      25252525252525FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
    BorderStyle = bsSingle
    ClipboardFormats = [cfText]
    CodeFolding.Enabled = False
    CodeFolding.LineColor = clGray
    Ctl3D = False
    DelErase = True
    Enabled = False
    EnhancedHomeKey = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -13
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.GutterWidth = 25
    Gutter.GutterColorTo = clBtnFace
    Gutter.LineNumberTextColor = clWindowText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    HiddenCaret = False
    Lines.Strings = (
      'Immetti il cognome nel campo.'
      
        'Se la cliente esiste gi'#224' nel database sceglila con un doppio cli' +
        'ck.'
      
        'Se si tratta di una nuova cliente compila tutti i campi e confer' +
        'ma con OK. (Et'#224' minima deve essere '
      '18 anni) '
      
        'La finestra REGISTRAZIONE NUOVA CLIENTE si chiuder'#224' e potrai com' +
        'pletare i dati.')
    MarkerList.UseDefaultMarkerImageIndex = False
    MarkerList.DefaultMarkerImageIndex = -1
    MarkerList.ImageTransparentColor = 33554432
    OleDropTarget = []
    PrintOptions.MarginLeft = 0
    PrintOptions.MarginRight = 0
    PrintOptions.MarginTop = 0
    PrintOptions.MarginBottom = 0
    PrintOptions.PageNr = False
    PrintOptions.PrintLineNumbers = False
    RightMargin = 100
    RightMarginColor = 14869218
    ScrollHint = False
    SelColor = clHighlightText
    SelBkColor = clHighlight
    ShowRightMargin = True
    SmartTabs = False
    TabOrder = 7
    TabStop = True
    TrimTrailingSpaces = False
    UILanguage.ScrollHint = 'Row'
    UILanguage.Undo = 'Undo'
    UILanguage.Redo = 'Redo'
    UILanguage.Copy = 'Copy'
    UILanguage.Cut = 'Cut'
    UILanguage.Paste = 'Paste'
    UILanguage.Delete = 'Delete'
    UILanguage.SelectAll = 'Select All'
    UrlStyle.TextColor = clBlue
    UrlStyle.BkColor = clWhite
    UrlStyle.Style = [fsUnderline]
    UseStyler = True
    Version = '3.9.1.5'
    WordWrap = wwRightMargin
  end
  object DBGridEh1: TDBGridEh
    Left = 352
    Top = 176
    Width = 300
    Height = 120
    DynProps = <>
    TabOrder = 8
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object sc_Clients: TDataSource
    DataSet = Form2.tb_Clients
    Left = 680
    Top = 240
  end
end
