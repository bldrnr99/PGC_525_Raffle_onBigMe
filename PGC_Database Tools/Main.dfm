object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 653
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 634
    Width = 989
    Height = 19
    Panels = <>
  end
  object Button1: TButton
    Left = 48
    Top = 32
    Width = 137
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 272
    Top = 34
    Width = 633
    Height = 281
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object ProgressBar1: TProgressBar
    Left = 272
    Top = 320
    Width = 633
    Height = 17
    TabOrder = 3
  end
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 343
    Width = 961
    Height = 298
    DataSource = Form2.DataSource1
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 4
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
end
