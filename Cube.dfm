object MainForm: TMainForm
  Left = 0
  Top = 0
  ActiveControl = SpinEdit1
  Caption = #1052#1072#1083#1100#1086#1074#1072#1085#1080#1081' Cube'
  ClientHeight = 415
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 64
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 64
    Top = 375
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object SpinEdit1: TSpinEdit
    Left = 464
    Top = 368
    Width = 41
    Height = 22
    MaxValue = 20
    MinValue = 1
    TabOrder = 2
    Value = 1
  end
  object timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timerTimer
    Left = 80
    Top = 296
  end
end
