object dlg_Pecunia: Tdlg_Pecunia
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'dlg_Pecunia'
  ClientHeight = 695
  ClientWidth = 623
  Color = clGray
  TransparentColor = True
  TransparentColorValue = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.SheetOfGlass = True
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 520
    Width = 141
    Height = 30
    Caption = 'P A G A  C O N'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object DBNumberEditEh3: TDBNumberEditEh
    Left = 480
    Top = 174
    Width = 121
    Height = 21
    BorderStyle = bsNone
    DisplayFormat = '#,#.00'
    DynProps = <>
    EditButtons = <>
    ParentColor = True
    TabOrder = 0
    Visible = True
  end
  object pl_Recpayment: TPanel
    Left = 200
    Top = 451
    Width = 385
    Height = 254
    BevelOuter = bvNone
    TabOrder = 1
    object lb_TabTxID: TLabel
      Left = 16
      Top = 50
      Width = 114
      Height = 19
      Caption = 'Totale scontrino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 16
      Top = 77
      Width = 251
      Height = 19
      Caption = 'Deduzione consumazione con ticket'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 16
      Top = 102
      Width = 360
      Height = 2
      Brush.Color = clGray
      Pen.Color = clWhite
    end
    object Label5: TLabel
      Left = 16
      Top = 114
      Width = 67
      Height = 19
      Caption = 'Saldo bar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 23
      Top = 152
      Width = 108
      Height = 19
      Caption = 'Ticket d'#39'entrata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 25
      Top = 177
      Width = 67
      Height = 19
      Caption = 'Saldo bar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Shape2: TShape
      Left = 16
      Top = 202
      Width = 360
      Height = 2
      Brush.Color = clGray
      Pen.Color = clWhite
    end
    object lb_balToPay: TLabel
      Left = 25
      Top = 209
      Width = 114
      Height = 19
      Caption = 'Saldo da pagare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 5
      Width = 304
      Height = 19
      Caption = 'Pagamento scontrino bar in ricezione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_BarTabTotal: TDBNumberEditEh
      Left = 286
      Top = 48
      Width = 81
      Height = 29
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Value = 0.000000000000000000
      Visible = True
    end
    object ed_firstTabAmt: TDBNumberEditEh
      Left = 278
      Top = 75
      Width = 89
      Height = 21
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Value = 0.000000000000000000
      Visible = True
    end
    object ed_BarBalance: TDBNumberEditEh
      Left = 278
      Top = 110
      Width = 89
      Height = 21
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Value = 0.000000000000000000
      Visible = True
    end
    object ed_tkAmt: TDBNumberEditEh
      Left = 246
      Top = 150
      Width = 121
      Height = 21
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Value = 0.000000000000000000
      Visible = True
    end
    object ed_BarBalance2: TDBNumberEditEh
      Left = 246
      Top = 175
      Width = 121
      Height = 21
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Value = 0.000000000000000000
      Visible = True
    end
    object ed_BalToPay: TDBNumberEditEh
      Left = 272
      Top = 207
      Width = 95
      Height = 21
      BorderStyle = bsNone
      Color = clGray
      DisplayFormat = '#,#.00'
      DynProps = <>
      EditButtons = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Value = 0.000000000000000000
      Visible = True
    end
  end
end
