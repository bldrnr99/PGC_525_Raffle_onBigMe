object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'PGC 5.0.0'
  ClientHeight = 810
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 496
    Top = 2
    Width = 541
    Height = 787
    ActivePage = TabSheet1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '*'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabWidth = 120
    object TabSheet1: TTabSheet
      Caption = 'CASSA'
      object Cl_LedgerDbGD: TDBGridEh
        Left = 3
        Top = 3
        Width = 527
        Height = 238
        DataSource = Cl_LedgerDS
        DynProps = <>
        FooterRowCount = 2
        IndicatorOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'DateTime'
            Footers = <>
            Title.Caption = 'Data'
            Width = 101
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Description'
            Footers = <>
            Title.Caption = 'Descrizione'
            Width = 247
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Dare'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Avere'
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object mmDetail: TMemo
        Left = 3
        Top = 248
        Width = 527
        Height = 89
        Color = clBlack
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'DetailMemo')
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
      end
      object FeeCtrlGd: TDBCtrlGrid
        Left = 3
        Top = 343
        Width = 527
        Height = 216
        AllowDelete = False
        AllowInsert = False
        ColCount = 3
        Color = clBlack
        DataSource = FeeDS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16759225
        Font.Height = -19
        Font.Name = 'Sansation Light'
        Font.Style = [fsBold]
        PanelWidth = 170
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        SelectedColor = 7697781
        OnPaintPanel = FeeCtrlGdPaintPanel
        object DBText1: TDBText
          Left = 8
          Top = 27
          Width = 153
          Height = 17
          Alignment = taCenter
          DataField = 'Description'
          DataSource = FeeDS
        end
      end
      object Button1: TButton
        Left = 8
        Top = 584
        Width = 163
        Height = 65
        Caption = 'Leggi Tessera'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Sansation'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Button2: TButton
        Left = 179
        Top = 584
        Width = 163
        Height = 65
        Caption = 'Registra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Sansation'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object Button3: TButton
        Left = 349
        Top = 584
        Width = 163
        Height = 65
        Caption = 'Button3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Sansation'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object cbLogOn: TCheckBox
        Left = 16
        Top = 672
        Width = 97
        Height = 17
        Caption = 'Log events'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object btnOpenPort: TButton
        Left = 3
        Top = 712
        Width = 161
        Height = 25
        Caption = 'btnOpenPort'
        TabOrder = 7
        OnClick = btnOpenPortClick
      end
      object Button4: TButton
        Left = 176
        Top = 712
        Width = 105
        Height = 25
        Caption = 'DoSingleScan'
        TabOrder = 8
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 304
        Top = 712
        Width = 75
        Height = 25
        Caption = 'Button5'
        TabOrder = 9
        OnClick = Button5Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Registrazioni'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
    end
    object TabSheet9: TTabSheet
      Caption = '*'
      ImageIndex = 3
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 791
    Width = 1039
    Height = 19
    Panels = <>
  end
  object RoomsDBGD: TDBGridEh
    Left = 4
    Top = 2
    Width = 490
    Height = 511
    DataSource = RoomsDS
    DynProps = <>
    IndicatorOptions = []
    OddRowColor = clInfoBk
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghExtendVertLines]
    RowDetailPanel.Active = True
    RowHeight = 20
    TabOrder = 2
    TitleParams.Font.Charset = DEFAULT_CHARSET
    TitleParams.Font.Color = clWindowText
    TitleParams.Font.Height = -13
    TitleParams.Font.Name = 'Tahoma'
    TitleParams.Font.Style = []
    TitleParams.ParentFont = False
    VertScrollBar.VisibleMode = sbNeverShowEh
    Columns = <
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'Nr.'
        Width = 30
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Available'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'OK'
        Width = 25
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Description'
        Footers = <>
        Title.Caption = 'Descrizione'
        Width = 93
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'LastEvent'
        Footers = <>
        Title.Caption = 'Ultimo evento'
        Width = 158
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Door'
        Footers = <>
        Title.Caption = 'Porta'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Light'
        Footers = <>
        Title.Caption = 'Luci'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Projector'
        Footers = <>
        Title.Caption = 'Faro'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Alarm'
        Footers = <>
        Title.Caption = 'Allarme'
        Width = 40
      end>
    object RowDetailData: TRowDetailPanelControlEh
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 113
        Height = 18
        Caption = 'ID ultimo utente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object DBText2: TDBText
        Left = 176
        Top = 16
        Width = 65
        Height = 17
        DataField = 'LastUserID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 24
        Top = 48
        Width = 137
        Height = 18
        Caption = 'ID penultimo utente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object DBText3: TDBText
        Left = 176
        Top = 48
        Width = 65
        Height = 17
        DataField = 'SecLastUserID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object PageControl3: TPageControl
    Left = 3
    Top = 517
    Width = 491
    Height = 272
    ActivePage = TabSheet7
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabWidth = 120
    object TabSheet7: TTabSheet
      Caption = 'Clienti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 483
        Height = 241
        Align = alClient
        DataSource = ClientsDS
        DynProps = <>
        IndicatorOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        RowDetailPanel.Active = True
        TabOrder = 0
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'ID'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'LastName'
            Footers = <>
            Title.Caption = 'Cognome'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'FirstName'
            Footers = <>
            Title.Caption = 'Nome'
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Tessere'
      ImageIndex = 1
      object DBGridEh2: TDBGridEh
        Left = 0
        Top = 0
        Width = 483
        Height = 241
        Align = alClient
        DataSource = CardsDS
        DynProps = <>
        IndicatorOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        Columns = <
          item
            Alignment = taCenter
            DynProps = <>
            EditButtons = <>
            FieldName = 'ID'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Tessera'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'ClientID'
            Footers = <>
            Title.Caption = 'ID utente'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Valid'
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object FeeDS: TDataSource
    DataSet = Form2.FeesTB
    Left = 976
    Top = 544
  end
  object RoomsDS: TDataSource
    DataSet = Form2.RoomsTB
    Left = 432
    Top = 464
  end
  object ClientsDS: TDataSource
    DataSet = Form2.ClientsTB
    Left = 408
    Top = 736
  end
  object Cl_LedgerDS: TDataSource
    DataSet = Form2.Cl_LedgerTB
    Left = 952
    Top = 216
  end
  object CardsDS: TDataSource
    DataSet = Form2.CardsTB
    Left = 408
    Top = 704
  end
end
