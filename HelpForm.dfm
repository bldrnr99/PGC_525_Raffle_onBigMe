object frmHelp: TfrmHelp
  Left = 0
  Top = 0
  Caption = 'frmHelp'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblTopic: TLabel
      Left = 8
      Top = 15
      Width = 42
      Height = 15
      Caption = 'lblTopic'
    end
  end
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 41
    Width = 624
    Height = 400
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 152
    ExplicitTop = 128
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C0000007E400000572900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
