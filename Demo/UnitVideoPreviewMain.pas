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
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BitBtnSaveToClipboard: TBitBtn;
    procedure cbxCaptureDriverChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnChangeVidCapClick(Sender: TObject);
    procedure BitBtnVideoPreviewClick(Sender: TObject);
    procedure BitBtnChangeFormatClick(Sender: TObject);
    procedure BitBtnChangeDispalyClick(Sender: TObject);
    procedure BitBtnChangeCompressionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtnSaveToClipboardClick(Sender: TObject);
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
  sHint: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVDisplay;
    except
      sHint := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeCompressionClick(Sender: TObject);
var
  sHint: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVCompression;
    except
      sHint := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeFormatClick(Sender: TObject);
var
  sHint: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVFormat;
    except
      sHint := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
end;

procedure TFormMain.BitBtnChangeVidCapClick(Sender: TObject);
var
  sHint: string;
begin
  if cbxCaptureDriver.ItemIndex >= 0 then
  begin
    try
      Capture.DlgVSource;
    except
      sHint := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
        'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
        'Please make sure that the device is in available state.';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
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
  sHint: string;
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
        sHint := 'The current format not support, please click ChangeFormat button.';
        Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
        exit;
      end;
      else
      begin
        sHint := 'The camera equipment for the designated photo is not currently available.' + sLineBreak +
          'Please check whether the camera is connected to the computer properly. ' + sLineBreak +
          'Please make sure that the device is in available state.';
        Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
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

procedure TFormMain.Button1Click(Sender: TObject);
begin
  Capture.PreviewScaleToWindow := not Capture.PreviewScaleToWindow;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  Capture.PreviewScaleProportional := not Capture.PreviewScaleProportional;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  Capture.PreviewfCenterToWindows := not Capture.PreviewfCenterToWindows;
end;

end.
