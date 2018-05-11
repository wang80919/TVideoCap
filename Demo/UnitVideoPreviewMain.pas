unit UnitVideoPreviewMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Videocap, StdCtrls, Buttons,
  Spin, vfw, ExtCtrls;

type
  TFormMain = class(TForm)
    GroupBoxCapture: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cbxCaptureDriver: TComboBox;
    BitBtnChangeVidCap: TBitBtn;
    BitBtnVideoPreview: TBitBtn;
    LabelCurVIDCap: TEdit;
    Capture: TVideoCap;
    BitBtnChangeFormat: TBitBtn;
    BitBtnChangeDispaly: TBitBtn;
    BitBtnChangeCompression: TBitBtn;
    BitBtnSaveToClipboard: TBitBtn;
    CheckBoxStretch: TCheckBox;
    CheckBoxProportional: TCheckBox;
    CheckBoxCenter: TCheckBox;
    ComboBoxSize: TComboBox;
    Label1: TLabel;
    procedure cbxCaptureDriverChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnChangeVidCapClick(Sender: TObject);
    procedure BitBtnVideoPreviewClick(Sender: TObject);
    procedure BitBtnChangeFormatClick(Sender: TObject);
    procedure BitBtnChangeDispalyClick(Sender: TObject);
    procedure BitBtnChangeCompressionClick(Sender: TObject);
    procedure BitBtnSaveToClipboardClick(Sender: TObject);
    procedure CheckBoxStretchClick(Sender: TObject);
    procedure CheckBoxProportionalClick(Sender: TObject);
    procedure CheckBoxCenterClick(Sender: TObject);
    procedure ComboBoxSizeChange(Sender: TObject);
  private
    { Private declarations }
    FisShowing: Boolean;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.cbxCaptureDriverChange(Sender: TObject);
begin
  if not FisShowing then
  begin
    Capture.DriverIndex := cbxCaptureDriver.ItemIndex;
    if Capture.VideoPreview then
    begin
      BitBtnVideoPreview.Caption := 'StopPreview';
    end
    else
    begin
      BitBtnVideoPreview.Caption := 'StartPreview';
    end;
    if cbxCaptureDriver.ItemIndex >= 0 then
    begin
      LabelCurVIDCap.Text := GetVideoCapDeviceNameByDriverIndex(cbxCaptureDriver.ItemIndex, True);
    end
    else
    begin
      LabelCurVIDCap.Text := 'NA';
      Capture.VideoPreview := False;
      Capture.DriverOpen := False;
      BitBtnVideoPreview.Caption := 'StartPreview';
    end;
    BitBtnChangeVidCap.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and Capture.HasDlgSource;
    BitBtnChangeFormat.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and Capture.HasDlgFormat;
    BitBtnVideoPreview.Enabled := (cbxCaptureDriver.ItemIndex >= 0);
    BitBtnChangeDispaly.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and Capture.HasDlgDisplay;
    BitBtnChangeCompression.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and Capture.HasDlgFormat;
    BitBtnSaveToClipboard.Enabled := Capture.VideoPreview;
  end;
end;

procedure TFormMain.CheckBoxCenterClick(Sender: TObject);
begin
  Capture.PreviewfCenterToWindows := CheckBoxCenter.Checked;
end;

procedure TFormMain.CheckBoxProportionalClick(Sender: TObject);
begin
  Capture.PreviewScaleProportional := CheckBoxProportional.Checked;
end;

procedure TFormMain.CheckBoxStretchClick(Sender: TObject);
begin
  Capture.PreviewScaleToWindow := CheckBoxStretch.Checked;
end;

procedure TFormMain.ComboBoxSizeChange(Sender: TObject);
var
  HintStr: string;
  Bh: TBitmapInfoHeader;
begin
  if not Capture.DriverOpen then exit;
  Bh := Capture.BitMapInfoHeader;
  case ComboBoxSize.ItemIndex of
    1:
    begin
      Bh.biWidth := 800;
      Bh.biHeight := 600;
    end;
    2:
    begin
      Bh.biWidth := 1024;
      Bh.biHeight := 768;
    end;
    3:
    begin
      Bh.biWidth := 1280;
      Bh.biHeight := 1024;
    end;
    4:
    begin
      Bh.biWidth := 1280;
      Bh.biHeight := 720;
    end;
    5:
    begin
      Bh.biWidth := 1920;
      Bh.biHeight := 1080;
    end;
    6:
    begin
      Bh.biWidth := 854;
      Bh.biHeight := 480;
    end;
    //0:
    else
    begin

    end;
  end;
  Bh := GetBitmapInfoHeader(Bh.biCompression, Bh.biWidth, Bh.biHeight, Bh.biBitCount);
  if Capture.IsBitmapHeaderSupport(Bh) then
  begin
    Capture.BitMapInfoHeader := Bh;
  end;
  ClientWidth := Capture.CapWidth;
  ClientHeight := Capture.CapHeight + GroupBoxCapture.Height;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FisShowing := True;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin

  cbxCaptureDriver.Items.Clear;
  cbxCaptureDriver.Items.AddStrings(VideoCap.GetDriverList);
  cbxCaptureDriver.ItemIndex := -1;

  FisShowing := False;
end;

procedure TFormMain.BitBtnChangeDispalyClick(Sender: TObject);
var
  HintStr: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVDisplay;
    except
      HintStr := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeCompressionClick(Sender: TObject);
var
  HintStr: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVCompression;
    except
      HintStr := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeFormatClick(Sender: TObject);
var
  HintStr: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      if Capture.DlgVFormat then
      begin
        ComboBoxSize.ItemIndex := -1;
        ComboBoxSize.ItemIndex := 0;
      end;
    except
      HintStr := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeVidCapClick(Sender: TObject);
var
  HintStr: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVSource;
    except
      HintStr := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
    LabelCurVIDCap.Text :=  GetVideoCapDeviceNameByDriverIndex(cbxCaptureDriver.ItemIndex, True);
  end;
end;

procedure TFormMain.BitBtnSaveToClipboardClick(Sender: TObject);
begin
  Capture.SaveToClipboard;
end;

procedure TFormMain.BitBtnVideoPreviewClick(Sender: TObject);
var
  HintStr: string;
begin
  if Capture.VideoPreview then
  begin
    Capture.VideoPreview := False;
    Capture.DriverOpen := False;
  end
  else
  begin
    try
      Capture.VideoPreview := False;
      Capture.DriverOpen := True;
      ComboBoxSizeChange(Sender);
      Capture.VideoPreview := True;
      if Capture.HasVideoOverlay then
        Capture.VideoOverlay := True;
      {
      if Capture.CapWidth > Capture.CapHeight then
      begin
        Capture.Height := Capture.Width * Capture.CapHeight div Capture.CapWidth;
      end
      else
      begin
        Capture.Width := Capture.Height * Capture.CapWidth div Capture.CapHeight;
      end;
      //}
    except
      on E: EFalseFormat do
      begin
        HintStr := 'The current format not support, please click ChangeFormat button.';
        Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
        exit;
      end;
      else
      begin
        HintStr := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
          'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
          'Please make sure that the device is in available state.';
        Application.MessageBox(PChar(HintStr), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
      end;
    end;
  end;
  BitBtnSaveToClipboard.Enabled := Capture.VideoPreview;
  if Capture.VideoPreview then
  begin
    BitBtnVideoPreview.Caption := 'StopPreview';
  end
  else
  begin
    BitBtnVideoPreview.Caption := 'StartPreview';
  end;
end;

end.
