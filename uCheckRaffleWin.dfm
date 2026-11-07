object frmCheckRaffleWin: TfrmCheckRaffleWin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Verifica vincita'
  ClientHeight = 301
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object lblTxID: TLabel
    Left = 16
    Top = 16
    Width = 150
    Height = 17
    Caption = 'Codice vincita (TxID / QR):'
  end
  object edTxID: TEdit
    Left = 16
    Top = 38
    Width = 296
    Height = 25
    TabOrder = 0
    OnKeyPress = edTxIDKeyPress
  end
  object btnCheck: TButton
    Left = 324
    Top = 36
    Width = 100
    Height = 28
    Caption = 'Verifica'
    Default = True
    TabOrder = 1
    OnClick = btnCheckClick
  end
  object pnlResult: TPanel
    Left = 16
    Top = 84
    Width = 408
    Height = 160
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 2
    object lblResult: TLabel
      Left = 0
      Top = 0
      Width = 408
      Height = 64
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Inserire o scansionare il codice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object lblDetail: TLabel
      Left = 0
      Top = 64
      Width = 408
      Height = 96
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitTop = 70
    end
  end
  object btnRedeemNow: TButton
    Left = 324
    Top = 250
    Width = 100
    Height = 43
    Caption = 'Riscuoti'
    Default = True
    TabOrder = 3
    OnClick = btnRedeemNowClick
  end
  object EDBQuery1: TEDBQuery
    Params = <>
    Left = 256
    Top = 8
  end
end
