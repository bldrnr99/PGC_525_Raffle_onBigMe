{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
// PGC 522 EXP (Started Sunday 27/07/2022)
// Main difference to former versions: OpLedger suppression
// CC1 30/01/23

{ GRUPPI DI TESSERE
  ------------------
  1000 - 2999 = Clienti passanti
  3000 - 6999 = Clienti fissi
  7000 - 7999 = Prepagati
  8000 - 8999 = Riservato per futuro uso (VIP, ecc)
  9000 - 9999 = Gestione (Gerenti, cassieri, pulizia)
}

UNIT Main;

INTERFACE

USES
  Windows,
  RichEdit,
  Winapi.Messages,
  WinSpool,
  Winsock,
  Types,
  Vcl.Controls,
  System.SysUtils,
  System.DateUtils,
  System.Math,
  System.UITypes,
  System.Variants,
  System.RegularExpressions,
  System.Generics.Defaults,
  Registry,
  System.Classes,
  Vcl.Graphics,
  Vcl.Imaging.jpeg,
  ComObj, ActiveX,
  System.IOUtils,
  System.Generics.Collections,
  Vcl.Dialogs,
  Vcl.Clipbrd,
  Vcl.StdCtrls,
  Buttons,
  Grids,
  System.AnsiStrings,
  Vcl.Printers,
  TagC32,
  Vcl.ComCtrls,
  smcInterproc,
  Data.DB,
  Vcl.DBCtrls,
  Vcl.DBCGrids,
  DBGridEhGrouping,
  ToolCtrlsEh,
  DBGridEhToolCtrls,
  DynVarsEh,
  GridsEh,
  DBAxisGridsEh,
  DBGridEh,
  Vcl.ImgList,
  Vcl.ExtCtrls,
  MgM_LanHal,
  OoMisc,
  OtlCommon,
  OtlComm,
  OtlTask,
  OtlTaskControl,
  OtlEventMonitor,
  AdPort,
  Vcl.Mask,
  DBCtrlsEh,
  DBVertGridsEh,
  Vcl.ExtDlgs,
  iniFiles,
  Vcl.Touch.GestureMgr,
  Gestures,
  Vcl.Imaging.pngimage,
  DBLookupEh,
  adselcom,
  DBlogDlg,
  AdPacket,
  Vcl.CategoryButtons,
  ShellApi,
  TlHelp32,
  DBSumLst,
  Vcl.Menus,
  AdvSmoothPanel,
  AdvSmoothCalendarGroup,
  mmsystem,
  AdvSmoothCalendar,
  // u_USB,
  System.StrUtils,
  // Indy
  // ----------------------------------------------
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP,
  IdEMailAddress, IdGlobal, IdAttachmentFile,
  IdHTTP, ipwhtmlmailer,
  IdUserPassProvider, IdException, IdStack,
  ipwcore, ipwtypes,
  uClientStore,
  uWriteCashierDisplay,
  JvExStdCtrls, JvMemo, JvThread, JvComponentBase,
  JvExExtCtrls, JvImage, JvExtComponent, JvClock, JvMenus,
  JvExComCtrls, JvExMask, JvDBImage, JvTimer,
  JvMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit,
  JvDBControls, JvTimerList, JvExGrids, JvStringGrid,
  JvThreadTimer, JvCheckedMaskEdit, JvAppInst, JvToolEdit,
  JvRadioGroup, JvDBCheckBox, JvLabel, JvSpin,
  JvLED, JvXPCore, JvXPCheckCtrls, JvExControls, JvBehaviorLabel, JvImageList,

  Vcl.Samples.Spin, AdvSmoothMessageDialog, AdvSmoothTabPager, frxClass,
  frxDBSet, edbcomps, frxExportPDF, DelphiTwain, DelphiTwain_Vcl,
  GIFImg, frxExportBaseDialog, System.ImageList,
  Vcl.DBGrids,

  dblucomb, PrnDbgeh,
  Vcl.WinXPickers, frxRich,
  BaseGrid,
  DBAdvOfficeButtons, AdvGrid, AdvCGrid, AdvEdit, DBAdvEd, advlued, DBAdvLe,
  AdvGroupBox, AdvUtil, AdvObj, AdvGlassButton, AdvBadge,
  PlannerCal, AdvFontCombo, DBAdvOfficeComboBox,
  AdvRichEditorBase, AdvRichEditor, AdvToolBar, AdvToolBarExt,
  AdvRichEditorToolBar, AdvAlertWindow, AdvSmoothPopup,
  AdvDropDown, AdvControlDropDown,
  DBAdvControlDropDown, MoneyEdit, AdvMenus,
  AdvTimePickerDropDown,
  AdvTreeViewBase, AdvTreeViewData, AdvCustomTreeView, AdvTreeView,
  AdvCheckedTreeView, AdvEdBtn, PlannerDatePicker, frxExportText,
  AdvLabel, DBAdvLabel,
  AdvSmoothSlider, DBAdvSmoothSlider, Vcl.WinXCtrls, AdvOfficeButtons,
  AdvSmoothLabel, DBAdvSmoothLabel, AdvDBDataLabel, Vcl.OleServer,
  AdvCombo, AdvSmoothLedLabel,
  AdvSmoothToggleButton,
  AdvCheckTreeView,
  AdvSmoothStepControl, Vcl.WinXCalendars, Vcl.FileCtrl, MultiMon,
  System.JSON,
  System.Net.HttpClient, System.Net.HttpClientComponent, ipwhttp,
  FlCtrlEx, RzEdit,
  Vcl.WinXPanels,

  Xml.XMLIntf, Xml.XMLDoc,

  RzDBChk, RzPanel, RzRadGrp, RzDBRGrp, RzDBNav, RzButton,
  RzRadChk, RzSpnEdt, RzDBEdit, RzDBSpin, RzDBList, RzLstBox,
  RzGrids, AdvMemo, DBAdvMemo, AdvScrollControl,
  JvSpeedButton, JvCombobox, JvColorCombo, AdvOfficeComboBox,
  AdvListBox, AdvDBListBox, RzSplit, JvDesignSurface, AdvDBComboBox,
  Vcl.ExtActns, System.Actions, Vcl.ActnList, JvAppStorage, JvAppIniStorage,
  frCoreClasses, EhLibVclUtils, RzStatus, Barcode, CurvyControls,
  DBAdvRichEditor, DBAdvGlowNavigator, AdvRichEditorPopupToolBar,
  AdvToolBarStylers, Vcl.Forms, AdvRichEditorIO, DBAdvRichEditorRTFIO, RzBtnEdt,
  AdvMultiButtonEdit, AdvRichEditorFormatButtonBar, AdvCustomComponent,
  AdvPDFIO, AdvRichEditorPDFIO, DBAdvNavigator, RzListVw, AdvListV,
  JvListView, JvDBRichEdit, JvRichEdit, PivotGridToolsEh, SpreadGridsEh,
  PivotGridsEh, JvBaseDlg, JvSelectDirectory, System.Net.URLClient,
  IdServerIOHandler, TaskDialog, TaskDialogEx, JvProgressBar, AdvGridToolbar,
  AdvRichEditorEditLink, JvRegistryTreeview, AdvShapeButton, JvFormTransparent,
  AdvToggle, InspectorBar, INIInspectorBar, Vcl.NumberBox, IdIcmpClient,
  RzDBGrid, IdExceptionCore, AdvPanel;

CONST
  // tamaño maximo de los buffers
  // modificamos esto pues tambien se hizo en MikroPascal
  BufferInSize = 16;
  BufferOutSize = 16;

TYPE
  // buffers de envio y recepcion
  TBufferIn = ARRAY [0 .. BufferInSize] OF byte;
  TBufferOut = ARRAY [0 .. BufferOutSize] OF byte;
  HMONITOR = THandle;
  PHDC = ^HDC;

  // TYPE
  // TMonitorEnumFunc = FUNCTION(HMONITOR: HMONITOR; hdcMonitor: HDC;
  // lprcMonitor: PRect; dwData: LPARAM): LongBool; STDCALL;
type
  TRaffleCheck = (rcValid, rcInvalid, rcAlreadyPrinted);

TYPE
  TForm1 = CLASS(TForm)
    GestureManager1: TGestureManager;
    MGuardClient1: TMGuardClient;
    il_Buttons: TImageList;
    RoomClean: TImageList;
    il_dbgdRooms: TImageList;
    sc_Tessere_Cards: TDataSource;
    sc_Fees: TDataSource;
    sc_Cassa_Services: TDataSource;
    mn_ClientiClients: TPopupMenu;
    sc_CardsCategories: TDataSource;
    sc_Clienti_SS: TDataSource;
    mn_Cassa_Services: TPopupMenu;
    Resetsingolastanza1: TMenuItem;
    ControllaSingolastanza1: TMenuItem;
    Controllatuttelestanze1: TMenuItem;
    Mostrasoloclientiincasa1: TMenuItem;
    Mostratutti1: TMenuItem;
    sc_Personale_Personnel: TDataSource;
    sc_Personale_PerHis: TDataSource;
    sc_Cassa_SS: TDataSource;
    sc_Manut_Services: TDataSource;
    sc_Manut_SMaintenance: TDataSource;
    il_General: TImageList;
    sc_AdminServices_SS: TDataSource;
    sc_AdminServices_Clients: TDataSource;
    frxReport2: TfrxReport;
    OpenDialog1: TOpenDialog;
    BalloonHint1: TBalloonHint;
    frxDBDataset1: TfrxDBDataset;
    frxReportTESEU: TfrxReport;
    frxDBDatasetTeseu1: TfrxDBDataset;
    frxDBDatasetTeseu2: TfrxDBDataset;
    frxDBDatasetTaxes: TfrxDBDataset;
    Tax_SumList: TDBSumList;
    frxDBDatasetTeseu3: TfrxDBDataset;
    frxDBDataset_CostCenter: TfrxDBDataset;
    frxReportTaxGirlMonth: TfrxReport;
    frxReport3: TfrxReport;
    frxReport1: TfrxReport;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    tm_RR_Charge: TTimer;
    tm_List: TJvTimerList;
    sc_Permissions: TDataSource;
    tm_ExpiredFeesReset: TJvThreadTimer;
    popup_BarOpLedger: TAdvSmoothPopup;
    popup_SoldByEdit: TAdvSmoothPopup;
    frxDBDataset2: TfrxDBDataset;
    frxDBDataset4: TfrxDBDataset;
    mn_OpLedger: TAdvPopupMenu;
    InordinediData1: TMenuItem;
    AdvMenuStyler1: TAdvMenuStyler;
    N1: TMenuItem;
    InordinediData2: TMenuItem;
    InordinediRegistrazione1: TMenuItem;
    inordinediIDClienti1: TMenuItem;
    Stornaregistrazione1: TMenuItem;
    frxPDFExport1: TfrxPDFExport;
    frxDBDataset5: TfrxDBDataset;
    sc_OTab: TDataSource;
    Solochidormedanoi1: TMenuItem;
    scq_frxClOpLedger: TDataSource;
    ds_frxClOpLedger: TfrxDBDataset;
    scqy_gPec: TDataSource;
    Mostrasolouscitesenzaricevuta1: TMenuItem;
    Mostratutto1: TMenuItem;
    im_CheckBoxey: TImageList;
    IdHTTP1: TIdHTTP;
    FontDialog1: TFontDialog;
    JvPopupMenu1: TJvPopupMenu;
    Caricafoto1: TMenuItem;
    Eliminafoto1: TMenuItem;
    il_CliCards: TJvImageList;
    popmn_BonMal: TAdvPopupMenu;
    Assegnaa1: TMenuItem;
    popmn_ClientiClients: TJvPopupMenu;
    SoloPresenticompresoinresidenza1: TMenuItem;
    utte1: TMenuItem;
    tht_RRBlink: TJvThreadTimer;
    tht_CheckPresence: TJvThreadTimer;
    JvAppIniFileStorage1: TJvAppIniFileStorage;
    OpenPictureDialog1: TOpenPictureDialog;
    DBSumList1: TDBSumList;
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzGlyphStatus1: TRzGlyphStatus;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane6: TRzStatusPane;
    scEH_FeeE: TDataSource;
    scEH_BonMalFees: TDataSource;
    scEH_Clienti_Clients: TDataSource;
    OmniEventMonitor1: TOmniEventMonitor;
    DBAdvRichEditorRTFIO1: TDBAdvRichEditorRTFIO;
    JvImageList1: TJvImageList;
    JvSelectDirectory1: TJvSelectDirectory;
    Barcode1: TBarcode;
    ipwHTMLMailer1: TipwHTMLMailer;
    NetHTTPClient1: TNetHTTPClient;
    jvtm_RefreshCassaServices: TJvThreadTimer;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    AdvInputTaskDialogEx1: TAdvInputTaskDialogEx;
    tm_Closing: TJvThreadTimer;
    AdvRichEditorEditLink1: TAdvRichEditorEditLink;
    qysc_PecuniaComments: TDataSource;
    DBSumList2: TDBSumList;
    thtm_BarRT: TJvThreadTimer;
    th_XchangeR: TJvThread;
    MainMenu1: TMainMenu;
    thtm_Login: TJvThreadTimer;
    Caricafotodascanner1: TMenuItem;
    JvPopupMenu2: TJvPopupMenu;
    CreaTessera1: TMenuItem;
    Eliminatessera1: TMenuItem;
    SoloRecenti1: TMenuItem;
    JvThread1: TJvThread;
    pc_MainPageC: TAdvSmoothTabPager;
    pc_Cashier_Page: TAdvSmoothTabPage;
    DBText5: TDBText;
    Label173: TLabel;
    lb_Tabs: TLabel;
    Label9: TLabel;
    bt_pdRefresh: TImage;
    Image7: TImage;
    pl_KeyBoardCover: TPanel;
    JvImage1: TJvImage;
    DBAdvLabel1: TDBAdvLabel;
    pl_KeyboardError: TPanel;
    Panel1: TPanel;
    bt_Login: TAdvGlassButton;
    ed_LogInPwd: TCurvyEdit;
    dbgd_InRoom: TDBGridEh;
    pl_MainButtons: TPanel;
    bt_CancelAll: TAdvGlassButton;
    bt_Read: TAdvGlassButton;
    bt_Register: TAdvGlassButton;
    cg_CashierKeyboard: TDBCtrlGrid;
    db_FeeTxt: TDBText;
    img_Fee: TJvDBImage;
    bt_CH: TAdvGlassButton;
    bt_EU: TAdvGlassButton;
    bt_CC: TAdvGlassButton;
    bt_PD: TAdvGlassButton;
    bt_OF: TAdvGlassButton;
    bt_Cancel: TAdvGlassButton;
    bt_RR_Rooms: TAdvGlassButton;
    bt_Calculator: TAdvGlassButton;
    bt_Receipt_: TAdvGlassButton;
    bt_MultiReg: TAdvGlassButton;
    dbgd_TabNow: TDBGridEh;
    dbgd_TabsOpen: TDBGridEh;
    dbgd_PagaDopo: TDBGridEh;
    dbgd_CashierDisplay: TDBGridEh;
    DBText1: TDBText;
    Label14: TLabel;
    DBNumberEditEh3: TDBNumberEditEh;
    BitBtn7: TBitBtn;
    mm_Cashier: TAdvStringGrid;
    dbgd_Rooms: TDBGridEh;
    ts_EuroXchange: TAdvToggleSwitch;
    pl_TestDataButtons: TPanel;
    Label82: TLabel;
    Label87: TLabel;
    bt_alarm: TButton;
    Button1: TButton;
    Button10: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button17: TButton;
    ed_cCard: TDBNumberEditEh;
    pc_Fees_Page: TAdvSmoothTabPage;
    Shape1: TShape;
    Label78: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label32: TLabel;
    img_QRcode: TJvImage;
    Shape10: TShape;
    StackPanel1: TStackPanel;
    AdvGlassButton5: TAdvGlassButton;
    bt_ExpandCat: TAdvGlassButton;
    dbimg1_Keyboard: TDBImage;
    dbVgd_FeesEdit: TDBVertGridEh;
    dbgd_FeesEdit: TDBCtrlGrid;
    dbgd_FEText: TDBText;
    nav_FeesEdit: TRzDBNavigator;
    ed_QR_Size: TDBNumberEditEh;
    btn_Help_PosTicket: TAdvGlassButton;
    bt_FeeHelp: TAdvGlassButton;
    bt_TestPosTicket: TRzButtonEdit;
    advSTP_FeeEdit: TAdvSmoothTabPager;
    AdvSmoothTabPage5: TAdvSmoothTabPage;
    Label2: TLabel;
    Label3: TLabel;
    RzDBNavigator2: TRzDBNavigator;
    RzDBNavigator3: TRzDBNavigator;
    db_RTEditor: TDBAdvRichEditor;
    AdvRichEditorFormatToolBar1: TAdvRichEditorFormatToolBar;
    dbgd_Pos_T: TDBCtrlGrid;
    dblb_PosTxtID: TDBText;
    DBMemo2: TDBMemo;
    dbgd_placeholders: TDBGridEh;
    DBText6: TDBText;
    Label16: TLabel;
    DBEditEh2: TDBEditEh;
    AdvGlassButton1: TAdvGlassButton;
    AdvGlassButton6: TAdvGlassButton;
    AdvSmoothTabPage6: TAdvSmoothTabPage;
    Label12: TLabel;
    B_printImage: TJvImage;
    dbgd_PosImages: TDBCtrlGrid;
    DBText4: TDBText;
    dbimg_Body: TJvDBImage;
    DBEdit1: TDBEdit;
    dbrg_PosImageFormat: TRzRadioGroup;
    AdvGlassButton3: TAdvGlassButton;
    RzDBNavigator5: TRzDBNavigator;
    AdvSmoothTabPage3: TAdvSmoothTabPage;
    Label49: TLabel;
    Label50: TLabel;
    Label59: TLabel;
    bt_edFeesHelp: TAdvGlassButton;
    dbimg2_Keyboard: TJvDBImage;
    DBMemoEh1: TDBMemoEh;
    RzDBNavigator4: TRzDBNavigator;
    ed_tID: TDBNumberEditEh;
    ed_tSubID: TDBNumberEditEh;
    bt_ExpandFees: TAdvGlassButton;
    dbgd_Fees_Edit: TDBGridEh;
    DBImage2: TJvDBImage;
    pc_Settings_Page: TAdvSmoothTabPage;
    Label206: TLabel;
    pc_SettingDetailPage: TAdvSmoothTabPager;
    pg_PrintSettings: TAdvSmoothTabPage;
    Label208: TLabel;
    Label154: TLabel;
    Label216: TLabel;
    Image2: TImage;
    Label232: TLabel;
    Label196: TLabel;
    imgLotteryT: TJvImage;
    Label237: TLabel;
    Label212: TLabel;
    Label294: TLabel;
    Label107: TLabel;
    Label159: TLabel;
    Label337: TLabel;
    Label70: TLabel;
    Label112: TLabel;
    ed_nrLfCopies: TSpinEdit;
    rg_Printers: TRadioGroup;
    Memo2: TMemo;
    ed_ScannerFileName: TEdit;
    ed_LotteryT: TEdit;
    ed_PrinterSleepTm: TSpinEdit;
    cb_settings_PrintCB: TJvXPCheckbox;
    cb_PrintCleaningInfo: TJvXPCheckbox;
    Edit1: TEdit;
    ed_PrinterName: TEdit;
    rg_Scanners: TRadioGroup;
    pg_Cassa_Settings: TAdvSmoothTabPage;
    Panel5: TPanel;
    pl_Settings3: TPanel;
    Label230: TLabel;
    Label277: TLabel;
    Label274: TLabel;
    Label200: TLabel;
    Label8: TLabel;
    Label146: TLabel;
    Label199: TLabel;
    Label308: TLabel;
    Label309: TLabel;
    Label140: TLabel;
    Label18: TLabel;
    Label72: TLabel;
    Label117: TLabel;
    ed_Inact_LogOut: TDBNumberEditEh;
    cb_Check_ClientDataInput: TCheckBox;
    ed_MaxOffered: TDBNumberEditEh;
    ed_maxTmeDisc: TSpinEdit;
    ed_BalanceReminder: TDBNumberEditEh;
    cb_MultiDebitSameClient: TCheckBox;
    cb_QRReader: TCheckBox;
    ed_ResetRoomMinSpan: TDBNumberEditEh;
    cb_RoomReset: TCheckBox;
    ed_StartDateClosingCheck: TDateTimePicker;
    cb_Testdata_: TCheckBox;
    Edit2: TEdit;
    ed_ImgDir: TJvDirectoryEdit;
    ed_FreqContrFondiCassa: TDBNumberEditEh;
    ckb_verifyPermit: TCheckBox;
    pl_Settings2: TPanel;
    Label156: TLabel;
    Label58: TLabel;
    Label144: TLabel;
    Shape61: TShape;
    Shape64: TShape;
    lb_Last_ER_Date: TLabel;
    Label102: TLabel;
    Label211: TLabel;
    lb_commission: TLabel;
    Label235: TLabel;
    Label234: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    Label139: TLabel;
    Label194: TLabel;
    Label330: TLabel;
    Label71: TLabel;
    ed_ExchangeRate: TDBNumberEditEh;
    ed_DeltaEuroMargin: TDBNumberEditEh;
    rg_CommissionCC: TRadioGroup;
    ed_CcCommissionAmt: TDBNumberEditEh;
    ed_VatTax: TDBNumberEditEh;
    cb_AutomaticCheckOut: TCheckBox;
    cb_CollectTaxes: TCheckBox;
    ed_DailyTaxAmt: TDBNumberEditEh;
    ed_nrTaxRecCopies: TDBNumberEditEh;
    ed_tmPrntTeseuList: TDateTimePicker;
    clk_TeseuCkOut: TJvClock;
    ed_amtMarchetta: TDBNumberEditEh;
    ed_minSaleAmtMVat: TDBNumberEditEh;
    cb_PrntTeseuList: TCheckBox;
    ed_DeltaClosingAmt: TDBNumberEditEh;
    cb_VatTax: TCheckBox;
    BtnFetchRates: TButton;
    MemoRates: TMemo;
    ed_EuroRate: TDBNumberEditEh;
    pl_Settings1: TPanel;
    Label165: TLabel;
    Label148: TLabel;
    Label256: TLabel;
    Label257: TLabel;
    Label134: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label60: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    Label226: TLabel;
    Label227: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label163: TLabel;
    Label218: TLabel;
    Label210: TLabel;
    Label103: TLabel;
    lb_LstFeeResetDT: TLabel;
    Label30: TLabel;
    ed_CompanyName: TEdit;
    ed_TaxNo: TEdit;
    ed_Manager: TEdit;
    ed_OT_Mon: TDateTimePicker;
    ed_CT_Mon: TDateTimePicker;
    ed_CT_Tue: TDateTimePicker;
    ed_CT_Wed: TDateTimePicker;
    ed_CT_Thu: TDateTimePicker;
    ed_CT_Fri: TDateTimePicker;
    ed_CT_Sat: TDateTimePicker;
    ed_CT_Sun: TDateTimePicker;
    ed_OT_Sun: TDateTimePicker;
    ed_OT_Sat: TDateTimePicker;
    ed_OT_Fri: TDateTimePicker;
    ed_OT_Thu: TDateTimePicker;
    ed_OT_Wed: TDateTimePicker;
    ed_OT_Tue: TDateTimePicker;
    ed_TimePopUp: TDateTimePicker;
    cb_internetOff: TCheckBox;
    ed_sDt: TDateTimePicker;
    ed_eDt: TDateTimePicker;
    Panel2: TPanel;
    Label13: TLabel;
    Label20: TLabel;
    Label33: TLabel;
    ed_NotEmail: TEdit;
    ed_NotPwd: TEdit;
    Button24: TButton;
    Button23: TButton;
    AdvGlassButton2: TAdvGlassButton;
    pg_Room_Settings: TAdvSmoothTabPage;
    Panel6: TPanel;
    Label86: TLabel;
    Label84: TLabel;
    Label55: TLabel;
    Label85: TLabel;
    Label125: TLabel;
    Label129: TLabel;
    Label172: TLabel;
    Label166: TLabel;
    Label207: TLabel;
    Label108: TLabel;
    Label185: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    ed_MarkRedAfterUse: TSpinEdit;
    ed_Minutes2ChangeRoom: TSpinEdit;
    ed_GraceMinutes: TSpinEdit;
    ed_tmLmtCnclRmReg: TSpinEdit;
    ed_MultiplyFee: TDBNumberEditEh;
    ed_OvtMoneyThrsHld: TSpinEdit;
    cb_PrintRoomUse: TCheckBox;
    ed_TimeUsed: TSpinEdit;
    cb_HowLongInRoom: TCheckBox;
    rg_TowelFee: TJvRadioGroup;
    Panel15: TPanel;
    Label222: TLabel;
    Label307: TLabel;
    Label54: TLabel;
    sw_RRDeposit: TToggleSwitch;
    ed_DepDifferito: TSpinEdit;
    ed_MinReservDays: TSpinEdit;
    DBNavigator2: TDBNavigator;
    sw_RRLongRatePmt: TToggleSwitch;
    pg_Interface_Settings: TAdvSmoothTabPage;
    Panel7: TPanel;
    Label83: TLabel;
    Label124: TLabel;
    Label126: TLabel;
    Label135: TLabel;
    Label35: TLabel;
    cb_SoundSwitch: TCheckBox;
    rg_AlarmSoundFiles: TRadioGroup;
    cb_settings_SS: TCheckBox;
    bt_CheckAlarmSounf: TButton;
    cb_pcTimeVSlstRegTime: TCheckBox;
    bt_StopAlarmSound: TButton;
    ed_DatabaseName: TEdit;
    cbShowSecondaryMonitors: TCheckBox;
    DBGridEh2: TDBGridEh;
    DBRichEditEh1: TDBRichEditEh;
    DBRichEditEh2: TDBRichEditEh;
    pg_ComPorts_Settings: TAdvSmoothTabPage;
    Shape12: TShape;
    Label123: TLabel;
    Label121: TLabel;
    Label120: TLabel;
    Label145: TLabel;
    Label147: TLabel;
    Label1: TLabel;
    Label269: TLabel;
    Label270: TLabel;
    Label271: TLabel;
    lb_HostName: TLabel;
    Label272: TLabel;
    Label273: TLabel;
    Label75: TLabel;
    led_MG_Client: TJvLED;
    led_MG_Server: TJvLED;
    Label321: TLabel;
    Label322: TLabel;
    ed_TagReaderPort: TSpinEdit;
    ed_Display2Port: TSpinEdit;
    ed_Display1Port: TSpinEdit;
    lb_ComPorts: TListBox;
    ed_RemoteAddress: TEdit;
    ed_RemoteHostName: TEdit;
    ed_RemotePort: TDBNumberEditEh;
    cb_BCScanner: TAdvOfficeCheckBox;
    pg_Mail_Settings: TAdvSmoothTabPage;
    CurvyPanel1: TCurvyPanel;
    Label320: TLabel;
    Label122: TLabel;
    Label289: TLabel;
    Label288: TLabel;
    Label149: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    Label205: TLabel;
    Label105: TLabel;
    Label45: TLabel;
    lb_mailEmsg: TLabel;
    Label285: TLabel;
    lb: TLabel;
    rg_LogToMailFile: TAdvOfficeRadioGroup;
    bt_TestText: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    mm_LogFile: TRzMemo;
    cbg_SendMailCriteria: TAdvOfficeCheckGroup;
    ed_AssVatPwd: TEdit;
    ed_Subject: TEdit;
    ed_message: TEdit;
    ed_aHost: TEdit;
    ed_aUser: TEdit;
    ed_aPwd: TEdit;
    ed_FromAddr: TEdit;
    ed_ToAddr: TEdit;
    ed_CcAddr: TEdit;
    ed_eMsg: TEdit;
    cb_SSL: TAdvOfficeCheckBox;
    bt_TestMail: TButton;
    ed_PortNo: TDBNumberEditEh;
    ed_LastRCMailDate: TDBDateTimeEditEh;
    CurvyPanel2: TCurvyPanel;
    DBGridEh1: TDBGridEh;
    AdvSmoothTabPage1: TAdvSmoothTabPage;
    Label281: TLabel;
    Label279: TLabel;
    lb_monCount: TLabel;
    lb_ShowAdsMonID: TLabel;
    Label280: TLabel;
    Label282: TLabel;
    Label258: TLabel;
    Label284: TLabel;
    Label283: TLabel;
    lb_imDir: TLabel;
    im_AdImage: TJvImage;
    im_AdAssImage: TJvImage;
    Label255: TLabel;
    Shape33: TShape;
    Shape32: TShape;
    Shape34: TShape;
    Shape35: TShape;
    FileListBox2: TFileListBox;
    DBVertGridEh1: TDBVertGridEh;
    cb_posSelimg: TRzCheckBox;
    cb_Mon_3: TRzCheckBox;
    cb_Mon_2: TRzCheckBox;
    cb_DefaultImg: TRzCheckBox;
    ed_DefMonImg_V: TJvFilenameEdit;
    ed_DefMonImg_H: TJvFilenameEdit;
    RR_Abitazioni: TAdvSmoothTabPage;
    Label62: TLabel;
    Label66: TLabel;
    Label68: TLabel;
    dbgd_Buildings: TDBGridEh;
    dbgd_RoomsD: TDBGridEh;
    DBNavigator5: TDBNavigator;
    dbVgd_Booking: TDBVertGridEh;
    CurvyPanel4: TCurvyPanel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label31: TLabel;
    ed_MaxRoomRateDays: TDBNumberEditEh;
    ed_MaxInterruptDays: TDBNumberEditEh;
    ed_LastCheckOutTime: TDateTimePicker;
    pc_Admin_Page: TAdvSmoothTabPage;
    pc_Admin: TAdvSmoothTabPager;
    pc_Personnel_Page: TAdvSmoothTabPage;
    DBGridEh4: TDBGridEh;
    Panel8: TPanel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label100: TLabel;
    Label162: TLabel;
    Label150: TLabel;
    Label169: TLabel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    dbed_Pwd: TDBEdit;
    DBCheckBox13: TDBCheckBox;
    DBDateTimeEditEh11: TDBDateTimeEditEh;
    DBDateTimeEditEh12: TDBDateTimeEditEh;
    DBEdit36: TDBEdit;
    DBNumberEditEh13: TDBNumberEditEh;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBEdit7: TDBEdit;
    DBGridEh7: TDBGridEh;
    DBNavigator6: TDBNavigator;
    Panel9: TPanel;
    Label101: TLabel;
    DBText10: TDBText;
    DBMemo1: TDBMemo;
    Panel13: TPanel;
    Label151: TLabel;
    Label184: TLabel;
    Label261: TLabel;
    Label265: TLabel;
    Label262: TLabel;
    Label99: TLabel;
    DBGridEh18: TDBGridEh;
    DBNavigator8: TDBNavigator;
    gd_ClubPermissions: TDBGridEh;
    ed_LoginTimeOut: TDBNumberEditEh;
    pc_Clients_Page: TAdvSmoothTabPage;
    Shape3: TShape;
    lb_CardReadResult: TJvBehaviorLabel;
    Shape4: TShape;
    dbg_Clienti_Clients: TDBGridEh;
    dbVgd_Clienti_Clients: TDBVertGridEh;
    img_ClientiClients: TJvDBImage;
    tp_AdminClientsAccounting: TAdvSmoothTabPager;
    tp_A: TAdvSmoothTabPage;
    dbgd_AdminClientsSS: TDBGridEh;
    tp_B: TAdvSmoothTabPage;
    dbgd_AdminClientsSoldBy: TDBGridEh;
    AdvSmoothTabPage7: TAdvSmoothTabPage;
    dbgd_Presence: TRzDBGrid;
    cal_Clients: TAdvSmoothCalendar;
    RzDBNavigator1: TRzDBNavigator;
    ed_ClCardID: TDBNumberEditEh;
    dbgClientHist: TDBGridEh;
    RzDBNavigator6: TRzDBNavigator;
    pc_Cards_Page: TAdvSmoothTabPage;
    DBGridEh3: TDBGridEh;
    DBNavigator3: TDBNavigator;
    Panel3: TPanel;
    Label64: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    bt_AddCardRecords: TButton;
    cb_CardsOK: TCheckBox;
    rg_CardEditChoice: TRadioGroup;
    ed_FromCardID: TSpinEdit;
    ed_ToCardID: TSpinEdit;
    cb_CardDescription1: TComboBox;
    Panel4: TPanel;
    Label63: TLabel;
    Label65: TLabel;
    Label67: TLabel;
    lb_CardEDate: TLabel;
    lb_ErrorMsg: TLabel;
    Label69: TLabel;
    bt_ReadCard: TButton;
    bt_WriteCard: TButton;
    cb_IncrementCardID: TCheckBox;
    ed_CardID: TSpinEdit;
    cb_AddCardToDB: TCheckBox;
    ed_ClientID: TSpinEdit;
    MemoLog: TMemo;
    DBGridEh8: TDBGridEh;
    DBNavigator4: TDBNavigator;
    DBGridEh14: TDBGridEh;
    pc_Services_Page: TAdvSmoothTabPage;
    DBGridEh6: TDBGridEh;
    DBGridEh5: TDBGridEh;
    DBCtrlGrid2: TDBCtrlGrid;
    DBText16: TDBText;
    DBText22: TDBText;
    DBText23: TDBText;
    Label152: TLabel;
    Label153: TLabel;
    DBCheckBox12: TDBCheckBox;
    DBImage3: TJvDBImage;
    dbgd_TotServices: TDBGridEh;
    pc_RS485_Page: TAdvSmoothTabPage;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    me_RS485Log: TMemo;
    Panel11: TPanel;
    cb_lg485Evt: TCheckBox;
    Button4: TButton;
    dbgdRS485page: TDBGridEh;
    Button11: TButton;
    Button13: TButton;
    Button15: TButton;
    ed_RecType: TEdit;
    ed_ComCod: TEdit;
    ed_EveDes: TEdit;
    ed_DevAdd: TEdit;
    RichEdit1_: TRichEdit;
    Button9: TButton;
    Button16: TButton;
    Memo4: TMemo;
    Memo5: TMemo;
    rg_What: TAdvOfficeRadioGroup;
    pc_Manutenzione: TAdvSmoothTabPage;
    Shape9: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    DBGridEh13: TDBGridEh;
    mm_CleaningInfo: TMemo;
    AdvGlassButton7: TAdvGlassButton;
    AdvGlassButton4: TAdvGlassButton;
    re_manutNotesEditor: TAdvRichEditor;
    AdvRichEditorFormatToolBar2: TAdvRichEditorFormatToolBar;
    AdvGlassButton8: TAdvGlassButton;
    ClosingPage: TAdvSmoothTabPage;
    Label21: TLabel;
    Label79: TLabel;
    Label177: TLabel;
    Label57: TLabel;
    Label350: TLabel;
    Label351: TLabel;
    lb_Period: TLabel;
    lb_ClAlias: TLabel;
    Shape11: TShape;
    Shape15: TShape;
    Label114: TLabel;
    dbgd_1000_CC: TDBGridEh;
    DBText24: TDBText;
    DBText25: TDBText;
    DBText26: TDBText;
    DBText27: TDBText;
    Label363: TLabel;
    Label364: TLabel;
    Label365: TLabel;
    Label366: TLabel;
    dbgd_1000_EU: TDBGridEh;
    Label359: TLabel;
    Label360: TLabel;
    Label361: TLabel;
    Label362: TLabel;
    DBText14: TDBText;
    DBText19: TDBText;
    DBText20: TDBText;
    DBText21: TDBText;
    DBGridEh9: TDBGridEh;
    Label34: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    DBText9: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    DBText13: TDBText;
    rg_ClubOrCards: TAdvOfficeRadioGroup;
    dbgd_1000_CH: TDBGridEh;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    DBText15: TDBText;
    DBText17: TDBText;
    DBText18: TDBText;
    DBText28: TDBText;
    DBGridEh12: TDBGridEh;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    DBText29: TDBText;
    DBText30: TDBText;
    DBText31: TDBText;
    DBText32: TDBText;
    pl_RicClosing: TCurvyPanel;
    Image6: TImage;
    Label342: TLabel;
    Label341: TLabel;
    Label343: TLabel;
    Label104: TLabel;
    lb_RecFcDt: TJvBehaviorLabel;
    Label327: TLabel;
    Label329: TLabel;
    Label339: TLabel;
    lb_RecFC_CH: TJvBehaviorLabel;
    lb_RecFC_EU: TJvBehaviorLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label81: TLabel;
    ed_RecPos_CC: TDBNumberEditEh;
    ed_RecPos_EU: TDBNumberEditEh;
    ed_RecPos_CH: TDBNumberEditEh;
    ed_RecDelta_EU: TDBNumberEditEh;
    ed_RecDelta_CC: TDBNumberEditEh;
    ed_RecFC_CH: TDBNumberEditEh;
    ed_RecFC_EU: TDBNumberEditEh;
    ed_Ric_RT: TDBNumberEditEh;
    ed_RecDelta_CH: TNumberBox;
    ed_RecReal_CH: TNumberBox;
    ed_RecReal_EU: TNumberBox;
    ed_RecReal_CC: TNumberBox;
    pl_BarClosing: TCurvyPanel;
    Image9: TImage;
    Label316: TLabel;
    Label317: TLabel;
    Label318: TLabel;
    Label37: TLabel;
    Label324: TLabel;
    Label323: TLabel;
    Label325: TLabel;
    Label110: TLabel;
    lb_BarFcDt: TJvBehaviorLabel;
    Shape42: TShape;
    Shape38: TShape;
    lb_BarFC_CH: TJvBehaviorLabel;
    lb_BarFC_EU: TJvBehaviorLabel;
    Shape7: TShape;
    Label80: TLabel;
    ed_BarPos_CH: TDBNumberEditEh;
    ed_BarDelta_CH: TDBNumberEditEh;
    ed_BarPos_EU: TDBNumberEditEh;
    ed_BarDelta_EU: TDBNumberEditEh;
    ed_BarPos_CC: TDBNumberEditEh;
    ed_BarDelta_CC: TDBNumberEditEh;
    ed_BarRealTotal: TDBNumberEditEh;
    ed_BarFC_CH: TDBNumberEditEh;
    ed_BarFC_EU: TDBNumberEditEh;
    ed_BarPosTotal: TDBNumberEditEh;
    ed_BarDeltaTotal: TDBNumberEditEh;
    ed_Bar_RT: TDBNumberEditEh;
    ed_BarReal_CC: TNumberBox;
    ed_BarReal_EU: TNumberBox;
    ed_BarReal_CH: TNumberBox;
    CurvyPanel6: TCurvyPanel;
    Label302: TLabel;
    Label303: TLabel;
    Label306: TLabel;
    Label314: TLabel;
    Label347: TLabel;
    Label349: TLabel;
    Label252: TLabel;
    Label23: TLabel;
    Label29: TLabel;
    Shape41: TShape;
    JvBehaviorLabel1: TJvBehaviorLabel;
    Shape40: TShape;
    Image3: TImage;
    Image5: TImage;
    Label53: TLabel;
    Label17: TLabel;
    Label61: TLabel;
    Shape8: TShape;
    Shape14: TShape;
    Label109: TLabel;
    ed_TotPos_CH: TDBNumberEditEh;
    ed_TotReal_CH: TDBNumberEditEh;
    ed_TotPos_EU: TDBNumberEditEh;
    ed_TotReal_EU: TDBNumberEditEh;
    ed_TotPos_CC: TDBNumberEditEh;
    ed_TotReal_CC: TDBNumberEditEh;
    ed_RealTot: TDBNumberEditEh;
    ed_TotDelta_CC: TDBNumberEditEh;
    ed_TotDelta_EU: TDBNumberEditEh;
    ed_TotDelta_CH: TDBNumberEditEh;
    ed_Rec_OF: TDBNumberEditEh;
    ed_Rec_Canceled: TDBNumberEditEh;
    ed_Bar_OF: TDBNumberEditEh;
    ed_Bar_Canceled: TDBNumberEditEh;
    ed_PosTot: TDBNumberEditEh;
    ed_DeltaTot: TDBNumberEditEh;
    ed_OpenPD: TDBNumberEditEh;
    ed_OpenPiR: TDBNumberEditEh;
    ed_TotWoutGCC: TDBNumberEditEh;
    ed_TotNetClub: TDBNumberEditEh;
    CurvyPanel5: TCurvyPanel;
    Label73: TLabel;
    Label74: TLabel;
    Label76: TLabel;
    lb_Cashier: TLabel;
    bt_ClosePeriod: TAdvGlassButton;
    dbed_PecExRate: TDBNumberEditEh;
    JvProgressBar1: TJvProgressBar;
    mm_Comments: TRzMemo;
    AdvGlassButton9: TAdvGlassButton;
    CurvyPanel3: TCurvyPanel;
    cl_Closing_Cal: TAdvSmoothCalendarGroup;
    dbgd_PecComments: TDBGridEh;
    DBMemo3: TDBMemo;
    btn_PrintReceipt: TAdvGlassButton;
    ed_ReceiptCustomText: TCurvyEdit;
    AdvSmoothTabPage2: TAdvSmoothTabPage;
    tp_Stats: TAdvSmoothTabPager;
    tp_Stats_1: TAdvSmoothTabPage;
    dbgd_SaliteStats: TDBGridEh;
    cal_ClRoster: TDatePicker;
    AdvSmoothTabPage9: TAdvSmoothTabPage;
    Label56: TLabel;
    Label111: TLabel;
    cal_Bar: TAdvSmoothCalendar;
    pl_AssignTo: TPanel;
    Label319: TLabel;
    Label312: TLabel;
    lb_AssignedTo: TLabel;
    lb_payedWith: TLabel;
    bt_AssignTo: TAdvGlassButton;
    ed_AssPwd: TDBEditEh;
    dbgd_BarClosing: TDBGridEh;
    dbgd_BarOpLedger: TDBGridEh;
    btnCheckMGuard: TAdvGlassButton;
    btnStartMediaPlayer: TAdvGlassButton;
    shp_MGuardConnect: TShape;
    Label118: TLabel;
    Label7: TLabel;
    ed_RecPos_CH_G: TNumberBox;
    ed_RecPos_CHGCC: TNumberBox;
    Label106: TLabel;
    Label113: TLabel;
    ed_RecPos_CHSaldo: TDBNumberEditEh;
    Shape16: TShape;
    Timer_StartMediaPlayer: TTimer;
    bt_ShowCCtoG: TAdvGlassButton;
    AdvGlassButton10: TAdvGlassButton;
    pl_CC: TPanel;
    tp_CCtoG: TAdvSmoothTabPager;
    AdvSmoothTabPager99: TAdvSmoothTabPage;
    dbgd_1000_GCC: TDBGridEh;
    tp_CCtoG1: TAdvSmoothTabPage;
    tp_CCtoG2: TAdvSmoothTabPage;
    advsmtp_PrintRecap: TAdvSmoothTabPage;
    rg_DayMode: TAdvOfficeRadioGroup;
    rg_cash2client: TAdvOfficeRadioGroup;
    bt_PrintCCtoG: TAdvGlassButton;
    dbgd_CashToClients: TDBGridEh;
    cb_Deposits: TAdvOfficeCheckBox;
    cb_CCtoG: TAdvOfficeCheckBox;
    Label77: TLabel;
    BitBtn1: TBitBtn;
    rgCCMD: TRzRadioGroup;
    ed_RecPos_EUSaldo: TDBNumberEditEh;
    ed_RecPos_EU_G: TNumberBox;
    ckbSendRelaisDisconnect: TRzCheckBox;
    btnSendRelaisDisconnect: TButton;
    Label119: TLabel;
    edtSendRelaisDisconnect: TDBNumberEditEh;
    Label127: TLabel;
    Shape2: TShape;
    DBGridEh10: TDBGridEh;
    DBNavigator1: TDBNavigator;
    Label128: TLabel;
    cbgLotteryDays: TRzCheckGroup;
    bt_PrintRaffleClick: TAdvGlassButton;
    bt_DeleteUnredeemed: TAdvGlassButton;
    bt_Lottery: TAdvGlassButton;
    sc_RafflePrices: TDataSource;
    dtp_RaffleDate: TDatePicker;
    dbgRafflePrice: TDBCtrlGrid;
    DBNavigator9: TDBNavigator;
    DBImage1: TDBImage;
    DBEdit2: TDBEdit;
    Label130: TLabel;
    DBEdit3: TDBEdit;
    Label131: TLabel;
    DBEdit4: TDBEdit;
    Label132: TLabel;
    Label133: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    btnPrintRafflePrice: TAdvGlassButton;
    tmrRaffleMsg: TTimer;
    Shape13: TShape;
    Shape17: TShape;
    edRaffleQR: TRzButtonEdit;
    btnPrintRaffleWin: TAdvGlassButton;
    Shape18: TShape;
    Shape19: TShape;
    DBEdit5: TDBEdit;
    PROCEDURE nStartMguard(Sender: TObject);
    PROCEDURE nsg_CashierDisplayGetAlignment(Sender: TObject;
      ARow, ACol: Integer; VAR HAlign: TAlignment; VAR VAlign: TVAlignment);
    PROCEDURE rg_PrintReportsClick(Sender: TObject);
    PROCEDURE gd_ClLedgerGridTitleClick(Column: TColumnEh);
    PROCEDURE Edit1Change(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE gd_ClLedgerGridKeyDown(Sender: TObject; VAR Key: Word;
      Shift: TShiftState);
    PROCEDURE dbgd_RoomsKeyDown(Sender: TObject; VAR Key: Word;
      Shift: TShiftState);
    PROCEDURE DBGridEh2KeyDown(Sender: TObject; VAR Key: Word;
      Shift: TShiftState);
    PROCEDURE tm_ListEvents0Timer(Sender: TObject);
    PROCEDURE Button9Click(Sender: TObject);
    PROCEDURE Button16Click(Sender: TObject);
    PROCEDURE Button24Click(Sender: TObject);
    PROCEDURE Solochidormedanoi1Click(Sender: TObject);
    PROCEDURE pg_PecuniaDetailChanging(Sender: TObject;
      FromPage, ToPage: Integer; VAR AllowChange: Boolean);
    PROCEDURE cal_gPecSelectMultiDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
    PROCEDURE cal_gPecSelectDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
    PROCEDURE dbgd_InRoomDblClick(Sender: TObject);
    PROCEDURE mn_ClientiClientsPopup(Sender: TObject);
    PROCEDURE ed_AssPwdChange(Sender: TObject);
    PROCEDURE bt_AssignToClick(Sender: TObject);
    PROCEDURE rg_WhatClick(Sender: TObject);
    PROCEDURE led_MG_ClientDblClick(Sender: TObject);
    PROCEDURE ed_CT_MonExit(Sender: TObject);
    PROCEDURE dbed_FNameExit(Sender: TObject);
    PROCEDURE FileListBox2Click(Sender: TObject);
    PROCEDURE advSTP_FeeEditChange(Sender: TObject);
    PROCEDURE DBGridEh1CellClick(Column: TColumnEh);
    PROCEDURE cb_Testdata_Click(Sender: TObject);
    PROCEDURE DBVertGridEh1LabelColClick(Row: TFieldRowEh);
    PROCEDURE DBVertGridEh1CellClick(Row: TFieldRowEh);
    PROCEDURE cb_DefaultImgClick(Sender: TObject);
    PROCEDURE lb_monCountClick(Sender: TObject);
    PROCEDURE Button23Click(Sender: TObject);
    PROCEDURE rg_LogToMailFileRadioButtonClick(Sender: TObject);
    PROCEDURE bt_TestTextClick(Sender: TObject);
    PROCEDURE WriteTextFile(s: STRING);
    PROCEDURE Button25Click(Sender: TObject);
    PROCEDURE Button26Click(Sender: TObject);
    PROCEDURE db_PromoImageDblClick(Sender: TObject);
    PROCEDURE bt_CalculatorClick(Sender: TObject);
    PROCEDURE bt_EUClick(Sender: TObject);
    PROCEDURE bt_CCClick(Sender: TObject);
    PROCEDURE bt_PDClick(Sender: TObject);
    PROCEDURE bt_OFClick(Sender: TObject);
    PROCEDURE bt_CancelClick(Sender: TObject);
    PROCEDURE dbgd_CashierDisplaySumListAfterRecalcAll(Sender: TObject);
    PROCEDURE bt_pdRefreshClick(Sender: TObject);
    PROCEDURE mm_CashierSelectCell(Sender: TObject; ACol, ARow: Integer;
      VAR CanSelect: Boolean);
    PROCEDURE dbgd_1000_CHSumListAfterRecalcAll(Sender: TObject);
    PROCEDURE dbgd_1000_EUSumListAfterRecalcAll(Sender: TObject);
    PROCEDURE rg_ClubOrCardsClick(Sender: TObject);
    PROCEDURE tm_ExpiredFeesResetTimer(Sender: TObject);
    PROCEDURE H_printImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE FlowPanel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; VAR Accept: Boolean);
    PROCEDURE dbimg_BodyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE dbimg_HeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    // PROCEDURE Button32Click(Sender: TObject);
    PROCEDURE ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE db_RTEditor_EHExit(Sender: TObject);
    PROCEDURE FlowPanel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE ed_QR_SizeExit(Sender: TObject);
    PROCEDURE ed_QR_SizeChanging(Sender: TObject; NewValue: Integer;
      VAR AllowChange: Boolean);
    PROCEDURE dbimg1_KeyboardDblClick(Sender: TObject);
    PROCEDURE RzDBCheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE RzDBCheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    PROCEDURE bt_RegisterClick(Sender: TObject);

    PROCEDURE advSTP_FeeEditChanging(Sender: TObject; FromPage, ToPage: Integer;
      VAR AllowChange: Boolean);
    PROCEDURE dbimg_BodyEndDrag(Sender, Target: TObject; X, Y: Integer);
    PROCEDURE dbimg_HeaderEndDrag(Sender, Target: TObject; X, Y: Integer);
    PROCEDURE dbmm_TextEndDrag(Sender, Target: TObject; X, Y: Integer);
    PROCEDURE JvThread1Execute(Sender: TObject; Params: Pointer);
    PROCEDURE DBImageEh1ButtonClick(Sender: TObject; VAR Handled: Boolean);
    PROCEDURE Caricafoto1Click(Sender: TObject);
    PROCEDURE Eliminafoto1Click(Sender: TObject);
    PROCEDURE JvDBImage1DblClick(Sender: TObject);
    PROCEDURE bt_DelBonMalIdFromFeeClick(Sender: TObject);
    PROCEDURE popmn_BonMalPopup(Sender: TObject);
    PROCEDURE Assegnaa1Click(Sender: TObject);
    PROCEDURE bt_LoginClick(Sender: TObject);
    PROCEDURE dbgd_AdminClientsSSEnter(Sender: TObject);
    PROCEDURE dbg_Clienti_ClientsEnter(Sender: TObject);
    PROCEDURE dbg_Clienti_ClientsTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    PROCEDURE DBCtrlGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE cal_ClientsSelectMultiDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
    PROCEDURE cal_ClientsSelectDate(Sender: TObject;
      Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
    PROCEDURE tp_AdminClientsAccountingChanging(Sender: TObject;
      FromPage, ToPage: Integer; VAR AllowChange: Boolean);
    PROCEDURE bt_RR_RoomsClick(Sender: TObject);
    PROCEDURE SoloPresenticompresoinresidenza1Click(Sender: TObject);
    PROCEDURE tht_RRBlinkTimer(Sender: TObject);
    PROCEDURE tht_CheckPresenceTimer(Sender: TObject);
    procedure RzStatusBar1DblClick(Sender: TObject);
    procedure cb_QRReaderClick(Sender: TObject);
    procedure dbrg_PosImageFormatClick(Sender: TObject);
    procedure dbimg_BodyDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvGlassButton2Click(Sender: TObject);
    procedure dbVgd_FeesEditRows30EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure bt_TestPosTicketButtonClick(Sender: TObject);
    procedure dbgd_placeholdersDblClick(Sender: TObject);
    procedure AdvGlassButton1Click(Sender: TObject);
    procedure dbgd_placeholdersMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbimg2_KeyboardDblClick(Sender: TObject);
    procedure DBGridEh10Columns2EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure dbgd_RoomsDEnter(Sender: TObject);
    procedure dbgd_BuildingsEnter(Sender: TObject);
    procedure BtnFetchRatesClick(Sender: TObject);
    procedure dbgd_1000_GCCSelectionChanged(Sender: TObject);
    procedure bt_MultiRegClick(Sender: TObject);
    procedure jvtm_RefreshCassaServicesTimer(Sender: TObject);
    procedure pl_RicClosingEnter(Sender: TObject);
    procedure pl_RicClosingExit(Sender: TObject);
    procedure pl_BarClosingEnter(Sender: TObject);
    procedure pl_BarClosingExit(Sender: TObject);
    procedure bt_ClosePeriodClick(Sender: TObject);
    procedure dbgd_1000_CHDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dbgd_1000_EUDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dbgd_1000_CCDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure tm_ListEvents3Timer(Sender: TObject);
    procedure tm_ClosingTimer(Sender: TObject);
    procedure dbgd_1000_CCSumListAfterRecalcAll(Sender: TObject);
    procedure AdvGlassButton8Click(Sender: TObject);
    procedure AdvGlassButton4Click(Sender: TObject);
    procedure bt_FeeHelpClick(Sender: TObject);
    procedure bt_ExpandFeesClick(Sender: TObject);
    procedure dbgd_Fees_EditCellClick(Column: TColumnEh);
    procedure btn_Help_PosTicketClick(Sender: TObject);
    procedure RzStatusPane2DblClick(Sender: TObject);
    procedure RzStatusPane1DblClick(Sender: TObject);
    procedure cal_ClRosterChange(Sender: TObject);
    procedure bt_ReadCardClick(Sender: TObject);
    procedure thtm_BarRTTimer(Sender: TObject);
    procedure dbgd_1000_CHDblClick(Sender: TObject);
    procedure dbgd_1000_EUDblClick(Sender: TObject);
    procedure dbgd_1000_CCDblClick(Sender: TObject);
    procedure dbgd_1000_CHCellClick(Column: TColumnEh);
    procedure dbgd_1000_EUCellClick(Column: TColumnEh);
    procedure dbgd_1000_CCCellClick(Column: TColumnEh);
    procedure dbgd_1000_CHExit(Sender: TObject);
    procedure dbgd_1000_EUExit(Sender: TObject);
    procedure dbgd_1000_CCExit(Sender: TObject);
    procedure cb_CCtoGClick(Sender: TObject);
    procedure dbgd_1000_CHMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgd_1000_EUMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgd_1000_CCMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure utte1Click(Sender: TObject);
    procedure cb_DepositsClick(Sender: TObject);
    procedure thtm_LoginTimer(Sender: TObject);
    procedure rg_cash2clientClick(Sender: TObject);
    procedure dbgd_1000_GCCGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure bt_PrintCCtoGClick(Sender: TObject);
    procedure AdvGlassButton5Click(Sender: TObject);
    procedure dbgd_1010_GCCDblClick(Sender: TObject);
    procedure bt_ShowCCtoGClick(Sender: TObject);
    procedure img_ClientiClientsDblClick(Sender: TObject);
    procedure Caricafotodascanner1Click(Sender: TObject);
    procedure CreaTessera1Click(Sender: TObject);
    procedure Eliminatessera1Click(Sender: TObject);
    procedure SoloRecenti1Click(Sender: TObject);
    procedure ed_RecReal_CHChange(Sender: TObject);
    procedure ed_RecReal_EUChange(Sender: TObject);
    procedure ed_RecReal_CCChange(Sender: TObject);
    procedure ed_RecReal_EUChangeValue(Sender: TObject);
    procedure ed_BarReal_CHChange(Sender: TObject);
    procedure ed_BarReal_EUChange(Sender: TObject);
    procedure ed_BarReal_CCChange(Sender: TObject);
    procedure AdvGlassButton9Click(Sender: TObject);
    procedure cg_CashierKeyboardClick(Sender: TObject);
    procedure dbgd_TabsOpenDblClick(Sender: TObject);
    procedure dbgd_TabNowCellClick(Column: TColumnEh);
    procedure dbgd_TabNowExit(Sender: TObject);
    procedure btn_PrintReceiptClick(Sender: TObject);
    procedure dbgd_PresenceDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure MGuardClient1Connected(Sender: TObject);
    procedure MGuardClient1ServerDisconnected(Sender: TObject);
    procedure btnCheckMGuardClick(Sender: TObject);
    procedure dbgd_TabNowGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure dbgd_CashToClientsDblClick(Sender: TObject);
    procedure AdvGlassButton10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure rgCCMDClick(Sender: TObject);
    procedure btnSendRelaisDisconnectClick(Sender: TObject);
    procedure bt_PrintRaffleClick_Click(Sender: TObject);
    function NewRaffleNumber(const ATxID: string): string;
    procedure MarkRaffleNumberPrinted(const ACode: string; AWhen: TDateTime);
    procedure bt_DeleteUnredeemed_Click(Sender: TObject);
    procedure imgLotteryTDblClick(Sender: TObject);
    procedure DBImage1DblClick(Sender: TObject);
    procedure edRaffleQRChange(Sender: TObject);
    procedure btnPrintRafflePriceClick(Sender: TObject);
    procedure tmrRaffleMsgTimer(Sender: TObject);
    procedure edRaffleQRButtonClick(Sender: TObject);
    procedure btnPrintRaffleWinClick(Sender: TObject);
    procedure bt_LotteryClick(Sender: TObject);
    procedure dbgd_FeesEditClick(Sender: TObject);

  TYPE
    TPermissions = RECORD
      LogIn, CanOffer, FeesP, FeesEdit, Settings, AdminP, ManutP, PersonnelP,
        ClientsP, ClientsDataP, ClientsPresP, ClientsTaxP, ClientsResidP,
        ClientsPermitsP, CardsP, RoomsP, RS485P, CassaSettings, RoomSettings,
        InterfaceSettings, ComPortSettings, MailSettings,
        PrintSettings: Boolean;
      ClosingP, LimitClosingCalDays, BarP, LogInTimeOut: Integer;
      LogInFallBackPwd: String;
    END;

  TYPE
    TPrintItems = RECORD
      ImageA, ImageB, ImageC, ImageD, QrImage: TPicture;
      RichTextA, RichTextB: TDBRichEditEh;
      PrintQR, qr_Size, Copies: Integer;
      txID: STRING;
    END;

  TYPE
    TItemData = RECORD
      ItemType: Char; // 'H' OR 'B' for Image, 'T' or 't' for RichText
      ItemID: Integer; // ID of the image or RichText
    END;

  TYPE
    TPrintJob = record
      Panel: TStackPanel;
      Printer: TPrinter;
      Copies: Integer;
    end;

  type
    TCustomDialogButton = record
      ModalResult: TModalResult;
      Caption: string;
      ImageIndex: Integer;
      IsDefault: Boolean;
    end;

  type
    TDefaultButtonHelper = class
    public
      Btn: TRzButton;
      procedure HandleShow(Sender: TObject);
    end;

  type
    // mail thread pointer
    PMyThreadParams = ^TMyThreadParams;

    TMyThreadParams = record
      S1, S2, S3, S4: string;
    end;

  PROCEDURE FormCreate(Sender: TObject);
  PROCEDURE FeeCtrlGdPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
  PROCEDURE bt_AddCardRecordsClick(Sender: TObject);
  PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
  PROCEDURE bt_CancelAllClick(Sender: TObject);
  PROCEDURE dbg_Clienti_ClientsCellClick(Column: TColumnEh);
  PROCEDURE rg_CardEditChoiceClick(Sender: TObject);
  PROCEDURE bt_WriteCardClick(Sender: TObject);
  PROCEDURE bt_Read_Click(Sender: TObject);
  FUNCTION ReadCard(block: Integer; Sender: TObject): STRING;
  FUNCTION KillTask(exeFileName: STRING): Integer;
  FUNCTION Str2HexStr(Str: shortstring): STRING;
  FUNCTION HexToStr(H: byte): shortstring;
  FUNCTION Pad(CONST s: STRING; PadLen: smallInt; c: Char = ' '): STRING;
  FUNCTION Sec_CheckPCDateTime: Boolean;
  PROCEDURE RecalcClGridSums;
  PROCEDURE Bt_alarmClick(Sender: TObject);
  PROCEDURE MGuard1DataReceive(Sender: TObject);
  PROCEDURE dbgd_RoomsGetCellParams(Sender: TObject; Column: TColumnEh;
    AFont: TFont; VAR Background: TColor; State: TGridDrawState);
  PROCEDURE dbgd_RoomsCellClick(Column: TColumnEh);
  PROCEDURE ResetServices(all: Boolean);
  PROCEDURE Resetsingolastanza1Click(Sender: TObject);
  PROCEDURE Panel1DblClick(Sender: TObject);
  PROCEDURE Mostrasoloclientiincasa1Click(Sender: TObject);
  PROCEDURE Mostratutti1Click(Sender: TObject);
  PROCEDURE pc_MainPageCChanging(Sender: TObject; FromPage, ToPage: Integer;
    VAR AllowChange: Boolean);
  PROCEDURE HandleMicroGuardData(deviceName, deviceAddress, eventCode, readerID,
    actuatorID, abbaActuatorID, abbaReaderID, alias, lastEventDescr: STRING;
    serviceID, usedClean, feeID, barCredit: smallInt; privacy: Boolean;
    ledgerID, cardID, cardInID, ClientID, totUse: Integer);
  PROCEDURE Button4Click(Sender: TObject);
  PROCEDURE pc_AdminChanging(Sender: TObject; FromPage, ToPage: Integer;
    VAR AllowChange: Boolean);
  PROCEDURE pc_Clients_CalPageShow(Sender: TObject);
  PROCEDURE pc_Clients_DataPageShow(Sender: TObject);
  PROCEDURE pc_RS485_PageShow(Sender: TObject);
  PROCEDURE bt_Valid_SSClick(Sender: TObject);
  PROCEDURE Chiusura_calSelectMultiDate(Sender: TObject;
    Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
  PROCEDURE ed_ExchangeRateExit(Sender: TObject);
  PROCEDURE pc_Services_PageShow(Sender: TObject);
  PROCEDURE pc_MainPageCChange(Sender: TObject);
  PROCEDURE Shape7MouseEnter(Sender: TObject);
  PROCEDURE Shape7MouseLeave(Sender: TObject);
  PROCEDURE Button11Click(Sender: TObject);
  PROCEDURE bt_CheckAlarmSounfClick(Sender: TObject);
  PROCEDURE Button13Click(Sender: TObject);
  PROCEDURE PrintCleaningSheet(printIt: Boolean);

  PROCEDURE PrintFotoDelibera(Sender: TObject; PName: STRING; TextAR: TStrings);
  PROCEDURE Button15Click(Sender: TObject);
  FUNCTION TrimS(CONST s: shortstring): shortstring;
  PROCEDURE GetDailyCount;
  FUNCTION CheckBirthDay(ClientID: Integer): Boolean;
  PROCEDURE frxReport1GetValue(CONST VarName: STRING; VAR Value: Variant);
  PROCEDURE bt_PrintBarSummaryPeriodClick(Sender: TObject);
  PROCEDURE pc_SettingDetailPageChanging(Sender: TObject;
    FromPage, ToPage: Integer; VAR AllowChange: Boolean);
  PROCEDURE ed_ScannerFileNameDblClick(Sender: TObject);
  PROCEDURE bt_TestLedClick(Sender: TObject);
  PROCEDURE rg_CommissionCCClick(Sender: TObject);
  PROCEDURE bt_TestMailClick(Sender: TObject);
  PROCEDURE DBImage2DblClick(Sender: TObject);
  PROCEDURE PrintTeseuList(Sender: TObject);
  PROCEDURE BitBtn2Click(Sender: TObject);
  PROCEDURE msg_TeseuListButtonClick(Sender: TObject; Index: Integer);
  PROCEDURE frxReportTaxAllGetValue(CONST VarName: STRING; VAR Value: Variant);
  PROCEDURE frxReportTaxSingleGetValue(CONST VarName: STRING;
    VAR Value: Variant);
  PROCEDURE frxReport2GetValue(CONST VarName: STRING; VAR Value: Variant);
  PROCEDURE bt_StopAlarmSoundClick(Sender: TObject);
  FUNCTION TitleCase(CONST s: STRING): STRING;
  PROCEDURE dbed_FNameChange(Sender: TObject);
  PROCEDURE Image2DblClick(Sender: TObject);
  PROCEDURE db_TicketImage_DblClick(Sender: TObject);
  PROCEDURE ed_tmPrntTeseuListChange(Sender: TObject);
  PROCEDURE clk_TeseuCkOutAlarm(Sender: TObject);
  PROCEDURE bt_TeseuDailyListClick(Sender: TObject);
  PROCEDURE SetWorkingDayDateTime(ADate: TDateTime);
  PROCEDURE bt_PrintNotificheListClick(Sender: TObject);
  PROCEDURE pcTP_RoomsShow(Sender: TObject);

  FUNCTION GetHostName: STRING;

  PROCEDURE FormShow(Sender: TObject);
  PROCEDURE mm_AppHelpClick(Sender: TObject);
  PROCEDURE tm_CashierTimer(Sender: TObject);
  PROCEDURE Chiusura_calSelectDate(Sender: TObject;
    Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
  PROCEDURE Chiusura_calGetDateText(Sender: TObject; Date: TDateTime;
    AFont: TFont; VAR AText: STRING);
  PROCEDURE cb_SendMailClick(Sender: TObject);
  PROCEDURE lb_fondoCassaCtrlDtBadgeClick(Sender: TObject);
  PROCEDURE ed_BalanceReminderExit(Sender: TObject);
  Procedure xx_UpdateBarPage(CalSelDt, CalStartDt, CalEndDt: TDateTime);
  PROCEDURE dbgd_TabsOpenCellClick(Column: TColumnEh);
  PROCEDURE gd_BarOpLedgerDblClick(Sender: TObject);
  PROCEDURE cal_BarSelectDate(Sender: TObject; Mode: TAdvSmoothCalendarDateMode;
    Date: TDateTime);
  FUNCTION CheckPermission(AccessLevel: Integer; Field: STRING): Boolean;
  PROCEDURE cal_BarSelectMultiDate(Sender: TObject;
    Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
  FUNCTION nTaxPayed(ClientID: Integer): Boolean;

  PROCEDURE ShowBarcode;
  FUNCTION GetLocalPCName: STRING;
  FUNCTION EnCrypt(sInput: STRING): STRING;
  FUNCTION DeCrypt(sInput: STRING): STRING;
  PROCEDURE nSetFeeWeekDayFilter;
  FUNCTION GetDefaultPrinterName: STRING;
  FUNCTION processExists(exeFileName: STRING): Boolean;

  PROCEDURE UpdateBarSettings(Sender: TObject);
  FUNCTION nChangeAlpha(Input: STRING): STRING;
  FUNCTION CalculateDigits(iban: STRING): Integer;
  FUNCTION CheckIBAN(iban: STRING): Boolean;
  PROCEDURE ReadIni;
  PROCEDURE WriteIni;
  FUNCTION IsTimeBetween(CONST ATime, AStartTime, AEndTime: TTime): Boolean;
  FUNCTION nnIsTimeInRange(nowTime: TDateTime): Boolean;
  PROCEDURE bt_CHClick(Sender: TObject);
  PROCEDURE CheckSecondMonitor;
  PROCEDURE PositionFormOnSecondMonitor;
  PROCEDURE ShowThisImage(Sender: TObject; fName: STRING);
  FUNCTION BooleanArrayToString(CONST arr: ARRAY OF Boolean): STRING;
  PROCEDURE AssignBlobToImage(DataSet: TDataSet; BlobFieldName: STRING;
    ImageComponent: TImage);
  PROCEDURE GetImageDimensionsFromBlob(DataSet: TDataSet;
    ImageFieldName: STRING; OUT Width, Height: Integer);
  // PROCEDURE PrintImagePixelPos(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
  FUNCTION IsJPEG(Stream: TStream): Boolean;
  FUNCTION DetectImageFormat(Stream: TStream): STRING;
  PROCEDURE ToggleMemoVisibilityAtMouse(Memo: TMemo);
  FUNCTION StripRTFFormatting(CONST RTF: STRING): STRING;
  PROCEDURE nnSetPecuniaBtUp;

  PROCEDURE nnSetCashierDisplayColor(clr: TColor);

  PROCEDURE nnWriteCashierDisplay(stGrid: Integer; del: Boolean; fCol: TColor;
    Txt: STRING; rowIndex: Integer);

  PROCEDURE nnGetTheBalance(ClientID: Integer; txnID: STRING);
  // Modified test version of verifying procedures (start with "nn_")  started 20/10/24
  // --------------------------------------------------------------------------------
  PROCEDURE nn_CloseDailyFee;

  PROCEDURE nn_EnablePecuniaBt(enable: Boolean);
  PROCEDURE nn_SetPecuniaBtToFieldValue;

  PROCEDURE xx_CalcCash(Sender: TObject);
  PROCEDURE xx_FilterClosingTables(s: STRING);

  PROCEDURE AddRichTextToStackPanel(StackPanel: TStackPanel; TextID: Integer);

  // Print control procedures
  // ---------------------------------------------------------------------------
  FUNCTION GetCurrentPrinterHandle: THandle;
  PROCEDURE PurgeJobsOnCurrentPrinter;
  FUNCTION IsPrinterReady: Boolean;
  PROCEDURE WaitForPrinter;
  FUNCTION GetCurrentPrinterStatus: DWORD;
  FUNCTION GetMyPrinter: TPrinter;
  PROCEDURE PrintFromStackPanel(StackPanel: TStackPanel; myPrinter: TPrinter);
  function UnicodeToRtf(const s: string): string;
  procedure PrintStackPanelBitmap(StackPanel: TStackPanel;
    const PrinterName: string);
  procedure PrintTokensToPrinter(const PrinterName: string; const Ref: string;
    const PlaceholderDict: TDictionary<string, string>; const Copies: Integer);
  procedure PopulateStackPanelWithPlaceholders(const Ref: string;
    const PlaceholderDict: TDictionary<string, string>);
  PROCEDURE t_executePrint(StackPanel: TStackPanel; Printer: TPrinter;
    Copies: Integer);

  // Prepare print data (work in progress 26-12-24
  // ---------------------------------------------------------------------------
  PROCEDURE PreparePrintItems;
  PROCEDURE CopyRichText(Source: TDBRichEditEh; VAR Target: TDBRichEditEh;
    AParent: TWinControl);

  // Print procedures
  // ---------------------------------------------------------------------------
  PROCEDURE ReplacePlaceholders(RichEdit: TDBRichEditEh; ADate: TDate;
    amt: Double);
  // PROCEDURE ReplacePlaceholders_(RichEdit: TDBRichEditEh; CONST Placeholders, Values: ARRAY OF STRING);
  PROCEDURE PrintPNG(myPrinter: TPrinter; CONST FileName: STRING);
  PROCEDURE PrintImageFromTImage(myPrinter: TPrinter; posImage: TImage);
  PROCEDURE PrintImageFromTImageWithDatabase(myPrinter: TPrinter;
    posImage: TImage; BlobField: TField);

  PROCEDURE PurgeCompletedPrintJobs;

  FUNCTION CalculateRichEditContentHeight(RichEdit: TDBRichEditEh;
    PrinterCanvasHandle: HDC): Integer;
  PROCEDURE MergeImagesAndPrint(myPrinter: TPrinter; RichEdit: TDBRichEditEh;
    BlobField: TField);

  PROCEDURE RenderRTFToTImage(CONST RTFContent: STRING; TargetImage: TImage);

  PROCEDURE RichEditToImage(RichEdit: TDBRichEditEh; Image: TImage);

  FUNCTION GetRTFContentFromField(DataSet: TDataSet; FieldName: STRING): STRING;
  PROCEDURE ControlMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
  PROCEDURE CenterImageInShape(Image: TImage; Shape: TShape);
  FUNCTION CheckIfCardReadyToChange(Sender: TObject): Boolean;
  FUNCTION IsIntegerInCommaDelimitedString(Value: Integer;
    CONST DelimitedString: STRING): Boolean;
  PROCEDURE FilterBonusMalusFees;
  FUNCTION GetWorkShiftForDateRange(aCalendar: TAdvSmoothCalendar;
    DaysAuthorized: Integer): TArray<TDateTime>;
  PROCEDURE RemovePrintItem(Sender: TObject; DataSet: TDataSet);
  PROCEDURE RemovePrintItemHandler(Sender: TObject);

  PROCEDURE CheckIfpaymethodComplete;

  PROCEDURE xx_SetExpiredFeesToFalse;

  // Fee section procedures
  PROCEDURE ExpandVCategories(Expand: Boolean);

  // Rental room procedures
  PROCEDURE xx_GetBookingData(guestID: Integer);
  PROCEDURE xx_GetRentalData(guestID: Integer);
  FUNCTION GetRentalDepositAmt(AGuestID: Integer): uClientStore.TBooking;
  PROCEDURE xx_ScheduleNextRRCheck;
  FUNCTION xx_CheckIfStillPresent: Boolean;
  PROCEDURE xx_CloseUsedRoom;
  PROCEDURE xx_CloseUnusedRoom;
  PROCEDURE xx_WriteFeeToOtab;
  procedure xx_UpdateAllTxIDs;
  FUNCTION xx_WritePdToOtab(comesFrom: STRING): Boolean;
  PROCEDURE xx_ProcessBReferences(BReferences: STRING);
  PROCEDURE xx_WriteOtabToAccounts;

  PROCEDURE xx_WriteRentOwedToOtab;
  FUNCTION GetEuroFee(chfFee: Double): Double;
  PROCEDURE xx_SwitchOTabPecunia(Index: Integer);

  FUNCTION xx_GetLastValidTxData(comesFrom: String; ClientID: Integer): Boolean;
  FUNCTION xx_HandleValidFees(comesFrom: String): Integer;
  PROCEDURE xx_CancelAll(ResetDisplay: Boolean);
  FUNCTION xx_ReadCard(cardID: Integer): Integer;
  Function xx_FromCardReader: Integer;
  Procedure xx_VerifyFee(ClientID: Integer; OUT card4Fee, hasValidEntrance,
    hasValidRoom: Boolean);
  PROCEDURE xx_GetClientData(caClID: Integer);
  Procedure xx_GetThePdBalance(ClientID: Integer; txnID: STRING);
  Function yy_CheckAllClientData(comesFrom: String; cardID: Integer): Boolean;
  Procedure yy_CheckIfFeeOK(comesFrom: String);
  PROCEDURE xx_VacantRoom;

  procedure GetPrinterDevMode(PrinterName: string; var hDevMode: THandle);

  PROCEDURE InsertIntoTabMem;
  procedure LoadBlobIntoRich(Rich: TRichEdit; Blob: TBlobField);
  procedure ShowNumKeyboard;
  procedure ShowRR_Rooms;
  procedure SyncFloatingForm(Form: TForm; DeltaX, DeltaY: Integer;
    const msg: TWMWindowPosChanged);
  function VariantToFloatDef(const V: Variant;
    const Default: Double = 0.0): Double;
  Function CheckIfHasBarCredit(ClientID: Integer): String;
  Procedure SendThisMail(const toWhom, subject, bodyText: String;
    const AttachFiles: TArray<String>);
  // My Dialogs
  Function MyTaskDlg_Default(Cap, titl, Txt, b0_c, b1_c, b2_c,
    IconFileName: string): Integer;

  Procedure ShowHideBottomBtns(A, B, c, D: Boolean);
  function FullDaysBetween(const A, B: TDateTime): Integer;
  function GetInstallDrive: string;
  Function GetUnclosedPeriods: TDate;
  Procedure GetClosingBarData(CalStartDt, CalEndDt: TDateTime;
    workingDayPeriod: STRING);
  FUNCTION CheckIfHasComment(ClosingID: TDate): Boolean;
  Procedure WriteRTtoOTab;
  Procedure ShowDetailOpenBarTab;
  PROCEDURE PrintNote(amt: Double; pID, Copies: Integer);
  PROCEDURE PrintManutNotes(printIt: Boolean);
  FUNCTION GenerateTxID: PChar; stdcall;

  procedure PopulateStackPanelWithPlaceholders_2(const Ref: string;
    const PlaceholderDict: TDictionary<string, string>);
  Procedure UpdateClosingTabStatus;
  Procedure ResetRealValues;
  Procedure ResetPosValues;
  Procedure SetDatePeriod(CalSelDt, CalStartDt, CalEndDt: TDateTime;
    out workingday, workingDayPeriod: String;
    overrideLimits, isCalendarDate: Boolean);
  Procedure ShowCCtoGirls(startDateTime: TDateTime; workingDayPeriod: String;
    showOnlyTime: Boolean);
  Procedure SetSoldByFilter;
  Procedure SetBoughtByFilter;
  Procedure ChangePaymethod(subFeeID, cPartita, txID, amt, Description,
    oldPaymethod, sel1, sel2: String);
  Procedure xx_SetClosingPageFilters(Sender: TObject; StDt, EnDt: TDateTime;
    workingday, workingDayPeriod: STRING);
  Function ReadCardOnReader: Integer;
  Function VerifyCard(cardID: Integer): Integer;
  Procedure FilterCCandDeposits(cc, deposits: Boolean);
  Procedure ReverseEntry(txID: String);
  function IsBetweenMidnightAndNoon(const ADateTime: TDateTime): Boolean;
  Procedure ResetAncientFees;
  Procedure PrintCCtoG(StartDate, EndDate: TDateTime; workingDayPeriod: String);
  procedure PrintStackPanelAsBitmap(StackPanel: TStackPanel;
    myPrinter: TPrinter);
  Procedure PrintCCCashtoGClick(workingDayPeriod: String);
  // Printer and Scanner detection proc and func
  // ---------------------------------------------------------------------------
  procedure FillPrinters;
  procedure FillScanners;
  function VarTryStr(const V: OleVariant; const Member: string): string;
  procedure AddWmiItemsToLists(const Items: OleVariant; Names, Ids: TStrings);
  function GetSelectedScannerId: string;
  procedure ScanViaPickerToPicture(TargetPic: TPicture);
  function ScanViaPickerToFile(out SavedFile: string): Boolean;
  function GetPrinterStatusFlags(const APrinterName: string;
    out Status: DWORD): Boolean;
  function DetectImageExtByMagic(const FileName: string): string;
  function PrinterStatusText(s: DWORD): string;
  function IsPrinterOnline(const APrinterName: string): Boolean;
  function EnumPrintersInfo2(out Buf: PPrinterInfo2; out Count: DWORD): Boolean;
  procedure FillPrinterNamesFromSpooler(Target: TStrings);
  function SpoolerStatusFor(const APrinterName: string;
    out Status, Attrs: DWORD): Boolean;
  function IsOnlineBySpooler(const APrinterName: string): Boolean;
  // ---------------------------------------------------------------------------
  Procedure DoWriteCard(out registered: Boolean);
  Procedure UpdateClosingPage(Sender: TObject; StartDate, EndDate: TDateTime);
  Procedure UpdateMissingClosingIDS;
  Procedure ReverseClosing(workingday: String);
  Procedure ExecuteClosing(workDay: String);

  function SendCommand(const AJSON: TJSONObject; AMemo: TMemo): string;
  function PosVideoSendCommand(JSON: TJSONObject; AMemo: TMemo): string;

  procedure TerminateMediaPlayerProcess;
  procedure StopMediaPlayerAndShutdown;
  procedure SendPlaylistCommand(const ACmd: string);
  function IsProcessRunning(const AExeName: string): Boolean;
  procedure StartFetchingRates;
  procedure UpdateMGuardStatus(const ServerOK, ClientOK: Boolean;
    const StatusMsg: string);
  // procedure Timer_StartMediaPlayerTimer(Sender: TObject);
  function GetPrinterStatusByName(const APrinterName: string): DWORD;
  function TxDareExists(qy: TDataSet; const ATxID: string;
    const AAmount: Double): Boolean;
  Procedure SendRelaisDisconnect;
  function GetCashBalance(Pecunia: String): Double;
  Procedure GetRoomUseOverTime(ClientID, SubID: Integer);
  function IsRaffleQRValid(const ATxID: string): Boolean;
  procedure PrintRafflePrice(Sender: TObject);
  procedure RegisterRaffleWin(const ATxID: string; AWhen: TDateTime);

  PRIVATE
    FPlaceholders: TDictionary<string, string>;
    FFetchingRates: Boolean;

    // FOldPagerProc: TWndMethod;
    FShowRowSel: Boolean;
    FInTimerRefresh: Boolean;

    // procedure PagerWndProc(var msg: TMessage);

  PRIVATE
    { Private declarations }
    Twain: TDelphiTwain;
    FTCPClient: TIdTCPClient;
    PROCEDURE TwainTwainAcquire(Sender: TObject; CONST Index: Integer;
      Image: TBitmap; VAR Cancel: Boolean);

    // PROCEDURE WMDisplayChange(VAR msg: TMessage); MESSAGE WM_DISPLAYCHANGE;
    Procedure UpdatePresenceCalendar;
    Function CheckPermit(ClientID: Integer): Boolean;
    Procedure UpdateSaliteStats;
    Procedure ReverseSoldBy(txID: String);
    procedure SafeSend(const ACmd: string);
    function SendTCPCommand(const Command: string): Boolean;
    procedure WarnInsufficientCash(const AAmount, Cash: Double;
      const ACurrency: string);
    function HasEnoughCash(const AAmount: Double;
      const ACurrency: string): Boolean;
  PRIVATE
    FRaffleMsg: string;
    FPopupDataFieldName: STRING;
    FBlinkState: Boolean;
    orderBy: STRING;
    FScannerIDs: TStringList; // maps RadioGroup index -> PNPDeviceID
    FRatesEUR: TStringList; // Temporary storage for EUR rates
    FRatesCHF: TStringList; // Temporary storage for CHF rates
    FEURRate: Double; // Temporary storage for the rate
    FErrorMessage: string;
    FreceiptTxID: String;
    FSubFeeID: Integer;
    procedure FetchEuroAndCHF;
    procedure UpdateUIWithRates; // New method to update UI from main thread
    procedure ShowErrorMessage;

    PROCEDURE WMMove(VAR msg: TWMMove); MESSAGE WM_MOVE;
    PROCEDURE WMWindowPosChanged(VAR msg: TWMWindowPosChanged);
      MESSAGE WM_WINDOWPOSCHANGED;
    procedure PrintRaffleTicket(const ACaption, ACode: string;
      AWhen: TDateTime);
    function LoadGraphicFromField(AField: TField): TGraphic;
    function MakeQRBitmap(const AText: string): TBitmap;
    procedure PrintRafflePrices(APriceImage: TGraphic;
      const ADrawLine, AValidLine, AQRText: string; AWhen: TDateTime);
    procedure RegisterRafflePricePrinted(const ATxID: string; AWhen: TDateTime);
    function CheckRaffleQR(const ATxID: string): TRaffleCheck;

  PRIVATE
    NextControlY: Integer; // Tracks the Y-coordinate for default placement
    FreePositionImage: TImage;

    class var FInstanceCount: Integer;
    class var FFirstInstance: TForm1;
    // Pointer to the specific TImage with free placement

    procedure UpdateGrid(eT, gT, sT: Integer);

  CONST
    ConnXDoorReaderID: STRING = '9999';
    // Disabled using 9999 because had same reader id 28 as room 14 - 01/08/22
    LoungeReaderID: STRING = '26';
    LoungeActuatorID: STRING = '58';
    relaisOn = '20';
    relaisOff = '23';
    ledGreen = 'BX';
    ledRed = 'AX';
    ledBlue = '';
    ledBlink = 'DX';
    ledOff = 'CX';
    sleepTm = 100;
    RaffleLetters = 'ABCDEFGHJKLMNPRTUVWXYZ';

  PUBLIC
    FTestString: String;
    property Placeholders: TDictionary<string, string> read FPlaceholders;
    { Public declarations }
    PROCEDURE TagEvent(TagID: shortstring);
    // *** Evento di TAG rilevato nel campo RF del lettore ***
    procedure AfterConstruction; override;
    destructor Destroy; override;

  CONST
    regClientFeeID = 3;
    WIA_FMT_BMP = '{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}';


    // ************** DO NOT DELETE ************* DO NOT DELETE ***************
    // c_permissions_Arr fields  (value 0 = no access)
    // -------------------------------------------------------------
    // INDEX NO      VALUES
    { login_ix   = 0; // Login permit field index:  1 = True, 0 = False
      cashKey_ix = 1;
      // Cashier keyboard:   1 = access but no offered; >1 offered OK
      closingPage_ix = 2;
      // Closing page: 2 = no sums, no edit; 3,4,5 = todays edit; 6 = 10 days multidate, two days edit; 9 = all
      fees_ix = 3;
      // Fees page:  3,4 = access, no edit; 5 = edit no insert; 9 = all
      settings_ix = 4; // Settings page:  1 = access print page;
      admin_ix    = 5;
      // Admin page:  3 = access clients (detail) page, no edit; > 3 = edit
      maintenance_ix = 6; // Maintenance page: >= 2 = access
      personnel_ix   = 7; // Personnel page: 9 = all;
      clients_ix     = 8;
      // Clients page:(same as admin_ix) 3 = detail page, no edit; > 3 = edit
      clientsDet_ix = 9;
      // Clients detail page: (same as admin_ix) 3 = detail page, no edit; > 3 = edit
      clientsPres_ix   = 10; // Clients presence page:  => 4 = access
      clientsTax_ix    = 11; // Clients daily tax page: => 4 = access
      clientsRes_ix    = 12; // Clients residential rooms: => 3 = access
      clientsPermit_ix = 13;
      // Clients permits page: 3 = access, no edit; > 3 = edit
      cards_ix    = 14; // Cards page: => 5 = access, edit
      rooms_ix    = 15; // Rooms page: => 5 = access, edit
      rs485_ix    = 16; // RS485 serial com page: 9 = all
      cassaSet_ix = 17;
      // Cassa Settings page: >= 3 = access panel 1; >= 4 = panel 2; 9 = panel 3
      roomSet_ix   = 18; // Room settings page: 3,4,5 = access, no edit; 9 = all
      interface_ix = 19; // Interface settings page: >= 2 = access
      comport_ix   = 20; // Com ports settings page: 9 = all
      mail_ix      = 21; // email settings page: 9 = all
      print_ix     = 22; // Print settings page: 1 = access, no edit; >= 3 edit
      barCal_ix    = 23; }
    // Bar page calendar multidate: >= 6 multidate, rest only present day
    // ************** DO NOT DELETE ************* DO NOT DELETE ****************

  VAR
    // DraggedFieldName, whatYear,
    what2print, what2Print1, what2Print2, what2Print3, what2Print4, what2Print5,
      what2Print6, whatMonth, c_CardID, c_AlarmSound, c_serviceIdName, c_permit,
      txnID, posTable, regDtStr, cashier, barTxId, nClientType, nPm, thisPCName,
      nShift, remoteHostName, wDayPeriod, fReaderID: STRING;

    // c_LastFeeID, nUseThisCard,
    oldPrinterIdx, c_sameFeeItem, c_previousSubFeeID, oTabRowCount,
      nActiveFeeID, nSubFeeID, nSameFeeCount, nDoNotDeleteRow: Integer;
    FDeltaX, FDeltaY: Integer;
    FKeyDeltaX, FKeyDeltaY: Integer; // for NumKeyboard

    c_Fee, excRate, nCC2ClientAmt, nCCCommAmt, nfree, aChf, aEuro: Double;

    sDt, eDT, calSdt, calEdt, clos_Filter_sDT, clos_Filter_eDt, lstTxSdt,
      lstBsDate, lstFcVerDate, lstxRateDT: TDateTime;

    // ledgHasEntries,
    c_alarmEvent, c_RoomEnabled, c_needPrint, c_PayNow, nIsOpenAmt,
      resetIncExpDlg, nState, pState, startUp, lotteryT, promoT, nOK2Edit,
      nPrintJobDone, presenceChecked, vatBarCredit, catAreExpanded, showNumKeyB,
      keepMGuardActive: Boolean;

    c_ServiceOwnedByCardID_Arr, c_permissions_Arr: ARRAY OF Integer;
    openPeriod_Arr: TArray<TDateTime>;
    selectedPeriod_Arr: TArray<TDateTime>;
    posItems_Arr: ARRAY [1 .. 6] OF STRING[3];

    ItemsToPrint_Arr: ARRAY OF TItemData;
    toPrint_Arr: TArray<STRING>;

    FAliases: ARRAY OF STRING; // In room but Late at club

    todays_O_time, todays_C_time: TTime;
    regDT, StartDt: TDateTime;
    PaydUntDate, ToPaydUntDate, CinDate: TDate;

    ClubAccPermissions: TPermissions;

    PrintItems: TPrintItems;

    posImage: TImage;
    IsDragging: Boolean; // Flag to indicate if dragging is in progress
    DragStartY: Integer; // Starting Y position of the mouse
    FlowPanelStartTop: Integer; // Initial Top position of the FlowPanel
    FCashCHavailable, FCashEUavailable, FCashCHbusteCCG, FCashCHdirectCCG,
      FCashEUdirectCCG, FCashCHBaravailable, FCashEUBaravailable: Double;

  PROTECTED
    PROCEDURE DoCreate; OVERRIDE;
    PROCEDURE DoDestroy; OVERRIDE;

  END;

VAR
  Form1: TForm1;
  DeviceNotificationHandle: HDEVNOTIFY;
  TagTesterPresent: Boolean;

  tID: shortstring; // Tag ID.
  subFeeIdStr: STRING;
  { FwVersion         : shortstring; // Fw ver.
    Tag_StrBuffer     : string;                   // TI-iso15693  64 Blk * 4 byte = 256 bytes
    Tag_HexBuffer     : string; }
  alarmSound, tmpEvCd, c_CardEDate, partialDesc, ClosingID, lstClosingID,
    pecStr, VTtxId, senderGrid: STRING;
  cardOnReader, clickedFee, c_FeeID, c_SubFeeID, c_DiscID, gStatDays,
    validFeeResult, paylaterCount, validFeeHandleResult, qrSize: Integer;

  checkIN, c_CardOK, c_ActivePromos, InHouse, addNewService, regularCl, barCl,
    vipCl, prepaidCl, barPer, cleaningPer, cashierPer, testPer, nClosingOldBal,
    cc1: Boolean;

  FeeEuro, lastOvtBal, lastFeeBal, lastBal, startCHF, StartEuro, overTimeFee,
    ovtMultipl, allowedPdAmt, xRate, roomRateCHF, roomRateEuro: Double;
  mHandle: THandle;
  what: WideString;

IMPLEMENTATION

{$R *.dfm}


USES
  DM1,
  DlgNewClient,
  OtlParallel,
  dlg_ClosingDiscrepancy,
  uCheckRaffleWin,
  cUSBInterface,
  cUSBInterfaceTypes,
  AlarmPanel,
  nDlgRaffles,
  Unit4,
  Monitor_2,
  Monitor_3,
  KeyBoard,
  RrRooms,
  PGCManual,
  DM2,
  HelpForm,
  HelpEditorForm, RawPrinter, TaskDlgHelperF, GCC, uPlaylistClient,
  uVideoCommands, uPOSVideoClient;

CONST
  // constantes vendor y product ID en Hex
  // PRODUCT_ID = 2, pues asi lo hicimos en  MikroPascal
  // 2 proyectos con el mismo VID no pueden tener el mismo PID

  {
    WM_HID_EVENT = WM_USER + 1;
    NOTIFY_PLUGGED = 1;
    NOTIFY_UNPLUGGED = 2;
    NOTIFY_CHANGED = 3;
    NOTIFY_READ = 4;
  }
  VENDOR_ID = $0525;
  PRODUCT_ID = $A4AC;
  MGUARD_CONNECTION_ATTEMPTS = 4;
  MGUARD_RETRY_DELAY_MS = 500; // Delay tra tentativi di connessione
  MGUARD_STARTUP_WAIT_MS = 1000; // Attesa dopo avvio processo
  // Forward declaration
function CurrencyToItalianWords(Amount: Currency;
  const CurrencyName: string = 'euro'; const CentName: string = 'centesimi')
  : string; forward;

{ callback for streaming into the RichEdit }
function RichEditStreamInProc(dwCookie: DWORD; pbBuff: PAnsiChar; cb: Longint;
  var pcb: Longint): Longint; stdcall;
begin
  pcb := TStream(dwCookie).Read(pbBuff^, cb);
  Result := 0;
end;

procedure TForm1.AfterConstruction;
var
  Stack: string;
begin
  inherited;

  Inc(FInstanceCount);

  if FInstanceCount = 1 then
  begin
    FFirstInstance := Self;
    OutputDebugString(PChar(Format('Form1 #1 created at %p', [Pointer(Self)])));
  end
  else
  begin
    // SECOND OR LATER INSTANCE - THIS IS YOUR PROBLEM!
    OutputDebugString(PChar('========================================'));
    OutputDebugString(PChar(Format('ALERT! Form1 instance #%d created!',
      [FInstanceCount])));
    OutputDebugString(PChar(Format('First instance: %p (Name=%s)',
      [Pointer(FFirstInstance), FFirstInstance.Name])));
    OutputDebugString(PChar(Format('New instance: %p (Name=%s)', [Pointer(Self),
      Self.Name])));
    OutputDebugString(PChar('========================================'));

    // FORCE BREAKPOINT - Check call stack in debugger!
    DebugBreak;

    // Or show message with current state
    {
      MessageBox(0,
      PChar(Format('Form1 created again!'^M^J +
      'Instance: %d'^M^J +
      'Name: %s'^M^J +
      'Check call stack NOW!',
      [FInstanceCount, Self.Name])),
      'Duplicate Form1',
      MB_OK or MB_ICONWARNING or MB_TOPMOST);
    }
  end;
end;

destructor TForm1.Destroy;
begin
  Dec(FInstanceCount);
  OutputDebugString(PChar(Format('Form1 destroyed: %p (Name=%s), Remaining: %d',
    [Pointer(Self), Self.Name, FInstanceCount])));

  if Self = FFirstInstance then
    FFirstInstance := nil;

  inherited;
end;

function TForm1.PosVideoSendCommand(JSON: TJSONObject; AMemo: TMemo): string;
begin
  // TODO: adapt the call inside this wrapper to use your real SendCommand logic.
  // Example 1: if you already have a global SendCommand(JSON, AMemo):
  Result := SendCommand(JSON, AMemo);

  // Example 2: if your existing function is something like:
  // function SendCommand(const Host: string; Port: Integer; JSON: TJSONObject): string;
  // then write:
  //
  // Result := SendCommand('localhost', 9999, JSON);
  //
  // Example 3: if SendCommand is a *method* of the form:
  // function TForm1.SendCommand(JSON: TJSONObject): string;
  // then write:
  //
  // Result := Form1.SendCommand(JSON);
end;

function TForm1.SendCommand(const AJSON: TJSONObject; AMemo: TMemo): string;
var
  Client: TIdTCPClient;
  cmd: string;
begin
  Result := '';
  Client := TIdTCPClient.Create(nil);
  try
    Client.Host := 'localhost';
    Client.Port := 9999;
    Client.ConnectTimeout := 3000;
    Client.ReadTimeout := 3000;

    try
      if Assigned(AMemo) then
        AMemo.Lines.Add('Connecting to localhost:9999...');
      Client.Connect;
      if Assigned(AMemo) then
        AMemo.Lines.Add('Connected!');

      cmd := AJSON.ToString;
      if Assigned(AMemo) then
        AMemo.Lines.Add('Sending: ' + cmd);

      Client.IOHandler.WriteLn(cmd, IndyTextEncoding_UTF8);
      Result := Client.IOHandler.ReadLn(IndyTextEncoding_UTF8);

      if Assigned(AMemo) then
      begin
        AMemo.Lines.Add('Response: ' + Result);
        AMemo.Lines.Add('---');
      end;

    except
      on E: Exception do
      begin
        if Assigned(AMemo) then
        begin
          AMemo.Lines.Add('ERROR: ' + E.Message);
          AMemo.Lines.Add('---');
        end;
        raise;
      end;
    end;
  finally
    if Client.Connected then
      Client.Disconnect;
    Client.Free;
  end;
end;

procedure TForm1.TDefaultButtonHelper.HandleShow(Sender: TObject);
begin
  if Assigned(Btn) and Btn.CanFocus then
    Btn.SetFocus;
end;

procedure TForm1.GetPrinterDevMode(PrinterName: string; var hDevMode: THandle);
var
  hPrinter: THandle;
  pDefaults: TPrinterDefaults;
  dwNeeded: DWORD;
  pDevMode: PDeviceMode;
begin
  FillChar(pDefaults, SizeOf(pDefaults), 0);
  pDefaults.DesiredAccess := PRINTER_ACCESS_USE;

  if OpenPrinter(PChar(PrinterName), hPrinter, @pDefaults) then
    try
      // First call to get the size
      DocumentProperties(0, hPrinter, PChar(PrinterName), nil, nil, 0);
      dwNeeded := DocumentProperties(0, hPrinter, PChar(PrinterName),
        nil, nil, 0);
      hDevMode := GlobalAlloc(GHND, dwNeeded);
      pDevMode := GlobalLock(hDevMode);
      try
        DocumentProperties(0, hPrinter, PChar(PrinterName), pDevMode, nil,
          DM_OUT_BUFFER);
      finally
        GlobalUnlock(hDevMode);
      end;
    finally
      ClosePrinter(hPrinter);
    end;
end;

{ ------------------------------------------------------------------------------
  This function is called for every Windows message once hooked.
  We filter for our WM_HID_EVENT and then handle each WParam case.
  ------------------------------------------------------------------------------- }

procedure TForm1.ShowNumKeyboard;
Var
  P: TPoint;
begin
  if not Assigned(NumKeyboard) then
    NumKeyboard := TNumKeyboard.Create(Self);

  // Define default relative offset only once
  if (FKeyDeltaX = 0) and (FKeyDeltaY = 0) then
  begin
    FKeyDeltaX := 805;
    FKeyDeltaY := Self.Height - NumKeyboard.Height - 113;
  end;

  NumKeyboard.SetBounds(Self.Left + FKeyDeltaX, Self.Top + FKeyDeltaY,
    NumKeyboard.Width, NumKeyboard.Height);
  NumKeyboard.Show;
end;

procedure TForm1.ShowRR_Rooms;
begin

  if not Assigned(RR_Rooms) then
    RR_Rooms := TRR_Rooms.Create(Self);

  if (FDeltaX = 0) and (FDeltaY = 0) then
  begin
    // FDeltaX := Width + 10; // Example: to the right of the main form
    FDeltaX := 805;
    FDeltaY := Self.Height - RR_Rooms.Height - 112;
  end;

  RR_Rooms.SetBounds(Left + FDeltaX, Top + FDeltaY, RR_Rooms.Width,
    RR_Rooms.Height);

  RR_Rooms.Show;

end;

procedure TForm1.SyncFloatingForm(Form: TForm; DeltaX, DeltaY: Integer;
  const msg: TWMWindowPosChanged);
begin
  if not Assigned(Form) then
    Exit;

  // Reposition the form
  Form.SetBounds(Self.Left + DeltaX, Self.Top + DeltaY, Form.Width,
    Form.Height);

  // Sync visibility with parent
  if Form.Showing then
  begin
    if (msg.WindowPos.Flags and SWP_HIDEWINDOW) <> 0 then
      Form.Hide
    else if (msg.WindowPos.Flags and SWP_SHOWWINDOW) <> 0 then
      Form.Show;
  end;
end;

procedure TForm1.WMWindowPosChanged(var msg: TWMWindowPosChanged);
begin
  inherited;

  // Sync RR_Rooms
  SyncFloatingForm(RR_Rooms, FDeltaX, FDeltaY, msg);

  // Sync NumKeyboard
  SyncFloatingForm(NumKeyboard, FKeyDeltaX, FKeyDeltaY, msg);
end;

PROCEDURE TForm1.WMMove(VAR msg: TWMMove);
BEGIN
  inherited;

  if Assigned(RR_Rooms) then
    RR_Rooms.SetBounds(Self.Left + FDeltaX, Self.Top + FDeltaY, RR_Rooms.Width,
      RR_Rooms.Height);

  if Assigned(NumKeyboard) then
    NumKeyboard.SetBounds(Self.Left + FKeyDeltaX, Self.Top + FKeyDeltaY,
      NumKeyboard.Width, NumKeyboard.Height);
END;

(* Old version
  PROCEDURE TForm1.nStartMguard(Sender: TObject);
  VAR
  dir: STRING;
  BEGIN
  dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0))));

  what := dir + '\LanMaster_new\MGuard.exe';
  IF NOT processExists('MGuard.exe') THEN
  TRY
  ShellExecute(Handle, 'open', PWideChar(what), NIL, NIL,
  SW_SHOWMINNOACTIVE);
  EXCEPT
  ShowMessage('Microguard NOT running!');
  END;
  IF NOT processExists('MGuard.exe') THEN
  BEGIN
  RzStatusPane1.Caption := 'MGuard Server error';
  nnWriteCashierDisplay(0, False, clYellow, 'MGuard Server error!', 1);
  led_MG_Server.Status := False;
  END
  ELSE
  BEGIN
  RzStatusPane1.Caption := 'MGuard Server ok';
  nnWriteCashierDisplay(0, False, clWhite, 'MGuard Server ok', 1);
  led_MG_Server.Status := True;
  for var I := 1 to 4 do
  BEGIN
  MGuardClient1.Active := True;
  led_MG_Client.Status := MGuardClient1.Active;
  IF MGuardClient1.Active = True THEN
  Break;
  END;

  IF MGuardClient1.Active = True THEN
  RzStatusPane2.Caption := 'MGuard Client active'
  ELSE
  RzStatusPane2.Caption := 'MGuard Client not active';
  END;

  END;
*)


// --------------------------------------------------------------------------
{
  PROCEDURE TForm1.nStartMguard(Sender: TObject);
  VAR
  dir: STRING;
  BEGIN
  dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0))));

  what := dir + '\LanMaster_new\MGuard.exe';
  IF NOT processExists('MGuard.exe') THEN
  TRY
  ShellExecute(Handle, 'open', PWideChar(what), NIL, NIL,
  SW_SHOWMINNOACTIVE);
  EXCEPT
  ShowMessage('Microguard NOT running!');
  END;
  IF NOT processExists('MGuard.exe') THEN
  BEGIN
  RzStatusPane1.Caption := 'MGuard Server error';
  nnWriteCashierDisplay(0, False, clYellow, 'MGuard Server error!', 1);
  led_MG_Server.Status := False;
  END
  ELSE
  BEGIN
  RzStatusPane1.Caption := 'MGuard Server ok';
  nnWriteCashierDisplay(0, False, clWhite, 'MGuard Server ok', 1);
  led_MG_Server.Status := True;
  for var I := 1 to 4 do
  BEGIN
  MGuardClient1.Active := True;
  led_MG_Client.Status := MGuardClient1.Active;
  IF MGuardClient1.Active = True THEN
  Break;
  END;
  // Attenzione smcInterproc da testare a Chiasso changed SendMessage to PostMessage
  IF MGuardClient1.Active = True THEN
  RzStatusPane2.Caption := 'MGuard Client active'
  ELSE
  RzStatusPane2.Caption := 'MGuard Client not active';
  END;

  END;

}

procedure TForm1.nStartMguard(Sender: TObject);
var
  dir, exePath: string;
  TryNo: Integer;
begin
  dir := ExtractFileDir(ExtractFileDir(ExtractFileDir(ParamStr(0))));
  exePath := dir + '\LanMaster_new\MGuard.exe';

  if not processExists('MGuard.exe') then
  begin
    ShellExecute(Handle, 'open', PWideChar(exePath), nil, nil,
      SW_SHOWMINNOACTIVE);
    // give it time to create the IPC window
    for TryNo := 1 to 50 do // ~5 seconds
    begin
      Application.ProcessMessages;
      if processExists('MGuard.exe') then
        Break;
      Sleep(100);
    end;
  end;

  if not processExists('MGuard.exe') then
  begin
    RzStatusPane1.Caption := 'MGuard Server error';
    nnWriteCashierDisplay(0, False, clYellow, 'MGuard Server error!', 1);
    led_MG_Server.Status := False;
    Exit;
  end;

  RzStatusPane1.Caption := 'MGuard Server ok';
  nnWriteCashierDisplay(0, False, clWhite, 'MGuard Server ok', 1);
  led_MG_Server.Status := True;

  // try to connect (with real waiting)
  MGuardClient1.Active := False;
  for TryNo := 1 to 30 do // ~3 seconds
  begin
    MGuardClient1.Active := True;
    Application.ProcessMessages;

    if MGuardClient1.Active then
      Break;

    // force a real retry next loop
    MGuardClient1.Active := False;
    Application.ProcessMessages;
    Sleep(100);
  end;

  led_MG_Client.Status := MGuardClient1.Active;
  if MGuardClient1.Active then
    RzStatusPane2.Caption := 'MGuard Client active'
  else
    RzStatusPane2.Caption := 'MGuard Client not active';
end;

// Funzione helper per aggiornare lo stato UI (migliora manutenibilità)
procedure TForm1.UpdateMGuardStatus(const ServerOK, ClientOK: Boolean;
  const StatusMsg: string);
begin
  // Server status
  led_MG_Server.Status := ServerOK;
  if ServerOK then
    RzStatusPane1.Caption := 'MGuard Server ok'
  else
    RzStatusPane1.Caption := 'MGuard Server error';

  // Client status
  led_MG_Client.Status := ClientOK;
  if ClientOK then
    RzStatusPane2.Caption := 'MGuard Client active'
  else
    RzStatusPane2.Caption := 'MGuard Client not active';

  // Display message
  if ServerOK then
    nnWriteCashierDisplay(0, False, clWhite, StatusMsg, 1)
  else
    nnWriteCashierDisplay(0, False, clYellow, StatusMsg, 1);
end;

PROCEDURE TForm1.FormCreate(Sender: TObject);
var
  s: String;
begin
  dbgd_TabsOpen.SelectionDrawParams.DrawFocusFrame := False;
  // FOldPagerProc := pc_MainPageC.WindowProc;
  // pc_MainPageC.WindowProc := PagerWndProc;
  FScannerIDs := TStringList.Create;
  FScannerIDs.Sorted := True;
  FScannerIDs.Duplicates := dupIgnore; // for quick duplicate checks (by ID)
  FScannerIDs.Sorted := False; // keep UI order stable
  keepMGuardActive := False;

  FTCPClient := TIdTCPClient.Create(Self);
  FTCPClient.ReadTimeout := 5000;
  FTCPClient.ConnectTimeout := 5000;
  FTestString := 'not ok';
  if Winapi.Windows.LoadLibrary('RICHED20.DLL') = 0 then
    raise Exception.Create('Could not load RICHED20.DLL');

  xx_ScheduleNextRRCheck;
  Application.Title := Form1.Caption;
  NextControlY := 0; // Initialize the default Y-coordinate
  FreePositionImage := NIL; // Placeholder for the free-placement TImage
  SetLength(c_ServiceOwnedByCardID_Arr, 28);
  // Initalize now array otherwise initalized only after cashier login (poduces error in MguardDataReceive)
  for var I := LOW(c_ServiceOwnedByCardID_Arr)
    TO HIGH(c_ServiceOwnedByCardID_Arr) DO
    c_ServiceOwnedByCardID_Arr[I] := 0;
  gStatDays := 30;
  orderBy := ' Alias';
  thisPCName := GetLocalPCName;
  startUp := True;
  ed_cCard.Visible := False;
  Application.HintHidePause := 2500;
  dbg_Clienti_Clients.Hint := 'Clica a destra per menu' + #13 +
    'Verde: assente da 0 a 3 gg' + #13 + 'Giallo: assente da 4 a 8 gg' + #13 +
    'Rosso: assente da più di 8 gg';
  pl_KeyBoardCover.Width := 1108;
  pl_KeyBoardCover.BringToFront;
  pc_MainPageC.ActivePage := pc_Cashier_Page;
  FormatSettings.DateSeparator := '/';
  FormatSettings.DateSeparator := '-';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.DecimalSeparator := '.';
  cl_Closing_Cal.Month := Monthof(Date);
  cl_Closing_Cal.Year := YearOf(Date);
  cl_Closing_Cal.MaxDate := DateOf(Date);

  TagReader.ContinuoScan := False;
  TagTesterPresent := False;

  with Printer do
  begin
    rg_Printers.Items.Assign(Printers);
    rg_Printers.ItemIndex := PrinterIndex; // <- sets the current system printer
  end;

  ReadIni;

  FillPrinters;

  FillScanners;

  cbg_SendMailCriteria.Enabled := rg_LogToMailFile.CheckBox.Checked;
  clk_TeseuCkOut.AlarmHour := HourOf(ed_tmPrntTeseuList.Time);
  IF nState THEN
    sw_RRDeposit.State := tssON
  ELSE
    sw_RRDeposit.State := tssOff;

  IF pState THEN
    sw_RRLongRatePmt.State := tssON
  ELSE
    sw_RRLongRatePmt.State := tssOff;

  CASE DayOfWeek(Date) OF
    1:
      BEGIN
        todays_O_time := ed_OT_Sun.Time;
        todays_C_time := ed_CT_Sun.Time;
      END;
    2:
      BEGIN
        todays_O_time := ed_OT_Mon.Time;
        todays_C_time := ed_CT_Mon.Time;
      END;
    3:
      BEGIN
        todays_O_time := ed_OT_Tue.Time;
        todays_C_time := ed_CT_Tue.Time;
      END;
    4:
      BEGIN
        todays_O_time := ed_OT_Wed.Time;
        todays_C_time := ed_CT_Wed.Time;
      END;
    5:
      BEGIN
        todays_O_time := ed_OT_Thu.Time;
        todays_C_time := ed_CT_Thu.Time;
      END;
    6:
      BEGIN
        todays_O_time := ed_OT_Fri.Time;
        todays_C_time := ed_CT_Fri.Time;
      END;
    7:
      BEGIN
        todays_O_time := ed_OT_Sat.Time;
        todays_C_time := ed_CT_Sat.Time;
      END;

  END;

  excRate := ed_ExchangeRate.Value;

  CASE rg_AlarmSoundFiles.ItemIndex OF
    0:
      c_AlarmSound := 'car-alarm-1.wav';
    1:
      c_AlarmSound := '..\Caralarm.wav';
    2:
      c_AlarmSound := '..\Siren1.wav';
    3:
      c_AlarmSound := '..\Siren2.wav';
  END;

  // mm_Cashier.Clear;

  pc_MainPageC.ActivePageIndex := 0;
  pc_Admin.ActivePageIndex := 0;
  // pc_Clients.ActivePageIndex := 0;
  pc_SettingDetailPage.ActivePageIndex := 0;

  // ------------------------------------------------------
  // lb_ComPorts.Items.Clear;
  FOR VAR I := 1 TO 64 DO
    IF IsPortAvailable(I) THEN
    BEGIN
      lb_ComPorts.Items.Add('COM' + intToStr(I));
      ed_TagReaderPort.MaxValue := I;
    END;

  // Try to open Rfid Reader on port indicated in Settings
  // -------------------------------------------------------
  // IMPORTANT: on 19/09/2025 modification of Tag32.pas. Changed open and subsequent
  // proc and func from Rossi version to ChatGpt versions because of access violation
  // in application.ProcessMessages;
  IF TagReader.OpenPort(ed_TagReaderPort.Value) THEN // COM Port set to ..
  BEGIN
    TagTesterPresent := True;
    TagReader.TagEventLink := TagEvent; // Aggancia eventi
    RzStatusPane3.Caption := 'Port open';
    RzStatusPane4.Caption := 'Lettore tessere connesso';
    nnWriteCashierDisplay(0, False, clWhite, 'Lettore tessere connesso', 2);
  END
  ELSE
  BEGIN
    RzStatusPane4.Caption := 'Errore lettore tessere';
    nnWriteCashierDisplay(0, False, clYellow, 'Errore lettore tessere', 2);
    Label1.Caption := 'Port not open';
  END;

  Application.HintHidePause := 4000;
  SetWorkingDayDateTime(Now);

  lb_HostName.Caption := GetHostName;
  Randomize;
  // pc_Clients.ActivePageIndex := 0;
  pc_MainPageC.ActivePageIndex := 0;
  pc_SettingDetailPage.ActivePageIndex := 0;

  tm_List.Events.Items[1].Interval := ed_BalanceReminder.Value * 60000;

  Connect(Application.Handle);
  posImage := TImage.Create(Self); // Pass the form as the owner
  posImage.Parent := Self; // Assign the form as its parent
  posImage.Left := 10; // Set position (X coordinate)
  posImage.Top := 10; // Set position (Y coordinate)
  posImage.Width := 400; // Set width
  posImage.Height := 300; // Set height
  posImage.Stretch := True; // Enable Stretch to fit image dimensions
  posImage.Visible := True;
END;

procedure TForm1.FillPrinters;
var
  NameToPick: string;
  idx: Integer;
begin
  // 1) Populate from spooler (safe even if some printers are offline)
  FillPrinterNamesFromSpooler(rg_Printers.Items);
  rg_Printers.ItemIndex := -1;

  // 2) If you have a preferred name, try to select it only if online
  NameToPick := Trim(ed_PrinterName.Text);
  if NameToPick = '' then
    Exit;

  idx := rg_Printers.Items.IndexOf(NameToPick);
  if idx < 0 then
  begin
    MessageDlg(Format('La stampante "%s" non è istallata.', [NameToPick]),
      mtWarning, [mbOK], 0);
    Exit;
  end;

  if not IsOnlineBySpooler(NameToPick) then
  begin
    MessageDlg(Format('La stampante "%s" è OFFLINE.', [NameToPick]), mtWarning,
      [mbOK], 0);
    // keep ItemIndex = -1
    Exit;
  end;

  // 3) Only select in UI (do NOT touch TPrinter here)
  rg_Printers.ItemIndex := idx;
end;

function TForm1.GetPrinterStatusFlags(const APrinterName: string;
  out Status: DWORD): Boolean;
var
  H: THandle;
  Needed: DWORD;
  Buf: Pointer;
begin
  Result := False;
  Status := 0;

  if not OpenPrinter(PChar(APrinterName), H, nil) then
    Exit;
  try
    Needed := 0;
    GetPrinter(H, 6, nil, 0, @Needed);
    if Needed > 0 then
    begin
      GetMem(Buf, Needed);
      try
        if GetPrinter(H, 6, Buf, Needed, @Needed) then
        begin
          Status := PPrinterInfo6(Buf)^.dwStatus;
          Exit(True);
        end;
      finally
        FreeMem(Buf);
      end;
    end;

    Needed := 0;
    GetPrinter(H, 2, nil, 0, @Needed);
    if Needed > 0 then
    begin
      GetMem(Buf, Needed);
      try
        if GetPrinter(H, 2, Buf, Needed, @Needed) then
        begin
          Status := PPrinterInfo2(Buf)^.Status;
          Exit(True);
        end;
      finally
        FreeMem(Buf);
      end;
    end;
  finally
    ClosePrinter(H);
  end;
end;

function TForm1.IsPrinterOnline(const APrinterName: string): Boolean;
var
  s: DWORD;
begin
  Result := GetPrinterStatusFlags(APrinterName, s) and
    ((s and PRINTER_STATUS_OFFLINE) = 0);
end;

function TForm1.EnumPrintersInfo2(out Buf: PPrinterInfo2;
  out Count: DWORD): Boolean;
var
  Needed: DWORD;
  Flags: DWORD;
begin
  Result := False;
  Buf := nil;
  Count := 0;

  Flags := PRINTER_ENUM_LOCAL or PRINTER_ENUM_CONNECTIONS;

  Needed := 0;
  EnumPrinters(Flags, nil, 2, nil, 0, Needed, Count);
  if Needed = 0 then
    Exit(True); // no printers installed

  GetMem(Buf, Needed);
  try
    if EnumPrinters(Flags, nil, 2, Buf, Needed, Needed, Count) then
      Result := True
    else
    begin
      FreeMem(Buf);
      Buf := nil;
      Count := 0;
    end;
  except
    if Buf <> nil then
      FreeMem(Buf);
    Buf := nil;
    Count := 0;
  end;
end;

procedure TForm1.FillPrinterNamesFromSpooler(Target: TStrings);
var
  Buf, P: PPrinterInfo2;
  c, I: DWORD;
begin
  Target.Clear;
  if not EnumPrintersInfo2(Buf, c) then
    Exit;
  try
    P := Buf;
    for I := 0 to c - 1 do
    begin
      Target.Add(string(P^.pPrinterName));
      Inc(P);
    end;
  finally
    if Buf <> nil then
      FreeMem(Buf);
  end;
end;

function TForm1.SpoolerStatusFor(const APrinterName: string;
  out Status, Attrs: DWORD): Boolean;
var
  Buf, P: PPrinterInfo2;
  c, I: DWORD;
begin
  Result := False;
  Status := 0;
  Attrs := 0;
  if not EnumPrintersInfo2(Buf, c) then
    Exit;
  try
    P := Buf;
    for I := 0 to c - 1 do
    begin
      if SameText(string(P^.pPrinterName), APrinterName) then
      begin
        Status := P^.Status;
        Attrs := P^.Attributes;
        Exit(True);
      end;
      Inc(P);
    end;
  finally
    if Buf <> nil then
      FreeMem(Buf);
  end;
end;

function TForm1.IsOnlineBySpooler(const APrinterName: string): Boolean;
var
  s, A: DWORD;
begin
  Result := SpoolerStatusFor(APrinterName, s, A) and
    ((s and PRINTER_STATUS_OFFLINE) = 0) and
    ((A and PRINTER_ATTRIBUTE_WORK_OFFLINE) = 0);
end;

function TForm1.PrinterStatusText(s: DWORD): string;
  procedure Add(const S2: string);
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + S2;
  end;

begin
  Result := '';
  if (s and PRINTER_STATUS_OFFLINE) <> 0 then
    Add('Offline');
  if (s and PRINTER_STATUS_ERROR) <> 0 then
    Add('Error');
  if (s and PRINTER_STATUS_PAPER_JAM) <> 0 then
    Add('Paper jam');
  if (s and PRINTER_STATUS_PAPER_OUT) <> 0 then
    Add('Paper out');
  if (s and PRINTER_STATUS_MANUAL_FEED) <> 0 then
    Add('Manual feed');
  if (s and PRINTER_STATUS_DOOR_OPEN) <> 0 then
    Add('Door open');
  if (s and PRINTER_STATUS_TONER_LOW) <> 0 then
    Add('Toner low');
  if (s and PRINTER_STATUS_NO_TONER) <> 0 then
    Add('No toner');
  if (s and PRINTER_STATUS_OUT_OF_MEMORY) <> 0 then
    Add('Out of memory');
  if (s and PRINTER_STATUS_NOT_AVAILABLE) <> 0 then
    Add('Not available');
  if (s and PRINTER_STATUS_USER_INTERVENTION) <> 0 then
    Add('User intervention required');
  if Result = '' then
    Result := 'Unknown status';
end;

function TForm1.VarTryStr(const V: OleVariant; const Member: string): string;
begin
  Result := '';
  try
    if SameText(Member, 'Name') then
      Result := VarToStr(V.Name)
    else if SameText(Member, 'Caption') then
      Result := VarToStr(V.Caption)
    else if SameText(Member, 'Description') then
      Result := VarToStr(V.Description)
    else if SameText(Member, 'PNPDeviceID') then
      Result := VarToStr(V.PNPDeviceID)
    else if SameText(Member, 'DeviceID') then
      Result := VarToStr(V.DeviceID)
    else if SameText(Member, 'Status') then
      Result := VarToStr(V.Status)
    else if SameText(Member, 'Service') then
      Result := VarToStr(V.Service)
    else if SameText(Member, 'PNPClass') then
      Result := VarToStr(V.PNPClass);
  except
  end;
end;

procedure TForm1.AddWmiItemsToLists(const Items: OleVariant;
  Names, Ids: TStrings);
var
  Enum: IEnumVariant;
  Itm: OleVariant;
  Fetched: LongWord;
  Name, ID, Svc, Cls, Cap, Desc: string;
  IsScanner: Boolean;

  function LooksLikeScanner: Boolean;
  begin
    Result := SameText(Svc, 'WSDScan') or
      ((SameText(Cls, 'Image') or SameText(Cls, 'Imaging') or ContainsText(Cls,
      'Image')) and (ContainsText(Name, 'scan') or ContainsText(Cap, 'scan') or
      ContainsText(Desc, 'scan') or ContainsText(Svc, 'scan')));
  end;

begin
  if VarIsNull(Items) or VarIsEmpty(Items) then
    Exit;
  try
    Enum := IEnumVariant(IUnknown(Items._NewEnum));
  except
    Exit;
  end;

  while Enum.Next(1, Itm, Fetched) = 0 do
  begin
    // force everything into STRINGs here:
    Name := VarTryStr(Itm, 'Name');
    Cap := VarTryStr(Itm, 'Caption');
    Desc := VarTryStr(Itm, 'Description');
    Svc := VarTryStr(Itm, 'Service');
    Cls := VarTryStr(Itm, 'PNPClass');
    ID := VarTryStr(Itm, 'PNPDeviceID');
    if ID = '' then
      ID := VarTryStr(Itm, 'DeviceID');

    IsScanner := LooksLikeScanner;
    if not IsScanner then
      Continue;

    if Name = '' then
      Name := Cap;
    if Name = '' then
      Name := Desc;
    if Name = '' then
      Name := 'Scanner';

    if (ID <> '') and (Ids.IndexOf(ID) = -1) then
    begin
      Names.Add(Name);
      Ids.Add(ID);
    end
    else if (ID = '') and (Names.IndexOf(Name) = -1) then
    begin
      Names.Add(Name);
      Ids.Add(ID);
    end;
  end;
end;

procedure TForm1.FillScanners;
var
  Locator, Services, Items: OleVariant;
  TempNames: TStringList;
  I: Integer;
begin
  rg_Scanners.Items.Clear;
  if FScannerIDs = nil then
    FScannerIDs := TStringList.Create;
  FScannerIDs.Clear;

  TempNames := TStringList.Create;
  try
    try
      Locator := CreateOleObject('WbemScripting.SWbemLocator');
      Services := Locator.ConnectServer('.', 'root\cimv2');

      // A) Native scanner class (authoritative when present)
      Items := Services.ExecQuery
        ('SELECT Name, DeviceID, Status FROM Win32_Scanner');
      AddWmiItemsToLists(Items, TempNames, FScannerIDs);

      // B) Imaging class entries that look like scanners (USB/WIA)
      Items := Services.ExecQuery
        ('SELECT Name, Caption, Description, PNPDeviceID, Service, PNPClass FROM Win32_PnPEntity '
        + 'WHERE PNPClass="Image"');
      AddWmiItemsToLists(Items, TempNames, FScannerIDs);

      // C) WSD scanners (network MFP scan functions)
      Items := Services.ExecQuery
        ('SELECT Name, Caption, Description, PNPDeviceID, Service, PNPClass FROM Win32_PnPEntity '
        + 'WHERE PNPClass="WSD" OR Service="WSDScan"');
      AddWmiItemsToLists(Items, TempNames, FScannerIDs);

    except
      // WMI unavailable—leave empty silently
    end;

    for I := 0 to TempNames.Count - 1 do
      rg_Scanners.Items.Add(TempNames[I]);

    if rg_Scanners.Items.Count > 0 then
      rg_Scanners.ItemIndex := 0
    else
      rg_Scanners.ItemIndex := -1;

  finally
    TempNames.Free;
  end;
end;

procedure TForm1.ScanViaPickerToPicture(TargetPic: TPicture);
var
  Fn: string;
begin
  if not ScanViaPickerToFile(Fn) then
    Exit;
  // Try load; if extension was .bin and Delphi refuses, you can add stream-based loaders here.
  TargetPic.LoadFromFile(Fn);
end;

function TForm1.ScanViaPickerToFile(out SavedFile: string): Boolean;
var
  WiaDlg, WiaImg: OleVariant;
  tmpRaw, ext, newPath: string;
begin
  Result := False;
  SavedFile := '';
  try
    WiaDlg := CreateOleObject('WIA.CommonDialog');
    // Ask for BMP (drivers often comply; if not, we still handle it)
    // ShowAcquireImage(DeviceType=1 Scanner, Intent=0, Bias=0, FormatID=BMP, AlwaysSelectDevice=True, UseCommonUI=True, CancelError=False)
    WiaImg := WiaDlg.ShowAcquireImage(1, 0, 0,
      '{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}', True, True, False);
    if VarIsEmpty(WiaImg) then
      Exit; // user canceled

    // Save raw to .bin (don’t assume a format)
    tmpRaw := TPath.Combine(TPath.GetTempPath,
      'scan_' + FormatDateTime('yyyymmdd_hhnnss', Now) + '.bin');
    WiaImg.SaveFile(tmpRaw);

    // Detect true format by magic bytes and rename
    ext := DetectImageExtByMagic(tmpRaw);
    newPath := ChangeFileExt(tmpRaw, ext);
    if not SameText(newPath, tmpRaw) then
    begin
      if FileExists(newPath) then
        DeleteFile(newPath);
      RenameFile(tmpRaw, newPath);
      SavedFile := newPath;
    end
    else
      SavedFile := tmpRaw;

    Result := True;
  except
    // swallow WIA COM quirks; caller checks Result
    Result := False;
  end;
end;

function TForm1.GetSelectedScannerId: string;
begin
  if (rg_Scanners.ItemIndex >= 0) and (rg_Scanners.ItemIndex < FScannerIDs.Count)
  then
    Result := FScannerIDs[rg_Scanners.ItemIndex]
  else
    Result := '';
end;

function TForm1.DetectImageExtByMagic(const FileName: string): string;
var
  fs: TFileStream;
  B: array [0 .. 7] of byte;
  n: Integer;
begin
  Result := '.img';
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    FillChar(B, SizeOf(B), 0);
    n := fs.Read(B, SizeOf(B));
    if (n >= 3) and (B[0] = $FF) and (B[1] = $D8) and (B[2] = $FF) then
      Exit('.jpg'); // JPEG
    if (n >= 8) and (B[0] = $89) and (B[1] = $50) and (B[2] = $4E) and
      (B[3] = $47) and (B[4] = $0D) and (B[5] = $0A) and (B[6] = $1A) and
      (B[7] = $0A) then
      Exit('.png'); // PNG
    if (n >= 2) and (B[0] = Ord('B')) and (B[1] = Ord('M')) then
      Exit('.bmp'); // BMP
    if (n >= 3) and (B[0] = Ord('G')) and (B[1] = Ord('I')) and (B[2] = Ord('F'))
    then
      Exit('.gif'); // GIF
    if (n >= 4) and (((B[0] = Ord('I')) and (B[1] = Ord('I')) and (B[2] = 42))
      or ((B[0] = Ord('M')) and (B[1] = Ord('M')) and (B[2] = 0) and
      (B[3] = 42))) then
      Exit('.tif'); // TIFF
  finally
    fs.Free;
  end;
end;

PROCEDURE TForm1.ReadIni;
var
  Reg: TiniFile;
BEGIN
  Reg := TiniFile.Create(GetInstallDrive +
    '\Program Files (x86)\PGC_DB_Euro\Data Unicode\PGC_525.ini');

  TRY
    WITH Reg DO
    BEGIN
      ed_DatabaseName.Text := ReadString('Settings', 'DatabaseName',
        'PGC_DB_Main_EURO');
      ed_OT_Mon.Time := ReadTime('Settings', 'OT_Mon', StrToTime('14:00:00'));
      ed_OT_Tue.Time := ReadTime('Settings', 'OT_Tue', StrToTime('14:00:00'));
      ed_OT_Wed.Time := ReadTime('Settings', 'OT_Wed', StrToTime('14:00:00'));
      ed_OT_Thu.Time := ReadTime('Settings', 'OT_Thu', StrToTime('14:00:00'));
      ed_OT_Fri.Time := ReadTime('Settings', 'OT_Fri', StrToTime('14:00:00'));
      ed_OT_Sat.Time := ReadTime('Settings', 'OT_Sat', StrToTime('14:00:00'));
      ed_OT_Sun.Time := ReadTime('Settings', 'OT_Sun', StrToTime('14:00:00'));
      ed_CT_Mon.Time := ReadTime('Settings', 'CT_Mon', StrToTime('01:30:00'));
      ed_CT_Tue.Time := ReadTime('Settings', 'CT_Tue', StrToTime('01:30:00'));
      ed_CT_Wed.Time := ReadTime('Settings', 'CT_Wed', StrToTime('01:30:00'));
      ed_CT_Thu.Time := ReadTime('Settings', 'CT_Thu', StrToTime('01:30:00'));
      ed_CT_Fri.Time := ReadTime('Settings', 'CT_Fri', StrToTime('03:00:00'));
      ed_CT_Sat.Time := ReadTime('Settings', 'CT_Sat', StrToTime('03:00:00'));
      ed_CT_Sun.Time := ReadTime('Settings', 'CT_Sun', StrToTime('01:30:00'));
      ed_sDt.Time := ReadTime('Settings', 'sDt', StrToTime('12:00:00'));
      ed_eDt.Time := ReadTime('Settings', 'eDt', StrToTime('11:59:59'));
      ed_LastCheckOutTime.Time := ReadTime('Settings', 'lstChkOutTm',
        StrToTime('15:00:00'));

      ed_ExchangeRate.Value := ReadFloat('Settings', 'ExchangeRate', 1);
      lb_Last_ER_Date.Caption := ReadString('Settings', 'LastERDate',
        '01/01/2003');
      ed_GraceMinutes.Value := ReadInteger('Settings', 'GraceMinutes', 3);
      rg_CommissionCC.ItemIndex := ReadInteger('Settings', 'RG_Commission', 0);
      ed_MultiplyFee.Value := ReadFloat('Settings', 'MultiplyFee', 1);
      ed_VatTax.Value := ReadFloat('Settings', 'VatTax', 0);
      cb_VatTax.Checked := ReadBool('Settings', 'VatTax_YN', False);
      ed_amtMarchetta.Value := ReadFloat('Settings', 'AmtMarchetta', 0);
      ed_minSaleAmtMVat.Value := ReadFloat('Settings', 'MinSaleAmtMVat', 0);
      ed_CcCommissionAmt.Value := ReadFloat('Settings', 'CcCommission', 10);
      cb_SoundSwitch.Checked := ReadBool('Settings', 'SoundSwitch', True);
      cb_internetOff.Checked := ReadBool('Settings', 'InternetOff', False);
      rg_AlarmSoundFiles.ItemIndex := ReadInteger('Settings', 'AlarmSound', 0);
      ed_Minutes2ChangeRoom.Value := ReadInteger('Settings',
        'Minutes2ChangeRoom', 5);
      ed_MarkRedAfterUse.Value := ReadInteger('Settings', 'MarkRedAfterUse', 5);
      ed_TagReaderPort.Value := ReadInteger('Settings', 'TagReaderPort', 3);
      cb_settings_SS.Checked := ReadBool('Settings', 'showValidSS', True);
      ed_tmLmtCnclRmReg.Value := ReadInteger('Settings', 'TimeLimitRoomReg', 1);
      lstClosingID := ReadString('Settings', 'LastClosingID', '');
      cb_settings_PrintCB.Checked :=
        ReadBool('Settings', 'PrintReceipt', False);
      ed_OvtMoneyThrsHld.Value := ReadInteger('Settings', 'OvtMoneyThrsHld', 5);
      cb_PrintRoomUse.Checked := ReadBool('Settings', 'PrintRoomUse', True);
      ed_CompanyName.Text := ReadString('Settings', 'Company', 'Company name');
      ed_aHost.Text := ReadString('Settings', 'aHost', '');
      ed_aUser.Text := ReadString('Settings', 'aUser', '');
      ed_aPwd.Text := ReadString('Pwd', 'aPwd', '');
      ed_FromAddr.Text := ReadString('Settings', 'fromAddr', '');
      ed_ToAddr.Text := ReadString('Settings', 'toAddr', '');
      ed_TaxNo.Text := ReadString('Settings', 'TaxNo', '');
      ed_Manager.Text := ReadString('Settings', 'Manager', '');
      ed_CcAddr.Text := ReadString('Settings', 'ccAddr', '');
      ed_maxTmeDisc.Value := ReadInteger('Settings', 'ed_maxTmeDisc', 30);
      ed_nrLfCopies.Value := ReadInteger('Settings', 'LF copies', 1);
      ed_TimeUsed.Value := ReadInteger('Settings', 'Courtesan time', 25);
      cb_HowLongInRoom.Checked := ReadBool('Settings',
        'Courtesan time print', True);
      rg_Printers.ItemIndex := rg_Printers.Items.IndexOf
        (ReadString('Settings', 'Printer Name', 'EPSON TM-88V Receipt'));
      ed_ScannerFileName.Text := ReadString('Settings', 'Scan Program', '');
      cb_pcTimeVSlstRegTime.Checked :=
        ReadBool('Settings', 'PCTimeVSRegTime', False);
      cb_CollectTaxes.Checked := ReadBool('Settings', 'Collecttaxes', True);
      ed_PortNo.Value := ReadInteger('Settings', 'mailPortNo', 465);
      ed_DailyTaxAmt.Value := ReadInteger('Settings', 'DailyTaxAmt', 25);
      ed_nrTaxRecCopies.Value := ReadInteger('Settings', 'TaxRecCopies', 2);
      ed_tmPrntTeseuList.Time := ReadTime('Settings', 'tmPrntTeseuList',
        StrToTime('16:00:00'));
      cb_Check_ClientDataInput.Checked :=
        ReadBool('Settings', 'ClientDataInputCheck', False);
      cb_AutomaticCheckOut.Checked :=
        ReadBool('Settings', 'AutomaticCheckOut', True);
      ed_RemoteAddress.Text := ReadString('Settings', 'Remote Address', '');
      ed_RemotePort.Value := ReadInteger('Settings', 'RemotePort', 12010);
      IF (ed_RemoteHostName.Text = '') AND (ed_RemoteAddress.Text = '') THEN
        ed_RemoteAddress.Text := '127.0.0.1';
      ed_PrinterName.Text := ReadString('Settings', 'PrinterName',
        'EPSON TM-T88V Receipt');
      ed_MaxOffered.Value := ReadInteger('Settings', 'MaxOffered', 0);
      ed_Inact_LogOut.Value := ReadInteger('Settings', 'Inactivity Log Out', 0);
      ed_BalanceReminder.Value := ReadInteger('Settings',
        'Balance Reminder', 30);
      ed_DeltaEuroMargin.Value := ReadFloat('Settings', 'DeltaEuroMargin', 0);
      ed_DeltaClosingAmt.Value := ReadFloat('Settings', 'DeltaClosingAmt', 0);
      ed_LotteryT.Text := ReadString('Settings', 'LotteryText', '');
      ed_PrinterSleepTm.Value := ReadInteger('Settings', 'PrinterSleepTime', 7);
      cb_MultiDebitSameClient.Checked :=
        ReadBool('Settings', 'MultiDebitSameClient', False);
      cb_QRReader.Checked := ReadBool('Settings', 'QRReader', False);
      cb_PrintCleaningInfo.Checked :=
        ReadBool('Settings', 'PrintCleaningInfo', True);
      // ed_StimaCash.Value := ReadFloat('Settings', 'StimaCash', 120);
      cb_PrntTeseuList.Checked := ReadBool('Settings', 'PrntTeseuList', False);
      ed_DepDifferito.Value := ReadInteger('Settings', 'DepositPostboned', 5);
      ed_ResetRoomMinSpan.Value := ReadInteger('Settings',
        'ResetRoomMinSpan', 5);
      cb_RoomReset.Checked := ReadBool('Settings', 'RoomReset', True);
      ed_AssVatPwd.Text := ReadString('Settings', 'AssVatPwd', '1234');
      ed_MinReservDays.Value := ReadInteger('Settings', 'RR_RoomMinStay', 5);
      // ***  ed_StartDateClosingCheck.Date := ReadDate('Settings', 'StartDateClosingCheck', StrTodate('02-08-2022'));
      // ed_barRvalue.Value := ReadFloat('Settings', 'barRaffleValue', 100);
      // ed_rValidUntil.Value := ReadInteger('Settings', 'rValidUntil', 15);
      nState := ReadBool('Settings', 'DepositON', True);
      pState := ReadBool('Settings', 'RR_longratePmt', False);
      rg_LogToMailFile.CheckBox.Checked :=
        ReadBool('Settings', 'SendmailFile', False);
      rg_LogToMailFile.RadioButtons[0].Checked :=
        ReadBool('Settings', 'LogToMail', False);
      rg_LogToMailFile.RadioButtons[1].Checked :=
        ReadBool('Settings', 'LogToFile', False);
      cbg_SendMailCriteria.Checked[0] :=
        ReadBool('Settings', 'SendMLogIn0', False);
      cbg_SendMailCriteria.Checked[1] :=
        ReadBool('Settings', 'SendMNewClient', False);
      cbg_SendMailCriteria.Checked[2] :=
        ReadBool('Settings', 'SendMDiscrepancy', False);
      cbg_SendMailCriteria.Checked[3] :=
        ReadBool('Settings', 'SendMAnomaly', False);

      ed_QR_Size.Value := ReadInteger('Settings', 'QR_Width', 100);
      ed_NotEmail.Text := ReadString('Settings', 'NotEmail', '@pompeii.ch');
      ed_NotPwd.Text := ReadString('Settings', 'NotPwd', '6830@Notifiche');

      ed_MaxRoomRateDays.Value := ReadInteger('Settings', 'MaxRoomRateDays', 5);
      ed_MaxInterruptDays.Value := ReadInteger('Settings',
        'MaxInterruptDays', 0);

      ed_ImgDir.Text := ReadString('Settings', 'ImageDirectory',
        'nessuna directory salvata');
      ed_FreqContrFondiCassa.Value := ReadInteger('Settings',
        'RFreqContrFC', 2);
      ed_LoginTimeOut.Value := ReadInteger('Settings', 'LogInTimeOut', 5);
      rg_TowelFee.ItemIndex := ReadInteger('Settings', 'TowelFee', 0);
      ckb_verifyPermit.Checked := ReadBool('Settings', 'VerifyPermit', True);
      cbShowSecondaryMonitors.Checked :=
        ReadBool('Settings', 'ShowSecondaryMonitors', True);
      cbgLotteryDays.ItemChecked[0] := ReadBool('Settings', 'LotterySun', False);
      cbgLotteryDays.ItemChecked[1] := ReadBool('Settings', 'LotteryMon', False);
      cbgLotteryDays.ItemChecked[2] := ReadBool('Settings', 'LotteryTue', False);
      cbgLotteryDays.ItemChecked[3] := ReadBool('Settings', 'LotteryWed', False);
      cbgLotteryDays.ItemChecked[4] := ReadBool('Settings', 'LotteryThu', False);
      cbgLotteryDays.ItemChecked[5] := ReadBool('Settings', 'LotteryFri', False);
      cbgLotteryDays.ItemChecked[6] := ReadBool('Settings', 'LotterySat', False);
    END;
  FINALLY
    Reg.Free;
  END;
END;

PROCEDURE TForm1.WriteIni;
var
  Reg: TiniFile;
begin
  Reg := TiniFile.Create(GetInstallDrive +
    '\Program Files (x86)\PGC_DB_Euro\Data Unicode\PGC_525.ini');
  TRY
    WITH Reg DO
    BEGIN
      WriteString('Settings', 'DatabaseName', ed_DatabaseName.Text);
      WriteTime('Settings', 'OT_Mon', ed_OT_Mon.Time);
      WriteTime('Settings', 'OT_Tue', ed_OT_Tue.Time);
      WriteTime('Settings', 'OT_Wed', ed_OT_Wed.Time);
      WriteTime('Settings', 'OT_Thu', ed_OT_Thu.Time);
      WriteTime('Settings', 'OT_Fri', ed_OT_Fri.Time);
      WriteTime('Settings', 'OT_Sat', ed_OT_Sat.Time);
      WriteTime('Settings', 'OT_Sun', ed_OT_Sun.Time);
      WriteTime('Settings', 'CT_Mon', ed_CT_Mon.Time);
      WriteTime('Settings', 'CT_Tue', ed_CT_Tue.Time);
      WriteTime('Settings', 'CT_Wed', ed_CT_Wed.Time);
      WriteTime('Settings', 'CT_Thu', ed_CT_Thu.Time);
      WriteTime('Settings', 'CT_Fri', ed_CT_Fri.Time);
      WriteTime('Settings', 'CT_Sat', ed_CT_Sat.Time);
      WriteTime('Settings', 'CT_Sun', ed_CT_Sun.Time);
      WriteTime('Settings', 'sDt', ed_sDt.Time);
      WriteTime('Settings', 'eDt', ed_eDt.Time);
      WriteTime('Settings', 'lstChkOutTm', ed_LastCheckOutTime.Time);
      // WriteTime('Settings', 'LotteryStartTime', ed_LotteryStartTime.Time);
      // WriteTime('Settings', 'LotteryEndTime', ed_LotteryEndTime.Time);
      WriteTime('Settings', 'tmPrntTeseuList', ed_tmPrntTeseuList.Time);
      WriteFloat('Settings', 'ExchangeRate', ed_ExchangeRate.Value);
      WriteFloat('Settings', 'VatTax', ed_VatTax.Value);
      WriteBool('Settings', 'VatTax_YN', cb_VatTax.Checked);
      WriteFloat('Settings', 'AmtMarchetta', ed_amtMarchetta.Value);
      WriteFloat('Settings', 'minSaleAmtMVat', ed_minSaleAmtMVat.Value);
      WriteString('Settings', 'LastERDate', lb_Last_ER_Date.Caption);
      WriteString('Settings', 'Company', ed_CompanyName.Text);
      WriteString('Settings', 'Manager', ed_Manager.Text);
      WriteInteger('Settings', 'GraceMinutes', ed_GraceMinutes.Value);
      WriteBool('Settings', 'SoundSwitch', cb_SoundSwitch.Checked);
      WriteFloat('Settings', 'MultiplyFee', ed_MultiplyFee.Value);
      WriteBool('Settings', 'SoundSwitch', cb_SoundSwitch.Checked);
      WriteBool('Settings', 'InternetOff', cb_internetOff.Checked);
      WriteInteger('Settings', 'AlarmSound', rg_AlarmSoundFiles.ItemIndex);
      WriteInteger('Settings', 'Minutes2ChangeRoom',
        ed_Minutes2ChangeRoom.Value);
      WriteInteger('Settings', 'MarkRedAfterUse', ed_MarkRedAfterUse.Value);
      WriteInteger('Settings', 'TagReaderPort', ed_TagReaderPort.Value);
      WriteInteger('Settings', 'RG_Commission', rg_CommissionCC.ItemIndex);
      WriteBool('Settings', 'showValidSS', cb_settings_SS.Checked);
      WriteInteger('Settings', 'TimeLimitRoomReg', ed_tmLmtCnclRmReg.Value);
      WriteInteger('Settings', 'OvtMoneyThrsHld', ed_OvtMoneyThrsHld.Value);
      WriteFloat('Settings', 'CcCommission', ed_CcCommissionAmt.Value);
      WriteBool('Settings', 'PrintReceipt', cb_settings_PrintCB.Checked);
      WriteBool('Settings', 'PrintRoomUse', cb_PrintRoomUse.Checked);
      IF ClosingID <> '' THEN
        WriteString('Settings', 'LastClosingID', ClosingID);
      WriteString('Settings', 'aHost', ed_aHost.Text);
      WriteString('Settings', 'aUser', ed_aUser.Text);
      WriteString('Settings', 'aPwd', ed_aPwd.Text);
      WriteString('Settings', 'fromAddr', ed_FromAddr.Text);
      WriteString('Settings', 'toAddr', ed_ToAddr.Text);
      WriteString('Settings', 'ccAddr', ed_CcAddr.Text);
      WriteString('Settings', 'PrinterName', ed_PrinterName.Text);
      WriteInteger('Settings', 'ed_maxTmeDisc', ed_maxTmeDisc.Value);
      IF rg_Printers.ItemIndex > -1 THEN
        WriteString('Settings', 'Printer Name',
          rg_Printers.Items[rg_Printers.ItemIndex]);
      WriteInteger('Settings', 'LF copies', ed_nrLfCopies.Value);
      WriteInteger('Settings', 'Courtesan time', ed_TimeUsed.Value);
      WriteString('Settings', 'Scan Program', ed_ScannerFileName.Text);
      WriteBool('Settings', 'Courtesan time print', cb_HowLongInRoom.Checked);
      WriteBool('Settings', 'PCTimeVSRegTime', cb_pcTimeVSlstRegTime.Checked);
      WriteInteger('Settings', 'mailPortNo', ed_PortNo.Value);
      WriteFloat('Settings', 'DailyTaxAmt', ed_DailyTaxAmt.Value);
      WriteBool('Settings', 'CollectTaxes', cb_CollectTaxes.Checked);
      WriteInteger('Settings', 'TaxRecCopies', ed_nrTaxRecCopies.Value);
      WriteBool('Settings', 'ClientDataInputCheck',
        cb_Check_ClientDataInput.Checked);
      WriteBool('Settings', 'AutomaticCheckOut', cb_AutomaticCheckOut.Checked);
      WriteString('Settings', 'TaxNo', ed_TaxNo.Text);
      WriteString('Settings', 'Remote Address', ed_RemoteAddress.Text);
      WriteString('Settings', 'Remote Host Name', ed_RemoteHostName.Text);
      WriteInteger('Settings', 'RemotePort', ed_RemotePort.Value);
      WriteFloat('Settings', 'MaxOffered', ed_MaxOffered.Value);
      WriteInteger('Settings', 'Inactivity Log Out', ed_Inact_LogOut.Value);
      WriteInteger('Settings', 'Balance Reminder', ed_BalanceReminder.Value);
      WriteFloat('Settings', 'DeltaEuroMargin', ed_DeltaEuroMargin.Value);
      WriteString('Settings', 'LotteryText', ed_LotteryT.Text);
      WriteInteger('Settings', 'PrinterSleepTime', ed_PrinterSleepTm.Value);
      WriteBool('Settings', 'MultiDebiSameClient',
        cb_MultiDebitSameClient.Checked);
      WriteBool('Settings', 'QRReader', cb_QRReader.Checked);
      WriteBool('Settings', 'PrintCleaningInfo', cb_PrintCleaningInfo.Checked);
      WriteBool('Settings', 'PrntTeseuList', cb_PrntTeseuList.Checked);
      WriteInteger('Settings', 'DepositPostboned', ed_DepDifferito.Value);
      WriteBool('Settings', 'RoomReset', cb_RoomReset.Checked);
      WriteInteger('Settings', 'ResetRoomMinSpan', ed_ResetRoomMinSpan.Value);
      WriteInteger('Settings', 'RR_RoomMinStay', ed_MinReservDays.Value);
      WriteString('Pwd', 'AssVatPwd', ed_AssVatPwd.Text);
      WriteFloat('Settings', 'DeltaClosingAmt', ed_DeltaClosingAmt.Value);
      // ***  WriteDate('Settings', 'StartDateClosingCheck', ed_StartDateClosingCheck.Date);
      WriteBool('Settings', 'DepositON', nState);
      WriteBool('Settings', 'RR_longRatePmt', pState);
      WriteBool('Settings', 'SendMailFile', rg_LogToMailFile.CheckBox.Checked);
      WriteBool('Settings', 'LogToMail', rg_LogToMailFile.RadioButtons
        [0].Checked);
      WriteBool('Settings', 'LogToFile', rg_LogToMailFile.RadioButtons
        [1].Checked);
      WriteBool('Settings', 'SendMLogIn0', cbg_SendMailCriteria.Checked[0]);
      WriteBool('Settings', 'SendMNewClient', cbg_SendMailCriteria.Checked[1]);
      WriteBool('Settings', 'SendMAnomaly', cbg_SendMailCriteria.Checked[2]);
      WriteBool('Settings', 'SendMDiscrepancy',
        cbg_SendMailCriteria.Checked[3]);

      WriteInteger('Settings', 'QR_Width', ed_QR_Size.Value);

      WriteString('Settings', 'NotEmail', ed_NotEmail.Text);
      WriteString('Settings', 'NotPwd', ed_NotPwd.Text);

      WriteInteger('Settings', 'MaxRoomRateDays', ed_MaxRoomRateDays.Value);
      WriteInteger('Settings', 'MaxInterruptDays', ed_MaxInterruptDays.Value);
      WriteString('Settings', 'ImageDirectory', ed_ImgDir.Text);
      WriteInteger('Settings', 'RFreqContrFC', ed_FreqContrFondiCassa.Value);
      WriteInteger('Settings', 'LogInTimeOut', ed_LoginTimeOut.Value);
      WriteInteger('Settings', 'TowelFee', rg_TowelFee.ItemIndex);
      WriteBool('Settings', 'VerifyPermit', ckb_verifyPermit.Checked);
      WriteBool('Settings', 'ShowSecondaryMonitors',
        cbShowSecondaryMonitors.Checked);
      WriteBool('Settings', 'LotterySun', cbgLotteryDays.ItemChecked[0]);
      WriteBool('Settings', 'LotteryMon', cbgLotteryDays.ItemChecked[1]);
      WriteBool('Settings', 'LotteryTue', cbgLotteryDays.ItemChecked[2]);
      WriteBool('Settings', 'LotteryWed', cbgLotteryDays.ItemChecked[3]);
      WriteBool('Settings', 'LotteryThu', cbgLotteryDays.ItemChecked[4]);
      WriteBool('Settings', 'LotteryFri', cbgLotteryDays.ItemChecked[5]);
      WriteBool('Settings', 'LotterySat', cbgLotteryDays.ItemChecked[6]);
    END;
  FINALLY
    Reg.Free;
  END;
end;

FUNCTION TForm1.BooleanArrayToString(CONST arr: ARRAY OF Boolean): STRING;
BEGIN
  Result := '';
  FOR var I := LOW(arr) TO HIGH(arr) DO
  BEGIN
    IF arr[I] THEN
      Result := Result + '1'
    ELSE
      Result := Result + '0';
  END;
END;

procedure TForm1.btnCheckMGuardClick(Sender: TObject);
begin
  nStartMguard(Sender);
end;

procedure TForm1.BtnFetchRatesClick(Sender: TObject);
begin
  MemoRates.Clear;
  StartFetchingRates;
end;

FUNCTION TForm1.processExists(exeFileName: STRING): Boolean;
VAR
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
BEGIN
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  WHILE Integer(ContinueLoop) <> 0 DO
  BEGIN
    IF ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(exeFileName)) OR (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(exeFileName))) THEN
    BEGIN
      Result := True;
    END;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  END;
  CloseHandle(FSnapshotHandle);
END;

PROCEDURE TForm1.FormDestroy(Sender: TObject);
BEGIN
  if Assigned(FTCPClient) then
  begin
    try
      if FTCPClient.Connected then
        FTCPClient.Disconnect;
    except
      // Silently ignore socket errors during cleanup
      on E: EIdException do; // Do nothing - socket already invalid
    end;

    FreeAndNil(FTCPClient);
  end;

  posImage.Free;
  FreeAndNil(FPlaceholders);
  FScannerIDs.Free;
  Twain.Free;
  INHERITED;
END;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    Application.HelpContext(Self.HelpContext);
end;

PROCEDURE TForm1.FormShow(Sender: TObject);
var
  I: Integer;
  FieldName: String;
  workingday, workingDayPeriod: String;
BEGIN
  // Form2.tb_Fees.First;
  Barcode1.InputText := 'pompeiigentlemensclub.com';

  ShowBarcode;
  bt_Login.SetFocus;

  // Create placeholder dictionary
  // -----------------------------
  FPlaceholders := TDictionary<string, string>.Create(TIStringComparer.Ordinal);
  // despite the name, this comparer is actually case-insensitive
  nStartMguard(Sender);

  SetWorkingDayDateTime(Now);

END;

PROCEDURE TForm1.frxReport1GetValue(CONST VarName: STRING; VAR Value: Variant);
BEGIN
  IF CompareText(VarName, 'whatcompany') = 0 THEN
  BEGIN
    IF sDt <= StrToDateTime('31-07-2017 11:50:50') THEN
      Value := 'C I C E R O   S A G L'
    ELSE
      Value := 'O P A S   S A';
  END;
  IF CompareText(VarName, 'Period') = 0 THEN
    Value := 'Dal: ' + DateTimeToStr(sDt) + ' al: ' + DateTimeToStr(eDT);

  IF CompareText(VarName, 'GroupName') = 0 THEN
  BEGIN
    IF Form2.qy_FR_CostCenter.FieldByName('CostCenter').AsString = 'bar' THEN
      Value := 'BAR';
    IF Form2.qy_FR_CostCenter.FieldByName('CostCenter').AsString = 'clu' THEN
      Value := 'CLUB';
    IF Form2.qy_FR_CostCenter.FieldByName('CostCenter').AsString = 'gir' THEN
      Value := 'CLIENTI';
  END;
  IF CompareText(VarName, 'whatFname') = 0 THEN
    Value := Form2.tb_ClientiClients.FieldByName('FirstName').AsString;
  IF CompareText(VarName, 'whatLname') = 0 THEN
    Value := Form2.tb_ClientiClients.FieldByName('LastName').AsString;
  IF CompareText(VarName, 'whatBdate') = 0 THEN
    Value := DateToStr(Form2.tb_ClientiClients.FieldByName('BirthDate')
      .AsDateTime);
  IF CompareText(VarName, 'what2Print') = 0 THEN
    Value := what2print;
  IF CompareText(VarName, 'what2Print1') = 0 THEN
    Value := what2Print1;
  IF CompareText(VarName, 'what2Print2') = 0 THEN
    Value := what2Print2;
  IF CompareText(VarName, 'what2Print3') = 0 THEN
    Value := what2Print3;
  IF CompareText(VarName, 'what2Print4') = 0 THEN
    Value := what2Print4;
  IF CompareText(VarName, 'what2Print5') = 0 THEN
    Value := what2Print5;
  IF CompareText(VarName, 'what2Print6') = 0 THEN
    Value := what2Print6;
END;

PROCEDURE TForm1.frxReport2GetValue(CONST VarName: STRING; VAR Value: Variant);
BEGIN
  IF CompareText(VarName, 'whatcompany') = 0 THEN
  BEGIN
    IF sDt <= StrToDateTime('31-07-2017 11:50:50') THEN
      Value := 'C I C E R O   S A G L'
    ELSE
      Value := 'O P A S   S A';
  END;
  IF CompareText(VarName, 'Period') = 0 THEN
    Value := 'Dal: ' + DateTimeToStr(sDt) + ' al: ' + DateTimeToStr(eDT);
  IF CompareText(VarName, 'what2print') = 0 THEN
    Value := what2print;
END;

PROCEDURE TForm1.frxReportTaxAllGetValue(CONST VarName: STRING;
  VAR Value: Variant);
BEGIN
  IF CompareText(VarName, 'what2print') = 0 THEN
    Value := what2print;
  IF CompareText(VarName, 'whatCompany') = 0 THEN
    Value := ed_CompanyName.Text;
  IF VarName = 'IdTeseu2Print' THEN
    Value := Form2.tb_ClientiClients.FieldByName('IDTeseu').AsString;
END;

PROCEDURE TForm1.frxReportTaxSingleGetValue(CONST VarName: STRING;
  VAR Value: Variant);
BEGIN
  IF CompareText(VarName, 'what2print') = 0 THEN
    Value := what2print;
  IF CompareText(VarName, 'whatCompany') = 0 THEN
    Value := ed_CompanyName.Text;
  IF VarName = 'IdTeseu2Print' THEN
    Value := Form2.tb_ClientiClients.FieldByName('IDTeseu').AsString;
END;

PROCEDURE TForm1.gd_BarOpLedgerDblClick(Sender: TObject);
BEGIN
  { WITH Form2.qy_BarOpLedger DO
    BEGIN
    IF Active THEN
    Close;
    SQL.Clear;
    SQL.Add('SELECT Bar_OpLedger.UnitsSold,Bar_OpLedger.VolSold, Bar_Products.ProductName, '
    + 'Bar_OpLedger.Dare,Bar_OpLedger.Avere,Bar_OpLedger.PayMethod,Bar_OpLedger.TCount'
    + ' FROM Bar_OpLedger ' +
    'LEFT JOIN Bar_Products ON Bar_Products.ProductID =Bar_OpLedger.ProductID '
    + 'ORDER BY Data,txid');
    Active := True;
    END; }
END;

PROCEDURE TForm1.gd_ClLedgerGridKeyDown(Sender: TObject; VAR Key: Word;
  Shift: TShiftState);
BEGIN
  IF (Key = VK_DELETE) AND (Shift = [ssCtrl]) THEN
    Key := 0;
END;

PROCEDURE TForm1.gd_ClLedgerGridTitleClick(Column: TColumnEh);
BEGIN
  mn_OpLedger.PopupAtCursor;
END;

PROCEDURE TForm1.FormClose(Sender: TObject; VAR Action: TCloseAction);
VAR
  nState, pState: Boolean;
BEGIN
  startUp := True;
  Form2.qy_Presence.Close;
  nState := sw_RRDeposit.State = tssON;
  pState := sw_RRLongRatePmt.State = tssON;
  IF excRate <> ed_ExchangeRate.Value THEN
    lb_Last_ER_Date.Caption := DateTimeToStr(Now);

  WriteIni;

  IF Assigned(RR_Rooms) THEN
  BEGIN
    RR_Rooms.Hide;
    RR_Rooms := NIL;
  END;

  IF Assigned(NumKeyboard) THEN
  BEGIN
    NumKeyboard.Hide;
    NumKeyboard := NIL;
  END;

  MGuardClient1.Active := False;
  Sleep(100);
  KillTask('MGuard.exe');
END;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  resp: Integer;
  Client: TPlaylistClient;
  WaitCount: Integer;
begin
  CanClose := True;

  // Wait for currency fetch to complete (max 3 seconds)

  WaitCount := 0;
  while FFetchingRates and (WaitCount < 50) do
  begin
    Application.ProcessMessages;
    Sleep(100);
    Inc(WaitCount);
  end;

  // Check if playlist process is running
  if not IsProcessRunning('PGC525_MediaPlayer.exe') then
    Exit; // Playlist not running, just close

  // Playlist is running, ask user
  resp := MessageDlg('Il Media Player è ancora funzionante.' + sLineBreak +
    'Vuoi chiudere anche lui?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

  case resp of
    mrYes:
      begin
        Client := nil;
        try
          Client := TPlaylistClient.Create('localhost', 9999);
          try
            Client.ShutdownServer;
          except
            // Silently ignore - playlist might have already closed
          end;
        finally
          if Assigned(Client) then
          begin
            try
              Client.Free;
            except
            end;
          end;
        end;

      end;

    mrCancel:
      CanClose := False;
  end;

end;

PROCEDURE TForm1.TagEvent(TagID: shortstring);
// *** Evento di TAG rilevato nel campo RF del lettore ***
BEGIN
  tID := TagID;
END;

procedure TForm1.tmrRaffleMsgTimer(Sender: TObject);
var
  msg: string;
begin
  tmrRaffleMsg.Enabled := False;
  msg := FRaffleMsg;
  FRaffleMsg := '';
  if msg = '' then
    Exit;

  ShowMessage(msg);
  edRaffleQR.Clear; // so the next scan doesn't get appended to the old text
  edRaffleQR.SetFocus;
end;

PROCEDURE TForm1.tm_CashierTimer(Sender: TObject);
BEGIN
  // Automatic log out after timer intervall ended
  bt_Login.Click;
END;

procedure TForm1.cb_CCtoGClick(Sender: TObject);
begin
  FilterCCandDeposits(cb_CCtoG.Checked, cb_Deposits.Checked);
end;

procedure TForm1.cb_DepositsClick(Sender: TObject);
begin
  FilterCCandDeposits(cb_CCtoG.Checked, cb_Deposits.Checked);
end;

Procedure TForm1.FilterCCandDeposits(cc, deposits: Boolean);
Var
  s: String;
begin

  IF (cc) AND (deposits = False) Then
    s := '(subfeeid = 999 or subfeeid = 990)';

  IF (cc = False) AND (deposits) Then
    s := '(subfeeid = 289 or subfeeid = 299)';

  IF (cc) and (deposits) Then
    s := '(subfeeid = 999 or subfeeid = 990) OR (subfeeid = 289 or subfeeid = 299) ';

  IF (cc = False) AND (deposits = False) Then
    s := ' SubFeeID = 9999999999 '; // Show none
  With Form2.qy_1000_GCC do
  begin
    // Filter := s;
    // Filtered := True;
  end;

end;

PROCEDURE TForm1.cb_DefaultImgClick(Sender: TObject);
BEGIN
  IF NOT startUp THEN
    IF cb_DefaultImg.Checked THEN
    BEGIN
      IF (cb_Mon_3.Checked) THEN
        Form4.ShowAds(Trim(ed_DefMonImg_V.Text), 3);
      IF cb_Mon_2.Checked THEN
        Form4.ShowAds(Trim(ed_DefMonImg_H.Text), 2);
    END;
END;

procedure TForm1.cb_QRReaderClick(Sender: TObject);
begin
  if cb_QRReader.Checked then
    // Application.HookMainWindow(USBEventHook)
  else
    // Application.UnhookMainWindow(USBEventHook);
end;

PROCEDURE TForm1.cb_SendMailClick(Sender: TObject);
BEGIN
  cbg_SendMailCriteria.Enabled := rg_LogToMailFile.CheckBox.Checked;
END;

PROCEDURE TForm1.cb_Testdata_Click(Sender: TObject);
BEGIN
  If cb_Testdata_.Checked then
  begin
    ed_cCard.Visible := True;
    pl_TestDataButtons.Visible := True;
  end
  else
  begin
    ed_cCard.Visible := False;
    pl_TestDataButtons.Visible := False;
  end;
END;

PROCEDURE TForm1.Chiusura_calSelectDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);

BEGIN
  UpdateClosingPage(Sender, cl_Closing_Cal.StartDate, cl_Closing_Cal.EndDate);
END;

Procedure TForm1.UpdateClosingPage(Sender: TObject;
  StartDate, EndDate: TDateTime);
Var
  workingday, workingDayPeriod: String;
begin
  rgCCMD.ItemIndex := 0;
  ResetRealValues;
  ResetPosValues;
  SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
    cl_Closing_Cal.StartDate, workingday, workingDayPeriod, False,
    rg_DayMode.ItemIndex = 1);
  xx_SetClosingPageFilters(Sender, cl_Closing_Cal.StartDate,
    cl_Closing_Cal.EndDate, workingday, workingDayPeriod);
  ShowCCtoGirls(cl_Closing_Cal.StartDate, workingDayPeriod, True);
  FilterCCandDeposits(cb_CCtoG.Checked, cb_Deposits.Checked);
  xx_CalcCash(Sender);
  PrintCCtoG(cl_Closing_Cal.StartDate, IncDay(cl_Closing_Cal.StartDate, 1),
    workingDayPeriod);
end;

PROCEDURE TForm1.Chiusura_calSelectMultiDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
Var
  workingday, workingDayPeriod: String;
BEGIN
  rgCCMD.ItemIndex := 0;
  ResetRealValues;
  ResetPosValues;
  SetDatePeriod(StartDate, StartDate, EndDate, workingday, workingDayPeriod,
    False, rg_DayMode.ItemIndex = 1);
  xx_SetClosingPageFilters(Sender, cl_Closing_Cal.StartDate,
    cl_Closing_Cal.EndDate, workingday, workingDayPeriod);
  ShowCCtoGirls(cl_Closing_Cal.StartDate, workingDayPeriod, False);
  FilterCCandDeposits(cb_CCtoG.Checked, cb_Deposits.Checked);
  xx_CalcCash(Sender);
END;

Procedure TForm1.SetDatePeriod(CalSelDt, CalStartDt, CalEndDt: TDateTime;
  out workingday, workingDayPeriod: String;
  overrideLimits, isCalendarDate: Boolean);
VAR
  I: Integer;
  X, Y: Double;
BEGIN
  dbgd_1000_CH.Columns[0].Displayformat := 'hh:nn:ss';

  // Check if dayspan access granted
  // ---------------------------------------------------------------------------
  If overrideLimits = False Then
    CASE ClubAccPermissions.LimitClosingCalDays OF
      0:
        begin
          Exit;
        end;
      1 .. 15:
        Begin
          IF (DaySpan(Now, CalStartDt) >
            ClubAccPermissions.LimitClosingCalDays) Then
          begin
            CalStartDt := IncDay(Now, -ClubAccPermissions.LimitClosingCalDays);
            CalEndDt := CalStartDt;
            cl_Closing_Cal.Date := CalStartDt;
            cl_Closing_Cal.Refresh;
          end;
        end;
    End;

  {
    If DaySpan(CalStartDt, CalEndDt) <= 1 Then
    begin
    If isCalendarDate = False Then
    begin
    if CompareTime(Time, EncodeTime(12, 0, 0, 0)) < 0 then
    // it's before noon now
    CalStartDt := IncDay(CalStartDt, -1)
    else
    // noon or after
    CalEndDt := IncDay(CalEndDt, 1);

    dbgd_1000_GCC.Columns[0].Title.Caption := FormatSettings.LongDayNames
    [DayOfTheWeek(CalStartDt)];
    end;
    end
    else
    begin
    If isCalendarDate = False Then
    CalEndDt := IncDay(CalEndDt, 1);
    dbgd_1000_GCC.Columns[0].Title.Caption := '';
    end;

  }
  If isCalendarDate = False Then
  begin
    CalEndDt := IncDay(CalEndDt, 1);
    CalStartDt := RecodeTime(CalStartDt, 12, 0, 0, 0);
    CalEndDt := RecodeTime(CalEndDt, 11, 59, 59, 999);
  end
  else
  begin
    CalStartDt := RecodeTime(CalStartDt, 0, 0, 0, 1);
    CalEndDt := RecodeTime(CalEndDt, 23, 59, 59, 999);
  end;

  sDt := CalStartDt;
  eDT := CalEndDt;

  workingDayPeriod := ' BETWEEN CAST(' +
    QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', CalStartDt)) +
    ' AS Timestamp) ' + 'AND CAST(' +
    QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', CalEndDt)) +
    ' as Timestamp) ';
  wDayPeriod := workingDayPeriod; // wDayPeriod needed in PrintCCtoG
  workingday := Form2.EDBEngine1.DateToSQLStr(DateOf(CalStartDt));

  lb_Period.Caption := 'dal ' + DateTimeToStr(CalStartDt) + ' al ' +
    DateTimeToStr(CalEndDt);

  // bt_ClosePeriod.Enabled := False;
  IF ClubAccPermissions.LimitClosingCalDays = 0 THEN
    Exit;

  dbgd_1000_CH.Columns[0].Displayformat := 'dd.mm hh:nn';
  dbgd_1000_EU.Columns[0].Displayformat := 'dd.mm hh:nn';
  dbgd_1000_CC.Columns[0].Displayformat := 'dd.mm hh:nn';

  // from old CalMultiDate
  // ????????????????????????????????????????????????????????????????????????????
  Var
  wdp_SDt := CalStartDt;

  Var
  wdp_EDt := wdp_SDt;

  lb_Period.Caption := 'dal ' + DateTimeToStr(CalStartDt) + ' al ' +
    DateTimeToStr(CalEndDt);

  // Get the still open dates, if selection is multi dates, and open dates exist
  // then cancel the cash and cc fields on the display
  // ---------------------------------------------------------------------------
  Var
  Count := 0;

  Var
  CurrDate := wdp_SDt;
  while CurrDate < wdp_EDt do
  begin
    SetLength(selectedPeriod_Arr, Count + 1);
    selectedPeriod_Arr[Count] := DateOf(CurrDate);
    // Store only date part (time = 0)
    Inc(Count);
    CurrDate := IncDay(CurrDate); // move to next day
  end;

  var
  ADate := GetUnclosedPeriods;

  var
  op := Length(openPeriod_Arr);
  IF ADate > 0 Then
  begin

    TaskDlgHelperF.TaskDlg_Default('Periodi aperti',
      'Totale giorni lavorativi ancora non chiusi: ' + intToStr(op) + #13#10 +
      'Di cui il ' + DateTimeToStr(ADate),
      'Attenzione, a causa di periodi NON chiusi i conteggi CONTANTI e CC, essendo quindi solo parziali, non vengono mostrati sul display!',
      'OK', '', '', 'stop_48.ico');

  end;
end;

function TForm1.IsBetweenMidnightAndNoon(const ADateTime: TDateTime): Boolean;
begin
  Result := TimeOf(ADateTime) < EncodeTime(12, 0, 0, 0); // True if before noon
end;

Procedure TForm1.ShowCCtoGirls(startDateTime: TDateTime;
  workingDayPeriod: String; showOnlyTime: Boolean);
Var
  s: String;
begin

  // Credit cards to clients
  // ------------------------------------------------------------------------
  With Form2.qy_1000_GCC do
  begin
    SQL.Clear;

    SQL.Add('SELECT');
    SQL.Add('  c.ClientID,');
    SQL.Add('  cl.Alias,');
    SQL.Add('  c.Data,');
    SQL.Add('  c.Dare,');
    SQL.Add('  c.Avere,');
    SQL.Add('  c.SubFeeID,');
    SQL.Add('  CAST(NULL AS DECIMAL(18,2)) AS Balance,');
    SQL.Add('  CAST('''' AS VARCHAR(20)) AS Note,');
    SQL.Add('  CAST(0 AS SMALLINT) AS RowType,'); // detail
    SQL.Add('  c.TxID');
    SQL.Add('FROM c_2900 c');
    SQL.Add('LEFT JOIN clients cl ON cl.ID = c.ClientID');
    SQL.Add('WHERE c.SubFeeID IN (289, 299, 999, 990) ');
    SQL.Add('  AND c.Data ' + workingDayPeriod);

    SQL.Add('UNION ALL');

    SQL.Add(' SELECT');
    SQL.Add('  ids.ClientID,');
    SQL.Add('  CAST(''Saldo '' + cl.Alias AS VARCHAR(50)) AS Alias,');
    SQL.Add('  CAST(NULL AS DATE) AS Data,');
    SQL.Add('  CAST(NULL AS DECIMAL(18,2)) AS Dare,');
    SQL.Add('  CAST(NULL AS DECIMAL(18,2)) AS Avere,');
    SQL.Add('  CAST(NULL AS INTEGER) AS SubFeeID,');
    SQL.Add('  CAST((COALESCE(o.Opening,0) + COALESCE(m.Movement,0)) AS DECIMAL(18,2)) AS Balance,');
    SQL.Add('  CAST(''Saldo Cliente'' AS VARCHAR(20)) AS Note,');
    SQL.Add('  CAST(1 AS SMALLINT) AS RowType,'); // balance
    SQL.Add('  CAST(NULL AS VARCHAR(50)) AS TxID');
    SQL.Add(' FROM (');
    SQL.Add('  SELECT DISTINCT ClientID');
    SQL.Add('  FROM c_2900 ');
    SQL.Add('  WHERE SubFeeID IN (289, 299, 999, 990)');
    SQL.Add('    AND Data ' + workingDayPeriod); // FIX: no "c."

    SQL.Add(' ) ids');
    SQL.Add('LEFT JOIN clients cl ON cl.ID = ids.ClientID');
    SQL.Add('LEFT JOIN (');
    SQL.Add('  SELECT ClientID, SUM(COALESCE(Dare,0) - COALESCE(Avere,0)) AS Opening');
    SQL.Add('  FROM c_2900 ');
    SQL.Add('  WHERE SubFeeID IN (289, 299, 999, 990)');
    SQL.Add('    AND Data < CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', startDateTime)) +
      ' AS TIMESTAMP)');

    SQL.Add('  GROUP BY ClientID ');
    SQL.Add(' ) o ON o.ClientID = ids.ClientID ');
    SQL.Add(' LEFT JOIN (');
    SQL.Add('  SELECT ClientID, SUM(COALESCE(Dare,0) - COALESCE(Avere,0)) AS Movement');
    SQL.Add('  FROM c_2900 ');
    SQL.Add('  WHERE SubFeeID IN (289, 299, 999, 990)');
    SQL.Add('    AND Data ' + workingDayPeriod); // FIX: no "c."

    SQL.Add('  GROUP BY ClientID');
    SQL.Add(') m ON m.ClientID = ids.ClientID');

    SQL.Add('ORDER BY ClientID, RowType, COALESCE(Data, CAST(''9999-12-31'' AS DATE))');

    Active := True;
    Refresh;
    Last;
  end;

  If showOnlyTime Then
    dbgd_1000_GCC.Columns[0].Displayformat := 'hh:mm'
  else
    dbgd_1000_GCC.Columns[0].Displayformat := 'dd-mm  hh:MM';

  dbgd_1000_GCC.Refresh;
  dbgd_1000_GCC.SumList.RecalcAll;
end;

PROCEDURE TForm1.xx_SetClosingPageFilters(Sender: TObject;
  StDt, EnDt: TDateTime; workingday, workingDayPeriod: STRING);
VAR
  X, Y: Double;
BEGIN
  IF ClubAccPermissions.LimitClosingCalDays = 0 THEN
  begin
    Exit;
  end;

  // Fill CHF grid
  // ---------------------------------------------------------------------------
  With Form2.qy_1000_CH do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Data,Description,Dare,Avere,txID,Cpartita, cl.Alias, c.clientID,CardID, ClosingID, SubfeeID '
      + 'FROM c_1000 AS c ' + 'LEFT JOIN Clients AS cl ON c.ClientID = cl.ID ' +
      'WHERE PayMethod = ''CH''  AND Canceled <> True AND SubFeeID NOT IN (990, 999) AND Data '
      + workingDayPeriod + ' ORDER BY  Data ASC ');

    Active := True;
    Refresh;
    Last;
    dbgd_1000_CH.Refresh;
    dbgd_1000_CH.SumList.RecalcAll;
    FCashCHavailable := VariantToFloatDef(dbgd_1000_CH.SumList.SumCollection[0]
      .SumValue) - VariantToFloatDef(dbgd_1000_CH.SumList.SumCollection[1]
      .SumValue);
    ed_RecPos_CH.Value := VariantToFloatDef(dbgd_1000_CH.SumList.SumCollection
      [0].SumValue) - VariantToFloatDef(dbgd_1000_CH.SumList.SumCollection[1]
      .SumValue);
    // Cash set away for CC payments (busta ragazze)
    // -------------------------------------------------------------------------
    With Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT COALESCE(SUM(t.Dare),0) AS Dare' + ' FROM c_1010 t ' +
        'WHERE t.PayMethod = ''CH'' ' + '  AND t.Canceled <> True' +
        '  AND t.SubFeeID IN (990, 999)' + '  AND t.Data ' + workingDayPeriod +
        '   AND cPartita = 1000 ';
      Active := True;
      FCashCHbusteCCG := (FieldByName('Dare').AsFloat * -1);
      ed_RecPos_CHGCC.Value := (FieldByName('Dare').AsFloat * -1);
      // temporary mov of CH into envelope

      // Cash payments directly to GCC
      // -----------------------------------------------------------------------
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT COALESCE(SUM(Avere),0) AS Avere FROM c_1000 ' +
        ' WHERE PayMethod = ''CH''  AND Canceled <> True AND SubFeeID IN (990, 999) '
        + ' AND Data ' + workingDayPeriod + ' AND cPartita = 2900 ';
      Active := True;
      FCashCHdirectCCG := (FieldByName('Avere').AsFloat * -1);
      ed_RecPos_CH_G.Value := (FieldByName('Avere').AsFloat * -1);

      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT COALESCE(SUM(Avere),0) AS Avere FROM c_1000 ' +
        ' WHERE PayMethod = ''EU''  AND Canceled <> True AND SubFeeID IN (990, 999) '
        + ' AND Data ' + workingDayPeriod + ' AND cPartita = 2900 ';
      Active := True;
      FCashEUdirectCCG := (FieldByName('Avere').AsFloat * -1);
      ed_RecPos_EU_G.Value := (FieldByName('Avere').AsFloat * -1);
    end;
  end;

  // Fill Euro grid
  // ---------------------------------------------------------------------------
  With Form2.qy_1000_EU do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Data,Description,Dare,Avere,txID,Cpartita, cl.Alias, c.clientID, CardID, ClosingID,SubFeeID '
      + 'FROM c_1000 AS c ' + 'LEFT JOIN Clients AS cl ON c.ClientID = cl.ID ' +
      'WHERE PayMethod = ''EU''  AND Canceled <> True ' +
      'AND SubFeeID NOT IN (990, 999) AND Data ' + workingDayPeriod +
      ' ORDER BY  Data ASC ');
    Active := True;
    Refresh;
    Last;
    dbgd_1000_EU.Refresh;
    dbgd_1000_EU.SumList.RecalcAll;
    FCashEUavailable := VariantToFloatDef(dbgd_1000_EU.SumList.SumCollection[0]
      .SumValue) - VariantToFloatDef(dbgd_1000_EU.SumList.SumCollection[1]
      .SumValue);
    ed_RecPos_EU.Value := VariantToFloatDef(dbgd_1000_EU.SumList.SumCollection
      [0].SumValue) - VariantToFloatDef(dbgd_1000_EU.SumList.SumCollection[1]
      .SumValue);
  end;

  // Fill CC grid
  // ---------------------------------------------------------------------------
  With Form2.qy_1000_CC do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Data,Description,Dare,Avere,txID,Cpartita, cl.Alias, c.clientID,CardID, ClosingID,SubFeeID '
      + 'FROM c_1000 AS c ' + 'LEFT JOIN Clients AS cl ON c.ClientID = cl.ID '
      // Changed including cc to g on 15-09-2025
      // 'WHERE PayMethod = ''CC''  AND Canceled <> True AND SubFeeID NOT IN (990, 999) AND Data '
      + ' WHERE PayMethod = ''CC''  AND Canceled <> True ' + ' AND Data ' +
      workingDayPeriod + ' ORDER BY  Data ASC ');
    Active := True;
    Refresh;
    Last;
    dbgd_1000_CC.Refresh;
    dbgd_1000_CC.SumList.RecalcAll;
    ed_RecPos_CC.Value := VariantToFloatDef(dbgd_1000_CC.SumList.SumCollection
      [0].SumValue);
  end;

  // Fill Bar panel
  // ---------------------------------------------------------------------------
  GetClosingBarData(StDt, EnDt, workingDayPeriod);

  dbed_PecExRate.DataField := '';

  IF (Form2.qysc_1000_CH.DataSet.RecordCount > 0) AND
    Form2.qysc_1000_CH.DataSet.FieldByName('ClosingID').IsNull Then
  begin
    bt_ClosePeriod.Enabled := True;
    bt_ClosePeriod.Caption := 'CHIUSURA CASSA';
  end;

  IF (Form2.qy_1000_CH.RecordCount > 0) OR (Form2.qy_1000_EU.RecordCount > 0) OR
    (Form2.qy_1000_CC.RecordCount > 0) Then
  begin
    Var
      s: String;

      // Get Pecunia days where Comments exist
      // --------------------------------------------------------------------------
    Var
    MonthStart := StartOfTheMonth(DateOf(cl_Closing_Cal.StartDate));
    // 2025-08-01 00:00:00
    Var
    MonthEndPlus1 := DateOf(IncMonth(MonthStart, 1));
    Var
    pecuniaWDP := ' DATE ' + QuotedStr(Form2.EDBEngine1.DateToSQLStr(MonthStart)
      ) + ' AND DATE ' + QuotedStr
      (Form2.EDBEngine1.DateToSQLStr(MonthEndPlus1));

    s := 'SELECT Comments , Operator,' +
      'CAST(ClosingID AS DATE DATE FORMAT ''DD-MM-YYYY'') AS ClosingDate, ' +
      'p.* ' + 'FROM Pecunia p ' +
      'WHERE CAST(ClosingID AS DATE DATE FORMAT ''DD-MM-YYYY'') ' + 'BETWEEN ' +
      pecuniaWDP + ' AND p.Comments IS NOT NULL ';

    With Form2.qy_PecuniaComments do
    begin
      IF Active Then
        Close;
      SQL.Clear;
      SQL.Add(s);
      Active := True;
      dbgd_PecComments.Refresh;
    end;

    // Get past pecunia data
    // -------------------------------------------------------------------------
    IF HoursBetween(StDt, EnDt) > 24 Then
      s := 'SELECT SUM(cCH) AS cCHSum, SUM(cEU) AS cEuSum, SUM(cCC) AS cCCSum, '
        + 'SUM(bCH) AS bCHSum, SUM(bEU) AS bEUsum, SUM(bCC) AS bCCsum  ' +
        'FROM Pecunia WHERE Data ' + workingDayPeriod
    else
      s := 'SELECT COALESCE(cCH,0) AS cCH, COALESCE(cEU,0) AS cEu, COALESCE(cCC,0) AS cCC, '
        + 'COALESCE(bCH,0) AS bCH, COALESCE(bEU,0) AS bEU, COALESCE(bCC,0) AS bCC, Operator, '
        + ' ExchangeRateEuro, Comments FROM Pecunia WHERE ClosingID = ' +
        QuotedStr(workingday);
    IF rg_ClubOrCards.ItemIndex = 0 Then
      With Form2.qy_CalcPecunia do
      begin
        DataBaseName := 'DB_Main';
        If Active Then
          Close;
        SQL.Clear;
        SQL.Add(s);
        Active := True;

        IF HoursBetween(StDt, EnDt) > 24 Then
        begin
          ed_RecReal_CH.Value := FieldByName('cCHsum').AsFloat;
          ed_RecReal_EU.Value := FieldByName('cEUsum').AsFloat;
          ed_RecReal_CC.Value := FieldByName('cCCsum').AsFloat;
          ed_BarReal_CH.Value := FieldByName('bCHsum').AsFloat;
          ed_BarReal_EU.Value := FieldByName('bEUsum').AsFloat;
          ed_BarReal_CC.Value := FieldByName('bCCsum').AsFloat;
        end
        else If (Form2.qy_1000_CH.RecordCount > 0) AND
          NOT(Form2.qy_1000_CH.FieldByName('ClosingID').IsNull) Then
        begin
          ed_RecReal_CH.Value := FieldByName('cCH').AsFloat;
          ed_RecReal_EU.Value := FieldByName('cEU').AsFloat;
          ed_RecReal_CC.Value := FieldByName('cCC').AsFloat;
          ed_BarReal_CH.Value := FieldByName('bCH').AsFloat;
          ed_BarReal_EU.Value := FieldByName('bEU').AsFloat;
          ed_BarReal_CC.Value := FieldByName('bCC').AsFloat;
          lb_Cashier.Caption := FieldByName('Operator').AsString;
          mm_Comments.Text := FieldByName('Comments').AsString;
        end;
      end;
  end;

  // Offered and Canceled totals
  // ---------------------------
  WITH Form2.qy_TmpClosing DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(SUM(DARE),0) AS sD ' + 'FROM c_1000 AS c ' +
      'WHERE PayMethod = ''OF'' ' + ' AND Data ' + workingDayPeriod);
    Active := True;
    ed_Rec_OF.Value := FieldValues['sD'];
    Active := False;

    SQL.Clear;
    SQL.Add('SELECT COALESCE(SUM(DARE),0) AS sD ' + 'FROM c_1000 AS c ' +
      'WHERE Canceled = True ' + ' AND Data ' + workingDayPeriod);
    Active := True;
    ed_Rec_Canceled.Value := FieldValues['sD'];
    Active := False;
  END;

  xx_CalcCash(Sender);
  IF DaySpan(StDt, EnDt) <= 1 Then
    // ShowCCtoGirls(workingDayPeriod, True)
  else
    // ShowCCtoGirls(workingDayPeriod, True);

    {
      IF rg_ClubOrCards.ItemIndex = 1 Then
      begin
      IF InRange(uClientStore.ThisCard.cardID, 3000, 5999) THEN
      xx_FilterClosingTables(' ClientID = ' + intToStr(uClientStore.ThisClient.ID));
      ResetPosValues;
      end
      else
      xx_FilterClosingTables('');
    }
END;

Procedure TForm1.ResetRealValues;
begin
  ed_RecReal_CH.Value := 0;
  ed_RecReal_EU.Value := 0;
  ed_RecReal_CC.Value := 0;
  ed_BarReal_CH.Value := 0;
  ed_BarReal_EU.Value := 0;
  ed_BarReal_CC.Value := 0;
end;

Procedure TForm1.ResetPosValues;
begin
  ed_RecPos_CH.Value := 0;
  ed_RecPos_EU.Value := 0;
  ed_RecPos_CC.Value := 0;
  ed_BarPos_CH.Value := 0;
  ed_BarPos_EU.Value := 0;
  ed_BarPos_CC.Value := 0;
  ed_Ric_RT.Value := 0;
  ed_Bar_RT.Value := 0;
end;

Procedure TForm1.GetClosingBarData(CalStartDt, CalEndDt: TDateTime;
  workingDayPeriod: STRING);
begin
  With Form2.qy_TMPBar do
  begin
    If (Form2.qy_1000_CH.RecordCount > 0) AND
      NOT(Form2.qy_1000_CH.FieldByName('ClosingID').IsNull) Then
    begin
      ResetRealValues;
      // ResetPosValues;
    end;
    IF Active THEN
      Close;
    DataBaseName := 'DB_Bar';
    SQL.Clear;
    SQL.Add('SELECT PayMethod, COALESCE(SUM(Dare),0) AS aS,COALESCE(SUM(Avere),0) AS avereS '
      + ' FROM Bar_OpLedger ' + 'WHERE Data  ' + workingDayPeriod +
      ' GROUP BY PayMethod');
    Active := True;
    IF RecordCount > 0 THEN
      WHILE NOT EOF DO
      BEGIN
        IF Trim(FieldByName('PayMethod').AsString) = 'CH' THEN
        begin
          FCashCHBaravailable := FieldValues['aS'];
          ed_BarPos_CH.Value := FieldValues['aS'];
        end;
        IF Trim(FieldByName('PayMethod').AsString) = 'EU' THEN
        begin
          FCashEUBaravailable := FieldValues['aS'];
          ed_BarPos_EU.Value := FieldValues['aS'];
        end;
        IF Trim(FieldByName('PayMethod').AsString) = 'CC' THEN
          ed_BarPos_CC.Value := FieldValues['aS'];
        IF Trim(FieldByName('PayMethod').AsString) = '' THEN
          ed_BarPos_CH.Value := FieldValues['aS'];
        IF Trim(FieldByName('PayMethod').AsString) = 'OT' THEN
          ed_Bar_OF.Value := FieldValues['aS'];
        IF Trim(FieldByName('PayMethod').AsString) = 'RT' THEN
        begin
          ed_Bar_RT.Value := FieldValues['avereS'];
          ed_Ric_RT.Value := FieldValues['aS'];
        end;
        Next;
      END;
    Active := False;
  end;
end;

PROCEDURE TForm1.clk_TeseuCkOutAlarm(Sender: TObject);
BEGIN
  IF NOT cb_AutomaticCheckOut.Checked THEN
  BEGIN
    IF MessageDlg
      ('È ora di eseguire i CheckOut per l''elenco Teseu. Procedi con la stampa?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes THEN
      // tm_CheckOutTimer(Sender);
  END
END;

PROCEDURE TForm1.Chiusura_calGetDateText(Sender: TObject; Date: TDateTime;
  AFont: TFont; VAR AText: STRING);
BEGIN
  IF Date <= IncDay(Today, 1) Then
  Begin
    FOR var I := LOW(openPeriod_Arr) TO HIGH(openPeriod_Arr) DO
    begin
      IF openPeriod_Arr[I] = Date THEN
      begin
        AFont.Color := clRed;
        AFont.Style := [fsBold];
        AFont.Size := 12;
      end;
    end;
  End;
END;

procedure TForm1.edRaffleQRButtonClick(Sender: TObject);
begin
  edRaffleQR.Clear;
end;

procedure TForm1.edRaffleQRChange(Sender: TObject);
var
  sT: TRaffleCheck;
  Code: string;
begin
  Code := Trim(edRaffleQR.Text);
  sT := CheckRaffleQR(Code);
  btnPrintRafflePrice.Enabled := sT = rcValid;

  FRaffleMsg := '';
  case sT of
    rcAlreadyPrinted:
      FRaffleMsg := 'Questa vincita è già stata stampata!';
    rcInvalid:
      if Length(Code) = 13 then
        FRaffleMsg := 'Codice non valido per una vincita!';
  end;

  tmrRaffleMsg.Enabled := False; // restart the delay on every change
  tmrRaffleMsg.Enabled := FRaffleMsg <> '';
end;

PROCEDURE TForm1.ed_AssPwdChange(Sender: TObject);
BEGIN
  bt_AssignTo.Visible := ed_AssPwd.Text = ed_AssVatPwd.Text;
END;

PROCEDURE TForm1.dbed_FNameChange(Sender: TObject);
BEGIN
  // dbed_FName.Text := TitleCase(dbed_FName.Text);
END;

PROCEDURE TForm1.dbed_FNameExit(Sender: TObject);
BEGIN
  WITH Form2, qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Clients ' + 'WHERE FirstName = ' +
      QuotedStr(Trim(tb_ClientiClients.FieldByName('FirstName').AsString)) +
      ' AND LastName = ' +
      QuotedStr(Trim(tb_ClientiClients.FieldByName('LastName').AsString)));
    Active := True;
    IF RecordCount > 0 THEN
      ShowMessage('Esiste già una cliento con lo stesso nome e cognome!' +
        #13#10 + 'Controlla se sitratta della stessa persona.');
  END;
END;

PROCEDURE TForm1.tm_ListEvents0Timer(Sender: TObject);
BEGIN
  IF (DayOfWeek(Date) = 1) AND (cb_PrntTeseuList.Checked) AND
    ((TimeOf(Now) > IncMinute(TimeOf(ed_CT_Sat.DateTime), -16)) AND
    (TimeOf(Now) < TimeOf(ed_CT_Sat.DateTime))) THEN
  // Saturday, 20 min before closing time
  BEGIN
    ShowMessage('Ricordati di controllare il Token?');
    tm_List.Events[0].Interval := tm_List.Events[0].Interval + 60000;
    tm_List.Events[0].Cycled := False;
  END;
END;

procedure TForm1.tm_ListEvents3Timer(Sender: TObject);
begin
  bt_ClosePeriod.Caption := 'CHIUSURA EFFETTUATA';
  // bt_ClosePeriod.Enabled := False;
end;

PROCEDURE TForm1.tm_ExpiredFeesResetTimer(Sender: TObject);
BEGIN
  // xx_SetExpiredFeesToFalse;
  lb_LstFeeResetDT.Caption := DateTimeToStr(Now);
END;

PROCEDURE TForm1.dbgd_RoomsCellClick(Column: TColumnEh);
BEGIN

  WITH Form2 DO
  BEGIN
    IF (Column.FieldName = 'Enabled') THEN
      WITH tb_Cassa_Services DO
      BEGIN
        Edit;
        Post;
        MGuardClient1.MgRecordType := 'C';
        MGuardClient1.MgCommandCode := '37';
        MGuardClient1.MgEventDescr := ledOff;
        MGuardClient1.MgDeviceAddress :=
          Format('%.*d',
          [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);
        MGuardClient1.SendToMGuardSrv;
        Sleep(sleepTm);
        MGuardClient1.MgRecordType := 'C';
        MGuardClient1.MgCommandCode := '37';
        IF FieldByName('Enabled').AsBoolean = True THEN
          MGuardClient1.MgEventDescr := ledRed
        ELSE
          MGuardClient1.MgEventDescr := ledGreen;
        MGuardClient1.MgDeviceAddress :=
          Format('%.*d',
          [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);
        MGuardClient1.SendToMGuardSrv;
      END;

    IF Column.FieldName = 'ServiceName' THEN
      WITH Form2.tb_Cassa_SS DO
      BEGIN
        Filtered := False;
        Filter := 'ServiceID = ' +
          QuotedStr(Form2.tb_Cassa_Services.FieldByName('ServiceName')
          .AsString);
        Filtered := True;
      END;

    {
      IF (Column.FieldName = 'LastAlias') AND
      (tb_Cassa_Services.FieldByName('LastAlias').AsString <> '') THEN
      IF tb_Cards.Locate('ID', tb_Cassa_Services.FieldByName('CardInID')
      .AsInteger, []) THEN
      IF tb_ClientiClients.Locate('ID', tb_Cards.FieldByName('ClientID')
      .AsInteger, []) THEN
      ShowCourtesanImage(True, tb_ClientiClients.FieldByName('ID')
      .AsInteger, '');
    }

  END;
END;

PROCEDURE TForm1.dbgd_RoomsGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; VAR Background: TColor; State: TGridDrawState);
VAR
  fColor, bColor: TColor;
  I: STRING;
BEGIN
  fColor := AFont.Color;
  bColor := Background;
  WITH Form2.tb_Cassa_Services DO
  BEGIN
    IF Column.ID = 4 THEN
      I := FieldByName('LastAlias').AsString;

    IF FieldByName('LastEventDescr').AsString = 'A L L A R M E' THEN
    BEGIN
      AFont.Color := clWhite;
      Background := clRed;
    END
    ELSE IF (FieldByName('LastEventDescr').AsString = 'Abbandonata') OR
      (FieldByName('LastEventDescr').AsString = 'Da pulire!') THEN
    BEGIN
      AFont.Color := clWhite;
      Background := clGray;
    END
    ELSE IF FieldByName('LastEventDescr').AsString = 'Occupata' THEN
    BEGIN
      AFont.Color := fColor;
      Background := $00DAFACA;
    END
    ELSE IF (Column.ID = 4) AND (FieldByName('LastAlias').AsString <> '') AND
      ((FieldByName('CardInID').AsInteger = 0) OR
      ((FieldByName('CardInID').AsInteger >= 9000) AND
      (FieldByName('CardInID').AsInteger <= 9900))) THEN
      AFont.Color := clSilver
    ELSE IF FieldByName('LastEventDescr').AsString = 'Richiesto Controllo' THEN
    BEGIN
      AFont.Color := clWhite;
      Background := clBlack;
    END
    ELSE IF (FieldByName('LastEventDescr').AsString = 'Aperto senza tessera') OR
      (FieldByName('LastEventDescr').AsString = 'Chiuso senza tessera') THEN
    BEGIN
      AFont.Color := clWhite;
      Background := $970295;
    END
    ELSE
    BEGIN
      AFont.Color := fColor;
      Background := bColor;
    END;
  END;
END;

PROCEDURE TForm1.dbgd_RoomsKeyDown(Sender: TObject; VAR Key: Word;
  Shift: TShiftState);
BEGIN
  IF (Key = VK_DELETE) AND (Shift = [ssCtrl]) THEN
    Key := 0;
END;

procedure TForm1.dbgd_TabsOpenDblClick(Sender: TObject);
Var
  remarksName, DateThreshold: String;
  bOK: Boolean;
begin
  DateThreshold := FormatDateTime('yyyy-MM-dd HH:mm:ss', IncDay(sDt, -1));
  remarksName := Form2.qy_TabsOpen.FieldByName('Remarks').AsString;
  With Form2.qy_TMPBar do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT MIN(bol.Data) AS Data,   ''RT'' AS PayMethod, ' +
      '  MIN(bol.Waiter) AS Waiter, a.Balance, ' +
      '  SUBSTRING(a.TxID, 8) AS tID, a.TxID,  r.Remarks ' + 'FROM ( SELECT ' +
      ' TxID, SUM(COALESCE(Avere,0) - COALESCE(Dare,0)) AS Balance ' +
      ' FROM Bar_OpLedger ' + '  WHERE Data > :cutoff AND PayMethod = ''RT'' ' +
      '  GROUP BY TxID ' +
      '  HAVING SUM(COALESCE(Avere,0) - COALESCE(Dare,0)) > 0 ' +
      ') a JOIN Bar_OpLedger bol ON bol.TxID = a.TxID ' +
      'LEFT JOIN Bar_TabRemarks r ON r.TxID = a.TxID ' +
      ' WHERE Remarks = :SpecialClient ' +
      'GROUP BY a.TxID, a.Balance, r.Remarks, SUBSTRING(a.TxID, 8)';

    Params.ParamByName('cutoff').AsDateTime := IncDay(sDt, -1);
    Params.ParamByName('SpecialClient').AsString := remarksName;
    Active := True;

    // Reset previous doubleclick results
    // -------------------------------------------------------------------------
    IF RecordCount > 0 Then
      bt_CancelAllClick(nil);

    // Write RT to Otab
    // -------------------------------------------------------------------------
    First;
    while not EOF do
    begin
      with Form2.tb_oTab do
      begin
        Insert;
        FieldByName('Data').AsDateTime := Now;
        FieldByName('ClientID').AsInteger := 0;
        FieldByName('CardID').AsInteger := 0;
        FieldByName('FeeID').AsInteger := 8;
        FieldByName('SubfeeID').AsInteger := 800;
        FieldByName('CostCenter').AsString := 'b';

        FieldByName('Description').AsString := 'Vendita bar pag. ricez. ' +
          Form2.qy_TMPBar.FieldByName('Remarks').AsString;

        FieldByName('AmountCHF').AsFloat := Form2.qy_TMPBar.FieldByName
          ('Balance').AsFloat;

        if ts_EuroXchange.On then
          FieldByName('AmountEuro').AsFloat :=
            GetEuroFee(Form2.qy_TMPBar.FieldByName('Balance').AsFloat)
        else
          FieldByName('AmountEuro').AsFloat := Form2.qy_TMPBar.FieldByName
            ('Balance').AsFloat;

        FieldByName('amountToPrint').AsFloat :=
          Form2.qy_TMPBar.FieldByName('Balance').AsFloat;

        FieldByName('CH').AsBoolean := True;
        FieldByName('EU').AsBoolean := True;
        FieldByName('CC').AsBoolean := True;
        FieldByName('PD').AsBoolean := False;
        FieldByName('OF').AsBoolean := True;
        FieldByName('dAccount').AsInteger := 1000;
        FieldByName('aAccount').AsInteger := 5000;

        FieldByName('TxID').AsString := Form2.qy_TMPBar.FieldByName
          ('TxID').AsString;

        FieldByName('Operator').AsString := Form2.qy_TMPBar.FieldByName
          ('Waiter').AsString;
        Post;
      end;

      Next;
    end;
    dbgd_CashierDisplay.Refresh;
    bOK := Form2.qy_TabsOpen.RecordCount > 0;
    bt_CH.Enabled := bOK;
    bt_EU.Enabled := bOK;
    bt_CC.Enabled := bOK;
    bt_PD.Enabled := False;
    bt_OF.Enabled := False;
    Form2.qy_TabsOpen.Locate('Remarks', remarksName, []);
  end;
end;

procedure TForm1.dbgd_TabNowCellClick(Column: TColumnEh);
begin
  thtm_BarRT.Enabled := False;
end;

procedure TForm1.dbgd_TabNowExit(Sender: TObject);
begin
  thtm_BarRT.Enabled := True;
end;

procedure TForm1.dbgd_TabNowGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if FInTimerRefresh and (gdSelected in State) then
  begin
    Background := dbgd_TabsOpen.Color;
    AFont.Color := dbgd_TabsOpen.Font.Color;
  end;
end;

PROCEDURE TForm1.dbgd_TabsOpenCellClick(Column: TColumnEh);
Var
  txID: String;
  amt: Double;
BEGIN
  // Check if openTab table empty- if not check if txid already payed
  // ---------------------------------------------------------------------------
  FShowRowSel := True;
  dbgd_TabsOpen.Invalidate;

  If Form2.tb_oTab.RecordCount > 0 Then
    Exit
  else
  begin
    WitH Form2.qy_TMP do
    begin
      txID := Form2.qy_TabsOpen.FieldByName('TxID').AsString;
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT TXID, Dare FROM c_1000 ' + ' WHERE TXID = ' +
        QuotedStr(txID);
      Open;
      If (RecordCount > 0) And (FieldByName('Dare').AsFloat > 0) AND
        (FieldByName('TxID').AsString = txID) Then
        Exit;
    end;
  end;

  WITH Form2.qy_OTabDet DO
  BEGIN
    bt_Read_Click(Nil);
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Text :=
      'SELECT Bar_OpLedger.ProductID,Bar_OpLedger.PayMethod, Bar_OpLedger.Avere As Avere,Bar_OpLedger.UnitsSold, '
      + 'Bar_OpLedger.VolSold, Bar_Opledger.TxID, Bar_Products.ProductName ' +
      'FROM Bar_OpLedger ' +
      'INNER JOIN Bar_Products ON ProductID=Bar_Products.ProductID ' +
      'Where txID = ' + QuotedStr(Form2.qy_TabsOpen.FieldByName('TxID')
      .AsString);
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      bt_Register.Enabled := True;
      barTxId := Form2.qy_TabsOpen.FieldByName('TxID').AsString;
      dbgd_TabNow.Columns[2].Footers[0].Value := barTxId;
      dbgd_TabNow.Refresh;
      IF FieldValues['PayMethod'] = 'RT' THEN
        lb_Tabs.Caption := 'Scontrino aperto da pagare da ' +
          Form2.qy_TabsOpen.FieldByName('Remarks').AsString
      ELSE
        lb_Tabs.Caption := 'Ultimo scontrino bar';
      NumKeyboard.lb_ChoseCategory.Visible := False;
      NumKeyboard.pl_Buttons.Visible := False;
      bt_Register.Enabled := True;
      bt_CH.Enabled := True;
      bt_EU.Enabled := True;
      bt_CC.Enabled := True;
      bt_PD.Enabled := False;
      bt_OF.Enabled := False;

      thtm_BarRT.Enabled := False;
      // Stop thtm_BarRT until xx_WriteOtabToAccounts done

      WriteRTtoOTab;
      bt_Register.Enabled := False;
    END;
  END;

END;

Procedure TForm1.WriteRTtoOTab;
begin
  IF Not InRange(uClientStore.ThisCard.cardID, 9000, 9099) THEN
  BEGIN
    nnWriteCashierDisplay(0, True, clYellow,
      'Tessera non valida per questa registrazione', 1);
    nnWriteCashierDisplay(0, False, clWhite,
      'Tessere valide dal 9000 al 9999', 2);
    Exit;
  END;

  tm_ExpiredFeesReset.Enabled := False;
  WITH Form2 DO
  BEGIN
    // Fill Cashier Display
    // --------------------
    WITH tb_oTab DO
    BEGIN
      Insert;
      FieldByName('Data').AsDateTime := Now;
      FieldByName('ClientID').AsInteger := 0;
      FieldByName('CardID').AsInteger := 0;
      FieldByName('FeeID').AsInteger := 8;
      FieldByName('SubfeeID').AsInteger := 800;
      // Bar RT (reception ticket) payment
      FieldByName('CostCenter').AsString := 'b';
      FieldByName('Description').AsString := 'Vendita bar pag. ricez. ' +
        qy_TabsOpen.FieldByName('Remarks').AsString;
      FieldByName('AmountCHF').AsFloat :=
        qy_TabsOpen.FieldByName('Balance').AsFloat;

      IF ts_EuroXchange.On Then
        FieldByName('AmountEuro').AsFloat :=
          GetEuroFee(qy_TabsOpen.FieldByName('Balance').AsFloat)
      Else
        FieldByName('AmountEuro').AsFloat :=
          qy_TabsOpen.FieldByName('Balance').AsFloat;

      FieldByName('amountToPrint').AsFloat :=
        qy_TabsOpen.FieldByName('Balance').AsFloat;
      FieldByName('CH').AsBoolean := True;
      FieldByName('EU').AsBoolean := True;
      FieldByName('CC').AsBoolean := True;
      FieldByName('PD').AsBoolean := False;
      FieldByName('OF').AsBoolean := True;
      FieldByName('dAccount').AsInteger := 1000;
      FieldByName('aAccount').AsInteger := 5000;
      FieldByName('TxID').AsString := qy_TabsOpen.FieldByName('TxID').AsString;
      FieldByName('Operator').AsString :=
        qy_TabsOpen.FieldByName('Waiter').AsString;
      Post;
      dbgd_CashierDisplay.Refresh;
    END;
    nnWriteCashierDisplay(0, True, clWhite, 'Scontrino Bar ' +
      qy_TabsOpen.FieldByName('tID').AsString + ': ' + FormatFloat('0.00',
      qy_TabsOpen.FieldByName('Balance').AsFloat), 0);
    nnWriteCashierDisplay(0, False, clWhite,
      'Pronto per registrare pagamento', 1);
    NumKeyboard.pl_Buttons.Enabled := False;
    NumKeyboard.pl_Keys.Enabled := False;
    NumKeyboard.ed_Description.Text := 'Vendita bar pag. ricez. ' +
      qy_TabsOpen.FieldByName('Remarks').AsString;
  END;
end;

Procedure TForm1.ShowDetailOpenBarTab;
var
  DateThreshold: string;
begin
  // Pre-calculate the date string to avoid function calls in SQL
  DateThreshold := FormatDateTime('yyyy-MM-dd HH:mm:ss', IncDay(sDt, -1));

  WITH Form2.qy_TabsOpen DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT ' + sLineBreak + '  MIN(bol.Data)           AS Data, ' +
      '  ''RT''                  AS PayMethod, ' +
      '  MIN(bol.Waiter)         AS Waiter, ' + sLineBreak + '  a.Balance, ' +
      '  SUBSTRING(a.TxID, 8)    AS tID, ' + '  a.TxID, ' + '  r.Remarks ' +
      sLineBreak + 'FROM ( ' + sLineBreak + '  SELECT ' + sLineBreak +
      '    TxID, ' + '    SUM(COALESCE(Avere,0) - COALESCE(Dare,0)) AS Balance '
      + sLineBreak + '  FROM Bar_OpLedger ' + sLineBreak +
      '  WHERE Data > :cutoff AND PayMethod = ''RT'' ' + sLineBreak +
      '  GROUP BY TxID ' + sLineBreak +
      '  HAVING SUM(COALESCE(Avere,0) - COALESCE(Dare,0)) > 0 ' + sLineBreak +
      ') a ' + sLineBreak + 'JOIN Bar_OpLedger bol ON bol.TxID = a.TxID ' +
      sLineBreak + 'LEFT JOIN Bar_TabRemarks r ON r.TxID = a.TxID ' + sLineBreak
      + 'GROUP BY a.TxID, a.Balance, r.Remarks, SUBSTRING(a.TxID, 8)';

    Params.ParamByName('cutoff').AsDateTime := IncDay(sDt, -1);

    Active := True;
    IF RecordCount > 0 Then
    begin
      dbgd_TabsOpen.Refresh;
      dbgd_TabsOpen.SumList.RecalcAll;
    end;
  END;

end;

FUNCTION TForm1.IsIntegerInCommaDelimitedString(Value: Integer;
  CONST DelimitedString: STRING): Boolean;
VAR
  StringList: TStringList;
BEGIN
  StringList := TStringList.Create;
  TRY
    StringList.CommaText := DelimitedString;
    Result := StringList.IndexOf(intToStr(Value)) <> -1;
  FINALLY
    StringList.Free;
  END;
END;

PROCEDURE TForm1.bt_AssignToClick(Sender: TObject);
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    // Check if client has valid entry fee
    // -----------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT SoldDT FROM ServicesSold WHERE Clientid = ' +
      intToStr(uClientStore.ThisClient.ID) + ' AND FeeID = 3 AND ' +
      'SoldDT BETWEEN CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',
      sDt)) + ' AS Timestamp) ' + ' AND CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) + ' as Timestamp)');
    Active := True;
    IF RecordCount <= 0 THEN
    BEGIN
      ShowMessage(uClientStore.ThisClient.alias +
        ' non ha un''entrata valida per oggi!' + #13#10 +
        'Non puoi assegnare il drink.');
      Active := False;
      Exit;
    END;
  END;

  IF MessageDlg('Confermi l''assegnazione di questo drink a ' +
    uClientStore.ThisClient.alias + '?', mtConfirmation, [mbOK, mbNo], 0, mbNo)
    = mrOk THEN
  BEGIN
    IF (uClientStore.ThisClient.alias <> lb_AssignedTo.Caption) AND
      (lb_AssignedTo.Caption <> 'nessuno') THEN
      Form2.t_executequery('UPDATE Bar_SoldByDetail SET SoldBy = ' +
        intToStr(uClientStore.ThisClient.ID) + 'WHERE TxID = ' +
        QuotedStr(Form2.qy_BarOpLedger.FieldByName('TxID').AsString), 'DB_Bar',
        'PGC_Bar', 'Bar_SoldByDetail');

    IF lb_AssignedTo.Caption = 'nessuno' THEN
      Form2.t_executequery
        ('INSERT INTO Bar_SoldByDetail (Data,ProductID,UnitsSold,' +
        ' SaleAmt,CommAmt,Waiter,SoldBy,TxID, ' + 'VALUES (CAST(' +
        QuotedStr(Form2.EDBEngine1.DateToSQLStr(Now)) + ' AS TIMESTAMP),' +
        QuotedStr(Form2.qy_BarOpLedger.FieldByName('ProductID').AsString) +
        ', 1, ' + floatToStr(Form2.qy_BarOpLedger.FieldByName('Avere').AsFloat)
        + ', ' + floatToStr(ed_VatTax.Value) + ', ' + QuotedStr(cashier) + ', '
        + intToStr(uClientStore.ThisClient.ID) + ', ' +
        QuotedStr(Form2.qy_BarOpLedger.FieldByName('TxID').AsString), 'DB_Bar',
        'PGC_Bar', 'Bar_SoldByDetail');
  END;
END;

PROCEDURE TForm1.bt_CancelAllClick(Sender: TObject);
BEGIN
  IF RR_Rooms.Showing THEN
    RR_Rooms.Close;
  nnSetCashierDisplayColor(clLime);
  xx_CancelAll(True);
  bt_Cancel.Enabled := False;
  ShowHideBottomBtns(True, True, True, True);
  dbgd_CashierDisplay.SumList.RecalcAll;
  cg_CashierKeyboard.Enabled := True;
  dbgd_CashierDisplay.TitleParams.Color := clSilver;
  Form1.bt_CC.Caption := 'CC';
  nnSetPecuniaBtUp;
END;

PROCEDURE TForm1.nnSetCashierDisplayColor(clr: TColor);
BEGIN
  WITH dbgd_CashierDisplay DO
  BEGIN
    Font.Color := clr;
    FooterFont.Color := clr;
  END;
END;

PROCEDURE TForm1.xx_CancelAll(ResetDisplay: Boolean);
BEGIN
  NumKeyboard.btnCloseBustaPLClick(Nil);
  VTtxId := '';
  nActiveFeeID := -1;
  nSameFeeCount := 0;
  nSubFeeID := 0;
  clickedFee := 0;
  nIsOpenAmt := False;
  nClosingOldBal := False;
  bt_Register.Caption := '';
  bt_Register.Enabled := False;
  bt_Cancel.Enabled := False;
  cg_CashierKeyboard.Enabled := True;
  // dbgd_Rooms.Refresh;
  nn_EnablePecuniaBt(False);
  IF NumKeyboard.Showing THEN
    NumKeyboard.Close;
  dbgd_CashierDisplay.Options := dbgd_CashierDisplay.Options -
    [DBGridEh.dgAlwaysShowSelection];

  // Do not use here t_executeQuery!!!

  WITH Form2, qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    SQL.Add('DELETE FROM OpenTab');
    ExecSQL;
    tb_oTab.Refresh
  END;

  WITH Form2, qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('DELETE FROM OpenTabMemory');
    ExecSQL;
    tb_OTabMemory.Refresh
  END;

  IF ResetDisplay THEN
  BEGIN
    Finalize(LastTxData);
    FillChar(LastTxData, SizeOf(LastTxData), 0);
    Finalize(uClientStore.ThisClient);
    FillChar(uClientStore.ThisClient, SizeOf(uClientStore.ThisClient), 0);
    dbgd_CashierDisplay.Refresh;
  END;
  dbgd_CashierDisplay.SumList.RecalcAll;
  mm_Cashier.Clear;
  validFeeResult := -1;
  RentalData := Default (TRental);
  If thtm_BarRT.Enabled = False Then
    thtm_BarRT.Enabled := True;
END;

PROCEDURE TForm1.PrintCleaningSheet(printIt: Boolean);
VAR
  tmpPrntStr: TStrings;
  s: STRING;
BEGIN
  IF cb_PrintRoomUse.Checked THEN // verificare
  BEGIN
    mm_CleaningInfo.Clear;
    tmpPrntStr := TStringList.Create;
    WITH Form2.qy_TMP DO
    BEGIN
      IF Active THEN
        Close;
      // DataSource := Form2.sc_Services;
      SQL.Clear;
      SQL.Add('SELECT ID,USEDWITHOUTCLEAN FROM Services WHERE USEDWITHOUTCLEAN > 0');
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        tmpPrntStr.Add(' ');
        tmpPrntStr.Add(intToStr(DayOf(Date)));
        tmpPrntStr.Add(' ');
        tmpPrntStr.Add('--------------------');
        tmpPrntStr.Add(' ');
        WHILE NOT EOF DO
        BEGIN
          s := StringOfChar('*', FieldByName('USEDWITHOUTCLEAN').AsInteger);
          IF FieldByName('ID').AsInteger = 25 THEN
            tmpPrntStr.Add('VIP  ' + Pad('> > >', 12) + ': usato ')
          ELSE
            tmpPrntStr.Add(#$2610 + ' ' + Format('%2d',
              [FieldByName('ID').AsInteger]) + ':  ' + s);
          Next;
        END;
        Close;
        UnPrepare;
      END;
      // Now get rental room departures
      // ------------------------------
      tmpPrntStr.Add('--------------------');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add('Partenze abit. tra ieri/oggi');
      tmpPrntStr.Add('--------------------');
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT ' + ' rr.GuestID, ' + ' cl.Alias, ' + ' rr.CheckOutDate, '
        + ' rb.Name, ' + ' rr.BookingStatus ' + 'FROM RREU_Bookings rr ' +
        'LEFT JOIN Clients cl ' + '  ON rr.GuestID = cl.ID ' +
        'LEFT JOIN RREU_Buildings rb ' +
        '  ON CAST(SUBSTRING(rr.BookingStatus, 1, 2) AS INT) = rb.BuildingID ' +
        'WHERE rr.CheckOutDate BETWEEN ' + 'CAST(' +
        QuotedStr(Form2.EDBEngine1.DateToSQLStr(Now - 1)) + ' AS DATE) ' +
        'AND CAST(' + QuotedStr(Form2.EDBEngine1.DateToSQLStr(Now)) +
        ' AS DATE)');
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        First;
        WHILE NOT EOF DO
        BEGIN
          tmpPrntStr.Add(#$2610 + ' ' + FieldByName('Name').AsString + ' Cam ' +
            Copy(FieldByName('BookingStatus').AsString, 8, 1) + ' ' +
            FieldByName('Alias').AsString);
          Next;
        END;
      END
      ELSE
      BEGIN
        tmpPrntStr.Add('Al momento nessuna partenza tra ieri e domani');
        tmpPrntStr.Add(' ');
      END;
      tmpPrntStr.Add('--------------------');
      tmpPrntStr.Add('OSSERVAZIONI (da aggiungere a mano)');
      tmpPrntStr.Add('--------------------');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add(' ');
      tmpPrntStr.Add('--------------------');
      tmpPrntStr.Add('Resp Ricez: ' + cashier);
      tmpPrntStr.Add('--------------------');
      mm_CleaningInfo.Lines.AddStrings(tmpPrntStr);
      If printIt then
        IF GetCurrentPrinterStatus = 0 THEN
          Form2.t_executePrint_(rg_Printers.Items[rg_Printers.ItemIndex],
            tmpPrntStr, 0, 1, 4, 120, False, False)
        ELSE
          ShowMessage('ATTENZIONE, Errore stampante no: ' +
            intToStr(GetCurrentPrinterStatus));
    END;
    s := 'UPDATE Services SET UsedWithoutClean = 0 WHERE ID = 25';
    // Reset Vip lounge use
    Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
  END;
END;

PROCEDURE TForm1.PrintManutNotes(printIt: Boolean);

var
  Rich: TRichEdit;
  RtfStream: TStringStream;
  Timestamp: String;
begin
  // 1. Select the printer from your radio-group
  Printer.PrinterIndex := rg_Printers.ItemIndex;
  // PrinterIndex selects which printer in Printer.Printers to use :contentReference[oaicite:0]{index=0}

  // 2. Create a hidden TRichEdit to render the RTF
  Rich := TRichEdit.Create(nil);
  try
    Rich.Parent := Self; // needed so the control has a valid window handle
    Rich.Visible := False; // keep it off-screen
    Rich.PlainText := False; // enable RTF mode

    // 3. Load the RTF out of your AdvRichEditor
    // ContentAsRTF returns the full RTF string :contentReference[oaicite:1]{index=1}
    RtfStream := TStringStream.Create(re_manutNotesEditor.ContentAsRTF,
      TEncoding.Default);
    try
      Rich.Lines.LoadFromStream(RtfStream);
    finally
      RtfStream.Free;
    end;

    // 3.1 Build a timestamp string
    Timestamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);

    // 3.2 Move the caret to the very end, set any desired attributes,
    // then add a blank line + the timestamp
    Rich.SelStart := Rich.GetTextLen;
    // (optional) match the default font of the rest of the doc:
    Rich.SelAttributes.Name := Rich.DefAttributes.Name;
    Rich.SelAttributes.Size := Rich.DefAttributes.Size;
    Rich.Lines.Add(''); // blank line
    Rich.Lines.Add(cashier + ' ' + Timestamp);
    Rich.Lines.Add('.'); // blank line
    Rich.Lines.Add('.'); // blank line

    // 4. Print — the string you pass here is the job name in the printer queue :contentReference[oaicite:2]{index=2}
    Rich.Print('My Document');
  finally
    Rich.Free;
  end;
end;

FUNCTION TForm1.CheckBirthDay(ClientID: Integer): Boolean;
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    DataSource := Form2.sc_Services;
    SQL.Clear;
    SQL.Add('SELECT Alias FROM Clients WHERE EXTRACT(DAY FROM birthdate) = EXTRACT(DAY FROM CURRENT_DATE) AND '
      + 'EXTRACT(MONTH FROM birthdate) = EXTRACT(MONTH FROM CURRENT_DATE) AND ID = '
      + intToStr(ClientID));
    Active := True;
    Result := RecordCount = 1;
    Close;
    UnPrepare;
  END;
END;

PROCEDURE TForm1.bt_CalculatorClick(Sender: TObject);
VAR
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
  ExecuteFile, StartInString: STRING;
BEGIN
  ExecuteFile := 'Calc.exe';
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  StartInString := 'c:\Windows\System32\';
  WITH SEInfo DO
  BEGIN
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpFile := PChar(ExecuteFile);
    // lpParameters := PChar(ParamString);
    { ParamString can contain the application parameters. }
    lpDirectory := PChar(StartInString);
    { StartInString specifies the name of the working directory.
      If ommited, the current directory is used. }
    nShow := SW_SHOWNORMAL;
  END;
  IF ShellExecuteEx(@SEInfo) THEN
  BEGIN
    REPEAT
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    UNTIL (ExitCode <> STILL_ACTIVE) OR Application.Terminated;
  END
  ELSE
    ShowMessage('Error starting Calc!');
END;

PROCEDURE TForm1.bt_PrintNotificheListClick(Sender: TObject);
BEGIN
  oldPrinterIdx := Printer.PrinterIndex;
  IF PrinterSetupDialog1.Execute THEN
  BEGIN
    ShowMessage('Printer SetUp is done.');
  END;

  Printer.PrinterIndex := oldPrinterIdx;
  Printer.Orientation := poPortrait;
END;

procedure TForm1.bt_PrintRaffleClick_Click(Sender: TObject);
var
  Code: string;
  Ts: TDateTime;
begin
  Code := NewRaffleNumber('xxxxxxxxxxxx'); // your transaction id
  Ts := Now;
  PrintRaffleTicket(ed_LotteryT.Text, Code, Ts);
  MarkRaffleNumberPrinted(Code, Ts);
end;

function TForm1.CheckRaffleQR(const ATxID: string): TRaffleCheck;
var
  Days: Integer;
  MinSold: TDateTime;
  Printed: Boolean;
begin
  Result := rcInvalid;
  With Form2 do
  begin
    if (Length(ATxID) <> 13) or
      tb_RafflePrice.FieldByName('ValidHowManyDays').IsNull then
      Exit;

    Days := tb_RafflePrice.FieldByName('ValidHowManyDays').AsInteger;
    MinSold := IncDay(Now, -Days);
    Printed := False;

    qry_RaffleCheck.Close;
    qry_RaffleCheck.SQL.Text :=
      'SELECT S.SoldDT, R.PrintedPriceDate ' +
      'FROM ServicesSold S ' +
      'JOIN RaffleNumber R ON R.TxID = S.TxID ' +
      'WHERE S.TxID = :TxID';
    qry_RaffleCheck.ParamByName('TxID').AsString := ATxID;
    qry_RaffleCheck.Open;
    try
      while not qry_RaffleCheck.EOF do
      begin
        if qry_RaffleCheck.FieldByName('PrintedPriceDate').IsNull then
        begin
          // unprinted row: valid if the sale is inside the allowed window
          if not qry_RaffleCheck.FieldByName('SoldDT').IsNull and
            (qry_RaffleCheck.FieldByName('SoldDT').AsDateTime >= MinSold) then
          begin
            Result := rcValid;
            Exit;
          end;
        end
        else
          Printed := True;
        qry_RaffleCheck.Next;
      end;
    finally
      qry_RaffleCheck.Close;
    end;

    if Printed then
      Result := rcAlreadyPrinted;
  end;
end;

function TForm1.IsRaffleQRValid(const ATxID: string): Boolean;
begin
  Result := CheckRaffleQR(ATxID) = rcValid;
end;

function TForm1.NewRaffleNumber(const ATxID: string): string;
var
  QIns, QSel: TEDBQuery;
  Attempt, idx, LI, DI: Integer;
  Candidate: string;
  Taken, FreeList: TStringList;

  function CodeExists(const ACode: string): Boolean;
  begin
    QSel.Close;
    QSel.ParamByName('v').AsString := ACode;
    QSel.Open;
    Result := not QSel.IsEmpty;
    QSel.Close;
  end;

// True = inserted and ours. False = rejected as duplicate, try another.
  function TryInsert(const ACode: string): Boolean;
  begin
    Result := True;
    QIns.ParamByName('v').AsString := ACode;
    QIns.ParamByName('tx').AsString := ATxID;
    try
      QIns.ExecSQL;
    except
      on E: EEDBError do
        if CodeExists(ACode) then
          Result := False // the UNIQUE constraint rejected it
        else
          raise; // engine, session or permission problem
    end;
  end;

begin
  // drop this check if a ticket may be issued without a transaction
  if ATxID = '' then
    raise Exception.Create('A TxID is required to register a raffle number.');
  if Length(ATxID) > 13 then
    raise Exception.CreateFmt('TxID "%s" exceeds the 13-character column.', [ATxID]);

  QIns := TEDBQuery.Create(nil);
  QSel := TEDBQuery.Create(nil);
  try
    QIns.SessionName := Form2.PGC_Session.SessionName; // <-- your session
    QIns.DataBaseName := Form2.DB_Main.DataBaseName; // <-- your database
    QIns.SQL.Text :=
      'INSERT INTO "RaffleNumber" ("RandomNumber", "TxID") VALUES (:v, :tx)';

    QSel.SessionName := Form2.PGC_Session.SessionName;
    QSel.DataBaseName := Form2.DB_Main.DataBaseName;
    QSel.SQL.Text := 'SELECT 1 FROM "RaffleNumber" WHERE "RandomNumber" = :v';

    // ---- fast path: random probing, fine while the table is mostly empty ----
    for Attempt := 1 to 60 do
    begin
      Candidate := RaffleLetters[Random(Length(RaffleLetters)) + 1] +
        Format('%.2d', [Random(100)]);
      if TryInsert(Candidate) then
        Exit(Candidate);
    end;

    // ---- slow path: table is crowded, enumerate what is left ----
    Taken := TStringList.Create;
    try
      Taken.Sorted := True; // IndexOf becomes a binary search
      Taken.Duplicates := dupIgnore;

      QSel.Close;
      QSel.SQL.Text := 'SELECT "RandomNumber" FROM "RaffleNumber"';
      QSel.Open;
      while not QSel.EOF do
      begin
        Taken.Add(QSel.Fields[0].AsString);
        QSel.Next;
      end;
      QSel.Close;
      QSel.SQL.Text := 'SELECT 1 FROM "RaffleNumber" WHERE "RandomNumber" = :v';

      FreeList := TStringList.Create;
      try
        for LI := 1 to Length(RaffleLetters) do
          for DI := 0 to 99 do
          begin
            Candidate := RaffleLetters[LI] + Format('%.2d', [DI]);
            if Taken.IndexOf(Candidate) < 0 then
              FreeList.Add(Candidate);
          end;

        // try the remaining codes in random order
        while FreeList.Count > 0 do
        begin
          idx := Random(FreeList.Count);
          Candidate := FreeList[idx];
          if TryInsert(Candidate) then
            Exit(Candidate);
          FreeList.Delete(idx); // another station took it meanwhile
        end;

        raise Exception.CreateFmt(
          'All %d raffle numbers have been used.',
          [Length(RaffleLetters) * 100]);
      finally
        FreeList.Free;
      end;
    finally
      Taken.Free;
    end;
  finally
    QSel.Free;
    QIns.Free;
  end;
end;

procedure TForm1.MarkRaffleNumberPrinted(const ACode: string; AWhen: TDateTime);
var
  Q: TEDBQuery;
begin
  Q := TEDBQuery.Create(nil);
  try
    Q.SessionName := Form2.PGC_Session.SessionName;
    Q.DataBaseName := Form2.DB_Main.DataBaseName;
    Q.SQL.Text :=
      'UPDATE "RaffleNumber" SET "PrintedDate" = :ts ' +
      'WHERE "RandomNumber" = :v AND "PrintedDate" IS NULL';
    Q.ParamByName('ts').AsDateTime := AWhen;
    Q.ParamByName('v').AsString := ACode;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

PROCEDURE TForm1.PrintTeseuList(Sender: TObject);
VAR
  s: STRING;
BEGIN
  WITH Form2.qy_FR_Teseu1 DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    s := ('Select Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Clients.IDTeseu, ServicesSold.Solddt'
      + ' From Clients Inner Join ServicesSold ON Clients.ID = ServicesSold.ClientID '
      + ' Where ServicesSold.FeeID = 3 AND Clients.IDTeseu <> ''''  GROUP BY Clients.LastName '
      + ' Having MAX(ServicesSold.Solddt) = CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd', YesterDay)) + ' AS DATE)' +
      ' Order By Clients.Alias');
    SQL.Add(s);
    Active := True;
    IF RecordCount > 0 THEN
      what2print :=
        'Clienti da togliere dall''elenco Teseu (Ieri presente, oggo non presente)'
    ELSE
      what2print :=
        'Non ci sono clienti da togliere dall''elenco Teseu (O appena arrivate o già presente ieri)';
    Active := False;
    UnPrepare;
  END;

  WITH Form2.qy_FR_Teseu2 DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    s := ('Select Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Clients.IDTeseu, ServicesSold.Solddt'
      + ' From Clients Inner Join ServicesSold ON Clients.ID = ServicesSold.ClientID '
      + ' Where ServicesSold.FeeID = 3 AND Clients.IDTeseu <> ''''  GROUP BY Clients.LastName '
      + ' Having MAX(ServicesSold.Solddt) = CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd', Today)) + ' AS DATE)' +
      ' Order By Clients.Alias');
    SQL.Add(s);
    Active := True;

    IF RecordCount > 0 THEN
      what2Print2 := 'Clienti presenti oggi da lasciare nell''elenco Teseu. '
    ELSE
      what2Print2 := 'Non ci sono clienti vecchi presenti oggi.';
    Active := False;
    UnPrepare;
  END;

  WITH Form2.qy_FR_Teseu3 DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    s := ('Select Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, Clients.IDTeseu, ServicesSold.Solddt '
      + ' From Clients Inner Join ServicesSold ON Clients.ID = ServicesSold.ClientID'
      + ' Where ServicesSold.FeeID = 3 AND Clients.IDTeseu <> '''' ' +
      ' Group by Clients.ID Having  MAX(ServicesSold.Solddt) = ' + ' CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd', Today)) +
      ' AS DATE) AND COUNT(Servicessold.FeeID) = 13');
    SQL.Add(s);
    Active := True;

    IF RecordCount > 0 THEN
      what2Print3 := 'Clienti arrivati oggi da registrare nell''elenco TESEU '
    ELSE
      what2Print3 :=
        'Non ci sono nuovo clienti da registrare nell''elenco Teseu';
    frxReportTESEU.LoadFromFile(GetInstallDrive +
      '\Program Files (x86)\PGC_510 - Tokyo - Chiasso - CC\TeseuList.fr3');
    IF frxReportTESEU.PrepareReport THEN
      frxReportTESEU.ShowPreparedReport;
    Active := False;
    UnPrepare;
  END;
END;

PROCEDURE TForm1.bt_PrintBarSummaryPeriodClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  WITH Form2.qy_FR_OpLedger DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    s := 'Select S.Closingid, sum(S.dare)as sD, sum(S.avere)as sA ' + 'From ( '
      + 'Select Closingid, Dare, Avere ' + 'From OpLedger ' +
      'WHERE OpLedger.Data BETWEEN CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) + ' AS Timestamp) '
      + 'AND CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
      ' as Timestamp) ' + 'AND ClosingID IS NOT NULL ' + 'UNION ALL ' +
      'Select Closingid, Dare, Avere ' + 'FROM ExpLedger ' +
      'WHERE Expense = False AND Description IS NOT NULL ' +
      'AND ExpLedger.Data BETWEEN CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) + ' AS Timestamp) '
      + 'AND CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
      ' as Timestamp)' + 'AND ExpLedger.ClosingID IS NOT NULL) ' + 'AS S ' +
      'GROUP BY S.ClosingID';
    SQL.Add(s);
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      what2print := 'RICAPITOLAZIONE  GIORNALIERA DAL ' + DateToStr(sDt) +
        ' al ' + DateToStr(IncDay(eDT, -1));
      frxReport2.LoadFromFile(GetInstallDrive +
        '\Program Files (x86)\PGC_510 - Tokyo - Chiasso - CC\FR_OpLedgerSummary.fr3');
      IF frxReport2.PrepareReport THEN
        frxReport2.ShowPreparedReport;
    END
    ELSE
      ShowMessage('Non ci sono registrazioni da stampare!');
    Active := False;
    UnPrepare;
  END;
END;

PROCEDURE TForm1.H_printImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  // PrintImagePixelPos(Sender, Button, Shift, X, Y);
END;

// Writes open PD positions
FUNCTION TForm1.xx_WritePdToOtab(comesFrom: STRING): Boolean;
VAR
  s, CH, EU, cc, PD: STRING;
  pdTxID, barTxId: STRING;
  eFee, cFee: Double;
  // ADate: TDateTime;
BEGIN
  eFee := 0;
  Result := False;
  WITH Form2 DO
  BEGIN
    tb_1200.Refresh;
    WITH qy_TMP DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      s := 'SELECT * FROM c_1200 WHERE ClientID = ' +
        intToStr(uClientStore.ThisClient.ID) +
        ' AND PayMethod = ''PD'' AND Canceled = False AND Dare > 0 ';
      SQL.Add(s);
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        Result := True;
        First;
        WHILE NOT EOF DO
        BEGIN
          amt := FieldByName('Dare').AsFloat;
          cFee := amt;
          eFee := GetEuroFee(amt);
          IF NOT qy_TMP.FieldByName('TxID').IsNull THEN
            pdTxID := qy_TMP.FieldByName('TxID').AsString;
          s := 'SELECT dAccount, aAccount,CH,EU,CC,PD ' +
            'FROM Fees  WHERE SubID = ' + qy_TMP.FieldByName
            ('SubFeeID').AsString;
          WITH qy_Tmp2 DO
          BEGIN
            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Add(s); // qy_TMP1
            Active := True;
            CH := BoolToStr(FieldByName('CH').AsBoolean, True);
            EU := BoolToStr(FieldByName('EU').AsBoolean, True);
            cc := BoolToStr(FieldByName('CC').AsBoolean, True);
            PD := 'False';
            s := 'INSERT INTO OpenTab (' +
              'ClientID,CardID,Data,Description,amountCHF,amountEuro,FeeID,SubFeeID,TxID,'
              + 'PayMethod,costCenter,Operator,dAccount,aAccount,CH,EU,CC,PD) '
              + 'SELECT ClientID,CardID,Data,Description,' + floatToStr(cFee) +
              ',' + floatToStr(eFee) + ',FeeID,SubFeeID,TxID,' +
              ' '''',costCenter,Operator,' + '1000' + ',' + '1200' + ', ' + CH +
              ',' + EU + ',' + cc + ',True ' + ' FROM c_1200 WHERE ClientID = '
              + intToStr(uClientStore.ThisClient.ID) + ' AND txID = ' +
              QuotedStr(pdTxID) + ' AND SubFeeID = ' +
              qy_TMP.FieldByName('SubFeeID').AsString +
              ' AND PayMethod = ''PD'' AND Canceled = False';

            WITH qy_Tmp2 DO
            BEGIN
              IF Active THEN
                Close;
              SQL.Clear;
              SQL.Add(s); // qy_Tmp2
              ExecSQL;
            END;

          END;
          Next;
          tb_oTab.Refresh;
        END;

        begin
          // Now check and update if client has bar bonus VT
          barTxId := CheckIfHasBarCredit(uClientStore.ThisClient.ID);
          If barTxId <> '' Then
          begin
            WITH qy_Tmp2 DO
            BEGIN
              IF Active THEN
                Close;
              SQL.Clear;
              SQL.Add('UPDATE OpenTab SET PayMethod = ''VT'', TmpTxID = ' +
                QuotedStr(barTxId) +
                ', amountEuro = NULL  WHERE SubFeeID = 9998');
              ExecSQL;
              tb_oTab.Refresh;
              nn_EnablePecuniaBt(False);
            End;
          END
        end;
      end
      else
        Result := False;
    END;
    tb_oTab.Refresh;
    If xx_GetLastValidTxData(comesFrom, uClientStore.ThisClient.ID) then
    begin
      Case xx_HandleValidFees(comesFrom) of
        40:
          Begin
            if comesFrom <> 'bt_MultiReg' then
              CASE TaskDlgHelperF.TaskDlg_Default('Gestione camere',
                'Camera non usata', uClientStore.ThisClient.alias + ' ha una ' +
                LastTxData.lTxFeeDesc + ' non usata.' + #13#10 +
                'REGISTRA come usata o AZZERA vendita?', 'REGISTRA', 'AZZERA',
                'NO', 'ExitRoom_48.ico') OF
                mrOk:
                  begin
                    xx_CloseUsedRoom;
                    nnWriteCashierDisplay(0, False, clLime,
                      'Camera chiusa.', 2);
                  end;
                mrNo:
                  begin
                    xx_CloseUnusedRoom;
                    bt_CancelClick(Nil);
                    nnWriteCashierDisplay(0, False, clLime, '', 1);
                    nnWriteCashierDisplay(0, False, clLime,
                      'Camera azzerata.', 2);
                    Exit
                  end;
              END;
          End;
        41:
          BEGIN
            If TaskDlgHelperF.TaskDlg_Default('Gestione camere',
              uClientStore.ThisClient.alias + ': Camera usata',
              uClientStore.ThisClient.alias + ' libera la ' +
              LastTxData.lTxFeeDesc + '?', 'Libera', 'NO', '',
              'ExitRoom_48.ico') = mrOk Then
            begin
              xx_CloseUsedRoom;
              nnWriteCashierDisplay(0, False, clLime, 'Camera chiusa.', 2);
            end
            else IF uClientStore.ThisClient.balanceDue = 0 Then
              bt_CancelAll.Click;
          END;
      End;
    end;
    bt_CH.Enabled := True;
    bt_EU.Enabled := True;
    bt_CC.Enabled := True;
    bt_PD.Enabled := False;
    bt_OF.Enabled := False;
    nnWriteCashierDisplay(0, False, clWhite, 'Scegli la valuta >>', 2)
  END;
  dbgd_CashierDisplay.SumList.RecalcAll;
END;

Procedure TForm1.GetRoomUseOverTime(ClientID, SubID: Integer);
Var
  TimeSpansUsed: Double;
  TimeSpansToPay: Integer;
  amt: Double;
begin
  with Form2.qy_TMP do
  begin
    If Active then
      Close;
    SQL.Clear;
    SQL.Text :=
      'SELECT Fee_OverTime, TimeSpan2Use FROM Fees ' +
      ' WHERE SubID = :SubID ';
    ParamByName('SubID').AsInteger := SubID;
    Open;
    var
    timeSpan := FieldByName('TimeSpan2Use').AsInteger;
    Var
    overTimeFee := FieldByName('Fee_OverTime').AsInteger;
    Close;

    If Active then
      Close;
    SQL.Clear;
    SQL.Text :=
      'SELECT StartUse, TxID ' +
      'FROM ServicesSold ' +
      'WHERE Valid = True ' +
      '  AND ClientID = :ClientID ' +
      ' AND SubFeeID = :SubID ';
    ParamByName('ClientID').AsInteger := ClientID;
    ParamByName('SubID').AsInteger := SubID;
    Open;
    IF (RecordCount > 0) and (FieldByName('StartUse').AsDateTime > 0) Then
    begin
      Var
      MinutesDiff := MinutesBetween(Now, FieldByName('StartUse').AsDateTime);
      var
      txID := FieldByName('TxID').AsString;
      IF MinutesDiff >= timeSpan Then
      begin
        // Get first how many times the over time amount is to pay
        TimeSpansUsed := MinutesDiff / timeSpan;
        IF Frac(TimeSpansUsed) > 0.1666 Then // (5 Minutes)
          TimeSpansUsed := Ceil(TimeSpansUsed)
        else
          TimeSpansUsed := Floor(TimeSpansUsed);
        amt := (TimeSpansUsed - 1) * overTimeFee;
        IF amt > 0 Then
          With Form2.qy_TMP do
          begin
            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Text := 'INSERT INTO c_1200' +
              ' (Data, ClientID, CardID, Description, Dare' +
              ', FeeID, SubFeeID,' +
              '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID)'
              + ' VALUES (CURRENT_TIMESTAMP, :clientID, :cardID, :descr, :amt,' +
              '         :feeID, :subFeeID, :verified, :canceled,' +
              '         :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid)';

            Params.ParamByName('clientID').AsInteger := ClientID;
            Params.ParamByName('cardID').AsInteger := ThisClient.cardID;
            Params.ParamByName('descr').AsString := 'Suppl tempo uso Sub Light';
            Params.ParamByName('amt').AsFloat := amt;
            Params.ParamByName('feeID').AsInteger := 5;
            Params.ParamByName('subFeeID').AsInteger := 509;
            Params.ParamByName('verified').AsBoolean := False;
            Params.ParamByName('canceled').AsBoolean := False;
            Params.ParamByName('payMethod').AsString := 'PD';
            Params.ParamByName('costCenter').AsString := 'c';
            Params.ParamByName('operator').AsString := Trim(cashier);
            Params.ParamByName('receipt').AsBoolean := False;
            Params.ParamByName('cPartita').AsInteger := 5000;
            Params.ParamByName('txid').AsString := txID;
            ExecSQL;

            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Text := 'INSERT INTO c_5000' +
              ' (Data, ClientID, CardID, Description, Avere' +
              ', FeeID, SubFeeID,' +
              '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID)'
              + ' VALUES (CURRENT_TIMESTAMP, :clientID, :cardID, :descr, :amt,' +
              '         :feeID, :subFeeID, :verified, :canceled,' +
              '         :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid)';

            Params.ParamByName('clientID').AsInteger := ClientID;
            Params.ParamByName('cardID').AsInteger := ThisClient.cardID;
            Params.ParamByName('descr').AsString := 'Suppl tempo uso Sub Light';
            Params.ParamByName('amt').AsFloat := amt;
            Params.ParamByName('feeID').AsInteger := 5;
            Params.ParamByName('subFeeID').AsInteger := 509;
            Params.ParamByName('verified').AsBoolean := False;
            Params.ParamByName('canceled').AsBoolean := False;
            Params.ParamByName('payMethod').AsString := 'PD';
            Params.ParamByName('costCenter').AsString := 'c';
            Params.ParamByName('operator').AsString := Trim(cashier);
            Params.ParamByName('receipt').AsBoolean := False;
            Params.ParamByName('cPartita').AsInteger := 1200;
            Params.ParamByName('txid').AsString := txID;
            ExecSQL;

          end;
      end;
    end;
  end;
end;

PROCEDURE TForm1.xx_GetRentalData(guestID: Integer);
VAR
  DateA, DateB: TDateTime;
  sA, sB: STRING;

BEGIN
  // Rent has to be payed a day in advance (ex: today payes for tonight till tomorrow morning). Hence the following IncDay()
  // to inform the cashier since what date the client payed the room rent.

  // Get the number of already payed entrance fees (used to calculate short term stay)
  // During the last ed_MaxRoomRateDays days plus ed_MaxInterruptDays
  DateA := DateOf(DateOf(uClientStore.ThisBooking.checkInDt));
  DateB := IncDay(uClientStore.ThisBooking.checkInDt,
    +(ed_MaxRoomRateDays.Value + ed_MaxInterruptDays.Value));
  Var
    payedEntranceFees: Integer;
  WITH Form2.qy_TMP DO
  BEGIN
    // First count how many days this guest has been at the club
    // (payed entrance fees) in order to apply the Supplement for short term stay)
    // -------------------------------------------------------------------------

    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Add('SELECT COUNT(COALESCE(FeeID,0)) AS nPF FROM c_1000 ' +
      'WHERE ClientID = ' + intToStr(uClientStore.ThisBooking.guestID) +
      ' AND SubFeeID IN (310,315) ' + ' AND Canceled = False ' +
      ' AND Data BETWEEN ' + ' CAST(' +
      QuotedStr(Form2.EDBEngine1.DateToSQLStr(DateA)) + ' AS TimeStamp) ' +
      ' AND CAST(' + QuotedStr(Form2.EDBEngine1.DateToSQLStr(DateB)) +
      ' as TimeStamp) ');
    Active := True;
    IF (RecordCount > 0) THEN
      payedEntranceFees := FieldValues['nPF'];
    Active := True;
  END;

  // Now get the Room Rates (Basic rate, Suppl single occ, Suppl Short Term stay)
  // ---------------------------------------------------------------------------
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Add('SELECT COALESCE(RoomRate,0)as f,COALESCE(SupSingleRoom,0) AS s,COALESCE(SupShortTerm,0) AS sT '
      + 'FROM RREU_Bookings WHERE  BookingID = ' +
      intToStr(uClientStore.ThisBooking.bookingID));
    {
      SQL.Add('SELECT COALESCE(FeeCHF,0)as f,COALESCE(SupSingle,0) AS s,COALESCE(SupShortTerm,0) AS sT '
      + 'FROM RREU_RentalRooms WHERE  BookingID = ' +
      intToStr(uClientStore.ThisBooking.bookingID));
    }
    Active := True;
    RentalData.FeeCHF := FieldByName('f').AsFloat;
    RentalData.SupSingle := FieldByName('s').AsFloat;
    RentalData.SupShortTerm := FieldByName('sT').AsFloat;
    Active := False;

    IF payedEntranceFees < ed_MaxRoomRateDays.Value THEN
      RentalData.TotalShortTerm := RentalData.SupShortTerm;

    IF (uClientStore.ThisBooking.singleOccupancy)
    { OR (RentalData.RoomIsSingleOccupancy) } Then
      RentalData.TotalSingle := RentalData.SupSingle;
  END;

  WITH Form2.qy_TMP DO
  BEGIN
    // Get the last RR payment date and calc days to pay
    // -----------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Add('SELECT MAX(Data) AS lastPayDt, Dare FROM c_1000 ' +
      'WHERE ClientID = ' + intToStr(uClientStore.ThisBooking.guestID) +
      ' AND SubFeeID = 222 AND BookingID = ' +
      intToStr(uClientStore.ThisBooking.bookingID) + 'GROUP BY ClientID');
    Active := True;

    BEGIN
      IF uClientStore.ThisBooking.checkOutDt = 0 THEN
      BEGIN
        // Has already made payment(s) but has a balance due
        IF (RentalData.PayedUntilDate < DateOf(IncDay(Date))) AND
          (RentalData.PayedUntilDate > uClientStore.ThisBooking.checkInDt) THEN
        BEGIN
          RentalData.DaysToPay := DaysBetween(DateOf(RentalData.PayedUntilDate),
            DateOf(Tomorrow));
          RentalData.ToPayUntilDate := DateOf(Tomorrow);
        END;

        // Has no balance due
        IF RentalData.PayedUntilDate >= DateOf(IncDay(Date)) THEN
          RentalData.DaysToPay := 0;
      END;
      // Already checked out but has still a balance due
      IF (uClientStore.ThisBooking.checkOutDt >
        uClientStore.ThisBooking.checkInDt) AND
        (uClientStore.ThisBooking.checkOutDt < Today) THEN
      BEGIN
        RentalData.DaysToPay := DaysBetween(DateOf(FieldValues['lastPayDt']),
          uClientStore.ThisBooking.checkOutDt);
        RentalData.ToPayUntilDate :=
          DateOf(IncDay(FieldValues['lastPayDt'], RentalData.DaysToPay));
        RentalData.PayedUntilDate :=
          DateOf(IncDay(FieldValues['lastPayDt'], 1));
      END;
    END;
    // Has room, but not yet payed
    IF RentalData.PayedUntilDate = 0 THEN
    BEGIN
      RentalData.DaysToPay :=
        DaysBetween(DateOf(uClientStore.ThisBooking.checkInDt),
        DateOf(Tomorrow));
      RentalData.ToPayUntilDate :=
        DateOf(IncDay(uClientStore.ThisBooking.checkInDt,
        RentalData.DaysToPay));
      RentalData.PayedUntilDate := uClientStore.ThisBooking.checkInDt;
    END;
    // If checking out between 00:01 and ed_LastCheckOutTime then guest does not have to pay from today till tomorrow
    // hence deduct 1 day from daysTopay
    If (uClientStore.ThisBooking.willCheckOutToday > 0) AND
      InRange(uClientStore.ThisBooking.willCheckOutToday,
      RecodeTime(Now, 0, 1, 0, 0),
      RecodeTime(Now, HourOf(ed_LastCheckOutTime.Time), 0, 0, 0)) then
    begin
      RentalData.DaysToPay := RentalData.DaysToPay - 1;
      RentalData.ToPayUntilDate := IncDay(RentalData.ToPayUntilDate, -1);
    end
    else
      RentalData.DaysToPay := RentalData.DaysToPay;

    RentalData.TotalFeeCHF := RentalData.FeeCHF * RentalData.DaysToPay;
    RentalData.TotalShortTerm := RentalData.SupShortTerm * RentalData.DaysToPay;
    IF (uClientStore.ThisBooking.singleOccupancy) Then
      RentalData.TotalSingle := RentalData.SupSingle * RentalData.DaysToPay;

    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(COALESCE(Avere,0)) - SUM(COALESCE(Dare,0)) AS Balance  FROM c_1000 '
      + 'WHERE ClientID = ' + intToStr(uClientStore.ThisBooking.guestID) +
      ' AND SubFeeID = 299 AND BookingID = ' +
      intToStr(uClientStore.ThisBooking.bookingID) +
      ' GROUP BY ClientID, TXID');
    Active := True;
    IF RecordCount > 0 THEN
      uClientStore.ThisBooking.depositAmtPayed := FieldValues['Balance']
    ELSE
      uClientStore.ThisBooking.depositAmtPayed := 0;
  END;
END;

PROCEDURE TForm1.xx_WriteRentOwedToOtab;
VAR
  txnID: STRING;
BEGIN
  // First check if already rental PD exists
  // ---------------------------------------------------------------------------
  WITH Form2.qy_Tmp2 DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT TxID, BookingID FROM c_1200 ' + ' WHERE BookingID = ' +
      intToStr(uClientStore.ThisBooking.bookingID) + ' AND ClientID = ' +
      intToStr(uClientStore.ThisBooking.guestID));
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      txnID := FieldByName('TxID').AsString;
      // IF already existing rental PD in c_1200 found then use it's txid
    END
    ELSE
    BEGIN
      txnID := GenerateTxID;
    END;
    Active := False;
  END;

  // Write basic rent owed
  // ---------------------------------------------------------------------------
  IF RentalData.TotalFeeCHF > 0 Then
    WITH Form2.qy_Tmp2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;

      SQL.Add('INSERT INTO OpenTab ' +
        '(GroupID,FeeID,SubFeeID,ClientID,CardID,Description,' +
        'amountCHF,amountEuro,amountToPrint,' + 'PosPrintItems,PrintQRCode,' +
        'BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,' +
        'PayMethod,DefaultPayMethod,' +
        'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt,BookingID,TxID) ' +
        'SELECT GroupID, ' + intToStr(200) + ', ' + intToStr(222) + ', ' +
        intToStr(uClientStore.ThisClient.ID) + ', ' +
        intToStr(uClientStore.ThisCard.cardID) + ', ' +
        QuotedStr('Affitto dal ' + DateTimeToStr
        (DateOf(RentalData.PayedUntilDate)) + ' al ' +
        DateTimeToStr(DateOf(RentalData.ToPayUntilDate))) + ',' +
        floatToStr(RentalData.TotalFeeCHF) + ',' +
        floatToStr(GetEuroFee(RentalData.TotalFeeCHF)) + ',' +
        floatToStr(RentalData.TotalFeeCHF) + ',' +
        'PosPrintItems,PrintQRCode,BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,'''' ,DefaultPayMethod,'
        + 'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt, ' +
        intToStr(uClientStore.ThisBooking.bookingID) + ',' + QuotedStr(txnID) +
        ' FROM Fees f ' + ' WHERE f.SubID = 222');
      ExecSQL;
      Form2.tb_oTab.Refresh;
    END;

  // Write Short Term supplement
  // ---------------------------------------------------------------------------
  IF RentalData.TotalShortTerm > 0 Then
    WITH Form2.qy_Tmp2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('INSERT INTO OpenTab ' +
        '(GroupID,FeeID,SubFeeID,ClientID,CardID,Description,' +
        'amountCHF,amountEuro,amountToPrint,' + 'PosPrintItems,PrintQRCode,' +
        'BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,' +
        'PayMethod,DefaultPayMethod,' +
        'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt,BookingID,TxID) ');
      SQL.Add('SELECT GroupID, ' + intToStr(200) + ', ' + intToStr(232) + ', ' +
        intToStr(uClientStore.ThisClient.ID) + ', ' +
        intToStr(uClientStore.ThisCard.cardID) + ', ' +
        QuotedStr('+ breve ' + DateTimeToStr(DateOf(RentalData.PayedUntilDate))
        + ' al ' + DateTimeToStr(DateOf(RentalData.ToPayUntilDate))) + ',' +
        floatToStr(RentalData.TotalShortTerm) + ',' +
        floatToStr(GetEuroFee(RentalData.TotalShortTerm)) + ',' +
        floatToStr(RentalData.TotalShortTerm) + ',' +
        'PosPrintItems,PrintQRCode,BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,'''' ,DefaultPayMethod,'
        + 'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt, ' +
        intToStr(uClientStore.ThisBooking.bookingID) + ',' + QuotedStr(txnID) +
        ' FROM Fees f ' + ' WHERE f.SubID = 222');
      ExecSQL;
      Form2.tb_oTab.Refresh;
    END;
  // Write Single occupancy supplement
  // ---------------------------------------------------------------------------
  IF RentalData.TotalSingle > 0 Then
    WITH Form2.qy_Tmp2 DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('INSERT INTO OpenTab ' +
        '(GroupID,FeeID,SubFeeID,ClientID,CardID,Description,' +
        'amountCHF,amountEuro,amountToPrint,' + 'PosPrintItems,PrintQRCode,' +
        'BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,' +
        'PayMethod,DefaultPayMethod,' +
        'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt,BookingID,TxID) ');
      SQL.Add('SELECT GroupID,  ' + intToStr(200) + ', ' + intToStr(242) + ', '
        + intToStr(uClientStore.ThisClient.ID) + ', ' +
        intToStr(uClientStore.ThisCard.cardID) + ', ' +
        QuotedStr('+ singola ' + DateTimeToStr(DateOf(RentalData.PayedUntilDate)
        ) + ' al ' + DateTimeToStr(DateOf(RentalData.ToPayUntilDate))) + ',' +
        floatToStr(RentalData.TotalSingle) + ',' +
        floatToStr(GetEuroFee(RentalData.TotalSingle)) + ',' +
        floatToStr(RentalData.TotalSingle) + ',' +
        'PosPrintItems,PrintQRCode,BonusMalusID,CostCenter,dAccount,aAccount,' +
        'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,'''' ,DefaultPayMethod,'
        + 'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt, ' +
        intToStr(uClientStore.ThisBooking.bookingID) + ',' + QuotedStr(txnID) +
        ' FROM Fees f ' + ' WHERE f.SubID = 222');
      ExecSQL;
      Form2.tb_oTab.Refresh;
    END;
  dbgd_CashierDisplay.SumList.RecalcAll;
END;

Function TForm1.yy_CheckAllClientData(comesFrom: String;
  cardID: Integer): Boolean;
Var
  s: String;
begin
  // Get basic clientData
  // ---------------------------------------------------------------------------
  xx_GetClientData(uClientStore.ThisCard.ClientID); // ok

  // If pc_MainPageC.ActivePageIndex = 0 Then
  begin
    // Get room rental (RR) data    (xx_WriteRentOwedToOtab)
    // ---------------------------------------------------------------------------
    BEGIN
      xx_GetBookingData(uClientStore.ThisClient.ID);
      IF uClientStore.ThisBooking.bookingID > -1 THEN
        // > -1 = Has a valid rental room booking
        xx_GetRentalData(uClientStore.ThisClient.ID);

      IF (RentalData.TotalFeeCHF > 0) Then
        If NOT((TimeOf(Now) >= EncodeTime(0, 0, 0, 0)) and
          (TimeOf(Now) < EncodeTime(8, 0, 0, 0))) OR
          (DaySpan(DateOf(Tomorrow), RentalData.PayedUntilDate) > 1) Then
        begin
          xx_WriteRentOwedToOtab;
          nnWriteCashierDisplay(1, False, clYellow,
            uClientStore.ThisClient.alias + ' deve ancora un affitto ' +
            ' totale di  ' + FormatFloat('#,##0.00', RentalData.TotalFeeCHF +
            RentalData.TotalShortTerm + RentalData.TotalSingle) + ' CHF', 1);
        end
        else
          nnWriteCashierDisplay(0, False, clWhite, uClientStore.ThisClient.alias
            + ' affitto pagato fino il ' +
            DateTimeToStr(RentalData.PayedUntilDate), 1);
    END;

    // IF RR_Rooms.Showing
    // ---------------------------------------------------------------------------
    IF (RR_Rooms.Showing) THEN
    BEGIN
      WITH Form2.qy_TMP DO
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('SELECT GuestID FROM RREU_Bookings ' + 'WHERE GuestID = ' +
          intToStr(uClientStore.ThisClient.ID) +
          ' AND CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
          QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)));
        Active := True;
        RR_Rooms.img_CheckIN.Enabled := RecordCount = 0;
        IF RecordCount = 0 THEN
        BEGIN
          RR_Rooms.lb_Checkin.Caption := uClientStore.ThisClient.alias + #13#10
            + 'Pronta per Check IN';
          RR_Rooms.lb_CheckOut.Caption := '';
        END
        ELSE
          RR_Rooms.lb_Checkin.Caption := '';
        Active := False;
      END;
    END;

    GetRoomUseOverTime(ThisClient.ID, 509);

    // Get client's last tx balance  and overall balance due if fee used
    // xx_GetThePdBalance(uClientStore.ThisClient.ID, LastTxData.lTxID);
    // xx_WritePdToOtab('')
    // ---------------------------------------------------------------------------
    IF Form2.tb_Fees.FieldByName('SubID').AsInteger <> 999 Then
      IF (uClientStore.ThisCard.cardID < 9000) AND
        NOT((LastTxData.lTxFeeID IN [4, 5, 6]) AND (LastTxData.lTxStartDt = 0)
        AND (MinutesBetween(LastTxData.lTxSoldDT, Now) < 6)) THEN
      begin
        // If room time use limit check if over time

        xx_GetThePdBalance(uClientStore.ThisClient.ID, LastTxData.lTxID);
        Var
        amt := uClientStore.ThisClient.balanceDue;
        if dbgd_CashierDisplay.Columns[1].Footers[0].SumValue > amt then
          amt := dbgd_CashierDisplay.Columns[1].Footers[0].SumValue;
        IF amt > 0 THEN
        begin
          nnWriteCashierDisplay(1, False, clYellow,
            uClientStore.ThisClient.alias + ' deve ancora saldare un importo ' +
            ' totale di  ' + FormatFloat('#,##0.00', amt) + ' CHF', 1);
          dbgd_CashierDisplay.TitleParams.Color := clYellow;
          dbgd_CashierDisplay.SumList.RecalcAll;
          IF xx_WritePdToOtab(comesFrom) = True THEN
            Exit;
        end
        else
          dbgd_CashierDisplay.TitleParams.Color := clSilver;
      END;

    // ---------------------------------------------------------------------------
    IF uClientStore.ThisCard.cardID < 9000 THEN
    BEGIN
      xx_GetLastValidTxData(comesFrom, uClientStore.ThisClient.ID);
      validFeeHandleResult := xx_HandleValidFees(comesFrom);
      IF (comesFrom = 'bt_Read') AND
        (Form2.tb_Fees.FieldByName('SubID').AsInteger <> 999) Then
        // not a pecunia non olet registration
        CASE validFeeHandleResult OF
          30:
            BEGIN
              WITH Form2.qy_SS DO
              BEGIN
                IF Active THEN
                  Close;
                SQL.Clear;
                SQL.Add('SELECT FeeID FROM ServicesSold ' + 'WHERE ClientID = '
                  + intToStr(uClientStore.ThisClient.ID) +
                  ' AND FeeID IN (4,5,6) AND ' + ' SoldDT BETWEEN CAST(' +
                  QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) +
                  ' AS Timestamp) ' + ' AND CAST(' +
                  QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
                  ' as Timestamp)');
                Active := True;
              END;

              If TaskDlgHelperF.TaskDlg_Default('Chiusura tessera ragazza',
                'Sorry to see ' + uClientStore.ThisClient.alias + ' go.',
                'Confermi l''uscita di ' + uClientStore.ThisClient.alias +
                ' dal club?', 'SI', 'NO', '', 'marilyn-monroe.ico') = mrOk then
                nn_CloseDailyFee
              else
              begin
                IF RentalData.TotalFeeCHF > 0 Then
                begin
                  //
                end
                else
                begin
                  xx_CancelAll(False);
                  Exit;
                end;
              end;
            END;
          31: // 31: Has already same Fee;
            BEGIN
              TaskDlgHelperF.TaskDlg_Default('Gestione entrate',
                uClientStore.ThisClient.alias + ' ha già una valida ' +
                LastTxData.lTxFeeDesc, '', '', 'OK', '', 'ExitRoom_48.ico');
              xx_CancelAll(False);
              Exit;
            end;
          40:
            begin
              IF comesFrom <> 'bt_MultiReg' Then
                CASE TaskDlgHelperF.TaskDlg_Default('Gestione camere',
                  'Camera non usata', uClientStore.ThisClient.alias + ' ha una '
                  + LastTxData.lTxFeeDesc + ' non usata.' + #13#10 +
                  'REGISTRA come usata o AZZERA vendita?', 'REGISTRA', 'AZZERA',
                  'NO', 'ExitRoom_48.ico') OF
                  mrOk:
                    begin
                      xx_CloseUsedRoom;
                      nnWriteCashierDisplay(0, False, clLime,
                        LastTxData.lTxFeeDesc + ' chiusa.', 2);
                    end;
                  mrNo:
                    begin
                      xx_CloseUnusedRoom;
                      nnWriteCashierDisplay(0, False, clLime,
                        LastTxData.lTxFeeDesc + ' azzerata.', 2);
                    end;
                  mrCancel:
                    begin
                      Exit;
                    end;
                END;

            end;
          41:
            BEGIN
              IF TaskDlgHelperF.TaskDlg_Default('Gestione camere',
                'Camera usata', uClientStore.ThisClient.alias + ' libera la ' +
                LastTxData.lTxFeeDesc + '?', 'Libera', 'NO', '',
                'ExitRoom_48.ico') = mrOk Then
              begin
                xx_CloseUsedRoom;
              end
              else
              begin
                IF uClientStore.ThisClient.balanceDue = 0 Then
                  bt_CancelAll.Click;
                Exit;
              end;
            End;
        END;
    end;
  end;
end;

Procedure TForm1.yy_CheckIfFeeOK(comesFrom: String);
Var
  card4Fee, hasValidEntrance, hasValidRoom: Boolean;
begin
  // If Fees pressed
  // ---------------------------------------------------------------------------
  IF comesFrom = 'cg_CashierKeyboard' THEN
  BEGIN
    xx_VerifyFee(uClientStore.ThisClient.ID, card4Fee, hasValidEntrance,
      hasValidRoom);
    IF card4Fee THEN
    BEGIN
      // Handle numKeyboard or Pecunia buttons
      With Form2 do
        // Use of AllFees because needed in xx_WriteFeeToOtab
        tb_AllFees.Locate('ID;SubID',
          varArrayof([tb_Fees.FieldByName('ID').AsInteger,
          tb_FeeE.FieldByName('SubID').AsInteger]), []);
      CASE uClientStore.ThisCard.cardID OF
        9000 .. 9099:
          BEGIN
            //
          END;
        3000 .. 5999:
          BEGIN
            IF (Form2.tb_Fees.FieldByName('ID').AsInteger IN [4, 5, 6]) AND
              NOT(hasValidEntrance) THEN
            BEGIN
              nnWriteCashierDisplay(1, True, clYellow,
                uClientStore.ThisClient.alias +
                ' non ha ancora una valida entrata', 1);
              Exit;
            END;
            IF (Form2.tb_Fees.FieldByName('ID').AsInteger IN [4, 5, 6]) AND
              (hasValidRoom) THEN
            BEGIN
              Exit;
            END;
            IF (Form2.tb_Fees.FieldByName('ID').AsInteger = 3) AND
              (hasValidEntrance = True) THEN
            BEGIN
              // IF validFeeHandleResult = 31 THEN
              BEGIN
                nnWriteCashierDisplay(1, True, clYellow,
                  uClientStore.ThisClient.alias + ' ha già una entrata ' +
                  LastTxData.lTxFeeDesc, 1);
                Exit;
              END;
            END;
            IF (Form2.tb_Fees.FieldByName('SubID').AsInteger = 289) AND
              (uClientStore.ThisBooking.depositAmtPayed <= 0) THEN
            BEGIN
              nnWriteCashierDisplay(1, True, clYellow,
                uClientStore.ThisClient.alias +
                ' non ha un rimborso di una cauzione da ricevere.', 1);
              Exit;
            END;
          END;
      END;
    END
    ELSE
      Exit;
    If (Form2.tb_Fees.FieldByName('OpenFeeAmt').AsBoolean = True) Then
    BEGIN
      ShowNumKeyboard;
    END
    else
      xx_WriteFeeToOtab;
  END;
end;

procedure TForm1.bt_ReadCardClick(Sender: TObject);
begin
  MemoLog.Clear;
  TagReader.SingleScan;
  if TagReader.tID <> '' then
    MemoLog.Lines.Add('Scanned Tag ID: ' + TagReader.tID)
  else
    MemoLog.Lines.Add('No tag detected.');

  if TagReader.tID = '' then
  begin
    MemoLog.Lines.Add('No tag scanned yet.');
    Exit;
  end;
  // Select the tag before reading
  if not TagReader.SelectTag(TagReader.tID) then
  begin
    MemoLog.Lines.Add('Tag select failed.');
    Exit;
  end;
  // Read Block 0
  if TagReader.ReadBlock(0) then
  begin
    MemoLog.Lines.Add('Block 0: ' + TagReader.Rfid_strBlockData);
    ed_CardID.Value := StrToIntDef(TagReader.Rfid_strBlockData, 0);
  end
  else
    MemoLog.Lines.Add('Read failed: ' + TagReader.RC); // this will show 'A4'
END;

Function TForm1.ReadCardOnReader: Integer;
VAR
  tmp_CardEDate, tmp_CardID: STRING;
BEGIN
  uClientStore.ThisCard := Default (uClientStore.TCard);
  // Get card id from ed_cCard edit component
  // ---------------------------------------------------------------------------
  IF cb_Testdata_.Checked THEN
  begin
    If not ed_cCard.IsEmpty then
      uClientStore.ThisCard.cardID := ed_cCard.Value
    else
    begin
      // Result := 'Manca il numero tessera!';
      Result := 1;
      Exit;
    end;
    // uClientStore.ThisCard.cardID := 3005;
  end
  ELSE
  // Read from RFid card reader
  // -------------------------------------------------------------------------
  BEGIN
    MemoLog.Clear;
    TagReader.SingleScan;
    if TagReader.tID <> '' then
      MemoLog.Lines.Add('Scanned Tag ID: ' + TagReader.tID)
    else
      MemoLog.Lines.Add('No tag detected.');

    if TagReader.tID = '' then
    begin
      MemoLog.Lines.Add('No tag scanned yet.');
      Result := -1;
      Exit;
    end;
    // Select the tag before reading
    if not TagReader.SelectTag(TagReader.tID) then
    begin
      MemoLog.Lines.Add('Tag select failed.');
      nnWriteCashierDisplay(0, True, clYellow,
        'Lettura tessera fallita (Tag)', 2);
      Result := -1;
      Exit;
    end;
    // Read Block 0
    if TagReader.ReadBlock(0) then
    begin
      MemoLog.Lines.Add('Block 0: ' + TagReader.Rfid_strBlockData);
      uClientStore.ThisCard.cardID :=
        StrToIntDef(TagReader.Rfid_strBlockData, 0);
      Result := 0;
    end
    else
    begin
      MemoLog.Lines.Add('Read failed: ' + TagReader.RC); //
      nnWriteCashierDisplay(0, True, clYellow,
        'Lettura tessera fallita (Block)', 2);
      Result := -1;
    end;
  END;
end;

Function TForm1.VerifyCard(cardID: Integer): Integer;
begin
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    SQL.Add('SELECT Enabled, Description, ClientID FROM Cards WHERE ID = ' +
      intToStr(cardID));
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      IF FieldValues['ClientID'] >= 0 THEN
      BEGIN
        Result := 1;
        uClientStore.ThisCard.cardID := cardID;
        uClientStore.ThisCard.ClientID := FieldValues['ClientID'];
        uClientStore.ThisCard.Description := Trim(FieldValues['Description']);
        uClientStore.ThisCard.Enabled := FieldValues['Enabled'];
        s := 'Tessera ' + intToStr(cardID) + ' ok';
        nnWriteCashierDisplay(0, True, clWhite, s, 2);
      END;

      IF (FieldValues['ClientID'] < 0) OR
        (VarIsNull(FieldValues['ClientID'])) THEN
      BEGIN
        Result := -1;
        s := 'Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
          ' non appartiene a nessun cliente!';
      END;

      IF NOT FieldByName('Enabled').AsBoolean THEN
      BEGIN
        Result := -2;
        s := 'Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
          ' non autorizzata';
      END;
    END
    ELSE
    BEGIN
      Result := -3;
      s := 'Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
        ' non esiste nel database!';
    END;
    Active := False;
    If Result < 1 Then
      nnWriteCashierDisplay(0, True, clYellow, s, 2)
    else
      nnWriteCashierDisplay(0, True, clWhite, s, 1);
  END;
end;

FUNCTION TForm1.xx_ReadCard(cardID: Integer): Integer;
begin
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    SQL.Add('SELECT Enabled, Description, ClientID FROM Cards WHERE ID = ' +
      intToStr(uClientStore.ThisCard.cardID));
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      uClientStore.ThisCard.Enabled := FieldValues['Enabled'];
      IF VarIsNull(FieldValues['ClientID']) Then
        uClientStore.ThisCard.ClientID := -1
      else
        uClientStore.ThisCard.ClientID := FieldValues['ClientID'];
      uClientStore.ThisCard.Description := Trim(FieldValues['Description']);

      IF FieldValues['ClientID'] < 0 THEN
      BEGIN
        Result := 2;
        // Result := 'Tessera ' + intToStr(uClientStore.ThisCard.cardID)+' non appartiene a nessun cliente!';
        Exit;
      END;

      IF NOT FieldByName('Enabled').AsBoolean THEN
      BEGIN
        Result := 3;
        // Result := 'Tessera ' + intToStr(uClientStore.ThisCard.cardID) + ' non autorizzata';
        Exit;
      END;
    END
    ELSE
    BEGIN
      Result := 4;
      // Result := 'Tessera non esiste nel database!';
      Exit;
    END;
    Active := False;
    // Result := 'OK';
    Result := 0;
  END;
END;

PROCEDURE TForm1.bt_Read_Click(Sender: TObject);
BEGIN
  bt_CancelAllClick(Sender);

  If ReadCardOnReader < 0 Then
    Exit;

  IF VerifyCard(uClientStore.ThisCard.cardID) < 0 then
    Exit;

  yy_CheckAllClientData('bt_Read', uClientStore.ThisCard.cardID);

  Form1.ShowHideBottomBtns(True, True, True, True);
END;

Function TForm1.xx_FromCardReader: Integer;
VAR
  tmp_CardEDate, tmp_CardID: STRING;
BEGIN
  uClientStore.ThisCard := Default (uClientStore.TCard);
  // Get card id from ed_cCard edit component
  // ---------------------------------------------------------------------------
  IF cb_Testdata_.Checked THEN
  begin
    If not ed_cCard.IsEmpty then
      uClientStore.ThisCard.cardID := ed_cCard.Value
    else
    begin
      // Result := 'Manca il numero tessera!';
      Result := 1;
      Exit;
    end;
    // uClientStore.ThisCard.cardID := 3005;
  end
  ELSE
  // Read from RFid card reader
  // -------------------------------------------------------------------------
  BEGIN
    MemoLog.Clear;
    TagReader.SingleScan;
    if TagReader.tID <> '' then
      MemoLog.Lines.Add('Scanned Tag ID: ' + TagReader.tID)
    else
      MemoLog.Lines.Add('No tag detected.');

    if TagReader.tID = '' then
    begin
      MemoLog.Lines.Add('No tag scanned yet.');
      Exit;
    end;
    // Select the tag before reading
    if not TagReader.SelectTag(TagReader.tID) then
    begin
      MemoLog.Lines.Add('Tag select failed.');
      Exit;
    end;
    // Read Block 0
    if TagReader.ReadBlock(0) then
    begin
      MemoLog.Lines.Add('Block 0: ' + TagReader.Rfid_strBlockData);
      uClientStore.ThisCard.cardID :=
        StrToIntDef(TagReader.Rfid_strBlockData, 0);
    end
    else
      MemoLog.Lines.Add('Read failed: ' + TagReader.RC); // this will show 'A4'
  END;
end;

PROCEDURE TForm1.xx_GetClientData(caClID: Integer);
BEGIN
  IF (uClientStore.ThisCard.Enabled) AND (caClID > -1) THEN
  BEGIN
    uClientStore.ThisClient := Default (TClient);
    WITH Form2.qy_TMP DO
    BEGIN
      IF Active THEN
        Close;

      SQL.Clear;
      SQL.Add('SELECT * ' + ' FROM Clients WHERE ID = ' +
        intToStr(uClientStore.ThisCard.ClientID) + ' AND ID > 0');
      Active := True;
      IF (RecordCount > 0) THEN
      BEGIN
        // Collect personal data
        WITH uClientStore.ThisClient DO
        BEGIN
          ID := uClientStore.ThisCard.ClientID;
          cardID := uClientStore.ThisCard.cardID;
          fName := Trim(FieldByName('FirstName').AsString);
          lName := Trim(FieldByName('LastName').AsString);
          alias := Trim(FieldValues['Alias']);
          IF FieldValues['Address'] <> NULL THEN
            Address := Trim(FieldValues['Address']);
          IF FieldValues['Cap'] <> NULL THEN
            Cap := FieldValues['Cap'];
          IF FieldValues['City'] <> NULL THEN
            City := Trim(FieldValues['City']);
          IF FieldValues['Simic'] <> NULL THEN
            SIMIC := FieldValues['Simic'];
          IF FieldValues['IDTeseu'] <> NULL THEN
            IDTeseu := FieldValues['IDTeseu'];
          IF FieldValues['Permit'] <> NULL THEN
            Permit := FieldValues['Permit'];
          IF FieldValues['Iban'] <> NULL THEN
            iban := FieldValues['Iban'];
          IF FieldValues['InHouse'] <> NULL THEN
            InHouse := FieldValues['InHouse'];
          Enabled := FieldValues['Enabled'];
          Taxed := FieldValues['Taxed'];
          IF FieldValues['BirthDate'] <> NULL THEN
            bdate := FieldValues['BirthDate'];
          nnWriteCashierDisplay(1, True, clWhite, uClientStore.ThisClient.alias
            + ': ' + 'Tessera ' + intToStr(uClientStore.ThisClient.cardID), 0);
        END;
      END;
    END;
    IF uClientStore.ThisCard.cardID >= 9000 THEN
      nnWriteCashierDisplay(1, True, clWhite, uClientStore.ThisCard.Description
        + ': ' + 'Tessera ' + intToStr(uClientStore.ThisCard.cardID), 0)
  END;
END;

// Get either  the client's whole PD due balance or this tx's balance due   (PD)
// -----------------------------------------------------------------------------
Procedure TForm1.xx_GetThePdBalance(ClientID: Integer; txnID: STRING);
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF ClientID > -1 THEN
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      DataBaseName := 'DB_Main';
      // Get client's total due balance
      SQL.Add('SELECT COALESCE(SUM(Dare),0) AS bal FROM c_1200 WHERE ClientID = '
        + intToStr(ClientID) + ' AND PayMethod = ''PD'' AND Canceled = False ');
      Active := True;
      IF RecordCount > 0 THEN
        uClientStore.ThisClient.balanceDue := FieldByName('bal').AsFloat;
    END;

    IF txnID <> '' THEN
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT COALESCE(SUM(Dare),0) AS bal FROM c_1200 WHERE ClientID = '
        + intToStr(ClientID) + ' AND TxID = ' + QuotedStr(txnID) +
        ' AND PayMethod = ''PD'' AND Canceled = False ');
      Active := True;
      LastTxData.lTxBal := FieldByName('bal').AsFloat;
    END;
    Active := False;
  END;
END;

FUNCTION TForm1.Sec_CheckPCDateTime: Boolean;
VAR
  mDt: TDateTime;
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('Select max(Data) as maxDT from OpLedger ');
    Active := True;
    mDt := FieldValues['maxDT'];
    IF (FieldValues['maxDT'] > Now) AND (FieldValues['maxDT'] <> NULL) THEN
    BEGIN
      Result := False;
    END
    ELSE
      Result := True;
    Active := False;
    UnPrepare;
  END;
END;

PROCEDURE TForm1.GetDailyCount;
VAR
  n: Integer;
  s: STRING;
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    DataSource := Form2.sc_ServicesSold;
    SQL.Clear;
    s := 'SELECT count(FeeID) AS cF FROM ServicesSold WHERE FEEID = 3 AND Valid = True AND CheckedOut = False'
      + ' AND SoldDt >= TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(sDt, True)) +
      ' AND SoldDt <= TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(eDT, True));
    SQL.Add(s);
    Active := True;
    IF FieldValues['cF'] <> NULL THEN
    BEGIN
      n := FieldValues['cF'];
      // StatusBar1.Panels[0].Text := IntToHex(n * (DayOf(now) * 10), 4);
      RzStatusPane1.Caption := intToStr(n);
    END
    ELSE
      RzStatusPane1.Caption := '';
  END;
END;

function TForm1.GenerateTxID: PChar; stdcall;
var
  ms: Int64;
  s: string;
begin
  Sleep(2);
  ms := DateTimeToUnix(Now, False) * 1000 + MilliSecondOf(Now);
  s := UpperCase(IntToHex(ms, 13));
  Result := PChar(s);
end;

PROCEDURE TForm1.bt_Valid_SSClick(Sender: TObject);
BEGIN
  WITH Form2 DO
  BEGIN
    tb_Cassa_SS.Filtered := True;
    tb_Cassa_SS.Last;
  END;
END;

PROCEDURE TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  IF (Button = mbLeft) AND (ssCtrl IN Shift) THEN
  BEGIN
    // Start drag operation when Ctrl+Left Mouse Button is pressed
    TRzDBListBox(Sender).BeginDrag(False);
  END;
END;

PROCEDURE TForm1.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  IF Sender IS TControl THEN
    TControl(Sender).BeginDrag(False);
END;

PROCEDURE TForm1.db_TicketImage_DblClick(Sender: TObject);
BEGIN
  WITH Form2.tb_FeeE DO
  BEGIN
    Edit;
    IF OpenPictureDialog1.Execute THEN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('TicketHeader'))
          .LoadFromFile(OpenPictureDialog1.FileName)
      ELSE
        RAISE Exception.Create('File does not exist.');
    Post;
  END;
END;

PROCEDURE TForm1.JvDBImage1DblClick(Sender: TObject);
BEGIN
  WITH Form2.tb_FeeE do
  begin
    Edit;
    IF OpenPictureDialog1.Execute THEN
    BEGIN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('Icon'))
          .LoadFromFile(OpenPictureDialog1.FileName);
      Post;
    END
    ELSE
    BEGIN
      // RAISE Exception.Create('File does not exist.');
      Cancel;
    END;
  END;
END;

PROCEDURE TForm1.JvThread1Execute(Sender: TObject; Params: Pointer);
BEGIN
  // On Fee click this locates the subfeeid
  Form2.tb_FeeE.Locate('SubID', Form2.tb_Fees.FieldByName('SubID')
    .AsInteger, []);
END;

procedure TForm1.thtm_BarRTTimer(Sender: TObject);
begin
  // Form2.qy_TabsOpen.Refresh;
  // dbgd_TabsOpen.Refresh;
  ShowDetailOpenBarTab;
end;

procedure TForm1.thtm_LoginTimer(Sender: TObject);
begin
  bt_LoginClick(Sender);
  Sleep(50);
  ed_LogInPwd.Text := ClubAccPermissions.LogInFallBackPwd;
  bt_LoginClick(Sender);
  thtm_Login.Enabled := False;
end;

procedure TForm1.tm_ClosingTimer(Sender: TObject);
begin
  (*
    if JvProgressBar1.Position < JvProgressBar1.Max then
    begin
    JvProgressBar1.Position := JvProgressBar1.Position + 1;
    end
    else
    begin
    tm_Closing.Enabled := False;
    JvProgressBar1.Visible := False;
    JvProgressBar1.Position := 0;
    // bt_ClosePeriod.Enabled := False; // disable button after timeout
    // cl_Closing_Cal.Enabled := True;
    ShowMessage('Chiusura cassa effettuata!'); // handle timeout
    end;
  *)
end;

procedure TForm1.jvtm_RefreshCassaServicesTimer(Sender: TObject);
begin
  Form2.tb_Cassa_Services.Refresh;
end;

PROCEDURE TForm1.tht_CheckPresenceTimer(Sender: TObject);
BEGIN
  tht_CheckPresence.Enabled := False;
  tht_RRBlink.Enabled := xx_CheckIfStillPresent;
  xx_ScheduleNextRRCheck;
END;

PROCEDURE TForm1.tht_RRBlinkTimer(Sender: TObject);
BEGIN
  FBlinkState := NOT FBlinkState;
  // Alternate between red and default color:
  bt_RR_Rooms.ShineColor := IfThen(FBlinkState, clRed, clWhite);
END;

PROCEDURE TForm1.db_PromoImageDblClick(Sender: TObject);
BEGIN
  WITH Form2.tb_FeeE DO
  BEGIN
    Edit;
    IF OpenPictureDialog1.Execute THEN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('PromoImage'))
          .LoadFromFile(OpenPictureDialog1.FileName)
      ELSE
        RAISE Exception.Create('File does not exist.');
    Post;
  END;
END;

PROCEDURE TForm1.dbimg_HeaderEndDrag(Sender, Target: TObject; X, Y: Integer);
BEGIN
  screen.Cursor := crDefault;
END;

PROCEDURE TForm1.dbimg_HeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  IF (Button = mbLeft) AND (ssCtrl IN Shift) THEN
    TControl(Sender).BeginDrag(True);

  // IF Button = mbLeft THEN  (Sender AS TDBImage).BeginDrag(True);
END;

PROCEDURE TForm1.dbmm_TextEndDrag(Sender, Target: TObject; X, Y: Integer);
BEGIN
  screen.Cursor := crDefault;
END;

procedure TForm1.DBImage1DblClick(Sender: TObject);
var
  Dlg: TOpenPictureDialog;
begin
  if not Assigned(DBImage1.DataSource) or not Assigned(DBImage1.DataSource.DataSet) then
    Exit;

  Dlg := TOpenPictureDialog.Create(Self);
  try
    Dlg.Filter := 'Images (*.jpg;*.jpeg;*.png;*.bmp;*.gif)|*.jpg;*.jpeg;*.png;*.bmp;*.gif|All files (*.*)|*.*';
    if Dlg.Execute then
    begin
      with DBImage1.DataSource.DataSet do
      begin
        if not(State in dsEditModes) then
          Edit;
        TBlobField(FieldByName(DBImage1.DataField)).LoadFromFile(Dlg.FileName);
        // Post;   // uncomment to save immediately instead of leaving the record in edit mode
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

PROCEDURE TForm1.DBImage2DblClick(Sender: TObject);
BEGIN
  WITH Form2.tb_FeeE DO
    IF OpenPictureDialog1.Execute THEN
    BEGIN
      // User selected a file; load the image
      IF FileExists(OpenPictureDialog1.FileName) THEN
      BEGIN
        Edit;
        TBlobField(FieldByName('Icon'))
          .LoadFromFile(OpenPictureDialog1.FileName);
        Post;
        ShowMessage('Image loaded successfully.');
      END
      ELSE
        ShowMessage('The selected file does not exist.');
    END
    ELSE
    BEGIN
      // User canceled the dialog
      ShowMessage('No image selected.');
    END;
END;

PROCEDURE TForm1.DBImageEh1ButtonClick(Sender: TObject; VAR Handled: Boolean);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Edit;
    IF OpenPictureDialog1.Execute THEN
    BEGIN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('Image'))
          .LoadFromFile(OpenPictureDialog1.FileName);
    END
    ELSE
      RAISE Exception.Create('File does not exist.');
    Post;
  END;
END;

PROCEDURE TForm1.dbimg1_KeyboardDblClick(Sender: TObject);
BEGIN
  WITH Form2.tb_FeeE DO
  BEGIN
    Edit;
    IF OpenPictureDialog1.Execute THEN
    BEGIN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('Icon'))
          .LoadFromFile(OpenPictureDialog1.FileName);
      Post;
    END
    ELSE
    BEGIN
      // RAISE Exception.Create('File does not exist.');
      Cancel;
    END;
  END;
END;

procedure TForm1.dbimg2_KeyboardDblClick(Sender: TObject);
begin
  WITH Form2.tb_Fees_Edit DO
  BEGIN
    Edit;
    IF OpenPictureDialog1.Execute THEN
    BEGIN
      IF FileExists(OpenPictureDialog1.FileName) THEN
        TBlobField(FieldByName('Icon'))
          .LoadFromFile(OpenPictureDialog1.FileName);
      Post;
    END
    ELSE
    BEGIN
      // RAISE Exception.Create('File does not exist.');
      Cancel;
    END;
  END;
END;

procedure TForm1.dbimg_BodyDblClick(Sender: TObject);
begin
  with Form2.tb_PosImages do
  begin
    // 1) Make sure the table/query is open
    if not Active then
      Open;

    Edit;

    // 2) User picks a file?
    if OpenPictureDialog1.Execute then
    begin
      if FileExists(OpenPictureDialog1.FileName) then
      begin
        // 3) Load into TPicture just to check orientation
        var
        pic := TPicture.Create;
        try
          pic.LoadFromFile(OpenPictureDialog1.FileName);

          // 4) Set your Format field (use the actual field name)
          if pic.Width > pic.Height then
            FieldByName('Format').AsString := 'L'
          else
            FieldByName('Format').AsString := 'P';

          // 5) Now store the blob
          (FieldByName('PosImage') as TBlobField)
            .LoadFromFile(OpenPictureDialog1.FileName);

          Post;
        finally
          pic.Free;
        end;
      end
      else
      begin
        ShowMessage('Nessuna immagine scontrino caricata!');
        Cancel;
      end;
    end
    else
      Cancel; // user hit Cancel on the dialog
  end;
end;

procedure TForm1.LoadBlobIntoRich(Rich: TRichEdit; Blob: TBlobField);
var
  ms: TMemoryStream;
  header: array [0 .. 4] of AnsiChar;
  isRTF: Boolean;
  ES: TEditStream;
begin
  ms := TMemoryStream.Create;
  try
    // pull blob into stream
    Blob.SaveToStream(ms);
    ms.Position := 0;

    // peek at first 5 chars
    ms.Read(header, SizeOf(header));
    isRTF := SameText(Copy(string(header), 1, 5), '{\rtf');
    ms.Position := 0;

    // ensure window handle exists
    Rich.HandleNeeded;

    if isRTF then
    begin
      Rich.PlainText := False;
      FillChar(ES, SizeOf(ES), 0);
      ES.dwCookie := DWORD(ms);
      ES.pfnCallback := @RichEditStreamInProc;
      ES.dwError := 0;
      Rich.Perform(EM_STREAMIN, SF_RTF, LPARAM(@ES));
    end
    else
    begin
      // plain‐text fallback
      Rich.PlainText := True;
      Rich.Lines.LoadFromStream(ms);
    end;
  finally
    ms.Free;
  end;
end;

PROCEDURE TForm1.dbimg_BodyEndDrag(Sender, Target: TObject; X, Y: Integer);
BEGIN
  screen.Cursor := crDefault;
END;

PROCEDURE TForm1.dbimg_BodyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN

  IF (Button = mbLeft) AND (ssCtrl IN Shift) THEN
    TControl(Sender).BeginDrag(True);
  // IF Button = mbLeft THEN  (Sender AS TDBImage).BeginDrag(False);
END;

FUNCTION TForm1.StripRTFFormatting(CONST RTF: STRING): STRING;
VAR
  RichEdit: TRichEdit;
  Stream: TStringStream;
BEGIN
  RichEdit := TRichEdit.Create(Self); // Use the form as the parent
  TRY
    RichEdit.Parent := Self; // Assign a valid parent window
    RichEdit.Visible := False; // Keep it hidden
    Stream := TStringStream.Create(RTF);
    TRY
      Stream.Position := 0;
      RichEdit.Lines.LoadFromStream(Stream); // Load the RTF content
      Result := RichEdit.Lines.Text; // Extract plain text
    FINALLY
      Stream.Free;
    END;
  FINALLY
    RichEdit.Free;
  END;
END;

FUNCTION TForm1.CheckIfCardReadyToChange(Sender: TObject): Boolean;
BEGIN
  // Check if card has still valid fee
  // --------------------------------------------------------------------------
  IF LastTxData.lTxValid THEN
  BEGIN
    ShowMessage(uClientStore.ThisClient.alias + ' ha ancora una ' +
      LastTxData.lTxFeeDesc + ' valida.' + #10#13 +
      'Prima di procedere azzerala nella cassa!');
    Result := False;
    Exit;
  END
  ELSE
    Result := True;
END;

PROCEDURE TForm1.DBVertGridEh1CellClick(Row: TFieldRowEh);
BEGIN
  IF Row.Field.Index IN [3, 6, 9, 12, 15, 18] THEN
    IF (Form2.tb_AdMonitors.FieldByName(Row.FieldName).AsVariant <> NULL) THEN
      im_AdAssImage.Picture.LoadFromFile
        (Trim(Form2.tb_AdMonitors.FieldByName(Row.FieldName).AsString));
END;

PROCEDURE TForm1.DBVertGridEh1LabelColClick(Row: TFieldRowEh);
VAR
  Picture: TPicture;
  Bitmap: TBitmap;
  // thumbRect: TRect;
  monID: Integer;
  imgName: STRING;
BEGIN
  WITH Form2.tb_AdMonitors DO
  BEGIN
    IF Row.Field.Index IN [3, 6, 9, 12, 15, 18] THEN
    BEGIN
      IF (FieldByName(Row.FieldName).AsVariant <> NULL) THEN
        im_AdAssImage.Picture.LoadFromFile
          (Trim(FieldByName(Row.FieldName).AsString));

      IF ((FieldByName(Row.FieldName).AsVariant <> NULL) AND
        (MessageDlg('Vuoi cambiare l''immagine esistente?', mtInformation,
        mbOKCancel, 0) = mrOk)) OR
        (FieldByName(Row.FieldName).AsVariant = NULL) THEN
        IF OpenPictureDialog1.Execute THEN
        BEGIN
          IF FileExists(OpenPictureDialog1.FileName) THEN
          BEGIN
            Picture := TPicture.Create;
            Bitmap := TBitmap.Create;
            TRY
              Picture.LoadFromFile(OpenPictureDialog1.FileName);
              WITH Form2.tb_AdMonitors DO
              BEGIN
                Edit;
                FieldByName(Row.FieldName).AsString :=
                  OpenPictureDialog1.FileName;
                Post;
              END;
            FINALLY
              // ShowMessage('Immagine non esiste!');
            END;
          END;
        END;
    END;

    // Test images on monitor
    IF Row.Field.Index IN [2, 5, 8, 11, 14, 17] THEN
    BEGIN
      CASE Row.Field.Index OF
        2:
          BEGIN
            imgName := Trim(FieldByName('Img_ReadCard').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_ReadCard').AsString, 1, 1));
          END;
        5:
          BEGIN
            imgName := Trim(FieldByName('Img_SelFee').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_SelFee').AsString, 1, 1));
          END;
        8:
          BEGIN
            imgName := Trim(FieldByName('Img_PayType').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_PayType').AsString, 1, 1));
          END;
        11:
          BEGIN
            imgName := Trim(FieldByName('Img_RegSale').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_RegSale').AsString, 1, 1));
          END;
        14:
          BEGIN
            imgName := Trim(FieldByName('Img_rCheckOut').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_rCheckOut')
              .AsString, 1, 1));
          END;
        17:
          BEGIN
            imgName := Trim(FieldByName('Img_ClLeaves').AsString);
            monID := StrToInt(Copy(FieldByName('Mon_ClLeaves').AsString, 1, 1));
          END;
      END;
      IF monID > 0 THEN // for now only on one external monitor
        Form4.ShowAds(imgName, monID);
    END;
  END;
END;

procedure TForm1.dbVgd_FeesEditRows30EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  Handled := Form2.tb_Fees.FieldByName('PosPrintItems').AsString <> '';

  bt_TestPosTicket.Text := Form2.tb_FeeE.FieldByName('PosPrintItems').AsString;
  bt_TestPosTicketButtonClick(Sender);
end;

PROCEDURE TForm1.Shape7MouseEnter(Sender: TObject);
BEGIN
  Application.HintHidePause := 7000;
END;

PROCEDURE TForm1.Shape7MouseLeave(Sender: TObject);
BEGIN
  Application.HintHidePause := 4000;
END;

procedure TForm1.dbgd_1000_CCDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  IsWorkingDayNull: Boolean;
  AGrid: TDBGridEh;
begin
  AGrid := TDBGridEh(Sender);

  // Check if WorkingDay is null
  IsWorkingDayNull := Column.Field.DataSet.FieldByName('ClosingID').IsNull;

  // Optionally preserve selection style
  if (gdSelected in State) then
    AGrid.Canvas.Font.Color := clBlue
  else
  begin
    if Not IsWorkingDayNull then
      AGrid.Canvas.Font.Color := clTeal
    else
      AGrid.Canvas.Font.Color := clBlack;
  end;

  // Draw the cell
  AGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.dbgd_1000_CCExit(Sender: TObject);
begin
  dbgd_1000_CC.Columns[2].Footers[0].Value := '';
end;

procedure TForm1.dbgd_1000_CCSumListAfterRecalcAll(Sender: TObject);
Var
  D: Double;
begin
  WITH dbgd_1000_CC DO
  begin
    If VarIsNull(Columns[3].Footers[0].SumValue) Then
      D := 0
    else
      D := Columns[3].Footers[0].SumValue;
  end;
end;

procedure TForm1.ChangePaymethod(subFeeID, cPartita, txID, amt, Description,
  oldPaymethod, sel1, sel2: String);
var
  mr, sel: Integer;
  s, newAmt, oldAmt, workingday, workingDayPeriod: String;
  OwnTransaction: Boolean;
begin
  oldAmt := amt;
  newAmt := oldAmt; // default so it's never empty

  mr := TaskDlgHelperF.TaskDlg_Default('Modifica valuta',
    'Correzione su: ' + Description, 'Scegli', 'OK', 'Cancel', '',
    'QuestionMark_48.ico', [sel1, sel2], -1, sel);

  if mr = 1 then // OK button clicked
  begin
    if sel = -1 then
    begin
      // No choice made – show warning and exit
      MessageDlg('Manca la scelta della valuta!', mtWarning, [mbOK], 0);
      Exit;
    end;

    case sel of
      0:
        s := sel1;
      1:
        s := sel2;
    end;

    // First check if there is a fee difference
    // ------------------------------------------------------------------------
    with Form2.qy_TMP do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT DoNotApplyExchangeRate, FeeCHF FROM Fees WHERE SubID = ' +
        subFeeID);
      Active := True;

      if FieldByName('DoNotApplyExchangeRate').AsBoolean = False then
      begin
        if ((oldPaymethod = 'CH') or (oldPaymethod = 'CC')) and (s = 'EU') then
          newAmt := floatToStr(GetEuroFee(StrToFloatDef(amt, 0)));

        if ((s = 'CH') or (s = 'CC')) and (oldPaymethod = 'EU') then
          newAmt := floatToStr(FieldByName('FeeCHF').AsFloat);

        if ((s = 'CH') or (s = 'CC')) and
          ((oldPaymethod = 'CH') or (oldPaymethod = 'CC')) then
          newAmt := oldAmt;
      end;

      // close the SELECT query, we don't need it anymore
      Close;
    end;

    // Safety net: if for some reason newAmt is still empty, fall back to oldAmt
    if newAmt = '' then
      newAmt := oldAmt;

    with Form2.qy_TMP do
    begin
      // Start a transaction ONLY if there isn't already one
      OwnTransaction := not Form2.DB_Main.InTransaction;
      if OwnTransaction then
        Form2.DB_Main.StartTransaction(['c_1000', 'c_1200', 'c_2900', 'c_5000',
          'c_6000']);

      try
        if Active then
          Close;

        // C_1000 --------------------------------------------------------------
        SQL.Clear;
        SQL.Add('UPDATE C_1000 SET ' + 'PayMethod = ' + QuotedStr(s) + ',' +
          'Dare = CASE WHEN Dare IS NOT NULL AND Dare > 0 THEN ' + newAmt +
          ' ELSE Dare END,' +
          'Avere = CASE WHEN Avere IS NOT NULL AND Avere > 0 THEN ' + newAmt +
          ' ELSE Avere END ' + 'WHERE TxID = ' + QuotedStr(txID) + ' ' +
          'AND ((Dare = ' + oldAmt + ') OR (Avere = ' + oldAmt + '))');

        ExecSQL;

        // C_1200 --------------------------------------------------------------
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_1200 SET ' + 'PayMethod = ' + QuotedStr(s) + ',' +
          'Dare = CASE WHEN Dare IS NOT NULL AND Dare > 0 THEN ' + newAmt +
          ' ELSE Dare END,' +
          'Avere = CASE WHEN Avere IS NOT NULL AND Avere > 0 THEN ' + newAmt +
          ' ELSE Avere END ' + 'WHERE TxID = ' + QuotedStr(txID) + ' ' +
          'AND ((Dare = ' + oldAmt + ') OR (Avere = ' + oldAmt + '))');
        ExecSQL;

        // C_2900 --------------------------------------------------------------
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_2900 SET ' + 'PayMethod = ' + QuotedStr(s) + ',' +
          'Dare = CASE WHEN Dare IS NOT NULL AND Dare > 0 THEN ' + newAmt +
          ' ELSE Dare END,' +
          'Avere = CASE WHEN Avere IS NOT NULL AND Avere > 0 THEN ' + newAmt +
          ' ELSE Avere END ' + 'WHERE TxID = ' + QuotedStr(txID) + ' ' +
          'AND ((Dare = ' + oldAmt + ') OR (Avere = ' + oldAmt + '))');
        ExecSQL;

        // C_5000 --------------------------------------------------------------
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_5000 SET ' + 'PayMethod = ' + QuotedStr(s) + ',' +
          'Dare = CASE WHEN Dare IS NOT NULL AND Dare > 0 THEN ' + newAmt +
          ' ELSE Dare END,' +
          'Avere = CASE WHEN Avere IS NOT NULL AND Avere > 0 THEN ' + newAmt +
          ' ELSE Avere END ' + 'WHERE TxID = ' + QuotedStr(txID) + ' ' +
          'AND ((Dare = ' + oldAmt + ') OR (Avere = ' + oldAmt + '))');
        ExecSQL;

        // C_6000 --------------------------------------------------------------
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_6000 SET ' + 'PayMethod = ' + QuotedStr(s) + ',' +
          'Dare = CASE WHEN Dare IS NOT NULL AND Dare > 0 THEN ' + newAmt +
          ' ELSE Dare END,' +
          'Avere = CASE WHEN Avere IS NOT NULL AND Avere > 0 THEN ' + newAmt +
          ' ELSE Avere END ' + 'WHERE TxID = ' + QuotedStr(txID) + ' ' +
          'AND ((Dare = ' + oldAmt + ') OR (Avere = ' + oldAmt + '))');
        ExecSQL;

        // If everything goes well, commit the transaction (if we started it)
        if OwnTransaction then
          Form2.DB_Main.Commit;

        Sleep(50);

        // Refresh the relevant grids ----------------------------------------
        if s = 'CH' then
        begin
          dbgd_1000_CH.DataSet.DisableControls;
          try
            dbgd_1000_CH.Refresh;
          finally
            dbgd_1000_CH.DataSet.EnableControls;
          end;
        end;

        if s = 'EU' then
        begin
          dbgd_1000_EU.DataSet.DisableControls;
          try
            dbgd_1000_EU.Refresh;
          finally
            dbgd_1000_EU.DataSet.EnableControls;
          end;
        end;

        if s = 'CC' then
        begin
          dbgd_1000_CC.DataSet.DisableControls;
          try
            dbgd_1000_CC.Refresh;
          finally
            dbgd_1000_CC.DataSet.EnableControls;
          end;
        end;

        // Set period filter --------------------------------------------------
        SetDatePeriod(Date, Date, IncDay(Date, 1), workingday, workingDayPeriod,
          False, rg_DayMode.ItemIndex = 1);
        xx_SetClosingPageFilters(nil, cl_Closing_Cal.StartDate,
          cl_Closing_Cal.EndDate, workingday, workingDayPeriod);
        xx_CalcCash(nil);

        ShowMessage('Valuta modificata con successo');

      except
        on E: Exception do
        begin
          // Roll back only if we own the transaction
          if OwnTransaction and Form2.DB_Main.InTransaction then
            Form2.DB_Main.Rollback;
          ShowMessage('An error occurred: ' + E.Message);
        end;
      end;
    end;
  end;
end;

procedure TForm1.dbgd_1000_CHCellClick(Column: TColumnEh);
begin
  dbgd_1000_CH.Columns[2].Footers[0].Value := Form2.qy_1000_CH.FieldByName
    ('CardID').AsString;
  FreceiptTxID := Form2.qy_1000_CH.FieldByName('TxID').AsString;
  FSubFeeID := Form2.qy_1000_CH.FieldByName('SubFeeID').AsInteger;
end;

procedure TForm1.dbgd_1000_CHDblClick(Sender: TObject);
begin
  With Form2.qy_1000_CH do
  begin
    IF FieldByName('Dare').AsFloat = 0 Then
    begin
      ShowMessage('Solo importi > 0 possono essere corretti!');
      Exit;
    end;
    IF NOT FieldByName('ClosingID').IsNull Then
    begin
      ShowMessage('Periodi chiusi non possono essere corretti!');
      Exit;
    end;
    ChangePaymethod(FieldByName('SubFeeID').AsString, FieldByName('cPartita')
      .AsString, FieldByName('TxID').AsString,
      Form2.qy_1000_CH.FieldByName('Dare').AsString, FieldByName('Description')
      .AsString, 'CH', 'EU', 'CC');
  end;
end;

procedure TForm1.dbgd_1000_EUCellClick(Column: TColumnEh);
begin
  dbgd_1000_EU.Columns[2].Footers[0].Value := Form2.qy_1000_EU.FieldByName
    ('CardID').AsString;
  FreceiptTxID := Form2.qy_1000_EU.FieldByName('TxID').AsString;
end;

procedure TForm1.dbgd_1000_EUDblClick(Sender: TObject);
begin
  With Form2.qy_1000_EU do
  begin
    IF FieldByName('Dare').AsFloat > 0 Then
      ChangePaymethod(FieldByName('SubFeeID').AsString, FieldByName('cPartita')
        .AsString, FieldByName('TxID').AsString,
        Form2.qy_1000_EU.FieldByName('Dare').AsString,
        FieldByName('Description').AsString, 'EU', 'CH', 'CC')
    else
      ShowMessage('Solo importi > 0 possono essere corretti!');
  end;
end;

procedure TForm1.dbgd_1000_CCCellClick(Column: TColumnEh);
begin
  dbgd_1000_CC.Columns[2].Footers[0].Value := Form2.qy_1000_CC.FieldByName
    ('CardID').AsString;
  FreceiptTxID := Form2.qy_1000_CC.FieldByName('TxID').AsString;
end;

procedure TForm1.dbgd_1000_CCDblClick(Sender: TObject);
begin
  With Form2.qy_1000_CC do
  begin
    IF FieldByName('Dare').AsFloat > 0 Then
      ChangePaymethod(FieldByName('SubFeeID').AsString, FieldByName('cPartita')
        .AsString, FieldByName('TxID').AsString,
        Form2.qy_1000_CC.FieldByName('Dare').AsString,
        FieldByName('Description').AsString, 'CC', 'CH', 'EU')
    else
      ShowMessage('Solo importi > 0 possono essere corretti!');
  end;
end;

procedure TForm1.dbgd_1000_CHDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  IsWorkingDayNull: Boolean;
  AGrid: TDBGridEh;
begin
  AGrid := TDBGridEh(Sender);

  // Check if WorkingDay is null
  IsWorkingDayNull := Column.Field.DataSet.FieldByName('ClosingID').IsNull;

  // Optionally preserve selection style
  if (gdSelected in State) then
    AGrid.Canvas.Font.Color := clBlue
  else
  begin
    if Not IsWorkingDayNull then
      AGrid.Canvas.Font.Color := clTeal // or any color you prefer
    else
      AGrid.Canvas.Font.Color := clBlack;
  end;

  // Draw the cell
  AGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.dbgd_1000_CHExit(Sender: TObject);
begin
  dbgd_1000_CH.Columns[2].Footers[0].Value := '';
end;

procedure TForm1.dbgd_1000_CHMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  regDetail, amt, Ftxid: String;
begin
  // Reverse bookkeeping entry
  If ClubAccPermissions.ClosingP = 99 then
    If (Button = mbRight) Then
      With Form2.qy_1000_CH do
      begin
        If FieldByName('ClosingID').IsNull Then
        begin
          if Not FieldByName('Dare').IsNull then
            amt := FieldByName('Dare').AsString;

          if Not FieldByName('Avere').IsNull then
            amt := FieldByName('Avere').AsString;

          regDetail := FieldByName('Data').AsString + ' ' +
            FieldByName('Description').AsString + amt + 'CHF';
          Ftxid := FieldByName('TxID').AsString;

          if TaskDlgHelperF.TaskDlg_Default('Contabilitá',
            'Storno di: ' + regDetail, '', 'STORNO', 'NO', '',
            'QuestionMark_48.ico') = mrOk Then
          begin
            ReverseEntry(Ftxid);
            ReverseSoldBy(Ftxid);
          end;

        end
        else
          ShowMessage('Periodi chiusi non possono essere corretti.');
      end;
end;

procedure TForm1.dbgd_1000_EUMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  regDetail, amt, Ftxid: String;
begin
  // Reverse bookkeeping entry
  If ClubAccPermissions.ClosingP = 99 then
    If (Button = mbRight) Then
      With Form2.qy_1000_EU do
      begin
        If FieldByName('ClosingID').IsNull Then
        begin
          if Not FieldByName('Dare').IsNull then
            amt := FieldByName('Dare').AsString;

          if Not FieldByName('Avere').IsNull then
            amt := FieldByName('Avere').AsString;

          regDetail := FieldByName('Data').AsString + ' ' +
            FieldByName('Description').AsString + amt + 'CHF';

          Ftxid := FieldByName('TxID').AsString;

          if TaskDlgHelperF.TaskDlg_Default('Contabilitá',
            'Storno di: ' + regDetail, '', 'STORNO', 'NO', '',
            'QuestionMark_48.ico') = mrOk Then
          begin
            ReverseEntry(Ftxid);
            ReverseSoldBy(Ftxid);
          end;

        end
        else
          ShowMessage('Periodi chiusi non possono essere corretti.');
      end;
end;

procedure TForm1.dbgd_1000_CCMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  regDetail, amt, Ftxid: String;
begin
  // Reverse bookkeeping entry
  If ClubAccPermissions.ClosingP = 99 then
    If (Button = mbRight) Then
      With Form2.qy_1000_CC do
      begin
        If FieldByName('ClosingID').IsNull Then
        begin
          if Not FieldByName('Dare').IsNull then
            amt := FieldByName('Dare').AsString;

          if Not FieldByName('Avere').IsNull then
            amt := FieldByName('Avere').AsString;

          regDetail := FieldByName('Data').AsString + ' ' +
            FieldByName('Description').AsString + amt + 'CHF';

          Ftxid := FieldByName('TxID').AsString;

          if TaskDlgHelperF.TaskDlg_Default('Contabilitá',
            'Storno di: ' + regDetail, '', 'STORNO', 'NO', '',
            'QuestionMark_48.ico') = mrOk Then
          begin
            ReverseEntry(Ftxid);
            ReverseSoldBy(Ftxid);
          end;

        end
        else
          ShowMessage('Periodi chiusi non possono essere corretti.');
      end;
end;

Procedure TForm1.ReverseEntry(txID: String);
begin
  if Trim(txID) <> '' then

    with Form2, qy_TMP do
    begin
      // Start the transaction
      Form2.DB_Main.StartTransaction(['c_1000', 'c_1200', 'c_2900', 'c_5000',
        'c_6000', 'C_1010', 'ServicesSold']);
      try
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_1000 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));
        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_1200 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));

        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_2900 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));

        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_5000 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));

        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_6000 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));
        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE C_1010 SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));
        ExecSQL;

        if Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE ServicesSold SET Canceled = TRUE ' + 'WHERE TxID = ' +
          QuotedStr(txID));
        ExecSQL;

        // If everything goes well, commit the transaction
        Form2.DB_Main.Commit;

        Sleep(50);

        // Set period filter
        // -------------------------------------------------------------------
        qy_1000_CH.Refresh;
        qy_1000_EU.Refresh;
        qy_1000_CC.Refresh;
        If qy_1000_GCC.Active = False Then
          qy_1000_GCC.Open;
        qy_1000_GCC.Refresh;
        // qy_1010_All.Refresh;
        // qy_SS.Refresh;

        dbgd_1000_CH.Refresh;
        dbgd_1000_EU.Refresh;
        dbgd_1000_CC.Refresh;
        dbgd_1000_GCC.Refresh;

        xx_CalcCash(nil);

      except
        on E: Exception do
        begin
          // Roll back all changes if something goes wrong
          Database.Rollback;
          ShowMessage('Rolled back. An error in ReverseEntry occurred: ' +
            E.Message);
        end;
      end;
    end;
end;

Procedure TForm1.ReverseSoldBy(txID: String);
begin
  With Form2, qy_TMPBar do
  begin
    If Active then
      Close;
    SQL.Clear;
    SQL.Text :=
      'UPDATE Bar_SoldByDetail SET Avere = NUll, VatTxID = Null, DataModified = Null '
      + 'WHERE VatTxid = ' + QuotedStr(txID);
    ExecSQL;
    qy_BarSoldBy.Refresh;
    dbgd_AdminClientsSoldBy.Refresh;
  end;
end;

procedure TForm1.dbgd_1000_EUDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  IsWorkingDayNull: Boolean;
  AGrid: TDBGridEh;
begin
  AGrid := TDBGridEh(Sender);

  // Check if WorkingDay is null
  IsWorkingDayNull := Column.Field.DataSet.FieldByName('ClosingID').IsNull;

  // Optionally preserve selection style
  if (gdSelected in State) then
    AGrid.Canvas.Font.Color := clBlue
  else
  begin
    if Not IsWorkingDayNull then
      AGrid.Canvas.Font.Color := clTeal // or any color you prefer
    else
      AGrid.Canvas.Font.Color := clBlack;
  end;

  // Draw the cell
  AGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.dbgd_1000_EUExit(Sender: TObject);
begin
  dbgd_1000_EU.Columns[2].Footers[0].Value := '';
end;

PROCEDURE TForm1.dbgd_1000_CHSumListAfterRecalcAll(Sender: TObject);
Var
  D, A: Double;
BEGIN
  WITH dbgd_1000_CH DO
  begin
    If VarIsNull(Columns[3].Footers[0].SumValue) Then
      D := 0
    else
      D := Columns[3].Footers[0].SumValue;
    If VarIsNull(Columns[4].Footers[0].SumValue) Then
      A := 0
    else
      A := Columns[4].Footers[0].SumValue;
    ed_RecPos_CH.Value := D - A;
  end;
END;

PROCEDURE TForm1.dbgd_1000_EUSumListAfterRecalcAll(Sender: TObject);
Var
  D, A: Double;
BEGIN
  WITH dbgd_1000_EU DO
  begin
    If VarIsNull(Columns[3].Footers[0].SumValue) Then
      D := 0
    else
      D := Columns[3].Footers[0].SumValue;
    If VarIsNull(Columns[4].Footers[0].SumValue) Then
      A := 0
    else
      A := Columns[4].Footers[0].SumValue;
    ed_RecPos_EU.Value := D - A;
  end;
END;

procedure TForm1.dbgd_1000_GCCGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
VAR
  fColor, bColor: TColor;

BEGIN
  fColor := AFont.Color;
  bColor := Background;
  WITH Form2.qy_1000_GCC DO
  BEGIN
    If FieldByName('Balance').AsFloat > 0 Then
    begin
      AFont.Color := clWhite;
      Background := clRed;
    end
    else IF FieldByName('Balance').AsFloat < 0 Then
    begin
      AFont.Color := fColor;
      Background := $00DAFACA;
    end
    else
    begin
      AFont.Color := fColor;
      Background := bColor;
    end;
  END;
end;

procedure TForm1.dbgd_1000_GCCSelectionChanged(Sender: TObject);
begin
  IF uClientStore.ThisClient.ID <> Form2.qy_1000_GCC.FieldByName('ClientID')
    .AsInteger Then
  begin
    {
      ShowMessage('Wrong Selection');
      dbgd_1000_GCC.SelectedRows.CurrentRowSelected := False;
    }
  end;
end;

procedure TForm1.dbgd_1010_GCCDblClick(Sender: TObject);
begin
  Form2.qy_1010_GCC.Active := True;
  Form2.qy_1010_GCC.Refresh;
end;

procedure TForm1.DBGridEh10Columns2EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
Var
  s: String;
begin
  // Complete new fee with data from already existing, similare fee
  // --------------------------------------------------------------
  (*
    With MyTaskDialog do
    begin
    CustomMainIcon.LoadFromFile
    ('C:\Program Files (x86)\PGC_523 - Tokyo - Chiasso - Euro\Images & Icons\MoneyWings_48');
    Caption := 'Gestione prezzi';
    Title := 'Copia dati';
    Text := 'Completa con questi dati il nuovo prezzo.' + #13#10 +
    'Campi già riempiti non vengono copiati.'
    end;
    If MyTaskDialog.Execute Then
    If MyTaskDialog.ModalResult = mrOk Then
    begin
    s := Form2.BuildElevateDBUpdateSQL_FromTable(Form2.tb_Fees,
    ['ID', 'SubID'], // Source Key Fields
    [Form2.tb_Fees_Edit.FieldByName('ID').AsString,
    Form2.tb_Fees_Edit.FieldByName('SubID').AsString],
    // [1, 100],        // Source Key Values
    [ed_tID.Text, ed_tSubID.Text],
    // [555, 666],      // Target Key Values
    ['ID', 'SubID', 'K', 'Icon', 'Notes', 'RecLastMod', 'Enabled',
    'Description'] // Fields to Skip list
    );
    With Form2.qy_TMP do
    begin
    If Active Then
    Close;
    SQL.Clear;
    SQL.Add(s);
    ExecSQL;
    Form2.tb_Fees_Edit.Refresh;
    end;
    end;
  *)
end;

procedure TForm1.dbgd_RoomsDEnter(Sender: TObject);
begin
  DBNavigator5.DataSource := Form2.sc_RREU_Rooms;
end;

PROCEDURE TForm1.DBGridEh1CellClick(Column: TColumnEh);
VAR
  s: STRING;
BEGIN
  WITH Form2 DO
  BEGIN
    tb_FeeE.Locate('SubID', tb_AdMonitors.FieldByName('FeeSubID')
      .AsInteger, []);
    s := Trim(tb_AdMonitors.FieldByName('AdImageName').AsString);
    im_AdAssImage.Picture.LoadFromFile
      (Trim(tb_AdMonitors.FieldByName('AdImageName').AsString));
  END;
END;

PROCEDURE TForm1.DBGridEh2KeyDown(Sender: TObject; VAR Key: Word;
  Shift: TShiftState);
BEGIN
  IF (Key = VK_DELETE) AND (Shift = [ssCtrl]) THEN
    Key := 0;
END;

procedure TForm1.dbgd_FeesEditClick(Sender: TObject);
begin
  With Form2 do
  begin
    tb_FeeE.Locate('ID;SubID',
      varArrayof([tb_FeeE.FieldByName('ID').AsInteger,
      tb_FeeE.FieldByName('SubID').AsInteger]), []);

        tb_Fees_Edit.Locate('ID;SubID',
      varArrayof([tb_FeeE.FieldByName('ID').AsInteger,
      tb_FeeE.FieldByName('SubID').AsInteger]), []);

  dbgd_Fees_Edit.Options := dbgd_Fees_Edit.Options - [DBGridEh.dgEditing] +
    [DBGridEh.dgRowSelect];
    dbVgd_FeesEdit.Refresh;
  end;
end;

procedure TForm1.dbgd_Fees_EditCellClick(Column: TColumnEh);
begin
  Form2.tb_FeeE.Locate('SubID', Form2.tb_Fees_Edit.FieldByName('SubID')
    .AsInteger, []);
  dbgd_FeesEdit.Refresh;
end;

procedure TForm1.dbgd_BuildingsEnter(Sender: TObject);
begin
  DBNavigator5.DataSource := Form2.sc_RREU_Buildings;
end;

PROCEDURE TForm1.dbgd_CashierDisplaySumListAfterRecalcAll(Sender: TObject);
BEGIN
  WITH dbgd_CashierDisplay DO
  BEGIN
    IF Columns[1].Footers[0].SumValue > 0 THEN
    BEGIN
      Columns[1].Footers[1].Value := 'CHF';
    END
    ELSE
      Columns[1].Footers[1].Value := '';

    IF Columns[2].Footers[0].SumValue > 0 THEN
    BEGIN
      Columns[2].Footers[1].Value := 'Euro';
    END
    ELSE
      Columns[2].Footers[1].Value := '';

    Columns[1].Width := 95;
    Columns[2].Width := 95;
  END;
END;

procedure TForm1.dbgd_CashToClientsDblClick(Sender: TObject);
begin
  If advsmtp_PrintRecap.Height = 255 Then
    advsmtp_PrintRecap.Height := 600
  else
    advsmtp_PrintRecap.Height := 255;
end;

PROCEDURE TForm1.bt_CHClick(Sender: TObject);
BEGIN
  xx_SwitchOTabPecunia(1);
END;

PROCEDURE TForm1.bt_EUClick(Sender: TObject);
BEGIN
  xx_SwitchOTabPecunia(2);
END;

PROCEDURE TForm1.bt_CCClick(Sender: TObject);
BEGIN
  xx_SwitchOTabPecunia(3);
END;

PROCEDURE TForm1.bt_PDClick(Sender: TObject);
BEGIN
  xx_SwitchOTabPecunia(4);
END;

PROCEDURE TForm1.bt_OFClick(Sender: TObject);
BEGIN
  xx_SwitchOTabPecunia(5);
END;

PROCEDURE TForm1.xx_SwitchOTabPecunia(Index: Integer);
VAR
  s, pecuniaStr, txID: STRING;
  onlyPDpayments: Boolean;
  dAccount, aAccount: Integer;
  OwnTransaction: Boolean;
BEGIN
  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text :=
      'SELECT SUm(amountCHF) AS SumCH, SUM(amountEuro) AS SumEU FROM openTab ' +
      ' WHERE amountCHF > 0 OR amountEuro > 0  ';
    Active := True;
    If (FieldByName('SumCH').IsNull) AND (FieldByName('SumEU').IsNull) Then
    begin
      ShowMessage('Manca l''importo!');
      bt_Register.Enabled := False;
      Exit;
    end;
  end;

  CASE INDEX OF
    1:
      pecuniaStr := 'CH';
    2:
      pecuniaStr := 'EU';
    3:
      pecuniaStr := 'CC';
    4:
      pecuniaStr := 'PD';
    5:
      pecuniaStr := 'OF';
  END;

  InsertIntoTabMem;

  // Check if cash already in envelope else Get the reception CHF cash balance
  // --------------------------------------------------------------------------

  subFeeID := Form2.tb_oTab.FieldByName('SubFeeID').AsInteger;
  amt := Form2.tb_oTab.FieldByName('AmountToPrint').AsFloat;
  txID := Form2.tb_oTab.FieldByName('TxID').AsString;

  case subFeeID of
    990: // Pag CC rag
      begin
        // If  cc to g is a IBAN payment
        // -------------------------------------------------------------------
        If (index = 3) And (bt_CC.Caption = 'IBAN') then
        begin
          OwnTransaction := not Form2.DB_Main.InTransaction;
          if OwnTransaction then
            Form2.DB_Main.StartTransaction(['OpenTab']);
          try
            with Form2, qy_TMP do
            begin
              if Active then
                Close;
              SQL.Clear;
              SQL.Text := 'UPDATE OpenTab ' + 'SET PayMethod = :PayMethod , ' +
                'AmountEuro = NULL, ' + 'aAccount = :aAccount, ' +
                'dAccount = :dAccount, ' + // 1020 IBAN payments account
                'Description = :Description ' + 'WHERE TxID = :TxID ';
              Params.ParamByName('PayMethod').AsString := 'CH';
              Params.ParamByName('aAccount').AsInteger := 1020;
              Params.ParamByName('dAccount').AsInteger := 2900;
              Params.ParamByName('Description').AsString := 'Pag IBAN CC a ' +
                Copy(ThisClient.fName, 1) + ' ' + ThisClient.lName;
              Params.ParamByName('TxID').AsString := txID;
              ExecSQL;
            end;
            if OwnTransaction then
              Form2.DB_Main.Commit;
            Form2.tb_oTab.Refresh;
          except
            on E: Exception do
            begin
              // Roll back only if we own the transaction
              if OwnTransaction and Form2.DB_Main.InTransaction then
                Form2.DB_Main.Rollback;
              ShowMessage('An error occurred: ' + E.Message);
            end;
          end;
          Exit;
        end;

        // If not already in envelope then check if enough cash to pay
        if not TxDareExists(Form2.qy_TMP, txID, amt) then
        begin
          IF Not NumKeyboard.plCashBuste.Visible Then
          begin
            if HasEnoughCash(amt, pecuniaStr) = False Then
            exit
            //  If MessageDlg('Prelevi CHF da buste cassa precedenti? ' , mtConfirmation, [mbOK, mbNo], 0, mbNo) = mrOk then
            //    NumKeyboard.plCashBuste.Visible := True
              else
              //  Exit;
          end
          else
          begin

          end;
        end;
      end;

    289, 9940: // Rimborso cauzione, Spesa
      begin
        if not HasEnoughCash(amt, pecuniaStr) Then
          Exit;
      end;
  end;

  WITH Form2, qy_TMP DO
  BEGIN
    bt_Cancel.Enabled := False;
    // Get number of records without paymethod
    // -------------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT PayMethod FROM OpenTab WHERE PaYMethod IS NULL OR PayMethod = '''' ');
    Active := True;
    Var
      n: Integer;
    n := RecordCount;

    // Check if PD override intended paymethod
    // -------------------------------------------------------------------------
    Case Form2.tb_oTab.FieldByName('SubFeeID').AsInteger Of
      995, 998, 999:
        begin
          // do nothing
        end
    else
      If n = 0 Then
      begin
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('SELECT COUNT(PayMethod) as cnt FROM OpenTab WHERE PayMethod = ''PD'' ');
        Active := True;
        IF ((Fields[0].AsInteger > 0) AND (pecuniaStr <> 'PD')) Then
          IF MessageDlg('Confermi la sostituzione del PD con ' + pecuniaStr +
            '?', mtConfirmation, [mbOK, mbNo], 0, mbNo) <> mrOk THEN
            Exit;
      end;
    End;

    // Check if all paymethods set
    // -------------------------------------------------------------------------
    WITH Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      IF n > 0 Then // not yet all paymethods set
      begin
        SQL.Text := 'UPDATE OpenTab ' + 'SET PayMethod = :Pay ' +
          'WHERE PayMethod IS NULL OR PayMethod = ''''';
        Params.ParamByName('Pay').AsString := pecuniaStr;
      end
      Else
      begin // All paymethods set
        SQL.Text := 'UPDATE OpenTab ' + 'SET PayMethod = CASE ' +
          ' WHEN ((AmountCHF = 0 OR AmountCHF IS NULL) AND AmountEuro = 0) THEN ''CH'' '
          + '  WHEN PayMethod = ''VT'' THEN PayMethod ' + '  ELSE ' +
          QuotedStr(pecuniaStr) + ' END';
      end;
      ExecSQL;
    end;

    // CH/CC/PD/OF/VT: restore CHF from memory, null EUR
    // -----------------------------------------------------------------------
    if MatchText(pecuniaStr, ['CH', 'CC', 'PD', 'OF', 'VT']) then
    begin
      qy_TMP.Close;
      qy_TMP.SQL.Clear;
      qy_TMP.SQL.Add('UPDATE OpenTab ot ' + 'SET AmountCHF = (' +
        '      SELECT m.AmountCHF ' + '      FROM OpenTabMemory m ' +
        '      WHERE m.SubFeeID = ot.SubFeeID ' +
        '        AND (m.TxID = ot.TxID OR (m.TxID IS NULL AND ot.TxID IS NULL))'
        + '    ), ' + '    AmountEuro = CAST(NULL AS FLOAT) ' +
        'WHERE PayMethod IN (''CH'',''CC'',''PD'',''OF'',''VT'') ' +
        '  AND EXISTS (' + '      SELECT 1 FROM OpenTabMemory m ' +
        '      WHERE m.SubFeeID = ot.SubFeeID ' +
        '        AND (m.TxID = ot.TxID OR (m.TxID IS NULL AND ot.TxID IS NULL))'
        + '    )');
      qy_TMP.ExecSQL;
    end

    // EU: restore EUR from memory, null CHF
    // -----------------------------------------------------------------------
    else if SameText(pecuniaStr, 'EU') then
    begin
      qy_TMP.Close;
      qy_TMP.SQL.Clear;
      qy_TMP.SQL.Add('UPDATE OpenTab ot ' + 'SET AmountEuro = (' +
        '      SELECT m.AmountEuro ' + '      FROM OpenTabMemory m ' +
        '      WHERE m.SubFeeID = ot.SubFeeID ' +
        '        AND (m.TxID = ot.TxID OR (m.TxID IS NULL AND ot.TxID IS NULL))'
        + '    ), ' + '    AmountCHF = CAST(NULL AS FLOAT) ' +
        'WHERE PayMethod = ''EU'' ' + '  AND EXISTS (' +
        '      SELECT 1 FROM OpenTabMemory m ' +
        '      WHERE m.SubFeeID = ot.SubFeeID ' +
        '        AND (m.TxID = ot.TxID OR (m.TxID IS NULL AND ot.TxID IS NULL))'
        + '    )');
      qy_TMP.ExecSQL;
    end;

    tb_oTab.Refresh;

    // Update accounts to PD PayMethod (1000 becomes 1200)
    // -----------------------------------------------------------------------
    Sleep(50);
    WITH Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      IF pecuniaStr = 'PD' Then
        SQL.Add('UPDATE OpenTab SET dAccount = 1200 WHERE dAccount = 1000 and PayMethod = ''PD'' ')
      else
        SQL.Add('UPDATE OpenTab SET dAccount = 1000, PayMethod = ' +
          QuotedStr(pecuniaStr) +
          ' WHERE dAccount = 1200 and PayMethod <> ''PD'' ');
      ExecSQL;
      Form2.tb_oTab.Refresh;
    end;
  END;
  IF NumKeyboard.Showing THEN
  BEGIN
    InsertIntoTabMem;
    NumKeyboard.pl_Keys.Enabled := False;
  END;

  Form2.tb_oTab.Refresh;
  dbgd_CashierDisplay.Refresh;
  dbgd_CashierDisplay.SumList.RecalcAll;

  bt_Cancel.Enabled := NumKeyboard.Showing = False;
  nnSetPecuniaBtUp;
  CheckIfpaymethodComplete;
END;

function TForm1.TxDareExists(qy: TDataSet; const ATxID: string;
  const AAmount: Double): Boolean;
begin
  With Form2.qy_TMP do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT COALESCE(Dare,0) as dAmt, TxID ' + 'FROM c_1010 ' +
      'WHERE Dare = :Amt AND TxID = :TxID';
    ParamByName('Amt').AsFloat := AAmount;
    ParamByName('TxID').AsString := ATxID;
    Open;
    Result := qy.FieldByName('dAmt').AsFloat <> 0;
    qy.Close;
  end;
end;

procedure TForm1.WarnInsufficientCash(const AAmount, Cash: Double;
  const ACurrency: string);
begin
  Form1.nnWriteCashierDisplay(0, True, clYellow, 'Il saldo cassa di ' +
    floatToStr(Cash) + ' ' + ACurrency + ' è insufficiente per pagare ' +
    floatToStr(AAmount) + ' ' + ACurrency, 0);
end;

function TForm1.HasEnoughCash(const AAmount: Double;
  const ACurrency: string): Boolean;
Var
  Cash: Double;
begin
  Cash := GetCashBalance(ACurrency);
  Result := Cash >= AAmount;
  if not Result then
  begin
    WarnInsufficientCash(AAmount, Cash, ACurrency);
    bt_register.Enabled := False;
  end;
end;

function TForm1.GetCashBalance(Pecunia: String): Double;
Var
  workingday, workingDayPeriod: String;
  sDt, eDT: TDateTime;
begin
  If TimeOf(Now) >= EncodeTime(12, 0, 0, 0) Then
  begin
    eDT := IncDay(Now, 1);
    sDt := RecodeTime(Now, 12, 0, 0, 0);
    eDT := RecodeTime(eDT, 11, 59, 59, 999);
  end
  else
  begin
    sDt := IncDay(Now, -1);
    sDt := RecodeTime(sDt, 12, 0, 0, 1);
    eDT := RecodeTime(Now, 11, 59, 59, 999);
  end;

  workingDayPeriod := ' BETWEEN CAST(' +
    QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) + ' AS Timestamp) ' +
    'AND CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
    ' as Timestamp) ';
  wDayPeriod := workingDayPeriod; // wDayPeriod needed in PrintCCtoG
  workingday := Form2.EDBEngine1.DateToSQLStr(DateOf(sDt));

  xx_SetClosingPageFilters(nil, sDt, eDT, workingday, workingDayPeriod);
  with Form1 do
  begin
    IF Pecunia = 'CH' then
      Result := FCashCHavailable + FCashCHBaravailable - FCashCHdirectCCG -
        FCashCHbusteCCG
    else
      Result := FCashEUavailable + FCashEUBaravailable - FCashEUdirectCCG;
  end;
End;

PROCEDURE TForm1.CheckIfpaymethodComplete;
BEGIN
  // Check if paymethod is complete
  // -----------------------------------------------------------------------
  WITH Form2.qy_Tmp2 DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM OpenTab WHERE PayMethod IS NULL OR PayMethod = '''' ');
    Active := True;
    IF NOT NumKeyboard.Showing THEN
      IF RecordCount > 0 THEN
        nnWriteCashierDisplay(0, False, clWhite, 'Scegli la valuta >>', 2)
      ELSE
        nnWriteCashierDisplay(0, False, clLime,
          'Procedi alla registrazione >>', 2);
    // If RecordCount > 0 Then
    nn_SetPecuniaBtToFieldValue;
    // else
    // nn_EnablePecuniaBt(False);
    bt_Register.Enabled := RecordCount = 0;
    Active := False;
  END;
  dbgd_CashierDisplay.SumList.RecalcAll;
END;

PROCEDURE TForm1.dbgd_AdminClientsSSEnter(Sender: TObject);
BEGIN
  cal_Clients.Footer.Caption := 'Contabilità';
END;

PROCEDURE TForm1.dbgd_InRoomDblClick(Sender: TObject);
BEGIN
  xx_CheckIfStillPresent;
END;

procedure TForm1.dbgd_placeholdersDblClick(Sender: TObject);
begin
  With dbgd_placeholders do
  begin
    IF Height = 244 then
    begin
      Height := 488;
      Top := 389;
    end
    else
    begin
      Height := 244;
      Top := 633;
    end;
  end;
end;

procedure TForm1.dbgd_placeholdersMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  {
    if Button = mbLeft then
    begin
    Cell := dbgd_placeholders.MouseCoord(X, Y);
    // only start row‐drag if on a data row (Y>0)
    if Cell.Y > 0 then
    dbgd_placeholders.BeginDrag(False);
    end;

  }
end;

procedure TForm1.dbgd_PresenceDrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
var
  Grd: TDBGrid;
begin
  Grd := TDBGrid(Sender);
  if SameText(Field.AsString, 'WD') then
    Grd.Canvas.Brush.Color := clLime
  else if SameText(Field.AsString, 'D') then
    Grd.Canvas.Brush.Color := clRed
  else if SameText(Field.AsString, 'W') then
    Grd.Canvas.Brush.Color := clSkyBlue;
end;

PROCEDURE TForm1.dbg_Clienti_ClientsCellClick(Column: TColumnEh);
Var
  n: Variant;
BEGIN
  uClientStore.ThisClient.ID := Form2.tb_ClientiClients.FieldByName('ID')
    .AsInteger;
  n := Form2.tb_Cards.Lookup('ClientID',
    intToStr(uClientStore.ThisClient.ID), 'ID');
  IF n <> NULL then
  begin
    ed_ClCardID.Text := intToStr(n);
    // yy_CheckAllClientData('AdminPage', n);
  end
  else
    ed_ClCardID.Text := '';
  Form2.AdminClientSAccountingFilter(calSdt, calEdt, NIL);
  WITH Form2 DO
  BEGIN
    IF lb_CardReadResult.Caption <> '' THEN
      lb_CardReadResult.Caption := '';
  END;
  SetSoldByFilter;
  SetBoughtByFilter;
END;

PROCEDURE TForm1.dbg_Clienti_ClientsEnter(Sender: TObject);
BEGIN
  cal_Clients.Footer.Caption := 'Presenze per data';
END;

PROCEDURE TForm1.dbg_Clienti_ClientsTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
VAR
  SortDirection: STRING;
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    IF dbg_Clienti_Clients.Columns[ACol].Title.SortMarker = smDownEh THEN
      SortDirection := 'ASC'
    ELSE IF dbg_Clienti_Clients.Columns[ACol].Title.SortMarker = smUpEh THEN
      SortDirection := 'DESC'
    ELSE
      SortDirection := 'ASC';
    IndexName := Column.FieldName + '_' + SortDirection;
    First;
  END;
END;

function SafeVal(E: TCustomEdit): Double;
var
  V: Double;
begin
  if TryStrToFloat(E.Text, V) then
    Result := V
  else
    Result := 0;
end;

// Helper function to safely get numeric control value, returns 0 if null/invalid
function SafeGetValue(Edit: TControl): Double;
begin
  Result := 0;
  if Assigned(Edit) then
  begin
    try
      if Edit is TNumberBox then
        Result := TNumberBox(Edit).Value
      else if Edit is TDBNumberEditEh then
        Result := TDBNumberEditEh(Edit).Value;
      // If Value is null/NaN, it will be caught by the except block
    except
      Result := 0;
    end;
  end;
end;

PROCEDURE TForm1.xx_CalcCash(Sender: TObject);

// Helper procedure to safely set numeric control value
  procedure SafeSetValue(Edit: TControl; Value: Double);
  begin
    if Assigned(Edit) then
    begin
      try
        if Edit is TNumberBox then
          TNumberBox(Edit).Value := Value
        else if Edit is TDBNumberEditEh then
          TDBNumberEditEh(Edit).Value := Value;
      except
        // Silently handle any assignment errors
      end;
    end;
  end;

BEGIN
  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT COALESCE(SUM(Dare),0) AS sDare ' + ' FROM C_1000 ' +
      ' WHERE SubFeeID = 999 AND ' + ' Data >= :FDateFrom AND Data < :FDateTo ' +
      ' AND VERIFIED = False';
    ParamByName('FDateFrom').AsDateTime := sDt; // TDate
    ParamByName('FDateTo').AsDateTime := eDT; // TDate
    Open;
    ed_TotWoutGCC.Value := FieldByName('sDare').AsFloat;
  end;

  try
    // Reception totals
    // ----------------
    SafeSetValue(ed_RecDelta_CH, SafeGetValue(ed_RecReal_CH) -
      SafeGetValue(ed_RecPos_CH));
    SafeSetValue(ed_RecDelta_EU, SafeGetValue(ed_RecReal_EU) -
      SafeGetValue(ed_RecPos_EU));
    SafeSetValue(ed_RecDelta_CC, SafeGetValue(ed_RecReal_CC) -
      SafeGetValue(ed_RecPos_CC));

    // Bar totals
    // ----------------
    SafeSetValue(ed_BarDelta_CH, SafeGetValue(ed_BarReal_CH) -
      Abs(SafeGetValue(ed_BarPos_CH)));
    SafeSetValue(ed_BarDelta_EU, SafeGetValue(ed_BarReal_EU) -
      Abs(SafeGetValue(ed_BarPos_EU)));
    SafeSetValue(ed_BarDelta_CC, SafeGetValue(ed_BarReal_CC) -
      Abs(SafeGetValue(ed_BarPos_CC)));

    SafeSetValue(ed_BarRealTotal, SafeGetValue(ed_BarReal_CH) +
      SafeGetValue(ed_BarReal_EU) + SafeGetValue(ed_BarReal_CC));
    SafeSetValue(ed_BarPosTotal, SafeGetValue(ed_BarPos_CH) +
      SafeGetValue(ed_BarPos_EU) + SafeGetValue(ed_BarPos_CC));
    SafeSetValue(ed_BarDeltaTotal, SafeGetValue(ed_BarDelta_CH) +
      SafeGetValue(ed_BarDelta_EU) + SafeGetValue(ed_BarDelta_CC));

    // Rec + Bar Totals
    // -----------------
    SafeSetValue(ed_TotReal_CH, SafeGetValue(ed_RecReal_CH) +
      SafeGetValue(ed_BarReal_CH));

    SafeSetValue(ed_TotReal_EU, SafeGetValue(ed_RecReal_EU) +
      SafeGetValue(ed_BarReal_EU));

    SafeSetValue(ed_TotReal_CC, SafeGetValue(ed_RecReal_CC) +
      SafeGetValue(ed_BarReal_CC));

    SafeSetValue(ed_TotPos_CH, SafeGetValue(ed_RecPos_CH) +
      SafeGetValue(ed_BarPos_CH));
    SafeSetValue(ed_TotPos_EU, SafeGetValue(ed_RecPos_EU) +
      SafeGetValue(ed_BarPos_EU));
    SafeSetValue(ed_TotPos_CC, SafeGetValue(ed_RecPos_CC) +
      SafeGetValue(ed_BarPos_CC));

    ed_TotDelta_CH.Value := ed_TotReal_CH.Value - ed_TotPos_CH.Value;
    ed_TotDelta_EU.Value := ed_TotReal_EU.Value - ed_TotPos_EU.Value;
    ed_TotDelta_CC.Value := ed_TotReal_CC.Value - ed_TotPos_CC.Value;

    SafeSetValue(ed_RealTot, SafeGetValue(ed_TotReal_CH) +
      SafeGetValue(ed_TotReal_EU) + SafeGetValue(ed_TotReal_CC));
    SafeSetValue(ed_PosTot, SafeGetValue(ed_TotPos_CH) +
      SafeGetValue(ed_TotPos_EU) + SafeGetValue(ed_TotPos_CC));
    SafeSetValue(ed_DeltaTot, SafeGetValue(ed_TotDelta_CH) +
      SafeGetValue(ed_TotDelta_EU) + SafeGetValue(ed_TotDelta_CC));
    FormatFloat('+0.00;-0.00;0.00', ed_DeltaTot.Value);
    ed_TotNetClub.Value := ed_RealTot.Value - ed_TotWoutGCC.Value;

    SafeSetValue(ed_RecPos_CHSaldo, SafeGetValue(ed_TotReal_CH) +
      SafeGetValue(ed_RecPos_CH_G) + SafeGetValue(ed_RecPos_CHGCC));

    SafeSetValue(ed_RecPos_EUSaldo, SafeGetValue(ed_TotReal_EU) +
      SafeGetValue(ed_RecPos_EU_G));

  except
    on E: Exception do
    begin
      // Handle any unexpected errors during calculation
      ShowMessage('Error in cash calculation: ' + E.Message);
    end;
  end;
end;

PROCEDURE TForm1.cal_BarSelectDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
VAR
  ShiftTimes: TArray<TDateTime>;
  StartTime, EndTime: TDateTime;
BEGIN
  ShiftTimes := GetWorkShiftForDateRange(cal_Bar,
    ClubAccPermissions.LimitClosingCalDays);
  calSdt := ShiftTimes[0];
  calEdt := ShiftTimes[1];
  IF calSdt = 0 Then
    Exit;
  xx_UpdateBarPage(calSdt, calSdt, calEdt);
END;

PROCEDURE TForm1.cal_BarSelectMultiDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
VAR
  ShiftTimes: TArray<TDateTime>;
  StartTime, EndTime: TDateTime;
BEGIN
  ShiftTimes := GetWorkShiftForDateRange(cal_Bar,
    ClubAccPermissions.LimitClosingCalDays);

  calSdt := ShiftTimes[0];
  calEdt := ShiftTimes[1];
  IF calSdt = 0 Then
    Exit;
  xx_UpdateBarPage(calSdt, calSdt, calEdt);
END;

Procedure TForm1.xx_UpdateBarPage(CalSelDt, CalStartDt, CalEndDt: TDateTime);
Var
  groupByWaiter: Boolean;
  s: STRING;
BEGIN
  dbgd_BarClosing.Columns[0].Footers[0].Value := '';
  IF DaySpan(calSdt, calEdt) > 1 Then
  begin
    groupByWaiter := False;
    s := '';
    dbgd_BarClosing.Columns[3].Title.Caption := 'Tutti Baristi';
  end
  else
  begin
    groupByWaiter := True;
    s := ' ,Waiter ';
    dbgd_BarClosing.Columns[3].Title.Caption := 'Singolo Barista';
  end;

  WITH Form2.qy_BarTmp DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Bar';
    SQL.Add('SELECT * FROM Bar_OpLedger ' + 'WHERE Dare > 0 AND Data BETWEEN ' +
      'CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', calSdt)) +
      ' AS TIMESTAMP) AND ' + 'CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', calEdt)) +
      ' AS TIMESTAMP) ');
    Active := True;
    If RecordCount = 0 Then
    begin
      Form2.qy_BarClosing.Close;
      dbgd_BarClosing.Refresh;
      Exit;
    end;
  END;

  WITH Form2.qy_BarClosing DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Bar';

    SQL.Add('  SELECT ClosingID ' + s + ', ' +
      ' SUBSTRING(CAST(CAST(MIN(Data) AS TIME) AS VARCHAR(8)) FROM 1 FOR 5) AS FromShift, '
      + ' SUBSTRING(CAST(CAST(MAX(Data) AS TIME) AS VARCHAR(8)) FROM 1 FOR 5) AS ToShift, '
      + '  COALESCE(SUM(CASE WHEN PayMethod = ''CH'' THEN Dare ELSE 0 END), 0) AS SumCH, '
      + '  COALESCE(SUM(CASE WHEN PayMethod = ''EU'' THEN Dare ELSE 0 END), 0) AS SumEU, '
      + '  COALESCE(SUM(CASE WHEN PayMethod = ''CC'' THEN Dare ELSE 0 END), 0) AS SumCC, '
      + '  COALESCE(SUM(CASE WHEN PayMethod = ''RT'' THEN Dare ELSE 0 END), 0) AS SumRT, '
      + '  COALESCE(SUM(CASE WHEN PayMethod IN (''CH'',''EU'',''CC'',''RT'') THEN Dare ELSE 0 END), 0) AS TotalDirectBarSales, '
      +
      // Count rows with PayMethod = 'ET' (independent of Dare value in the CASE; WHERE already filters Dare > 0)
      '  COUNT(CASE WHEN PayMethod = ''ET'' THEN 1 END) AS TotalEntryTickets, '
      + '  COALESCE(SUM(CASE WHEN PayMethod IN (''CH'',''EU'',''CC'',''RT'') ' +
      '                    AND SoldBy IS NOT NULL AND SoldBy <> 0 AND Dare > 0 '
      + '               THEN Dare ELSE 0 END), 0) AS TotalSoldBy ' +
      ' FROM Bar_OpLedger ' + ' WHERE Dare > 0 AND Data BETWEEN ' + '  CAST('''
      + FormatDateTime('yyyy-MM-dd HH:mm:ss', calSdt) + ''' AS TIMESTAMP) AND '
      + '  CAST(''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', calEdt) +
      ''' AS TIMESTAMP) ' + 'GROUP BY ClosingID ' + s + ' ' +
      'ORDER BY ClosingID ' + s);
    Active := True;
    dbgd_BarClosing.Refresh;
  END;
  // Get SoldBy totals
  With Form2.qy_BarOpLedger do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text :=
      'SELECT Data, ProductName, Dare, Avere,PayMethod, bS.SoldBy,c.Alias,  txid, Waiter FROM Bar_OpLedger bO '
      + ' Left Join PGC_Bar.Bar_Products bP ON bO.ProductID = bP.ProductID ' +
      ' LEFT JOIN PGC_Bar.Bar_SoldByDetail bS ON bS.TxID = bO.TxID ' +
      ' LEFT JOIN PGC_DB_Main_Euro.Clients c ON c.ID = bS.SoldBy ' +
      ' WHERE  Data BETWEEN ' + '  CAST(''' +
      FormatDateTime('yyyy-MM-dd HH:mm:ss', calSdt) +
      ' '' AS TIMESTAMP) AND CAST(''' + FormatDateTime('yyyy-MM-dd HH:mm:ss',
      calEdt) + ' '' AS TIMESTAMP) ';

    Open;
  end;
  dbgd_BarOpLedger.Refresh;
end;

PROCEDURE TForm1.cal_ClientsSelectDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
VAR
  ShiftTimes: TArray<TDateTime>;
  StartTime, EndTime: TDateTime;
  s: STRING;
BEGIN
  ShiftTimes := GetWorkShiftForDateRange(cal_Clients,
    ClubAccPermissions.LimitClosingCalDays);
  calSdt := ShiftTimes[0];
  calEdt := ShiftTimes[1];
  Form2.tb_ClientiClients.FieldValues['ID'];
  Form2.AdminClientSAccountingFilter(calSdt, calEdt, Sender);
  UpdatePresenceCalendar;
END;

PROCEDURE TForm1.cal_ClientsSelectMultiDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
VAR
  ShiftTimes: TArray<TDateTime>;
  StartTime, EndTime: TDateTime;

BEGIN
  ShiftTimes := GetWorkShiftForDateRange(cal_Clients,
    ClubAccPermissions.LimitClosingCalDays);
  calSdt := ShiftTimes[0];
  calEdt := ShiftTimes[1];
  Form2.AdminClientSAccountingFilter(calSdt, calEdt, Sender);
END;

procedure TForm1.cal_ClRosterChange(Sender: TObject);
begin

  UpdateSaliteStats;

end;

PROCEDURE TForm1.cal_gPecSelectDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
VAR
  sdate, edate: TDateTime;
BEGIN
  gStatDays := 1;
  // nSetgStats(RecodeTime(Date, 12, 0, 0, 0), RecodeTime(IncDay(Date, 1), 11, 59, 0, 0));
END;

PROCEDURE TForm1.cal_gPecSelectMultiDate(Sender: TObject;
  Mode: TAdvSmoothCalendarDateMode; StartDate, EndDate: TDateTime);
BEGIN
  gStatDays := DaysBetween(RecodeTime(StartDate, 12, 0, 0, 0),
    RecodeTime(IncDay(EndDate, 1), 11, 59, 0, 0));
  // nSetgStats(RecodeTime(StartDate, 12, 0, 0, 0), RecodeTime(IncDay(EndDate, 1),  11, 59, 0, 0));
END;

PROCEDURE TForm1.rg_CardEditChoiceClick(Sender: TObject);
BEGIN
  CASE rg_CardEditChoice.ItemIndex OF
    0:
      BEGIN
        cb_CardsOK.Enabled := True;
        cb_CardDescription1.Enabled := True;

      END;
    1:
      BEGIN
        cb_CardsOK.Enabled := False;
        cb_CardsOK.Checked := False;
        cb_CardDescription1.Enabled := True;

      END;
    2:
      BEGIN
        cb_CardsOK.Enabled := False;
        cb_CardsOK.Checked := False;
        cb_CardDescription1.Enabled := False;
      END;
  END;
END;

PROCEDURE TForm1.rg_ClubOrCardsClick(Sender: TObject);
Var
  workingday, workingDayPeriod: String;

BEGIN

  SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
    IncDay(cl_Closing_Cal.StartDate, 1), workingday, workingDayPeriod, False,
    rg_DayMode.ItemIndex = 1);
  xx_SetClosingPageFilters(Sender, cl_Closing_Cal.StartDate,
    cl_Closing_Cal.EndDate, workingday, workingDayPeriod);

  ShowCCtoGirls(cl_Closing_Cal.StartDate, workingDayPeriod, True);
end;

// ------------------------------------------------------------------------------
// Tag Reader functions and procedures - unit TAGC32 version AM001 needed
// ------------------------------------------------------------------------------

PROCEDURE TForm1.rg_PrintReportsClick(Sender: TObject);
BEGIN
  // bt_PrintReport.Enabled := rg_PrintReports.ItemIndex > -1;
END;

PROCEDURE TForm1.rg_WhatClick(Sender: TObject);
BEGIN
  CASE rg_What.ItemIndex OF
    0:
      what := GetInstallDrive +
        '\Program Files (x86)\PGC_522 - Tokyo - Chiasso - EXP\LanMaster_new\MGuard.exe';
    1:
      what := GetInstallDrive +
        '\Program Files (x86)\PGC_510\LanMaster_new\MGuard.exe';
  END;
END;

PROCEDURE TForm1.rg_CommissionCCClick(Sender: TObject);
BEGIN
  CASE rg_CommissionCC.ItemIndex OF
    0:
      lb_commission.Caption := 'Commissione CC ogni 100 e frazione: ';
    1:
      lb_commission.Caption := 'Commissione in percentuale ';
  END;
END;

procedure TForm1.rg_cash2clientClick(Sender: TObject);
begin
  PrintCCtoG(cl_Closing_Cal.StartDate, IncDay(cl_Closing_Cal.StartDate, 1),
    wDayPeriod);
end;

Procedure TForm1.PrintCCtoG(StartDate, EndDate: TDateTime;
  workingDayPeriod: String);
begin
  // Deduct CC to G
  // ---------------------------------------------------------------------------
  IF Form2.qy_1000_CC.RecordCount > 0 Then
    With Form2.qy_TMP do
    begin
      IF Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT COALESCE(Sum(Dare),0) as sDare FROM c_1000 ' +
        ' WHERE SubFeeID = 999 AND Data ' + workingDayPeriod;
      Open;
      IF RecordCount > 0 Then
      begin
        ed_TotWoutGCC.Value := FieldByName('sDare').AsFloat;
        ed_TotNetClub.Value := ed_RealTot.Value - ed_TotWoutGCC.Value;
      end
      else
        ed_TotWoutGCC.Value := ed_RealTot.Value;
      Close;
    end;

  CASE rg_cash2client.ItemIndex OF
    0: // Ricap Clients
      BEGIN
        s := 'SELECT Clients.Alias,  ' +
          ' Clients.LastName || '' '' || Clients.FirstName AS Name, ' +
          ' COALESCE(sum(c_1000.Dare),0) AS Entrata, COALESCE(SUM(c_1000.Avere),0) AS Uscita '
          + ' FROM Clients INNER JOIN c_1000 On Clients.id = c_1000.ClientID ' +
          ' WHERE Data ' + workingDayPeriod +
          ' AND (SubFeeID = 990 OR SubFeeID = 999) ' +
          ' GROUP BY Clients.Lastname ORDER BY Clients.Alias ';
      END;
    1: // Detail clients
      BEGIN
        s := 'SELECT Data, Clients.Alias, ' +
          ' Clients.LastName || '' '' || Clients.FirstName AS Name, ' +
          ' Dare AS Entrata, Avere AS Uscita  ' +
          ' FROM Clients INNER JOIN c_1000 On Clients.id = c_1000.ClientID ' +
          ' WHERE  c_1000.Data ' + workingDayPeriod +
          ' AND (SubFeeID = 990 OR SubFeeID = 999) ' +
          ' ORDER BY Clients.Alias, Data ';
      END;

    2: // Detail day
      BEGIN
        s := 'SELECT Data, ' +
          ' Clients.LastName || '' '' || Clients.FirstName AS Name, Dare AS Entrata, '
          + ' Avere AS Uscita ' +
          ' FROM Clients INNER JOIN c_1000 On Clients.id = c_1000.ClientID ' +
          '  WHERE Data ' + workingDayPeriod +
          ' AND (SubFeeID = 990 OR SubFeeID = 999) ' + ' ORDER BY Data ';
      END;
  END;
  With Form2.qy_CashToClients do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add(s);
    Active := True;
    dbgd_CashToClients.Refresh;
  end;

end;

PROCEDURE TForm1.rg_LogToMailFileRadioButtonClick(Sender: TObject);
BEGIN
  bt_TestMail.Enabled := rg_LogToMailFile.RadioButtons[0].Checked;
  bt_TestText.Enabled := rg_LogToMailFile.RadioButtons[1].Checked;
END;

FUNCTION TForm1.ReadCard(block: Integer; Sender: TObject): STRING;
BEGIN
  IF NOT TagTesterPresent THEN
  // solo per precauzione
  BEGIN
    Result := '';
    Exit;
  END;
  TagReader.ContinuoScan := False;
  TagReader.SingleScan;
  IF NOT TagReader.SelectTag(tID) THEN
  BEGIN
    Result := '';
    Exit;
  END;
  IF (TagReader.RC = '14') AND (TagReader.ReadBlock(byte(block))) THEN
  BEGIN
    Result := TagReader.Rfid_strBlockData;
    Label1.Caption := Result;
  END;
END;

PROCEDURE TForm1.pc_SettingDetailPageChanging(Sender: TObject;
  FromPage, ToPage: Integer; VAR AllowChange: Boolean);
BEGIN

  IF startUp THEN
  BEGIN
    AllowChange := True;
    Exit;
  END;
  CASE ToPage OF
    0:
      AllowChange := ClubAccPermissions.PrintSettings;
    1:
      BEGIN
        AllowChange := ClubAccPermissions.CassaSettings;
        pl_Settings3.Visible := ClubAccPermissions.CassaSettings;
      END;
    2:
      AllowChange := ClubAccPermissions.RoomSettings;
    3:
      AllowChange := ClubAccPermissions.InterfaceSettings;
    4:
      AllowChange := ClubAccPermissions.ComPortSettings;
    5:
      AllowChange := ClubAccPermissions.MailSettings;

    6:
      BEGIN
        AllowChange := ClubAccPermissions.RoomSettings;

      END;
    7:
      BEGIN
        AllowChange := ClubAccPermissions.RoomSettings;
        Form2.tb_RREU_Rooms.Refresh;
        dbgd_Rooms.Refresh;
      END;
  END;

END;

PROCEDURE TForm1.pg_PecuniaDetailChanging(Sender: TObject;
  FromPage, ToPage: Integer; VAR AllowChange: Boolean);
BEGIN
  CASE ToPage OF
    1:
      AllowChange := ClubAccPermissions.ClosingP = 99;
  END;
END;

PROCEDURE TForm1.popmn_BonMalPopup(Sender: TObject);
BEGIN
  popmn_BonMal.Items[0].Caption := 'Assegna a ' + Form2.tb_FeeE.FieldByName
    ('Description').AsString;
END;

PROCEDURE TForm1.RemovePrintItem(Sender: TObject; DataSet: TDataSet);
VAR
  SubFeeIDs: TStringList;
  SelectedID: STRING;
  CleanID: STRING;
  NewValue: STRING;
BEGIN
  // Get the selected SubFeeID from the clicked menu item
  SelectedID := (Sender AS TMenuItem).Caption;

  // Remove the '&' character from the caption
  CleanID := StringReplace(SelectedID, '&', '', [rfReplaceAll]);

  // Ensure the dataset is valid
  IF Assigned(DataSet) AND DataSet.Active THEN
  BEGIN
    SubFeeIDs := TStringList.Create;
    TRY
      SubFeeIDs.Delimiter := ',';
      SubFeeIDs.StrictDelimiter := True;
      SubFeeIDs.DelimitedText := DataSet.FieldByName
        (FPopupDataFieldName).AsString;

      // Remove the cleaned ID
      IF SubFeeIDs.IndexOf(CleanID) >= 0 THEN
      BEGIN
        SubFeeIDs.Delete(SubFeeIDs.IndexOf(CleanID));
        NewValue := SubFeeIDs.DelimitedText;

        // Update the field in the dataset
        DataSet.Edit;
        DataSet.FieldByName(FPopupDataFieldName).AsString := NewValue;
        DataSet.Post;

        ShowMessage(Format('Item %s removed successfully.', [CleanID]));
      END
      ELSE
      BEGIN
        ShowMessage(Format('Item %s not found.', [CleanID]));
      END;
    FINALLY
      SubFeeIDs.Free;
    END;
  END
  ELSE
    ShowMessage('Dataset is not assigned or inactive.');
END;

PROCEDURE TForm1.RemovePrintItemHandler(Sender: TObject);
VAR
  DataSet: TDataSet;
BEGIN
  // Retrieve the dataset from the Tag property
  DataSet := TDataSet(Pointer((Sender AS TMenuItem).Tag));

  // Call the RemoveSubFeeID procedure
  RemovePrintItem(Sender, DataSet);
END;

PROCEDURE TForm1.msg_TeseuListButtonClick(Sender: TObject; Index: Integer);
BEGIN
  IF INDEX = 0 THEN
    PrintTeseuList(Sender);
END;

PROCEDURE TForm1.pcTP_RoomsShow(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := 'Inhouse = True';
    Filtered := True;
  END;
END;

procedure TForm1.btn_PrintReceiptClick(Sender: TObject);

  function PadRight(const s: string; W: Integer): string;
  begin
    Result := Copy(s, 1, W);
    if Length(Result) < W then
      Result := Result + StringOfChar(' ', W - Length(Result));
  end;

  function PadLeft(const s: string; W: Integer): string;
  begin
    if Length(s) >= W then
      Result := Copy(s, 1, W)
    else
      Result := StringOfChar(' ', W - Length(s)) + s;
  end;

var
  Description, paymethod, ADate, txID: String;
  amt: Double;
  Printer: TPrinter;
  PrinterName: String;
  Line, s: string;
  YPos, LineHeight: Integer;
  CharsPerLine, NameW, NumW: Integer;
  LeftMarginPx, RightMarginPx, UsablePx: Integer;
  SDare, SAvere: string;
Begin
  With Form2.qy_TMP do
  begin
    amt := 0;
    If FreceiptTxID = '' Then
    begin
      ShowMessage('TxID vuoto. Stampa non possibile.');
      Exit;
    end;
    begin
      If Active Then
        Close;
      SQL.Clear;
      IF FSubFeeID = 800 Then // bar direct sale
        SQL.Text :=
          ' SELECT Data,bpr.ProductName,c.SubFeeID,bop.Dare,bop.Avere,PayMethod,TxID '
          + ' FROM PGC_DB_Main_Euro.c_1000 c ' +
          ' LEFT JOIN PGC_Bar.Bar_OpLedger bop ON bop.txid = c.TxID ' +
          ' LEFT JOIN PGC_Bar.Bar_Products bpr ON bpr.ProductID = bop.ProductID '
          + ' WHERE TxID = ' + QuotedStr(FreceiptTxID) + ' AND ' +
          ' c.SubFeeID IN (800) ' + ' ORDER BY bop.Dare '
      else
        SQL.Text :=
          'SELECT Data,Description,c.SubFeeID,Dare,PayMethod,PrintThisFeeOnReceipt,TxID '
          + ' FROM c_1000 c ' + ' LEFT JOIN Fees f ON f.SubID = c.SubFeeID ' +
          ' WHERE TxID = ' + QuotedStr(FreceiptTxID) + ' AND ' +
          ' SubFeeID IN (100,110,119,190,410,510,511,610,910,920,930,940,949,950,998,999)';
      Open;

      If (RecordCount > 0) {
        AND
        (FieldByName('PrintThisFeeOnReceipt').AsBoolean = True)
      } Then
      begin
        // Get data
        // ---------------------------------------------------------------------
        txID := FieldByName('TxID').AsString;
        paymethod := FieldByName('PayMethod').AsString;
        ADate := FormatDateTime('dd/mm/yyyy hh:nn',
          FieldByName('Data').AsDateTime);
        Case FieldByName('SubFeeID').AsInteger Of
          100 .. 190, 910 .. 950:
            Description := FieldByName('Description').AsString;
          800:
            Description := '';
          410, 510, 511, 610:
            Description := 'Stanza ' + FieldByName('Description').AsString;
          998, 999:
            Description := 'Massaggi distensivi';
        else
          begin
            ShowMessage
              ('Per questo incasso non è possibile stampare ricevute.');
            Exit;
          end;
        End;
        While not EOF do
        begin
          amt := amt + FieldByName('Dare').AsFloat;
          Next;
        end;

        // Print receipt
        // ---------------------------------------------------------------------
        Printer := GetMyPrinter;
        PrinterName := Printer.Printers[Printer.PrinterIndex];
        begin
          Printer.BeginDoc;
          Printer.Canvas.Font.Name := 'Trajan Pro 3 Semibold';
          // Monospaced font for alignment
          Printer.Canvas.Font.Size := 18;
          LineHeight := Printer.Canvas.TextHeight('X');
          // Dynamically calculate line height
          YPos := 20;
          s := '       P O M P E I I';
          Printer.Canvas.TextOut(10, YPos, s);

          Printer.Canvas.Font.Size := 10;

          Printer.Canvas.Font.Name := 'Lucida Console';
          // Monospaced font for alignment
          Inc(YPos, LineHeight);

          Printer.Canvas.TextOut(10, YPos, '        GENTLEMEN''S CLUB');
          Inc(YPos, LineHeight); // Lineheight = 67

          Printer.Canvas.TextOut(10, YPos, '    Via Brogeda 1 - 6830 Chiasso');
          Inc(YPos, LineHeight - 25); // Lineheight = 67

          Printer.Canvas.TextOut(10, YPos, '           +41 91 682 76 56');
          Inc(YPos, LineHeight - 25); // Lineheight = 67

          Printer.Canvas.TextOut(10, YPos, '   info@pompeiigentlemensclub.com');
          Inc(YPos, LineHeight - 25); // Lineheight = 67

          Printer.Canvas.TextOut(10, YPos, '    Opas SA IVA: CHE-115.789.294');
          Inc(YPos, LineHeight + 23); // Lineheight = 67

          Printer.Canvas.Font.Size := 11;

          IF FieldByName('SubFeeID').AsInteger = 800 then
          begin
            // Printer.Canvas.Font.Name := 'Courier New';
            Printer.Canvas.Font.Size := 10;
            First;
            WHILE not EOF do
            begin

              LeftMarginPx := 0; // move left if you can
              RightMarginPx := Printer.Canvas.TextWidth('00');
              // keep a small safe margin

              UsablePx := Printer.PageWidth - LeftMarginPx - RightMarginPx;
              CharsPerLine := UsablePx div Printer.Canvas.TextWidth('0');

              NumW := 8;
              // was 10 -> narrower numbers = more space before right edge
              NameW := CharsPerLine - (NumW * 2) - 2;
              // 2 single-space separators
              if NameW < 8 then
                NameW := 8;
              // 2 spaces between columns
              if NameW < 10 then
                NameW := 10; // safety
              if FieldByName('Dare').AsFloat > 0 then
                SDare := FormatFloat('0.00', FieldByName('Dare').AsFloat)
              else
                SDare := '';
              if FieldByName('Avere').AsFloat > 0 then
                SAvere := FormatFloat('0.00', FieldByName('Avere').AsFloat)
              else
                SAvere := '';
              var
                PName: String;
              if FieldByName('ProductName').IsNull then
                PName := 'Totale '
              else
                PName := FieldByName('ProductName').AsString;

              Line := PadRight(PName, NameW) + ' ' + PadLeft(SDare, NumW) + ' '
                + PadLeft(SAvere, NumW);

              Printer.Canvas.TextOut(10, YPos, Line);
              Inc(YPos, LineHeight - 22);
              Next
            end;
          end
          else
          begin
            Printer.Canvas.TextOut(10, YPos, Description);
            Inc(YPos, LineHeight - 22);
            IF ed_ReceiptCustomText.Text <> '' then
            begin
              Printer.Canvas.Font.Size := 10;
              Printer.Canvas.TextOut(10, YPos, ed_ReceiptCustomText.Text);
              Inc(YPos, LineHeight - 22);
              Printer.Canvas.Font.Size := 11;
            end;

            Printer.Canvas.TextOut(10, YPos,
              ('Totale ' + FloatToStrF(amt, ffCurrency, 15, 2)));
            Inc(YPos, LineHeight - 22);
            Printer.Canvas.Font.Size := 10;
          end;

          IF InRange(FieldByName('SubFeeID').AsInteger, 998, 999) Then
          begin
            Printer.Canvas.TextOut(10, YPos, 'eseguiti da terzi');
            Inc(YPos, LineHeight);
          end
          else
          begin
            Printer.Canvas.TextOut(10, YPos, '(Iva 8.1% compresa )');
            Inc(YPos, LineHeight);
          end;

          Printer.Canvas.TextOut(10, YPos, '. ');
          Inc(YPos, LineHeight);
          Printer.Canvas.TextOut(10, YPos, 'Chiasso, ' + ADate);
          Inc(YPos, LineHeight - 25);
          Printer.Canvas.Font.Size := 9;
          Printer.Canvas.TextOut(10, YPos, 'Receipt copy printed on: ' +
            FormatDateTime('dd/mm/yyyy hh:nn', Now));
          Inc(YPos, LineHeight);
          Printer.Canvas.TextOut(10, YPos, '. ');
          Printer.EndDoc;
          Close;
          SQL.Clear;
          SQL.Text := 'UPDATE c_1000 SET Receipt = True WHERE TxID = ' +
            QuotedStr(txID);
          ExecSQL;
          UnPrepare;
        end;
      end
      else
        ShowMessage('TxID ' + FreceiptTxID +
          ' non trovato o la stampa ricevute è disattivata nei PREZZI');
    end;
  end;
  ed_ReceiptCustomText.Text := '';
end;

procedure TForm1.AdvGlassButton10Click(Sender: TObject);
begin
  pl_CC.Visible := Not pl_CC.Visible;
end;

procedure TForm1.AdvGlassButton1Click(Sender: TObject);
begin
  if not Assigned(frmHelp) then
    frmHelp := TfrmHelp.Create(Self);
  frmHelp.ShowHelpTopic('FeePosTextImgQR_help.html');
end;

procedure TForm1.AdvGlassButton2Click(Sender: TObject);
begin
  if not Assigned(frmHelpEditor) then
    frmHelpEditor := TfrmHelpEditor.Create(Self);
  frmHelpEditor.Show;
end;

procedure TForm1.AdvGlassButton4Click(Sender: TObject);
begin
  PrintCleaningSheet(True);
end;

procedure TForm1.AdvGlassButton5Click(Sender: TObject);
Var
  Printer: TPrinter;
  PrinterName: String;
begin

  Printer := GetMyPrinter;
  PrinterName := Printer.Printers[Printer.PrinterIndex];

  PrintFromStackPanel(StackPanel1, Printer);
end;

procedure TForm1.AdvGlassButton8Click(Sender: TObject);
begin
  PrintManutNotes(True);
end;

procedure TForm1.AdvGlassButton9Click(Sender: TObject);
begin
  UpdateMissingClosingIDS;
end;

Procedure TForm1.UpdateMissingClosingIDS;
var
  s: STRING;
begin
  s := ' SET ClosingID = CASE ' +
    ' WHEN EXTRACT(HOUR FROM CAST(Data AS TIMESTAMP)) < 12 ' +
    ' THEN CAST((CAST(Data AS DATE) - INTERVAL ''1'' DAY) AS VARCHAR(10)) ' +
    ' ELSE CAST(CAST(Data AS DATE) AS VARCHAR(10))  END ' +
    ' WHERE (ClosingID IS NULL OR ClosingID = ''0'' OR ClosingID = ''1899-12-30'')'
    + ' AND Data IS NOT NULL AND CAST(Data AS DATE) <> DATE ''1899-12-30'' ';
  With Form2.qy_Tmp2 do
  begin
    If Active Then
      Close;
    SQL.Clear;
    Form2.DB_Main.StartTransaction(['c_1000', 'C_1010', 'c_1200', 'c_2900',
      'c_5000', 'c_6000', 'Pecunia']);
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Text := 'UPDATE C_1000 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE C_1010 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE C_1200 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE C_2900 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE C_5000 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE C_6000 ' + s;
      ExecSQL;

      SQL.Clear;
      SQL.Text := 'UPDATE Pecunia ' + s;
      ExecSQL;

      // If everything goes well, commit the transaction
      Form2.DB_Main.Commit;
    except
      on E: Exception do
      begin
        // Roll back all changes if something goes wrong
        Database.Rollback;
        ShowMessage
          ('Rolled back. An error in UpdateMissingClosingIDS Reception occurred: : '
          + E.Message);
      end;
    end;

    // Update bar tables
    With Form2.qy_TMPBar do
    begin
      If Active Then
        Close;
      SQL.Clear;
      Form2.DB_Bar.StartTransaction(['Bar_OpLedger', 'Bar_SoldByDetail',
        'Bar_TabArchived']);
      try
        if Active then
          Close;
        SQL.Clear;
        SQL.Text := 'UPDATE Bar_OpLedger ' + s;
        ExecSQL;

        SQL.Clear;
        SQL.Text := 'UPDATE Bar_SoldByDetail' + s;
        ExecSQL;

        SQL.Clear;
        SQL.Text := 'UPDATE Bar_TabArchived' + s;
        ExecSQL;

        // If everything goes well, commit the transaction
        Form2.DB_Bar.Commit;
      except
        on E: Exception do
        begin
          // Roll back all changes if something goes wrong
          Database.Rollback;
          ShowMessage
            ('Rolled back. An error in UpdateMissingClosingIDS Bar occurred: ' +
            E.Message);
        end;
      end;
    end;
  end;
end;

procedure TForm1.bt_MultiRegClick(Sender: TObject);
begin
  bt_CancelAllClick(Sender);
  If ReadCardOnReader < 0 Then
    Exit;
  IF VerifyCard(uClientStore.ThisCard.cardID) < 0 then
    Exit;
  yy_CheckAllClientData('bt_MultiReg', uClientStore.ThisCard.cardID);
  ShowNumKeyboard;
  ShowHideBottomBtns(False, True, True, False);
end;

PROCEDURE TForm1.bt_RR_RoomsClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  IF NOT RR_Rooms.Showing THEN
  BEGIN
    If xx_ReadCard(xx_FromCardReader) = 0 then
    begin
      xx_GetClientData(uClientStore.ThisCard.ClientID);
      xx_GetBookingData(uClientStore.ThisCard.ClientID);
      xx_GetRentalData(uClientStore.ThisCard.ClientID);
    end
    else
    begin
      nnWriteCashierDisplay(0, False, clYellow, 'Tessera non valida', 2);
      Exit;
    end;
    // Get clientData
    // -----------------------------------------------------------------------
    // xx_GetClientData(uClientStore.ThisCard.ClientID); // ok
    uClientStore.ThisBooking := GetRentalDepositAmt(uClientStore.ThisClient.ID);
    xx_CheckIfStillPresent;
    tht_RRBlink.Enabled := False;
    bt_RR_Rooms.ShineColor := clWhite;
    ShowHideBottomBtns(False, True, False, False);
    ShowRR_Rooms;
  END;
END;

Procedure TForm1.ShowHideBottomBtns(A, B, c, D: Boolean);
begin
  bt_RR_Rooms.Visible := A;
  bt_Calculator.Visible := B;
  // bt_Receipt.Visible := c;
  bt_MultiReg.Visible := D;
end;

Procedure TForm1.ResetAncientFees;
var
  StartDtTime: TDateTime;
begin
  If IsBetweenMidnightAndNoon(Now) Then
    StartDtTime := RecodeTime(IncDay(Now, -1), 12, 0, 0, 0)
  else
    StartDtTime := RecodeTime(Now, 12, 0, 0, 0);

  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('UPDATE ServicesSold SET Valid = False ' + 'Where SoldDT < CAST(' +
      QuotedStr(Form2.EDBEngine1.DateToSQLStr(DateOf(IncDay(StartDtTime, -1))))
      + ' AS TimeStamp)');
    ExecSQL;
  end;
end;

PROCEDURE TForm1.bt_LoginClick(Sender: TObject);
VAR
  s: STRING;
  I: Integer;
BEGIN
  startUp := False;
  GetDailyCount;
  I := 0;
  // Cashier logging out
  // ---------------------
  IF cashier <> '' THEN
  BEGIN
    bt_Login.Caption := 'LOG IN';
    cb_Testdata_.Checked := False;
    xx_CancelAll(True);
    nnWriteCashierDisplay(0, True, clWhite, TimeToStr(Time) + ': ' + cashier +
      ' log out.', 1);
    RzStatusPane6.Caption := '';
    ed_LogInPwd.Text := '';
    cashier := '';
    cb_Testdata_.Visible := cashier = 'Test';
    ed_LogInPwd.Visible := True;

    pl_KeyboardError.Visible := False;
    Form2.PlayASound('magic-chime-01.wav', False);
    AnimateWindow(pl_KeyBoardCover.Handle, 400, AW_VER_NEGATIVE OR AW_SLIDE OR
      AW_ACTIVATE);

    IF (DayOfWeek(Date) = 1) AND
      ((TimeOf(Now) > IncMinute(TimeOf(ed_CT_Sat.DateTime), -16)) AND
      (TimeOf(Now) < IncMinute(TimeOf(ed_CT_Sat.DateTime), 120))) THEN
    // Saturday, 20 min before closing time
    BEGIN
      ShowMessage('Hai controllato i Token?');
      tm_List.Events[0].Cycled := True;
    END;
    tm_ExpiredFeesReset.Enabled := False;
    IF NumKeyboard.Showing THEN
      NumKeyboard.Hide;
    Exit;
  END;

  // Cashier logging in
  // ------------------
  var
  pwd := EnCrypt(ed_LogInPwd.Text);
  if pwd = '' then
    pwd := ClubAccPermissions.LogInFallBackPwd;
  IF Form2.tb_Personale_Personnel.Locate('Password;Enabled',
    varArrayof([pwd, True]), []) THEN
  BEGIN
    screen.Cursor := crHourGlass;
    bt_Login.GlowColor := $00FFBD8D;
    var
    jobPosition := Form2.tb_Personale_Personnel.FieldByName
      ('JobPosition').AsString;
    cashier := Trim(Form2.tb_Personale_Personnel.FieldByName('FName').AsString);

    // Handle time limited access for admin job position
    // -------------------------------------------------------------------------
    WITH Form2.qy_TMP DO
    BEGIN
      IF jobPosition = 'Admin' Then
      begin
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('SELECT Password FROM Personnel');
        SQL.Add(' WHERE FName = ' + QuotedStr(cashier));
        SQL.Add(' AND JobPosition = ' + QuotedStr('Manager'));
        Active := True;
        IF RecordCount > 0 Then
        begin
          ClubAccPermissions.LogInFallBackPwd :=
            DeCrypt(FieldByName('Password').AsString);
          if ed_LoginTimeOut.Value > 0 then
          begin
            bt_Login.GlowColor := clRed;
            thtm_Login.Interval := ed_LoginTimeOut.Value * 60000;
            thtm_Login.Enabled := True;
            thtm_Login.ExecuteAction(nil);
          end;
        end
        else
          ClubAccPermissions.LogInFallBackPwd := '';
      end;
      // ---------------------------------------------------------------------------

      SQL.Clear;
      SQL.Add('SELECT * FROM Club_Permissions WHERE JobRole = ' +
        QuotedStr(jobPosition));
      Active := True;
      IF RecordCount > 0 THEN
        WITH ClubAccPermissions DO
        BEGIN
          LogIn := FieldValues['Log In'];
          LogInTimeOut := ed_LoginTimeOut.Value;
          CanOffer := FieldValues['CanOffer'];
          FeesP := FieldValues['FeesP'];
          FeesEdit := FieldValues['FeesEdit'];
          Settings := FieldValues['Setting'];
          AdminP := FieldValues['AdminPage'];
          ManutP := FieldValues['ManutenzionePage'];
          PersonnelP := FieldValues['PersonnelPage'];
          ClientsP := FieldValues['ClientsPage'];
          ClientsDataP := FieldValues['ClientsDataPage'];
          ClientsPresP := FieldValues['ClientsPresencePage'];
          ClientsTaxP := FieldValues['TaxesPage'];
          ClientsResidP := FieldValues['ResidentialPage'];
          ClientsPermitsP := FieldValues['PermitsPage'];
          CardsP := FieldValues['CardsPage'];
          RoomsP := FieldValues['RoomsPage'];
          RS485P := FieldValues['RS485 Page'];
          // pl_TestDataButtons.Visible := FieldValues['RS485 Page'];
          CassaSettings := FieldValues['CassaSettings'];
          RoomSettings := FieldValues['RoomSettings'];
          InterfaceSettings := FieldValues['InterfaceSettings'];
          ComPortSettings := FieldValues['ComPortSettings'];
          MailSettings := FieldValues['MailSettings'];
          PrintSettings := FieldValues['PrintSettings'];
          ClosingP := FieldValues['ClosingP'];
          LimitClosingCalDays := FieldValues['LimitClosingCalDays'];
          BarP := FieldValues['BarP'];

          IF LogIn = False THEN
            Exit;
        END;
      Active := False;
      keepMGuardActive := True;

      // Set fees which are older than today's fees to Valid = False in ServicesSold table
      ResetAncientFees;

      s := 'DELETE FROM OpenTab';
      Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'OpenTab');
      Form2.tb_oTab.Refresh;
      AnimateWindow(pl_KeyBoardCover.Handle, 400, AW_VER_POSITIVE OR
        AW_SLIDE OR AW_HIDE);
    END;

    // Show open RT bar tabs
    // -------------------------------------------------------------------------

    WITH Form2.qy_TabsOpen DO
    BEGIN
      s := 'SELECT Data, PayMethod, Waiter, sum(COALESCE(Avere,0)) - sum(COALESCE(Dare,0))  as Balance, '
        + 'SUBSTRING(TxID,8)AS tID, TxID,Print, Bar_TabRemarks.Remarks ' +
        'FROM Bar_OpLedger ' +
        'Left Join Bar_TabRemarks ON TxID = Bar_TabRemarks.TxID ' +
        'WHERE Data BETWEEN CAST(' +
        QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', IncDay(sDt, -7))) +
        ' AS Timestamp) ' + 'AND CAST(' +
        QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
        ' AS Timestamp) AND PayMethod = ''RT'' ' + 'GROUP BY TxID ' +
        'HAVING Balance > 0';
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add(s);
      Active := True;
      dbgd_TabsOpen.Refresh;
    END;


    // Show last registered bar sales
    // -------------------------------------------------------------------------

    ShowDetailOpenBarTab;

    pl_KeyboardError.Visible := False;

    RzStatusPane6.Caption := cashier;
    cb_Testdata_.Visible := cashier = 'Test';
    nnWriteCashierDisplay(0, False, clWhite, TimeToStr(Time) + ': ' + cashier +
      ' log in ok.', 0);
    ed_LogInPwd.Visible := False;
    ed_LogInPwd.Text := '';
    nSetFeeWeekDayFilter;
    IF I <> 0 THEN
      ShowMessage('ATTENZIONE, Errore stampante no: ' + intToStr(I));
    I := 0;

    // Get unclosed periods
    // -------------------------------------------------------------------------
    GetUnclosedPeriods;

    FOR I := LOW(openPeriod_Arr) TO HIGH(openPeriod_Arr) DO
      nnWriteCashierDisplay(0, False, clYellow, 'Registrazioni non chiuse del: '
        + DateToStr(openPeriod_Arr[I]), 1);

    UpdateClosingTabStatus;

    // Remind of checking rooms at opening
    // -------------------------------------------------------------------------
    IF InRange(HourOf(Now), 13, 14) THEN
      ShowMessage('Hai fatto il controllo delle stanze?');
    // Write log

    (*
      IF (rg_LogToMailFile.CheckBox.Checked) AND (cbg_SendMailCriteria.Checked[0]) THEN
      BEGIN
      IF rg_LogToMailFile.RadioButtons[0].Checked THEN
      SendThisMail(ed_aHost.Text, ed_aUser.Text, ed_aPwd.Text,
      ed_FromAddr.Text, ed_ToAddr.Text, ed_CcAddr.Text, ' Log-in' +
      floatToStr(RoundTo(ed_DeltaTot.Value, -2)),
      cashier + ':' + DateTimeToStr(Now), '', intToStr(ed_PortNo.Value));
      IF rg_LogToMailFile.RadioButtons[1].Checked THEN
      WriteTextFile(DateTimeToStr(Now) + ': Log in: ' + cashier);
      END;
    *)

    FillPrinters;
    IF rg_Printers.ItemIndex = -1 THEN
      ShowMessage
        ('Attenzione, scegli prima la stampante nelle IMPOSTAZIONI>>STAMPA>>STAMPANTI!');
    screen.Cursor := crDefault;
    xx_CheckIfStillPresent;

    nStartMguard(Sender);

    bt_Login.Caption := cashier;
    thtm_BarRT.Enabled := True;
    // ***********************************************************************
    // Code only for testing, remove when not testing !!!
    // ************************************************************************
    // pl_TestDataButtons.Visible := True;
    // ed_cCard.Visible := True;
    // ************************************************************************

    // ---------------------------------------------------------------------------
    // StartFetchingRates  DO NOT CALL HERE  StartFetchingRates, AV VIOLATION;
    // ---------------------------------------------------------------------------
  END
  ELSE
  BEGIN
    bt_Login.Down := False;

    nnWriteCashierDisplay(0, True, clYellow, 'Errore log in', 1);
    cashier := '';
    bt_Login.Caption := '';
    ed_LogInPwd.Text := '';
    ed_LogInPwd.Visible := True;
    bt_Login.Caption := '';
    Form2.PlayASound('error.wav', False);
    pl_KeyboardError.Visible := False;
    bt_Login.Caption := 'LOG IN';
    AnimateWindow(pl_KeyBoardCover.Handle, 400, AW_VER_NEGATIVE OR AW_SLIDE OR
      AW_ACTIVATE);
  END;

  // WITH Form2.tb_Services DO
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Add('SELECT * FROM Services');
    Active := True;
    SetLength(c_ServiceOwnedByCardID_Arr, RecordCount + 1);
    First;
    WHILE NOT EOF DO
    BEGIN
      c_ServiceOwnedByCardID_Arr[FieldByName('ID').AsInteger] :=
        FieldByName('CardInID').AsInteger;
      Next;
    END;
    Active := False;
  END;
  BtnFetchRatesClick(Sender);
END;

procedure TForm1.bt_LotteryClick(Sender: TObject);
begin
  with TfrmCheckRaffleWin.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TForm1.PopulateStackPanelWithPlaceholders(const Ref: string;
  const PlaceholderDict: TDictionary<string, string>);

var
  Parts: TArray<string>;
  Token: string;
  idx, I, TotalHeight: Integer;
  BlobStream: TMemoryStream;
  Img, QR: TImage;
  r: TJvRichEdit;
  HiddenRE: TJvRichEdit;
  bmp: TBitmap;
  LineHt, TotalLines: Integer;
  scale: Double;
  RawRTF, PlainText, ReplacementText: string;
  RtfStream: TStringStream;
  RegexPattern: string;
  Matches: TMatchCollection;
  Match: TMatch;
  SeenNames: TDictionary<string, Boolean>;
  NameOnly, PlaceholderToken: string;
  Panel, QRPanel: TPanel;
  BGImg: TImage;
begin
  // 1) Clear existing contents
  while StackPanel1.ControlCount > 0 do
    StackPanel1.Controls[0].Free;

  with StackPanel1 do
  begin
    // Align := alNone; // must not be alClient or alTop etc.
    Orientation := spoVertical; // stack vertically
    // Padding.SetBounds(0, 0, 0, 0); // or whatever padding you like
    Spacing := 1; // default spacing between items
    // AutoSize    := True;                // this is the magic bit
  end;

  // 2) Split Ref into individual tokens
  Parts := Ref.Split([',']);

  for Token in Parts do
  begin
    if Token.IsEmpty then
      Continue;

    // --- IQ<n>: image with centered QR overlay ---
    if Token.StartsWith('IQ') and TryStrToInt(Copy(Token, 3, MaxInt), idx) then
    begin
      if not Form2.tb_PosImages.Active then
        Form2.tb_PosImages.Open;
      if Form2.tb_PosImages.Locate('id', idx, []) then
      begin
        BlobStream := TMemoryStream.Create;
        try
          (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField)
            .SaveToStream(BlobStream);
          BlobStream.Position := 0;

          Panel := TPanel.Create(Self);
          Panel.Parent := StackPanel1;
          Panel.Align := alTop;
          Panel.BevelOuter := bvNone;
          Panel.Caption := '';
          BGImg := TImage.Create(Panel);
          BGImg.Parent := Panel;
          BGImg.Align := alClient;
          BGImg.Stretch := True;
          BGImg.Proportional := True;
          BGImg.Picture.LoadFromStream(BlobStream);

          scale := StackPanel1.ClientWidth / BGImg.Picture.Width;
          Panel.Height := Round(BGImg.Picture.Height * scale);

          QR := TImage.Create(Panel);
          QR.Parent := Panel;
          QR.Transparent := True;
          QR.AutoSize := True;
          QR.Picture.Assign(Barcode1.Bitmap);
          QR.Left := (Panel.ClientWidth - QR.Width) div 2;
          QR.Top := (Panel.Height - QR.Height) div 2;
          QR.BringToFront;
        finally
          BlobStream.Free;
        end;
      end;
    end

    // --- I<n>: plain image (only if NOT 'IQ') ---
    else if (Length(Token) >= 2) and (UpCase(Token[1]) = 'I') and
      not Token.StartsWith('IQ') and TryStrToInt(Copy(Token, 2, MaxInt), idx)
    then
    begin
      if not Form2.tb_PosImages.Active then
        Form2.tb_PosImages.Open;
      if Form2.tb_PosImages.Locate('id', idx, []) then
      begin
        BlobStream := TMemoryStream.Create;
        try
          (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField)
            .SaveToStream(BlobStream);
          BlobStream.Position := 0;

          Img := TImage.Create(Self);
          Img.Parent := StackPanel1;
          Img.Align := alTop;
          Img.Proportional := True;
          Img.Picture.LoadFromStream(BlobStream);

          scale := StackPanel1.ClientWidth / Img.Picture.Width;
          Img.Height := Round(Img.Picture.Height * scale);
        finally
          BlobStream.Free;
        end;
      end;
    end

    // --- T<n>: RTF text with placeholder replacement ---
    else if (Length(Token) >= 2) and (UpCase(Token[1]) = 'T') and
      TryStrToInt(Copy(Token, 2, MaxInt), idx) then
    begin

      if not Form2.tb_PosText.Active then
        Form2.tb_PosText.Open;
      if Form2.tb_PosText.Locate('id', idx, []) then
      begin
        // 2.1) Read raw RTF from the data‐bound RTF component on Form2
        RawRTF := db_RTEditor.ContentAsRTF;
        // 2.2) Create a hidden TRichEdit so we can extract PlainText
        HiddenRE := TJvRichEdit.Create(nil);

        try
          // Give it an off‐screen Parent so it has a valid window handle:
          HiddenRE.Parent := Application.MainForm;
          HiddenRE.Visible := False;
          HiddenRE.PlainText := False;
          HiddenRE.WordWrap := True;
          HiddenRE.ScrollBars := TScrollStyle(0);
          HiddenRE.Width := StackPanel1.ClientWidth;

          {
            RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
            try
            RtfStream.Position := 0;
            HiddenRE.Lines.LoadFromStream(RtfStream);
            finally
            RtfStream.Free;
            end;
          }

          RtfStream := TStringStream.Create(RawRTF, TEncoding.Default);
          // ← was UTF8
          try
            HiddenRE.Lines.LoadFromStream(RtfStream);
          finally
            RtfStream.Free;
          end;

          PlainText := HiddenRE.Text; // capture all user‐visible text
        finally
          HiddenRE.Free;
        end;

        // 2.3) Find all “{Name}” tokens in that plain text
        RegexPattern := '\{([^}]+)\}';
        Matches := TRegEx.Matches(PlainText, RegexPattern);

        SeenNames := TDictionary<string, Boolean>.Create;
        try
          // 2.4) For each unique NameOnly, look up its replacement in PlaceholderDict
          for Match in Matches do
          begin
            NameOnly := Match.Groups[1].Value.Trim; // e.g. 'Company'
            if NameOnly.IsEmpty then
              Continue;
            if SeenNames.ContainsKey(NameOnly) then
              Continue;
            SeenNames.Add(NameOnly, True);

            if PlaceholderDict.TryGetValue(NameOnly, ReplacementText) then
            begin
              // Build the RTF‐safe token: \{NameOnly\}
              PlaceholderToken := '\{' + NameOnly + '\}';
              // Replace _all_ occurrences (case‐insensitive) in the raw RTF string
              RawRTF := StringReplace(RawRTF, PlaceholderToken, ReplacementText,
                [rfReplaceAll, rfIgnoreCase]);
            end;
          end;
        finally
          SeenNames.Free;
        end;

        // 2.5) Now create a VISIBLE TRichEdit in the StackPanel1 and load the modified RTF
        r := TJvRichEdit.Create(Self);
        r.Parent := StackPanel1;
        r.Margins.SetBounds(0, 0, 0, 0);
        r.Align := alTop;
        r.WordWrap := True;
        r.ScrollBars := TScrollStyle(0);
        r.PlainText := False;
        r.BorderStyle := bsNone;
        // R.Ctl3D := False;

        RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
        try
          RtfStream.Position := 0;
          r.Lines.LoadFromStream(RtfStream);
          r.SelectAll;
          // R.Paragraph.Alignment := taLeftJustify;
        finally
          RtfStream.Free;
        end;

        // 2.6) Recompute height so that the RichEdit fits its contents exactly
        bmp := TBitmap.Create;
        try
          bmp.Canvas.Font.Assign(r.Font);
          LineHt := bmp.Canvas.TextHeight('Wg') + 2;
        finally
          bmp.Free;
        end;

        TotalLines := r.Lines.Count;
        r.Height := TotalLines * LineHt + 20;
      end;
    end

    // --- Q: standalone QR code (no background) ---
    else if (UpCase(Token[1]) = 'Q') then
    begin
      QRPanel := TPanel.Create(Self);
      QRPanel.Parent := StackPanel1;
      QRPanel.BorderStyle := bsNone;
      QRPanel.BevelInner := bvNone;
      QRPanel.BevelOuter := bvNone;
      QRPanel.Height := img_QRcode.Picture.Height;
      QRPanel.Align := alTop;

      QR := TImage.Create(QRPanel);
      QR.Parent := QRPanel;
      QR.Picture.Assign(Barcode1.Bitmap);
      QR.Proportional := True;
      QR.AutoSize := False;
      QR.Left := (QRPanel.ClientWidth - QR.Width) div 2;
    end;
  end;

  // 3) Finally, resize the StackPanel1 height so it fits everything

  TotalHeight := 0;

  for I := 0 to StackPanel1.ControlCount - 1 do
  begin
    Inc(TotalHeight, StackPanel1.Controls[I].Height);
  end;
  StackPanel1.Height := TotalHeight + 5;

end;

// ****************************************************************************
procedure TForm1.PopulateStackPanelWithPlaceholders_2(const Ref: string;
  const PlaceholderDict: TDictionary<string, string>);

// --- Local Helper Procedures ---

  procedure ClearStackPanel;
  begin
    while StackPanel1.ControlCount > 0 do
      StackPanel1.Controls[0].Free;
    StackPanel1.Orientation := spoVertical;
    StackPanel1.Spacing := 1;
  end;

  function LoadImageFromDB(Table: TDataSet; const FieldName: string): TPicture;
  var
    Stream: TMemoryStream;
    pic: TPicture;
  begin
    Stream := TMemoryStream.Create;
    pic := TPicture.Create;
    try
      (Table.FieldByName(FieldName) as TBlobField).SaveToStream(Stream);
      Stream.Position := 0;
      pic.LoadFromStream(Stream);
      Result := pic;
    finally
      Stream.Free;
    end;
  end;

  procedure AddImagePanel(const pic: TPicture; WithQR: Boolean);
  var
    Panel: TPanel;
    BGImg, QR: TImage;
    scale: Double;
  begin
    Panel := TPanel.Create(Self);
    Panel.Parent := StackPanel1;
    Panel.Align := alTop;
    Panel.BevelOuter := bvNone;
    Panel.Caption := '';

    BGImg := TImage.Create(Panel);
    BGImg.Parent := Panel;
    BGImg.Align := alClient;
    BGImg.Stretch := True;
    BGImg.Proportional := True;
    BGImg.Picture.Assign(pic);

    scale := StackPanel1.ClientWidth / BGImg.Picture.Width;
    Panel.Height := Round(BGImg.Picture.Height * scale);

    if WithQR then
    begin
      QR := TImage.Create(Panel);
      QR.Parent := Panel;
      QR.Transparent := True;
      QR.AutoSize := True;
      QR.Picture.Assign(Barcode1.Bitmap);
      QR.Left := (Panel.ClientWidth - QR.Width) div 2;
      QR.Top := (Panel.Height - QR.Height) div 2;
      QR.BringToFront;
    end;
  end;

  procedure AddPlainImage(const pic: TPicture);
  var
    Img: TImage;
    scale: Double;
  begin
    Img := TImage.Create(Self);
    Img.Parent := StackPanel1;
    Img.Align := alTop;
    Img.Proportional := True;
    Img.Picture.Assign(pic);

    scale := StackPanel1.ClientWidth / Img.Picture.Width;
    Img.Height := Round(Img.Picture.Height * scale);
  end;

(*
  procedure AddRichEditWithPlaceholders(const RawRTF: string);
  var
  HiddenRE: TJvRichEdit;
  PlainText, ReplacementText, NameOnly, PlaceholderToken: string;
  RegexPattern: string;
  Matches: TMatchCollection;
  Match: TMatch;
  SeenNames: TDictionary<string, Boolean>;
  r: TJvRichEdit;
  RtfStream: TStringStream;
  bmp: TBitmap;
  LineHt, TotalLines: Integer;
  ModifiedRTF: string;
  begin
  // Load RTF and extract plain text for placeholder scanning
  HiddenRE := TJvRichEdit.Create(nil);
  try
  HiddenRE.Parent := Application.MainForm;
  HiddenRE.Visible := False;
  HiddenRE.PlainText := False;
  HiddenRE.WordWrap := True;
  HiddenRE.Width := StackPanel1.ClientWidth;

  RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
  try
  HiddenRE.Lines.LoadFromStream(RtfStream);
  finally
  RtfStream.Free;
  end;

  PlainText := HiddenRE.Text;
  finally
  HiddenRE.Free;
  end;

  // Replace all placeholders in RTF
  ModifiedRTF := RawRTF;
  RegexPattern := '\{([^}]+)\}';
  Matches := TRegEx.Matches(PlainText, RegexPattern);
  SeenNames := TDictionary<string, Boolean>.Create;
  try
  for Match in Matches do
  begin
  NameOnly := Match.Groups[1].Value.Trim;
  if NameOnly.IsEmpty or SeenNames.ContainsKey(NameOnly) then
  Continue;
  SeenNames.Add(NameOnly, True);

  if PlaceholderDict.TryGetValue(NameOnly, ReplacementText) then
  begin
  // If your RTF contains {amounttoprint} literally, do NOT escape braces
  PlaceholderToken := '{' + NameOnly + '}';

  if SameText(NameOnly, 'amounttoprint') then
  ReplacementText := Trim(
  StringReplace(
  StringReplace(ReplacementText, 'CHF', '', [rfReplaceAll, rfIgnoreCase]),
  'EUR', '', [rfReplaceAll, rfIgnoreCase]
  )
  );

  ModifiedRTF := StringReplace(ModifiedRTF, PlaceholderToken, ReplacementText,
  [rfReplaceAll, rfIgnoreCase]);
  end;
  end;
  finally
  SeenNames.Free;
  end;

  // Add the visible RichEdit to StackPanel1
  r := TJvRichEdit.Create(Self);
  r.Parent := StackPanel1;
  r.Align := alTop;
  r.WordWrap := True;
  r.ScrollBars := TScrollStyle(0);
  r.PlainText := False;
  r.BorderStyle := bsNone;

  RtfStream := TStringStream.Create(ModifiedRTF, TEncoding.UTF8);
  try
  r.Lines.LoadFromStream(RtfStream);
  r.SelectAll;
  finally
  RtfStream.Free;
  end;

  // Adjust height
  bmp := TBitmap.Create;
  try
  bmp.Canvas.Font.Assign(r.Font);
  LineHt := bmp.Canvas.TextHeight('Wg') + 2;
  finally
  bmp.Free;
  end;
  TotalLines := r.Lines.Count;
  r.Height := TotalLines * LineHt + 20;
  end;
*)

  procedure AddRichEditWithPlaceholders(const RawRTF: string);

    function EscapeRTF(const s: string): string;
    begin
      Result := s;
      Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
      Result := StringReplace(Result, '{', '\{', [rfReplaceAll]);
      Result := StringReplace(Result, '}', '\}', [rfReplaceAll]);
      Result := StringReplace(Result, #39, '\''27', [rfReplaceAll]);
      // ← #39 → \'27
      Result := StringReplace(Result, sLineBreak, '\par ', [rfReplaceAll]);
    end;

  var
    HiddenRE: TJvRichEdit;
    PlainText, ReplacementText, NameOnly: string;
    RegexPattern: string;
    Matches: TMatchCollection;
    Match: TMatch;
    SeenNames: TDictionary<string, Boolean>;
    r: TJvRichEdit;
    RtfStream: TStringStream;
    bmp: TBitmap;
    LineHt, TotalLines: Integer;
    ModifiedRTF: string;
    TokenEscaped, TokenRaw, PlaceholderToken: string;
  begin
    // Load RTF and extract plain text for placeholder scanning
    HiddenRE := TJvRichEdit.Create(nil);
    try
      HiddenRE.Parent := Application.MainForm;
      HiddenRE.Visible := False;
      HiddenRE.PlainText := False;
      HiddenRE.WordWrap := True;
      HiddenRE.Width := StackPanel1.ClientWidth;

      RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
      try
        HiddenRE.Lines.LoadFromStream(RtfStream);
      finally
        RtfStream.Free;
      end;

      PlainText := HiddenRE.Text; // this will show placeholders like {name}
    finally
      HiddenRE.Free;
    end;

    // Replace all placeholders in RTF
    ModifiedRTF := RawRTF;

    RegexPattern := '\{([^}]+)\}';
    Matches := TRegEx.Matches(PlainText, RegexPattern);

    SeenNames := TDictionary<string, Boolean>.Create;
    try
      for Match in Matches do
      begin
        NameOnly := Match.Groups[1].Value.Trim;
        if NameOnly.IsEmpty or SeenNames.ContainsKey(NameOnly) then
          Continue;
        SeenNames.Add(NameOnly, True);

        if not PlaceholderDict.TryGetValue(NameOnly, ReplacementText) then
          Continue;

        // Special cleanup for amounttoprint
        if SameText(NameOnly, 'amounttoprint') then
          ReplacementText :=
            Trim(StringReplace(StringReplace(ReplacementText, 'CHF', '',
            [rfReplaceAll, rfIgnoreCase]), 'EUR', '',
            [rfReplaceAll, rfIgnoreCase]));

        // Escape replacement so it stays valid RTF
        ReplacementText := EscapeRTF(ReplacementText);

        // Detect which placeholder form exists in the *RTF source*
        TokenEscaped := '\{' + NameOnly + '\}'; // literal braces in RTF
        TokenRaw := '{' + NameOnly + '}'; // RTF group (rare for this use)

        if Pos(TokenEscaped, ModifiedRTF) > 0 then
          PlaceholderToken := TokenEscaped
        else
          PlaceholderToken := TokenRaw;

        // IMPORTANT: don't use rfIgnoreCase unless you truly need it
        ModifiedRTF := StringReplace(ModifiedRTF, PlaceholderToken,
          ReplacementText, [rfReplaceAll]);
      end;
    finally
      SeenNames.Free;
    end;

    // Add the visible RichEdit to StackPanel1
    r := TJvRichEdit.Create(Self);
    r.Parent := StackPanel1;
    r.Align := alTop;
    r.WordWrap := True;
    r.ScrollBars := TScrollStyle(0);
    r.PlainText := False;
    r.BorderStyle := bsNone;

    {
      RtfStream := TStringStream.Create(ModifiedRTF, TEncoding.UTF8);
      try
      r.Lines.LoadFromStream(RtfStream);
      r.SelectAll;
      finally
      RtfStream.Free;
      end;
    }

    RtfStream := TStringStream.Create(ModifiedRTF, TEncoding.Default);
    // ← was UTF8
    try
      r.Lines.LoadFromStream(RtfStream);
      r.SelectAll;
    finally
      RtfStream.Free;
    end;

    // Adjust height
    bmp := TBitmap.Create;
    try
      bmp.Canvas.Font.Assign(r.Font);
      LineHt := bmp.Canvas.TextHeight('Wg') + 2;
    finally
      bmp.Free;
    end;

    TotalLines := r.Lines.Count;
    r.Height := TotalLines * LineHt + 20;
  end;

  procedure AddStandaloneQR;
  var
    QRPanel: TPanel;
    QR: TImage;
  begin
    QRPanel := TPanel.Create(Self);
    QRPanel.Parent := StackPanel1;
    QRPanel.BorderStyle := bsNone;
    QRPanel.BevelInner := bvNone;
    QRPanel.BevelOuter := bvNone;
    QRPanel.Align := alTop;
    QRPanel.Height := img_QRcode.Picture.Height;

    QR := TImage.Create(QRPanel);
    QR.Parent := QRPanel;
    QR.Picture.Assign(Barcode1.Bitmap);
    QR.Proportional := True;
    QR.AutoSize := False;

    // Set size based on image
    QR.Width := QR.Picture.Width;
    QR.Height := QR.Picture.Height;

    // Center horizontally
    QR.Left := (QRPanel.ClientWidth - QR.Width) div 2;
    QR.Top := 0;

    // Optional: center with alignment
    QR.Anchors := [akTop];
  end;

var
  Parts: TArray<string>;
  Token, CleanToken: string; // Add CleanToken
  idx: Integer;
  pic: TPicture;
  RawRTF: string;
  I, TotalHeight: Integer;
begin
  // 1) Clear panel
  ClearStackPanel;

  Parts := Ref.Split([',']);

  for Token in Parts do
  begin
    CleanToken := Token.Trim; // Use a separate variable
    if CleanToken = '' then
      Continue;

    // IQ<n>: image with centered QR
    if CleanToken.StartsWith('IQ') and
      TryStrToInt(Copy(CleanToken, 3, MaxInt), idx) then
    begin
      if not Form2.tb_PosImages.Active then
        Form2.tb_PosImages.Open;
      if Form2.tb_PosImages.Locate('id', idx, []) then
      begin
        pic := LoadImageFromDB(Form2.tb_PosImages, 'PosImage');
        try
          AddImagePanel(pic, True);
        finally
          pic.Free;
        end;
      end;
    end

    // I<n>: plain image
    else if (Length(CleanToken) >= 2) and (UpCase(CleanToken[1]) = 'I') and
      not CleanToken.StartsWith('IQ') and
      TryStrToInt(Copy(CleanToken, 2, MaxInt), idx) then
    begin
      if not Form2.tb_PosImages.Active then
        Form2.tb_PosImages.Open;
      if Form2.tb_PosImages.Locate('id', idx, []) then
      begin
        pic := LoadImageFromDB(Form2.tb_PosImages, 'PosImage');
        try
          AddPlainImage(pic);
        finally
          pic.Free;
        end;
      end;
    end

    // T<n>: RTF text with placeholder replacement
    else if (Length(CleanToken) >= 2) and (UpCase(CleanToken[1]) = 'T') and
      TryStrToInt(Copy(CleanToken, 2, MaxInt), idx) then
    begin
      if not Form2.tb_PosText.Active then
        Form2.tb_PosText.Open;
      if Form2.tb_PosText.Locate('id', idx, []) then
      begin
        RawRTF := db_RTEditor.ContentAsRTF;
        AddRichEditWithPlaceholders(RawRTF);
      end;
    end

    // Q: Standalone QR
    else if (UpCase(CleanToken[1]) = 'Q') then
    begin
      AddStandaloneQR;
    end;
  end;

  // Resize the StackPanel height to fit all content
  TotalHeight := 0;
  for I := 0 to StackPanel1.ControlCount - 1 do
    Inc(TotalHeight, StackPanel1.Controls[I].Height);
  StackPanel1.Height := TotalHeight + 5;
end;
// *****************************************************************************

function TForm1.UnicodeToRtf(const s: string): string;
var
  I, Code: Integer;
  c: Char;
begin
  Result := '';
  for I := 1 to Length(s) do
  begin
    c := s[I];
    if Ord(c) < 128 then
      Result := Result + c
    else
    begin
      Code := Ord(c);
      // RTF uses “\uN?” where “?” is a fallback ANSI character.
      Result := Result + Format('\u%d?', [Code]);
    end;
  end;
end;

// ------------------------------------------------------------------------------
// PrintTokensToPrinter
//
// - PrinterName: exactly matches one entry in Printer.Printers (e.g. 'Epson TM-T88V')
// - Ref: e.g. 'I1,T2,IQ3,Q,I4,T5,…'
// - PlaceholderDict: map from placeholder name → replacement text
// - Copies: how many identical receipts to send
// ------------------------------------------------------------------------------
procedure TForm1.PrintTokensToPrinter(const PrinterName: string;
  const Ref: string; const PlaceholderDict: TDictionary<string, string>;
  const Copies: Integer);
var
  Parts: TArray<string>;
  Token: string;
  idx: Integer;
  copyIndex: Integer;
  PrinterIdx: Integer;
  CurrentY, PageWidth: Integer;
  I, LineIndex, TextHeight, LineWidth, TotalHeight, TextX: Integer;
  BlobStream: TMemoryStream;
  Img, QR: TImage;
  r: TRichEdit;
  bmp: TBitmap;
  LineHt, TotalLines: Integer;
  scale: Double;
  RawRTF, PlainText, ReplacementRTF: string;
  RtfStream: TStringStream;
  HiddenRE: TRichEdit;
  RegexPattern: string;
  Matches: TMatchCollection;
  Match: TMatch;
  NameOnly, PlaceholderToken, ParamValue: string;
  QRPanel: TPanel;
  Panel: TPanel;
  BGImg: TImage;
  WideLine: WideString;
  CurrentFont: TFont;
  BlankLines: Integer;
  LineText: string;
begin
  // 0) Look up the printer name
  PrinterIdx := Printer.Printers.IndexOf(PrinterName);
  if PrinterIdx < 0 then
  begin
    ShowMessage(Format('Printer "%s" not found.', [PrinterName]));
    Exit;
  end;
  Printer.PrinterIndex := PrinterIdx;

  // 1) Loop for each requested copy
  for copyIndex := 1 to Copies do
  begin
    Parts := Ref.Split([',']);

    Printer.Orientation := poPortrait;
    Printer.BeginDoc;
    try
      CurrentY := 50;
      PageWidth := Printer.PageWidth;

      for Token in Parts do
      begin
        if Token.IsEmpty then
          Continue;

        // --- “IQ<n>”: background image + centered QR overlay ---
        if Token.StartsWith('IQ') and TryStrToInt(Copy(Token, 3, MaxInt), idx)
        then
        begin
          if not Form2.tb_PosImages.Active then
            Form2.tb_PosImages.Open;
          if Form2.tb_PosImages.Locate('id', idx, []) then
          begin
            BlobStream := TMemoryStream.Create;
            try
              (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField)
                .SaveToStream(BlobStream);
              BlobStream.Position := 0;

              bmp := TBitmap.Create;
              try
                bmp.LoadFromStream(BlobStream);

                scale := PageWidth / bmp.Width;
                if CurrentY + Round(bmp.Height * scale) > Printer.PageHeight
                then
                begin
                  Printer.NewPage;
                  CurrentY := 50;
                end;

                Printer.Canvas.StretchDraw(Rect(0, CurrentY, PageWidth,
                  CurrentY + Round(bmp.Height * scale)), bmp);

                // Overlay QR from Form2.img_QRCode
                QR := TImage.Create(nil);
                try
                  QR.Picture.Assign(img_QRcode.Picture);
                  Printer.Canvas.Draw((PageWidth - QR.Width) div 2,
                    CurrentY + (Round(bmp.Height * scale) - QR.Height) div 2,
                    QR.Picture.Bitmap);
                finally
                  QR.Free;
                end;

                Inc(CurrentY, Round(bmp.Height * scale) + 20);
              finally
                bmp.Free;
              end;
            finally
              BlobStream.Free;
            end;
          end;
        end

        // --- “I<n>”: plain image ---
        else if (Length(Token) >= 2) and (UpCase(Token[1]) = 'I') and
          not Token.StartsWith('IQ') and TryStrToInt(Copy(Token, 2, MaxInt), idx)
        then
        begin
          if not Form2.tb_PosImages.Active then
            Form2.tb_PosImages.Open;
          if Form2.tb_PosImages.Locate('id', idx, []) then
          begin
            BlobStream := TMemoryStream.Create;
            try
              (Form2.tb_PosImages.FieldByName('PosImage') as TBlobField)
                .SaveToStream(BlobStream);
              BlobStream.Position := 0;

              bmp := TBitmap.Create;
              try
                bmp.LoadFromStream(BlobStream);

                scale := PageWidth / bmp.Width;
                if CurrentY + Round(bmp.Height * scale) > Printer.PageHeight
                then
                begin
                  Printer.NewPage;
                  CurrentY := 50;
                end;

                Printer.Canvas.StretchDraw(Rect(0, CurrentY, PageWidth,
                  CurrentY + Round(bmp.Height * scale)), bmp);
                Inc(CurrentY, Round(bmp.Height * scale) + 20);
              finally
                bmp.Free;
              end;
            finally
              BlobStream.Free;
            end;
          end;
        end

        // --- “T<n>”: RTF text with placeholder replacement ---
        else if (Length(Token) >= 2) and (UpCase(Token[1]) = 'T') and
          TryStrToInt(Copy(Token, 2, MaxInt), idx) then
        begin
          if not Form2.tb_PosText.Active then
            Form2.tb_PosText.Open;
          if Form2.tb_PosText.Locate('id', idx, []) then
          begin
            // A) Read raw RTF from Form2.db_RTEditor
            RawRTF := db_RTEditor.ContentAsRTF;

            // B) Load into hidden TRichEdit to get plain text
            HiddenRE := TRichEdit.Create(nil);
            try
              HiddenRE.ParentWindow := Self.Handle;
              HiddenRE.Visible := False;
              HiddenRE.PlainText := False;
              RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
              try
                RtfStream.Position := 0;
                HiddenRE.Lines.LoadFromStream(RtfStream);
                PlainText := HiddenRE.Text;
              finally
                RtfStream.Free;
              end;
            finally
              HiddenRE.Free;
            end;

            // C) Find all “{NameOnly}” tokens
            RegexPattern := '\{([^}]+)\}';
            Matches := TRegEx.Matches(PlainText, RegexPattern);

            // D) Replace each token using PlaceholderDict
            for Match in Matches do
            begin
              NameOnly := Match.Groups[1].Value.Trim;
              if (NameOnly <> '') and PlaceholderDict.TryGetValue(NameOnly,
                ParamValue) then
              begin
                ReplacementRTF := UnicodeToRtf(ParamValue);
                PlaceholderToken := '{' + NameOnly + '}';
                RawRTF := StringReplace(RawRTF, PlaceholderToken,
                  ReplacementRTF, [rfReplaceAll, rfIgnoreCase]);
              end;
            end;

            // E) Load substituted RTF into temp TRichEdit then print each line
            r := TRichEdit.Create(nil);
            try
              r.ParentWindow := Self.Handle;
              r.Visible := False;
              r.PlainText := False;

              RtfStream := TStringStream.Create(RawRTF, TEncoding.UTF8);
              try
                RtfStream.Position := 0;
                r.Lines.LoadFromStream(RtfStream);
              finally
                RtfStream.Free;
              end;

              for LineIndex := 0 to r.Lines.Count - 1 do
              begin
                r.SelStart := r.Perform(EM_LINEINDEX, LineIndex, 0);
                r.SelLength := Length(r.Lines[LineIndex]);
                LineText := r.Lines[LineIndex];

                CurrentFont := TFont.Create;
                try
                  CurrentFont.Assign(r.SelAttributes);
                  Printer.Canvas.Font.Name := CurrentFont.Name;
                  Printer.Canvas.Font.Size := CurrentFont.Size;
                  Printer.Canvas.Font.Style := CurrentFont.Style;
                  Printer.Canvas.Font.Charset := ANSI_CHARSET;

                  TextHeight := Printer.Canvas.TextHeight(LineText);
                  LineWidth := Printer.Canvas.TextWidth(LineText);
                  TextX := (PageWidth - LineWidth) div 2;

                  WideLine := WideString(LineText);
                  Windows.TextOutW(Printer.Canvas.Handle, TextX, CurrentY,
                    PWideChar(WideLine), Length(WideLine));
                  Inc(CurrentY, TextHeight + 10);
                finally
                  CurrentFont.Free;
                end;
              end;

              Inc(CurrentY, 20);
            finally
              r.Free;
            end;
          end;
        end

        // --- “Q”: standalone QR panel (no background) ---
        else if (UpCase(Token[1]) = 'Q') then
        begin
          QRPanel := TPanel.Create(nil);
          try
            QRPanel.Width := qrSize;
            QRPanel.Height := qrSize;
            QRPanel.BorderStyle := bsNone;

            QR := TImage.Create(QRPanel);
            try
              QR.Parent := QRPanel;
              QR.Transparent := True;
              QR.AutoSize := False;
              QR.Width := qrSize;
              QR.Height := qrSize;
              QR.Picture.Assign(img_QRcode.Picture);
              QR.Stretch := True;
              QR.Proportional := True;
              QR.Left := 0;
              QR.Top := 0;

              // Capture panel into a bitmap
              bmp := TBitmap.Create;
              try
                bmp.PixelFormat := pf24bit;
                bmp.Width := QRPanel.Width;
                bmp.Height := QRPanel.Height;
                QRPanel.PaintTo(bmp.Canvas.Handle, 0, 0);

                if CurrentY + bmp.Height > Printer.PageHeight then
                begin
                  Printer.NewPage;
                  CurrentY := 50;
                end;

                Printer.Canvas.StretchDraw(Rect(0, CurrentY, PageWidth,
                  CurrentY + bmp.Height), bmp);
                Inc(CurrentY, bmp.Height + 20);
              finally
                bmp.Free;
              end;
            finally
              QR.Free;
            end;
          finally
            QRPanel.Free;
          end;
        end;
      end; // for each token

      // 4) Bottom margin: print invisible dots to advance paper
      BlankLines := 8;
      CurrentFont := TFont.Create;
      try
        CurrentFont.Assign(Printer.Canvas.Font);
        Printer.Canvas.Font.Color := clWhite;
        TextHeight := Printer.Canvas.TextHeight('.');

        for I := 1 to BlankLines do
        begin
          Windows.TextOutW(Printer.Canvas.Handle, 0, CurrentY,
            PWideChar(WideString('.')), 1);
          Inc(CurrentY, TextHeight);
        end;
      finally
        CurrentFont.Free;
      end;
    finally
      Printer.EndDoc;
    end;
  end; // for copyIndex
end;

PROCEDURE TForm1.bt_RegisterClick(Sender: TObject);
  procedure AddIfMissing(const AKey, AValue: string);
  begin
    if not FPlaceholders.ContainsKey(AKey) then
      FPlaceholders.Add(AKey, AValue);
  end;

VAR
  s, Key, FieldName, receipt: STRING;
  Printer: TPrinter;
  I: Integer;
  PlaceholderDict: TDictionary<string, string>;
  Copies: Integer;
  ItemsBlank: Boolean;
  fs: TFormatSettings;
  sFormatted: string;
  sBytes: TBytes;
BEGIN
  // Check if data on oTab complete
  // ---------------------------------------------------------------------------
  If Form2.tb_oTab.FieldByName('Description').IsNull Then
  begin
    ShowMessage('Manca la descrizione della registrazione!');
    Exit;
  end;

  receipt := 'False';
  IF Form2.tb_oTab.RecordCount > 0 THEN
  BEGIN
    // Make sure the working day is set correctly
    SetWorkingDayDateTime(Now);
    // Check if workingDay already closed
    // -------------------------------------------------------------------------
    With Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT ClosingID FROM Pecunia WHERE ClosingID = ' +
        QuotedStr(DateToStr(DateOf(sDt))));
      Active := True;
      Var
      subFeeID := Form2.tb_oTab.FieldByName('SubFeeID').AsInteger;
      If (RecordCount > 0) AND (subFeeID <> 990) and (subFeeID <> 995) and
        (subFeeID <> 999) Then
      begin
        // Working day already closed hence no more registrations permitted

        TaskDlgHelperF.TaskDlg_Default('Chiusura cassa',
          'Chiusura giornata ' + DateToStr(DateOf(sDt)) + ' giá effettuata!',
          'Ulteriori registrazioni possibili unicamento a partire da domani ',
          'OK', '', '', 'stop_48.ico');

        bt_CancelAllClick(Sender);
        Exit;
      end;
    end;
    // ----------------
    // Register all data
    // ----------------
    // If Income or Expense ask if paper recept exists( Aldi, Coop, ecc)
    // -------------------------------------------------------------------------

    IF InRange(Form2.tb_oTab.FieldByName('SubfeeID').AsInteger, 9940, 9950) Then
    begin
      CASE TaskDlgHelperF.TaskDlg_Default('Registrazione Contanti',
        'IMPORTANTE! Esiste una ricevuta cartacea per questo importo?',
        'Controlla bene!', 'SI', 'NO', 'Cancella', 'ReceiptCol_40.ico') OF
        1:
          receipt := 'True'; // OK
        7:
          receipt := 'False';
        2:
          begin
            receipt := 'False';
            bt_Cancel.Click; // Cancel
            nnWriteCashierDisplay(0, False, clYellow,
              'Registrazione annullata', 2);
          end;
      end;
      IF Not NumKeyboard.ed_Description.IsEmpty Then
      begin
        Form2.tb_oTab.Edit;
        Form2.tb_oTab.FieldByName('Description').AsString :=
          NumKeyboard.ed_Description.Text;
        Form2.tb_oTab.Post;
        Form2.tb_oTab.Refresh;
      end;
    end;

    With Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('UPDATE OpenTab SET Receipt = ' + receipt);
      ExecSQL;
      Form2.tb_oTab.Refresh;
    end;

    // If deposit reemboursment get the date of the deposit payment
    // -----------------------------------------------------------
    var
      ADate: TDateTime;
    IF Form2.tb_oTab.FieldByName('SubfeeID').AsInteger = 289 Then
      // Deposit reemboursment
      With Form2, qy_Tmp2 do
      begin
        If Active Then
          Close;
        SQL.Clear;
        SQL.Text := 'SELECT Data FROM  C_1000 ' + ' WHERE ClientID = ' +
          tb_oTab.FieldByName('ClientID').AsString + ' AND  TXID = ' +
          QuotedStr(tb_oTab.FieldByName('TxID').AsString);
        Active := True;
        If RecordCount > 0 Then
        begin
          ADate := FieldByName('Data').AsDateTime;
        end
        else
        begin
          ADate := 0;
          ShowMessage
            ('Errore rimborso cauzione. Pagamento cauzione non trovato.');
          Exit;
        end;
      end;

    // Register oTab data to accounts
    // ***------------------------------------------------------------------------

    xx_WriteOtabToAccounts;

    // ***------------------------------------------------------------------------

    bt_Register.Enabled := False;
    nnSetCashierDisplayColor(clAqua);
    // -----------------
    // Now Print tickets
    // -----------------
    IF cb_settings_PrintCB.Checked THEN
      WITH Form2.qy_Print DO
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM OpenTab ' +
          'LEFT JOIN Clients ON Clients.ID = OpenTab.ClientID ' +
          'WHERE ReceiptCopies > 0');
        Active := True;
        IF FieldByName('ReceiptCopies').AsInteger > 0 THEN
        begin
          Printer := GetMyPrinter;
          nPrintJobDone := True;
          First;
          While not EOF do
          begin
            Barcode1.InputText := FieldByName('TxID').AsString;

            Copies := 0;
            Copies := FieldByName('ReceiptCopies').AsInteger;
            ItemsBlank := True;
            ItemsBlank := FieldByName('PosPrintItems').IsNull or
              (Trim(FieldByName('PosPrintItems').AsString) = '');

            If (Copies <= 0) AND (ItemsBlank) Then
              Continue; // no receipt

            if ((Copies > 0) and ItemsBlank) or
              ((Copies <= 0) and (not ItemsBlank)) then
            begin // receipt but data error
              ShowMessage('Errore dati stampa!' + #13#10 +
                'Mancano o indicazione numero copie o immagini/testi.' + #13#10
                + 'SubFeeID: ' + FieldByName('SubFeeID').AsString + #13#10 +
                'Çopies: ' + intToStr(Copies) + #13#10 + 'ItemsBlank: ' +
                BoolToStr(ItemsBlank, True));
              Exit;
            end;
            // *** -------------------------------------------------------------------- 06.05.25
            // *** To complete. The placeholder names have to be exacly the same as the field names
            // *** --------------------------------------------------------------------

            // Create and populate Dictionary
            // -------------------------------------------------------------
            FPlaceholders.Clear;
            fs := TFormatSettings.Create; // starts from current locale
            fs.ThousandSeparator := #39;
            fs.DecimalSeparator := '.'; // make sure this is also explicit
            for I := 0 to FieldCount - 1 do
            begin
              FieldName := Fields[I].FieldName;

              if Fields[I].DataType = ftFloat then
                AddIfMissing(FieldName, FloatToStrF(Fields[I].AsFloat,
                  ffCurrency, 8, 2))
              else IF FieldByName('DAccount').AsInteger = 1020 Then
                // IBAN payment cc to g
                AddIfMissing('PayMethod', FieldByName('PayMethod').AsString
                  + ' IBAN')
              else
                AddIfMissing(FieldName, Fields[I].AsString);
            end;

            AddIfMissing('datenow', DateToStr(DateOf(Today)));
            AddIfMissing('datetimenow', DateTimeToStr(Now));

            if FieldByName('LifeTimeSpan').AsInteger > 0 then
              AddIfMissing('lifetimespan',
                DateTimeToStr(IncMinute(Now, FieldByName('LifeTimeSpan')
                .AsInteger)));

            AddIfMissing('company', ed_CompanyName.Text);
            AddIfMissing('txid', FieldByName('TxID').AsString);
            AddIfMissing('FirstName', FieldByName('FirstName').AsString);
            AddIfMissing('LastName', FieldByName('LastName').AsString);
            AddIfMissing('description', FieldByName('Description').AsString);

            if FieldByName('PayMethod').AsString = 'OF' then
              AddIfMissing('amountToPrint', 'O F F E R T O  D A  ' + cashier)
            else
            begin
              AddIfMissing('amountToPrint', FormatFloat('#,##0.00',
                FieldByName('AmountToPrint').AsFloat, fs));

              AddIfMissing('amtinwords',
                CurrencyToItalianWords(FieldByName('AmountToPrint').AsFloat,
                FieldByName('PayMethod').AsString, 'centesimi'));
            end;

            if FieldByName('SubFeeID').AsInteger = 700 then // Lottery ticket
              AddIfMissing('shorttxid',
                Copy(FieldByName('TxID').AsString, 8, 5));

            if ADate > 0 then
              AddIfMissing('datea', DateTimeToStr(ADate))
            else
              AddIfMissing('datea', DateTimeToStr(Now));

            s := FieldByName('ReceiptCopies').AsString;
            IF FieldByName('PosPrintItems').AsString <> '' THEN
            BEGIN
              // Create ticket
              s := FieldByName('PosPrintItems').AsString;
              PopulateStackPanelWithPlaceholders_2(FieldByName('PosPrintItems')
                .AsString, FPlaceholders);
              // Print ticket
              For I := 1 to FieldByName('ReceiptCopies').AsInteger do
                PrintFromStackPanel(StackPanel1, Printer);
              // PrintStackPanelAsBitmap(StackPanel1, Printer);
            END;
            Next;
            Application.ProcessMessages;
            Sleep(2000);
          END;
        end;

        // Print lottery tickets
        // ------------------------------------------------------------------
        var
          Code: string;
        var
          printIt: Boolean;
        var
          RaffleText: String;
        var
          Ts: TDateTime;
        // The raffle night is the SHIFT's day, not the calendar day: a ticket
        // printed at 01:00 on Sunday belongs to Saturday night. Same noon rule
        // as GetCashBalance - before 12:00 the shift started yesterday.
        var
          LShiftDay: TDate;
        if TimeOf(Now) < EncodeTime(12, 0, 0, 0) then
          LShiftDay := Date - 1
        else
          LShiftDay := Date;
        img_QRcode.Picture.Assign(Barcode1.Bitmap);

        // cbgLotteryDays is ordered SUNDAY first (index 0 = Sun .. 6 = Sat, see
        // the INI read/write), so the index comes from DayOfWeek (Sunday = 1),
        // NOT DayOfTheWeek (Monday = 1), which picked the next day's box.
        If (cbgLotteryDays.ItemChecked[DayOfWeek(LShiftDay) - 1]) Then
          With Form2.qy_TMP do
          begin
            If Active Then
              Close;
            SQL.Clear;
            SQL.Add('SELECT TxID,PrintLotteryTicket FROM OpenTab ' +
              'WHERE PrintLotteryTicket = True');
            Active := True;
            If RecordCount > 0 Then
            begin
              Code := NewRaffleNumber(FieldByName('TxID').AsString); // row created, PrintedDate NULL
              Ts := Now;
              // Friday night's tickets (DayOfTheWeek 5 = Friday), also after
              // midnight, are for Saturday's draw.
              If DayOfTheWeek(LShiftDay) = 5 Then
                RaffleText := 'VALIDO ESTRAZIONE SABATO'
              else
                RaffleText := ed_LotteryT.Text;
              PrintRaffleTicket(RaffleText, Code, Ts);
              MarkRaffleNumberPrinted(Code, Ts);
            end;
          end;

        // -------------------------------------------------------------------
        // Reset QR Code
        Barcode1.InputText := 'pompeiigentlemensclub.com';
        Active := False;
        Printer := Nil;
      END;
    nnSetPecuniaBtUp;
    ShowHideBottomBtns(True, True, True, True);
    IF StrToBoolDef(receipt, False) Then
      nnWriteCashierDisplay(0, False, clLime,
        'Registrazione effettuata con ricevuta', 2)
    else
      nnWriteCashierDisplay(0, False, clLime, 'Registrazione effettuata', 2);
    xx_CancelAll(False);
  END
  ELSE
    nnWriteCashierDisplay(0, True, clWhite, 'Niente da registrare!', 2);

  dbgd_CashierDisplay.TitleParams.Color := clSilver;
END;

PROCEDURE TForm1.t_executePrint(StackPanel: TStackPanel; Printer: TPrinter;
  Copies: Integer);
BEGIN
  Async(
    PROCEDURE
    BEGIN
      var
        I: Integer;
      nPrintJobDone := False;
      For I := 1 to Copies do
        PrintFromStackPanel(StackPanel1, Printer);
      // PrintStackPanelAsBitmap(StackPanel1, Printer);
    END).Await(
    PROCEDURE
    BEGIN
      nPrintJobDone := True;
    END);
END;

PROCEDURE TForm1.bt_CancelClick(Sender: TObject);
BEGIN
  IF NumKeyboard.Showing THEN
  BEGIN
    NumKeyboard.Calculator(14);
    Exit;
  END;

  IF (Form2.tb_Fees.FieldByName('MultiClick').AsBoolean) AND
    (Form2.tb_oTab.RecordCount > 1) Then
  begin
    With Form2.qy_Tmp2 do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('DELETE FROM openTab ' + 'WHERE rowID = (' +
        'SELECT MAX(rowID) FROM openTab' + ')');
      ExecSQL;
    end;
    Form2.tb_oTab.Refresh;
    Exit;
  end;

  dbgd_CashierDisplay.Refresh;
  // Reset OpenTab to original fee data
  // ---------------------------------------------------------------------------
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('DELETE FROM OpenTab');
    ExecSQL;
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('INSERT INTO OpenTab SELECT * FROM OpenTabMemory');
    ExecSQL;
    Form2.tb_oTab.Refresh;
  END;
  dbgd_CashierDisplay.SumList.RecalcAll;
  bt_Register.Enabled := False;
  bt_Cancel.Enabled := False;
  CheckIfpaymethodComplete;
  dbgd_CashierDisplay.Options := dbgd_CashierDisplay.Options -
    [DBGridEh.dgAlwaysShowSelection];
END;

Procedure TForm1.ReverseClosing(workingday: String);
begin

  IF bt_ClosePeriod.Caption = 'ANNULLA CHIUSURA' THEN
  BEGIN
    IF TaskDlgHelperF.TaskDlg_Default('Chiusura cassa',
      'Stai per azzerare la chiusura appena eseguita. Procedi con l''azzeramento?',
      '', 'Azzero chiusura', 'Interrompi azzeramento', '',
      'QuestionMark_48.ico') <> mrOk Then
    begin
      (*
        tm_Closing.Enabled := False;
        JvProgressBar1.Position := 0;
        JvProgressBar1.Visible := False;
        bt_ClosePeriod.Font.Color := clLime;
        bt_ClosePeriod.Caption := 'CHIUSURA CASSA';
        Exit;
      *)
    end
    else
      wITH Form2.qy_Tmp2 do
      begin
        ed_RecReal_CH.Value := 0;
        ed_RecReal_EU.Value := 0;
        ed_RecReal_CC.Value := 0;
        ed_BarReal_CH.Value := 0;
        ed_BarReal_EU.Value := 0;
        ed_BarReal_CC.Value := 0;
        try
          // Start the transaction
          Form2.DB_Main.StartTransaction(['c_1000', 'c_1200', 'c_2900',
            'c_5000', 'c_6000', 'Pecunia']);
          Form2.DB_Bar.StartTransaction(['Bar_OpLedger']);

          // Repeat for other tables
          SQL.Clear;
          SQL.Add('UPDATE c_1000 SET ClosingID = null ' + ' WHERE ClosingID = '
            + QuotedStr(workingday));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE c_1200 SET ClosingID = null ' + ' WHERE ClosingID = '
            + QuotedStr(workingday));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE c_2900 SET ClosingID = null ' + ' WHERE ClosingID = '
            + QuotedStr(workingday));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE c_5000 SET ClosingID = null ' + ' WHERE ClosingID = '
            + QuotedStr(workingday));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE c_6000 SET ClosingID = null ' + ' WHERE ClosingID = '
            + QuotedStr(workingday));
          ExecSQL;

          SQL.Clear;
          SQL.Add('DELETE FROM Pecunia ' + ' WHERE ClosingID = ' +
            QuotedStr(workingday));
          ExecSQL;

          // run the Bar_OpLedger update using a query bound to DB_Bar
          With Form2.qy_TMPBar do
          begin
            if Active then
              Close;
            SQL.Clear;
            SQL.Add('UPDATE Bar_OpLedger SET ClosingID = NULL WHERE ClosingID = '
              + QuotedStr(workingday));
            ExecSQL;
          end;

          // Commit the transactions
          Form2.DB_Bar.Commit;
          Form2.DB_Main.Commit;
          bt_ClosePeriod.Caption := 'CHIUSURA CASSA';
          bt_ClosePeriod.Enabled := True;
          // tm_Closing.Enabled := False;
          JvProgressBar1.Visible := False;
          cl_Closing_Cal.Enabled := True;
        except
          on E: Exception do
          begin
            // Rollback if anything fails
            if Form2.DB_Bar.InTransaction then
              Form2.DB_Bar.Rollback;
            if Form2.DB_Main.InTransaction then
              Form2.DB_Main.Rollback;
            ShowMessage('Transaction failed: ' + E.Message);
          end;
        end;

      end;
  END

end;

procedure TForm1.bt_ClosePeriodClick(Sender: TObject);
begin
  If ClubAccPermissions.ClosingP > 3 Then
  begin
    IF TimeOf(Now).IsPM Then
      IF MessageDlg(Format('Sono le ore "%s". Confermi la chiusura?',
        [TimeToStr(TimeOf(Now))]), mtWarning, [mbOK, mbNo], 0) = mrNo Then
        Exit;
    ExecuteClosing('') // workingDay  in procedure
  end
  else
    ShowMessage('Autorizzazione insufficiente per chiudere giornata cassa');
end;

Procedure TForm1.ExecuteClosing(workDay: String);
var
  n, timeBetween: Integer;
  s, workingday, workingDayPeriod: String;
  lastSaleDt: TDateTime;
begin
  // tm_Closing.Enabled := False;

  SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
    cl_Closing_Cal.StartDate, workingday, workingDayPeriod, False,
    rg_DayMode.ItemIndex = 1);

  // IMPORTANT! CCtoG.rg_CCtoG.ItemIndex has to be on 1 for workingdayperiod
  // ---------------------------------------------------------------------------
  CCtoG.rg_CCtoG.ItemIndex := 1;
  // ---------------------------------------------------------------------------

  // Get first the  datetime of the last sale (reception or bar)
  Var
    tmpLstSDate: TDateTime;

  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT MAX(Data) as lstSale FROM c_1000 ' +
      'WHERE Dare > 0 AND Data ' + workingDayPeriod);
    Active := True;
    If RecordCount > 0 Then
      tmpLstSDate := FieldByName('lstSale').AsDateTime
    else
      tmpLstSDate := 0;
    Close;
  end;
  With Form2.qy_BarTmp do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT MAX(Data) as lstSale FROM Bar_OpLedger ' +
      'WHERE Dare > 0 AND Data ' + workingDayPeriod);
    Active := True;
    If RecordCount > 0 Then
      lastSaleDt := FieldByName('lstSale').AsDateTime
    else
      lastSaleDt := 0;
    Close;
    if tmpLstSDate > lastSaleDt then
      lastSaleDt := tmpLstSDate;
  end;

  IF TaskDlgHelperF.TaskDlg_Default('Chiusura cassa',
    'Stai per effettuare la chiusura.', 'Procedi', 'SI', 'NO', '',
    'QuestionMark_48.ico') = mrOk Then
  begin
    BEGIN
      // Close the day
      // -------------------------------------------------------------------------
      // Check last Fondo Cassa control date
      WITH Form2.qy_Tmp2 do
      begin
        If Active Then
          Close;
        SQL.Clear;
        SQL.Add('SELECT Operator,Paymethod,  CostCenter,  MAX(Data) AS Last_Date '
          + 'FROM c_1010 GROUP BY Paymethod, CostCenter');
        Active := True;
        First;
        If RecordCount > 0 Then
        begin
          Var
            ADate: String;
          While not EOF do
          begin
            IF DaysBetween(FieldByName('Last_Date').AsDateTime, Now) > 2 Then
              s := s + FieldByName('Paymethod').AsString + ' ' +
                FieldByName('CostCenter').AsString + ' ' +
                DateTimeToStr(FieldByName('Last_Date').AsDateTime) + ' ' +
                FieldByName('Operator').AsString + '; ';
            Next;
          end;
          Active := False;
        end
        else
        begin
          TaskDlgHelperF.TaskDlg_Default('Chiusura cassa',
            'Controllo fondi cassa',
            'Non é stato esguito ancora alcuna registrazione dei fondi cassa',
            'OK', '', '', 'Accounting x_48.ico');
          s := DateToStr(Now) + 'Conto 1010 fondo cassa nessuna registrazione!';
        end;

        // If no or late fc check
        If (s <> '') AND NOT(InRange(ed_LastRCMailDate.Value, IncHour(Now, -3),
          Now)) Then
          TThread.CreateAnonymousThread(
            procedure
            begin
              ed_LastRCMailDate.Value := Now;
              // safely captured; lifetime is extended until the closure ends
              // SendThisMail(ed_ToAddr.Text, 'Controllo dati Fondo Cassa', s, []);
            end).Start;

        // Close Working day period
        // -----------------------------------------------------------------------
        IF Not InRange(ed_DeltaTot.Value, -ed_DeltaClosingAmt.Value,
          ed_DeltaClosingAmt.Value) Then
        begin
          AdvInputTaskDialogEx1.InputText := '';
          AdvInputTaskDialogEx1.Instruction := 'La differenza totale cassa di '
            + floatToStr(ed_DeltaTot.Value) + ' é dovuta a: ';
          n := AdvInputTaskDialogEx1.Execute;
          IF ((n = mrOk) and (AdvInputTaskDialogEx1.InputText = '')) OR
            (n = mrCancel) Then
          begin
            ShowMessage('Chiusura cassa cancellata!');
            Exit;
          end;
        end;
      end;
      // Close Pecunia
      // -------------------------------------------------------------------------
      Var
      cCH := ed_RecReal_CH.Value;
      Var
      cEU := ed_RecReal_EU.Value;
      Var
      cCC := ed_RecReal_CC.Value;
      Var
      bch := ed_BarReal_CH.Value;
      Var
      beu := ed_BarReal_EU.Value;
      Var
      bcc := ed_BarReal_CC.Value;

      with Form2.qy_TmpClosing do
      begin

        // INSERT INTO Pecunia table  (Updated code 24 09 2025)
        // ---------------------------------------------------------------------
        // First get the last sale date as timestamp (neede because if later closing occurs
        // Pecunia Data would not match account Data datetime)
        var
          DataDT: TDateTime;
        begin
          if lastSaleDt < sDt then
            DataDT := lastSaleDt
          else
            DataDT := Now;

          if Active then
            Close;
          SQL.Clear;
          SQL.Text := 'UPDATE Pecunia SET ' +
            '  Data=:Data, cCH=:cCH, cEU=:cEU, cCC=:cCC,' +
            '  bCH=:bCH, bEU=:bEU, bCC=:bCC,' +
            '  ExChangeRateEuro=:Rate, Operator=:Operator, Comments=:Comments '
            + 'WHERE ClosingID=:ClosingID';
          Params.ParamByName('Data').AsDateTime := DataDT;
          Params.ParamByName('cCH').AsFloat := cCH;
          Params.ParamByName('cEU').AsFloat := cEU;
          Params.ParamByName('cCC').AsFloat := cCC;
          Params.ParamByName('bCH').AsFloat := bch;
          Params.ParamByName('bEU').AsFloat := beu;
          Params.ParamByName('bCC').AsFloat := bcc;
          Params.ParamByName('Rate').AsFloat := ed_EuroRate.Value;
          Params.ParamByName('Operator').AsString := cashier;
          Params.ParamByName('Comments').AsString :=
            AdvInputTaskDialogEx1.InputText;
          Params.ParamByName('ClosingID').AsString := workingday;
          ExecSQL;

          if RowsAffected = 0 then
          begin
            Var
              dT: String;
            IF lastSaleDt < sDt Then
              dT := Form2.EDBEngine1.DateTimeToSQLStr(lastSaleDt, True)
            else
              dT := Form2.EDBEngine1.DateTimeToSQLStr(Now, True);
            SQL.Clear;
            SQL.Add('INSERT INTO Pecunia ' +
              '(Data,cCH,cEU,cCC,bCH,bEU,bCC,ExChangeRateEuro,Operator,ClosingID,Comments) VALUES ('
              + 'CAST(' + QuotedStr(dT) + ' AS TimeStamp), ' + floatToStr(cCH) +
              ',' + floatToStr(cEU) + ',' + floatToStr(cCC) + ',' +
              floatToStr(bch) + ',' + floatToStr(beu) + ',' + floatToStr(bcc) +
              ',' + ed_EuroRate.Text + ',' + QuotedStr(cashier) + ',' +
              QuotedStr(workingday) + ',' +
              QuotedStr(AdvInputTaskDialogEx1.InputText) + ')');
            ExecSQL;
          end;
        end;

        // Set all null or 0 closingIds to corresponding Data value
        // ---------------------------------------------------------------------
        UpdateMissingClosingIDS;

        bt_Register.Enabled := False;
      end;
    END;

    // Get still unclosed periods
    // -------------------------------------------------------------------------

    GetUnclosedPeriods;

    UpdateClosingTabStatus;

    cl_Closing_Cal.Repaint;

    PrintCCCashtoGClick(workingDayPeriod);

    IF (cb_PrintCleaningInfo.Checked) AND (cb_settings_PrintCB.Checked) THEN
      PrintCleaningSheet(True);
    ShowMessage('Chiusura eseguita.');
  end
  else
    ShowMessage('Chiusura interrotta.');
end;

PROCEDURE TForm1.advSTP_FeeEditChange(Sender: TObject);
BEGIN
  lb_imDir.Caption := ExtractFilePath(FileListBox2.FileName);
END;

PROCEDURE TForm1.advSTP_FeeEditChanging(Sender: TObject;
FromPage, ToPage: Integer; VAR AllowChange: Boolean);
BEGIN
  Form2.tb_FeeE.Refresh;
END;

PROCEDURE TForm1.tp_AdminClientsAccountingChanging(Sender: TObject;
FromPage, ToPage: Integer; VAR AllowChange: Boolean);
VAR
  s: STRING;
BEGIN
  WITH Form2 DO
    CASE ToPage OF
      0:
        BEGIN
          SetBoughtByFilter;
        END;
      1:
        BEGIN
          SetSoldByFilter;

        END;
    END;
END;

Procedure TForm1.SetSoldByFilter;
begin
  With Form2, qy_BarSoldBy do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT *, Bar_Products.ProductName ' + 'FROM Bar_SoldByDetail ' +
      'LEFT JOIN Bar_Products ON Bar_Products.ProductID = Bar_SoldByDetail.ProductID '
      + ' WHERE SoldBy = ' + tb_ClientiClients.FieldByName('ID').AsString +
      ' AND Data > CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',
      IncDay(cal_Clients.StartDate, -45))) + ' AS Timestamp) ' +
      ' ORDER BY Data ASC');
    Active := True;

    dbgd_AdminClientsSoldBy.Refresh;
    qy_BarSoldBy.Last;
  end;
end;

Procedure TForm1.SetBoughtByFilter;
var
  s: String;
begin
  With Form2, qy_ClientSS Do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT ss.ClientID,ss.CardID, ss.SoldDt, ss.StartUse, ss.EndUse,' +
      'ss.ServiceID,ss.Valid,ss.CheckedOut,ss.SubfeeID, Fees.Description Descr '
      + 'FROM ServicesSold ss ' + 'LEFT JOIN Fees ON ss.SubfeeID = fees.subID '
      + ' WHERE ClientID = ' + tb_ClientiClients.FieldByName('ID').AsString +
      ' AND SoldDT BETWEEN CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',
      IncDay(cal_Clients.StartDate, -1))) + ' AS Timestamp) ' + ' AND CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',
      IncDay(cal_Clients.EndDate, 1))) + ' as Timestamp)' +
      ' ORDER BY SoldDt ASC');
    Active := True;
    dbgd_AdminClientsSS.Refresh;
  end;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  pl_CC.Visible := False;
end;

PROCEDURE TForm1.BitBtn2Click(Sender: TObject);
VAR
  s: STRING;
BEGIN
  IF TimeOf(Now) < ed_tmPrntTeseuList.Time THEN
    s := 'Sei in anticipo. L''orario previsto per la stampa dell''elenco ' +
      #13#10 + ' clienti per la Teseu è prevista per le ' +
      TimeToStr(ed_tmPrntTeseuList.Time) + '.' + #13#10 +
      'Vuoi continuare lo stesso?';
  IF HourOf(Now) > HourOf(ed_tmPrntTeseuList.Time) THEN
    s := 'Sei in ritardo. L''orario previsto per la stampa dell''elenco ' +
      #13#10 + 'clienti per la Teseu era prevista per le ' +
      TimeToStr(ed_tmPrntTeseuList.Time) + '.' + #13#10 +
      'Vuoi continuare lo stesso?';
  IF HourOf(Now) = HourOf(ed_tmPrntTeseuList.Time) THEN
    s := 'É ora di compilare l''elenco Teseu';
  IF MessageDlg(s, mtInformation, mbOKCancel, 0) = mrOk THEN
    PrintTeseuList(Sender);
END;

// Blob field -> TGraphic, format detected from the file signature. Caller frees. Returns nil if empty.
function TForm1.LoadGraphicFromField(AField: TField): TGraphic;
var
  ms: TMemoryStream;
  Sig: array [0 .. 3] of byte;
begin
  Result := nil;
  if AField.IsNull then
    Exit;

  ms := TMemoryStream.Create;
  try
    TBlobField(AField).SaveToStream(ms);
    if ms.Size < 4 then
      Exit;
    ms.Position := 0;
    ms.ReadBuffer(Sig, 4);
    ms.Position := 0;

    if (Sig[0] = $FF) and (Sig[1] = $D8) then
      Result := TJPEGImage.Create
    else if (Sig[0] = $89) and (Sig[1] = $50) then
      Result := TPngImage.Create
    else if (Sig[0] = $47) and (Sig[1] = $49) then
      Result := TGIFImage.Create
    else
      Result := TBitmap.Create; // 'BM' and fallback

    try
      Result.LoadFromStream(ms);
    except
      FreeAndNil(Result);
      raise;
    end;
  finally
    ms.Free;
  end;
end;

// Version A: First Raffle, then client RECEIVES his winning ticket
// -----------------------------------------------------------------------------
procedure TForm1.btnPrintRafflePriceClick(Sender: TObject);
var
  Code: string;
  pic: TGraphic;
  PrintDT: TDateTime;
begin
  Code := Trim(edRaffleQR.Text);
  // re-check the gates at print time, not only when the text changed

  case CheckRaffleQR(Code) of
    rcAlreadyPrinted:
      begin
        btnPrintRafflePrice.Enabled := False;
        ShowMessage('This raffle price has already been printed.');
        Exit;
      end;
    rcInvalid:
      begin
        btnPrintRafflePrice.Enabled := False;
        ShowMessage('This code is not valid for a raffle ticket.');
        Exit;
      end;
  end;

  btnPrintRafflePrice.Enabled := False; // prevent double clicks while printing
  PrintDT := Now; // same timestamp on the ticket and in the database
  With Form2 do
  begin
    pic := LoadGraphicFromField(tb_RafflePrice.FieldByName('Image')); // nil if empty
    try
      try
        PrintRafflePrices(
          pic,
          'Estrazione del ' + FormatDateTime('dd/mm/yyyy', dtp_RaffleDate.Date),
          'Valido giorni ' + tb_RafflePrice.FieldByName('ValidHowManyDays').AsString,
          edRaffleQR.Text, // QR content
        PrintDT);

        // reached only if printing raised no exception
        RegisterRafflePricePrinted(Code, PrintDT);
      except
        btnPrintRafflePrice.Enabled := IsRaffleQRValid(Code); // allow a retry after an error
        raise;
      end;
    finally
      pic.Free;
    end;
  end;

  edRaffleQR.Clear; // fires OnChange (rcInvalid, no message); button stays disabled
  edRaffleQR.SetFocus;
end;

procedure TForm1.btnPrintRaffleWinClick(Sender: TObject);
begin
  PrintRafflePrice(Sender);
end;

// Version B: First Raffle, then client FISHES a winning ticket from the urn.
// -----------------------------------------------------------------------------
procedure TForm1.PrintRafflePrice(Sender: TObject);
var
  Code: string;
  pic: TGraphic;
  PrintDT: TDateTime;
begin
  Code := GenerateTxID;
  PrintDT := Now; // same timestamp on the ticket and in the database

  pic := LoadGraphicFromField(Form2.tb_RafflePrice.FieldByName('Image')); // nil if empty
  try
    PrintRafflePrices(
      pic,
      'Estrazione del ' + FormatDateTime('dd/mm/yyyy', dtp_RaffleDate.Date),
      'Valido giorni ' + Form2.tb_RafflePrice.FieldByName('ValidHowManyDays').AsString,
      Code, // QR content = the TxID being registered
    PrintDT);

    // reached only if printing raised no exception
    RegisterRaffleWin(Code, PrintDT);
  finally
    pic.Free;
  end;

end;

procedure TForm1.RegisterRaffleWin(const ATxID: string; AWhen: TDateTime);
begin
  With Form2.qry_RaffleCheck do
  begin
    Close;
    SQL.Text :=
      'INSERT INTO RaffleWins ("Data", "Value", SubFeeID, TxID, ValidHowManyDays) ' +
      'VALUES (:Data, :Value, :SubFeeID, :TxID, :ValidDays)';
    ParamByName('Data').AsDateTime := AWhen;
    ParamByName('Value').Value :=
      Form2.tb_RafflePrice.FieldByName('Value').Value;
    ParamByName('SubFeeID').Value :=
      Form2.tb_RafflePrice.FieldByName('SubFeeID').Value;
    ParamByName('TxID').AsString := ATxID;
    ParamByName('ValidDays').Value :=
      Form2.tb_RafflePrice.FieldByName('ValidHowManyDays').Value;
    ExecSQL;
  end;
end;

procedure TForm1.RegisterRafflePricePrinted(const ATxID: string; AWhen: TDateTime);
begin
  With Form2 do
  begin
    qry_RaffleCheck.Close;
    qry_RaffleCheck.SQL.Text :=
      'UPDATE RaffleNumber ' +
      'SET PrintedPriceDate = :PrintedDT, ' +
      '    RedeemedFeeID    = :FeeID ' +
      'WHERE TxID = :TxID ' +
      '  AND PrintedPriceDate IS NULL';
    // never overwrite an earlier print
    qry_RaffleCheck.ParamByName('PrintedDT').AsDateTime := AWhen;
    qry_RaffleCheck.ParamByName('FeeID').Value :=
      tb_RafflePrice.FieldByName('SubFeeID').Value; // keeps NULL if SubFeeID is NULL
    qry_RaffleCheck.ParamByName('TxID').AsString := ATxID;
    qry_RaffleCheck.ExecSQL;
  end;
end;

procedure TForm1.btnSendRelaisDisconnectClick(Sender: TObject);
begin
  WITH MGuardClient1 DO
  BEGIN
    MgRecordType := 'C';
    MgDeviceAddress := Form2.tb_Cassa_Services.FieldByName
      ('CardReader').AsString;
    MgEventDescr := '1';
    MgCommandCode := relaisOff;
    me_RS485Log.Lines.Add('=== SENDING direct button click COMMAND ===');
    me_RS485Log.Lines.Add('RecordType: ' + MgRecordType);
    me_RS485Log.Lines.Add('DeviceAddress: ' + MgDeviceAddress);
    me_RS485Log.Lines.Add('EventDescr: ' + MgEventDescr);
    me_RS485Log.Lines.Add('CommandCode: ' + MgCommandCode);
    me_RS485Log.Lines.Add('About to call SendToMGuardSrv...');
    SendToMGuardSrv;
  END;
end;

procedure TForm1.btn_Help_PosTicketClick(Sender: TObject);
begin
  if not Assigned(frmHelp) then
    frmHelp := TfrmHelp.Create(Self);
  frmHelp.ShowHelpTopic('FeePosTextImgQR_help.html');
end;

PROCEDURE TForm1.bt_AddCardRecordsClick(Sender: TObject);
VAR
  I: Integer;
BEGIN
  CASE rg_CardEditChoice.ItemIndex OF
    0:
      WITH Form2.qy_TMP DO
      BEGIN
        { Make sure to assign the same session and
          database name as the TEDBDatabase
          component }
        SessionName := 'PGC_Session_1';
        DataBaseName := 'DB_Main';
        SQL.Clear;
        SQL.Add('UPDATE cards SET Enabled = ' +
          BoolToStr(cb_CardsOK.Checked, True));
        SQL.Add(',DESCRIPTION = ' + QuotedStr(cb_CardDescription1.Text));
        SQL.Add('WHERE (ID >= ' + ed_FromCardID.Text + ' AND ID <= ' +
          ed_ToCardID.Text + ')');
        Prepare;
        TRY
          Database.StartTransaction(['Cards'], -1);
          TRY
            ExecSQL;
            Database.Commit;
          EXCEPT
            Database.Rollback;
          END;
        FINALLY
          UnPrepare;
        END;
      END;
    1:
      WITH Form2.qy_TMP DO
      BEGIN
        SessionName := 'PGC_Session_1';
        DataBaseName := 'DB_Main';
        I := ed_FromCardID.Value;
        REPEAT
          SQL.Clear;
          SQL.Add('INSERT INTO cards');
          SQL.Add('(ID,Enabled,Description)');
          SQL.Add('VALUES (' + intToStr(I) + ',True,' +
            QuotedStr(cb_CardDescription1.Text) + ')');
          Prepare;
          TRY
            Database.StartTransaction(['Cards'], -1);
            TRY
              ExecSQL;
              Database.Commit;
            EXCEPT
              Database.Rollback;
            END;
          FINALLY
            UnPrepare;
          END;
          Inc(I);
        UNTIL I > ed_ToCardID.Value;
      END;
    2:
      WITH Form2.qy_TMP DO
      BEGIN
        { Make sure to assign the same session and
          database name as the TEDBDatabase
          component }
        SQL.Clear;
        SQL.Add('DELETE FROM cards ');
        SQL.Add('WHERE (ID >= ' + ed_FromCardID.Text + ' AND ID <= ' +
          ed_ToCardID.Text + ')');
        Prepare;
        TRY
          { Start the transaction and execute the query }
          // LocalDatabase.StartTransaction;
          Database.StartTransaction(['Cards'], -1);
          TRY

            ExecSQL;
            Database.Commit;
          EXCEPT
            Database.Rollback;
          END;
        FINALLY
          UnPrepare;
        END;
      END;
  END;
END;

PROCEDURE TForm1.bt_WriteCardClick(Sender: TObject);
var
  registered: Boolean;
begin
  DoWriteCard(registered);
  if registered then
    ShowMessage('Tessera registrata!')
  else
    ShowMessage('Errore registrazione tessera');
END;

Procedure TForm1.DoWriteCard(out registered: Boolean);
VAR
  stmp, s, tmp_CardEDate: STRING;
BEGIN

  IF cb_Testdata_.Checked THEN
  BEGIN
    c_CardID := Form2.tb_Tessere_cards.FieldByName('ID').AsString;
    tmp_CardEDate := Form2.tb_Tessere_cards.FieldByName('Emissiondate')
      .AsString;
    stmp := Pad(intToStr(DayOfTheMonth(Now)), -2, '0') +
      Pad(intToStr(MonthOfTheYear(Now)), -2, '0');
    lb_CardEDate.Caption := stmp;
    stmp := intToStr(YearOf(Now));
    lb_CardEDate.Caption := lb_CardEDate.Caption + stmp;
  END
  ELSE
  BEGIN
    TagReader.SingleScan;
    if TagReader.tID <> '' then
      MemoLog.Lines.Add('Scanned Tag ID: ' + TagReader.tID)
    else
      ShowMessage('No tag detected.');

    // Select the tag before reading
    if not TagReader.SelectTag(TagReader.tID) then
    begin
      MemoLog.Lines.Add('Tag select failed.');
      Exit;
    end;
    IF NOT TagTesterPresent THEN
    // solo per precauzione
    BEGIN
      ShowMessage('Errore lettore tessere..');
      Exit;
    END;
    IF NOT TagReader.SelectTag(tID) THEN
      Exit;

    TagReader.ContinuoScan := False;
    TagReader.SingleScan;
    TRY
      TagReader.WriteBlock(byte(0), asStr, ed_CardID.Text);
      stmp := Pad(intToStr(DayOfTheMonth(Now)), -2, '0') +
        Pad(intToStr(MonthOfTheYear(Now)), -2, '0');
      lb_CardEDate.Caption := stmp;
      TagReader.WriteBlock(byte(1), asStr, stmp);
      stmp := intToStr(YearOf(Now));
      lb_CardEDate.Caption := lb_CardEDate.Caption + stmp;
      TagReader.WriteBlock(byte(2), asStr, stmp);
      // reset userId on card
      TagReader.WriteBlock(byte(3), asStr, Pad(ed_ClientID.Text, -4, '0'));
      // reset access level on card
      TagReader.WriteBlock(byte(4), asStr, '00-1');
    EXCEPT
      ShowMessage('Write Block failed...');
      lb_ErrorMsg.Caption := 'Write Block failed...';
      registered := False;
      Exit;
    END;
  END;

  IF cb_IncrementCardID.Checked THEN
    ed_CardID.Value := ed_CardID.Value + 1;

  WITH Form2.tb_Cards DO
  BEGIN
    IF Locate('ID', ed_CardID.Value, []) THEN
    BEGIN
      s := 'UPDATE Cards SET EmissionDate = ' + QuotedStr(lb_CardEDate.Caption)
        + ', ClientID = ' + intToStr(ed_ClientID.Value) + ', ' +
        'Enabled = True ' + ' WHERE ID = ' + intToStr(ed_CardID.Value);
      Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'Cards');
    END
    ELSE
    BEGIN
      s := 'INSERT INTO Cards (ID,ClientID,EmissionDate,Enabled) ' + 'VALUES ('
        + intToStr(ed_CardID.Value) + ', ClientID = ' +
        intToStr(ed_ClientID.Value) + ', ' + QuotedStr(lb_CardEDate.Caption) +
        ', True)';
      Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'Cards');
    END;
    registered := True;
  END;
END;

PROCEDURE TForm1.RecalcClGridSums;
BEGIN
  // sl_Cassa_ClLedger.RecalcAll;
END;

PROCEDURE TForm1.Bt_alarmClick(Sender: TObject);
BEGIN
  WITH Sender AS TButton DO
  BEGIN
    tmpEvCd := Caption;
  END;
  MGuard1DataReceive(Sender);
END;

PROCEDURE TForm1.Button11Click(Sender: TObject);
BEGIN
  MGuardClient1.MgRecordType := 'C';
  MGuardClient1.MgCommandCode := '37';
  MGuardClient1.MgEventDescr := ledOff;
  MGuardClient1.MgDeviceAddress := '25'; // spogliatoio donne
  MGuardClient1.SendToMGuardSrv;
END;

PROCEDURE TForm1.bt_CheckAlarmSounfClick(Sender: TObject);
BEGIN
  Form2.PlayASound(Form1.c_AlarmSound, True);
END;

PROCEDURE TForm1.Button13Click(Sender: TObject);
BEGIN
  WITH Form2 DO
  BEGIN
    PGC_Session.Execute
      ('BACKUP DATABASE "DB_Main" AS "PGC_DB_Main_Euro Backup on ' +
      EDBEngine1.DateToSQLStr(Date) +
      ' " TO STORE "PGC_DB_Euro_Store" INCLUDE CATALOG')
  END;
END;

PROCEDURE TForm1.Button15Click(Sender: TObject);
BEGIN
  MGuardClient1.MgRecordType := ed_RecType.Text;
  MGuardClient1.MgCommandCode := ed_ComCod.Text;
  MGuardClient1.MgDeviceAddress := ed_DevAdd.Text;
  MGuardClient1.SendToMGuardSrv;
END;

PROCEDURE TForm1.Button9Click(Sender: TObject);
BEGIN
  WITH MGuardClient1 DO
  BEGIN
    MgRecordType := 'C';
    MgDeviceAddress := '50';
    MgEventDescr := '1';
    MgCommandCode := relaisOff;
    SendToMGuardSrv;
    Sleep(sleepTm);
    MgRecordType := 'C';
    MgDeviceAddress := '50';
    MgEventDescr := '2';
    MgCommandCode := relaisOff;
    SendToMGuardSrv;
    Sleep(sleepTm);
    MgRecordType := 'C';
    MgCommandCode := '37';
    MgEventDescr := ledOff;
    MgDeviceAddress := '15';
    SendToMGuardSrv;
    Sleep(sleepTm);
  END;
END;

PROCEDURE TForm1.db_RTEditor_EHExit(Sender: TObject);
BEGIN
  dbgd_Pos_T.SelectedColor := clMedGray;
END;

PROCEDURE TForm1.Button16Click(Sender: TObject);
BEGIN
  WITH MGuardClient1 DO
  BEGIN
    MgRecordType := 'C';
    MgDeviceAddress := '50';
    MgEventDescr := '1';
    MgCommandCode := relaisOn;
    SendToMGuardSrv;
    Sleep(sleepTm);
    MgRecordType := 'C';
    MgCommandCode := '37';
    MgEventDescr := ledRed;
    MgDeviceAddress := '15';
    SendToMGuardSrv;
    Sleep(sleepTm);
  END;
END;

// Start Monitor Code
// ------------------------------------------------------------------------------

PROCEDURE TForm1.PrintPNG(myPrinter: TPrinter; CONST FileName: STRING);
VAR
  pngimage: TPngImage;
  Bitmap: TBitmap;
  SrcWidth, SrcHeight: Integer;
  DestWidth, DestHeight: Integer;
  scale: Double;
  DestRect: TRect;
BEGIN
  // Ensure the printer is valid
  IF myPrinter = NIL THEN
    RAISE Exception.Create('Printer is not assigned.');

  // Load the PNG image
  pngimage := TPngImage.Create;
  Bitmap := TBitmap.Create;
  TRY
    pngimage.LoadFromFile(FileName);

    // Convert PNG to Bitmap
    Bitmap.Assign(pngimage);

    // Get source dimensions
    SrcWidth := Bitmap.Width;
    SrcHeight := Bitmap.Height;

    // Calculate scaling to maintain aspect ratio
    scale := Min(myPrinter.PageWidth / SrcWidth, myPrinter.PageHeight /
      SrcHeight);

    // Calculate destination dimensions
    DestWidth := Round(SrcWidth * scale);
    DestHeight := Round(SrcHeight * scale);

    // Center the image on the page
    DestRect.Left := (myPrinter.PageWidth - DestWidth) DIV 2;
    DestRect.Top := (myPrinter.PageHeight - DestHeight) DIV 2;
    DestRect.Right := DestRect.Left + DestWidth;
    DestRect.Bottom := DestRect.Top + DestHeight;

    // Start printing
    myPrinter.BeginDoc;
    TRY
      // Draw the scaled bitmap to the printer canvas
      myPrinter.Canvas.StretchDraw(DestRect, Bitmap);
    FINALLY
      myPrinter.EndDoc; // Finalize the print job
    END;
  FINALLY
    pngimage.Free;
    Bitmap.Free;
  END;
END;

PROCEDURE TForm1.PrintImageFromTImage(myPrinter: TPrinter; posImage: TImage);
VAR
  Bitmap: TBitmap;
  DestWidth, DestHeight: Integer;
  scale: Double;
  DestRect: TRect;
BEGIN
  IF myPrinter = NIL THEN
    RAISE Exception.Create('Printer is not assigned.');

  IF (posImage.Picture.Graphic = NIL) THEN
    RAISE Exception.Create('No image loaded in TImage.');

  // Convert the TImage graphic to a bitmap for printing
  Bitmap := TBitmap.Create;
  TRY
    Bitmap.Assign(posImage.Picture.Graphic);

    // Calculate scaling to maintain aspect ratio
    scale := Min(myPrinter.PageWidth / Bitmap.Width, myPrinter.PageHeight /
      Bitmap.Height);

    // Calculate destination dimensions
    DestWidth := Round(Bitmap.Width * scale);
    DestHeight := Round(Bitmap.Height * scale);

    // Center the image on the page
    DestRect.Left := (myPrinter.PageWidth - DestWidth) DIV 2;
    DestRect.Top := (myPrinter.PageHeight - DestHeight) DIV 2;
    DestRect.Right := DestRect.Left + DestWidth;
    DestRect.Bottom := DestRect.Top + DestHeight;

    // Start printing
    myPrinter.BeginDoc;
    TRY
      // Draw the scaled bitmap to the printer canvas
      myPrinter.Canvas.StretchDraw(DestRect, Bitmap);
    FINALLY
      myPrinter.EndDoc; // Finalize the print job
    END;
  FINALLY
    Bitmap.Free;
  END;
END;

PROCEDURE TForm1.MergeImagesAndPrint(myPrinter: TPrinter;
RichEdit: TDBRichEditEh; BlobField: TField);
VAR
  Bitmap1, Bitmap2, CombinedBitmap: TBitmap;
  ContentHeight, CombinedHeight: Integer;
  BlobStream: TStream;
  pngimage: TPngImage;
BEGIN
  IF myPrinter = NIL THEN
    RAISE Exception.Create('Printer is not assigned.');

  Bitmap1 := TBitmap.Create;
  Bitmap2 := TBitmap.Create;
  CombinedBitmap := TBitmap.Create;
  pngimage := TPngImage.Create;
  TRY
    // Render the RichEdit content into Bitmap1
    Bitmap1.Width := RichEdit.Width;
    Bitmap1.Height := 1000; // Provide sufficient height initially
    RichEdit.PaintTo(Bitmap1.Canvas.Handle, 0, 0);
    ContentHeight := Bitmap1.Height;
    // Get the rendered height dynamically if possible

    // Load the second image from the Blob field into Bitmap2
    IF NOT(BlobField IS TBlobField) THEN
      RAISE Exception.Create('Provided field is not a Blob field.');

    BlobStream := BlobField.DataSet.CreateBlobStream(BlobField, bmRead);
    TRY
      pngimage.LoadFromStream(BlobStream);
      Bitmap2.Assign(pngimage);
    FINALLY
      BlobStream.Free;
    END;

    // Calculate the combined image dimensions
    CombinedHeight := ContentHeight + Bitmap2.Height;
    CombinedBitmap.Width := Max(Bitmap1.Width, Bitmap2.Width);
    CombinedBitmap.Height := CombinedHeight;

    // Merge the two images
    CombinedBitmap.Canvas.Draw(0, 0, Bitmap1);
    // Draw the first image at the top
    CombinedBitmap.Canvas.Draw(0, ContentHeight, Bitmap2);
    // Draw the second image below the first

    // Print the combined image
    myPrinter.BeginDoc;
    TRY
      myPrinter.Canvas.StretchDraw(Rect(0, 0, myPrinter.PageWidth,
        myPrinter.PageHeight), CombinedBitmap);
    FINALLY
      myPrinter.EndDoc;
    END;
  FINALLY
    Bitmap1.Free;
    Bitmap2.Free;
    CombinedBitmap.Free;
    pngimage.Free;
  END;
END;

PROCEDURE TForm1.PrintImageFromTImageWithDatabase(myPrinter: TPrinter;
posImage: TImage; BlobField: TField);
VAR
  Bitmap1, Bitmap2: TBitmap;
  DestWidth1, DestHeight1, DestWidth2, DestHeight2: Integer;
  Scale1, Scale2: Double;
  DestRect1, DestRect2: TRect;
  BlobStream: TStream;
  pngimage: TPngImage;
BEGIN
  IF myPrinter = NIL THEN
    RAISE Exception.Create('Printer is not assigned.');

  IF posImage.Picture.Graphic = NIL THEN
    RAISE Exception.Create('No image loaded in TImage.');

  // Load the first image from posImage
  Bitmap1 := TBitmap.Create;
  Bitmap2 := TBitmap.Create;
  pngimage := TPngImage.Create;
  TRY
    // Assign the first image (from posImage) to Bitmap1
    Bitmap1.Assign(posImage.Picture.Graphic);

    // Load the second image from the database BlobField
    IF NOT(BlobField IS TBlobField) THEN
      RAISE Exception.Create('Provided field is not a BLOB field.');

    BlobStream := BlobField.DataSet.CreateBlobStream(BlobField, bmRead);
    TRY
      pngimage.LoadFromStream(BlobStream); // Load the PNG from the blob field
      Bitmap2.Assign(pngimage); // Convert PNG to Bitmap
    FINALLY
      BlobStream.Free;
    END;

    // Calculate scaling and positioning for the first image
    Scale1 := Min(myPrinter.PageWidth / Bitmap1.Width, // Fit width to page
    (myPrinter.PageHeight / 2) / Bitmap1.Height // Fit half the page height
      );
    DestWidth1 := Round(Bitmap1.Width * Scale1);
    DestHeight1 := Round(Bitmap1.Height * Scale1);
    DestRect1 := Rect((myPrinter.PageWidth - DestWidth1) DIV 2,
    // Center horizontally
    0, // Start at the top
    (myPrinter.PageWidth - DestWidth1) DIV 2 + DestWidth1, DestHeight1);

    // Calculate scaling and positioning for the second image
    Scale2 := Min(myPrinter.PageWidth / Bitmap2.Width, // Fit width to page
    (myPrinter.PageHeight / 2) / Bitmap2.Height // Fit half the page height
      );
    DestWidth2 := Round(Bitmap2.Width * Scale2);
    DestHeight2 := Round(Bitmap2.Height * Scale2);
    DestRect2 := Rect((myPrinter.PageWidth - DestWidth2) DIV 2,
    // Center horizontally
    DestHeight1, // Start just below the first image
    (myPrinter.PageWidth - DestWidth2) DIV 2 + DestWidth2,
      DestHeight1 + DestHeight2);

    // Start printing
    myPrinter.BeginDoc;
    TRY
      // Draw the first image (posImage) at the top of the page
      myPrinter.Canvas.StretchDraw(DestRect1, Bitmap1);

      // Draw the second image (from the database) below the first image
      myPrinter.Canvas.StretchDraw(DestRect2, Bitmap2);
    FINALLY
      myPrinter.EndDoc; // Finalize the print job
    END;
  FINALLY
    Bitmap1.Free;
    Bitmap2.Free;
    pngimage.Free;
  END;
END;

PROCEDURE TForm1.RichEditToImage(RichEdit: TDBRichEditEh; Image: TImage);
VAR
  Bitmap: TBitmap;
  DrawRect: TRect;
BEGIN
  Bitmap := TBitmap.Create;
  TRY
    // Set the bitmap size to match the RichEdit dimensions
    Bitmap.Width := RichEdit.Width;
    Bitmap.Height := RichEdit.Height;

    // Define the drawing rectangle
    DrawRect := Types.Rect(0, 0, Bitmap.Width, Bitmap.Height);

    // Draw the RichEdit content to the bitmap
    RichEdit.Perform(WM_PAINT, Bitmap.Canvas.Handle, LPARAM(@DrawRect));

    // Assign the bitmap to the image
    Image.Picture.Bitmap := Bitmap;

    // Save as PNG
    WITH TPngImage.Create DO
      TRY
        Assign(Bitmap);
        SaveToFile('RichEditContent.png'); // Save as PNG file
      FINALLY
        Free;
      END;
  FINALLY
    Bitmap.Free;
  END;
END;

function TForm1.MyTaskDlg_Default(Cap, titl, Txt, b0_c, b1_c, b2_c,
  IconFileName: string): Integer;
var
  Dlg: TTaskDialog;
  btn0, btn1, btn2: TTaskDialogButtonItem;
  MyIcon: TIcon;
  s: string;
begin
  Dlg := TTaskDialog.Create(nil);
  try
    Dlg.Caption := Cap;
    Dlg.Title := titl;
    Dlg.Text := Txt;
    Dlg.CommonButtons := [];
    Dlg.Flags := Dlg.Flags + [tfUseHIconMain, tfUseHIconFooter] -
      [tfAllowDialogCancellation];

    // Check if file exists before loading
    if not FileExists(ed_ImgDir.Text + '\' + IconFileName) then
      raise Exception.Create('Icon file not found: ' + ed_ImgDir.Text + '\' +
        IconFileName);

    // Load icon
    MyIcon := TIcon.Create;
    try
      MyIcon.LoadFromFile(ed_ImgDir.Text + '\' + IconFileName);
      Dlg.CustomMainIcon := MyIcon;
    finally
      MyIcon.Free;
    end;

    // Add custom buttons
    IF b0_c <> '' Then
    begin
      btn0 := TTaskDialogButtonItem(Dlg.Buttons.Add);
      btn0.Caption := b0_c;
      btn0.ModalResult := mrOk;
    end;

    IF b1_c <> '' Then
    begin
      btn1 := TTaskDialogButtonItem(Dlg.Buttons.Add);
      btn1.Caption := b1_c;
      btn1.ModalResult := mrNo;
    end;

    IF b2_c <> '' Then
    begin
      btn2 := TTaskDialogButtonItem(Dlg.Buttons.Add);
      btn2.Caption := b2_c;
      btn2.ModalResult := mrCancel;
    end;

    // Show the dialog and return result
    if Dlg.Execute then
      Result := Dlg.ModalResult
    else
      Result := -1;
  finally
    Dlg.Free;
  end;
end;

PROCEDURE TForm1.RzDBCheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
BEGIN
  WITH Form2.tb_FeeE DO
    IF State IN [dsEdit, dsInsert] THEN
      Post;
END;

PROCEDURE TForm1.RzDBCheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
BEGIN
  WITH Form2.tb_FeeE DO
    IF State IN [dsEdit, dsInsert] THEN
      Post;
END;

procedure TForm1.rgCCMDClick(Sender: TObject);
Var
  StDt, EnDt: TDateTime;
  workingday, workingDayPeriod: String;
begin
  Case rgCCMD.ItemIndex of
    1:
      Begin
        StDt := EncodeDateTime(cl_Closing_Cal.Year, cl_Closing_Cal.Month, 1,
          0, 0, 0, 0);
        EnDt := EncodeDateTime(cl_Closing_Cal.Year, cl_Closing_Cal.Month,
          DaysInMonth(StDt), 0, 0, 0, 0);
        SetDatePeriod(StDt, StDt, EnDt, workingday, workingDayPeriod, True,
          rg_DayMode.ItemIndex = 1);
        ShowCCtoGirls(StDt, workingDayPeriod, False);
        lb_Period.Caption := 'Dal ' + DateTimeToStr(DateOf(StDt)) + ' al ' +
          DateTimeToStr(DateOf(EnDt));
        PrintCCtoG(StDt, EnDt, workingDayPeriod);
      End;
    0:
      begin
        SetDatePeriod(cl_Closing_Cal.StartDate, cl_Closing_Cal.StartDate,
          IncDay(cl_Closing_Cal.StartDate, 1), workingday, workingDayPeriod,
          True, rg_DayMode.ItemIndex = 1);
        ShowCCtoGirls(cl_Closing_Cal.StartDate, workingDayPeriod, True);
        lb_Period.Caption := '';
        PrintCCtoG(cl_Closing_Cal.StartDate, IncDay(cl_Closing_Cal.StartDate,
          1), workingDayPeriod);
      end;
  End;
end;

procedure TForm1.pl_RicClosingEnter(Sender: TObject);
begin
  pl_RicClosing.BorderColor := clRed;
end;

procedure TForm1.pl_RicClosingExit(Sender: TObject);
begin
  pl_RicClosing.BorderColor := clWhite;
end;

procedure TForm1.pl_BarClosingEnter(Sender: TObject);
begin
  pl_BarClosing.BorderColor := clRed;
end;

procedure TForm1.pl_BarClosingExit(Sender: TObject);
begin
  pl_BarClosing.BorderColor := clBtnFace;
end;

procedure TForm1.dbrg_PosImageFormatClick(Sender: TObject);
begin
  With Form2.tb_PosImages do
  begin
    CASE dbrg_PosImageFormat.ItemIndex OF
      0:
        begin
          Filter := '';
          Filtered := True;
        end;
      1:
        begin
          Filter := 'Format = ''P'' ';
          Filtered := True;
        end;

      2:
        begin
          Filter := 'Format = ''L'' ';
          Filtered := True;
        end;
    END;
  end;
end;

procedure TForm1.RzStatusBar1DblClick(Sender: TObject);
begin
  nStartMguard(Sender);
end;

procedure TForm1.RzStatusPane1DblClick(Sender: TObject);
begin
  nStartMguard(Sender);
end;

procedure TForm1.RzStatusPane2DblClick(Sender: TObject);
begin
  nStartMguard(Sender);
end;

PROCEDURE TForm1.FilterBonusMalusFees;
VAR
  BReferences: STRING;
  FilterCondition: STRING;
  CSVList: TStringList;
  I: Integer;
BEGIN
  BReferences := Form2.tb_FeeE.FieldByName('BonusMalusReference').AsString;

  // Split the CSV into individual IDs using TStringList
  CSVList := TStringList.Create;
  TRY
    CSVList.Delimiter := ',';
    CSVList.StrictDelimiter := True; // Avoid issues with spaces
    CSVList.DelimitedText := BReferences;

    // Construct the filter condition dynamically
    FilterCondition := '';
    FOR I := 0 TO CSVList.Count - 1 DO
    BEGIN
      IF I > 0 THEN
        FilterCondition := FilterCondition + ' OR ';
      FilterCondition := FilterCondition + Format('SubID = %s', [CSVList[I]]);
    END;

    // Apply the filter to the dataset
    WITH Form2.tb_BonMalFees DO
    BEGIN
      Filtered := False; // Disable the filter first
      IF FilterCondition <> '' THEN
        Filter := FilterCondition
      ELSE
        Filter := 'SubID = 1000000000000'; // No filter if no IDs are provided
      Filtered := True; // Enable the filter
    END;
  FINALLY
    CSVList.Free;
    //
  END;
END;

PROCEDURE TForm1.RenderRTFToTImage(CONST RTFContent: STRING;
TargetImage: TImage);
VAR
  RichEdit: TRichEdit;
  Bitmap: TBitmap;
  FormatRange: TFormatRange;
  ContentHeightTWIPS, ContentHeightPixels: Integer;
  RtfStream: TStringStream;
  DC: HDC;
BEGIN
  IF NOT Assigned(TargetImage) THEN
    RAISE Exception.Create('TargetImage is not assigned.');

  RichEdit := TRichEdit.Create(NIL);
  Bitmap := TBitmap.Create;
  RtfStream := TStringStream.Create(RTFContent);
  TRY
    // Initialize the RichEdit control
    RichEdit.Visible := False;
    RichEdit.Parent := Application.MainForm;
    RichEdit.Width := 800; // Set desired width for rendering
    RichEdit.Lines.LoadFromStream(RtfStream); // Load the RTF content properly

    // Create a memory DC compatible with the screen
    DC := CreateCompatibleDC(0);
    TRY
      // Initialize the FormatRange structure
      ZeroMemory(@FormatRange, SizeOf(TFormatRange));
      FormatRange.HDC := DC; // Measurement target
      FormatRange.hdcTarget := DC; // Same DC for measurement
      FormatRange.RC :=
        Rect(0, 0, RichEdit.Width * 1440 DIV screen.PixelsPerInch, MaxInt);
      FormatRange.chrg.cpMin := 0; // Start of content
      FormatRange.chrg.cpMax := -1; // End of content

      // Measure content height in TWIPS
      ContentHeightTWIPS := RichEdit.Perform(EM_FORMATRANGE, 0,
        LPARAM(@FormatRange));
      ContentHeightPixels := MulDiv(ContentHeightTWIPS,
        screen.PixelsPerInch, 1440);
      // Convert TWIPS to pixels

      // Set up the bitmap size
      Bitmap.Width := RichEdit.Width;
      Bitmap.Height := Max(1, ContentHeightPixels);
      // Ensure height is at least 1 pixel

      // Render the RTF content onto the bitmap's canvas
      Bitmap.Canvas.Lock;
      TRY
        Bitmap.Canvas.Brush.Color := clWhite; // Set background color
        Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
        FormatRange.HDC := Bitmap.Canvas.Handle;
        // Use bitmap's canvas for rendering
        RichEdit.Perform(EM_FORMATRANGE, 1, LPARAM(@FormatRange));
      FINALLY
        Bitmap.Canvas.Unlock;
      END;

      // Release the format range resources
      RichEdit.Perform(EM_FORMATRANGE, 0, 0);
    FINALLY
      DeleteDC(DC);
    END;

    // Assign the rendered bitmap to the TImage component
    TargetImage.Picture.Bitmap.Assign(Bitmap);
    TargetImage.Refresh;

  FINALLY
    RichEdit.Free;
    Bitmap.Free;
    RtfStream.Free;
  END;
END;

PROCEDURE TForm1.PreparePrintItems;
VAR
  I: Integer;
  posImages: TDataSet;
  BlobStream: TStream;
  // LineText: STRING;
  // CurrentFont: TFont;
BEGIN
  FOR I := LOW(ItemsToPrint_Arr) TO HIGH(ItemsToPrint_Arr) DO
  BEGIN
    CASE ItemsToPrint_Arr[I].ItemType OF
      'H', 'B': // Process and print an Header or Body image
        BEGIN
          IF ItemsToPrint_Arr[I].ItemType = 'H' THEN
            // posImages := Form2.tb_PosHeader
          ELSE IF ItemsToPrint_Arr[I].ItemType = 'B' THEN
            // posImages := Form2.tb_PosBody;

            IF posImages.Locate('ID', ItemsToPrint_Arr[I].ItemID, []) THEN
            BEGIN
              BlobStream := posImages.CreateBlobStream
                (posImages.FieldByName('PosImage'), bmRead);
              TRY
                // Load the image directly from the BlobStream
                IF NOT Assigned(PrintItems.ImageA) THEN
                BEGIN
                  PrintItems.ImageA := TPicture.Create;
                  // LoadImageFromBlobStream(BlobStream, PrintItems.ImageA);
                  PrintItems.ImageA.LoadFromStream(BlobStream);
                END
                ELSE
                BEGIN
                  PrintItems.ImageB := TPicture.Create;
                  PrintItems.ImageB.LoadFromStream(BlobStream);
                END;
              FINALLY
                BlobStream.Free;
              END;
            END;
        END;
      'Q':
        IF Assigned(PrintItems.QrImage) AND Assigned(img_QRcode.Picture) THEN
        BEGIN
          PrintItems.QrImage := TPicture.Create;
          img_QRcode.Height := PrintItems.qr_Size;
          img_QRcode.Width := PrintItems.qr_Size;
          PrintItems.QrImage.Assign(img_QRcode.Picture);
        END;
      'T', 't':
        BEGIN // Process and print RichText
          PrintItems.RichTextA := NIL;
          // Initialize to nil to avoid access violations
          TRY
            // Copy the rich text content from RichEditText to the record's RichTextA
            // CopyRichText(db_RTEditor, PrintItems.RichTextA, Self);

            // Example: Verify the content in the non-visual TRichEdit
            {
              IF Assigned(PrintItems.RichTextA) AND (PrintItems.RichTextA.Lines.Count > 0) THEN
              BEGIN

              ShowMessage('RichText successfully copied.');
              END;
            }
          FINALLY
            // Free the TRichEdit instance after use
            FreeAndNil(PrintItems.RichTextA);
          END;
        END;
    END;
  END;
END;

PROCEDURE TForm1.CopyRichText(Source: TDBRichEditEh; VAR Target: TDBRichEditEh;
AParent: TWinControl);
BEGIN
  IF NOT Assigned(Target) THEN
  BEGIN
    Target := TDBRichEditEh.Create(AParent); // Create the target RichText
    Target.Parent := AParent; // Assign a valid parent
    Target.Visible := False; // Hide it, as it is only for background use
  END;

  IF Assigned(Source) AND Assigned(Target) THEN
  BEGIN
    // Copy content and formatting
    Target.Font.Assign(Source.Font);
    Target.Paragraph.Assign(Source.Paragraph);
    Target.Lines.Assign(Source.Lines);
  END;
END;

procedure TForm1.CreaTessera1Click(Sender: TObject);
VAR
  s: STRING;
  I, mr: Integer;
  cardOk, registered: Boolean;
  alias, otherAlias: String;
  ClientID, oldCardID: Integer;
BEGIN
  If ed_ClCardID.Text = '' Then
  begin
    ShowMessage('ID tessera non pu?o essere vuoto.');
    Exit;
  end;
  alias := Form2.tb_ClientiClients.FieldByName('Alias').AsString;
  ClientID := Form2.tb_ClientiClients.FieldByName('ID').AsInteger;
  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := ' SELECT cl.ID AS clID,ca.ID AS oldCardID ' +
      ' FROM Clients cl ' + ' JOIN Cards ca  ON cl.ID = ca.ClientID ' +
      ' WHERE ca.ClientID = ' + intToStr(ClientID);
    Open;
    If (RecordCount > 0) Then
      oldCardID := FieldByName('oldCardID').AsInteger;
  end;

  IF InRange(ed_ClCardID.Value, 3000, 5999) Then
  begin
    // Check If card valid
    // -------------------------------------------------------------------------
    I := VerifyCard(ed_ClCardID.Value);
    Case I OF
      1:
        s := 'Tessera valida. Appartiene a questo o altro cliente';
      -1:
        s := 'Tessera valida,' + intToStr(uClientStore.ThisCard.cardID) +
          ' non appartiene a nessun cliente!';
      -2:
        begin
          ShowMessage('Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
            ' non autorizzata');
          Exit;
        end;
      -3:
        begin
          ShowMessage('Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
            ' non esiste nel database!');
          Exit;
        end;
    End;

    // Card already registerd
    // -------------------------------------------------------------------------
    WITH Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text :=
        ' SELECT ca.ClientID AS clID, cl.alias as otherAlias, MAX(ss.SoldDT) AS LastData '
        + ' FROM Cards ca ' + ' JOIN Clients cl  ON cl.ID = ca.ClientID ' +
        ' JOIN ServicesSold ss ON ss.ClientID = ca.ClientID ' +
        ' WHERE ca.ID = ' + ed_ClCardID.Text + ' AND ss.FeeID = 3 ' +
        ' GROUP BY ca.ClientID, cl.alias';
      Open;
      If (RecordCount > 0) Then
      begin
        otherAlias := FieldByName('otherAlias').AsString;
        IF (FieldByName('clID').AsInteger <> ClientID) Then
        // Card belongs to other client
        begin
          ShowMessage('La tessera ' + ed_ClCardID.Text + ' appartiene a ' +
            FieldByName('otherAlias').AsString + #13#10 +
            'Scegli un''altra tessera o azzera prima qusta tessera.');
          Exit;
        end;
      end;
      Active := False;
    end;

    // Client has already card, only a rewrite of the same card is allowed
    // -------------------------------------------------------------------
    If (InRange(oldCardID, 3000, 5999)) AND
      (oldCardID <> ed_ClCardID.Value) Then
    begin
      ShowMessage(alias + ' ha già assegnata la tessera ' + intToStr(oldCardID)
        + '.' + #13#10 + 'Devi usare questa stessa ID tessera.');
      Exit;
    end;

    // Card ok to register
    // -----------------------------------------------------------------------
    mr := TaskDlgHelperF.TaskDlg_Default('Gestione tessere',
      'La ' + ed_ClCardID.Text + ' è pronta per essere registrata.',
      'Procedi? ' + LastTxData.lTxFeeDesc + '?', 'Registra', '', 'NO',
      'RfidCards_48.ico');
    IF mr = 1 Then
    begin
      WITH Form2.qy_Tmp2 DO
      BEGIN
        // First set all clientid's to -1 where clientid = this clients id
        If Active Then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE Cards c ' + 'SET ClientID = -1 ' + 'WHERE ClientID = ' +
          intToStr(ClientID));
        ExecSQL;
      END;
      // Now write everything new
      ed_CardID.Value := ed_ClCardID.Value;
      ed_ClientID.Value := ClientID;
      DoWriteCard(registered);
      if registered then
        ShowMessage('Tessera registrata!')
      else
        ShowMessage('Errore registrazione tessera');
    End;
  end;
END;

PROCEDURE TForm1.DBCtrlGrid1MouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
BEGIN
  IF (Button = mbLeft) AND (ssCtrl IN Shift) THEN
    TControl(Sender).BeginDrag(True);
END;

PROCEDURE TForm1.PurgeCompletedPrintJobs;
VAR
  hPrinter: THandle;
  PrinterName: ARRAY [0 .. 255] OF Char;
  JobInfo: PJobInfo1;
  BytesNeeded, JobsReturned: DWORD;
  I: Integer;
BEGIN
  // Get the name of the current printer
  StrPCopy(PrinterName, Printer.Printers[Printer.PrinterIndex]);

  // Open a handle to the printer
  IF NOT OpenPrinter(PrinterName, hPrinter, NIL) THEN
  BEGIN
    ShowMessage('Failed to open printer');
    Exit;
  END;

  TRY
    // Get the size of the buffer needed for job info
    EnumJobs(hPrinter, 0, $FFFFFFFF, 1, NIL, 0, BytesNeeded, JobsReturned);
    IF BytesNeeded = 0 THEN
      Exit;

    GetMem(JobInfo, BytesNeeded);
    TRY
      // Retrieve the list of print jobs
      IF EnumJobs(hPrinter, 0, $FFFFFFFF, 1, JobInfo, BytesNeeded, BytesNeeded,
        JobsReturned) THEN
      BEGIN
        FOR I := 0 TO JobsReturned - 1 DO
        BEGIN
          // Use pointer arithmetic to access individual job records
          WITH PJobInfo1(Integer(JobInfo) + I * SizeOf(TJobInfo1))^ DO
          BEGIN
            // Check if the job is completed
            IF Status AND JOB_STATUS_PRINTED <> 0 THEN
            BEGIN
              // Purge the job
              IF NOT SetJob(hPrinter, JobId, 0, NIL, JOB_CONTROL_DELETE) THEN
                ShowMessage(Format('Failed to delete job %d', [JobId]));
            END;
          END;
        END;
      END;
    FINALLY
      FreeMem(JobInfo);
    END;
  FINALLY
    ClosePrinter(hPrinter);
  END;
END;

PROCEDURE TForm1.AddRichTextToStackPanel(StackPanel: TStackPanel;
TextID: Integer);
VAR
  RichEdit: TRichEdit;
  BlobStream: TStream;
BEGIN
  WITH Form2.tb_PosText DO
    IF Locate('ID', TextID, []) THEN
    BEGIN
      // Create a TRichEdit and attach it to the StackPanel
      RichEdit := TRichEdit.Create(StackPanel);
      RichEdit.Parent := StackPanel; // Attach to StackPanel
      RichEdit.Align := alTop;
      RichEdit.Visible := False; // Keep it invisible in the StackPanel
      RichEdit.PlainText := False; // Ensure it processes RTF data

      // Load the RichText content from the CLOB field
      BlobStream := CreateBlobStream(FieldByName('PosRichText'), bmRead);
      TRY
        RichEdit.Lines.LoadFromStream(BlobStream);
      FINALLY
        BlobStream.Free;
      END;
    END;
END;

procedure TForm1.PrintFromStackPanel(StackPanel: TStackPanel;
myPrinter: TPrinter);
const
  LineSpacing = 4;
  BlockSpacing = 4;
  TopMargin = 5;
var
  I, TextY, PageWidth, PageHeight: Integer;
  Control: TControl;
  Sorted: TList<TControl>;
  pf: TParaFormat2;

  function GetAlignedX(const Text: string; Alignment, PageWidth: Integer;
  Canvas: TCanvas): Integer;
  var
    LineWidth: Integer;
  begin
    LineWidth := Canvas.TextWidth(Text);
    case Alignment of
      PFA_LEFT:
        Result := 0;
      PFA_RIGHT:
        Result := PageWidth - LineWidth;
    else
      Result := (PageWidth - LineWidth) div 2; // center
    end;
  end;

  procedure EnsureSpace(HeightNeeded: Integer);
  begin
    if TextY + HeightNeeded > PageHeight then
    begin
      myPrinter.NewPage;
      TextY := TopMargin;
    end;
  end;

  procedure PrintRichEdit(RE: TJvRichEdit);
  var
    FontCopy: TFont;
    Alignment: Word;
    LineHeight, X, LineIdx: Integer;
    LineText: string;
  begin
    FontCopy := TFont.Create;
    try
      for LineIdx := 0 to RE.Lines.Count - 1 do
      begin
        RE.SelStart := RE.Perform(EM_LINEINDEX, LineIdx, 0);
        RE.SelLength := Length(RE.Lines[LineIdx]);
        LineText := RE.Lines[LineIdx];

        FontCopy.Assign(RE.SelAttributes);
        myPrinter.Canvas.Font.Assign(FontCopy);

        FillChar(pf, SizeOf(pf), 0);
        pf.cbSize := SizeOf(pf);
        pf.dwMask := PFM_ALIGNMENT;
        SendMessage(RE.Handle, EM_GETPARAFORMAT, SCF_SELECTION, LPARAM(@pf));
        Alignment := pf.wAlignment;

        LineHeight := myPrinter.Canvas.TextHeight(LineText);
        EnsureSpace(LineHeight + LineSpacing);

        X := GetAlignedX(LineText, Alignment, PageWidth, myPrinter.Canvas);
        myPrinter.Canvas.TextOut(X, TextY, LineText);

        Inc(TextY, LineHeight + LineSpacing);
      end;
      Inc(TextY, BlockSpacing);
    finally
      FontCopy.Free;
    end;
  end;

  procedure PrintBitmapGraphic(Graphic: TGraphic; Height, Width: Integer);
  var
    scale: Double;
    DestRect: TRect;
    OutHeight: Integer;
  begin
    if (Graphic = nil) or Graphic.Empty or (Width = 0) then
      Exit;

    scale := PageWidth / Width;
    OutHeight := Round(Height * scale);

    EnsureSpace(OutHeight);

    DestRect := Rect(0, TextY, PageWidth, TextY + OutHeight);
    myPrinter.Canvas.StretchDraw(DestRect, Graphic);
    Inc(TextY, OutHeight + BlockSpacing);
  end;

  procedure PrintPanel(Panel: TWinControl);
  var
    bmp: TBitmap;
    scale: Double;
    DestRect: TRect;
    OutHeight: Integer;
  begin
    if (Panel.Width = 0) or (Panel.Height = 0) then
      Exit;

    bmp := TBitmap.Create;
    try
      bmp.PixelFormat := pf24bit;
      bmp.SetSize(Panel.Width, Panel.Height);
      Panel.PaintTo(bmp.Canvas.Handle, 0, 0);

      if bmp.Width = 0 then
        Exit;

      scale := PageWidth / bmp.Width;
      OutHeight := Round(bmp.Height * scale);

      EnsureSpace(OutHeight);

      DestRect := Rect(0, TextY, PageWidth, TextY + OutHeight);
      myPrinter.Canvas.StretchDraw(DestRect, bmp);
      Inc(TextY, OutHeight + BlockSpacing);
    finally
      bmp.Free;
    end;
  end;

begin
  // Make sure layout is current so Top/Left are correct
  StackPanel.Realign;
  StackPanel.Update;

  myPrinter.BeginDoc;
  try
    PageWidth := myPrinter.PageWidth;
    PageHeight := myPrinter.PageHeight;
    TextY := TopMargin;

    // Collect and sort controls by visual position
    Sorted := TList<TControl>.Create;
    try
      for I := 0 to StackPanel.ControlCount - 1 do
        Sorted.Add(StackPanel.Controls[I]);

      Sorted.Sort(TComparer<TControl>.Construct(
        function(const A, B: TControl): Integer
        var
          ax, ay, bx, by: Integer;
        begin
          ay := A.BoundsRect.Top;
          by := B.BoundsRect.Top;
          ax := A.BoundsRect.Left;
          bx := B.BoundsRect.Left;

          if StackPanel.Orientation = spoVertical then
          begin
            Result := ay - by; // top -> bottom
            if Result = 0 then
              Result := ax - bx; // tie-breaker: left
          end
          else
          begin
            Result := ax - bx; // left -> right
            if Result = 0 then
              Result := ay - by; // tie-breaker: top
          end;
        end));

      for Control in Sorted do
      begin
        if (not Control.Visible) or (Control.Width = 0) or (Control.Height = 0)
        then
          Continue;

        if Control is TJvRichEdit then
          PrintRichEdit(TJvRichEdit(Control))
        else if (Control is TImage) and
          Assigned(TImage(Control).Picture.Graphic) and not TImage(Control)
          .Picture.Graphic.Empty then
          PrintBitmapGraphic(TImage(Control).Picture.Graphic,
            TImage(Control).Picture.Height, TImage(Control).Picture.Width)
        else if (Control is TWinControl) and not(Control is TJvRichEdit) then
          PrintPanel(TWinControl(Control));
      end;
    finally
      Sorted.Free;
    end;

  finally
    myPrinter.EndDoc;
  end;
end;

procedure TForm1.PrintStackPanelAsBitmap(StackPanel: TStackPanel;
myPrinter: TPrinter);
var
  bmp: TBitmap;
  DestRect: TRect;
  scale: Double;
  OutWidth, OutHeight: Integer;
  PrinterWidth: Integer;
begin
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.SetSize(StackPanel.Width, StackPanel.Height);

    // Render stackpanel exactly as it looks (including RichEdits)
    StackPanel.PaintTo(bmp.Canvas.Handle, 0, 0);

    // Get receipt paper width in dots (Epson = 512 or 576 typically)
    PrinterWidth := myPrinter.PageWidth;

    // Scale proportionally to fit paper width
    scale := PrinterWidth / bmp.Width;
    OutWidth := PrinterWidth;
    OutHeight := Round(bmp.Height * scale);

    myPrinter.BeginDoc;
    try
      DestRect := Rect(0, 0, OutWidth, OutHeight);
      myPrinter.Canvas.StretchDraw(DestRect, bmp);
    finally
      myPrinter.EndDoc;
    end;
  finally
    bmp.Free;
  end;
end;

{
  PROCEDURE TForm1.Button32Click(Sender: TObject);
  VAR
  myPrinter: TPrinter;
  Device: ARRAY [0 .. 255] OF Char;
  Driver: ARRAY [0 .. 255] OF Char;
  Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
  BEGIN
  IF GetCurrentPrinterStatus = 0 THEN
  BEGIN
  Printer.PrinterIndex := Printer.Printers.IndexOf
  (rg_Printers.Items[rg_Printers.ItemIndex]);
  // Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  myPrinter := Printer;
  END
  ELSE
  ShowMessage('ATTENZIONE, Errore stampante no: ' +
  intToStr(GetCurrentPrinterStatus));
  END;
}

FUNCTION TForm1.CalculateRichEditContentHeight(RichEdit: TDBRichEditEh;
PrinterCanvasHandle: HDC): Integer;
VAR
  FormatRange: TFormatRange;
  RenderRect: TRect;
  ContentHeightTWIPS: Integer;
BEGIN
  // Initialize the FormatRange structure
  ZeroMemory(@FormatRange, SizeOf(FormatRange));

  // Set up the rendering rectangle in TWIPS (1/1440 inch units)
  RenderRect.Left := 0;
  RenderRect.Top := 0;
  RenderRect.Right := RichEdit.Width * 1440 DIV screen.PixelsPerInch;
  RenderRect.Bottom := MaxInt;

  FormatRange.HDC := PrinterCanvasHandle;
  // Use the printer's canvas for calculations
  FormatRange.hdcTarget := PrinterCanvasHandle;
  FormatRange.RC := RenderRect; // Set the render rectangle
  FormatRange.rcPage := RenderRect; // Full page size
  FormatRange.chrg.cpMin := 0; // Start at the beginning of the text
  FormatRange.chrg.cpMax := -1; // Go to the end of the text

  // Perform the EM_FORMATRANGE call to calculate the height
  ContentHeightTWIPS := RichEdit.Perform(EM_FORMATRANGE, 0,
    LPARAM(@FormatRange));

  // Release resources used by EM_FORMATRANGE
  RichEdit.Perform(EM_FORMATRANGE, 0, 0);

  // Convert TWIPS to pixels and return
  Result := MulDiv(ContentHeightTWIPS, screen.PixelsPerInch, 1440);
END;

procedure TForm1.PrintStackPanelBitmap(StackPanel: TStackPanel;
const PrinterName: string);
var
  // 1) Off-screen bitmap at printer DPI
  bmp: TBitmap;

  // 2) Printer‐related
  Prn: TPrinter;
  PrinterIndex: Integer;
  PrinterDC: HDC;
  PrnDPIX, PrnDPIY: Integer;

  // 3) Screen DPI (for scaling)
  ScreenDC: HDC;
  ScrDPIX, ScrDPIY: Integer;
  ScaleX, ScaleY: Double;

  // 4) Loop variables
  I, TotalHeight: Integer;
  ChildCtrl: TControl;
  WinCtrl: TWinControl;

  // 5) For drawing each TRichEdit
  OriginalRE, TempRE: TRichEdit;
  fr: TFormatRange;
  RtfStream: TStringStream;

  // 6) Child position & size in printer pixels
  ControlLeft, ControlTop, ControlWidth, ControlHeight: Integer;
  rLeftTwips, rTopTwips, rRightTwips, rBottomTwips: Integer;

  // 7) Temporary bitmaps
  ImgBmp, ChildBmp: TBitmap;
begin
  // Step A: Find the printer by name and get its index
  Prn := Printer;
  PrinterIndex := -1;
  for I := 0 to Prn.Printers.Count - 1 do
    if SameText(Prn.Printers[I], PrinterName) then
    begin
      PrinterIndex := I;
      Break;
    end;
  if PrinterIndex < 0 then
  begin
    ShowMessage
      (Format('Printer "%s" not found. Please install or rename the driver.',
      [PrinterName]));
    Exit;
  end;
  Prn.PrinterIndex := PrinterIndex;

  // Step B: Get printer DPI via CreateDC (so we don’t touch Prn.Canvas yet)
  PrinterDC := CreateDC('WINSPOOL', PChar(Prn.Printers[PrinterIndex]),
    nil, nil);
  try
    PrnDPIX := GetDeviceCaps(PrinterDC, LOGPIXELSX);
    PrnDPIY := GetDeviceCaps(PrinterDC, LOGPIXELSY);
  finally
    DeleteDC(PrinterDC);
  end;

  // Step C: Get screen DPI
  ScreenDC := GetDC(0);
  try
    ScrDPIX := GetDeviceCaps(ScreenDC, LOGPIXELSX);
    ScrDPIY := GetDeviceCaps(ScreenDC, LOGPIXELSY);
  finally
    ReleaseDC(0, ScreenDC);
  end;

  // Step D: Compute scaling factors
  ScaleX := PrnDPIX / ScrDPIX;
  ScaleY := PrnDPIY / ScrDPIY;

  // Step E: Compute total height of all children (in screen pixels), then scale
  TotalHeight := 0;
  for I := 0 to StackPanel.ControlCount - 1 do
    Inc(TotalHeight, StackPanel.Controls[I].Height);

  // Step F: Create an off-screen bitmap at printer resolution
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := Round(StackPanel.ClientWidth * ScaleX);
    bmp.Height := Round(TotalHeight * ScaleY);

    // Fill with white (or StackPanel.Color × scale if you prefer)
    bmp.Canvas.Brush.Color := clWhite;
    bmp.Canvas.FillRect(Rect(0, 0, bmp.Width, bmp.Height));

    // Step G: Render each child into Bmp, scaled up
    for I := 0 to StackPanel.ControlCount - 1 do
    begin
      ChildCtrl := StackPanel.Controls[I];

      // Compute its position & size in printer pixels
      ControlLeft := Round(ChildCtrl.Left * ScaleX);
      ControlTop := Round(ChildCtrl.Top * ScaleY);
      ControlWidth := Round(ChildCtrl.Width * ScaleX);
      ControlHeight := Round(ChildCtrl.Height * ScaleY);

      // G1) If it’s a TRichEdit → draw with EM_FORMATRANGE
      if ChildCtrl is TRichEdit then
      begin
        OriginalRE := TRichEdit(ChildCtrl);

        // Create a hidden, printer-sized TRichEdit
        TempRE := TRichEdit.Create(Self);
        try
          TempRE.ParentWindow := Self.Handle;
          TempRE.Visible := False;
          TempRE.PlainText := False;
          TempRE.Width := ControlWidth;
          TempRE.Height := ControlHeight;

          // Copy its RTF via SaveToStream / LoadFromStream
          RtfStream := TStringStream.Create('', TEncoding.UTF8);
          try
            OriginalRE.Lines.SaveToStream(RtfStream);
            RtfStream.Position := 0;
            TempRE.Lines.LoadFromStream(RtfStream);
          finally
            RtfStream.Free;
          end;

          // Scale the base font so that onscreen Size → physical printer size
          TempRE.Font.Name := OriginalRE.Font.Name;
          TempRE.Font.Style := OriginalRE.Font.Style;
          TempRE.Font.Size := Round(OriginalRE.Font.Size * ScaleX);

          // Also scale DefaultAttributes (for “default font runs”)
          TempRE.DefAttributes.Name := OriginalRE.DefAttributes.Name;
          TempRE.DefAttributes.Style := OriginalRE.DefAttributes.Style;
          TempRE.DefAttributes.Size :=
            Round(OriginalRE.DefAttributes.Size * ScaleX);

          // Convert the target rectangle into TWIPS (1 inch = 1440 twips)
          rLeftTwips := MulDiv(ControlLeft, 1440, PrnDPIX);
          rTopTwips := MulDiv(ControlTop, 1440, PrnDPIY);
          rRightTwips := MulDiv(ControlLeft + ControlWidth, 1440, PrnDPIX);
          rBottomTwips := MulDiv(ControlTop + ControlHeight, 1440, PrnDPIY);

          fr.RC.Left := rLeftTwips;
          fr.RC.Top := rTopTwips;
          fr.RC.Right := rRightTwips;
          fr.RC.Bottom := rBottomTwips;
          fr.rcPage := fr.RC;

          fr.chrg.cpMin := 0;
          fr.chrg.cpMax := -1;
          fr.HDC := bmp.Canvas.Handle;
          fr.hdcTarget := bmp.Canvas.Handle;

          // Draw into the bitmap
          SendMessage(TempRE.Handle, EM_FORMATRANGE, WPARAM(1), LPARAM(@fr));
          SendMessage(TempRE.Handle, EM_FORMATRANGE, 0, 0);
        finally
          TempRE.Free;
        end;
      end

      // G2) If it’s a TImage → load/copy its bitmap & StretchDraw
      else if ChildCtrl is TImage then
      begin
        ImgBmp := TBitmap.Create;
        try
          ImgBmp.Assign(TImage(ChildCtrl).Picture.Bitmap);
          bmp.Canvas.StretchDraw(Rect(ControlLeft, ControlTop,
            ControlLeft + ControlWidth, ControlTop + ControlHeight), ImgBmp);
        finally
          ImgBmp.Free;
        end;
      end

      // G3) If it’s any other TWinControl (e.g. a TPanel with QR), capture & scale
      else if ChildCtrl is TWinControl then
      begin
        WinCtrl := TWinControl(ChildCtrl);

        ChildBmp := TBitmap.Create;
        try
          ChildBmp.PixelFormat := pf24bit;
          ChildBmp.Width := ChildCtrl.Width;
          ChildBmp.Height := ChildCtrl.Height;
          WinCtrl.PaintTo(ChildBmp.Canvas.Handle, 0, 0);

          bmp.Canvas.StretchDraw(Rect(ControlLeft, ControlTop,
            ControlLeft + ControlWidth, ControlTop + ControlHeight), ChildBmp);
        finally
          ChildBmp.Free;
        end;
      end;
    end;

    // Step H: Now send Bmp to the printer (Bmp is at printer DPI already)
    Prn := Printer;
    Prn.Orientation := poPortrait;
    Prn.BeginDoc;
    try
      // Draw at (0,0). If you want a little top margin, use Draw(0,10,Bmp).
      Prn.Canvas.Draw(0, 0, bmp);
    finally
      Prn.EndDoc;
    end;
  finally
    bmp.Free;
  end;
end;

PROCEDURE TForm1.ReplacePlaceholders(RichEdit: TDBRichEditEh; ADate: TDate;
amt: Double);
VAR
  PlaceholderData: TDictionary<STRING, STRING>;
  I: Integer;
  LineText: STRING;
  Placeholder, Value: STRING;
  drinkCredits: Integer;
  drinkCreditValue: Double;
BEGIN

  PlaceholderData := TDictionary<STRING, STRING>.Create;
  TRY
    PlaceholderData.Add('{FirstName}', uClientStore.ThisClient.fName);
    PlaceholderData.Add('{LastName}', uClientStore.ThisClient.lName);
    PlaceholderData.Add('{Alias}', uClientStore.ThisClient.alias);
    PlaceholderData.Add('{IDTeseu}', uClientStore.ThisClient.IDTeseu);
    PlaceholderData.Add('{Simic}', uClientStore.ThisClient.SIMIC);
    // PlaceholderData.Add('{AmountToPrint}', FormatFloat('#,##0.00', Form2.tb_oTab.FieldByName('AmountToPrint').AsFloat));
    PlaceholderData.Add('{AmountToPrint}', FormatFloat('#,##0.00', amt));
    PlaceholderData.Add('{Amount}', FormatFloat('#,##0.00', amt));
    PlaceholderData.Add('{PayMethod}', Form2.tb_oTab.FieldByName('PayMethod')
      .AsString);
    PlaceholderData.Add('{DrinkCredits}',
      Form2.tb_oTab.FieldByName('DrinkCredits').AsString);
    PlaceholderData.Add('{DrinkCreditValue}', FormatFloat('#,##0.00',
      Form2.tb_oTab.FieldByName('DrinkCreditValue').AsFloat));
    PlaceholderData.Add('{Description}',
      Form2.tb_oTab.FieldByName('Description').AsString);
    PlaceholderData.Add('{Date}', DateTimeToStr(DateOf(ADate)));
    PlaceholderData.Add('{RR_Address}', uClientStore.ThisBooking.Address);
    PlaceholderData.Add('{DateDeposit}',
      DateTimeToStr(DateOf(uClientStore.ThisBooking.DepositINdt)));

    // Iterate through all lines in the RichEdit
    FOR I := 0 TO RichEdit.Lines.Count - 1 DO
    BEGIN
      LineText := RichEdit.Lines[I];
      FOR Placeholder IN PlaceholderData.Keys DO
      BEGIN
        IF PlaceholderData.TryGetValue(Placeholder, Value) THEN
        BEGIN
          LineText := StringReplace(LineText, Placeholder, Value,
            [rfReplaceAll, rfIgnoreCase]);
        END;
      END;
      // Update the line in the RichEdit
      RichEdit.Lines[I] := LineText;
    END;
  FINALLY
    PlaceholderData.Free;
  END;
END;

PROCEDURE RichEditToImage(RichEdit: TDBRichEditEh; Image: TImage);
VAR
  Bitmap: TBitmap;
  DrawRect: TRect;
BEGIN
  Bitmap := TBitmap.Create;
  TRY
    // Set the bitmap size to match the RichEdit dimensions
    Bitmap.Width := RichEdit.Width;
    Bitmap.Height := RichEdit.Height;

    // Define the drawing rectangle
    DrawRect := Types.Rect(0, 0, Bitmap.Width, Bitmap.Height);

    // Draw the RichEdit content to the bitmap
    RichEdit.Perform(WM_PAINT, Bitmap.Canvas.Handle, LPARAM(@DrawRect));

    // Assign the bitmap to the image
    Image.Picture.Bitmap := Bitmap;

    // Save as PNG
    WITH TPngImage.Create DO
      TRY
        Assign(Bitmap);
        SaveToFile('RichEditContent.png'); // Save as PNG file
      FINALLY
        Free;
      END;
  FINALLY
    Bitmap.Free;
  END;
END;

FUNCTION TForm1.GetRTFContentFromField(DataSet: TDataSet;
FieldName: STRING): STRING;
VAR
  BlobStream: TMemoryStream;
  RtfStream: TStringStream;
BEGIN
  IF NOT DataSet.Active THEN
    RAISE Exception.Create('Dataset is not active.');

  IF NOT(DataSet.FieldByName(FieldName) IS TBlobField) THEN
    RAISE Exception.Create('Field is not a Blob field.');

  BlobStream := TMemoryStream.Create;
  RtfStream := TStringStream.Create('', TEncoding.Default);
  // Use default encoding
  TRY
    // Load the CBlob field into a memory stream
    TBlobField(DataSet.FieldByName(FieldName)).SaveToStream(BlobStream);
    BlobStream.Position := 0;

    // Convert the binary blob to a string
    RtfStream.CopyFrom(BlobStream, BlobStream.Size);
    Result := RtfStream.DataString;
  FINALLY
    BlobStream.Free;
    RtfStream.Free;
  END;
END;

PROCEDURE TForm1.CheckSecondMonitor;
VAR
  mon: TMonitor;
BEGIN
  // Check if there's a second monitor
  IF screen.monitorCount > 1 THEN
  BEGIN
    mon := screen.Monitors[1];
    // Monitors[0] is the primary monitor, Monitors[1] is the second monitor, and so on.

    // Print the dimensions of the second monitor
    ShowMessageFmt('Second monitor: Width=%d, Height=%d',
      [mon.Width, mon.Height]);
    // MoveForm2ToSecondMonitor;
  END
  ELSE
    ShowMessage('There is no second monitor.');
END;

PROCEDURE TForm1.PositionFormOnSecondMonitor;
VAR
  MonitorBounds: TRect;
BEGIN
  IF screen.monitorCount > 1 THEN
  BEGIN
    // Get the bounds of the second monitor
    MonitorBounds := screen.Monitors[1].BoundsRect;

    // Position MyForm in the center of the second monitor
    Form4.Left := (MonitorBounds.Width - Form4.Width) DIV 2 +
      MonitorBounds.Left;
    Form4.Top := (MonitorBounds.Height - Form4.Height) DIV 2 +
      MonitorBounds.Top;

    // Show the form
    Form4.Show;
  END
  ELSE
    ShowMessage('Only one monitor detected!');
END;

PROCEDURE TForm1.FileListBox2Click(Sender: TObject);
BEGIN
  im_AdImage.Picture.LoadFromFile(FileListBox2.FileName);
END;

PROCEDURE TForm1.ShowThisImage(Sender: TObject; fName: STRING);
BEGIN
  Form4.Image1.Picture.LoadFromFile(fName);
  Form4.Image1.Repaint;
  PositionFormOnSecondMonitor;
END;

// End Monitor Code
// ------------------------------------------------------------------------------------------------

PROCEDURE TForm1.bt_TeseuDailyListClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  WITH Form2.qy_FR_Teseu1 DO
  BEGIN
    IF Active THEN
      Close;
    DataBaseName := 'DB_Main';
    SQL.Clear;
    s := 'SELECT Clients.ID, Clients.Alias, Clients.LastName, Clients.FirstName, '
      + ' Clients.IDTeseu, SUM(opledger.dare), COUNT(opLedger.Dare)* 25 as Tax '
      + ' FROM Clients INNER JOIN opLedger ON Clients.ID = opLedger.ClientID ' +
      ' WHERE (opLedger.FeeID = 3 OR opLedger.SubFeeid = 399) AND Clients.IDTeseu <> '''' '
      + ' AND OpLedger.Data BETWEEN CAST(' +
      QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) + ' AS Timestamp) '
      + 'AND CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', eDT)) +
      ' as Timestamp) ' + ' GROUP BY Clients.Lastname';
    SQL.Add(s);
    Active := True;

    IF RecordCount > 0 THEN
      what2Print3 := 'Clienti arrivati oggi da registrare nell''elenco TESEU '
    ELSE
      what2Print3 :=
        'Non ci sono nuovo clienti da registrare nell''elenco Teseu';
    frxReportTESEU.LoadFromFile(GetInstallDrive +
      '\Program Files (x86)\PGC_510 - Tokyo - Chiasso - CC\TeseuDailyList.fr3');
    IF frxReportTESEU.PrepareReport THEN
      frxReportTESEU.ShowPreparedReport;
    Active := False;
    UnPrepare;
  END;
END;

PROCEDURE TForm1.DoDestroy;
BEGIN
  // Twain.Free; // Don't forget to free Twain!

  // INHERITED;
END;

PROCEDURE TForm1.Edit1Change(Sender: TObject);
BEGIN
  Barcode1.InputText := Edit1.Text;
  ShowBarcode;
END;

PROCEDURE TForm1.DoCreate;
BEGIN
  INHERITED;

  Twain := TDelphiTwain.Create;
  Twain.OnTwainAcquire := TwainTwainAcquire;

  IF Twain.LoadLibrary THEN
  BEGIN
    // Load source manager
    Twain.SourceManagerLoaded := True;

    // ReloadSources;
  END
  ELSE
  BEGIN
    ShowMessage('Twain is not installed.');
  END;
END;

PROCEDURE TForm1.ExpandVCategories(Expand: Boolean);
BEGIN
  catAreExpanded := Expand;
  IF bt_ExpandCat.Tag = 1 THEN
  BEGIN
    FOR var I := 1 TO 9 DO
    BEGIN
      dbVgd_FeesEdit.RowCategories.CategoryProps.Items[I].DefaultExpanded
        := Expand;
    END;
    Form2.tb_FeeE.Refresh;
  END;
END;

{
  function TForm1.IsRaffleQRValid(const ATxID: string): Boolean;
  var
  Days: Integer;
  begin
  Result := False;
  With Form2 do
  begin
  if (Length(ATxID) <> 13) or
  Form2.tb_RafflePrice.FieldByName('ValidHowManyDays').IsNull then
  Exit;

  Days := Form2.tb_RafflePrice.FieldByName('ValidHowManyDays').AsInteger;

  qry_RaffleCheck.Close;
  qry_RaffleCheck.SQL.Text :=
  'SELECT COUNT(*) AS Cnt ' +
  'FROM ServicesSold ' +
  'WHERE TxID = :TxID ' +
  '  AND SoldDT >= :MinSoldDT';
  qry_RaffleCheck.ParamByName('TxID').AsString := ATxID;
  qry_RaffleCheck.ParamByName('MinSoldDT').AsDateTime := IncDay(Now, -Days);
  qry_RaffleCheck.Open;
  try
  Result := qry_RaffleCheck.FieldByName('Cnt').AsInteger > 0;
  finally
  qry_RaffleCheck.Close;
  end;
  end;
  end;
}

PROCEDURE TForm1.bt_TestMailClick(Sender: TObject);
var
  A, B, c: string;
begin
  // to finish
  A := ed_ToAddr.Text;
  B := ed_Subject.Text;
  c := ed_message.Text;
  TThread.CreateAnonymousThread(
    procedure
    begin
      // safely captured; lifetime is extended until the closure ends
      SendThisMail(A, B, c, ['C:\Users\Opas\Documents\Book1.pdf']);
    end).Start;
END;

procedure TForm1.SendThisMail(const toWhom, subject, bodyText: String;
const AttachFiles: TArray<String>);
var
  SMTP: TIdSMTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  msg: TIdMessage;
  Attachment: TIdAttachmentFile;
  I: Integer;
begin
  SMTP := TIdSMTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  msg := TIdMessage.Create(nil);
  try
    // — SSL / SMTP setup —
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;
    SSL.IPVersion := Id_IPv4;
    SMTP.IOHandler := SSL;
    SMTP.Host := ed_aHost.Text; // e.g. 'smtp.mail.yahoo.com'
    SMTP.Port := 465; // or 587
    SMTP.UseTLS := utUseImplicitTLS; // utUseExplicitTLS for STARTTLS
    SMTP.Username := ed_FromAddr.Text;
    SMTP.Password := ed_aPwd.Text;

    // — Build the message —
    msg.From.Address := SMTP.Username;
    msg.Recipients.EmailAddresses :=
      IfThen(toWhom = '', ed_ToAddr.Text, toWhom);
    msg.subject := subject;
    msg.Body.Text := bodyText;

    // — Attach files if any —
    try
      for I := Low(AttachFiles) to High(AttachFiles) do
      begin
        if not FileExists(AttachFiles[I]) then
          raise Exception.CreateFmt('Attachment not found: %s',
            [AttachFiles[I]]);
        TIdAttachmentFile.Create(msg.MessageParts, AttachFiles[I]);
      end;
    except
      on E: Exception do
      begin
        ed_eMsg.Text := E.Message;
        Exit; // stop further processing
      end;
    end;

    // — Send with error‐handling —
    try
      SMTP.Connect;
      try
        SMTP.Send(msg);
        ed_eMsg.Text := Format('Sent via %s successfully!', [SMTP.Host]);
      finally
        SMTP.Disconnect;
      end;
    except
      // catch any Indy errors (SMTP, socket, SSL, etc.)
      on E: EIdException do
        ed_eMsg.Text := Format('Mail error [%s]: %s', [E.ClassName, E.Message]);
      // fallback for everything else
      on E: Exception do
        ed_eMsg.Text := 'General error: ' + E.Message;
    end;
  finally
    msg.Free;
    SSL.Free;
    SMTP.Free;
  end;
end;

procedure TForm1.bt_TestPosTicketButtonClick(Sender: TObject);
begin
  Var
    PlaceholderDict: TDictionary<string, string>;
  PlaceholderDict := TDictionary<string, string>.Create;
  // Fill placeholders with data
  PlaceholderDict.Add('Description', 'Here goes a description');
  PlaceholderDict.Add('DrinkCredits', 'x');
  PlaceholderDict.Add('DrinkCreditValue', 'x');
  PlaceholderDict.Add('AmountToPrint', 'x.xx');
  PlaceholderDict.Add('TxID', 'ABC123DEF456X');
  PlaceholderDict.Add('Alias', 'Marylin');
  PlaceholderDict.Add('FirstName', 'Mata');
  PlaceholderDict.Add('LastName', 'Hari');
  PlaceholderDict.Add('Simic', '1234567890');
  PlaceholderDict.Add('IDTeseu', '0987654321');
  PlaceholderDict.Add('DateNow', '01.01.1900');
  // Create test ticket
  PopulateStackPanelWithPlaceholders_2
    (Form2.tb_FeeE.FieldByName('PosPrintItems').AsString, PlaceholderDict);
end;

PROCEDURE TForm1.bt_TestTextClick(Sender: TObject);
BEGIN
  WriteTextFile(DateTimeToStr(Now) + ': Test Log');
END;

PROCEDURE TForm1.WriteTextFile(s: STRING);
VAR
  MyText: TStringList;
  FileName: STRING;
BEGIN
  FileName := ExtractFilePath(Application.ExeName) + '\Tmp.txt';
  MyText := TStringList.Create;
  TRY
    IF FileExists(FileName) THEN
      MyText.LoadFromFile(FileName);
    s := EnCrypt(s);
    MyText.Add(s);
    MyText.SaveToFile(FileName);
  FINALLY
    MyText.Free;
  END;
END;

PROCEDURE TForm1.Button23Click(Sender: TObject);
BEGIN
  IF 1 <= screen.monitorCount THEN
    Form7.ShowAds7(Trim(ed_DefMonImg_H.Text), 1);
END;

PROCEDURE TForm1.Button24Click(Sender: TObject);
BEGIN
  Form7.Close;
  IF 2 <= screen.monitorCount THEN
    Form8.ShowAds8(Trim(ed_DefMonImg_V.Text), 2);
END;

PROCEDURE TForm1.Button25Click(Sender: TObject);
VAR
  MyText: TStringList;
  FileName: STRING;
  I, n: Integer;
BEGIN
  FileName := ExtractFilePath(Application.ExeName) + 'Tmp.txt';
  MyText := TStringList.Create;
  mm_LogFile.Clear;
  TRY
    mm_LogFile.Lines.LoadFromFile(FileName);
    n := mm_LogFile.Lines.Count;
    FOR I := 0 TO n - 1 DO
    BEGIN
      MyText.Add(DeCrypt(mm_LogFile.Lines[I]));
    END;
    mm_LogFile.Clear;
    mm_LogFile.Lines := MyText;
  EXCEPT
    ON E: Exception DO
      ShowMessage('Error occurred: ' + E.Message);
  END;
END;

PROCEDURE TForm1.Button26Click(Sender: TObject);
VAR
  FileStream: TFileStream;
BEGIN
  IF MessageDlg('Confermi la cancellazione del log file?', mtCustom,
    [mbOK, mbCancel], 0) = mrOk THEN
  BEGIN
    FileStream := TFileStream.Create(ExtractFilePath(Application.ExeName) +
      '\Tmp.txt', fmCreate);
    TRY
      // The file is now empty
    FINALLY
      FileStream.Free;
    END;
    mm_LogFile.Clear;
  END;
END;

FUNCTION TForm1.GetDefaultPrinterName: STRING;
BEGIN
  IF (Printer.PrinterIndex > 0) THEN
  BEGIN
    Result := Printer.Printers[Printer.PrinterIndex];
  END
  ELSE
  BEGIN
    Result := '';
  END;
END;

procedure TForm1.bt_ShowCCtoGClick(Sender: TObject);
  procedure ShowFormNow(F: TCustomForm);
  begin
    F.Show;
    if F.WindowState = wsMinimized then
      F.WindowState := wsNormal;

    F.BringToFront;
    // F.SetActive;                 // activates inside your app
    SetForegroundWindow(F.Handle); // asks Windows to foreground it
  end;

begin
  IF CCtoG.Showing then
    CCtoG.Close
  else
    ShowFormNow(CCtoG);
end;

PROCEDURE TForm1.bt_StopAlarmSoundClick(Sender: TObject);
BEGIN
  sndPlaySound(NIL, SND_ASYNC);
END;

procedure TForm1.bt_ExpandFeesClick(Sender: TObject);
begin
  IF advSTP_FeeEdit.Left = 211 // It is wide
  then
  begin
    advSTP_FeeEdit.Left := 984; // set it to narrow
    advSTP_FeeEdit.Width := 926;
    dbgd_Fees_Edit.Width := 891;
    bt_ExpandFees.Left := 812;
    bt_edFeesHelp.Left := 846;
  end
  else
  begin
    advSTP_FeeEdit.Left := 211; // Else set it to wide
    advSTP_FeeEdit.Width := 1696;
    dbgd_Fees_Edit.Width := 1623;
    bt_ExpandFees.Left := 1585;
    bt_edFeesHelp.Left := 1619;
  end;
end;

procedure TForm1.bt_FeeHelpClick(Sender: TObject);
begin
  if not Assigned(frmHelp) then
    frmHelp := TfrmHelp.Create(Self);
  frmHelp.ShowHelpTopic('FeeHelpNew.html');

end;

PROCEDURE TForm1.bt_TestLedClick(Sender: TObject);
VAR
  ledToggleColor: shortstring;
BEGIN
  IF ledToggleColor = ledGreen THEN
    ledToggleColor := ledRed
  ELSE
    ledToggleColor := ledGreen;
  MGuardClient1.MgRecordType := 'C';
  MGuardClient1.MgCommandCode := '37';
  MGuardClient1.MgEventDescr := ledOff;
  MGuardClient1.MgDeviceAddress := '25'; // spogliatoio donne
  MGuardClient1.SendToMGuardSrv;
  Sleep(sleepTm);
  MGuardClient1.MgRecordType := 'C';
  MGuardClient1.MgCommandCode := '37';
  MGuardClient1.MgEventDescr := ledToggleColor;
  MGuardClient1.MgDeviceAddress := '25'; // spogliatoio donne
  MGuardClient1.SendToMGuardSrv;
  Sleep(sleepTm);
END;

PROCEDURE TForm1.Button4Click(Sender: TObject);
BEGIN
  me_RS485Log.Clear;
END;

PROCEDURE TForm1.ed_BalanceReminderExit(Sender: TObject);
BEGIN
  tm_List.Events.Items[1].Interval := ed_BalanceReminder.Value * 60000;
END;

procedure TForm1.ed_BarReal_CCChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

procedure TForm1.ed_BarReal_CHChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

procedure TForm1.ed_BarReal_EUChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

PROCEDURE TForm1.ed_CT_MonExit(Sender: TObject);
BEGIN
  UpdateBarSettings(Sender);
END;

PROCEDURE TForm1.UpdateBarSettings(Sender: TObject);
VAR
  yn: STRING;
BEGIN
  yn := BoolToStr(cb_VatTax.Checked, False);
  IF yn <> '0' THEN
    yn := '1';
  Form2.t_executequery('UPDATE Bar_Settings SET ' + 'CT_Sun = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Sun.Time)) + ' AS TIME), ' + 'CT_Mon = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Mon.Time)) + ' AS TIME), ' + 'CT_Tue = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Tue.Time)) + ' AS TIME), ' + 'CT_Wed = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Wed.Time)) + ' AS TIME), ' + 'CT_Thu = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Thu.Time)) + ' AS TIME), ' + 'CT_Fri = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Fri.Time)) + ' AS TIME), ' + 'CT_Sat = CAST(' +
    QuotedStr(TimeToStr(ed_CT_Sat.Time)) + ' AS TIME), ' + 'VatTax_YN = ' + yn +
    ', ' + 'VatTax = ' + floatToStr(ed_VatTax.Value) + ', ' + 'AmtMarchetta = '
    + floatToStr(ed_amtMarchetta.Value) + ', ' + 'MinSaleAmtMVat = ' +
    floatToStr(ed_minSaleAmtMVat.Value), 'DB_Bar', 'PGC_Bar', 'Bar_Settings');
END;

PROCEDURE TForm1.ed_ExchangeRateExit(Sender: TObject);
BEGIN
  IF excRate <> ed_ExchangeRate.Value THEN
    lb_Last_ER_Date.Caption := DateTimeToStr(Now);
END;

PROCEDURE TForm1.ed_QR_SizeChanging(Sender: TObject; NewValue: Integer;
VAR AllowChange: Boolean);
BEGIN
  IF ed_QR_Size.Value >= ed_QR_Size.MinValue THEN
  BEGIN
    img_QRcode.Width := ed_QR_Size.Value;
    img_QRcode.Height := ed_QR_Size.Value;
    // img_QRcode.Left := sh_QrCode.Left + (sh_QrCode.Width - img_QRcode.Width) DIV 2;
  END;
END;

PROCEDURE TForm1.ed_QR_SizeExit(Sender: TObject);
BEGIN
  IF ed_QR_Size.Value >= ed_QR_Size.MinValue THEN
  BEGIN
    img_QRcode.Width := ed_QR_Size.Value;
    img_QRcode.Height := ed_QR_Size.Value;
    // img_QRcode.Left := sh_QrCode.Left + (sh_QrCode.Width - img_QRcode.Width) DIV 2;
  END;
END;

procedure TForm1.ed_RecReal_CCChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

procedure TForm1.ed_RecReal_CHChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

procedure TForm1.ed_RecReal_EUChange(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

procedure TForm1.ed_RecReal_EUChangeValue(Sender: TObject);
var
  NumberBox: TNumberBox;
begin
  NumberBox := Sender as TNumberBox;

  if not IsNaN(NumberBox.Value) then
    xx_CalcCash(Sender);
end;

PROCEDURE TForm1.CenterImageInShape(Image: TImage; Shape: TShape);
BEGIN
  // Ensure the TImage is smaller than or equal to the TShape width
  IF Image.Width <= Shape.Width THEN
    Image.Left := (Shape.Width - Image.Width) DIV 2
  ELSE
    Image.Left := 0; // Optionally align to the left if the image is wider
END;

Function TForm1.CheckPermit(ClientID: Integer): Boolean;
Var
  DaysLeft: Integer;
  msg1, msg2: String;
begin
  // Check Permit situation
  // -------------------------------------------------------------------------
  If uClientStore.ThisClient.Permit = '90' Then
  begin
    With Form2.qy_TMP do
    begin
      If Active then
        Close;
      SQL.Clear;
      SQL.Text :=
        'SELECT IDNotifica, Max(DateOutTeseu) as D FROM ClientHistory ' +
        ' WHERE ClientID = ' + intToStr(uClientStore.ThisClient.ID) +
        ' GROUP BY ClientID';
      Active := True;
      If RecordCount = 0 Then
      begin
        msg1 := 'Non risulta nessuna notifica!';
        msg2 := 'Controlla e inoltra notifica.';
        Result := False;
      end
      else
      begin
        DaysLeft := DaysBetween(DateOf(Now),
          DateOf(FieldByName('D').AsDateTime));
        IF Not InRange(Now, StartDt, FieldValues['D']) Then
        begin
          msg1 := 'Ultima notifica: ' + FieldByName('IDNotifica').AsString +
            'del ' + FieldByName('D').AsString;
          msg2 := uClientStore.ThisClient.alias +
            ' non ha piú una valida notifica. Controlla';
          Result := False;
        end;
        If DaysLeft < 3 Then
        begin
          msg1 := 'Pochi giorni di permesso rimasti!';
          msg2 := 'Attenzione, il permesso scade tra ' + intToStr(DaysLeft) +
            ' giorno(i).';
        end;
        Result := True;
        If DaysLeft > 2 Then
        begin
          msg1 := '';
          msg2 := '';
          Result := True;
        end;
      end;
      If msg1 <> '' Then
        TaskDlgHelperF.TaskDlg_Default('CONTROLLO NOTIFICHE', msg1, msg2, 'OK',
          '', '', 'calendar48.ico');
    end;
  end;
end;

procedure TForm1.cg_CashierKeyboardClick(Sender: TObject);
begin
  IF Form2.tb_oTab.FieldByName('SubFeeID').AsInteger <>
    Form2.tb_Fees.FieldByName('SubID').AsInteger Then
    bt_CancelAll.Click;

  IF (Form2.tb_oTab.RecordCount = 0) Then
  begin
    // locate fee data
    // --------------------------------------------------------------------
    JvThread1.Execute(NIL);

    oTabRowCount := 0;
    showNumKeyB := True;
    // Check if valid card id
    // --------------------------------------------------------------------
    If ReadCardOnReader < 0 Then
      Exit;

    // Verify card
    // --------------------------------------------------------------------
    IF VerifyCard(uClientStore.ThisCard.cardID) < 0 then
      Exit;

    // Check client data
    // --------------------------------------------------------------------
    yy_CheckAllClientData('cg_CashierKeyboard', uClientStore.ThisCard.cardID);

    // Check client permit
    // --------------------------------------------------------------------
    If ckb_verifyPermit.Checked Then
    begin
      Var
      PermitOK := CheckPermit(uClientStore.ThisClient.ID);
      IF not PermitOK Then
      begin
        ShowMessage(uClientStore.ThisClient.alias +
          ' non ha una notifica valida. La registrazione viene interrotta');
        nnWriteCashierDisplay(0, False, clRed,
          'Registrazione interrotta per mancanza notifica!', 2);
        Exit;
      end;
    end;

    // Check if fee id ok for client id
    // -------------------------------------------------------------------
    If (uClientStore.ThisClient.balanceDue <= 0) Then
      yy_CheckIfFeeOK('cg_CashierKeyboard');
    bt_Cancel.Enabled := False;

    // Keep chf and euro fee values for autocorrect eventual multiclick paymethod error
    // -------------------------------------------------------------------
    aChf := Form2.tb_oTab.FieldByName('amountCHF').AsFloat;
    aEuro := Form2.tb_oTab.FieldByName('amountEuro').AsFloat;
  end
  else IF (Form2.tb_Fees.FieldByName('SubID')
    .AsInteger = Form2.tb_oTab.FieldByName('SubFeeID').AsInteger) AND
    (Form2.tb_Fees.FieldByName('MultiClick').AsBoolean = True) Then
  begin

    // Prepare fee to tab
    // ------------------------------------------------------------------
    If pc_MainPageC.ActivePageIndex = 0 Then
      xx_WriteFeeToOtab
    else
      Exit;

    // If multiClick and not all paymethods are set, then reset all paymethods in
    // order to evoid confusion
    // ------------------------------------------------------------------
    With Form2.qy_TMP do
    begin

      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS TotalFiltered, ' +
        'SUM(CASE WHEN AmountCHF IS NULL THEN 1 ELSE 0 END) AS NullCHF, ' +
        'SUM(CASE WHEN AmountEuro IS NULL THEN 1 ELSE 0 END) AS NullEuro ' +
        'FROM OpenTab WHERE AmountCHF IS NULL OR AmountEuro IS NULL');
      Active := True;
      If RecordCount > 0 Then
        IF FieldByName('nullCHF').AsInteger <> FieldByName('NullEuro')
          .AsInteger Then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE OpenTab ' + ' SET AmountCHF =  ' + ' CASE ' +
            ' WHEN EXISTS (SELECT 1 FROM OpenTab T WHERE T.AmountCHF IS NULL) '
            + ' THEN NULL ELSE AmountCHF END, ' + ' AmountEuro = ' + ' CASE ' +
            ' WHEN NOT EXISTS (SELECT 1 FROM OpenTab T WHERE T.AmountCHF IS NULL) '
            + ' AND EXISTS (SELECT 1 FROM OpenTab T2 WHERE T2.AmountEuro IS NULL) '
            + ' THEN NULL ELSE AmountEuro END, ' + ' PayMethod = ' + ' CASE ' +
            ' WHEN EXISTS (SELECT 1 FROM OpenTab T WHERE T.AmountEuro IS NULL) '
            + ' THEN ''CH'' ' +
            ' WHEN EXISTS (SELECT 1 FROM OpenTab T WHERE T.AmountCHF IS NULL) '
            + ' THEN ''EU'' ELSE PayMethod END ');
          ExecSQL;

          Form2.tb_oTab.Refresh;

        end;
    end;
    bt_Cancel.Enabled := Form2.tb_oTab.RecordCount > 1;
    nnWriteCashierDisplay(0, False, clWhite, intToStr(Form2.tb_oTab.RecordCount)
      + ' ' + Form2.tb_Fees.FieldByName('Description').AsString, 0);

  end;
end;

PROCEDURE TForm1.ed_ScannerFileNameDblClick(Sender: TObject);
BEGIN
  IF OpenDialog1.Execute THEN
  BEGIN
    OpenDialog1.Filter := '*.exe';
    ed_ScannerFileName.Text := OpenDialog1.FileName;
  END;
END;

PROCEDURE TForm1.ed_tmPrntTeseuListChange(Sender: TObject);
BEGIN
  clk_TeseuCkOut.AlarmHour := HourOf(ed_tmPrntTeseuList.Time);
  clk_TeseuCkOut.AlarmMinute := MinuteOf(ed_tmPrntTeseuList.Time);
END;

PROCEDURE TForm1.FeeCtrlGdPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
BEGIN
  IF INDEX = DBCtrlGrid.PanelIndex THEN
  BEGIN
    DBCtrlGrid.Font.Color := clRed;
    // DBCtrlGrid.Font.Style:= DBCtrlGrid.Font.Style + [fsBold];
  END
  ELSE
    DBCtrlGrid.Font.Color := $00FFB9B9;
END;

PROCEDURE TForm1.Resetsingolastanza1Click(Sender: TObject);
BEGIN
  ResetServices(False);
END;

PROCEDURE TForm1.ResetServices(all: Boolean);
VAR
  Str, queryStr: shortstring;
BEGIN
  IF all THEN
    Str := ' di tutte le stanze?'
  ELSE
    Str := ' della stanza ' + Form2.tb_Cassa_Services.FieldByName('ID')
      .AsString;

  IF MessageDlg('Stai per eseguire il reset' + Str + '. Confermi?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
  BEGIN
    WITH Form2.tb_Cassa_Services, MGuardClient1 DO
    BEGIN
      queryStr :=
        'UPDATE Services SET Door = True, Lights = False, Projector = False' +
        ', Alarm = False, CardInID = 0, LastAlias = null' +
        ', LastEventDT = CURRENT_TIMESTAMP' + ', LastEventDescr =  ' +
        QuotedStr('Reset manuale') + ' WHERE (ID = ' + FieldByName('ID')
        .AsString + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgDeviceAddress := FieldByName('Actuator').AsString;
      MgEventDescr := '1';
      MgCommandCode := '23';
      // relais off
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgDeviceAddress := FieldByName('Actuator').AsString;
      MgEventDescr := '2';
      MgCommandCode := '23';
      // relais off
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := 'CX';
      // led off
      MgDeviceAddress := Format('%.*d',
        [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := 'BX';
      // led green
      MgDeviceAddress := Format('%.*d',
        [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);
      SendToMGuardSrv;
      Sleep(sleepTm);

      c_ServiceOwnedByCardID_Arr[FieldByName('ID').AsInteger] := 0;
    END;
    Form2.tb_Cassa_Services.Refresh;
    Form2.tb_Services.Refresh;
  END;
END;

PROCEDURE TForm1.led_MG_ClientDblClick(Sender: TObject);
BEGIN
  nStartMguard(Sender);
END;

PROCEDURE TForm1.lb_fondoCassaCtrlDtBadgeClick(Sender: TObject);
BEGIN
  ShowMessage('Il fondo cassa deve essere controllato ogni settimana!');
END;

PROCEDURE TForm1.Image2DblClick(Sender: TObject);
BEGIN
  IF OpenPictureDialog1.Execute THEN
    IF FileExists(OpenPictureDialog1.FileName) THEN
      Image2.Picture.Graphic.LoadFromFile(OpenPictureDialog1.FileName)
    ELSE
      RAISE Exception.Create('File does not exist.');
END;

PROCEDURE TForm1.bt_pdRefreshClick(Sender: TObject);
BEGIN
  WITH dbgd_PagaDopo DO
  BEGIN
    Form2.qy_PagaDopo.Refresh;
    Refresh;
    SumList.RecalcAll;
  END;
END;

// ------------------------------------------------------------------------------
// Routines di servizio
// ------------------------------------------------------------------------------

FUNCTION TForm1.KillTask(exeFileName: STRING): Integer;
CONST
  PROCESS_TERMINATE = $0001;
VAR
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
BEGIN
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  WHILE Integer(ContinueLoop) <> 0 DO
  BEGIN
    IF ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(exeFileName)) OR (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(exeFileName))) THEN
      Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
        FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  END;
  CloseHandle(FSnapshotHandle);
END;

PROCEDURE TForm1.lb_monCountClick(Sender: TObject);
BEGIN
  lb_monCount.Caption := intToStr(screen.monitorCount);
END;

PROCEDURE TForm1.Solochidormedanoi1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := 'InHouse = True';
    Filtered := True;
  END;
END;

PROCEDURE TForm1.SoloPresenticompresoinresidenza1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := 'InHouse = True OR CheckedIn = True';
    Filtered := True;
  END;
END;

procedure TForm1.SoloRecenti1Click(Sender: TObject);
begin
  Form2.tb_ClientiClients.Filter := ' (NOT LastPresence IS NULL)';
  Form2.tb_ClientiClients.Filtered := True;
end;

procedure TForm1.bt_PrintCCtoGClick(Sender: TObject);
var
  Printer: TPrinter;
  PrinterName: string;
  Line, s: string;
  EntrataStr, UscitaStr: string;
  YPos, LineHeight, LineStep: Integer;
  LeftMargin, TopMargin, BottomMargin: Integer;
  EntrataValue, UscitaValue: Double;
  TotalEntrata, TotalUscita: Double;

  procedure NextLine(Count: Integer = 1);
  begin
    Inc(YPos, LineStep * Count);
    // Optional page-break protection (keeps a clean bottom margin)
    if YPos > (Printer.PageHeight - BottomMargin) then
    begin
      Printer.NewPage;
      YPos := TopMargin;
    end;
  end;

const
  MaxNameLength: Integer = 10;
begin
  with Form2.qy_CashToClients do
  begin
    if not Active then
    begin
      ShowMessage('The query qy_CashToClients is not active!');
      Exit;
    end;

    // Get the printer instance
    Printer := GetMyPrinter;
    PrinterName := Printer.Printers[Printer.PrinterIndex];
    // if you need it elsewhere

    Printer.BeginDoc;
    try
      // --- FONT & SPACING SETUP ---
      Printer.Canvas.Font.Name := 'Lucida Console';
      // Monospaced font for alignment
      Printer.Canvas.Font.Size := 9;

      LineHeight := Printer.Canvas.TextHeight('X');
      LineStep := Round(LineHeight * 1.35);
      // <-- increase this factor for more/less line spacing
      LeftMargin := 10;
      TopMargin := 20;
      BottomMargin := LineStep * 4;
      // <-- keeps ~4 blank lines at the end of the page

      YPos := TopMargin;

      // --- HEADER ---
      case rg_cash2client.ItemIndex of
        0:
          s := '*** Ricapitolazione Clienti ***';
        1:
          s := '*** Dettaglio Clienti ***';
        2:
          s := '*** Dettaglio Club ***';
      end;
      Printer.Canvas.TextOut(LeftMargin, YPos, s);
      NextLine(2);

      Printer.Canvas.TextOut(LeftMargin, YPos, lb_Period.Caption);
      NextLine(2);

      // Column Header
      if FindField('Data') <> nil then
        Printer.Canvas.TextOut(LeftMargin, YPos, Format('%-5s %-12s %-8s %-8s',
          ['Data', 'Nome', 'Entrata', 'Uscita']))
      else
        Printer.Canvas.TextOut(LeftMargin, YPos, Format('%-12s %-8s %-8s',
          ['Nome', 'Entrata', 'Uscita']));
      NextLine;

      Printer.Canvas.TextOut(LeftMargin, YPos, StringOfChar('-', 60));
      NextLine;

      // --- TOTALS INIT ---
      TotalEntrata := 0;
      TotalUscita := 0;

      // --- DETAIL LINES ---
      First;
      while not EOF do
      begin
        if not FieldByName('Entrata').IsNull then
          EntrataValue := FieldByName('Entrata').AsFloat
        else
          EntrataValue := 0;

        if not FieldByName('Uscita').IsNull then
          UscitaValue := FieldByName('Uscita').AsFloat
        else
          UscitaValue := 0;

        // Add to totals
        TotalEntrata := TotalEntrata + EntrataValue;
        TotalUscita := TotalUscita + UscitaValue;

        // Format numbers (blank if zero)
        if EntrataValue <> 0 then
          EntrataStr := Format('%8.0f', [EntrataValue])
        else
          EntrataStr := '        ';

        if UscitaValue <> 0 then
          UscitaStr := Format('%8.0f', [UscitaValue])
        else
          UscitaStr := '        ';

        // Compose line
        if FindField('Data') <> nil then
          Line := Format('%-5s %-12s %s %s',
            [FormatDateTime('dd/mm', FieldByName('Data').AsDateTime),
            Copy(FieldByName('Name').AsString, 1, MaxNameLength), EntrataStr,
            UscitaStr])
        else
          Line := Format('%-12s %s %s', [Copy(FieldByName('Name').AsString, 1,
            MaxNameLength), EntrataStr, UscitaStr]);

        Printer.Canvas.TextOut(LeftMargin, YPos, Line);
        NextLine;

        Next;
      end;

      // --- TOTALS ---
      NextLine;
      Printer.Canvas.TextOut(LeftMargin, YPos, StringOfChar('-', 60));
      NextLine;

      Line := Format('%-12s %8.0f %8.0f', ['Totali:', TotalEntrata,
        TotalUscita]);
      Printer.Canvas.TextOut(LeftMargin, YPos, Line);

      // --- FOOTER ---
      NextLine(2);
      Printer.Canvas.TextOut(LeftMargin, YPos,
        '*** Printed: ' + DateTimeToStr(Now) + ' ***');

      // Optional: a little extra padding at very end (can be omitted; BottomMargin already ensures whitespace)
      NextLine(1);

    finally
      Printer.EndDoc;
    end;
  end;
end;

// ===========================================================================
//  Unit of Form1 — ticket fitted to the 80 mm roll (approx. 38 visible chars
//  at Lucida Console 9 pt). Everything is laid out in 37 chars.
// ===========================================================================

function CurrLabel(const APaymethod: string): string;
begin
  if SameText(Trim(APaymethod), 'EU') then
    Result := 'EU'
  else
    Result := 'CH';
end;

Procedure TForm1.PrintCCCashtoGClick(workingDayPeriod: String);
const
  PW = 37; // printable width in characters

  // c1 = 5  (dd-mm)        Data Carta
  // c2 = 5  (Importo)
  // c3 = 2  (CH / EU)
  // c4 = 11 (dd-mm hh:nn)  Data/Ora Busta
  // c5 = 5  (dd-mm)        Pagto Raga.
  // c6 = 4  (ClientID)
  // 5+1+5+1+2+1+11+1+5+1+4 = 37
  LineFmt = '%-5s %5s %-2s %-11s %-5s %-4s';

  // Totals: label 18 | CHF 9 | EUR 9  = 36
  TotFmt = '%-18s%9s %9s';
Var
  Printer: TPrinter;
  PrinterName: string;
  Line: string;
  UscitaStr, CurStr: string;
  YPos, LineHeight: Integer;
  UscitaValue: Double;
  sum1010CHF, sum1010EUR: Double;
  sum2900CHF, sum2900EUR: Double;
  ADate, bdate, ClientID: String;
  t1, t2, t3, t4: string;

  procedure PrintLn(const AText: string; ALines: Integer = 1);
  begin
    Printer.Canvas.TextOut(10, YPos, AText);
    Inc(YPos, LineHeight * ALines);
  end;

  function Amt(const AValue: Double): string;
  begin
    Result := Format('%.2n', [AValue]);
  end;

begin
  Form2.Update_Qy_1010_GCC(workingDayPeriod,
    sum1010CHF, sum1010EUR, sum2900CHF, sum2900EUR);

  With Form2.qy_1010_GCC do
  begin
    Printer := GetMyPrinter;
    PrinterName := Printer.Printers[Printer.PrinterIndex];

    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Lucida Console'; // monospaced for alignment
      Printer.Canvas.Font.Size := 9;
      LineHeight := Printer.Canvas.TextHeight('X');
      YPos := 20;

      // ---- Header -------------------------------------------------------
      t1 := Copy(lb_Period.Caption, 1, 14);
      t2 := Copy(lb_Period.Caption, 24, 14);
      t3 := Copy(lb_Period.Caption, 16, 8);
      t4 := Copy(lb_Period.Caption, 39, 8);

      PrintLn('Movimento contanti CC ragazze');
      PrintLn(StringOfChar('*', PW), 2);

      PrintLn(t1 + '  ' + t3);
      PrintLn(t2 + '  ' + t4, 2);

      // ---- Column header ------------------------------------------------
      PrintLn(Format(LineFmt, ['Data',  'Imp', 'Va', 'Data/Ora', 'Pagto', 'ID']));
      PrintLn(Format(LineFmt, ['Carta', '',    '',   'Busta',    'Raga.', 'Cli.']));
      PrintLn(StringOfChar('-', PW));

      // ---- Rows ---------------------------------------------------------
      First;
      while not EOF do
      begin
        If not FieldByName('Dare1000').IsNull then
          UscitaValue := FieldByName('Dare1000').AsFloat
        else
          UscitaValue := 0;

        CurStr := CurrLabel(FieldByName('Paymethod').AsString);

        if FieldByName('Data1010').IsNull then
          ADate := StringOfChar('-', 11)
        else
          ADate := FormatDateTime('dd-mm hh:nn',
            FieldByName('Data1010').AsDateTime);

        if FieldByName('LastData2900').IsNull then
          bdate := '-----'
        else
          bdate := FormatDateTime('dd-mm',
            FieldByName('LastData2900').AsDateTime);

        if FieldByName('ClientID').IsNull then
          ClientID := ''
        else
          ClientID := Copy(FieldByName('ClientID').AsString, 1, 4);

        if UscitaValue <> 0 then
          UscitaStr := Format('%5.0n', [UscitaValue])
        else
          UscitaStr := '';

        Line := Format(LineFmt,
          [FormatDateTime('dd-mm', FieldByName('Data1000').AsDateTime),
           UscitaStr, CurStr, ADate, bdate, ClientID]);
        PrintLn(Line);

        Next;
      end;

      // ---- Totals (CHF | EUR) -------------------------------------------
      Inc(YPos, LineHeight);
      PrintLn(StringOfChar('-', PW));

      PrintLn(Format(TotFmt, ['', 'CHF', 'EUR']));
      PrintLn(Format(TotFmt, ['Totale Buste:',   Amt(sum1010CHF), Amt(sum1010EUR)]));
      PrintLn(Format(TotFmt, ['Totale Diretto:', Amt(sum2900CHF), Amt(sum2900EUR)]));
      PrintLn(Format(TotFmt, ['', '---------', '---------']));
      PrintLn(Format(TotFmt, ['Prelevato incasso:',
        Amt(sum1010CHF + sum2900CHF), Amt(sum1010EUR + sum2900EUR)]));

      // ---- Footer -------------------------------------------------------
      Inc(YPos, LineHeight * 2);
      PrintLn('*** ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now) + ' ***', 2);
      PrintLn('Osservazioni:', 2);
      PrintLn(cashier, 10);
      PrintLn(StringOfChar('-', PW));
    finally
      Printer.EndDoc;
    end;
  end;
end;

(*
  Procedure TForm1.PrintCCCashtoGClick(workingDayPeriod: String);
  Var
    Printer: TPrinter;
    PrinterName: string;
    Line, s: string;
    NameStr, EntrataStr, UscitaStr: string;
    YPos, LineHeight: Integer;
    UscitaValue: Double;
    TotalUscita: Double;
    sum1010, sum2900: Double;
    ADate, bdate, ClientID: String;
  const
    // LineFmt = '%-6s %-8s %-6s %-6s %-6s';
    LineFmt = '%-5s %6s %-11s %-5s %-8s';
    // c1   c2    c3     c4    c5
    // c1 = 5  (dd/mm)
    // c2 = 6  (Importo)
    // c3 = 11 (dd-mm hh:nn)
    // c4 = 5  (dd/mm)
    // c5 = 8  (ID / ClientID)

  begin
    Form2.Update_Qy_1010_GCC(workingDayPeriod, sum1010, sum2900);
    With Form2.qy_1010_GCC do
    begin
      // Get the printer instance
      Printer := GetMyPrinter;
      PrinterName := Printer.Printers[Printer.PrinterIndex];

      Printer.BeginDoc;
      try
        Printer.Canvas.Font.Name := 'Lucida Console';
        // Monospaced font for alignment
        Printer.Canvas.Font.Size := 9;
        LineHeight := Printer.Canvas.TextHeight('X');
        // Dynamically calculate line height
        YPos := 20;

        s := 'Movimento contanti CC ragazze';
        Var
        t1 := Copy(lb_Period.Caption, 1, 14);
        Var
        t2 := Copy(lb_Period.Caption, 24, 14);
        Var
        t3 := Copy(lb_Period.Caption, 16, 8);
        Var
        t4 := Copy(lb_Period.Caption, 39, 8);
        Printer.Canvas.TextOut(10, YPos, s);
        Inc(YPos, LineHeight);
        Printer.Canvas.TextOut(10, YPos, StringOfChar('*', 60));
        Inc(YPos, LineHeight * 2);

        Printer.Canvas.TextOut(10, YPos, t1 + '  ' + t3);
        Inc(YPos, LineHeight);
        Printer.Canvas.TextOut(10, YPos, t2 + '  ' + t4);
        Inc(YPos, LineHeight * 2);

        // Column Header
        {
          Printer.Canvas.TextOut(10, YPos,
          Format(LineFmt, ['Data', 'Imp.', 'Data ', 'Pagto', 'ID']));
          Inc(YPos, LineHeight);
          Printer.Canvas.TextOut(10, YPos,
          Format(LineFmt, ['Carta', 'Carte', 'Busta', 'Raga.', 'Cliente']));
          Inc(YPos, LineHeight);
        }

        Printer.Canvas.TextOut(10, YPos,
          Format(LineFmt, ['Data', 'Imp', 'Data/Ora', 'Pagto', 'ID']));
        Inc(YPos, LineHeight);

        Printer.Canvas.TextOut(10, YPos, Format(LineFmt, ['Carta', '', 'Busta',
          'Raga.', 'Cliente']));
        Inc(YPos, LineHeight);

        Printer.Canvas.TextOut(10, YPos, StringOfChar('-', 60));
        Inc(YPos, LineHeight);

        // Initialize totals

        TotalUscita := 0;

        // Iterate through the query results
        First;
        while not EOF do
        begin
          If not FieldByName('Dare1000').IsNull then
            UscitaValue := FieldByName('Dare1000').AsFloat
          else
            UscitaValue := 0;

          if FieldByName('Data1010').IsNull then
            ADate := StringOfChar('-', 11)
          else
            ADate := FormatDateTime('dd-mm hh:nn', FieldByName('Data1010')
              .AsDateTime);

          if FieldByName('LastData2900').IsNull then
            bdate := '-----'
          else
            bdate := FormatDateTime('dd/mm', FieldByName('LastData2900')
              .AsDateTime);

          if FieldByName('ClientID').IsNull then
            ClientID := ''
          else
            ClientID := FieldByName('ClientID').AsString;

          // Add to totals
          TotalUscita := TotalUscita + UscitaValue;

          // Format strings

          if UscitaValue <> 0 then
            UscitaStr := Format('%6.0n', [UscitaValue]) // 6 chars
          else
            UscitaStr := StringOfChar(' ', 6);

          Line := Format(LineFmt,
            [FormatDateTime('dd/mm', FieldByName('Data1000').AsDateTime),
            UscitaStr, ADate, bdate, ClientID]);

          Printer.Canvas.TextOut(10, YPos, Line);

          Inc(YPos, LineHeight);

          Next;
        end;

        // Print Totals
        Inc(YPos, LineHeight);
        Printer.Canvas.TextOut(10, YPos, StringOfChar('-', 60));
        Inc(YPos, LineHeight);

        {
          Line := Format('%-16s %8.2n', ['Totale Carte:  ', TotalUscita]); // 2 decimals
          Printer.Canvas.TextOut(10, YPos, Line);
          Inc(YPos, LineHeight);
        }

        Line := Format('%-16s %8.2n', ['Totale Buste:      ', sum1010]);
        Printer.Canvas.TextOut(10, YPos, Line);
        Inc(YPos, LineHeight);

        Line := Format('%-16s %8.2n', ['Totale Diretto:    ', sum2900]);
        // 2 decimals
        Printer.Canvas.TextOut(10, YPos, Line);
        Inc(YPos, LineHeight);

        Line := Format('%-16s %-8s', ['                   ', '----------']); //
        Printer.Canvas.TextOut(10, YPos, Line);
        Inc(YPos, LineHeight);

        Line := Format('%-16s %8.2n', ['Prelevato incasso: ', sum1010 + sum2900]);
        // 2 decimals
        Printer.Canvas.TextOut(10, YPos, Line);
        Inc(YPos, LineHeight);

        // Footer
        Inc(YPos, LineHeight * 2);
        Printer.Canvas.TextOut(10, YPos, '*** Printed: ' + DateTimeToStr(Now)
          + ' ***');

        Inc(YPos, LineHeight * 2);
        Printer.Canvas.TextOut(10, YPos, 'Osservazioni:');

        Inc(YPos, LineHeight * 2);
        Printer.Canvas.TextOut(10, YPos, cashier);

        Inc(YPos, 10 * LineHeight);
        Printer.Canvas.TextOut(10, YPos, StringOfChar('-', 60));
      finally
        Printer.EndDoc;
      end;

    end;
  end;
*)

procedure TForm1.bt_DeleteUnredeemed_Click(Sender: TObject);
var
  Q: TEDBQuery;
  n: Integer;
begin
  Q := TEDBQuery.Create(nil);
  try
    Q.SessionName := Form2.PGC_Session.SessionName; // <-- your session
    Q.DataBaseName := Form2.DB_Main.DataBaseName; // <-- your database

    // how many would go
    Q.SQL.Text :=
      'SELECT COUNT(*) FROM "RaffleNumber" WHERE "RedeemedTxID" IS NULL';
    Q.Open;
    try
      n := Q.Fields[0].AsInteger;
    finally
      Q.Close;
    end;

    if n = 0 then
    begin
      ShowMessage('No unredeemed raffle numbers to delete.');
      Exit;
    end;

    if MessageDlg(Format('Delete %d unredeemed raffle numbers?', [n]),
      mtWarning, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    Q.SQL.Text := 'DELETE FROM "RaffleNumber" WHERE "RedeemedTxID" IS NULL';
    Form2.DB_Main.StartTransaction(['RaffleNumber']);
    try
      Q.ExecSQL;
      n := Q.RowsAffected;
      Form2.DB_Main.Commit;
    except
      Form2.DB_Main.Rollback;
      raise;
    end;

    ShowMessage(Format('%d raffle numbers deleted.', [n]));
  finally
    Q.Free;
  end;
end;

procedure TForm1.PrintRaffleTicket(const ACaption, ACode: string;
AWhen: TDateTime);
var
  Printer: TPrinter;
  DpiX, DpiY: Integer;
  PageW, YPos: Integer;
  Logo: TBitmap;
  Stamp: string;
const
  LogoWidthMM = 75.0; // printed logo width
  QrSizeMM = 18.0; // customer QR box; don't go below ~20 mm
  StubQrSizeMM = 12.0; // box-stub QR box
  FullFontSize = 48; // customer number, points
  StubFontSize = 36; // box-stub number, points
  TopMarginMM = 8.0;
  GapMM = 4.0;

  // ---------- unit helpers: millimetres -> printer pixels ----------
  function MMX(MM: Double): Integer;
  begin
    Result := Round(MM / 25.4 * DpiX);
  end;

  function MMY(MM: Double): Integer;
  begin
    Result := Round(MM / 25.4 * DpiY);
  end;

// ---------- horizontally centred text ----------
  procedure CenterOut(Y: Integer; const s: string);
  begin
    Printer.Canvas.TextOut((PageW - Printer.Canvas.TextWidth(s)) div 2, Y, s);
  end;

// ---------- TGraphic -> opaque 24-bit bitmap on white ----------
  function Flatten(AGr: TGraphic): TBitmap;
  begin
    Result := nil;
    if (AGr = nil) or AGr.Empty then
      Exit;

    Result := TBitmap.Create;
    try
      Result.PixelFormat := pf24bit;
      Result.SetSize(AGr.Width, AGr.Height);
      Result.Canvas.Brush.Color := clWhite;
      Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
      Result.Canvas.Draw(0, 0, AGr); // alpha-blended onto white
    except
      FreeAndNil(Result);
      raise;
    end;
  end;

// ---------- draw the QR held in img_QRcode; returns height drawn ----------
  function DrawQR(ATop, ABoxPx: Integer): Integer;
  var
    Src: TBitmap;
    scale, W, H: Integer;
  begin
    Result := 0;
    Src := Flatten(img_QRcode.Picture.Graphic);
    if Src = nil then
      Exit;
    try
      if Src.Width <= ABoxPx then
      begin
        // integer scale: each source pixel becomes a whole block => no blur
        scale := ABoxPx div Src.Width;
        W := Src.Width * scale;
        H := Src.Height * scale;
      end
      else
      begin
        // source bigger than the printed box: plain fit (can drop modules)
        W := ABoxPx;
        H := Round(Src.Height * (ABoxPx / Src.Width));
      end;

      SetStretchBltMode(Printer.Canvas.Handle, COLORONCOLOR); // replicate, don't smooth
      Printer.Canvas.StretchDraw(
        Rect((PageW - W) div 2, ATop, (PageW - W) div 2 + W, ATop + H), Src);

      Result := H;
    finally
      Src.Free;
    end;
  end;

// ---------- one ticket; AFull = customer copy, else raffle-box stub ----------
  procedure RenderTicket(AFull: Boolean);
  var
    ImgW, ImgH: Integer;
  begin
    DpiX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    DpiY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    PageW := Printer.PageWidth;
    Printer.Canvas.Brush.Style := TBrushStyle.bsClear;

    YPos := MMY(TopMarginMM);

    if AFull then
    begin
      // ----- logo -----
      if Assigned(Logo) then
      begin
        ImgW := MMX(LogoWidthMM);
        ImgH := Round(ImgW * (Logo.Height / Logo.Width)); // keep aspect ratio
        SetStretchBltMode(Printer.Canvas.Handle, HALFTONE);
        Printer.Canvas.StretchDraw(
          Rect((PageW - ImgW) div 2, YPos,
          (PageW - ImgW) div 2 + ImgW, YPos + ImgH), Logo);
        Inc(YPos, ImgH + MMY(GapMM));
      end;

      // ----- caption line -----
      Printer.Canvas.Font.Name := 'Arial';
      Printer.Canvas.Font.Style := [fsBold];
      Printer.Canvas.Font.Size := 12;
      CenterOut(YPos, ACaption);
      Inc(YPos, Printer.Canvas.TextHeight('X') + MMY(GapMM * 2));
    end;

    // ----- raffle number -----
    Printer.Canvas.Font.Name := 'Arial';
    Printer.Canvas.Font.Style := [fsBold];
    if AFull then
      Printer.Canvas.Font.Size := FullFontSize
    else
      Printer.Canvas.Font.Size := StubFontSize;
    CenterOut(YPos, ACode);
    Inc(YPos, Printer.Canvas.TextHeight(ACode) + MMY(GapMM));

    // ----- QR code -----
    if AFull then
      Inc(YPos, DrawQR(YPos, MMX(QrSizeMM)) + MMY(GapMM * 1.5))
    else
      DrawQR(YPos, MMX(StubQrSizeMM));

    {
      // ----- code text (customer copy only) -----
      if AFull then
      begin
      Printer.Canvas.Font.Name  := 'Arial';
      Printer.Canvas.Font.Style := [];
      Printer.Canvas.Font.Size  := 9;
      CenterOut(YPos, ACode);
      Inc(YPos, Printer.Canvas.TextHeight(ACode) + MMY(GapMM));
      end;
    }

    // ----- date / time stamp (customer copy only) -----
    if AFull then
    begin
      Printer.Canvas.Font.Style := [];
      Printer.Canvas.Font.Size := 8;
      CenterOut(YPos, Stamp);
    end;
  end;

begin
  Logo := Flatten(imgLotteryT.Picture.Graphic);
  try
    Printer := GetMyPrinter;
    if Printer.Printers.Count = 0 then
      raise Exception.Create('No printer installed.');

    Stamp := FormatDateTime('dd/mm/yyyy hh:nn:ss', AWhen);

    // ---- job 1: customer copy (cut happens at EndDoc) ----
    Printer.BeginDoc;
    try
      RenderTicket(True);
    finally
      Printer.EndDoc;
    end;

    // ---- job 2: raffle-box stub ----
    Printer.BeginDoc;
    try
      RenderTicket(False);
    finally
      Printer.EndDoc;
    end;
  finally
    Logo.Free;
  end;
end;

function TForm1.MakeQRBitmap(const AText: string): TBitmap;
begin
  Barcode1.InputText := AText; // regenerates Barcode1.Bitmap

  Result := TBitmap.Create;
  try
    Result.Assign(Barcode1.Bitmap); // independent copy; caller frees
    Result.PixelFormat := pf24bit; // opaque, same format as the other bitmaps
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TForm1.PrintRafflePrices(APriceImage: TGraphic;
const ADrawLine, AValidLine, AQRText: string; AWhen: TDateTime);
var
  Printer: TPrinter;
  DpiX, DpiY, PageW, YPos: Integer;
  Img, QrBmp: TBitmap;
const
  ImgWidthMM = 70.0; // printed prize image width
  ImgMaxHMM = 80.0; // cap on image height
  QrSizeMM = 15.0; // QR box; don't go below ~20 mm
  TopMarginMM = 8.0;
  GapMM = 4.0;

  // ---------- unit helpers: millimetres -> printer pixels ----------
  function MMX(MM: Double): Integer;
  begin
    Result := Round(MM / 25.4 * DpiX);
  end;

  function MMY(MM: Double): Integer;
  begin
    Result := Round(MM / 25.4 * DpiY);
  end;

// ---------- horizontally centred text line, advances YPos ----------
  procedure CenterLine(const s: string; ASize: Integer; AStyle: TFontStyles);
  begin
    Printer.Canvas.Font.Name := 'Arial';
    Printer.Canvas.Font.Size := ASize;
    Printer.Canvas.Font.Style := AStyle;
    Printer.Canvas.TextOut((PageW - Printer.Canvas.TextWidth(s)) div 2, YPos, s);
    Inc(YPos, Printer.Canvas.TextHeight(s) + MMY(GapMM));
  end;

// ---------- TGraphic -> opaque 24-bit bitmap on white ----------
  function Flatten(AGr: TGraphic): TBitmap;
  begin
    Result := nil;
    if (AGr = nil) or AGr.Empty then
      Exit;
    Result := TBitmap.Create;
    try
      Result.PixelFormat := pf24bit;
      Result.SetSize(AGr.Width, AGr.Height);
      Result.Canvas.Brush.Color := clWhite;
      Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
      Result.Canvas.Draw(0, 0, AGr); // alpha-blended onto white
    except
      FreeAndNil(Result);
      raise;
    end;
  end;

// ---------- prize image, centred, fitted in ImgWidthMM x ImgMaxHMM ----------
  procedure DrawImage;
  var
    W, H: Integer;
  begin
    if Img = nil then
      Exit;
    W := MMX(ImgWidthMM);
    H := Round(W * (Img.Height / Img.Width));
    if H > MMY(ImgMaxHMM) then
    begin
      H := MMY(ImgMaxHMM);
      W := Round(H * (Img.Width / Img.Height));
    end;
    SetStretchBltMode(Printer.Canvas.Handle, HALFTONE);
    Printer.Canvas.StretchDraw(
      Rect((PageW - W) div 2, YPos, (PageW - W) div 2 + W, YPos + H), Img);
    Inc(YPos, H + MMY(GapMM * 1.5));
  end;

// ---------- QR centred; QrBmp is 1 pixel per module ----------
  procedure DrawQR;
  var
    scale, W, H, Box: Integer;
  begin
    if QrBmp = nil then
      Exit;
    Box := MMX(QrSizeMM);
    if QrBmp.Width <= Box then
    begin
      // integer scale: each source pixel becomes a whole block => no blur
      scale := Box div QrBmp.Width;
      W := QrBmp.Width * scale;
      H := QrBmp.Height * scale;
    end
    else
    begin
      // source bigger than the printed box: plain fit (can drop modules)
      W := Box;
      H := Round(QrBmp.Height * (Box / QrBmp.Width));
    end;

    SetStretchBltMode(Printer.Canvas.Handle, COLORONCOLOR); // replicate, don't smooth
    Printer.Canvas.StretchDraw(
      Rect((PageW - W) div 2, YPos, (PageW - W) div 2 + W, YPos + H), QrBmp);
    Inc(YPos, H + MMY(GapMM * 1.5));
  end;

begin
  Img := nil;
  QrBmp := nil;
  try
    Img := Flatten(APriceImage); // nil-safe: no image => text and QR only
    QrBmp := MakeQRBitmap(AQRText);

    Printer := GetMyPrinter;
    if Printer.Printers.Count = 0 then
      raise Exception.Create('No printer installed.');

    Printer.BeginDoc;
    try
      DpiX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
      DpiY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
      PageW := Printer.PageWidth;
      Printer.Canvas.Brush.Style := TBrushStyle.bsClear;

      YPos := MMY(TopMarginMM);

      DrawImage;
      CenterLine(ADrawLine, 14, [fsBold]); // 'Estrazione del ...'
      CenterLine(AValidLine, 12, []); // 'Valido giorni ...'
      DrawQR; // RafflePrices.TxID
      CenterLine(AQRText, 9, []); // the QR content as readable text
      CenterLine(FormatDateTime('dd/mm/yyyy hh:nn:ss', AWhen), 8, []);
    finally
      Printer.EndDoc; // cut happens here
    end;
  finally
    QrBmp.Free;
    Img.Free;
  end;
end;

PROCEDURE TForm1.bt_DelBonMalIdFromFeeClick(Sender: TObject);
VAR
  s: STRING;
BEGIN
  WITH Form2, tb_FeeE DO
  BEGIN
    IF MessageDlg('Stai per eliminare ' + tb_BonMalFees.FieldByName
      ('Description').AsString + ' dal prezzo ' + FieldByName('Description')
      .AsString + '. Procedi? ', mtConfirmation, [mbYes, mbNo], 0, mbYes)
      = mrYes THEN
    BEGIN
      s := RemoveIntegerFromCSV(Trim(FieldByName('BonusMalusReference')
        .AsString), tb_BonMalFees.FieldByName('SubFeeID').AsInteger);
      Edit;
      IF s <> '' THEN
        FieldByName('BonusMalusReference').AsString := s
      ELSE
        FieldByName('BonusMalusReference').AsVariant := NULL;
      Post;
    END;
  END;
END;

FUNCTION TForm1.Str2HexStr(Str: shortstring): STRING;
VAR
  j: Integer;
  // Passaggio da stringa Asc con lunghezza N, a stringaHex con lunghezza doppia 2N.
BEGIN // input(2) $C0+$B4 -> output(4) 'C0B4'
  Result := ''; // input(2)   'SI'  -> output(4) '5349'
  FOR j := 1 TO Length(Str) DO
    Result := Result + HexToStr(byte(Str[j]))
END;

FUNCTION TForm1.HexToStr(H: byte): shortstring;
// $2B  ->  '2B'
CONST
  Hex: shortstring = '0123456789ABCDEF';
VAR
  t0, t1: byte;
BEGIN
  t0 := H SHR 4;
  t1 := H AND $0F;
  HexToStr := Hex[t0 + 1] + Hex[t1 + 1];
END;

PROCEDURE TForm1.MGuard1DataReceive(Sender: TObject);
VAR
  d_EventCode, d_DeviceAddress, d_DeviceName, d_readerID, d_ActuatorID,
    d_AbbaActuatorID, d_AbbaReaderID, d_LastEventDescr, d_alias, s, ss,
    ledColor: STRING;
  d_serviceID, d_FeeID, d_UsedClean, d_TotUse, d_BarCredit, d_CardInID,
    d_ClientInID, d_CardID, d_ClientID: smallInt;
  d_clLedgerID: Integer;
  d_privacy, Enabled: Boolean;

  n_cardID: Integer;
  // 28.2.2025 Was before nCardID global variable - Don't know yet if used in other parts

  dT: TDateTime;
  I: Integer;
LABEL
  GotoLabel;
BEGIN
  // important, otherwise on startup of app app crashes
  // ---------------------------------------------------------------------------
  if keepMGuardActive then
    // ShowMessage('keepMGuardActive : True')
  else
    ShowMessage('keepMGuardActive : False');
  IF Not keepMGuardActive THEN
  begin
    me_RS485Log.Lines.Add('EXIT');
    Exit
  end;
  // ----------------------------------------------------------------------------
  d_DeviceName := 'n/a';
  // ====================
  // G A T H E R  D A T A
  // ====================
  // Collect MGuard data  (if checkbox Testdata checked then
  // get ServiceID from tb_Cassa_Services and CardID from tb_Cassa_Cards)
  // ----------------------------------------------------------------------
  IF NOT cb_Testdata_.Checked THEN
  BEGIN
    d_DeviceAddress := MGuardClient1.MgDeviceAddress;
    // me_RS485Log.Lines.Add('DeviceAddress: ' + d_DeviceAddress);
    d_DeviceName := Copy(MGuardClient1.MgDeviceName, 1, 11);
    // me_RS485Log.Lines.Add('DeviceName RAW: ' + d_DeviceName);

    {
      me_RS485Log.Lines.Add('=== RAW MGUARD VALUES ===');
      me_RS485Log.Lines.Add('MgRecordType: [' + MGuardClient1.MgRecordType + ']');
      me_RS485Log.Lines.Add('MgDeviceType: ' + IntToStr(MGuardClient1.MgDeviceType));
      me_RS485Log.Lines.Add('MgDeviceAddress: [' + MGuardClient1.MgDeviceAddress + ']');
      me_RS485Log.Lines.Add('MgDeviceName: [' + MGuardClient1.MgDeviceName + ']');
      me_RS485Log.Lines.Add('MgEventType: ' + IntToStr(MGuardClient1.MgEventType));
      me_RS485Log.Lines.Add('MgEventCode: [' + MGuardClient1.MgEventCode + '] Len=' + IntToStr(Length(MGuardClient1.MgEventCode)));
      me_RS485Log.Lines.Add('MgEventData: [' + MGuardClient1.MgEventData + '] Len=' + IntToStr(Length(MGuardClient1.MgEventData)));
      me_RS485Log.Lines.Add('MgEventDescr: [' + MGuardClient1.MgEventDescr + '] Len=' + IntToStr(Length(MGuardClient1.MgEventDescr)));
      me_RS485Log.Lines.Add('MgCommandType: ' + IntToStr(MGuardClient1.MgCommandType));
      me_RS485Log.Lines.Add('MgCommandCode: [' + MGuardClient1.MgCommandCode + ']');
      me_RS485Log.Lines.Add('=========================');
    }

    IF Copy(d_DeviceName, 1, 8) = 'Actuator' THEN
      d_DeviceName := 'Actuator';
    IF Copy(d_DeviceName, 1, 11) = 'Card Reader' THEN
      d_DeviceName := 'CardReader';
    // me_RS485Log.Lines.Add('DeviceName PROCESSED: ' + d_DeviceName);
    d_EventCode := MGuardClient1.MgEventCode;
    // me_RS485Log.Lines.Add('EventCode: [' + d_EventCode + '] Length: ' + IntToStr(Length(d_EventCode)));
    // me_RS485Log.Lines.Add('EventCode Hex: ' + IntToHex(Ord(d_EventCode[1]), 2) + ' ' + IntToHex(Ord(d_EventCode[2]), 2));

    // me_RS485Log.Lines.Add('EventData RAW: [' + MGuardClient1.MgEventData + ']');
    d_CardID := StrToIntDef(Copy(MGuardClient1.MgEventData, 1, 4), 0);
    d_ClientID := StrToIntDef(Copy(MGuardClient1.MgEventData, 5, 4), 0);

    IF cb_lg485Evt.Checked THEN
    BEGIN
      me_RS485Log.Lines.Add(d_DeviceAddress);
      me_RS485Log.Lines.Add(d_DeviceName);
      me_RS485Log.Lines.Add(d_EventCode);
      me_RS485Log.Lines.Add(intToStr(d_CardID));
      me_RS485Log.Lines.Add(intToStr(d_ClientID));
      me_RS485Log.Lines.Add('---------');
    END;
  END
  ELSE
  BEGIN
    d_DeviceAddress := Form2.tb_Cassa_Services.FieldByName('Actuator').AsString;
    // d_DeviceName := 'Actuator';
    d_EventCode := tmpEvCd;
    d_CardID := StrToIntDef(ed_cCard.Text, 0);

    n_cardID := StrToIntDef(ed_cCard.Text, 0); // for new version
    WITH Form2.qy_TMP DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM Cards WHERE ID = ' + intToStr(d_CardID));
      Active := True;
      IF RecordCount > 0 THEN
        uClientStore.ThisClient.ID := FieldValues['ClientID']
      ELSE
        uClientStore.ThisClient.ID := 0;
    END;
  END;

  // Get room data
  // -------------
  WITH Form2 DO
  BEGIN
    WITH qy_TMP DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM Services ' + 'WHERE CardReader = ' +
        d_DeviceAddress + ' OR ' + 'Actuator = ' + d_DeviceAddress);
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        d_readerID := Format('%.*d',
          [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);
        d_ActuatorID := Format('%.*d',
          [2, StrToIntDef(FieldByName('Actuator').AsString, 0)]);
        d_serviceID := FieldByName('ID').AsInteger;
        c_RoomEnabled := FieldByName('Enabled').AsBoolean;
        d_privacy := FieldByName('Privacy').AsBoolean;
        d_FeeID := FieldByName('FeeID').AsInteger;
        d_UsedClean := FieldByName('UsedWithoutClean').AsInteger;
        d_TotUse := FieldByName('TotUse').AsInteger;
        d_LastEventDescr := FieldByName('LastEventDescr').AsString;
        IF FieldByName('CardInID').AsString <> NULL THEN
          d_CardInID := FieldByName('CardInID').AsInteger
        ELSE
          d_CardInID := 0;
        IF Length(c_ServiceOwnedByCardID_Arr) > 0 THEN
          c_ServiceOwnedByCardID_Arr[d_serviceID] := d_CardInID;
        Enabled := FieldByName('Enabled').AsBoolean;
        Active := False;
        IF (NOT Enabled) AND (d_CardID < 9000) THEN
          Exit;
      END;
    END;

    // Get client Data
    // ---------------
    IF (d_CardID > 6000) AND (d_CardID <= 6010) THEN
      d_alias := 'John Doe'
    ELSE
    BEGIN
      IF tb_Cards.Locate('ID', d_CardID, []) THEN
      BEGIN
        d_ClientID := 0;
        d_alias := '';
        IF tb_Cards.FieldByName('ClientID').AsInteger <> NULL THEN
        BEGIN
          IF tb_Clients.Locate('ID', tb_Cards.FieldByName('ClientID')
            .AsInteger, []) THEN
          BEGIN
            d_ClientID := tb_Clients.FieldByName('ID').AsInteger;
            d_alias := tb_Clients.FieldByName('Alias').AsString;
          END;
        END
        ELSE
          d_ClientID := 0;
      END;
    END;

    // A0: If event code A0 then write alarm info to cashier display
    // --------------------------------------------------------------
    IF d_EventCode = 'A0' THEN
    BEGIN
      IF tb_Cards.Locate('ID', d_CardInID, []) THEN
      BEGIN
        d_ClientInID := tb_Cards.FieldByName('ClientID').AsInteger;
        d_alias := tb_Clients.Lookup('ID', d_ClientInID, 'Alias');
      END;
      pl_Alarm.lb_RoomID.Caption := 'Camera: ' + intToStr(d_serviceID);
      pl_Alarm.lb_Alias.Caption := 'Cliente: ' + d_alias;
      pl_Alarm.Show;
      GOTO GotoLabel;
    END;

    // Lights on (new code 2/4/22 because old one not working ???
    // ----------------------------------------------------------
    // 95: Card inserted into inside reader
    // ------------------------------------
    IF d_EventCode = '95' THEN
    BEGIN
      WITH Form1 DO
      BEGIN
        WITH MGuardClient1 DO
        BEGIN
          MgRecordType := 'C';
          MgDeviceAddress := d_ActuatorID;
          MgEventDescr := '1';
          MgCommandCode := relaisOff;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgDeviceAddress := d_ActuatorID;
          MgEventDescr := '2';
          MgCommandCode := relaisOff;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgCommandCode := '37';
          MgEventDescr := ledOff;
          MgDeviceAddress := d_readerID;
          SendToMGuardSrv;
          Sleep(sleepTm);
        END;
        CASE d_CardInID OF
          9900 .. 9999:
            BEGIN
              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgDeviceAddress := d_ActuatorID;
                MgEventDescr := '1';
                MgCommandCode := relaisOn;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledRed;
                MgDeviceAddress := d_readerID;
                SendToMGuardSrv;
                Sleep(sleepTm);
              END;
              s := 'UPDATE Services SET Lights = True' + ' WHERE (CardReader = '
                + d_DeviceAddress + ' OR ACTUATOR = ' + d_DeviceAddress + ')';
              Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro',
                'Services');
              Sleep(sleepTm);
            END;
          9000 .. 9899:
            BEGIN
              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgDeviceAddress := d_ActuatorID;
                MgEventDescr := '1';
                MgCommandCode := relaisOn;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgDeviceAddress := d_ActuatorID;
                MgEventDescr := '2';
                MgCommandCode := relaisOn;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledGreen;
                MgDeviceAddress := d_readerID;
                SendToMGuardSrv;
                Sleep(sleepTm);
              END;
              s := 'UPDATE Services SET Lights = True' + ', Projector = True' +
                ' WHERE (CardReader = ' + d_DeviceAddress + ' OR ACTUATOR = ' +
                d_DeviceAddress + ')';
              ss := 'UPDATE CleanLog SET CardInside = CURRENT_TIMESTAMP' +
                ' WHERE (ServiceID = ' + intToStr(d_serviceID) +
                ' AND CardID = ' + intToStr(d_CardInID) + ')';
              Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro',
                'Services');
              // Sleep(sleepTm);
              Form2.t_executequery(ss, 'DB_Main', 'PGC_DB_Main_Euro',
                'CleanLog');
              Sleep(sleepTm);
            END;
          1000 .. 7999:
            BEGIN
              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgDeviceAddress := d_ActuatorID;
                MgEventDescr := '1';
                MgCommandCode := relaisOn;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledRed;
                MgDeviceAddress := d_readerID;
                SendToMGuardSrv;
                Sleep(sleepTm);
              END;
              s := 'UPDATE Services SET Lights = True' + ' WHERE (CardReader = '
                + d_DeviceAddress + ' OR ACTUATOR = ' + d_DeviceAddress + ')';
              Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro',
                'Services');

              // check if both rooms, 11 and 12, are busy. If so, then set connecting door led to red
              IF (((d_serviceID = 11) OR (d_serviceID = 12)) AND
                ((Form1.c_ServiceOwnedByCardID_Arr[11] <> 0) AND
                (Form1.c_ServiceOwnedByCardID_Arr[12] <> 0))) THEN
                WITH MGuardClient1 DO
                BEGIN
                  MgRecordType := 'C';
                  MgCommandCode := '37';
                  MgEventDescr := ledOff;
                  MgDeviceAddress := ConnXDoorReaderID;
                  SendToMGuardSrv;
                  Sleep(sleepTm);
                  MgRecordType := 'C';
                  MgCommandCode := '37';
                  MgEventDescr := ledRed;
                  MgDeviceAddress := ConnXDoorReaderID;
                  SendToMGuardSrv;
                  Sleep(sleepTm);
                END;
            END;
        END;
        // end case
      END;
      Exit;
    END;

    // Lights off (new code 2/4/22 because old one not working ???
    // ----------------------------------------------------------
    IF d_EventCode = '97' THEN
      WITH Form1.MGuardClient1 DO
      BEGIN
        MgRecordType := 'C';
        MgDeviceAddress := d_ActuatorID;
        MgEventDescr := '1';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgDeviceAddress := d_ActuatorID;
        MgEventDescr := '2';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        IF (InRange(d_CardID, 1000, 8999)) OR (c_RoomEnabled = False) THEN
          // verificare
          ledColor := ledRed
        ELSE
          ledColor := ledGreen;
        // set led color to green..
        MgRecordType := 'C';
        MgCommandCode := '37';
        MgEventDescr := ledColor;
        MgDeviceAddress := d_readerID;
        SendToMGuardSrv;
        Sleep(sleepTm);
        IF InRange(d_CardID, 9000, 9899) THEN
        BEGIN
          s := 'UPDATE Services SET Lights = False' + ', Projector = False' +
            ', CardInID = 0' + ' WHERE (CardReader = ' + d_DeviceAddress +
            ' OR ACTUATOR = ' + d_DeviceAddress + ')';
          ss := 'UPDATE CleanLog SET CardInsideOut = CURRENT_TIMESTAMP' +
            ', DeltaInOut = (CURRENT_TIMESTAMP - CardInside)MINUTE' +
            ' WHERE ServiceID = ' + intToStr(d_serviceID) + ' AND CardID = ' +
            intToStr(d_CardInID) + ' AND DeltaInOut = 0';
          Form2.t_executequery(ss, 'DB_Main', 'PGC_DB_Main_Euro', 'CleanLog');
        END
        ELSE IF (d_CardInID >= 9900) THEN
          s := 'UPDATE Services SET Lights = False' + ', Projector = False' +
            ', CardInID = 0' + ' WHERE (CardReader = ' + d_DeviceAddress +
            ' OR ACTUATOR = ' + d_DeviceAddress + ')'
        ELSE
          s := 'UPDATE Services SET Lights = False' + ', Projector = False' +
            ' WHERE (CardReader = ' + d_DeviceAddress + ' OR ACTUATOR = ' +
            d_DeviceAddress + ')';
        Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
        Sleep(sleepTm);
      END;
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    // If admin or cleaning card then act subito
    // -----------------------------------------
    IF InRange(d_CardID, 9000, 9999) THEN
      GOTO GotoLabel;

    // Check if client has valid Fee
    // -----------------------------
    WITH qy_SS DO
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      s := 'SELECT * FROM ServicesSold WHERE ClientID = ' + intToStr(d_ClientID)
        + ' AND FEEID = ' + intToStr(d_FeeID) + ' AND Valid = True ' +
        'AND SoldDt >= CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',
        sDt)) + ' AS Timestamp)';
      SQL.Add(s);
      Active := True;
      I := RecordCount;
      Active := False;
      IF I < 1 THEN
        Exit;
    END;

    // ===================================
    // H A N D L E  E V E N T  C O D E S
    // ===================================

    // 90 = Request to open door
    // -------------------------

    // Check if rights granted to open door
    // ------------------------------------
    IF d_LastEventDescr <> 'A L L A R M E' THEN
    BEGIN
      IF (d_EventCode = '90') AND (d_CardID > 0) AND (d_CardID <= 9999) THEN
      BEGIN
        // Exit if room not enabled and set led to red
        // -------------------------------------------
        IF NOT c_RoomEnabled THEN
        BEGIN
          WITH MGuardClient1 DO
          BEGIN
            MgRecordType := 'C';
            MgCommandCode := '37';
            MgEventDescr := ledOff;
            MgDeviceAddress := d_DeviceAddress;
            SendToMGuardSrv;
            Sleep(sleepTm);
            MgRecordType := 'C';
            MgCommandCode := '37';
            MgEventDescr := ledRed;
            MgDeviceAddress := d_DeviceAddress;
            SendToMGuardSrv;
            Sleep(sleepTm);
          END;
          Exit;
        END;

        // Open If admin or cleaning card
        // ------------------------------
        // Exit if room already occupied
        // -----------------------------
        IF (d_CardInID > 0) AND NOT((d_CardInID >= 9000) AND (d_CardID <= 9999))
          AND (d_CardInID <> d_CardID) THEN
          Exit;

        // ------------------------------------------------------------------------
        // ------------------------------------------------------------------------

        // Exit if client has abbandoned other room and too much time passed
        // ------------------------------------------------------------------
        IF d_CardInID = 0 THEN
        BEGIN
          WITH Form2.qy_SS DO
          BEGIN
            (*
              IF Active THEN
              Close;
              SQL.Clear;
              s := 'SELECT * FROM ServicesSold WHERE CardID = ' + intToStr(d_CardID) +
              ' AND FeeID = ' + intToStr(d_FeeID) + ' AND Valid = True ' +
              'AND CheckedOut = False AND StartUse IS NOT NULL ' +
              'AND StartUSE >  CAST(' + QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss', sDt)) + ' AS TIMESTAMP)';
              SQL.Add(s);
              Active := True;
              IF RecordCount > 0 THEN
              BEGIN
              dT := FieldValues['StartUse'];
              IF (d_CardInID = 0) AND (d_readerID <> LoungeReaderID) AND
              (MinutesBetween(now, FieldValues['StartUse']) > ed_Minutes2ChangeRoom.Value) THEN
              EXIT;
              END;
            *)
          END;

          // Check if client has abbandoned another room. In this case set abbandoned led to green
          // --------------------------------------------------------------------------------------
          WITH tb_Services DO
          BEGIN
            IF Locate('CardInID', d_CardID, []) THEN
            BEGIN
              d_AbbaActuatorID :=
                Format('%.*d',
                [2, StrToIntDef(FieldByName('Actuator').AsString, 0)]);
              d_AbbaReaderID :=
                Format('%.*d',
                [2, StrToIntDef(FieldByName('CardReader').AsString, 0)]);

              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledOff;
                MgDeviceAddress := d_AbbaReaderID;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledGreen;
                MgDeviceAddress := d_AbbaReaderID;
                SendToMGuardSrv;
                Sleep(sleepTm);
              END;
              Edit;
              FieldByName('LastEventDescr').AsString := 'Abbandonata';
              FieldByName('CardInID').AsInteger := 0;
              Post;
            END;
          END;
        END;
      END;
    END;
    // Lounge reader
    // -------------
    IF (d_EventCode = '90') AND (d_readerID = LoungeReaderID) THEN
    BEGIN
      IF d_CardID = 9899 THEN
        WITH MGuardClient1 DO
        BEGIN
          MgRecordType := 'C';
          MgDeviceAddress := LoungeActuatorID;
          MgEventDescr := '2';
          MgCommandCode := relaisOn;
          SendToMGuardSrv;
          Sleep(sleepTm);
        END;
      IF (d_CardID >= 9000) AND NOT(d_CardID = 9899) THEN
        WITH MGuardClient1 DO
        BEGIN
          MgRecordType := 'C';
          MgDeviceAddress := LoungeActuatorID;
          MgEventDescr := '1';
          MgCommandCode := relaisOn;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgDeviceAddress := LoungeActuatorID;
          MgEventDescr := '2';
          MgCommandCode := relaisOn;
          SendToMGuardSrv;
          Sleep(sleepTm);
        END;
      Exit;
    END;

    // 93: card extracted from outside reader
    // --------------------------------------
    IF d_EventCode = '93' THEN
    BEGIN
      IF d_readerID = LoungeReaderID THEN
      BEGIN
        WITH MGuardClient1 DO
        BEGIN
          MgRecordType := 'C';
          MgDeviceAddress := LoungeActuatorID;
          MgEventDescr := '1';
          MgCommandCode := relaisOff;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgDeviceAddress := LoungeActuatorID;
          MgEventDescr := '2';
          MgCommandCode := relaisOff;
          SendToMGuardSrv;
          Sleep(sleepTm);
        END;
        Exit;
      END;
    END;

    // 95: If event code 95 check if rights granted to turn on lights
    // --------------------------------------------------------------------------
    IF d_EventCode = '95' THEN
    BEGIN
      IF d_CardInID = 0 THEN
        Exit;
    END;

  GotoLabel:
    // Finally handle all the info in a thread
    // --------------------------------------------------------------------------
    HandleMicroGuardData(d_DeviceName, d_DeviceAddress, d_EventCode, d_readerID,
      d_ActuatorID, d_AbbaActuatorID, d_AbbaReaderID, d_alias, d_LastEventDescr,
      d_serviceID, d_UsedClean, d_FeeID, d_BarCredit, d_privacy, d_clLedgerID,
      d_CardID, d_CardInID, d_ClientID, d_TotUse);
  END;
END;

PROCEDURE TForm1.mm_AppHelpClick(Sender: TObject);
BEGIN

END;

// 0 = void room as used; 1 = void room as NOT used; 2 = Do nothing
PROCEDURE TForm1.mm_CashierSelectCell(Sender: TObject; ACol, ARow: Integer;
VAR CanSelect: Boolean);
BEGIN
  CanSelect := False;
END;

PROCEDURE TForm1.mn_ClientiClientsPopup(Sender: TObject);
BEGIN
  dbg_Clienti_Clients.SearchPanel.CancelSearchFilter;
  dbg_Clienti_Clients.SearchPanel.SearchingText := '';
END;

PROCEDURE TForm1.Mostrasoloclientiincasa1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := 'CheckedIN = True';
    Filtered := True;
  END;
END;

PROCEDURE TForm1.Mostratutti1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := '';
    Filtered := False;
  END;
END;

{ -------------------------------------------------------------------------------
  *Pad
  Ads a character at the end of the string until the length is equal to PadLen.
  If PadLen is negative the character will be inserted to the left.
  Example: Pad('hello',7)  > 'hello  '
  Example: Pad('hello',7,' ')  > 'hello  '
  Example: Pad('hello',-7,'.') > '..hello'
  Example: Pad('hello',1,'.') > 'hello'
  ------------------------------------------------------------------------------- }
FUNCTION TForm1.Pad(CONST s: STRING; PadLen: smallInt; c: Char = ' '): STRING;
BEGIN
  Result := s;
  IF PadLen < 0 THEN
  BEGIN
    WHILE Length(Result) < Abs(PadLen) DO
      Result := c + Result;
  END
  ELSE
  BEGIN
    WHILE Length(Result) < PadLen DO
      Result := Result + c;
  END;
END;

FUNCTION TForm1.TrimS(CONST s: shortstring): shortstring;
{ -Return a string with leading and trailing white space removed. }
VAR
  I: Cardinal;
  SLen: byte ABSOLUTE Result;
BEGIN
  Result := s;
  WHILE (SLen > 0) AND (Result[SLen] <= ' ') DO
    Dec(SLen);

  I := 1;
  WHILE (I <= SLen) AND (Result[I] <= ' ') DO
    Inc(I);
  Dec(I);
  IF I > 0 THEN
    Delete(Result, 1, I);
END;

PROCEDURE TForm1.Panel1DblClick(Sender: TObject);
BEGIN
  MGuardClient1.Active := True;
END;

PROCEDURE TForm1.pc_AdminChanging(Sender: TObject; FromPage, ToPage: Integer;
VAR AllowChange: Boolean);
BEGIN
  IF startUp THEN
  BEGIN
    AllowChange := True;
    Exit;
  END;

  CASE ToPage OF
    0:
      AllowChange := ClubAccPermissions.PersonnelP;
    1:
      AllowChange := ClubAccPermissions.ClientsP;
    2:
      AllowChange := ClubAccPermissions.CardsP;
    3:
      AllowChange := ClubAccPermissions.RoomsP;
    4:
      AllowChange := ClubAccPermissions.RS485P;
  END;
END;

PROCEDURE TForm1.pc_Clients_CalPageShow(Sender: TObject);
BEGIN
  cal_ClRoster.Date := encodeDate(YearOf(Today), Monthof(Today), 1);

END;

PROCEDURE TForm1.pc_Clients_DataPageShow(Sender: TObject);
BEGIN
  // mn_ClientiClients.Items[3].Enabled := True;
END;

PROCEDURE TForm1.pc_MainPageCChange(Sender: TObject);
BEGIN
  If Not(startUp) AND (CCtoG.Showing) Then
    CCtoG.Close;
  dbgd_TotServices.Visible := False;
  pc_Admin.ActivePage := pc_Clients_Page;
  dbgd_BarClosing.Columns[0].Footers[0].Value := '';
  pc_SettingDetailPage.ActivePageIndex := 0;
  if edRaffleQR.CanFocus then
    edRaffleQR.SetFocus;
END;

PROCEDURE TForm1.PrintFotoDelibera(Sender: TObject; PName: STRING;
TextAR: TStrings);
VAR
  myPrinter: TPrinter;
  Device: ARRAY [0 .. 255] OF Char;
  Driver: ARRAY [0 .. 255] OF Char;
  Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
  I: Word;
BEGIN
  Printer.PrinterIndex := Printer.Printers.IndexOf(PName);
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  myPrinter := Printer;
  WITH myPrinter DO
  BEGIN
    // Print Headers
    BeginDoc;
    Canvas.Font.Size := 18;
    Canvas.Font.Name := 'Trajan Pro';
    Canvas.Font.Style := [fsBold];

    Canvas.TextOut(20, 40, 'LIBERATORIA');
    Canvas.TextOut(20, 100, 'FOTOGRAFICA');

    Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Style := [];
    // Print text
    Canvas.Font.Size := 12;
    I := 0;
    WHILE I < TextAR.Count DO
    BEGIN
      Canvas.TextOut(20, 120 + (I * 30), TextAR.Strings[I]);
      Inc(I);
    END;
    EndDoc;
  END;
  // Print footers
  TextAR.Free;
END;

Procedure TForm1.UpdateSaliteStats;
Var
  StartDate, EndDate: TDateTime;
  Y, M, D: Word;
begin
  // If Not startUp then
  begin
    With Form2.qy_SaliteStats do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT ' + '  R.ClientID, ' + '  R.Alias, ' +
        '  R.d01 AS d01, ' + '  R.d02 AS d02, ' + '  R.d03 AS d03, ' +
        '  R.d04 AS d04, ' + '  R.d05 AS d05, ' + '  R.d06 AS d06, ' +
        '  R.d07 AS d07, ' + '  R.d08 AS d08, ' + '  R.d09 AS d09, ' +
        '  R.d10 AS d10, ' + '  R.d11 AS d11, ' + '  R.d12 AS d12, ' +
        '  R.d13 AS d13, ' + '  R.d14 AS d14, ' + '  R.d15 AS d15, ' +
        '  R.d16 AS d16, ' + '  R.d17 AS d17, ' + '  R.d18 AS d18, ' +
        '  R.d19 AS d19, ' + '  R.d20 AS d20, ' + '  R.d21 AS d21, ' +
        '  R.d22 AS d22, ' + '  R.d23 AS d23, ' + '  R.d24 AS d24, ' +
        '  R.d25 AS d25, ' + '  R.d26 AS d26, ' + '  R.d27 AS d27, ' +
        '  R.d28 AS d28, ' + '  R.d29 AS d29, ' + '  R.d30 AS d30, ' +
        '  R.d31 AS d31, ' + '  R.Entrate, ' + '  R.Standard, ' +
        '  R.Superior, ' + '  R.Suites ' + 'FROM ( ' + '  SELECT ' +
        '    c."ID" AS ClientID, ' + '    1 AS SortOrder, ' + '    c.Alias, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d01, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d02, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d03, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d04, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d05, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d06, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d07, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d08, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d09, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d10, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d11, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d12, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d13, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d14, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d15, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d16, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d17, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d18, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d19, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d20, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d21, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d22, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d23, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d24, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d25, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d26, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d27, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d28, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d29, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d30, ' +

        '    CASE ' +
        '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) > 0 THEN '
        + '           SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END) '
        + '      WHEN SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) > 0 THEN 0 '
        + '      ELSE NULL ' + '    END AS d31, ' +

        '    SUM(CASE WHEN c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END) AS Entrate, '
        + '    SUM(CASE WHEN c1.SubFeeID = 410 THEN 1 ELSE 0 END) AS Standard, '
        + '    SUM(CASE WHEN c1.SubFeeID IN (510,511) THEN 1 ELSE 0 END) AS Superior, '
        + '    SUM(CASE WHEN c1.SubFeeID = 610 THEN 1 ELSE 0 END) AS Suites ' +
        '  FROM c_1000 c1 ' + '  JOIN Clients c ON c."ID" = c1.ClientID ' +
        '  WHERE (EXTRACT(YEAR FROM c1.Data) = :pYear AND EXTRACT(MONTH FROM c1.Data) = :pMonth) '
        + '     OR (EXTRACT(YEAR FROM c1.Data) = CASE WHEN :pMonth = 12 THEN :pYear + 1 ELSE :pYear END '
        + '         AND EXTRACT(MONTH FROM c1.Data) = CASE WHEN :pMonth = 12 THEN 1 ELSE :pMonth + 1 END '
        + '         AND EXTRACT(DAY FROM c1.Data) = 1 ' +
        '         AND EXTRACT(HOUR FROM c1.Data) < 12) ' +
        '  GROUP BY c."ID", c.Alias ' +

        '  UNION ALL ' +

        '  SELECT ' + '    0 AS ClientID, ' + '    2 AS SortOrder, ' +
        '    ''Entrate Bar'' AS Alias, ' +
        '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9  AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.FeeID IN (1,2) THEN 1 ELSE 0 END), '
        + '    0 AS Entrate, 0 AS Standard, 0 AS Superior, 0 AS Suites ' +
        '  FROM c_1000 c1 ' +
        '  WHERE (EXTRACT(YEAR FROM c1.Data) = :pYear AND EXTRACT(MONTH FROM c1.Data) = :pMonth) '
        + '     OR (EXTRACT(YEAR FROM c1.Data) = CASE WHEN :pMonth = 12 THEN :pYear + 1 ELSE :pYear END '
        + '         AND EXTRACT(MONTH FROM c1.Data) = CASE WHEN :pMonth = 12 THEN 1 ELSE :pMonth + 1 END '
        + '         AND EXTRACT(DAY FROM c1.Data) = 1 ' +
        '         AND EXTRACT(HOUR FROM c1.Data) < 12) ' +

        '  UNION ALL ' +

        '  SELECT ' + '    0 AS ClientID, ' + '    3 AS SortOrder, ' +
        '    ''Entrate G'' AS Alias, ' +
        '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9  AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), '
        + '    0 AS Entrate, 0 AS Standard, 0 AS Superior, 0 AS Suites ' +
        '  FROM c_1000 c1 ' +
        '  WHERE (EXTRACT(YEAR FROM c1.Data) = :pYear AND EXTRACT(MONTH FROM c1.Data) = :pMonth) '
        + '     OR (EXTRACT(YEAR FROM c1.Data) = CASE WHEN :pMonth = 12 THEN :pYear + 1 ELSE :pYear END '
        + '         AND EXTRACT(MONTH FROM c1.Data) = CASE WHEN :pMonth = 12 THEN 1 ELSE :pMonth + 1 END '
        + '         AND EXTRACT(DAY FROM c1.Data) = 1 ' +
        '         AND EXTRACT(HOUR FROM c1.Data) < 12) ' +

        '  UNION ALL ' +

        '  SELECT ' + '    0 AS ClientID, ' + '    4 AS SortOrder, ' +
        '    ''Salite'' AS Alias, ' +
        '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=1  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=2  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=3  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=4  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=5  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=6  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=7  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=8  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=9  AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=10 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=11 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=12 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=13 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=14 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=15 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=16 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=17 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=18 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=19 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=20 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=21 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=22 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=23 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=24 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=25 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=26 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=27 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=28 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=29 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=30 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    SUM(CASE WHEN EXTRACT(DAY FROM c1.Data - INTERVAL ''12'' HOUR)=31 AND c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), '
        + '    0 AS Entrate, 0 AS Standard, 0 AS Superior, 0 AS Suites ' +
        '  FROM c_1000 c1 ' +
        '  WHERE (EXTRACT(YEAR FROM c1.Data) = :pYear AND EXTRACT(MONTH FROM c1.Data) = :pMonth) '
        + '     OR (EXTRACT(YEAR FROM c1.Data) = CASE WHEN :pMonth = 12 THEN :pYear + 1 ELSE :pYear END '
        + '         AND EXTRACT(MONTH FROM c1.Data) = CASE WHEN :pMonth = 12 THEN 1 ELSE :pMonth + 1 END '
        + '         AND EXTRACT(DAY FROM c1.Data) = 1 ' +
        '         AND EXTRACT(HOUR FROM c1.Data) < 12) ' + ') R ' +
        'ORDER BY R.SortOrder, R.Alias;';
      Params.ParamByName('pMonth').AsInteger := Monthof(cal_ClRoster.Date);
      Params.ParamByName('pYear').AsInteger := YearOf(cal_ClRoster.Date);
      Open;
      With Form2.qy_TMP do
      begin
        If Active Then
          Close;
        SQL.Clear;
        SQL.Text := 'SELECT ' +
          ' COALESCE(SUM(CASE WHEN c1.SubFeeID = 100 THEN 1 ELSE 0 END), 0) AS tE ,'
          + ' COALESCE(SUM(CASE WHEN c1.SubFeeID IN (310,315) THEN 1 ELSE 0 END), 0) AS tG, '
          + ' COALESCE(SUM(CASE WHEN c1.SubFeeID IN (410,510,511,610) THEN 1 ELSE 0 END), 0) AS tS '
          + ' FROM C_1000 c1  ' +
          ' WHERE EXTRACT(YEAR  FROM c1.Data - INTERVAL ''12'' HOUR) = :pYear '
          + ' AND EXTRACT(MONTH FROM c1.Data - INTERVAL ''12'' HOUR) = :pMonth';

        Params.ParamByName('pMonth').AsInteger := Monthof(cal_ClRoster.Date);
        Params.ParamByName('pYear').AsInteger := YearOf(cal_ClRoster.Date);
        Active := True;
        If RecordCount > 0 then
          UpdateGrid(FieldValues['tE'], FieldValues['tG'], FieldValues['tS']);
      end;
      // FillSaliteStatsGrid;
    end;
  end;
end;

procedure TForm1.UpdateGrid(eT, gT, sT: Integer);
const
  FIRST_DAY_COL = 2; // day 1
  LAST_DAY_COL = 32; // day 31
  COL_ENTRATE = 33;
  COL_STANDARD = 34;
  COL_SUPERIOR = 35;
  COL_SUITES = 36;
var
  Y, M, MaxDay, D, col: Integer;
  dT: TDateTime;
  dayName: string;
begin
  dbgd_SaliteStats.Columns.BeginUpdate;
  try
    Y := YearOf(cal_ClRoster.Date);
    M := Monthof(cal_ClRoster.Date);
    MaxDay := DaysInMonth(cal_ClRoster.Date); // 28..31

    // 1) show & label existing days
    for D := 1 to MaxDay do
    begin
      col := FIRST_DAY_COL + (D - 1); // day d -> column
      dT := encodeDate(Y, M, D);
      dayName := FormatDateTime('ddd', dT);

      dbgd_SaliteStats.Columns[col].Width := 40;
      dbgd_SaliteStats.Columns[col].Title.Caption := intToStr(D) + #13#10
        + dayName;
      dbgd_SaliteStats.Columns[col].Visible := True;
    end;

    // 2) hide the rest of the day columns
    for D := MaxDay + 1 to 31 do
    begin
      col := FIRST_DAY_COL + (D - 1); // still 2..32
      dbgd_SaliteStats.Columns[col].Title.Caption := '';
      dbgd_SaliteStats.Columns[col].Visible := False;
    end;

    // 3) format the fixed summary columns (after the days)

    dbgd_SaliteStats.Columns[0].Width := 80;
    dbgd_SaliteStats.Columns[1].Width := 100;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Width := 70;
    dbgd_SaliteStats.Columns[COL_STANDARD].Width := 70;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Width := 70;
    dbgd_SaliteStats.Columns[COL_SUITES].Width := 70;

    // add footers to those (only once is enough)
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers.Clear;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers.Add;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers.Add;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers.Add;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers.Add;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers[0].ValueType := fvtSum;
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers[1];
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers[2];
    dbgd_SaliteStats.Columns[COL_ENTRATE].Footers[3];

    dbgd_SaliteStats.Columns[COL_STANDARD].Footers.Clear;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers.Add;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers.Add;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers.Add;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers.Add;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[0].ValueType := fvtSum;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[1].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[2].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[3].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[1].Alignment :=
      taLeftJustify;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[2].Alignment :=
      taLeftJustify;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[3].Alignment :=
      taLeftJustify;
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[1].Value :=
      'Tot Entrate Bar';
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[2].Value := 'Tot Ragazze';
    dbgd_SaliteStats.Columns[COL_STANDARD].Footers[3].Value := 'Tot Salite';

    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers.Clear;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers.Add;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers.Add;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers.Add;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers.Add;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[0].ValueType := fvtSum;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[1].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[2].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[3].ValueType :=
      fvtStaticText;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[1].Alignment :=
      taRightJustify;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[2].Alignment :=
      taRightJustify;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[3].Alignment :=
      taRightJustify;
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[1].Value := intToStr(eT);
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[2].Value := intToStr(gT);
    dbgd_SaliteStats.Columns[COL_SUPERIOR].Footers[3].Value := intToStr(sT);

    dbgd_SaliteStats.Columns[COL_SUITES].Footers.Clear;
    dbgd_SaliteStats.Columns[COL_SUITES].Footers.Add;
    dbgd_SaliteStats.Columns[COL_SUITES].Footers[0].ValueType := fvtSum;

    dbgd_SaliteStats.SumList.RecalcAll;
  finally
    dbgd_SaliteStats.Columns.EndUpdate;
  end;
end;

Procedure TForm1.UpdatePresenceCalendar;
Var
  StartDate, EndDate: TDateTime;
  Y, M, D: Word;
begin
  With Form2.qy_Presence do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT ' + '  t."Alias", ' +
      '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=1  THEN t.DayCode END) AS "_01", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=2  THEN t.DayCode END) AS "_02", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=3  THEN t.DayCode END) AS "_03", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=4  THEN t.DayCode END) AS "_04", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=5  THEN t.DayCode END) AS "_05", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=6  THEN t.DayCode END) AS "_06", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=7  THEN t.DayCode END) AS "_07", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=8  THEN t.DayCode END) AS "_08", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=9  THEN t.DayCode END) AS "_09", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=10 THEN t.DayCode END) AS "_10", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=11 THEN t.DayCode END) AS "_11", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=12 THEN t.DayCode END) AS "_12", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=13 THEN t.DayCode END) AS "_13", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=14 THEN t.DayCode END) AS "_14", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=15 THEN t.DayCode END) AS "_15", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=16 THEN t.DayCode END) AS "_16", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=17 THEN t.DayCode END) AS "_17", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=18 THEN t.DayCode END) AS "_18", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=19 THEN t.DayCode END) AS "_19", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=20 THEN t.DayCode END) AS "_20", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=21 THEN t.DayCode END) AS "_21", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=22 THEN t.DayCode END) AS "_22", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=23 THEN t.DayCode END) AS "_23", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=24 THEN t.DayCode END) AS "_24", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=25 THEN t.DayCode END) AS "_25", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=26 THEN t.DayCode END) AS "_26", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=27 THEN t.DayCode END) AS "_27", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=28 THEN t.DayCode END) AS "_28", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=29 THEN t.DayCode END) AS "_29", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=30 THEN t.DayCode END) AS "_30", '
      + '  MAX(CASE WHEN EXTRACT(DAY FROM t.DayDate)=31 THEN t.DayCode END) AS "_31" '
      + 'FROM ( ' + '  SELECT ' +
      '    COALESCE(cl."Alias", ''ClientID='' || CAST(f."ClientID" AS VARCHAR(20))) AS "Alias", '
      + '    CAST(f."Data" AS DATE) AS DayDate, ' + '    CASE ' +
      '      WHEN SUM(CASE WHEN f.SubFeeId = 222 THEN 1 ELSE 0 END) > 0 ' +
      '           AND SUM(CASE WHEN f.SubFeeId IN (310,315) THEN 1 ELSE 0 END) > 0 THEN ''WD'' '
      + '      WHEN SUM(CASE WHEN f.SubFeeId = 222 THEN 1 ELSE 0 END) > 0 THEN ''D'' '
      + '      WHEN SUM(CASE WHEN f.SubFeeId IN (310,315) THEN 1 ELSE 0 END) > 0 THEN ''W'' '
      + '      ELSE '''' ' + '    END AS DayCode ' + '  FROM c_1000 f ' +
      '  LEFT JOIN Clients cl ON cl."ID" = f."ClientID" ' +
      '  WHERE f."Data" >= :pStart AND f."Data" < :pEnd ' +
      '    AND COALESCE(cl."Alias", ''ClientID='' || CAST(f."ClientID" AS VARCHAR(20))) <> ''Passante'' '
      + '  GROUP BY COALESCE(cl."Alias", ''ClientID='' || CAST(f."ClientID" AS VARCHAR(20))), CAST(f."Data" AS DATE) '
      + ') t ' + 'GROUP BY t."Alias" ';

    DecodeDate(cal_Clients.StartDate, Y, M, D);
    StartDate := encodeDate(Y, M, 1) + EncodeTime(12, 0, 0, 0);
    if M = 12 then
      EndDate := encodeDate(Y + 1, 1, 1) - 1
    else
      EndDate := encodeDate(Y, M + 1, 1) - 1;
    EndDate := Trunc(EndDate) + EncodeTime(23, 59, 59, 0);

    Params.ParamByName('pStart').AsDate := StartDate;
    Params.ParamByName('pEnd').AsDate := EndDate;
    Open;
    dbgd_Presence.Columns[0].Title.Font.Style := [fsBold];
    dbgd_Presence.Columns[0].Title.Caption := FormatDateTime('mmmm', StartDate);
    dbgd_Presence.Columns[0].Width := 100;
    dbgd_Presence.Refresh;
  end;
end;

PROCEDURE TForm1.pc_MainPageCChanging(Sender: TObject;
FromPage, ToPage: Integer; VAR AllowChange: Boolean);
VAR
  s: STRING;
  ResultValues: Variant;
BEGIN
  IF Not(startUp) And (cashier = '') Then
  begin
    AllowChange := False;
    Exit;
  end;
  // IF RR_Rooms.Showing THEN
  // RR_Rooms.Close;
  ShowHideBottomBtns(True, True, True, True);
  IF (FromPage = 1) AND ((scEH_FeeE.State = dsEdit) OR
    (scEH_FeeE.State = dsInsert)) THEN
    Form2.tb_FeeE.Post;

  IF NOT startUp THEN
  BEGIN
    IF NumKeyboard.Showing THEN
      NumKeyboard.Visible := False;
    IF RR_Rooms.Showing THEN
      RR_Rooms.Visible := False;
  END;

  CASE ToPage OF
    1: // Fees page
      BEGIN
        AllowChange := ClubAccPermissions.FeesP;
        dbrg_PosImageFormat.ItemIndex := 0;
        dbgd_FeesEdit.SelectedColor := clNavy;

        WITH Form2 DO
        BEGIN
          tb_FeeE.Locate('K', tb_Fees.FieldByName('K').AsInteger, []);
          // IF tb_FeeE.Locate('K', tb_Fees.FieldByName('K').AsInteger, [])then
          // tb_AdMonitors.Locate('SubfeeID', tb_Fees.FieldByName('SubID').AsInteger, []);
        END;
        IF ed_QR_Size.Value >= ed_QR_Size.MinValue THEN
        BEGIN
          img_QRcode.Width := ed_QR_Size.Value;
          img_QRcode.Height := ed_QR_Size.Value;
          // img_QRcode.Left := sh_QrCode.Left + (sh_QrCode.Width - img_QRcode.Width) DIV 2;
        END;

      END;

    2: // Settings page
      begin
        AllowChange := ClubAccPermissions.InterfaceSettings;
        dbgRafflePrice.Width := 617;
        dtp_RaffleDate.Date := Now;

      end;

    3: // Admin page
      BEGIN
        cal_Clients.SelectedDate := Today;
        cal_Clients.MaxDate := Today;
        Form2.AdminClientSAccountingFilter(sDt, eDT, Sender);
        dbgd_AdminClientsSS.Refresh;
        AllowChange := ClubAccPermissions.AdminP;
        // Update CheckedIndata
        WITH Form2.qy_TMP DO
        BEGIN
          Form2.DB_Main.StartTransaction(['Clients']);
          try
            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Add('UPDATE Clients c ' + 'SET CheckedIn = EXISTS ( ' +
              ' SELECT 1 FROM ServicesSold s ' +
              ' WHERE s.ClientID = c.ID AND s.FeeID = 3 AND s.Valid = TRUE)');
            ExecSQL;
            SQL.Clear;
            SQL.Add('UPDATE Clients c ' + 'SET InHouse = EXISTS ( ' +
              'SELECT 1 FROM RREU_Bookings b ' + 'WHERE b.GuestID = c.ID ' +
              'AND b.CheckOutDate IS NULL )');
            ExecSQL;
            Form2.DB_Main.Commit;
          except
            on E: Exception do
            begin
              // Roll back all changes if something goes wrong
              Database.Rollback;
              ShowMessage('Rolled back. An error in ReverseEntry occurred: ' +
                E.Message);
            end;
          end;
        END;

        // nSetgStats(IncDay(sDt, -30), eDT);
        gStatDays := 30;

        UpdatePresenceCalendar;

      END;
    4: // Maintenance page
      begin
        AllowChange := ClubAccPermissions.ManutP;
      end;

    5: // Closing
      BEGIN
        // ToPage := 5;
        rg_DayMode.ItemIndex := 0; // Work day hours not calendar
        tp_CCtoG.ActivePageIndex := 0;
        AllowChange := ClubAccPermissions.ClosingP > 0;
        // ed_TotWoutGCC.Visible := ClubAccPermissions.ClosingP >= 9;
        // ed_TotNetClub.Visible := ClubAccPermissions.ClosingP >= 9;
        Shape14.Visible := ClubAccPermissions.ClosingP >= 9;
        xx_ReadCard(xx_FromCardReader);
        xx_GetClientData(uClientStore.ThisCard.ClientID);
        IF uClientStore.ThisClient.alias <> '' THEN
          rg_ClubOrCards.Items[1] := uClientStore.ThisClient.alias
        ELSE
          rg_ClubOrCards.Items[1] := 'CLIENTS';
        cl_Closing_Cal.ShowCurrentDate := True;
        cl_Closing_Cal.MultiSelect :=
          ClubAccPermissions.LimitClosingCalDays > 1;
        cl_Closing_Cal.Date := DateOf(sDt);

        rg_ClubOrCards.ItemIndex := 0;
        rg_ClubOrCards.Enabled := InRange(uClientStore.ThisClient.cardID,
          3000, 5999);

        UpdateClosingPage(Sender, cl_Closing_Cal.StartDate,
          cl_Closing_Cal.EndDate);
        UpdateClosingTabStatus;

        // Check Fondo cassa control dates
        // -------------------------------
        With Form2.qy_FondoCassa do
        begin
          Active := True;
          If RecordCount > 0 Then
          begin
            Refresh;
            // Club Fondo cassa values
            ResultValues := Lookup('Paymethod;CostCenter',
              varArrayof(['CH', 'c']), 'Dare;Data');
            ed_RecFC_CH.Value := ResultValues[0];
            lb_RecFC_CH.Caption := DateToStr(ResultValues[1]);
            lb_RecFC_CH.BehaviorOptions.Active :=
              DaysBetween(Now, ResultValues[1]) > ed_FreqContrFondiCassa.Value;

            ResultValues := Lookup('Paymethod;CostCenter',
              varArrayof(['EU', 'c']), 'Dare;Data');
            ed_RecFC_EU.Value := ResultValues[0];
            lb_RecFC_EU.Caption := DateToStr(ResultValues[1]);
            lb_RecFC_EU.BehaviorOptions.Active :=
              DaysBetween(Now, ResultValues[1]) > ed_FreqContrFondiCassa.Value;

            // Bar fondo cassa values
            ResultValues := Lookup('Paymethod;CostCenter',
              varArrayof(['CH', 'b']), 'Dare;Data');
            ed_BarFC_CH.Value := ResultValues[0];
            lb_BarFC_CH.Caption := DateToStr(ResultValues[1]);
            lb_BarFC_CH.BehaviorOptions.Active :=
              DaysBetween(Now, ResultValues[1]) > ed_FreqContrFondiCassa.Value;

            ResultValues := Lookup('Paymethod;CostCenter',
              varArrayof(['EU', 'b']), 'Dare;Data');
            ed_BarFC_EU.Value := ResultValues[0];
            lb_BarFC_EU.Caption := DateToStr(ResultValues[1]);
            lb_BarFC_EU.BehaviorOptions.Active :=
              DaysBetween(Now, ResultValues[1]) > ed_FreqContrFondiCassa.Value;
          end;
        end;
      END;
    6: // Club Stats
      begin
        AllowChange := ClubAccPermissions.PersonnelP;
        // Form2.FillGridFromQuery;
        cal_ClRoster.Date := Now;
        UpdateSaliteStats;
        if (Now >= EncodeTime(0, 0, 0, 100)) and (Now < EncodeTime(12, 0, 0, 0))
        then
          xx_UpdateBarPage(Now, Now, YesterDay)
        else
          xx_UpdateBarPage(Now, Now, Tomorrow);
      end;
    7: // Bar Stats
      begin
        AllowChange := ClubAccPermissions.BarP > 0;
        With cal_Bar do
        begin
          Year := YearOf(Date);
          Month := Monthof(Date);
          SelectedDate := Date; // optional highlight
          Repaint;
        end;
      end;
  END;
END;

Procedure TForm1.UpdateClosingTabStatus;
begin
  IF Length(openPeriod_Arr) > 0 then
  begin
    pc_MainPageC.AdvSmoothTabPages[5].TabAppearance.Status.Visible := True;
    pc_MainPageC.AdvSmoothTabPages[5].TabAppearance.Status.OffsetLeft := 12;
    pc_MainPageC.AdvSmoothTabPages[5].TabAppearance.Status.Caption :=
      'Periodi aperti: ' + intToStr(Length(openPeriod_Arr)) + ' ';
  end
  else
    pc_MainPageC.AdvSmoothTabPages[5].TabAppearance.Status.Visible := False;
end;

procedure TForm1.utte1Click(Sender: TObject);
begin
  WITH Form2.tb_ClientiClients DO
  BEGIN
    Filter := '';
    Filtered := False;
  END;
end;

PROCEDURE TForm1.xx_FilterClosingTables(s: STRING);
BEGIN
  WITH Form2 DO
  BEGIN
    qy_1000_CH.Refresh;
    qy_1000_EU.Refresh;
    qy_1000_CC.Refresh;
    qy_1000_GCC.Refresh;

    qy_1000_CH.Filter := s;
    qy_1000_CH.Filtered := s <> '';
    qy_1000_EU.Filter := s;
    qy_1000_EU.Filtered := s <> '';
    qy_1000_CC.Filter := s;
    qy_1000_CC.Filtered := s <> '';
    qy_1000_CH.Last;
    dbgd_1000_CH.SumList.RecalcAll;

    qy_1000_EU.Last;
    dbgd_1000_EU.SumList.RecalcAll;

    qy_1000_CC.Last;
    dbgd_1000_CC.SumList.RecalcAll;

    qy_1000_GCC.Last;
    dbgd_1000_GCC.SumList.RecalcAll;
  END;
END;

PROCEDURE TForm1.nSetFeeWeekDayFilter;
VAR
  s: STRING;
BEGIN
  s := 'Enabled = True AND Appearance > 0';
  CASE DayOfWeek(DateOf(sDt)) OF
    1:
      s := s + ' AND Sun = True';
    2:
      s := s + ' AND Mon = True';
    3:
      s := s + ' AND Tue = True';
    4:
      s := s + ' AND Wed = True';
    5:
      s := s + ' AND Thu = True';
    6:
      s := s + ' AND Fri = True';
    7:
      s := s + ' AND Sat = True';
  ELSE
    s := 'Enabled = True AND Appearance > 0';
  END;
  WITH Form2.tb_Fees DO
  BEGIN
    Filter := s;
    Filtered := True;
  END;
END;

PROCEDURE TForm1.pc_RS485_PageShow(Sender: TObject);
BEGIN
  Form2.tb_Anomalies.Last;
END;

PROCEDURE TForm1.pc_Services_PageShow(Sender: TObject);
BEGIN
  Form2.qy_AdminServices_S.Refresh;
END;

PROCEDURE TForm1.HandleMicroGuardData(deviceName, deviceAddress, eventCode,
  readerID, actuatorID, abbaActuatorID, abbaReaderID, alias, lastEventDescr
  : STRING; serviceID, usedClean, feeID, barCredit: smallInt; privacy: Boolean;
ledgerID, cardID, cardInID, ClientID, totUse: Integer);

{
  //30 = handles re-entry request ?
  //90 = Card inserted in outside reader
  //93 = Card extracted from outside reader
  //95 = card inserted into inside reader
  //97 =  Card extracted from inside reader
  // AO = Alarm button on
  // A2 = Alarm button off
  // A6 = door is open
  // A4 = door is closed
  cmdGetDeviceList   = chr($10);  // comando locale (non va ai Microguards)
  cmdPing            = $1A;
  cmdGetDeviceInfo   = $1B;
  cmdRelayOn         = chr($20);
  cmdRelayOff        = chr($23);
  cmdRelayToggle     = chr($25);
  cmdGetIOStatus     = chr($30);  // risponde con 4 bytes di on/off.
  cmdGetANAStatus    = $33;       // risponde con 2 word  di valori analogici
  cmdSetParameter    = $35;       // per settare cfg in eeprom MGuard.
  cmdSetWarning      = chr($37);  // per controllare Led/Beeper.
  cmdEnterISP        = $3F;       // per far entrare divice in ISP boot loader !

  answDeviceList     = $80;
  answPingAnswer     = $8C;
  answIspReady       = $8D;
  answDeviceInfo     = $8E;
  answRelayOn        = $B0;
  answRelayOff       = $B3;
  answRelToggled     = $B5;
  answIOStatus       = $C0;
  answSetParameter   = $C5;
  answSetWarning     = $C7;
  answEnterISP       = $CF;

  eveCardIn          = chr($90);  // in Datamodule diventa $91 se anche Door opened !
  eveCardInDoorOpen  = chr($91);
  eveCardOut         = chr($93);
  eveCardInsideIn    = chr($95);
  eveCardInsideOut   = chr($97);
  EveButton          = chr($99);   // user button.
  eveSwitch1On       = chr($A0);
  eveSwitch1Off      = chr($A2);
  eveSwitch2On       = chr($A4);
  eveSwitch2Off      = chr($A6);


  const
  maxATmega32CodeArray  = 32768; // lunghezza array per Upload di Firmware su ATmega323
  maxATmegaEEpArray   = 2048;  //

  paramUnLock1      = '1';
  paramUnLock2      = '2';
  paramUnLock3      = '3';
  paramOneTimeSet   = '4';
  paramOneTimeReset = '5';
  paramRdPwd        = '6';
  paramWrPwd        = '7';
  paramSecRelay     = '8';
  paramLedRed       = 'A';
  paramLedGreen     = 'B';
  paramLedOff       = 'C';
  paramLedBlink     = 'D';
  paramNumBeeps     = 'E';
}
VAR
  queryStr, cLogQueryStr, tmps, ledColor: STRING;
  UwCl, TotU, totAbba: Integer;
BEGIN
  // clientID := intToStr(StrToIntDef(clientID, 0));
  // A= = Alarm event, sound alarm, write event timestamp and event descr,
  // blink reader led
  // ---------------------------------------------------------------------

  // A0: alarm event
  // ---------------
  IF eventCode = 'A0' THEN
  BEGIN
    overrideSound := True;
    c_alarmEvent := True;
    WITH Form2 DO
    BEGIN
      PlayASound(Form1.c_AlarmSound, True);
      tmps := ' / ' + DateTimeToStr(Now) + ': Allarme stanza ' +
        intToStr(serviceID);
      queryStr := 'UPDATE Services SET LastEventDT = CURRENT_TIMESTAMP,' +
        ' LastEventDescr = ' + QuotedStr('A L L A R M E') +
        ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
        deviceAddress + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      // Sleep(sleepTm);
      (*
        queryStr := 'UPDATE ClientHistory SET Remarks = Remarks + ' +
        QuotedStr(tmps) + ' WHERE ClientID = ' + intToStr(ClientID);
        Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      *)
      // Sleep(sleepTm);
      queryStr :=
        'INSERT INTO Anomalies (Where,ServiceID,What,CardID,Operator) ' +
        'VALUES (' + QuotedStr('Porta') + ',' + intToStr(serviceID) + ',' +
        QuotedStr('Allarme da: ' + alias) + ',' +
        intToStr(c_ServiceOwnedByCardID_Arr[serviceID]) + ',' +
        QuotedStr(Form1.cashier) + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
        'Anomalies');
      // Sleep(sleepTm);
    END;
    WITH MGuardClient1 DO
    BEGIN
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := ledOff;
      MgDeviceAddress := readerID;
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := ledBlink;
      MgDeviceAddress := readerID;
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgDeviceAddress := actuatorID;
      MgEventDescr := '2';
      MgCommandCode := relaisOn;
      SendToMGuardSrv;
    END;
  END;

  // A2: reset alarm event
  // ---------------------
  IF (eventCode = 'A2') AND (cardID > 8999) THEN
  BEGIN
    overrideSound := True;
    c_alarmEvent := True;
    WITH Form2 DO
    BEGIN
      sndPlaySound(NIL, SND_ASYNC);
      tmps := ' / ' + DateTimeToStr(Now) + ': Allarme disins.: ' +
        intToStr(serviceID);
      queryStr := 'UPDATE Services SET LastEventDT = CURRENT_TIMESTAMP,' +
        ' LastEventDescr = ' + QuotedStr('Allarme disins.') +
        ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
        deviceAddress + ')';
      Form2.t_executequery { TODO : ClLedger, ServicesSold, OpLedger, Services, Clients, Cards, Anomalies }
        (queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Sleep(sleepTm);
      (*
        queryStr := 'UPDATE ClientHistory SET Remarks = Remarks + ' +
        QuotedStr(tmps) + ' WHERE ClientID = ' + intToStr(ClientID);
        Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
        Sleep(sleepTm);
      *)
      queryStr :=
        'INSERT INTO Anomalies (Where,ServiceID,What,CardID,Operator) ' +
        'VALUES (' + QuotedStr('Porta') + ',' + intToStr(serviceID) + ',' +
        QuotedStr('Allarme disinserito: ' + alias) + ',' +
        intToStr(c_ServiceOwnedByCardID_Arr[serviceID]) + ',' +
        QuotedStr(Form1.cashier) + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
        'Anomalies');
      Sleep(sleepTm);
    END;
  END;

  // A4: Door has been closed event
  // -----------------------------
  IF eventCode = 'A4' THEN
  BEGIN
    IF serviceID = StrToInt(ConnXDoorReaderID) THEN
      queryStr := 'UPDATE Services SET Door = True' + ' WHERE (CardReader = ' +
        deviceAddress + ' OR Actuator = ' + deviceAddress + ')'
    ELSE
      queryStr := 'UPDATE Services SET Door = True' + ' WHERE (CardReader = ' +
        deviceAddress + ' OR Actuator = ' + deviceAddress + ')';
    // Form2.WriteData2Table('HandleDoorClosed', queryStr, 'Services');
    Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    // Sleep(sleepTm);
    IF (c_ServiceOwnedByCardID_Arr[serviceID] = 0) AND
      (TimeInRange(Time, Form1.todays_O_time, Form1.todays_C_time, False)) THEN
    BEGIN
      queryStr :=
        'INSERT INTO Anomalies (Where,ServiceID,What,ClientID,CardID,Operator) '
        + 'VALUES (' + QuotedStr('Porta') + ',' + intToStr(serviceID) + ',' +
        QuotedStr('Chiuso senza tessera ') + ',' + intToStr(ClientID) + ',' +
        intToStr(cardID) + ',' + QuotedStr(Form1.cashier) + ')';
      // Form2.WriteData2Table('HandleAnomaly', queryStr, 'Anomalies');
      Form2.t_executequery(queryStr, 'DB_Mein', 'PGC_DB_Main_Euro', 'Services');
      // Sleep(sleepTm);
      queryStr :=
        'UPDATE Services SET LastEventDescr = ''Chiuso senza tessera'' ' +
        'WHERE ID = ' + intToStr(serviceID);
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Sleep(sleepTm);
    END;
  END;

  // A6: Door has been opened event
  // -----------------------------
  IF eventCode = 'A6' THEN
  BEGIN
    IF serviceID = StrToInt(ConnXDoorReaderID) THEN
      queryStr := 'UPDATE Services SET Door = True' + ' WHERE (CardReader = ' +
        deviceAddress + ' OR Actuator = ' + deviceAddress + ')'
    ELSE
      queryStr := 'UPDATE Services SET Door = False' + ' WHERE (CardReader = ' +
        deviceAddress + ' OR Actuator = ' + deviceAddress + ')';
    // Form2.WriteData2Table('HandleDoorOpened', queryStr, 'Services');
    Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    // Sleep(sleepTm);
    IF (c_ServiceOwnedByCardID_Arr[serviceID] = 0) AND
      (TimeInRange(Time, Form1.todays_O_time, Form1.todays_C_time, False)) THEN
    BEGIN
      queryStr :=
        'INSERT INTO Anomalies (Where,ServiceID,What,ClientID,CardID,Operator) '
        + 'VALUES (' + QuotedStr('Porta') + ',' + intToStr(serviceID) + ',' +
        QuotedStr('Aperta senza tessera ') + ',' + intToStr(ClientID) + ',' +
        intToStr(cardID) + ',' + QuotedStr(cashier) + ')';
      // Form2.WriteData2Table('HandleAnomaly', queryStr, 'Anomalies');
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
        'Anomalies');
      Sleep(sleepTm);
      queryStr :=
        'UPDATE Services SET LastEventDescr = ''Aperto senza tessera'' ' +
        'WHERE ID = ' + intToStr(serviceID);
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    END;
  END;

  // 30: answer code from inside reader
  // ----------------------------------
  IF eventCode = '30' THEN
  BEGIN
    // re-entry request -check if card inside internal reader
  END;

  // 90: card inserted in outside reader
  // -----------------------------------
  IF eventCode = '90' THEN
  BEGIN
    // Claude test
    // --------------------------------------------------------------------------
    WITH MGuardClient1 DO
    BEGIN
      MgRecordType := 'C';
      MgDeviceAddress := readerID;
      MgEventDescr := '1';
      MgCommandCode := relaisOn;
      fReaderID := readerID;
      // ADD THIS LOGGING
      me_RS485Log.Lines.Add('=== SENDING COMMAND ===');
      me_RS485Log.Lines.Add('RecordType: ' + MgRecordType);
      me_RS485Log.Lines.Add('DeviceAddress: ' + MgDeviceAddress);
      me_RS485Log.Lines.Add('EventDescr: ' + MgEventDescr);
      me_RS485Log.Lines.Add('CommandCode: ' + MgCommandCode);
      me_RS485Log.Lines.Add('About to call SendToMGuardSrv...');
      SendToMGuardSrv;

      if ckbSendRelaisDisconnect.Checked then
      begin
        Sleep(edtSendRelaisDisconnect.Value);
        MgRecordType := 'C';
        MgDeviceAddress := readerID;
        MgEventDescr := '1';
        MgCommandCode := relaisOff;
        me_RS485Log.Lines.Add('=== SENDING COMMAND ===');
        me_RS485Log.Lines.Add('RecordType: ' + MgRecordType);
        me_RS485Log.Lines.Add('DeviceAddress: ' + MgDeviceAddress);
        me_RS485Log.Lines.Add('EventDescr: ' + MgEventDescr);
        me_RS485Log.Lines.Add('CommandCode: ' + MgCommandCode);
        me_RS485Log.Lines.Add('About to call SendToMGuardSrv...');
        SendToMGuardSrv;
      end;

      me_RS485Log.Lines.Add('SendToMGuardSrv returned');
      Sleep(sleepTm);
    END;
    // -----------------------------------------------------------------------------
    IF lastEventDescr = 'A L L A R M E' THEN
    BEGIN
      WITH MGuardClient1 DO
      BEGIN
        MgRecordType := 'C';
        MgDeviceAddress := readerID;
        MgCommandType := 2;
        MgCommandCode := '25';
        SendToMGuardSrv;
      END;
      queryStr :=
        'INSERT INTO Anomalies (Where,ServiceID,What,CardID,Operator) ' +
        'VALUES (' + QuotedStr('Porta') + ',' + intToStr(serviceID) + ',' +
        QuotedStr('Allarme-porta aperta: ' + alias) + ',' + intToStr(cardID) +
        ',' + QuotedStr(Form1.cashier) + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
        'Anomalies');
      queryStr := 'UPDATE Services SET LastEventDT = Current_TimeStamp' +
        ', LastEventDescr = ' + QuotedStr('Allarme-controllo') +
        ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
        deviceAddress + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Exit;
    END;

    CASE cardID OF
      1000 .. 8999:
        BEGIN
          IF (NOT privacy) AND (readerID <> LoungeReaderID) THEN
          BEGIN
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := readerID;
              MgCommandType := 2;
              MgCommandCode := '25';
              SendToMGuardSrv;
              Sleep(sleepTm);
              Exit;
            END
          END;

          // connection door 11 & 12
          // ------------------------
          IF readerID = ConnXDoorReaderID THEN
          BEGIN
            IF ((c_ServiceOwnedByCardID_Arr[11] = 0) OR
              (c_ServiceOwnedByCardID_Arr[12] = 0)) OR
              (c_ServiceOwnedByCardID_Arr[11] = cardID) OR
              (c_ServiceOwnedByCardID_Arr[12] = cardID) THEN
              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgDeviceAddress := readerID;
                MgCommandType := 2;
                MgCommandCode := '25';
                SendToMGuardSrv;
              END
            ELSE
              Exit;
          END;

          IF (cardInID = cardID) OR (cardInID = 0) OR
          // re-enter or new entry or personnel card
            ((cardInID >= 9000) AND (cardInID < 9900)) THEN
          BEGIN
            IF cardInID <> cardID THEN
            BEGIN
              Form1.c_ServiceOwnedByCardID_Arr[serviceID] := cardID;
              queryStr := 'UPDATE Services SET LastEventDT = Current_TimeStamp'
                + ', LastEventDescr = ' + QuotedStr('Occupata') +
                ', LastAlias = ' + QuotedStr(alias) + ', CardInID = ' +
                intToStr(cardID) + ', UsedWithoutClean = ' +
                intToStr(usedClean + 1) + ', TotUse = ' + intToStr(totUse + 1) +
                ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
                deviceAddress + ')';
              Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                'Services');
              queryStr := 'UPDATE ServicesSold SET StartUse = Current_TimeStamp'
                + ', ServiceID = ' + QuotedStr(intToStr(serviceID)) +
                ' WHERE (CardID = ' + intToStr(cardID) + ' AND ClientID = ' +
                intToStr(ClientID) + ' AND FeeID = ' + intToStr(feeID) +
                ' AND Valid = True ' + ')';
              Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                'ServicesSold');
              queryStr := 'UPDATE ServicesSold SET StartUse = Current_TimeStamp'
                + ' WHERE (CardID = ' + intToStr(cardID) + ' AND ClientID = ' +
                intToStr(ClientID) + ' AND FeeID = 3 AND StartUse IS NULL ' +
                ' AND Valid = True ' + ')';
              Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                'ServicesSold');
            END;
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := readerID;
              MgCommandType := 2;
              MgCommandCode := '25';
              SendToMGuardSrv;
              Sleep(sleepTm);
            END;
          END
          ELSE
            // Exit;
        END;

      9000 .. 9999:
        BEGIN
          WITH Form1 DO
          BEGIN
            CASE cardID OF
              9000 .. 9010: // receptionist cards
                BEGIN
                  queryStr :=
                    'UPDATE Services SET LastEventDT = Current_TimeStamp' +
                    ', LastEventDescr = ' + QuotedStr('Gestione') +
                    ', CardInID = ' + intToStr(cardID) + ' WHERE (CardReader = '
                    + deviceAddress + ' OR ACTUATOR = ' + deviceAddress + ')';
                  cLogQueryStr :=
                    'INSERT INTO CleanLog (ServiceID,CardID,OpenRequest,Operator) '
                    + 'VALUES (' + intToStr(serviceID) + ',' + intToStr(cardID)
                    + ', current_TimeStamp' + ',' +
                    QuotedStr(Form1.cashier) + ')';

                  Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                    'Services');
                  Sleep(sleepTm);
                END;
              9100 .. 9899:
                // cleaning ladies cards
                BEGIN
                  IF usedClean >= ed_MarkRedAfterUse.Value THEN
                    queryStr :=
                      'UPDATE Services SET LastEventDT = Current_TimeStamp' +
                      ', LastEventDescr = ' + QuotedStr('Pulizia') +
                      ', CardInID = ' + intToStr(cardID) +
                      ', UsedWithoutClean = 0' + ', Enabled = True' +
                      ' WHERE (CardReader = ' + deviceAddress +
                      ' OR ACTUATOR = ' + deviceAddress + ')'
                  ELSE
                    queryStr :=
                      'UPDATE Services SET LastEventDT = Current_TimeStamp' +
                      ', LastEventDescr = ' + QuotedStr('Pulizia') +
                      ', CardInID = ' + intToStr(cardID) +
                      ', UsedWithoutClean = 0' + ' WHERE (CardReader = ' +
                      deviceAddress + ' OR ACTUATOR = ' + deviceAddress + ')';
                  cLogQueryStr :=
                    'INSERT INTO CleanLog (ServiceID,CardID,OpenRequest,Operator) '
                    + 'VALUES (' + intToStr(serviceID) + ',' + intToStr(cardID)
                    + ', CURRENT_TIMESTAMP' + ',' +
                    QuotedStr(Form1.cashier) + ')';
                  Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                    'Services');
                  Sleep(sleepTm);
                  Form2.t_executequery(cLogQueryStr, 'DB_Main',
                    'PGC_DB_Main_Euro', 'CleanLog');
                  Sleep(sleepTm);
                END;

              9900 .. 9999:
                BEGIN
                  // technicians test cards
                  IF cardInID > 0 THEN
                    Exit;
                  queryStr :=
                    'UPDATE Services SET LastEventDT = CURRENT_TIMESTAMP' +
                    ', LastEventDescr = CONCAT(LastEventDescr WITH ' +
                    QuotedStr('+') + ')' + ' WHERE (CardReader = ' +
                    deviceAddress + ' OR ACTUATOR = ' + deviceAddress + ')';
                  Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
                    'Services');
                END;
            END;
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := readerID;
              MgCommandType := 2;
              MgCommandCode := '25';
              SendToMGuardSrv;
              Sleep(sleepTm);
            END;
          END;
        END;
    END;
    IF abbaActuatorID <> '' THEN
    BEGIN
      WITH MGuardClient1 DO
      BEGIN
        MgRecordType := 'C';
        MgDeviceAddress := abbaActuatorID;
        MgEventDescr := '1';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgDeviceAddress := abbaActuatorID;
        MgEventDescr := '2';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgCommandCode := '37';
        MgEventDescr := ledOff;
        MgDeviceAddress := abbaReaderID;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgCommandCode := '37';
        MgEventDescr := ledGreen;
        MgDeviceAddress := abbaReaderID;
        SendToMGuardSrv;
        Sleep(sleepTm);
      END;
      WITH Form2.qy_TMP DO
      BEGIN
        IF Active THEN
          Close;
        DataSource := Form2.sc_Services;
        SQL.Clear;
        SQL.Add('SELECT Abbandoned AS totAbba FROM Services WHERE (CardReader = '
          + abbaReaderID + ' OR ACTUATOR = ' + abbaActuatorID + ')');
        Active := True;
        IF FieldValues['totAbba'] <> NULL THEN
          totAbba := FieldValues['totAbba'] + 1
        ELSE
          totAbba := 1;
        Active := False;
        UnPrepare;
      END;
      queryStr := 'UPDATE Services SET  Abbandoned = ' + intToStr(totAbba) +
        '  WHERE (CardReader = ' + abbaReaderID + ' OR ACTUATOR = ' +
        abbaActuatorID + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Sleep(sleepTm);
    END;
  END;

  // 93: Card extracted from outside reader
  // --------------------------------------
  IF eventCode = '93' THEN
    WITH Form1.MGuardClient1 DO
    BEGIN
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := ledOff;
      MgDeviceAddress := readerID;
      SendToMGuardSrv;
      Sleep(sleepTm);
      IF ((cardInID >= 1000) AND (cardInID <= 8999)) OR
        (c_RoomEnabled = False) THEN
        // to verify
        ledColor := ledRed
      ELSE
        ledColor := ledGreen;
      // set led color to green..
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := ledColor;
      MgDeviceAddress := readerID;
      SendToMGuardSrv;
      Sleep(sleepTm);
    END;
  // 95: Card inserted into inside reader
  // ------------------------------------
  IF eventCode = '95' THEN
  BEGIN
    WITH Form1 DO
    BEGIN
      WITH MGuardClient1 DO
      BEGIN
        MgRecordType := 'C';
        MgDeviceAddress := actuatorID;
        MgEventDescr := '1';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgDeviceAddress := actuatorID;
        MgEventDescr := '2';
        MgCommandCode := relaisOff;
        SendToMGuardSrv;
        Sleep(sleepTm);
        MgRecordType := 'C';
        MgCommandCode := '37';
        MgEventDescr := ledOff;
        MgDeviceAddress := readerID;
        SendToMGuardSrv;
        Sleep(sleepTm);
      END;
      CASE cardInID OF
        9900 .. 9999:
          BEGIN
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := actuatorID;
              MgEventDescr := '1';
              MgCommandCode := relaisOn;
              SendToMGuardSrv;
              Sleep(sleepTm);
              MgRecordType := 'C';
              MgCommandCode := '37';
              MgEventDescr := ledRed;
              MgDeviceAddress := readerID;
              SendToMGuardSrv;
              Sleep(sleepTm);
            END;
            queryStr := 'UPDATE Services SET Lights = True' +
              ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
              deviceAddress + ')';
            Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
              'Services');
            Sleep(sleepTm);
          END;
        9000 .. 9899:
          BEGIN
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := actuatorID;
              MgEventDescr := '1';
              MgCommandCode := relaisOn;
              SendToMGuardSrv;
              Sleep(sleepTm);
              MgRecordType := 'C';
              MgDeviceAddress := actuatorID;
              MgEventDescr := '2';
              MgCommandCode := relaisOn;
              SendToMGuardSrv;
              Sleep(sleepTm);
              MgRecordType := 'C';
              MgCommandCode := '37';
              MgEventDescr := ledGreen;
              MgDeviceAddress := readerID;
              SendToMGuardSrv;
              Sleep(sleepTm);
            END;
            queryStr := 'UPDATE Services SET Lights = True' +
              ', Projector = True' + ' WHERE (CardReader = ' + deviceAddress +
              ' OR ACTUATOR = ' + deviceAddress + ')';
            cLogQueryStr := 'UPDATE CleanLog SET CardInside = CURRENT_TIMESTAMP'
              + ' WHERE (ServiceID = ' + intToStr(serviceID) + ' AND CardID = '
              + intToStr(cardInID) + ')';
            Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
              'Services');
            Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
              'CleanLog');
          END;
        1000 .. 7999:
          BEGIN
            WITH MGuardClient1 DO
            BEGIN
              MgRecordType := 'C';
              MgDeviceAddress := actuatorID;
              MgEventDescr := '1';
              MgCommandCode := relaisOn;
              SendToMGuardSrv;
              Sleep(sleepTm);
              MgRecordType := 'C';
              MgCommandCode := '37';
              MgEventDescr := ledRed;
              MgDeviceAddress := readerID;
              SendToMGuardSrv;
              Sleep(sleepTm);
            END;
            queryStr := 'UPDATE Services SET Lights = True' +
              ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
              deviceAddress + ')';
            Form2.t_executequery(queryStr, 'DB_EMain', 'PGC_DB_Main_Euro',
              'Services');
            Sleep(sleepTm);

            // check if both rooms, 11 and 12, are busy. If so, then set connecting door led to red
            IF (((serviceID = 11) OR (serviceID = 12)) AND
              ((Form1.c_ServiceOwnedByCardID_Arr[11] <> 0) AND
              (Form1.c_ServiceOwnedByCardID_Arr[12] <> 0))) THEN
              WITH MGuardClient1 DO
              BEGIN
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledOff;
                MgDeviceAddress := ConnXDoorReaderID;
                SendToMGuardSrv;
                Sleep(sleepTm);
                MgRecordType := 'C';
                MgCommandCode := '37';
                MgEventDescr := ledRed;
                MgDeviceAddress := ConnXDoorReaderID;
                SendToMGuardSrv;
                Sleep(sleepTm);
              END;
          END;
      END;
      // end case
    END;
  END;
  // 97: card extracted from inside reader
  // -------------------------------------
  IF eventCode = '97' THEN
    WITH Form1.MGuardClient1 DO
    BEGIN
      MgRecordType := 'C';
      MgDeviceAddress := actuatorID;
      MgEventDescr := '1';
      MgCommandCode := relaisOff;
      SendToMGuardSrv;
      Sleep(sleepTm);
      MgRecordType := 'C';
      MgDeviceAddress := actuatorID;
      MgEventDescr := '2';
      MgCommandCode := relaisOff;
      SendToMGuardSrv;
      Sleep(sleepTm);
      IF ((cardInID >= 1000) AND (cardInID <= 8999)) OR
        (c_RoomEnabled = False) THEN
        // verificare
        ledColor := ledRed
      ELSE
        ledColor := ledGreen;
      // set led color to green..
      MgRecordType := 'C';
      MgCommandCode := '37';
      MgEventDescr := ledColor;
      MgDeviceAddress := readerID;
      SendToMGuardSrv;
      Sleep(sleepTm);
      IF (cardInID >= 9000) AND (cardInID <= 9899) THEN
      BEGIN
        queryStr := 'UPDATE Services SET Lights = False' + ', Projector = False'
          + ', CardInID = 0' + ' WHERE (CardReader = ' + deviceAddress +
          ' OR ACTUATOR = ' + deviceAddress + ')';
        cLogQueryStr := 'UPDATE CleanLog SET CardInsideOut = CURRENT_TIMESTAMP'
          + ', DeltaInOut = (CURRENT_TIMESTAMP - CardInside)MINUTE' +
          ' WHERE ServiceID = ' + intToStr(serviceID) + ' AND CardID = ' +
          intToStr(cardInID) + ' AND DeltaInOut = 0';
        Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro',
          'CleanLog');
      END
      ELSE IF (cardInID >= 9900) THEN
        queryStr := 'UPDATE Services SET Lights = False' + ', Projector = False'
          + ', CardInID = 0' + ' WHERE (CardReader = ' + deviceAddress +
          ' OR ACTUATOR = ' + deviceAddress + ')'
      ELSE
        queryStr := 'UPDATE Services SET Lights = False' + ', Projector = False'
          + ' WHERE (CardReader = ' + deviceAddress + ' OR ACTUATOR = ' +
          deviceAddress + ')';
      Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
      Sleep(sleepTm);
    END;
  // 99: Outside reader button pushed
  // --------------------------------
  IF (eventCode = '99') AND (cardInID <= 0) THEN
  BEGIN
    queryStr := 'UPDATE Services SET LastEventDescr = ' +
      QuotedStr('Richiesto Controllo') + ' WHERE (CardReader = ' + deviceAddress
      + ' OR ACTUATOR = ' + deviceAddress + ')';
    Form2.t_executequery(queryStr, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    // verificare
  END;
END;

Procedure TForm1.SendRelaisDisconnect;
begin
  WITH MGuardClient1 DO
  BEGIN
    Sleep(edtSendRelaisDisconnect.Value);
    MgRecordType := 'C';
    MgDeviceAddress := fReaderID;
    MgEventDescr := '1';
    MgCommandCode := relaisOff;
  END;
end;

FUNCTION TForm1.GetCurrentPrinterHandle: THandle;
CONST
  Defaults: TPrinterDefaults = (pDatatype: NIL; pDevMode: NIL;
  DesiredAccess: PRINTER_ACCESS_USE OR PRINTER_ACCESS_ADMINISTER);
VAR
  Device, Driver, Port: ARRAY [0 .. 255] OF Char;
  hDeviceMode: THandle;
BEGIN { GetCurrentPrinterHandle }
  // Printer.GetPrinter(Device, Driver, Port, hDeviceMode);

  IF NOT OpenPrinter(@Device, Result, @Defaults) THEN
    // RaiseLastWin32Error; deprecated
    RaiseLastOSError;
END; { GetCurrentPrinterHandle }

function TForm1.GetMyPrinter: TPrinter;
  function IsPrinterBlockingStatus(const sT: DWORD): Boolean;
  const
    BLOCKING_MASK = PRINTER_STATUS_ERROR or PRINTER_STATUS_OFFLINE or
      PRINTER_STATUS_PAPER_JAM or PRINTER_STATUS_PAPER_OUT or
      PRINTER_STATUS_PAPER_PROBLEM or PRINTER_STATUS_OUTPUT_BIN_FULL or
      PRINTER_STATUS_NO_TONER or PRINTER_STATUS_OUT_OF_MEMORY or
      PRINTER_STATUS_DOOR_OPEN or PRINTER_STATUS_USER_INTERVENTION;
  begin
    // NOTE: do NOT include PRINTER_STATUS_NOT_AVAILABLE ($1000) here
    Result := (sT and BLOCKING_MASK) <> 0;
  end;

var
  PName: string;
  idx: Integer;
  sT: DWORD;
  Device, Driver, Port: array [0 .. 255] of Char;
  hDeviceMode: THandle;
begin
  Result := nil;

  if rg_Printers.ItemIndex < 0 then
  begin
    ShowMessage('No printer selected');
    Exit;
  end;

  PName := rg_Printers.Items[rg_Printers.ItemIndex];

  idx := Printer.Printers.IndexOf(PName);
  if idx < 0 then
  begin
    ShowMessage('Selected printer not found: ' + PName);
    Exit;
  end;

  sT := GetPrinterStatusByName(PName);

  // If it’s *only* NOT_AVAILABLE, treat as “unknown” and still try to print
  if IsPrinterBlockingStatus(sT) then
  begin
    ShowMessage('Printer status blocking: ' + intToStr(sT));
    Exit;
  end;

  Printer.PrinterIndex := idx;
  // Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  Result := Printer;
end;

function TForm1.GetPrinterStatusByName(const APrinterName: string): DWORD;
var
  hPrinter: THandle;
  BytesNeeded: Cardinal;
  pPI: PPrinterInfo2;
  Defaults: TPrinterDefaults;
begin
  Result := 0;

  FillChar(Defaults, SizeOf(Defaults), 0);
  Defaults.DesiredAccess := PRINTER_ACCESS_USE; // don't request ADMINISTER

  Win32Check(OpenPrinter(PChar(APrinterName), hPrinter, @Defaults));
  try
    GetPrinter(hPrinter, 2, nil, 0, @BytesNeeded);
    // expected "insufficient buffer"
    GetMem(pPI, BytesNeeded);
    try
      Win32Check(GetPrinter(hPrinter, 2, pPI, BytesNeeded, @BytesNeeded));
      Result := pPI^.Status;
    finally
      FreeMem(pPI);
    end;
  finally
    ClosePrinter(hPrinter);
  end;
end;

PROCEDURE TForm1.PurgeJobsOnCurrentPrinter;
VAR
  hPrinter: THandle;
BEGIN
  hPrinter := GetCurrentPrinterHandle;
  TRY
    IF NOT WinSpool.SetPrinter(hPrinter, 0, NIL, PRINTER_CONTROL_PURGE) THEN
      // RaiseLastWin32Error; deprecated
      RaiseLastOSError;
  FINALLY
    ClosePrinter(hPrinter);
  END;
END; { PurgeJobsOnCurrentPrinter }

FUNCTION TForm1.GetCurrentPrinterStatus: DWORD;
// Status    Status
// code      code
// decimal   hex      Description
{ 0            0       Printer ready
  1             1       Printer paused
  2             2       Printer error
  4             4       Printer pending deletion
  8             8       Paper jam
  16            10      Out of paper
  32            20      Manual feed
  64            40      Paper problem
  128           80      Printer offline
  256           100     IO active
  512           200     Printer busy
  1024          400     Printing
  2048          800     Printer output bin full
  4096          1000    Not available.
  8192          2000    Waiting
  16384         4000    Processing
  32768         8000    Initializing
  65536         10000   Warming up
  131072        20000   Toner low
  262144        40000   No toner
  524288        80000   Page punt
  1048576       100000  User intervention
  2097152       200000  Out of memory
  4194304       400000  Door open
  8388608       800000  Server unknown
  6777216       1000000 Power save }
// --------------------------------------
var
  hPrinter: THandle;
  Device: string;
  BytesNeeded: Cardinal;
  pPI: PPrinterInfo2;
  Defaults: TPrinterDefaults;
begin
  Assert(Printer.PrinterIndex >= 0);
  Device := Printer.Printers[Printer.PrinterIndex];

  FillChar(Defaults, SizeOf(Defaults), 0);
  Defaults.DesiredAccess := PRINTER_ACCESS_ADMINISTER or PRINTER_ACCESS_USE;

  Win32Check(OpenPrinter(PChar(Device), hPrinter, @Defaults));
  try
    GetPrinter(hPrinter, 2, nil, 0, @BytesNeeded);
    GetMem(pPI, BytesNeeded);
    try
      Win32Check(GetPrinter(hPrinter, 2, pPI, BytesNeeded, @BytesNeeded));
      Result := pPI^.Status;
    finally
      FreeMem(pPI);
    end;
  finally
    ClosePrinter(hPrinter);
  end;
end;

FUNCTION TForm1.IsPrinterReady: Boolean;
VAR
  Status: DWORD;
BEGIN
  Status := GetCurrentPrinterStatus;
  // Check if the printer is ready (not paused, offline, or in an error state)
  Result := (Status AND PRINTER_STATUS_PAUSED = 0) AND
    (Status AND PRINTER_STATUS_ERROR = 0) AND
    (Status AND PRINTER_STATUS_OFFLINE = 0) AND
    (Status AND PRINTER_STATUS_PRINTING = 0);
END;

PROCEDURE TForm1.WaitForPrinter;
BEGIN
  WHILE NOT IsPrinterReady DO
  BEGIN
    Sleep(5000); // Wait for 500ms before checking again
    Application.ProcessMessages; // Keep the application responsive
  END;
END;

procedure TForm1.imgLotteryTDblClick(Sender: TObject);
begin
  IF OpenPictureDialog1.Execute THEN
    IF FileExists(OpenPictureDialog1.FileName) THEN
      imgLotteryT.Picture.Graphic.LoadFromFile(OpenPictureDialog1.FileName)
    ELSE
      RAISE Exception.Create('File does not exist.');
end;

procedure TForm1.img_ClientiClientsDblClick(Sender: TObject);
var
  Fn: string;
begin
  if ScanViaPickerToFile(Fn) then
  begin
    if scEH_Clienti_Clients.DataSet.State = dsBrowse then
      scEH_Clienti_Clients.DataSet.Edit;
    (scEH_Clienti_Clients.DataSet.FieldByName('Image') as TBlobField)
      .LoadFromFile(Fn);
    scEH_Clienti_Clients.DataSet.Post;
  end;
end;

PROCEDURE TForm1.FlowPanel1DragOver(Sender, Source: TObject; X, Y: Integer;
State: TDragState; VAR Accept: Boolean);
BEGIN
  Accept := (Source IS TImage) OR (Source IS TDBImage) OR (Source IS TDBMemo) OR
    (Source IS TDBRichEditEh);
  // Allow only TDBImage components to be dropped
END;

PROCEDURE TForm1.FlowPanel1MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
BEGIN
  IF Button = mbLeft THEN
  BEGIN
    IsDragging := False; // Stop dragging
  END;
END;

FUNCTION TForm1.xx_CheckIfStillPresent: Boolean;
BEGIN
  // Check who is still in room and not at club and fill FAliases with alias names
  FAliases := [];
  WITH Form2.qy_InHousePresence DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT c.ID AS ClientID, ' + '       c.Alias, ' +
      '       c.Phone, ' + '       (SELECT MAX(ss.SoldDT) ' +
      '        FROM ServicesSold ss ' + '        WHERE ss.ClientID = c.ID ' +
      '          AND ss.SubFeeID IN (310, 315) ' +
      '          AND ss.Valid = FALSE ' + '       ) AS LastInvalidFee3Date ' +
      'FROM Clients c ' + 'WHERE EXISTS ( ' +
      '    SELECT 1 FROM RREU_Bookings b ' + '    WHERE b.GuestID = c.ID ' +
      '      AND b.CheckOutDate IS NULL ' + ') ' + 'AND EXISTS ( ' +
      '    SELECT 1 FROM ServicesSold ss2 ' + '    WHERE ss2.ClientID = c.ID ' +
      '      AND ss2.SubFeeID IN (310, 315) ' + '      AND ss2.Valid = FALSE ' +
      ') ' + 'ORDER BY c.Alias');
    Active := True;
    dbgd_InRoom.Refresh;
    dbgd_InRoom.SumList.RecalcAll;
    Result := RecordCount > 0;
  END;
END;

PROCEDURE TForm1.xx_ScheduleNextRRCheck;
VAR
  NowDT, TargetDT: TDateTime;
  MsUntil: Int64;
BEGIN
  NowDT := Now;
  // Build today’s 18:00
  TargetDT := Trunc(NowDT) + EncodeTime(18, 00, 0, 0);
  // If we’re already at/after 18:00 today, move to tomorrow
  IF NowDT >= TargetDT THEN
    TargetDT := TargetDT + 1;

  // Compute milliseconds until then
  MsUntil := MilliSecondsBetween(TargetDT, NowDT);
  // Cap to a valid Integer if necessary
  IF MsUntil > HIGH(Integer) THEN
    MsUntil := HIGH(Integer);

  tht_CheckPresence.Interval := MsUntil;
  tht_CheckPresence.Enabled := True;
END;

FUNCTION TForm1.TitleCase(CONST s: STRING): STRING;
BEGIN
  IF s = '' THEN
    Result := ''
  ELSE
  BEGIN
    Result := UpperCase(s[1]);
    FOR var I := 2 TO Length(s) DO
      IF s[I - 1] = ' ' THEN
        Result := TrimLeft(Result + UpperCase(s[I]))
      ELSE
        Result := TrimLeft(Result + lowercase(s[I]));
  END;
END;

PROCEDURE TForm1.SetWorkingDayDateTime(ADate: TDateTime);
var
  nowFrac: TTime;
  baseDate: TDate;
begin
  nowFrac := Frac(Now);
  const
    SHIFT_START_TIME: TTime = EncodeTime(12, 0, 0, 0);
  const
    SHIFT_END_TIME: TTime = EncodeTime(11, 59, 59, 0);

    // decide which calendar‐day “chunk” we’re in:
  if InRange(nowFrac, SHIFT_START_TIME, 1.0) then
    baseDate := Date // between 12:00 and midnight → today’s shift
  else if InRange(nowFrac, 0.0, SHIFT_END_TIME) then
    baseDate := Date - 1 // between midnight and 11:50 → yesterday’s shift
  else
    baseDate := Date; // only if you ever fall outside 12:00→11:50

  // now build the full DateTime bounds:
  sDt := baseDate + SHIFT_START_TIME;
  eDT := baseDate + 1 + SHIFT_END_TIME;
end;

FUNCTION TForm1.GetHostName: STRING;
VAR
  ComputerName: ARRAY [0 .. MAX_COMPUTERNAME_LENGTH + 1] OF Char;
  Size: Cardinal;
BEGIN
  Result := '';
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(ComputerName, Size);
  Result := StrPas(ComputerName);
END;

FUNCTION TForm1.CheckPermission(AccessLevel: Integer; Field: STRING): Boolean;
BEGIN
  IF AccessLevel <= 0 THEN
    Result := False
  ELSE
    Result := Form2.tb_ClubPermissions.Lookup('Level',
      varArrayof([AccessLevel]), Field)
END;


// **************************************************************************
// NEW ROUTINES Started 06/06/2021                                         *
// **************************************************************************

PROCEDURE TForm1.nnWriteCashierDisplay(stGrid: Integer; del: Boolean;
fCol: TColor; Txt: STRING; rowIndex: Integer);
BEGIN
  WITH mm_Cashier DO
  BEGIN
    IF del THEN
    BEGIN
      Clear;
      RowCount := 3;
    END;
    CellProperties[0, rowIndex].FontColor := fCol;
    Cells[0, rowIndex] := Txt;
  END;
END;

Procedure TForm1.xx_VerifyFee(ClientID: Integer; OUT card4Fee, hasValidEntrance,
  hasValidRoom: Boolean);
VAR
  feeID, subFeeID: Integer;
  s, Description: STRING;
BEGIN
  // Update who is InHouse but not at club
  // ---------------------------------------------------------------------------
  IF (Form2.tb_Fees.FieldByName('ID').AsInteger = 3) THEN
    xx_CheckIfStillPresent;
  // Get girls giornaliera fee status
  // ---------------------------------------------------------------------------
  WITH Form2, qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    s := 'SELECT FeeID, SubFeeID, f.Description FROM ServicesSold SS ' +
      'LEFT JOIN Fees f ON f.SubID = SubFeeID ' + 'WHERE  ClientID = ' +
      intToStr(ClientID) +
      ' AND FeeID = 3 AND Valid = True  AND Canceled = False ' +
      ' AND SoldDt >= TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(sDt, True)) +
      ' ORDER BY SoldDT';
    SQL.Add(s);
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      Last;
      feeID := FieldValues['FeeID'];
      subFeeID := FieldValues['SubFeeID'];
      Description := FieldValues['Description'];
      hasValidEntrance := True;
    END
    ELSE
    BEGIN
      feeID := -1;
      subFeeID := -1;
      hasValidEntrance := False;
    END;
    Active := False;

    // Get RR booking data
    // -----------------------------------------------------------------------
    uClientStore.ThisBooking := GetRentalDepositAmt(uClientStore.ThisClient.ID);

    // Card id is valid for this fee
    // -----------------------------------------------------------------------
    IF InRange(uClientStore.ThisCard.cardID, tb_Fees.FieldByName('CardsFrom')
      .AsInteger, tb_Fees.FieldByName('CardsTo').AsInteger) THEN
      card4Fee := True
    ELSE
    BEGIN
      card4Fee := False;
      nnWriteCashierDisplay(0, False, clYellow,
        'Tessera ' + intToStr(uClientStore.ThisCard.cardID) +
        ' non valida per registrare un/una ' + tb_Fees.FieldByName
        ('Description').AsString, 1);
      nnWriteCashierDisplay(0, False, clWhite, 'Tessere valide dal ' +
        tb_Fees.FieldByName('CardsFrom').AsString + ' al ' +
        tb_Fees.FieldByName('CardsTo').AsString, 2);
    END;

    // Girl already payed RR room deposit
    // -----------------------------------------------------------------------
    IF (tb_Fees.FieldByName('SubID').Value = 299) AND
      (uClientStore.ThisBooking.depositAmtPayed < 0) THEN
    BEGIN
      nnWriteCashierDisplay(0, False, clWhite, uClientStore.ThisClient.alias +
        ' ha già pagato in data ' + DateTimeToStr
        (DateOf(uClientStore.ThisBooking.DepositINdt)) + ' una cauzione di ' +
        FormatFloat('#,##0.00', Abs(uClientStore.ThisBooking.depositAmtPayed)) +
        uClientStore.ThisBooking.depositPayMethod + '.', 1);
      showNumKeyB := False;
      bt_CancelAllClick(NIL);
    END;

    // Deposit reemboursment clicked but client, who has RR room, did not yet pay deposit
    // -----------------------------------------------------------------------
    IF (tb_oTab.FieldByName('SubFeeID').Value = 289) AND
      (uClientStore.ThisBooking.txID = '') THEN
    BEGIN
      nnWriteCashierDisplay(0, False, clYellow, uClientStore.ThisClient.alias +
        ' ha una camera in ' + uClientStore.ThisBooking.Address + ' dal ' +
        DateTimeToStr(DateOf(uClientStore.ThisBooking.checkInDt)) +
        ' ma non ha anocar pagata la cauzione.', 1);
      showNumKeyB := False;
      bt_CancelAllClick(NIL);
    END;

  END;
END;

FUNCTION TForm1.GetEuroFee(chfFee: Double): Double;
BEGIN
  IF ed_ExchangeRate.Value = 0 THEN
  begin
    RAISE Exception.Create('Il cambio non può essere 0!' + #13#10 +
      'In mancanza viene applicato un cambio alla pari!');
    Result := chfFee;
  end
  else
    Result := Ceil(chfFee / ed_ExchangeRate.Value);
END;

PROCEDURE TForm1.xx_WriteFeeToOtab;
VAR
  BRefStr, defPM, Description, txID: STRING;
  euroValue: String;
  NeedNullEuro: Boolean;
  euroFee: Double;
BEGIN
  WITH Form2, qy_TMP DO
  BEGIN
    IF (tb_AllFees.FieldByName('DefaultPayMethod').AsString = 'PD') OR
      (tb_AllFees.FieldByName('DefaultPayMethod').AsString = 'OF') THEN
      defPM := tb_AllFees.FieldByName('DefaultPayMethod').AsString
    ELSE
      defPM := '';

    // Set 0 amount paymethod
    // -------------------------------------------------------------------------
    IF (tb_AllFees.FieldByName('FeeCHF').AsFloat = 0) THEN
      defPM := 'CH';

    // Add client alias
    // -------------------------------------------------------------------------
    IF tb_AllFees.FieldByName('AddClientAlias').AsBoolean = True THEN
      Description := tb_AllFees.FieldByName('Description').AsString + ' ' +
        uClientStore.ThisClient.alias
    ELSE
      Description := tb_AllFees.FieldByName('Description').AsString;

    // Set € fee
    // -----------------------------------------------------------------------
    IF tb_AllFees.FieldByName('DoNotApplyExchangeRate').AsBoolean = True Then
      euroFee := tb_AllFees.FieldByName('FeeCHF').AsFloat
    else
      euroFee := GetEuroFee(tb_AllFees.FieldByName('FeeCHF').AsFloat);

    If (defPM = 'PD') OR (defPM = 'OF') OR (euroFee = 0) Then
      NeedNullEuro := True
    else
      NeedNullEuro := False;

    // If MultiClick then set TxID (needed for multiple TXIDs in SevicesSold Table
    // -------------------------------------------------------------------------
    IF tb_AllFees.FieldByName('MultiClick').AsBoolean Then
      txID := GenerateTxID
    else
      txID := '';

    IF Active THEN
      Close;
    SQL.Clear;
    if NeedNullEuro then
      euroValue := 'CAST(NULL AS FLOAT)'
    else
      euroValue := floatToStr(euroFee);

    {
      SQL.Add('INSERT INTO OpenTab ' +
      '(txID, ClientID, GroupID, FeeID, SubFeeID, Description, ' +
      ' amountCHF, amountToPrint, amountEuro, ' +
      ' DrinkCredits, DrinkCreditValue, PosPrintItems, PrintQRCode, ' +
      ' BonusMalusID, BonusPoints, CostCenter, dAccount, aAccount, ' +
      ' Receipt, ReceiptCopies, DebitToGirl, isMasterFee, PayMethod, DefaultPayMethod, '  +
      ' CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, SurCharge, LifeTimeSpan, MultiClick, ' +
      'PrintLotteryTicket) ' +
      'SELECT ' + QuotedStr(Trim(txID)) + ', ' +
      intToStr(uClientStore.ThisClient.ID) + ', GroupID, ID, SubID, ' +
      QuotedStr(Trim(Description)) + ', FeeCHF, FeeCHF, ' + euroValue +
      ', DrinkCredits, DrinkCreditValue, PosPrintItems, PrintQRCode, ' +
      'BonusMalusID, BonusToEarn, CostCenter, dAccount, aAccount, ' +
      'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, ' + QuotedStr(defPM) +
      ', DefaultPayMethod, ' +
      'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, SurCharge, LifeTimeSpan, MultiClick, ' +
      'PrintLotteryTicket FROM Fees ' + 'WHERE Fees.SubID = ' + tb_AllFees.FieldByName('SubID')
      .AsString);
    }
    SQL.Add(
      'INSERT INTO OpenTab ' +
      '(txID, ClientID, GroupID, FeeID, SubFeeID, Description, ' +
      ' amountCHF, amountToPrint, amountEuro, ' +
      ' DrinkCredits, DrinkCreditValue, PosPrintItems, PrintQRCode, ' +
      ' BonusMalusID, BonusPoints, CostCenter, dAccount, aAccount, ' +
      ' Receipt, ReceiptCopies, DebitToGirl, isMasterFee, PayMethod, DefaultPayMethod, ' +
      ' CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, SurCharge, LifeTimeSpan, MultiClick, ' +
      ' PrintLotteryTicket) ' +

      'SELECT ' +
      QuotedStr(Trim(txID)) + ', ' +
      intToStr(uClientStore.ThisClient.ID) + ', ' +
      'GroupID, ID, SubID, ' +
      QuotedStr(Trim(Description)) + ', ' +
      'FeeCHF, FeeCHF, ' + euroValue + ', ' +
      'DrinkCredits, DrinkCreditValue, PosPrintItems, PrintQRCode, ' +
      'BonusMalusID, BonusToEarn, CostCenter, dAccount, aAccount, ' +
      'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, ' +
      QuotedStr(defPM) + ', DefaultPayMethod, ' +
      'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, SurCharge, LifeTimeSpan, MultiClick, ' +
      'PrintLotteryTicket ' +
      'FROM Fees ' +
      'WHERE Fees.SubID = ' +
      tb_AllFees.FieldByName('SubID').AsString
      );

    ExecSQL;
    tb_oTab.Refresh;

    // Update field TxID if '' set to Null otherwise automatically set to 13 empty characters ???
    // ------------------------------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('UPDATE OpenTab SET TxID = NULL WHERE TxID = '''' ');
    ExecSQL;

    // Write Bonus Malus data to openTab
    // -----------------------------------------------------------------------
    IF NOT tb_AllFees.FieldByName('BonusMalusReference').IsNull THEN
      BRefStr := Trim(tb_AllFees.FieldByName('BonusMalusReference').AsString);
    IF BRefStr <> '' THEN
      xx_ProcessBReferences(BRefStr);

    // Now add client, card ID  and operator
    // -----------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('UPDATE OpenTab SET ClientID = ' +
      intToStr(uClientStore.ThisClient.ID) + ', CardID = ' +
      intToStr(uClientStore.ThisCard.cardID) + ', Operator = ' +
      QuotedStr(Trim(cashier)));
    ExecSQL;

    // Now Check If client has valid  VT ticked
    // ------------------------------------------------------------------------
    barTxId := CheckIfHasBarCredit(uClientStore.ThisClient.ID);
    If barTxId <> '' Then
    begin
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('UPDATE OpenTab SET PayMethod = ''VT'', TmpTxID = ' +
        QuotedStr(barTxId) + ', amountEuro = NULL  WHERE SubFeeID = 9998');
      ExecSQL;
    END;

    // Update accounts to PD PayMethod
    // -----------------------------------------------------------------------
    WITH Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Add('UPDATE OpenTab SET dAccount = 1200 WHERE PayMethod = ''PD'' ');
      ExecSQL;
    end;

    // If (TXID = '') OR (TXID = NULL) Then
    xx_UpdateAllTxIDs;

    Form2.tb_oTab.Refresh;

    // IF tb_AllFees.FieldByName('ID').AsInteger <> 99 THEN  InsertIntoTabMem;
    dbgd_CashierDisplay.Refresh;

    CheckIfpaymethodComplete;
    // Save a copy
    // -----------------------------------------------------------------------
    IF NumKeyboard.Showing Then
    begin
      Form2.tb_oTab.Edit;
      Form2.tb_oTab.FieldByName('PayMethod').AsString := '';
      Form2.tb_oTab.Post;
      bt_Register.Enabled := False;
    end;
  END;
  dbgd_CashierDisplay.SumList.RecalcAll;
END;

procedure TForm1.xx_UpdateAllTxIDs;
var
  newID: string;
begin
  // 1) Open a cursor on just the rows that need TxID’s

  try
    Form2.qy_TMP.SQL.Text := 'SELECT  RowID, GroupID ' + 'FROM OpenTab ' +
      'WHERE (TxID IS NULL OR TxID = '''')';
    Form2.qy_TMP.Active := True;

    // 2) Prepare your update once

    Form2.qy_Tmp2.SQL.Text :=
      'UPDATE OpenTab SET TxID = :TxID WHERE GroupID = :GroupID';

    // 3) Loop over each “empty‐TxID” row
    while not Form2.qy_TMP.EOF do
    begin
      // decide which generator to use by GroupID
      case Form2.qy_TMP.FieldByName('GroupID').AsInteger of
        0, 1200, 1290, 1300, 2000, 3000, 4000, 4560, 8000, 9900, 9940:
          newID := GenerateTxID;
      else
        newID := '';
        // or skip entirely if you don’t want to touch other groups
      end;

      if newID <> '' then
      begin
        Form2.qy_Tmp2.ParamByName('TxID').AsString := newID;
        Form2.qy_Tmp2.ParamByName('GroupID').AsInteger :=
          Form2.qy_TMP.FieldByName('GroupID').AsInteger;
        Form2.qy_Tmp2.ExecSQL;
      end;

      Form2.qy_TMP.Next;
    end;
  finally
    // srcQry.Free;
    // updQry.Free;
  end;
end;

PROCEDURE TForm1.InsertIntoTabMem;
BEGIN
  WITH Form2 DO
  BEGIN
    tb_OTabMemory.Active := True;
    IF tb_OTabMemory.RecordCount < 1 THEN
      WITH qy_TMP DO
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('INSERT INTO OpenTabMemory SELECT * FROM OpenTab');
        ExecSQL;
        tb_OTabMemory.Refresh;
      END;
  END;
END;

// This procedure adds all the bonus/malus fees to the OpenTab table
PROCEDURE TForm1.xx_ProcessBReferences(BReferences: STRING);
VAR
  IDList: TStringList;
  ID, s, PM, chAmt, euAmt: STRING;
  bonusNeeded, bonusEarned: Integer;
BEGIN
  // Split the BReferences string into individual IDs
  IDList := TStringList.Create;
  TRY
    // IDs are separated by commas
    ExtractStrings([','], [' '], PChar(BReferences), IDList);
    FOR ID IN IDList DO
    BEGIN
      IF ID.Trim.IsEmpty THEN
        Continue;
      // Drop by client pays no taxes fee but supplement
      IF (InRange(uClientStore.ThisCard.cardID, 6000, 6999)) AND
        (ID = '9998') Then
        Continue;
      // Regular client pays towel fee but no drop by supplement
      IF (InRange(uClientStore.ThisCard.cardID, 3000, 5999)) AND
        (ID = '900') Then
        // 900 = drop by client
        // Drop by client pays no towel fee
        Continue;

      WITH Form2, qy_oTabfees DO
      BEGIN
        IF Active THEN
          Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM Fees WHERE SubID = ' + ID);
        Active := True;

        // Check if bonus/malus entrance fee and if cutoff count reached
        // -----------------------------------------------------------------
        IF (FieldByName('BonusNeeded').AsInteger > 0) AND
          (Not uClientStore.ThisClient.HasSurCharge) THEN
          Continue;

        IF FieldByName('BonusNeeded').AsInteger > 0 THEN
        BEGIN
          WITH qy_Tmp2 DO
          BEGIN
            IF Active THEN
              Close;
            SQL.Clear;
            SQL.Add('SELECT COALESCE(Count(FeeID),0) AS sbonusEarned FROM c_1000 '
              + ' WHERE ClientID = ' + intToStr(uClientStore.ThisClient.ID) +
              ' AND Canceled = False ' +
              ' AND FeeID in (4,5,6)  AND Data >= TIMESTAMP ' +
              QuotedStr(EDBEngine1.DateTimeToSQLStr(sDt, True)) +
              ' AND Data <= TIMESTAMP ' +
              QuotedStr(EDBEngine1.DateTimeToSQLStr(eDT, True)));
            Active := True;

            IF FieldValues['sbonusEarned'] > 0 THEN
              bonusEarned := FieldValues['sbonusEarned']
            ELSE
              bonusEarned := 0;
            qy_Tmp2.Active := False;
          END;

          // If max malus already reached
          // (hence no entrance supplement)  then continue
          // -------------------------------------------------------------
          // IF FieldByName('ID').AsInteger = 98 THEN
          IF (qy_oTabfees.FieldByName('BonusNeeded').AsInteger <=
            bonusEarned) THEN
            Continue;
        END;

        // Check if Towel Fee TF is due
        // ------------------------------------------------------------------
        IF ID = intToStr(390) Then // TF SubFeeID = 390
        begin
          IF rg_TowelFee.ItemIndex = 2 Then // No towel fee
            Continue;

          IF rg_TowelFee.ItemIndex = 1 Then
          // Cancel TF if Superior or Suite already used
          begin
            With Form2.qy_TMP do
            begin
              SQL.Clear;
              SQL.Text :=
                'SELECT COALESCE(Count(FeeID),0) AS supCount FROM ServicesSold'
                + ' WHERE FeeID IN (5,6) AND ClientID = ' +
                intToStr(uClientStore.ThisClient.ID) +
                ' AND SoldDT >= TIMESTAMP ' +
                QuotedStr(EDBEngine1.DateTimeToSQLStr(sDt, True)) +
                ' AND SoldDT <= TIMESTAMP ' +
                QuotedStr(EDBEngine1.DateTimeToSQLStr(eDT, True));
              Open;
              var
              supCount := FieldByName('supCount').AsInteger;
              Close;
              IF supCount > 0 Then
                Continue;
              // Credit back of already payed TF happens on feeid 3 checkout at
              // end of workday
            end;
          end;
        end;

        // -----------------------------------------------------------------

        // Check if daily state tax owed and check if client ows tax
        // -----------------------------------------------------------------
        IF (ID = intToStr(9999)) AND (NOT uClientStore.ThisClient.Taxed) THEN
        // 9999 Income tax Fee
        BEGIN
          IF MessageDlg('Imposte alla fonte per ' +
            uClientStore.ThisClient.alias + ' sono disattivate!. È corretto? ',
            mtConfirmation, [mbOK, mbNo], 0, mbOK) = mrOk THEN
            Continue;
        END;

        // Check if daily income tax already payed
        // -----------------------------------------------------------------
        IF (ID = intToStr(9999)) AND
          (nTaxPayed(uClientStore.ThisClient.ID)) THEN
        BEGIN
          nnWriteCashierDisplay(0, False, clWhite,
            'Imposta alla fonte già pagata.', 1);
          Continue;
        END;

        // Check iF client has RR room else continue
        // -----------------------------------------------------------------
        IF (ID = '222') AND ((uClientStore.ThisBooking.bookingID <= 0) OR
          (RentalData.PayedUntilDate >= IncDay(Date, 1))) THEN
          Continue;

        // Now write Bonus Malus to OpenTab
        // -----------------------------------------------------------------
        IF RecordCount > 0 THEN
        BEGIN
          WITH Form2, qy_TMP DO
          BEGIN
            IF (qy_oTabfees.FieldByName('DefaultPayMethod').AsString = 'PD') OR
              (qy_oTabfees.FieldByName('DefaultPayMethod').AsString = 'OF') THEN
              PM := qy_oTabfees.FieldByName('DefaultPayMethod').AsString
            ELSE
              PM := '';

            chAmt := qy_oTabfees.FieldByName('FeeCHF').AsString;

            IF qy_oTabfees.FieldByName('DoNotApplyExchangeRate')
              .AsBoolean = True Then
              euAmt := chAmt
            else
              euAmt := floatToStr(GetEuroFee(qy_oTabfees.FieldByName('FeeCHF')
                .AsFloat));

            Var
              NeedNullEuro: Boolean;
            Var
              euroValue: String;
            If (PM = 'PD') OR (PM = 'OF') OR (strToFloat(euAmt) = 0) Then
              NeedNullEuro := True
            else
              NeedNullEuro := False;

            if NeedNullEuro then
              euroValue := 'CAST(NULL AS FLOAT)'
            else
              euroValue := euAmt;

            IF Active THEN
              Close;
            SQL.Clear;

            // Rental charge oTab
            // -----------------------------------------------------------------
            IF (ID = '222') AND
              (RentalData.PayedUntilDate < IncDay(Date, 1)) THEN
            // xx_WriteRentOwedToOtab  // >> already done in Read
            begin
              s := 'INSERT INTO OpenTab ' + '(GroupID,FeeID,SubFeeID, ' +
                'Description,' +
                'amountCHF,amountToPrint,amountEuro,DrinkCredits,DrinkCreditValue, '
                + 'PosPrintItems, PrintQRCode, BonusMalusID,CostCenter,dAccount,aAccount, '
                + 'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, PayMethod, DefaultPayMethod, '
                + 'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt,BonusPoints) ' +
                'SELECT  GroupID,ID,SubID,Description,' + chAmt + ',' + chAmt +
                ',' + euAmt + ',DrinkCredits,DrinkCreditValue,' +
                'PosPrintItems,PrintQRCode, BonusMalusID,CostCenter,dAccount, aAccount, '
                + 'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, ' +
                QuotedStr(PM) + ', DefaultPayMethod, ' +
                'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, BonusToEarn ' +
                'FROM Fees ' + 'WHERE Fees.SubID = ' + qy_oTabfees.FieldByName
                ('SubID').AsString;
            end;

            IF ID = '998' THEN // Credit card commission
            begin
              s := 'INSERT INTO OpenTab ' + '(GroupID,FeeID,SubFeeID, ' +
                'Description,' +
              // 'amountCHF,amountToPrint,amountEuro, ' +
                'PosPrintItems, PrintQRCode, BonusMalusID,CostCenter,dAccount,aAccount, '
                + 'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,PayMethod,DefaultPayMethod, '
                + 'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt) SELECT ' +
                'GroupID,ID,SubID,Description,' +
                'PosPrintItems,PrintQRCode, BonusMalusID,CostCenter,dAccount,aAccount,'
                + 'Receipt,ReceiptCopies,DebitToGirl,isMasterFee,' +
                QuotedStr(PM) + ',DefaultPayMethod, ' +
                'CH,EU,CC,PD,OF,PrintThisFeeOnReceipt ' + 'FROM Fees ' +
                'WHERE Fees.SubID = ' + qy_oTabfees.FieldByName
                ('SubID').AsString;
            end
            else
            begin
              s := 'INSERT INTO OpenTab ' + '(GroupID,FeeID,SubFeeID, ' +
                'Description,' +
                'amountCHF,amountToPrint,amountEuro,DrinkCredits,DrinkCreditValue, '
                + 'PosPrintItems, PrintQRCode, BonusMalusID,CostCenter,dAccount,aAccount, '
                + 'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, PayMethod, DefaultPayMethod, '
                + 'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt,BonusPoints) ' +
                'SELECT  GroupID,ID,SubID,Description,' + chAmt + ',' + chAmt +
                ',' + euAmt + ',DrinkCredits,DrinkCreditValue,' +
                'PosPrintItems,PrintQRCode, BonusMalusID,CostCenter,dAccount, aAccount, '
                + 'Receipt, ReceiptCopies, DebitToGirl, isMasterFee, ' +
                QuotedStr(PM) + ', DefaultPayMethod, ' +
                'CH, EU, CC, PD, OF, PrintThisFeeOnReceipt, BonusToEarn ' +
                'FROM Fees ' + 'WHERE Fees.SubID = ' + qy_oTabfees.FieldByName
                ('SubID').AsString;
            end;

            If s <> '' Then
            begin
              SQL.Add(s);
              ExecSQL;
              tb_oTab.Refresh;
            end;
          END;
        END;
      END;
    END;
  FINALLY
    IDList.Free;
  END;
END;

FUNCTION TForm1.GetRentalDepositAmt(AGuestID: Integer): uClientStore.TBooking;
VAR
  ResultInfo: uClientStore.TBooking;
BEGIN
  // Check if client has a rental booking
  // ----------------------------------------------------------------------------
  WITH Form2, qy_Tmp2 DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT BookingID, CheckInDate, b.Name FROM RREU_Bookings ' +
      'LEFT JOIN RREU_RentalRooms r ON RoomID = r.RoomID ' +
      'LEFT JOIN RREU_Buildings b ON r.BuildingID = b.BuildingID ' +
      'WHERE GuestID = ' + intToStr(uClientStore.ThisClient.ID) +
      ' AND Not CheckInDate IS NULL AND CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP '
      + QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)));
    Active := True;
    IF (RecordCount > 0) THEN
    BEGIN
      ResultInfo.guestID := AGuestID;
      ResultInfo.bookingID := FieldValues['BookingID'];
      ResultInfo.Address := FieldValues['Name'];
      ResultInfo.checkInDt := FieldValues['CheckInDate'];
    END
    ELSE
    BEGIN
      ResultInfo.bookingID := 0; // Has no booking
      Exit;
    END;

    // Check if rental deposit payed
    // -----------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add(' SELECT txid,b.txid, COALESCE(Dare,0) AS dAmt, COALESCE(Avere,0) AS aAmt,'
      + 'Max(Data) AS Data, b.BookingID, PayMethod, u.Name FROM c_1200 ' +
      'LEFT JOIN RREU_Bookings AS b ON b.TXID = TXID ' +
      'LEFT JOIN RREU_RentalRooms AS r ON b.BookingID = r.BookingID ' +
      'LEFT JOIN RREU_Buildings as u ON r.BuildingID = u.BuildingID ' +
      'WHERE ClientID = ' + intToStr(AGuestID) + ' AND NOT b.txid IS NULL ' +
      'AND FeeID = 200 AND SubFeeID = 299 ' +
      'AND CheckOutDate IS NULL OR CheckOutDate > TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)) +
      'GROUP BY b.BookingID');
    Active := True;
    IF (RecordCount > 0) AND (FieldValues['dAmt'] - FieldValues['aAmt'] < 0)
    THEN // Deposit OUT
    BEGIN

      ResultInfo.bookingID := FieldValues['BookingID'];
      ResultInfo.txID := FieldValues['TxID'];
      ResultInfo.depositAmtPayed := FieldValues['dAmt'] - FieldValues['aAmt'];
      // minus value = We owe
      ResultInfo.Address := FieldValues['Name'];
      ResultInfo.depositPayMethod := FieldValues['PayMethod'];
      ResultInfo.DepositINdt := FieldValues['Data'];
      ResultInfo.reemboursment := True;
      Active := False;
      Result := ResultInfo;
      Exit;
    END
    ELSE
    BEGIN
      ResultInfo.depositAmtPayed := 0; // Deposit not yet payed
      ResultInfo.Address := '';
      Result := ResultInfo;
    END;
    Active := False;

    // If Deposit not yet payed get room's deposit amount
    // -----------------------------------------------------------------------
    IF ResultInfo.depositAmtPayed = 0 THEN
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Add('SELECT Deposit, b.BookingID, build.Name  FROM RREU_RentalRooms rr '
        + 'LEFT JOIN RREU_Bookings b ON rr.BookingID = b.BookingID ' +
        'LEFT JOIN RREU_Buildings build ON rr.BuildingID = build.BuildingID ' +
        'WHERE b.GuestID = ' + intToStr(AGuestID));
      Active := True;
      IF RecordCount > 0 THEN
      BEGIN
        ResultInfo.bookingID := FieldValues['BookingID'];
        ResultInfo.depositAmtPayed := FieldValues['Deposit'];
        ResultInfo.Address := FieldValues['Name'];
        ResultInfo.reemboursment := False;
        Result := ResultInfo;
      END;
      Active := False;
    END;
    uClientStore.ThisBooking := ResultInfo;
  END;
END;

FUNCTION TForm1.nnIsTimeInRange(nowTime: TDateTime): Boolean;
VAR
  sT, eT: TDateTime;
BEGIN
  // Check if this fee has a time of day limit
  // -----------------------------------------
  WITH Form2.tb_Fees DO
    IF (FieldByName('StartT').AsDateTime <> NULL) AND
      (FieldByName('EndT').AsDateTime <> NULL) THEN
    BEGIN
      sT := FieldByName('StartT').AsDateTime;
      eT := FieldByName('EndT').AsDateTime;
      // First check if Now is after midnight and before eT
      IF (TimeOf(nowTime) > EncodeTime(0, 0, 0, 0)) AND
        (TimeOf(nowTime) <= TimeOf(eT)) THEN
        // after 00:00 and before eT
        sT := IncDay(nowTime, -1) + sT;
      IF (TimeOf(Now) >= sT) AND
        (TimeOf(Now) < EncodeTime(23, 59, 59, 999)) THEN
        eT := IncDay(nowTime, 1) + eT;
      Result := DateTimeInRange(Now, sT, eT)
    END;
END;

PROCEDURE TForm1.nsg_CashierDisplayGetAlignment(Sender: TObject;
ARow, ACol: Integer; VAR HAlign: TAlignment; VAR VAlign: TVAlignment);
BEGIN
  IF ACol = 2 THEN
    HAlign := taRightJustify;
END;

FUNCTION TForm1.nTaxPayed(ClientID: Integer): Boolean;
Var
  s: String;
  Ts: Double;
BEGIN
  // ---------------------------------
  // check if daily tax already payed
  // ---------------------------------
  With Form2.qy_TMP do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Max(EndUse) AS mT FROM ServicesSold ' + 'WHERE ClientID = '
      + intToStr(ClientID) + ' AND FeeID = 3 ');
    Active := True;
    If RecordCount > 0 Then
      Ts := MinuteSpan(Now, FieldByName('mT').AsDateTime)
    else
      Ts := 100;
    Active := False;
    IF Ts <= 5 then
      s := 'SELECT Dare FROM c_2900 ' + 'WHERE SubFeeID = 9999 AND ClientID = '
        + intToStr(ClientID) + ' AND Canceled = False ' +
        ' AND Data >= TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(sDt, True)) +
        ' AND Data <= TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(eDT, True))
    else
      s := 'SELECT c.Dare, s.Valid FROM c_2900 c ' +
        ' LEFT JOIN ServicesSold s ON c.ClientID = s.ClientID ' +
        'WHERE c.SubFeeID = 9999 AND c.ClientID = ' + intToStr(ClientID) +
        ' AND Canceled = False AND s.Valid = True  AND c.Data >= TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(sDt, True)) +
        ' AND c.Data <= TIMESTAMP ' +
        QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(eDT, True));
  end;

  WITH Form2.tb_Fees DO
  BEGIN
    WITH Form2.qy_TMP DO
    BEGIN
      SQL.Clear;
      SQL.Add(s);
      Active := True;
      IF RecordCount > 0 THEN
        Result := True
      ELSE
        Result := False;
      Active := False;
    END;
  END;
END;

PROCEDURE TForm1.xx_GetBookingData(guestID: Integer);
var
  ADate: TDateTime;
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM RREU_Bookings rrB ' +
      'LEFT JOIN RREU_RentalRooms rr ON rrB.BookingID = rr.BookingID ' +
      'WHERE GuestID = ' + intToStr(uClientStore.ThisClient.ID) + ' AND ' +
      'CheckOutDate IS NULL OR CheckOutDate > TIMESTAMP ' +
      QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)));
    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      WITH uClientStore.ThisBooking DO
      BEGIN
        guestID := FieldValues['GuestID'];
        bookingID := FieldValues['BookingID'];
        IF NOT VarIsNull(FieldValues['BuildingID']) THEN
          buildingID := FieldValues['BuildingID']
        ELSE
          buildingID := 0;
        IF NOT VarIsNull(FieldValues['ApartmentID']) THEN
          apartmentID := FieldValues['ApartmentID']
        ELSE
          apartmentID := 0;
        IF NOT VarIsNull(FieldValues['RoomID']) THEN
          roomID := FieldValues['RoomID']
        ELSE
          roomID := 0;
        IF NOT VarIsNull(FieldValues['BedID']) THEN
          bedID := FieldValues['BedID']
        ELSE
          bedID := 0;
        singleOccupancy := FieldValues['SingleOccupancy'];
        IF NOT VarIsNull(FieldValues['CheckInDate']) THEN
          checkInDt := FieldValues['CheckInDate']
        ELSE
          checkInDt := 0;
        IF NOT VarIsNull(FieldValues['CheckOutDate']) THEN
          checkOutDt := FieldValues['CheckOutDate']
        ELSE
          checkOutDt := 0;
        IF NOT VarIsNull(FieldValues['DepositAmountPayed']) THEN
          depositAmtPayed := FieldValues['DepositAmountPayed'];
        IF NOT VarIsNull(FieldValues['DepositAmountPayMethod']) THEN
          depositPayMethod := FieldValues['DepositAmountPayMethod'];
        IF NOT VarIsNull(FieldValues['DataDepositIN']) THEN
          DepositINdt := FieldValues['DataDepositIn']
        ELSE
          DepositINdt := 0;

        // ****************************************
        // Room rate calculated in xx_GetRentalData
        // ****************************************
      END;
      WITH RentalData DO
      BEGIN
        IF NOT VarIsNull(FieldValues['PayedUntilDate']) THEN
          PayedUntilDate := FieldValues['PayedUntilDate']
        ELSE
          PayedUntilDate := 0;
      END;
      Active := False;
    END
    ELSE
      uClientStore.ThisBooking.bookingID := -1;
  END;
  ADate := uClientStore.ThisBooking.checkInDt;
END;

FUNCTION TForm1.IsTimeBetween(CONST ATime, AStartTime, AEndTime: TTime)
  : Boolean;
BEGIN
  IF AStartTime < AEndTime THEN
    Result := (ATime >= AStartTime) AND (ATime <= AEndTime)
  ELSE
    Result := (ATime >= AStartTime) OR (ATime <= AEndTime);
END;

PROCEDURE TForm1.nnSetPecuniaBtUp;
BEGIN
  bt_CH.Down := False;
  bt_EU.Down := False;
  bt_CC.Down := False;
  bt_PD.Down := False;
  bt_OF.Down := False;
END;

PROCEDURE TForm1.nn_EnablePecuniaBt(enable: Boolean);
BEGIN
  bt_CH.Enabled := enable;
  bt_EU.Enabled := enable;
  bt_CC.Enabled := enable;
  bt_PD.Enabled := enable;
  bt_OF.Enabled := enable;
END;

PROCEDURE TForm1.nn_SetPecuniaBtToFieldValue;
BEGIN
  WITH Form2.tb_oTab DO
  BEGIN
    bt_CH.Enabled := FieldByName('CH').AsBoolean;
    bt_EU.Enabled := FieldByName('EU').AsBoolean;
    bt_CC.Enabled := FieldByName('CC').AsBoolean;
    bt_PD.Enabled := (FieldByName('PD').AsBoolean) AND
      (uClientStore.ThisClient.balanceDue <= 0);
    bt_OF.Enabled := FieldByName('OF').AsBoolean;
  END;
END;

PROCEDURE TForm1.nn_CloseDailyFee;
Var
  Count5, count6, count390: Integer;
  towelFee: Double;
BEGIN
  towelFee := 0;
  WITH Form2 DO
  BEGIN
    Count5 := 0;
    count6 := 0;
    count390 := 0;
    // -----------------------------------------------------------------------
    // Close daily fee: void Lst tx valid daily fee, update clients in house
    // -----------------------------------------------------------------------
    t_executequery('UPDATE ServicesSold SET Valid = False, CheckedOut = True, '
      + ' ENDUSE = Current_TimeStamp ' + 'WHERE ClientID = ' +
      intToStr(uClientStore.ThisClient.ID) + ' AND TXID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro',
      'ServicesSold');
    Sleep(20);
    t_executequery('UPDATE Clients SET CheckedIn = False ' + ' WHERE ID = ' +
      intToStr(uClientStore.ThisClient.ID) +
      intToStr(uClientStore.ThisClient.ID), 'DB_Main', 'PGC_DB_Main_Euro',
      'Clients');

    // Check Towel Fee situation
    // ------------------------------------------------------------------------
    If rg_TowelFee.ItemIndex = 1 Then
    begin
      // Check if TF to pay back
      WITH Form2.qy_TMP do
      begin
        If Active Then
          Close;
        SQL.Clear;
        SQL.Text := 'SELECT ' +
          '  COUNT(CASE WHEN FeeID = 4 THEN 1 END) AS Count_Fee4, ' +
          '  COUNT(CASE WHEN FeeID = 5 THEN 1 END) AS Count_Fee5, ' +
          '  COUNT(CASE WHEN FeeID = 6 THEN 1 END) AS Count_Fee6, ' +
          '  COUNT(CASE WHEN SubFeeID = 390 THEN 1 END) AS Count_SubFee390 ' +
          'FROM c_1000 ' + 'WHERE (FeeID IN (4, 5, 6) OR SubFeeID = 390) ' +
          '  AND Data BETWEEN :StartDate AND :EndDate ' +
          '  AND ClientID = :ClientID';
        Params.ParamByName('StartDate').AsDate := sDt;
        Params.ParamByName('EndDate').AsDate := eDT;
        Params.ParamByName('ClientID').AsInteger := uClientStore.ThisClient.ID;
        Open;
        If RecordCount > 0 Then
        begin
          Count5 := FieldByName('Count_Fee5').AsInteger;
          count6 := FieldByName('Count_Fee6').AsInteger;
          count390 := FieldByName('Count_SubFee390').AsInteger;
        end;
        If Active Then
          Close;
        SQL.Clear;
        SQL.Text := 'SELECT FeeCHF FROM Fees WHERE SubID = 390 ';
        If RecordCount > 0 Then
          towelFee := count390 * FieldByName('FeeCHF').AsFloat;
        If towelFee > 0 Then
        begin
          // Show cashier client's TF credit
          nnWriteCashierDisplay(0, False, clWhite,
            'Credito TF di ' + uClientStore.ThisClient.alias + ': ' +
            floatToStr(towelFee) + ' CHF', 2);
        end;
      end;
    end;
    nnSetCashierDisplayColor(clAqua);
    nnWriteCashierDisplay(0, False, clLime, LastTxData.lTxFeeDesc +
      ' chiusa.', 2);
    xx_CheckIfStillPresent;
    bt_Cancel.Enabled := False;
    Form2.tb_ServicesSold.Refresh;
  END;
END;

PROCEDURE TForm1.xx_CloseUnusedRoom;
BEGIN
  WITH Form2 DO
  BEGIN
    xx_VacantRoom;
    Sleep(20);
    t_executequery('UPDATE c_1000 SET Canceled = True WHERE TxID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro', 'c_1000');
    Sleep(20);
    t_executequery('UPDATE c_1200 SET Canceled = True WHERE TxID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro', 'c_1200');
    Sleep(20);
    t_executequery('UPDATE c_2900 SET Canceled = True WHERE TxID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro', 'c_2900');
    Sleep(20);
    t_executequery('UPDATE c_6000 SET Canceled = True WHERE TxID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro', 'c_6000');
    Sleep(20);
    t_executequery('UPDATE c_5000 SET Canceled = True WHERE TxID = ' +
      QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro', 'c_5000');
    Sleep(20);
    t_executequery
      ('UPDATE ServicesSold SET Canceled = True, Valid = False, BonusPoints = 0 WHERE TxID = '
      + QuotedStr(LastTxData.lTxID), 'DB_Main', 'PGC_DB_Main_Euro',
      'ServicesSold');
    Sleep(20);
    s := 'UPDATE Bar_SoldByDetail SET VatTXID = NULL, Avere = Null, DataModified = NULL '
      + 'WHERE VatTxID = ' + QuotedStr(LastTxData.lTxID);
    t_executequery(s, 'DB_Bar', 'PGC_Bar', 'Bar_OpLedger');
    nnSetCashierDisplayColor(clAqua);

    bt_Cancel.Enabled := False;
  END;
END;

PROCEDURE TForm1.xx_CloseUsedRoom;
VAR
  s: STRING;
BEGIN
  If pc_MainPageC.ActivePageIndex <> 0 Then
    Exit;
  xx_VacantRoom;
  s := 'UPDATE ServicesSold SET Valid = False, CheckedOut = True, ' +
    ' ENDUSE = Current_TimeStamp ' + ' WHERE ClientID = ' +
    intToStr(uClientStore.ThisClient.ID) + ' AND SubFeeID = ' +
    intToStr(LastTxData.lTxSubFeeID) + ' AND TxID = ' +
    QuotedStr(LastTxData.lTxID) + ' AND FeeID <> 3 ';
  Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'ServicesSold');
  nnSetCashierDisplayColor(clAqua);
END;

PROCEDURE TForm1.xx_VacantRoom;
VAR
  s, readerID, actuatorID: STRING;
  serviceID: Integer;
BEGIN
  // ---------------------------------------------------------
  // Write usage to Servicessold and Service,
  // then set reader led to green and turn the lights off
  // ---------------------------------------------------------
  serviceID := 0;
  IF LastTxData.lTxFeeID IN [4, 5, 6] THEN
  BEGIN
    WITH Form2 DO
    BEGIN
      IF tb_Services.Locate('CardInID',
        intToStr(uClientStore.ThisCard.cardID), []) THEN
      BEGIN
        // set reader led to green
        serviceID := tb_Services.FieldByName('ID').AsInteger;
        readerID := Format('%.*d',
          [2, StrToIntDef(tb_Services.FieldByName('CardReader').AsString, 0)]);
        actuatorID := Format('%.*d',
          [2, StrToIntDef(tb_Services.FieldByName('Actuator').AsString, 0)]);
        WITH MGuardClient1 DO
        BEGIN
          MgRecordType := 'C';
          MgCommandCode := '37';
          MgEventDescr := ledOff;
          MgDeviceAddress := readerID;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgCommandCode := '37';
          MgEventDescr := ledGreen;
          MgDeviceAddress := readerID;
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgDeviceAddress := actuatorID;
          MgEventDescr := '1';
          MgCommandCode := '23'; // relais off
          SendToMGuardSrv;
          Sleep(sleepTm);
          MgRecordType := 'C';
          MgDeviceAddress := actuatorID;
          MgEventDescr := '2';
          MgCommandCode := '23'; // relais off
          SendToMGuardSrv;
          Sleep(sleepTm);
        END;
      END;
      s := 'UPDATE Services SET CardInID = 0, LastEventDescr = ' +
        QuotedStr('Liberata') +
        ', LastEventDT = CURRENT_TIMESTAMP WHERE CARDInID = ' +
        intToStr(uClientStore.ThisCard.cardID);
      t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'Services');
    END;
    IF Length(c_ServiceOwnedByCardID_Arr) > 0 THEN
      c_ServiceOwnedByCardID_Arr[serviceID] := 0;
  END;
END;

PROCEDURE TForm1.xx_WriteOtabToAccounts;

// ── local helper ──────────────────────────────────────────────────────────
  procedure InsertAccountLine(qSrc: TDataSet; qDst: TEDBQuery;
  const TableAccount: string; // actual table suffix e.g. '1000', '1020'
  const AmountField: string; // 'Dare' or 'Avere'
  amt: Double; const txID: string; cPartitaAccount: Integer);
  var
    tbl: string;
  begin
    tbl := 'c_' + TableAccount;
    if not TRegEx.IsMatch(tbl, '^c_\d+$') then
      raise Exception.Create('Invalid account table name: ' + tbl);

    with qDst do
    begin
      SQL.Clear;
      SQL.Text := 'INSERT INTO ' + tbl +
        ' (Data, ClientID, CardID, Description, ' + AmountField +
        ', FeeID, SubFeeID,' +
        '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID)'
        + ' VALUES (CURRENT_TIMESTAMP, :clientID, :cardID, :descr, :amt,' +
        '         :feeID, :subFeeID, :verified, :canceled,' +
        '         :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid)';

      Params.ParamByName('clientID').AsInteger := qSrc.FieldByName('ClientID')
        .AsInteger;
      Params.ParamByName('cardID').AsInteger := qSrc.FieldByName('CardID')
        .AsInteger;
      Params.ParamByName('descr').AsString :=
        qSrc.FieldByName('Description').AsString;
      Params.ParamByName('amt').AsFloat := amt;
      Params.ParamByName('feeID').AsInteger := qSrc.FieldByName('FeeID')
        .AsInteger;
      Params.ParamByName('subFeeID').AsInteger := qSrc.FieldByName('SubFeeID')
        .AsInteger;
      Params.ParamByName('verified').AsBoolean := False;
      Params.ParamByName('canceled').AsBoolean := False;
      Params.ParamByName('payMethod').AsString :=
        qSrc.FieldByName('PayMethod').AsString;
      Params.ParamByName('costCenter').AsString :=
        qSrc.FieldByName('CostCenter').AsString;
      Params.ParamByName('operator').AsString :=
        Trim(qSrc.FieldByName('Operator').AsString);
      Params.ParamByName('receipt').AsBoolean := qSrc.FieldByName('Receipt')
        .AsBoolean;
      Params.ParamByName('cPartita').AsInteger := cPartitaAccount;
      Params.ParamByName('txid').AsString := txID;
      ExecSQL;
    end;
  end;
// ── end local helper ──────────────────────────────────────────────────────

VAR
  oldTxID, NewTxID, txID: STRING;
  amt: Double;
  dAcc, aAcc: Integer;
  dAccStr, aAccStr: String;
BEGIN
  txID := '';
  oldTxID := '';
  NewTxID := '';

  IF ClubAccPermissions.ClosingP < 1 THEN
    Exit;

  // ---------------------
  // 1000 Cassa
  // 1010 Fondo cassa
  // 1020 IBAN payments CC to g
  // 1200 Debitors
  // 2900 Creditors
  // 5000 Income
  // 6000 Expenses
  // ---------------------

  // Printer error warning
  // ---------------------------------------------------------------------------
  IF (Form2.tb_Fees.FieldByName('ReceiptID').AsInteger > 0) AND
    (cb_settings_PrintCB.Checked) AND (GetCurrentPrinterStatus <> 0) THEN
  BEGIN
    nnWriteCashierDisplay(0, True, clYellow,
      'Errore stampante: (printer status = ' + intToStr(GetCurrentPrinterStatus)
      + ')', 0);
    nnWriteCashierDisplay(0, False, clYellow,
      'La registrazione non può essere eseguita!', 1);
    Exit;
  END;

  // Disable pecunia buttons
  // ---------------------------------------------------------------------------
  nn_EnablePecuniaBt(False);

  // Register openTab record data to accounts
  // ---------------------------------------------------------------------------
  WITH Form2, qy_TMP DO
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM OpenTab');
    Active := True;
    First;

    WHILE NOT EOF DO
    BEGIN
      // Get amounts
      // ------------------------------------------------------------------------
      IF FieldByName('PayMethod').AsString = 'EU' THEN
        amt := FieldByName('AmountEuro').AsFloat
      ELSE
        amt := FieldByName('AmountCHF').AsFloat;

      // Get a TxID if none
      // ------------------------------------------------------------------------
      IF Trim(FieldByName('TxID').AsString) <> '' THEN
        oldTxID := FieldByName('TxID').AsString;
      IF ((Trim(FieldByName('TxID').AsString) = '') OR
        (FieldByName('TxID').IsNull)) AND (NewTxID = '') THEN
        NewTxID := GenerateTxID;
      IF (Trim(FieldByName('TxID').AsString) = '') OR
        (FieldByName('TxID').IsNull) THEN
        txID := NewTxID
      ELSE
        txID := oldTxID;

      // Cache account values for this row
      // ------------------------------------------------------------------------
      dAcc := FieldByName('dAccount').AsInteger;
      aAcc := FieldByName('aAccount').AsInteger;
      dAccStr := FieldByName('dAccount').AsString;
      aAccStr := FieldByName('aAccount').AsString;

      WITH qy_Tmp2 DO
      BEGIN
        TRY
          IF Active THEN
            Close;

          // Main account (Dare)
          // ----------------------------------------------------------------------
          InsertAccountLine(qy_TMP, qy_Tmp2, dAccStr, 'Dare', amt, txID, aAcc);

          // Contropartita account (Avere)
          // ----------------------------------------------------------------------
          IF aAcc > 0 THEN
            InsertAccountLine(qy_TMP, qy_Tmp2, aAccStr, 'Avere', amt,
              txID, dAcc);

          // Extra pair only when aAccount = 1020 (IBAN payment)
          // ----------------------------------------------------------------------
          // amt goes from 1000 to 1020 and them from 1020 to 2900

          IF dAcc = 1020 THEN
          BEGIN
            InsertAccountLine(qy_TMP, qy_Tmp2, '2900', 'Dare', amt, txID, 1020);
            InsertAccountLine(qy_TMP, qy_Tmp2, '1020', 'Avere', amt,
              txID, 2900);
          END;

          // If later PD Payment registration - update with effective paymethod and amount
          // ----------------------------------------------------------------------
          IF aAcc = 1200 THEN
          BEGIN
            SQL.Clear;
            SQL.Add('UPDATE c_1200 SET PayMethod = ' +
              QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ', Dare = '
              + floatToStr(amt) + ' WHERE ClientID = ' +
              qy_TMP.FieldByName('ClientID').AsString +
              '   AND PayMethod = ''PD''' + '   AND SubFeeID = ' +
              qy_TMP.FieldByName('SubFeeID').AsString + '   AND TxID = ' +
              QuotedStr(txID));
            ExecSQL;

            SQL.Clear;
            SQL.Add('UPDATE c_2900 SET PayMethod = ' +
              QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ', Avere = '
              + floatToStr(amt) + ' WHERE ClientID = ' +
              qy_TMP.FieldByName('ClientID').AsString +
              '   AND PayMethod = ''PD''' + '   AND SubFeeID = ' +
              qy_TMP.FieldByName('SubFeeID').AsString + '   AND TxID = ' +
              QuotedStr(txID));
            ExecSQL;

            SQL.Clear;
            SQL.Add('UPDATE c_5000 SET PayMethod = ' +
              QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ', Avere = '
              + floatToStr(amt) + ' WHERE ClientID = ' +
              qy_TMP.FieldByName('ClientID').AsString +
              '   AND PayMethod = ''PD''' + '   AND SubFeeID = ' +
              qy_TMP.FieldByName('SubFeeID').AsString + '   AND TxID = ' +
              QuotedStr(txID));
            ExecSQL;

            xx_CloseUsedRoom;
          END;

          // ServicesSold (modified including 399 changing bonuspoints deprecated)
          // ----------------------------------------------------------------------
          IF (qy_TMP.FieldByName('FeeID').AsInteger IN [1, 2, 3, 4, 5, 6, 7, 11,
            12, 30]) AND (qy_TMP.FieldByName('SubFeeID').AsInteger <> 390) AND
            (qy_TMP.FieldByName('SubFeeID').AsInteger <> 399) THEN
          BEGIN
            var
              ccStr: String;
            ccStr := BoolToStr(qy_TMP.FieldByName('PayMethod')
              .AsString = 'CC', True);

            SQL.Clear;
            SQL.Text := 'INSERT INTO ServicesSold' +
              ' (CC1, ClientID, CardID, SoldDT, FeeID, SubFeeID, Verified, Valid,'
              + '  DrinkCredits, DrinkValue, BonusPoints, SurCharge, TxID)' +
              ' VALUES' +
              ' (:cc1, :clientID, :cardID, CURRENT_TIMESTAMP, :feeID, :subFeeID,'
              + '  :verified, :valid, :drinkCredits, :drinkValue, :bonusPoints, :surCharge, :txid)';

            Params.ParamByName('cc1').AsInteger := StrToIntDef(ccStr, 0);
            Params.ParamByName('clientID').AsInteger :=
              qy_TMP.FieldByName('ClientID').AsInteger;
            Params.ParamByName('cardID').AsInteger :=
              qy_TMP.FieldByName('CardID').AsInteger;
            Params.ParamByName('feeID').AsInteger := qy_TMP.FieldByName('FeeID')
              .AsInteger;
            Params.ParamByName('subFeeID').AsInteger :=
              qy_TMP.FieldByName('SubFeeID').AsInteger;
            Params.ParamByName('verified').AsBoolean := False;
            Params.ParamByName('valid').AsBoolean := True;
            Params.ParamByName('drinkCredits').AsInteger :=
              qy_TMP.FieldByName('DrinkCredits').AsInteger;
            Params.ParamByName('drinkValue').AsFloat :=
              qy_TMP.FieldByName('DrinkCreditValue').AsFloat;
            Params.ParamByName('bonusPoints').AsInteger :=
              qy_TMP.FieldByName('BonusPoints').AsInteger;
            Params.ParamByName('surCharge').AsBoolean :=
              qy_TMP.FieldByName('SurCharge').AsBoolean;
            Params.ParamByName('txid').AsString := txID;
            ExecSQL;
          END;

          // Register last presence date in Clients table
          // ----------------------------------------------------------------------
          IF qy_TMP.FieldByName('FeeID').AsInteger = 3 THEN
          BEGIN
            SQL.Clear;
            SQL.Add('UPDATE Clients SET LastPresence = CURRENT_DATE ' +
              'WHERE ID = ' + intToStr(uClientStore.ThisClient.ID));
            ExecSQL;
            Sleep(50);
            Form2.tb_ClientiClients.Refresh;
            Form2.tb_Clients.Refresh;
            dbg_Clienti_Clients.Refresh;
          END;

          // If VT ticket used - update Bar_SoldByDetail table
          // ----------------------------------------------------------------------
          IF qy_TMP.FieldByName('PayMethod').AsString = 'VT' THEN
          BEGIN
            WITH qy_BarTmp DO
            BEGIN
              IF Active THEN
                Close;
              SQL.Clear;
              SQL.Add('UPDATE Bar_SoldByDetail SET Avere = ' + floatToStr(amt) +
                ', VatTxID = ' + QuotedStr(txID) +
                ', DataModified = CURRENT_TIMESTAMP ' + 'WHERE TxID = ' +
                QuotedStr(qy_TMP.FieldByName('tmpTxID').AsString));
              ExecSQL;
              qy_BarSoldBy.Refresh;
            END;
          END;

          // If RT bar ticket
          // ----------------------------------------------------------------------
          IF (qy_TMP.FieldByName('FeeID').AsInteger = 8) AND
            (qy_TMP.FieldByName('SubFeeID').AsInteger = 800) THEN
          BEGIN
            WITH qy_BarTmp DO
            BEGIN
              IF Active THEN
                Close;
              SQL.Clear;
              SQL.Add('INSERT INTO Bar_OpLedger (Data, ProductID, DARE, PayMethod, Waiter, TxID)'
                + ' VALUES (CURRENT_TIMESTAMP, ' + QuotedStr('Pagato') + ', ' +
                qy_TMP.FieldByName('AmountToPrint').AsString + ', ''RT'', ' +
                QuotedStr(qy_TabsOpen.FieldByName('waiter').AsString) + ', ' +
                QuotedStr(txID) + ')');
              ExecSQL;
            END;
            thtm_BarRT.Enabled := True;
          END;

          // If rental room payment - register paid-until date
          // ----------------------------------------------------------------------
          IF (qy_TMP.FieldByName('FeeID').AsInteger = 200) AND
            (qy_TMP.FieldByName('SubFeeID').AsInteger = 222) THEN
          BEGIN
            SQL.Clear;
            SQL.Add('UPDATE RREU_Bookings SET PayedUntilDate = CURRENT_DATE + INTERVAL ''1'' DAY '
              + 'WHERE GuestID = ' + intToStr(uClientStore.ThisClient.ID) +
              '  AND CheckOutDate IS NULL OR CheckOutDate > TIMESTAMP ' +
              QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)));
            ExecSQL;
          END;

        EXCEPT
          ON E: Exception DO
          BEGIN
            Database.Rollback;
            ShowMessage
              ('Rolled back. An error in xx_WriteOTabtoAccounts occurred: ' +
              E.Message);
          END;
        END;
      END; // WITH qy_Tmp2

      Next;
    END; // WHILE NOT EOF

    WITH dbgd_PagaDopo DO
    BEGIN
      qy_PagaDopo.Refresh;
      Refresh;
      SumList.RecalcAll;
      xx_CheckIfStillPresent;
    END;

  END; // WITH Form2, qy_TMP

END;

{
  PROCEDURE TForm1.xx_WriteOtabToAccounts;
  VAR
  oldTxID, NewTxID, txID, tableName: STRING;
  amt: Double;
  BEGIN
  txID := '';
  oldTxID := '';
  NewTxID := '';
  IF ClubAccPermissions.ClosingP < 1 THEN
  Exit;
  // ---------------------
  // 1000 Cassa
  // 1010 Fondo cassa
  // 1020 IBAN payments CC to g
  // 1200 Debitors
  // 2900 Creditors
  // 5000 Income
  // 6000 Expenses
  // ---------------------

  // ---------------------
  // Printer error warning
  // ---------------------
  IF (Form2.tb_Fees.FieldByName('ReceiptID').AsInteger > 0) AND
  (cb_settings_PrintCB.Checked) AND (GetCurrentPrinterStatus <> 0) THEN
  BEGIN
  nnWriteCashierDisplay(0, True, clYellow,
  'Errore stampante: (printer status = ' + intToStr(GetCurrentPrinterStatus)
  + ')', 0);
  nnWriteCashierDisplay(0, False, clYellow,
  'La registrazione non può essere eseguita!', 1);
  Exit;
  END;

  // Disable pecunia buttons
  // ---------------------------------------------------------------------------
  nn_EnablePecuniaBt(False);

  // Get a txid to Update record with if no txid in record

  // Register openTab record data to accounts
  // ---------------------------------------------------------------------------
  WITH Form2, qy_TMP DO
  BEGIN
  IF Active THEN
  Close;
  SQL.Clear;
  SQL.Add('SELECT * FROM OpenTab');
  Active := True;
  First;
  WHILE NOT EOF DO
  BEGIN
  // Get amounts
  // ----------------------------------------------------------------------
  IF FieldByName('PayMethod').AsString = 'EU' THEN
  amt := FieldByName('AmountEuro').AsFloat
  ELSE
  amt := FieldByName('AmountCHF').AsFloat;

  // Get a TxID if none
  // ----------------------------------------------------------------------

  IF Trim(FieldByName('TxID').AsString) <> '' Then
  oldTxID := FieldByName('TxID').AsString;
  IF ((Trim(FieldByName('TxID').AsString) = '') OR
  (FieldByName('TxID').IsNull)) AND (NewTxID = '') Then
  NewTxID := GenerateTxID;
  IF (Trim(FieldByName('TxID').AsString) = '') OR
  (FieldByName('TxID').IsNull) Then
  txID := NewTxID
  else
  txID := oldTxID;

  // Do the registrations
  // ----------------------------------------------------------------------
  WITH qy_Tmp2 DO
  BEGIN
  TRY
  IF Active THEN
  Close;
  SQL.Clear;
  // Main account
  // ------------------------------------------------------------------
  tableName := 'c_' + qy_TMP.FieldByName('dAccount').AsString;
  if not TRegEx.IsMatch(tableName, '^c_\d+$') then
  raise Exception.Create('Invalid account table name');
  SQL.Text := 'INSERT INTO ' + tableName + ' ' +
  ' (Data, ClientID, CardID, Description, Dare, FeeID, SubFeeID, ' +
  '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID) '
  + 'VALUES (CURRENT_TIMESTAMP, :clientID, :cardID, :descr, :dare, :feeID, :subFeeID, '
  + '        :verified, :canceled, :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid)';

  Params.ParamByName('clientID').AsInteger :=
  qy_TMP.FieldByName('ClientID').AsInteger;
  Params.ParamByName('cardID').AsInteger := qy_TMP.FieldByName('CardID')
  .AsInteger;
  Params.ParamByName('descr').AsString :=
  qy_TMP.FieldByName('Description').AsString;

  // Use numeric param to avoid locale issues from FloatToStr
  Params.ParamByName('dare').AsFloat := amt;
  // or AsCurrency if appropriate

  Params.ParamByName('feeID').AsInteger := qy_TMP.FieldByName('FeeID')
  .AsInteger;
  Params.ParamByName('subFeeID').AsInteger :=
  qy_TMP.FieldByName('SubFeeID').AsInteger;

  Params.ParamByName('verified').AsBoolean := False;
  // use 0/1 if DB lacks BOOLEAN
  Params.ParamByName('canceled').AsBoolean := False;

  Params.ParamByName('payMethod').AsString :=
  qy_TMP.FieldByName('PayMethod').AsString;
  Params.ParamByName('costCenter').AsString :=
  qy_TMP.FieldByName('costCenter').AsString;
  Params.ParamByName('operator').AsString :=
  Trim(qy_TMP.FieldByName('Operator').AsString);
  Params.ParamByName('receipt').AsBoolean :=
  qy_TMP.FieldByName('Receipt').AsBoolean;

  Params.ParamByName('cPartita').AsInteger :=
  qy_TMP.FieldByName('aAccount').AsInteger;

  Params.ParamByName('txid').AsString := txID;
  ExecSQL;

  // Contropartita account
  // ------------------------------------------------------------------
  If qy_TMP.FieldByName('aAccount').AsInteger > 0 Then
  begin
  tableName := 'c_' + qy_TMP.FieldByName('aAccount').AsString;
  if not TRegEx.IsMatch(tableName, '^c_\d+$') then
  raise Exception.Create('Invalid account table name');
  SQL.Clear;
  SQL.Text := 'INSERT INTO ' + tableName + ' ' +
  ' (Data, ClientID, CardID, Description, Avere, FeeID, SubFeeID, '
  + '  Verified, Canceled, PayMethod, CostCenter, Operator, Receipt, cPartita, TxID) '
  + 'VALUES (CURRENT_TIMESTAMP, :clientID, :cardID, :descr, :avere, :feeID, :subFeeID, '
  + '        :verified, :canceled, :payMethod, :costCenter, :operator, :receipt, :cPartita, :txid)';

  // Bind params
  Params.ParamByName('clientID').AsInteger :=
  qy_TMP.FieldByName('ClientID').AsInteger;
  Params.ParamByName('cardID').AsInteger :=
  qy_TMP.FieldByName('CardID').AsInteger;
  Params.ParamByName('descr').AsString :=
  qy_TMP.FieldByName('Description').AsString;

  // Numeric value: avoid FloatToStr locale issues
  Params.ParamByName('avere').AsFloat := amt;
  // or AsCurrency if appropriate

  Params.ParamByName('feeID').AsInteger := qy_TMP.FieldByName('FeeID')
  .AsInteger;
  Params.ParamByName('subFeeID').AsInteger :=
  qy_TMP.FieldByName('SubFeeID').AsInteger;

  Params.ParamByName('verified').AsBoolean := False;
  // use 0/1 if DB lacks BOOLEAN
  Params.ParamByName('canceled').AsBoolean := False;

  Params.ParamByName('payMethod').AsString :=
  qy_TMP.FieldByName('PayMethod').AsString;
  Params.ParamByName('costCenter').AsString :=
  qy_TMP.FieldByName('costCenter').AsString;
  Params.ParamByName('operator').AsString :=
  qy_TMP.FieldByName('Operator').AsString;
  Params.ParamByName('receipt').AsBoolean :=
  qy_TMP.FieldByName('Receipt').AsBoolean;

  Params.ParamByName('cPartita').AsInteger :=
  qy_TMP.FieldByName('dAccount').AsInteger;

  Params.ParamByName('txid').AsString := txID;
  ExecSQL;
  end;

  // IF later PD Payment registration update with effective paymethod
  // and  amount (ch or eu)
  // -------------------------------------------------------------------
  If qy_TMP.FieldByName('aAccount').AsInteger = 1200 Then
  begin
  SQL.Clear;
  SQL.Add('UPDATE c_1200 SET PayMethod = ' +
  QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ',Dare = ' +
  floatToStr(amt) + ' WHERE CLientID = ' +
  qy_TMP.FieldByName('ClientID').AsString +
  ' AND PayMethod = ''PD'' ' + ' AND SubFeeID = ' +
  qy_TMP.FieldByName('SubFeeID').AsString + ' AND TxID = ' +
  QuotedStr(txID));
  ExecSQL;

  SQL.Clear;
  SQL.Add('UPDATE c_2900 SET PayMethod = ' +
  QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ',Avere = '
  + floatToStr(amt) + ' WHERE CLientID = ' +
  qy_TMP.FieldByName('ClientID').AsString +
  ' AND PayMethod = ''PD'' ' + ' AND SubFeeID = ' +
  qy_TMP.FieldByName('SubFeeID').AsString + ' AND TxID = ' +
  QuotedStr(txID));
  ExecSQL;

  SQL.Clear;
  SQL.Add('UPDATE c_5000 SET PayMethod = ' +
  QuotedStr(qy_TMP.FieldByName('PayMethod').AsString) + ',Avere = '
  + floatToStr(amt) + ' WHERE CLientID = ' +
  qy_TMP.FieldByName('ClientID').AsString +
  ' AND PayMethod = ''PD'' ' + ' AND SubFeeID = ' +
  qy_TMP.FieldByName('SubFeeID').AsString + ' AND TxID = ' +
  QuotedStr(txID));
  ExecSQL;
  xx_CloseUsedRoom;
  end;

  // ServicesSold  (modified including 399 changing bonuspoints deprecated)
  // ------------------------------------------------------------------
  IF (qy_TMP.FieldByName('FeeID').AsInteger IN [1, 2, 3, 4, 5, 6, 7, 11,
  12, 30]) AND (qy_TMP.FieldByName('SubFeeID').AsInteger <> 390) AND
  (qy_TMP.FieldByName('SubFeeID').AsInteger <> 399) Then
  // Nor a Towel fee nor a Sun/Mon supplement

  begin
  var
  ccStr: String;
  ccStr := BoolToStr(qy_TMP.FieldByName('PayMethod')
  .AsString = 'CC', True);
  SQL.Clear;
  SQL.Text := 'INSERT INTO ServicesSold ' +
  ' (CC1, ClientID, CardID, SoldDT, FeeID, SubFeeID, Verified, Valid, '
  + '  DrinkCredits, DrinkValue, BonusPoints, SurCharge, TxID) ' +
  'VALUES ' +
  ' (:cc1, :clientID, :cardID, CURRENT_TIMESTAMP, :feeID, :subFeeID, '
  + '  :verified, :valid, :drinkCredits, :drinkValue, :bonusPoints, :surCharge, :txid)';

  Params.ParamByName('cc1').AsInteger := StrToIntDef(ccStr, 0);
  // or AsString if CC1 is text
  Params.ParamByName('clientID').AsInteger :=
  qy_TMP.FieldByName('ClientID').AsInteger;
  Params.ParamByName('cardID').AsInteger :=
  qy_TMP.FieldByName('CardID').AsInteger;
  Params.ParamByName('feeID').AsInteger := qy_TMP.FieldByName('FeeID')
  .AsInteger;
  Params.ParamByName('subFeeID').AsInteger :=
  qy_TMP.FieldByName('SubFeeID').AsInteger;

  Params.ParamByName('verified').AsBoolean := False;
  Params.ParamByName('valid').AsBoolean := True;

  Params.ParamByName('drinkCredits').AsInteger :=
  qy_TMP.FieldByName('DrinkCredits').AsInteger;
  Params.ParamByName('drinkValue').AsFloat :=
  qy_TMP.FieldByName('DrinkCreditValue').AsFloat;
  // or AsCurrency
  Params.ParamByName('bonusPoints').AsInteger :=
  qy_TMP.FieldByName('BonusPoints').AsInteger;
  Params.ParamByName('surCharge').AsBoolean :=
  qy_TMP.FieldByName('SurCharge').AsBoolean;

  Params.ParamByName('txid').AsString := txID;
  ExecSQL;
  end;

  // Register last presence date in Clients table
  // ------------------------------------------------------------------
  IF qy_TMP.FieldByName('FeeID').AsInteger = 3 Then
  begin
  SQL.Clear;
  SQL.Add('UPDATE Clients SET LastPresence = CURRENT_DATE ' +
  'WHERE ID = ' + intToStr(uClientStore.ThisClient.ID));
  ExecSQL;
  Sleep(50);
  Form2.tb_ClientiClients.Refresh;
  Form2.tb_Clients.Refresh;
  dbg_Clienti_Clients.Refresh;
  end;

  // If VT ticket used update bar_SoldBy table
  // -----------------------------------------------------------------
  var
  ss := QuotedStr(qy_TMP.FieldByName('tmpTxID').AsString);
  If qy_TMP.FieldByName('PayMethod').AsString = 'VT' Then
  begin
  With qy_BarTmp do
  begin
  If Active Then
  Close;
  SQL.Clear;
  SQL.Add('UPDATE Bar_SoldByDetail SET Avere = ' + floatToStr(amt) +
  ', VatTxID = ' + QuotedStr(txID) +
  ', DataModified = CURRENT_TIMESTAMP ' + 'WHERE TxID = ' +
  QuotedStr(qy_TMP.FieldByName('tmpTxID').AsString));
  ExecSQL;
  qy_BarSoldBy.Refresh;
  end;
  end;

  // If RT bar ticket
  // ------------------------------------------------------------------
  If (qy_TMP.FieldByName('FeeID').AsInteger = 8) AND
  (qy_TMP.FieldByName('SubFeeID').AsInteger = 800) Then
  begin
  With qy_BarTmp do
  begin
  If Active Then
  Close;
  SQL.Clear;
  SQL.Add('INSERT INTO  Bar_OpLedger (Data,ProductID,' +
  'DARE,PayMethod,Waiter,TxID) VALUES(CURRENT_TIMESTAMP,' +
  QuotedStr('Pagato') + ', ' + qy_TMP.FieldByName('AmountToPrint')
  .AsString + ', ''RT'', ' +
  QuotedStr(qy_TabsOpen.FieldByName('waiter').AsString) + ', ' +
  QuotedStr(txID) + ')');
  ExecSQL;
  end;
  thtm_BarRT.Enabled := True;
  end;

  // If rental room payment register payed until date
  // -------------------------------------------------------------------
  IF (qy_TMP.FieldByName('FeeID').AsInteger = 200) AND
  (qy_TMP.FieldByName('SubFeeID').AsInteger = 222) Then
  begin
  SQL.Clear;
  SQL.Add('UPDATE RREU_Bookings SET PayedUntilDate = CURRENT_DATE  + INTERVAL ''1'' DAY '
  + 'WHERE GuestID = ' + intToStr(uClientStore.ThisClient.ID) +
  ' AND CheckOutDate IS NULL OR  CheckOutDate > TIMESTAMP ' +
  QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(Now, True)));
  ExecSQL;
  end;

  except
  on E: Exception do
  begin
  // Roll back all changes if something goes wrong
  Database.Rollback;
  ShowMessage
  ('Rolled back. An error in xx_WriteOTabtoAccounts occurred: ' +
  E.Message);
  end;
  end;
  END;
  Next;
  END;


  WITH dbgd_PagaDopo DO
  BEGIN
  qy_PagaDopo.Refresh;
  Refresh;
  SumList.RecalcAll;
  xx_CheckIfStillPresent;
  END;

  END;

  END;
}

// Function brings back bar TxID of VT if not yet used
Function TForm1.CheckIfHasBarCredit(ClientID: Integer): String;
var
  StartDt: TDateTime;
begin
  StartDt := IncDay(sDt, -30);
  With Form2.qy_BarTmp do
  begin
    If Active Then
      Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Bar_SoldByDetail ' + 'WHERE SoldBy = :soldby ' +
      '  AND Avere IS NULL ' + '  AND Data >= :startDt AND Data < :endDt ' +
    // half-open range
      'ORDER BY Data';
    Params.ParamByName('soldby').AsInteger := ClientID;
    Params.ParamByName('startDt').AsDateTime := StartDt;
    Params.ParamByName('endDt').AsDateTime := eDT;
    Active := True;
    If RecordCount > 0 Then
    begin
      First;
      Result := FieldByName('TxID').AsString;
    end;
    Active := False;
  end;
end;

PROCEDURE TForm1.xx_SetExpiredFeesToFalse;
VAR
  s: STRING;
BEGIN
  // Resets payed fee Valid to false if overall life time span exceeded
  // ------------------------------------------------------------------
  s := 'UPDATE ServicesSold ' + 'SET VALID = FALSE ' + 'WHERE EXISTS (' +
    'SELECT 1 FROM Fees f ' + 'WHERE ServicesSold.SubFeeID = f.SubID ' +
    'AND CAST ((CURRENT_TIMESTAMP - SoldDT ) Minute AS INTEGER) > f.LifeTimeSpan)';
  Form2.t_executequery(s, 'DB_Main', 'PGC_DB_Main_Euro', 'ServicesSold');
END;

FUNCTION TForm1.xx_GetLastValidTxData(comesFrom: String;
ClientID: Integer): Boolean;
VAR
  s: STRING;
BEGIN
  Finalize(LastTxData);
  FillChar(LastTxData, SizeOf(LastTxData), 0);
  WITH Form2.qy_Tmp2 DO
  // -------------------------------------------------------------------------
  // Get last time daily tax payed
  // -------------------------------------------------------------------------
  BEGIN
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    s := 'SELECT Max(Data) AS Data FROM c_1000 ' +
      'WHERE SubFeeID = 9999 AND Canceled <> True AND clientid = ' +
      intToStr(uClientStore.ThisClient.ID);
    SQL.Add(s);
    Active := True;
    IF RecordCount > 0 THEN
      uClientStore.ThisClient.lstTaxDate := FieldByName('Data').AsDateTime
    ELSE
      uClientStore.ThisClient.lstTaxDate := 0;

    // --------------------------------------------------------------------------
    // Get last valid entrance fee
    // --------------------------------------------------------------------------
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Text := 'SELECT SS.*, Fees.* ' + 'FROM ServicesSold SS ' +
      'LEFT JOIN Fees ON SS.SubFeeID = Fees.SubID ' + 'WHERE SS.Valid = True ' +
      '  AND SS.Canceled = False ' + '  AND SS.FeeID = :fee ' +
      '  AND SS.ClientID = :clientID ' +
      '  AND SS.SoldDT >= :sDt AND SS.SoldDT < :eDt ' + 'ORDER BY SS.SoldDT';

    Params.ParamByName('fee').AsInteger := 3;
    Params.ParamByName('clientID').AsInteger := uClientStore.ThisClient.ID;
    Params.ParamByName('sDt').AsDateTime := sDt;
    Params.ParamByName('eDt').AsDateTime := eDT;

    Active := True;
    IF RecordCount > 0 THEN
    begin
      uClientStore.ThisClient.entrySubFeeID := FieldByName('SubFeeID')
        .AsInteger;
      uClientStore.ThisClient.HasSurCharge := FieldValues['SurCharge'];
    end
    ELSE
      uClientStore.ThisClient.entrySubFeeID := 0;
    Active := False;

    // -----------------------------------------------------------------------
    // Get rest of the txid data
    // -----------------------------------------------------------------------
    s := QuotedStr(Form2.EDBEngine1.DateTimeToSQLStr(sDt, True));
    IF Active THEN
      Close;
    SQL.Clear;
    DataBaseName := 'DB_Main';
    SQL.Text := 'SELECT SS.*, Fees.* ' + sLineBreak + 'FROM ServicesSold SS ' +
      sLineBreak + 'LEFT JOIN Fees ON SS.SubFeeID = Fees.SubID ' + sLineBreak +
      'WHERE SS.Valid = True ' + sLineBreak + '  AND SS.Canceled = False ' +
      sLineBreak + '  AND SS.FeeID NOT IN (7, 900, 200) ' + sLineBreak +
      '  AND SS.SubFeeID <> 399 ' + sLineBreak +
      '  AND SS.ClientID = :clientID ' + sLineBreak +
      '  AND SS.SoldDT >= :sDt AND SS.SoldDT < :eDt ' + sLineBreak +
      'ORDER BY SS.SoldDT';

    Params.ParamByName('clientID').AsInteger := uClientStore.ThisClient.ID;
    Params.ParamByName('sDt').AsDateTime := sDt;
    Params.ParamByName('eDt').AsDateTime := eDT;

    Active := True;
    IF RecordCount > 0 THEN
    BEGIN
      Last;
      WITH LastTxData DO
      BEGIN
        lTxSoldDT := FieldValues['SoldDT'];
        IF NOT FieldByName('StartUse').IsNull THEN
          lTxStartDt := FieldValues['StartUse'];
        lTxID := FieldValues['TxID'];
        lTxFeeID := FieldValues['FeeID'];
        lTxSubFeeID := FieldValues['SubFeeID'];
        lTxValid := FieldValues['Valid'];
        lTxFeeDesc := FieldValues['Description'];
      END;
    END;
    Active := False;

    Result := LastTxData.lTxValid;
  END;
END;

// xx_HandleValidFees(Sender: TObject): Integer *********************************
// Handles valid daily fees and room fees
// -----------------------------------------------------------------------------
FUNCTION TForm1.xx_HandleValidFees(comesFrom: String): Integer;
BEGIN
  CASE LastTxData.lTxFeeID OF
    4, 5, 6: // Has valid work room fee
      BEGIN
        // Has valid not yet used work room fee
        // ---------------------------------------------------------------------
        IF (LastTxData.lTxStartDt = 0) AND
          (MinuteSpan(LastTxData.lTxSoldDT, Now) < ed_ResetRoomMinSpan.Value)
          AND (cb_RoomReset.Checked) Then
          Result := 40
        else
        begin
          // Has valid room fee, with use started more than x minutes after sale
          // -----------------------------------------------------------------
          Result := 41;
        end;
        Exit;
      END;
    3:
      BEGIN
        // Has valid daily entrance fee
        // ---------------------------------------------------------------------
        IF comesFrom = 'bt_Read' THEN
          Result := 30
        ELSE IF (LastTxData.lTxSubFeeID = Form2.tb_Fees.FieldByName('SubID')
          .AsInteger) OR (LastTxData.lTxFeeID = Form2.tb_Fees.FieldByName('ID')
          .AsInteger) THEN
        BEGIN
          // Has already same fee
          // -----------------------------------------------------------------

          Result := 31;
        END;
      END;
  ELSE
    Result := 0;
  END;
END;

// nnGetBalance(clientID: Integer; txnID:String): Double; **********************
// either or the clientID retuns the whole due balance or
// txnID retruns only this tx's balance due
// -----------------------------------------------------------------------------
PROCEDURE TForm1.nnGetTheBalance(ClientID: Integer; txnID: STRING);
BEGIN
  WITH Form2.qy_TMP DO
  BEGIN
    IF ClientID > -1 THEN
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      DataBaseName := 'DB_Main';

      // Get client's total due balance
      SQL.Text := 'SELECT COALESCE(SUM(Dare), 0) AS bal ' + 'FROM c_1200 ' +
        'WHERE ClientID = :clientID ' + '  AND PayMethod = :pay ' +
        '  AND Canceled = :canceled';

      Params.ParamByName('clientID').AsInteger := ClientID;
      Params.ParamByName('pay').AsString := 'PD';
      Params.ParamByName('canceled').AsBoolean := False;

      Active := True;
      IF RecordCount > 0 THEN
        uClientStore.ThisClient.balanceDue := FieldByName('bal').AsFloat;
    END;
    IF txnID <> '' THEN
    BEGIN
      IF Active THEN
        Close;
      SQL.Clear;
      SQL.Text := 'SELECT COALESCE(SUM(Dare), 0) AS bal ' + 'FROM c_1200 ' +
        'WHERE TxID = :txid ' + '  AND PayMethod = :pay ' +
        '  AND Canceled = :canceled';

      Params.ParamByName('txid').AsString := txnID;
      // or AsInteger/AsLargeInt if numeric
      Params.ParamByName('pay').AsString := 'PD';
      Params.ParamByName('canceled').AsBoolean := False;
      Active := True;
      LastTxData.lTxBal := FieldByName('bal').AsFloat;
      Active := False;
    END;
  END;
END;

// -----------------------------------------------------------------------------
// End new cashier nnProcedures
// *****************************************************************************

FUNCTION TForm1.GetLocalPCName: STRING;
VAR
  buffer: ARRAY [0 .. 255] OF Char;
  Size: DWORD;
BEGIN
  Size := 256;
  IF GetComputerName(buffer, Size) THEN
    Result := buffer
  ELSE
    Result := '';
END;

PROCEDURE TForm1.ShowBarcode;
BEGIN
  TRY
    RzStatusPane5.Caption := '';
    img_QRcode.Picture.Assign(Barcode1.Bitmap);
    img_QRcode.Width := ed_QR_Size.Value;
    img_QRcode.Height := ed_QR_Size.Value;
  EXCEPT
    ON E: Exception DO
    BEGIN
      RzStatusPane5.Caption := E.Message;
      img_QRcode.Picture.Assign(NIL);
    END;
  END;
END;

FUNCTION TForm1.nChangeAlpha(Input: STRING): STRING;
VAR
  A: Char;
BEGIN
  Result := Input;
  FOR A := 'A' TO 'Z' DO
    Result := StringReplace(Result, A, intToStr(Ord(A) - 55), [rfReplaceAll]);
END;

FUNCTION TForm1.CalculateDigits(iban: STRING): Integer;
VAR
  V, L: Integer;
  alpha: STRING;
  number: Longint;
  rest: Integer;
BEGIN
  iban := UpperCase(iban);
  IF Pos('IBAN', iban) > 0 THEN
    Delete(iban, Pos('IBAN', iban), 4);
  iban := iban + Copy(iban, 1, 4);
  Delete(iban, 1, 4);
  iban := nChangeAlpha(iban);
  V := 1;
  L := 9;
  rest := 0;
  alpha := '';
  TRY
    WHILE V <= Length(iban) DO
    BEGIN
      IF L > Length(iban) THEN
        L := Length(iban);
      alpha := alpha + Copy(iban, V, L);
      number := StrToInt(alpha);
      rest := number MOD 97;
      V := V + L;
      alpha := intToStr(rest);
      L := 9 - Length(alpha);
    END;
  EXCEPT
    rest := 0;
  END;
  Result := rest;
END;

FUNCTION TForm1.CheckIBAN(iban: STRING): Boolean;
BEGIN
  iban := StringReplace(iban, ' ', '', [rfReplaceAll]);
  IF CalculateDigits(iban) = 1 THEN
    Result := True
  ELSE
    Result := False;
END;

{
  PROCEDURE TForm1.WMDisplayChange(VAR msg: TMessage);
  VAR
  MonitorCnt: Integer;
  BEGIN
  INHERITED;
  Sleep(1000);
  // Hiding here because screen.monitorCount gets wrong count when turning off second monitor
  Form4.Hide;
  Form1.SetFocus;

  MonitorCnt := screen.monitorCount;
  IF MonitorCnt < 2 THEN
  IF Form4.Showing THEN
  BEGIN
  Form4.Hide;
  Form1.SetFocus;
  END;
  ShowMessage(intToStr(MonitorCnt) + ' monitors detected.');
  END;
}

PROCEDURE TForm1.Eliminafoto1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    IF (NOT FieldByName('Image').IsNull) AND
      (MessageDlg('Stai per togliere la foto di ' + FieldByName('Alias')
      .AsString + '. Procedi ? ', mtConfirmation, [mbOK, mbNo], 0, mbOK)
      = mrOk) THEN
    BEGIN
      Edit;
      TBlobField(FieldByName('Image')).Clear;
      Post;
    END;
  END;
END;

procedure TForm1.Eliminatessera1Click(Sender: TObject);
BEGIN
  If ed_ClCardID.Text = '' Then
  begin
    ShowMessage('ID tessera non pu?o essere vuoto.');
    Exit;
  end;
  IF NOT CheckIfCardReadyToChange(Sender) THEN
    Exit;
  IF MessageDlg('Togli la tessera ' + ed_ClCardID.Text + ' Procedi?',
    mtConfirmation, [mbOK, mbNo], 0, mbOK) = mrOk THEN
  begin
    WITH Form2.qy_TMP do
    begin
      If Active Then
        Close;
      SQL.Clear;
      SQL.Text := 'UPDATE Cards SEt ClientID = -1 WHERE ID = ' +
        ed_ClCardID.Text;
      ExecSQL;
      Form2.tb_ClientiClients.Refresh;
      ed_ClCardID.Text := '';
    end;
  end;
end;

PROCEDURE TForm1.Caricafoto1Click(Sender: TObject);
BEGIN
  WITH Form2.tb_ClientiClients DO
  BEGIN
    IF (NOT FieldByName('Image').IsNull) AND
      (MessageDlg('Stai per cambiare la foto di ' + FieldByName('Alias')
      .AsString + '. Procedi ? ', mtConfirmation, [mbOK, mbNo], 0, mbOK) <>
      mrOk) THEN
      Exit
    ELSE
    BEGIN
      // Open the file dialog and check if the user clicked 'OK'
      IF OpenPictureDialog1.Execute THEN
      BEGIN
        // Check if the file exists
        IF FileExists(OpenPictureDialog1.FileName) THEN
        BEGIN
          Edit; // Begin editing the dataset
          // Load the image file into the blob field
          TBlobField(FieldByName('Image'))
            .LoadFromFile(OpenPictureDialog1.FileName);
          Post;
        END
        ELSE
        BEGIN
          // Raise an exception if the file does not exist
          RAISE Exception.Create('File does not exist.');
        END;
      END
      ELSE
      BEGIN
        // Optionally handle the cancel event (e.g., show a message or just exit)
        ShowMessage('Operation cancelled by the user.');
      END;
    END;
  END;
END;

procedure TForm1.Caricafotodascanner1Click(Sender: TObject);
var
  Fn: string;
begin
  if ScanViaPickerToFile(Fn) then
  begin
    if scEH_Clienti_Clients.DataSet.State = dsBrowse then
      scEH_Clienti_Clients.DataSet.Edit;
    (scEH_Clienti_Clients.DataSet.FieldByName('Image') as TBlobField)
      .LoadFromFile(Fn);
    scEH_Clienti_Clients.DataSet.Post;
  end;
end;

FUNCTION TForm1.EnCrypt(sInput: STRING): STRING;
VAR
  iCount, iLength: Integer;
BEGIN
  iLength := Length(sInput);
  FOR iCount := 1 TO iLength DO
  BEGIN
    sInput[iCount] := chr(Ord(sInput[iCount]) + 4);
  END;
  Result := sInput;
END;

FUNCTION TForm1.DeCrypt(sInput: STRING): STRING;
VAR
  iCount, iLength: Integer;
BEGIN
  iLength := Length(sInput);
  FOR iCount := 1 TO iLength DO
  BEGIN
    sInput[iCount] := chr(Ord(sInput[iCount]) - 4);
  END;
  Result := sInput;
END;

PROCEDURE TForm1.TwainTwainAcquire(Sender: TObject; CONST Index: Integer;
Image: TBitmap; VAR Cancel: Boolean);
BEGIN
  // im_Preview.Picture.Assign(Image);
  Cancel := True; // Only want one image
END;

PROCEDURE TForm1.GetImageDimensionsFromBlob(DataSet: TDataSet;
ImageFieldName: STRING; OUT Width, Height: Integer);
VAR
  BlobStream: TMemoryStream;
  Graphic: TGraphic;
  Format: STRING;
BEGIN
  Width := 0;
  Height := 0;

  IF NOT DataSet.FieldByName(ImageFieldName).IsNull THEN
  BEGIN
    BlobStream := TMemoryStream.Create;
    TRY
      // Load the BLOB data into the stream
      TBlobField(DataSet.FieldByName(ImageFieldName)).SaveToStream(BlobStream);

      // Detect image format
      Format := DetectImageFormat(BlobStream);

      // Load the appropriate graphic class based on format
      IF Format = 'BMP' THEN
        Graphic := TBitmap.Create
      ELSE IF Format = 'JPEG' THEN
        Graphic := TJPEGImage.Create
      ELSE IF Format = 'PNG' THEN
        Graphic := TPngImage.Create
      ELSE
        RAISE Exception.Create('Unsupported image format in BLOB field.');

      TRY
        BlobStream.Position := 0; // Reset position before loading
        Graphic.LoadFromStream(BlobStream);

        // Get the dimensions of the image
        Width := Graphic.Width;
        Height := Graphic.Height;
      FINALLY
        Graphic.Free;
      END;

    FINALLY
      BlobStream.Free;
    END;
  END
  ELSE
    RAISE Exception.Create('The image field is empty.');
END;

FUNCTION TForm1.IsJPEG(Stream: TStream): Boolean;
VAR
  header: Word;
BEGIN
  Stream.Position := 0;
  Stream.ReadBuffer(header, SizeOf(header));
  Result := header = $D8FF; // JPEG files start with FF D8
  Stream.Position := 0; // Reset position
END;

FUNCTION TForm1.DetectImageFormat(Stream: TStream): STRING;
VAR
  header: ARRAY [0 .. 7] OF byte;
BEGIN
  Result := '';
  Stream.Position := 0; // Reset position to start of stream
  Stream.ReadBuffer(header, SizeOf(header));

  // Check BMP
  IF (header[0] = $42) AND (header[1] = $4D) THEN
    Result := 'BMP'
    // Check JPEG
  ELSE IF (header[0] = $FF) AND (header[1] = $D8) THEN
    Result := 'JPEG'
    // Check PNG
  ELSE IF (header[0] = $89) AND (header[1] = $50) AND (header[2] = $4E) AND
    (header[3] = $47) AND (header[4] = $0D) AND (header[5] = $0A) AND
    (header[6] = $1A) AND (header[7] = $0A) THEN
    Result := 'PNG';

  Stream.Position := 0; // Reset position for further use
END;

PROCEDURE TForm1.Assegnaa1Click(Sender: TObject);
VAR
  subFeeID: Integer;
  ExistingValues, NewValues: STRING;
BEGIN
  WITH Form2 DO
  BEGIN
    subFeeID := Form2.tb_BonMalFees.FieldByName('SubFeeID').AsInteger;

    // Get the current value of the comma-separated string field
    ExistingValues := Trim(tb_FeeE.FieldByName('BonusMalusReference').AsString);

    // Check if SubFeeID already exists in the string
    IF Pos(intToStr(subFeeID), ExistingValues) = 0 THEN
    BEGIN
      // Append the new value, ensuring proper comma separation
      IF ExistingValues = '' THEN
        NewValues := intToStr(subFeeID)
      ELSE
        NewValues := ExistingValues + ',' + intToStr(subFeeID);

      tb_FeeE.Edit;
      tb_FeeE.FieldByName('BonusMalusReference').AsString := NewValues;
      tb_FeeE.Post;

      ShowMessage(Format('%s è stato aggiunto alla lista!',
        [Form2.tb_BonMalFees.FieldByName('Description').AsString]));
    END
    ELSE
    BEGIN
      ShowMessage(Format('La lista contiene già %s.',
        [Form2.tb_BonMalFees.FieldByName('Description').AsString]));
    END;
  END;
END;

PROCEDURE TForm1.AssignBlobToImage(DataSet: TDataSet; BlobFieldName: STRING;
ImageComponent: TImage);
VAR
  BlobStream: TMemoryStream;
  Graphic: TGraphic;
  Format: STRING;
BEGIN
  IF NOT DataSet.FieldByName(BlobFieldName).IsNull THEN
  BEGIN
    BlobStream := TMemoryStream.Create;
    TRY
      // Load the BLOB field into the stream
      TBlobField(DataSet.FieldByName(BlobFieldName)).SaveToStream(BlobStream);

      // Detect the image format
      Format := DetectImageFormat(BlobStream);

      // Load the appropriate graphic class based on the format
      Graphic := NIL;
      IF Format = 'BMP' THEN
        Graphic := TBitmap.Create
      ELSE IF Format = 'JPEG' THEN
        Graphic := TJPEGImage.Create
      ELSE IF Format = 'PNG' THEN
        Graphic := TPngImage.Create
      ELSE
        RAISE Exception.Create('Unsupported image format in the BLOB field.');

      TRY
        BlobStream.Position := 0; // Reset stream position before loading
        Graphic.LoadFromStream(BlobStream);
        ImageComponent.Picture.Assign(Graphic);
      FINALLY
        Graphic.Free;
      END;
    FINALLY
      BlobStream.Free;
    END;
  END
  ELSE
  BEGIN
    ImageComponent.Picture := NIL; // Clear the image if the field is null
    ShowMessage('The BLOB field is empty.');
  END;
END;

FUNCTION TForm1.GetWorkShiftForDateRange(aCalendar: TAdvSmoothCalendar;
DaysAuthorized: Integer): TArray<TDateTime>;
VAR
  CurrentTime: TTime;
  startDateTime, EndDateTime: TDateTime;
BEGIN
  CurrentTime := Time;
  // Single date (Today) selection

  IF (aCalendar.SelectedDate = DateOf(Now)) AND
    (CurrentTime < EncodeTime(12, 0, 0, 0)) THEN
  BEGIN
    // Adjust the start date if the current time is after midnight but before noon
    startDateTime := aCalendar.SelectedDate - 1 + EncodeTime(12, 0, 0, 0);
    EndDateTime := aCalendar.SelectedDate + EncodeTime(11, 59, 59, 0);
  END
  ELSE
  // Multi date selection
  BEGIN
    // Calculate the start and end date-times
    startDateTime := aCalendar.StartDate + EncodeTime(12, 0, 0, 0);
    // Start at 12:00 PM on the start date
    EndDateTime := (aCalendar.EndDate + 1) + EncodeTime(11, 59, 59, 0);
    // End at 2:00 AM on the day after the end date
  END;
  aCalendar.Footer.Caption := Format('Start: %s End: %s',
    [DateTimeToStr(startDateTime), DateTimeToStr(EndDateTime)]);

  // Check date range authorizations
  // -------------------------------------------------------------------------
  CASE DaysAuthorized OF
    0:
      begin
        startDateTime := 0;
        EndDateTime := 0;
        Result := TArray<TDateTime>.Create(startDateTime, EndDateTime);
        Exit;
      end;
    1:
      begin
        IF (DaySpan(startDateTime, EndDateTime) > 1) OR
          (startDateTime < IncDay(Now, -1)) Then
        begin
          startDateTime := 0;
          EndDateTime := 0;
          Result := TArray<TDateTime>.Create(startDateTime, EndDateTime);
          Exit;
        end;

      end;
    2 .. 15:
      Begin
        IF (DaySpan(startDateTime, EndDateTime) > 1) OR
          (startDateTime < IncDay(Now, -15)) Then
        begin
          startDateTime := 0;
          EndDateTime := 0;
          Result := TArray<TDateTime>.Create(startDateTime, EndDateTime);
          Exit;
        end;
      End;
  end;

  // Return the start and end times as an array
  Result := TArray<TDateTime>.Create(startDateTime, EndDateTime);
END;

PROCEDURE TForm1.ToggleMemoVisibilityAtMouse(Memo: TMemo);
VAR
  MousePos: TPoint;
BEGIN
  IF Memo.Showing THEN
    Memo.Hide
  ELSE
  BEGIN
    // Get the current mouse position relative to the screen
    MousePos := mouse.CursorPos;

    // Convert screen coordinates to the form's client area
    MousePos := ScreenToClient(MousePos);

    // Set the position of the Memo
    Memo.Left := MousePos.X;
    Memo.Top := MousePos.Y - 10;

    // Ensure Memo does not go outside the form's boundaries
    IF Memo.Left + Memo.Width > ClientWidth THEN
      Memo.Left := ClientWidth - Memo.Width;

    IF Memo.Top + Memo.Height > ClientHeight THEN
      Memo.Top := ClientHeight - Memo.Height;

    // Show the Memo
    Memo.BringToFront;
    Memo.Show;
  END;
END;

Function TForm1.GetUnclosedPeriods: TDate;
Var
  I: Integer;
begin
  With Form2.qy_TMP do
  begin
    SQL.Clear;
    SQL.Add('SELECT CAST( ' + 'CASE ' +
      'WHEN CAST(Data AS TIME) >= CAST(''12:00:00'' AS TIME) ' +
      'THEN Data  ELSE Data - INTERVAL ''1'' DAY ' + 'END ' +
      'AS DATE) AS WorkingDate, COUNT(*) AS NumRows ' + 'FROM c_1000 ' +
      'WHERE ClosingID IS NULL  AND ( ' +
      'CAST(Data AS TIME) >= CAST(''12:00:00'' AS TIME) ' +
      ' OR CAST(Data AS TIME) <= CAST(''11:59:59'' AS TIME)) ' +
      'GROUP BY CAST( ' + 'CASE ' +
      ' WHEN CAST(Data AS TIME) >= CAST(''12:00:00'' AS TIME) ' +
      ' THEN Data ELSE Data - INTERVAL ''1'' DAY ' + 'END AS DATE) ' +
      'ORDER BY WorkingDate');
    Active := True;
    IF RecordCount > 0 Then
    begin
      I := 0;
      SetLength(openPeriod_Arr, I);
      SetLength(openPeriod_Arr, RecordCount);
      While Not EOF do
      begin
        openPeriod_Arr[I] := DateOf(FieldByName('WorkingDate').AsDateTime);
        Inc(I);
        Next;
      end;
    end;
    Active := False;
  end;
  Var
    j: Integer;
  Var
    isfound: Boolean;
  Var
    foundDate: TDate;
  foundDate := 0;
  for I := 0 to High(selectedPeriod_Arr) do
  begin
    isfound := False;
    foundDate := 0; // default (invalid date)
    for j := 0 to High(openPeriod_Arr) do
    begin
      if SameDate(selectedPeriod_Arr[I], openPeriod_Arr[j]) then
      begin
        isfound := True;
        foundDate := openPeriod_Arr[j];
        Break;
      end;
    end;
    If isfound Then
      Break;
  end;
  Result := foundDate;
end;

FUNCTION TForm1.CheckIfHasComment(ClosingID: TDate): Boolean;
Begin
  ShowMessage(QuotedStr(Form2.EDBEngine1.DateToSQLStr(ClosingID)));
  With Form2, qy_TMP DO
  begin
    IF Active Then
      Close;
    SQL.Clear;
    SQL.Text := ('SELECT Comments FROM Pecunia ' + 'WHERE ClosingID = ' +
      QuotedStr(Form2.EDBEngine1.DateToSQLStr(ClosingID)) +
      ' AND Comments <> '''' AND NOT Comments IS NULL');
    Active := True;
    Result := RecordCount > 0;
  end;
END;

function TForm1.VariantToFloatDef(const V: Variant;
const Default: Double = 0.0): Double;
begin
  if VarIsNull(V) or VarIsEmpty(V) then
    Result := Default
  else
    Result := V;
end;

procedure TForm1.FetchEuroAndCHF;
const
  ECB_URL = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml';
var
  Client: TNetHTTPClient;
  resp: IHTTPResponse;
  XMLDoc: IXMLDocument;
  EnvelopeNode, ParentCube, DateCube, RateNode: IXMLNode;
  RatesDict: TDictionary<string, Double>;
  I: Integer;
  Curr: string;
  RateValue, CHFRate, CHFBaseRate: Double;
  Fmt: TFormatSettings;
begin
  FFetchingRates := True;

  FRatesEUR := TStringList.Create;
  FRatesCHF := TStringList.Create;
  Client := nil;
  RatesDict := nil;

  try
    try
      // Ensure decimal point parsing
      Fmt := TFormatSettings.Create('en-US');
      Fmt.DecimalSeparator := '.';

      Client := TNetHTTPClient.Create(nil);
      RatesDict := TDictionary<string, Double>.Create;

      // 1) Download the XML
      resp := Client.Get(ECB_URL);
      if resp.StatusCode <> 200 then
        raise Exception.Create('HTTP Error: ' + resp.StatusText);

      // 2) Parse it into an IXMLDocument
      XMLDoc := TXMLDocument.Create(nil);
      XMLDoc.Options := [doNodeAutoIndent, doAttrNull];
      XMLDoc.LoadFromXML(resp.ContentAsString);
      XMLDoc.Active := True;

      // 3) Find the <Cube> hierarchy: Envelope → Cube → Cube time="…" → Cube currency+rate
      EnvelopeNode := XMLDoc.DocumentElement; // <gesmes:Envelope>
      ParentCube := nil;
      for I := 0 to EnvelopeNode.ChildNodes.Count - 1 do
        if (EnvelopeNode.ChildNodes[I].NodeName = 'Cube') or
          EnvelopeNode.ChildNodes[I].NodeName.EndsWith(':Cube') then
        begin
          ParentCube := EnvelopeNode.ChildNodes[I];
          Break;
        end;
      if ParentCube = nil then
        raise Exception.Create('No top-level Cube node found');

      DateCube := nil;
      for I := 0 to ParentCube.ChildNodes.Count - 1 do
        if (ParentCube.ChildNodes[I].NodeName = 'Cube') or ParentCube.ChildNodes
          [I].NodeName.EndsWith(':Cube') then
        begin
          DateCube := ParentCube.ChildNodes[I];
          Break;
        end;
      if DateCube = nil then
        raise Exception.Create('No dated Cube node found');

      // 4) Build a dictionary of currency→rate (all relative to EUR)
      for I := 0 to DateCube.ChildNodes.Count - 1 do
      begin
        RateNode := DateCube.ChildNodes[I];
        if ((RateNode.NodeName = 'Cube') or RateNode.NodeName.EndsWith(':Cube'))
          and RateNode.HasAttribute('currency') then
        begin
          Curr := RateNode.Attributes['currency'];
          RateValue := strToFloat(RateNode.Attributes['rate'], Fmt);
          RatesDict.Add(Curr, RateValue);
        end;
      end;

      // 5) Store all EUR-base rates
      FRatesEUR.Add('--- Rates relative to EUR ---');
      for Curr in RatesDict.Keys do
        FRatesEUR.Add(Format('%s = %.6f', [Curr, RatesDict[Curr]]));

      // 6) Derive & store all CHF-base rates
      if not RatesDict.TryGetValue('CHF', CHFRate) then
        raise Exception.Create('CHF rate not found in ECB feed');

      FRatesCHF.Add('');
      FRatesCHF.Add('--- Rates relative to CHF ---');
      FRatesCHF.Add('CHF = 1.000000');
      for Curr in RatesDict.Keys do
        if Curr <> 'CHF' then
        begin
          CHFBaseRate := RatesDict[Curr] / CHFRate;
          FRatesCHF.Add(Format('%s = %.6f', [Curr, CHFBaseRate]));
        end;
      // And show EUR in CHF
      FRatesCHF.Add(Format('EUR = %.6f', [1 / CHFRate]));

      // Store the EUR rate
      if not RatesDict.ContainsKey('CHF') then
        RatesDict.Add('CHF', 1.0);

      FEURRate := RatesDict['CHF'];

      // SUCCESS - Queue UI update to main thread
      TThread.Queue(nil, UpdateUIWithRates);

    except
      on E: Exception do
      begin
        FErrorMessage := E.Message;
        // ERROR - Queue error display to main thread
        TThread.Queue(nil, ShowErrorMessage);
      end;
    end;

  finally
    if Assigned(RatesDict) then
      RatesDict.Free;
    if Assigned(Client) then
      Client.Free;
    // Note: FRatesEUR and FRatesCHF freed in UpdateUIWithRates or ShowErrorMessage
  end;
end;

function TForm1.FullDaysBetween(const A, B: TDateTime): Integer;
begin
  // Abs(B–A) is the difference in days (may be fractional).
  // Ceil() will round any non‑zero fraction up to the next integer.
  Result := Ceil(Abs(B - A));
end;

function TForm1.GetInstallDrive: string;
var
  exePath: string;
begin
  exePath := ParamStr(0); // full path to the running .exe
  Result := ExtractFileDrive(exePath); // e.g. 'C:'
end;

PROCEDURE TForm1.PrintNote(amt: Double; pID, Copies: Integer);
VAR
  tmpPrntStr: TStrings;
BEGIN
  tmpPrntStr := TStringList.Create;
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add(' Offerto bar da ' + FormatFloat('#,##0.00', amt));
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add('Data: ' + DateTimeToStr(Now));
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add(txnID + ' ' + uClientStore.ThisClient.alias);
  tmpPrntStr.Add(' ');
  tmpPrntStr.Add('_');
  IF GetCurrentPrinterStatus = 0 THEN
    Form2.t_executePrint_(rg_Printers.Items[rg_Printers.ItemIndex], tmpPrntStr,
      1, Copies, pID, 270, False, False)
  ELSE
  BEGIN
    ShowMessage('ATTENZIONE, Errore stampante no: ' +
      intToStr(GetCurrentPrinterStatus));
  END;
END;

function TryPing(Client: TIdIcmpClient; out ErrMsg: string): Boolean;
begin
  ErrMsg := '';
  Result := False;

  try
    Client.Ping; // <-- procedure in Indy

    // Decide success from reply (common simple check):
    Result := Client.ReplyStatus.BytesReceived > 0;

    // Alternative (if you prefer a stricter check):
    // Result := Client.ReplyStatus.ReplyStatusType = rsEcho;
  except
    on E: EIdSocketError do
    begin
      ErrMsg := Format('Ping socket error (WSA %d): %s',
        [E.LastError, E.Message]);
      Result := False;
    end;
    on E: Exception do
    begin
      ErrMsg := E.Message;
      Result := False;
    end;
  end;
end;

procedure TForm1.StopMediaPlayerAndShutdown;
begin
  RzStatusPane5.Caption := '';
  if IsProcessRunning
    ('C:\Program Files (x86)\PGC_525_MediaPlayer\PGC525_MediaPlayer.exe') then
  begin
    if Assigned(FTCPClient) then
    begin
      try
        if not FTCPClient.Connected then
        begin
          FTCPClient.Host := '127.0.0.1';
          FTCPClient.Port := 9999;
          FTCPClient.Connect;
        end;

        SafeSend('STOP1');
        Sleep(100);

        SafeSend('STOP2');
        Sleep(100);

        SafeSend('STOP3');
        Sleep(500);

        SafeSend('SHUTDOWN');
        Sleep(200);
      except
        // connection or other error; ignore for shutdown
      end;

      try
        if FTCPClient.Connected then
          FTCPClient.Disconnect;
      except
      end;
    end;

    Sleep(1000);
    try
      if IsProcessRunning
        ('C:\Program Files (x86)\PGC_525_MediaPlayer\PGC525_MediaPlayer.exe')
      then
        TerminateMediaPlayerProcess;
    except
    end;

    RzStatusPane5.Caption := 'Media player stopped. Logging out...';
  end
  else
    RzStatusPane5.Caption := 'Media player was not running';
end;

procedure TForm1.TerminateMediaPlayerProcess;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  ProcessHandle: THandle;
begin
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then
    Exit;

  try
    ZeroMemory(@ProcessEntry, SizeOf(ProcessEntry));
    ProcessEntry.dwSize := SizeOf(ProcessEntry);

    if Process32First(Snapshot, ProcessEntry) then
      repeat
        if SameText(ProcessEntry.szExeFile, 'PGC525_MediaPlayer.exe') then
        begin
          ProcessHandle := OpenProcess(PROCESS_TERMINATE, False,
            ProcessEntry.th32ProcessID);
          if ProcessHandle <> 0 then
            try
              TerminateProcess(ProcessHandle, 0);
            finally
              CloseHandle(ProcessHandle);
            end;
        end;
      until not Process32Next(Snapshot, ProcessEntry);
  finally
    CloseHandle(Snapshot);
  end;
end;

procedure TForm1.SendPlaylistCommand(const ACmd: string);
var
  c: TIdTCPClient;
  resp: string;
begin
  c := TIdTCPClient.Create(nil);
  try
    c.Host := '127.0.0.1';
    c.Port := 9999;
    c.ConnectTimeout := 3000;
    c.ReadTimeout := 3000;

    c.Connect;
    c.IOHandler.WriteLn(ACmd, IndyTextEncoding_UTF8);
    resp := c.IOHandler.ReadLn(IndyTextEncoding_UTF8); // 'OK' or error
  finally
    c.Free;
  end;
end;

procedure TForm1.SafeSend(const ACmd: string);
begin
  if not FTCPClient.Connected then
    Exit;

  try
    SendTCPCommand(ACmd);
  except
    on E: EIdSocketError do
    begin
      // Remote closed connection; stop using it
      try
        FTCPClient.Disconnect(False);
      except
      end;
    end;
  end;
end;

function TForm1.SendTCPCommand(const Command: string): Boolean;
begin
  Result := False;

  if not Assigned(FTCPClient) then
    Exit;

  if not FTCPClient.Connected then
    Exit;

  try
    FTCPClient.IOHandler.WriteLn(Command, IndyTextEncoding_UTF8);
    Result := True;
  except
    // Silently fail - connection was lost
    Result := False;
  end;
end;

function TForm1.IsProcessRunning(const AExeName: string): Boolean;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  ExeNameOnly: string;
begin
  Result := False;
  ExeNameOnly := ExtractFileName(AExeName); // Get just the filename

  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot <> INVALID_HANDLE_VALUE then
    try
      ProcessEntry.dwSize := SizeOf(TProcessEntry32);
      if Process32First(Snapshot, ProcessEntry) then
        repeat
          if SameText(ProcessEntry.szExeFile, ExeNameOnly) then
          begin
            Result := True;
            Break;
          end;
        until not Process32Next(Snapshot, ProcessEntry);
    finally
      CloseHandle(Snapshot);
    end;
end;

procedure TForm1.StartFetchingRates;
begin
  if FFetchingRates then
  begin
    ShowMessage('Already fetching rates...');
    Exit;
  end;

  TThread.CreateAnonymousThread(
    procedure
    begin
      FetchEuroAndCHF;
    end).Start;
end;

procedure TForm1.UpdateUIWithRates;
var
  I: Integer;
begin
  try
    MemoRates.Lines.BeginUpdate;
    try
      for I := 0 to FRatesEUR.Count - 1 do
        MemoRates.Lines.Add(FRatesEUR[I]);

      for I := 0 to FRatesCHF.Count - 1 do
        MemoRates.Lines.Add(FRatesCHF[I]);

      ed_EuroRate.Text := floatToStr(FEURRate);
      // Or .Value if it's a numeric edit
    finally
      MemoRates.Lines.EndUpdate;
    end;
  finally
    FFetchingRates := False;
    FreeAndNil(FRatesEUR);
    FreeAndNil(FRatesCHF);
  end;
end;

// This runs in MAIN thread - safe to show messages
procedure TForm1.ShowErrorMessage;
begin
  try
    ShowMessage('Error fetching rates: ' + FErrorMessage);
  finally
    FFetchingRates := False;
    FreeAndNil(FRatesEUR);
    FreeAndNil(FRatesCHF);
  end;
end;

{
  procedure TForm1.PagerWndProc(var msg: TMessage);
  begin
  if msg.msg = WM_SETREDRAW then
  begin
  OutputDebugString(PChar(Format('WM_SETREDRAW on TabPager wParam=%d',
  [msg.WPARAM])));
  if msg.WPARAM = 0 then
  raise Exception.Create('TabPager redraw disabled (WM_SETREDRAW=0)');
  // debugger breaks here
  end;

  FOldPagerProc(msg);
  end;
}

function CurrencyToItalianWords(Amount: Currency;
const CurrencyName: string = 'euro';
const CentName: string = 'centesimi'): string;
var
  IntPart, CentPart: Int64;
  Negative: Boolean;

  function UnitaToWords(n: Integer): string;
  const
    Unita: array [0 .. 19] of string = ('', 'un', 'due', 'tre', 'quattro',
      'cinque', 'sei', 'sette', 'otto', 'nove', 'dieci', 'undici', 'dodici',
      'tredici', 'quattordici', 'quindici', 'sedici', 'diciassette', 'diciotto',
      'diciannove');
  begin
    Result := Unita[n];
  end;

  function DecineToWords(n: Integer): string;
  const
    Decine: array [2 .. 9] of string = ('venti', 'trenta', 'quaranta',
      'cinquanta', 'sessanta', 'settanta', 'ottanta', 'novanta');
  var
    Decina, Unita: Integer;
  begin
    if n < 20 then
      Result := UnitaToWords(n)
    else
    begin
      Decina := n div 10;
      Unita := n mod 10;
      Result := Decine[Decina];
      // Drop final vowel before 'uno' and 'otto'
      if (Unita = 1) or (Unita = 8) then
        Result := Copy(Result, 1, Length(Result) - 1);
      Result := Result + UnitaToWords(Unita);
    end;
  end;

  function CentinaiaToWords(n: Integer): string;
  const
    Centinaia: array [1 .. 9] of string = ('cento', 'duecento', 'trecento',
      'quattrocento', 'cinquecento', 'seicento', 'settecento', 'ottocento',
      'novecento');
  begin
    if n < 100 then
      Result := DecineToWords(n)
    else
    begin
      Result := Centinaia[n div 100];
      if n mod 100 > 0 then
        Result := Result + DecineToWords(n mod 100);
    end;
  end;

  function MigliaiaToWords(n: Int64): string;
  begin
    Result := '';
    if n = 0 then
      Exit;

    if n >= 1000000000 then
    begin
      if n div 1000000000 = 1 then
        Result := 'un miliardo '
      else
        Result := CentinaiaToWords(n div 1000000000) + ' miliardi ';
      n := n mod 1000000000;
    end;

    if n >= 1000000 then
    begin
      if n div 1000000 = 1 then
        Result := Result + 'un milione '
      else
        Result := Result + CentinaiaToWords(n div 1000000) + ' milioni ';
      n := n mod 1000000;
    end;

    if n >= 1000 then
    begin
      if n div 1000 = 1 then
        Result := Result + 'mille'
      else
        Result := Result + CentinaiaToWords(n div 1000) + 'mila';
      n := n mod 1000;
    end;

    if n > 0 then
      Result := Result + CentinaiaToWords(n);
  end;

begin
  Negative := Amount < 0;
  if Negative then
    Amount := -Amount;

  IntPart := Trunc(Amount);
  CentPart := Round((Amount - IntPart) * 100);

  if IntPart = 0 then
    Result := 'zero'
  else
    Result := Trim(MigliaiaToWords(IntPart));

  var
    Pecunia: String;
  if (CurrencyName = 'CH') or (CurrencyName = 'CC') then
  begin
    if IntPart = 1 then
      Pecunia := 'Franco'
    else
      Pecunia := 'Franchi';
  end
  else
    Pecunia := 'Euro';

  // Currency name (singular/plural)
  if IntPart = 1 then
  begin
    Result := Result + ' ' + Pecunia;
  end
  else
    Result := Result + ' ' + Pecunia; // Italian: euro is invariable

  if CentPart > 0 then
    Result := Result + ' e ' + Trim(MigliaiaToWords(CentPart)) + ' ' + CentName;

  if Negative then
    Result := 'meno ' + Result;

  // Capitalize first letter
  if Result <> '' then
    Result[1] := UpCase(Result[1]);
end;

procedure TForm1.MGuardClient1Connected(Sender: TObject);
begin
  shp_MGuardConnect.Brush.Color := clLime;
end;

procedure TForm1.MGuardClient1ServerDisconnected(Sender: TObject);
begin
  shp_MGuardConnect.Brush.Color := clRed;
end;

INITIALIZATION

TForm1.FInstanceCount := 0;
TForm1.FFirstInstance := nil;

mHandle := CreateMutex(NIL, True, 'PGC_525_Euro');
IF GetLastError = ERROR_ALREADY_EXISTS THEN
BEGIN
  ShowMessage('Program is already running!');
  Halt;
END;

FINALIZATION

IF mHandle <> 0 THEN
  CloseHandle(mHandle);

END.
