object FormMain: TFormMain
  Left = 496
  Top = 231
  Caption = 'FormMain'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxCapture: TGroupBox
    Left = 0
    Top = 0
    Width = 640
    Height = 107
    Align = alTop
    Caption = 'Settings'
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 650
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 48
      Height = 12
      Caption = 'Drivers:'
      FocusControl = cbxCaptureDriver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 52
      Width = 48
      Height = 12
      Caption = 'Device: '
      FocusControl = cbxCaptureDriver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 487
      Top = 24
      Width = 36
      Height = 12
      Caption = 'Size :'
      FocusControl = cbxCaptureDriver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cbxCaptureDriver: TComboBox
      Left = 70
      Top = 21
      Width = 403
      Height = 20
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = cbxCaptureDriverChange
    end
    object BitBtnChangeVidCap: TBitBtn
      Left = 16
      Top = 75
      Width = 89
      Height = 28
      Caption = 'ChangeDevice'
      Enabled = False
      TabOrder = 1
      OnClick = BitBtnChangeVidCapClick
    end
    object BitBtnVideoPreview: TBitBtn
      Left = 432
      Top = 75
      Width = 89
      Height = 28
      Caption = 'StartPreview'
      Enabled = False
      TabOrder = 5
      OnClick = BitBtnVideoPreviewClick
    end
    object LabelCurVIDCap: TEdit
      Left = 70
      Top = 49
      Width = 228
      Height = 20
      AutoSize = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      Text = '__________________________________'
    end
    object BitBtnChangeFormat: TBitBtn
      Left = 112
      Top = 75
      Width = 89
      Height = 28
      Caption = 'ChangeFormat'
      Enabled = False
      TabOrder = 2
      OnClick = BitBtnChangeFormatClick
    end
    object BitBtnChangeDispaly: TBitBtn
      Left = 208
      Top = 75
      Width = 89
      Height = 28
      Caption = 'ChangeDispaly'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtnChangeDispalyClick
    end
    object BitBtnChangeCompression: TBitBtn
      Left = 304
      Top = 75
      Width = 123
      Height = 28
      Caption = 'ChangeCompression'
      Enabled = False
      TabOrder = 4
      OnClick = BitBtnChangeCompressionClick
    end
    object BitBtnSaveToClipboard: TBitBtn
      Left = 528
      Top = 75
      Width = 106
      Height = 28
      Caption = 'CopyToClipboard'
      Enabled = False
      TabOrder = 7
      OnClick = BitBtnSaveToClipboardClick
    end
    object CheckBoxStretch: TCheckBox
      Left = 344
      Top = 52
      Width = 58
      Height = 17
      Caption = 'Stretch'
      TabOrder = 8
      OnClick = CheckBoxStretchClick
    end
    object CheckBoxProportional: TCheckBox
      Left = 425
      Top = 52
      Width = 82
      Height = 17
      Caption = 'Proportional'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBoxProportionalClick
    end
    object CheckBoxCenter: TCheckBox
      Left = 552
      Top = 52
      Width = 62
      Height = 17
      Caption = 'Center'
      TabOrder = 10
      OnClick = CheckBoxCenterClick
    end
    object ComboBoxSize: TComboBox
      Left = 523
      Top = 20
      Width = 102
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 11
      Text = 'Default(vfw)'
      OnChange = ComboBoxSizeChange
      Items.Strings = (
        'Default(vfw)'
        '800x600'
        '1024x768'
        '1280x1024'
        '1280x720'
        '1920x1080'
        '854x480')
    end
  end
  object Capture: TVideoCap
    Left = 0
    Top = 107
    Width = 640
    Height = 373
    align = alClient
    DriverOpen = False
    DriverIndex = -1
    VideoOverlay = False
    VideoPreview = False
    PreviewScaleToWindow = False
    PreviewScaleProportional = True
    PreviewfCenterToWindows = False
    AutoSelectYUY2 = True
    PreviewRate = 30
    MicroSecPerFrame = 66667
    FrameRate = 15
    CapAudio = False
    VideoFileName = 'Video.avi'
    SingleImageFile = 'Capture.bmp'
    CapTimeLimit = 0
    CapIndexSize = 0
    CapToFile = True
    BufferFileSize = 0
    ExplicitTop = 119
    ExplicitWidth = 650
  end
end
