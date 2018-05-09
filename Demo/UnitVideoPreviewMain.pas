unit UnitVideoPreviewMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Videocap, StdCtrls, Buttons,
  Spin, vfw;

type
  TFormMain = class(TForm)
    GroupBoxCapture: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbxCaptureDriver: TComboBox;
    SpinEditCapturePicWidth: TSpinEdit;
    SpinEditCapturePicHeight: TSpinEdit;
    BitBtnChangeVidCap: TBitBtn;
    BitBtnVideoPreview: TBitBtn;
    LabelCurVIDCap: TEdit;
    vcCapture: TVideoCap;
    BitBtnChangeFormat: TBitBtn;
    BitBtnChangeDispaly: TBitBtn;
    BitBtnChangeCompression: TBitBtn;
    procedure cbxCaptureDriverChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnChangeVidCapClick(Sender: TObject);
    procedure BitBtnVideoPreviewClick(Sender: TObject);
    procedure BitBtnChangeFormatClick(Sender: TObject);
    procedure BitBtnChangeDispalyClick(Sender: TObject);
    procedure BitBtnChangeCompressionClick(Sender: TObject);
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
    vcCapture.DriverIndex := cbxCaptureDriver.ItemIndex;
    if vcCapture.VideoPreview then
    begin
      BitBtnVideoPreview.Caption := '关闭预览';
    end
    else
    begin
      BitBtnVideoPreview.Caption := '开始预览';
    end;
    if cbxCaptureDriver.ItemIndex >= 0 then
    begin
      LabelCurVIDCap.Text := GetVideoCapDeviceNameByDriverIndex(cbxCaptureDriver.ItemIndex, True);
    end
    else
    begin
      LabelCurVIDCap.Text := '无';
      vcCapture.VideoPreview := False;
      vcCapture.DriverOpen := False;
      BitBtnVideoPreview.Caption := '开始预览';
    end;
    BitBtnChangeVidCap.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and vcCapture.HasDlgSource;
    BitBtnChangeFormat.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and vcCapture.HasDlgFormat;
    BitBtnVideoPreview.Enabled := (cbxCaptureDriver.ItemIndex >= 0);
    BitBtnChangeDispaly.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and vcCapture.HasDlgDisplay;
    BitBtnChangeCompression.Enabled := (cbxCaptureDriver.ItemIndex >= 0) and vcCapture.HasDlgFormat;
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
      vcCapture.DlgVDisplay;
    except
      sHint := '指定拍照所用的摄像设备目前无法使用，请检查摄像头是否' + sLineBreak +
                 '与本计算机正常连接，请确定该设备处于可用状态！';
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
      vcCapture.DlgVCompression;
    except
      sHint := '指定拍照所用的摄像设备目前无法使用，请检查摄像头是否' + sLineBreak +
                 '与本计算机正常连接，请确定该设备处于可用状态！';
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
      vcCapture.DlgVFormat;
    except
      sHint := '指定拍照所用的摄像设备目前无法使用，请检查摄像头是否' + sLineBreak +
                 '与本计算机正常连接，请确定该设备处于可用状态！';
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
      vcCapture.DlgVSource;
    except
      sHint := '指定拍照所用的摄像设备目前无法使用，请检查摄像头是否' + sLineBreak +
                 '与本计算机正常连接，请确定该设备处于可用状态！';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
    LabelCurVIDCap.Text :=  GetVideoCapDeviceNameByDriverIndex(cbxCaptureDriver.ItemIndex, True);
  end;
end;

procedure TFormMain.BitBtnVideoPreviewClick(Sender: TObject);
var
  sHint: string;
begin
  if vcCapture.VideoPreview then
  begin
    vcCapture.VideoPreview := False;
    vcCapture.DriverOpen := False;
  end
  else
  begin
    try
      vcCapture.VideoPreview := False;
      vcCapture.DriverOpen := True;
      vcCapture.VideoPreview := True;
      {
      if vcCapture.CapWidth > vcCapture.CapHeight then
      begin
        vcCapture.Height := vcCapture.Width * vcCapture.CapHeight div vcCapture.CapWidth;
      end
      else
      begin
        vcCapture.Width := vcCapture.Height * vcCapture.CapWidth div vcCapture.CapHeight;
      end;
      //}
    except
      sHint := '指定拍照所用的摄像设备目前无法使用，请检查摄像头是否' + sLineBreak +
                 '与本计算机正常连接，请确定该设备处于可用状态！';
      Application.MessageBox(PChar(sHint), PChar('Message'), MB_OK or MB_ICONSTOP or MB_TOPMOST);
    end;
  end;
  if vcCapture.VideoPreview then
  begin
    BitBtnVideoPreview.Caption := '关闭预览';
  end
  else
  begin
    BitBtnVideoPreview.Caption := '开始预览';
  end;
end;

end.
