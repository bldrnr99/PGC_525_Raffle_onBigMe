object Manual: TManual
  Left = 0
  Top = 0
  Caption = 'Manual'
  ClientHeight = 479
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 233
    Height = 479
    Align = alLeft
    DataSource = scqy_Manual
    DynProps = <>
    TabOrder = 0
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBRichEditEh1: TDBRichEditEh
    Left = 239
    Top = 8
    Width = 394
    Height = 463
    EditButtons = <>
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    TabOrder = 1
  end
  object DBGridEh2: TDBGridEh
    Left = 400
    Top = 232
    Width = 300
    Height = 120
    DynProps = <>
    TabOrder = 2
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBRichEditEh2: TDBRichEditEh
    Left = 336
    Top = 152
    Width = 185
    Height = 89
    EditButtons = <>
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    TabOrder = 3
  end
  object scqy_Manual: TDataSource
    DataSet = Form2.qy_Manual
    Left = 592
    Top = 432
  end
end
