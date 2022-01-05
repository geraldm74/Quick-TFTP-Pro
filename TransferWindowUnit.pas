unit TransferWindowUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Shader, StdCtrls, Buttons, AdvPanel, ComCtrls,
  AdvProgressBar;

type
  TTransferWindowForm = class(TForm)
    AdvPanelStyler1: TAdvPanelStyler;
    AdvPanel1: TAdvPanel;
    Animate: TAnimate;
    TransTypeLabel: TLabel;
    DestLabel: TLabel;
    ProgressBar: TAdvProgressBar;
    Type1Label: TLabel;
    RateHeaderLabel: TLabel;
    RateLabel: TLabel;
    CloseButton: TBitBtn;
    TransDoneImage: TImage;
    TransDoneLabel: TLabel;
    Timer: TTimer;
    TimeLeftLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure UpdateDisplay;
    Function  GetRate(Position : Longint; LastPosition : Longint) : Longint;
    Function  GetAverageRate : Longint;
    function  ss2nn(Seconds: Integer): String;
  public
    { Public declarations }
  end;

var
  TransferWindowForm: TTransferWindowForm;
  ItemIdx           : Integer;
  Filename          : String;
  Temptime          : DWord;
  LastPosition      : Longint;
  Rate              : Longint;

implementation

uses MainUnit;

{$R *.dfm}
{$R aviresource.RES}

procedure TTransferWindowForm.UpdateDisplay;
Begin
   If (ItemIdx < 0) Then Exit;
   MainUnit.TransferItem := MainUnit.Transferlist.Items[ItemIdx];
   If (MainUnit.TransferItem^.WriteOp) Then
   Begin
      If (MainUnit.TransferItem^.EndTime = 0) Then
      Begin
         Animate.FileName := (extractfilepath(application.ExeName)+'\RECEIVE1.AVI');
         Animate.Active  := True;
         Animate.Visible := True;
         Visible    := True;
         Type1Label.Caption     := 'Receiving:';
         TransTypeLabel.Caption := 'Estimated time left:';
      End Else
      Begin
         ProgressBar.Max := MainUnit.TransferItem^.Filesize;
         ProgressBar.Position := MainUnit.TransferItem^.Position;
         Animate.Active     := False;
         Animate.Visible    := False;
         TransDoneImage.Visible := True;
         TransDoneLabel.Visible := True;
         Type1Label.Caption     := 'Received:';
         TransTypeLabel.Caption := 'Received:';
         TimeLeftLabel.Caption := Mainunit.MainForm.BytesToAbbr(MainUnit.TransferItem^.Position) + ' in ' +
                                  ss2nn(Round(MainUnit.TransferItem^.EndTime - MainUnit.TransferItem^.StartTime) div 1000);
         RateLabel.Caption := Mainunit.MainForm.BytesToAbbr(GetAverageRate) + '/Sec';
      End;
      DestLabel.Caption := MainUnit.TransferItem^.Filename + ' from ' +
      MainUnit.TransferItem^.IP_Address + ' (port: ' + inttostr(MainUnit.TransferItem^.Port) + ')';
   End Else
   Begin
      If (MainUnit.TransferItem^.EndTime = 0) Then
      Begin
         Animate.FileName := (extractfilepath(application.ExeName)+'\SEND1.AVI');
         Animate.Active     := True;
         Animate.Visible    := True;
         TransTypeLabel.Caption := 'Sending:';
         Type1Label.Caption     := 'Estimated time left:';
      End else
      Begin
         ProgressBar.Max := MainUnit.TransferItem^.Filesize;
         ProgressBar.Position := MainUnit.TransferItem^.Position;
         Animate.Active     := False;
         Animate.Visible    := False;
         TransDoneImage.Visible := True;
         TransDoneLabel.Visible := True;
         TransTypeLabel.Caption := 'Sent:';
         Type1Label.Caption     := 'Sent:';
         TimeLeftLabel.Caption := Mainunit.MainForm.BytesToAbbr(MainUnit.TransferItem^.Position) + ' in ' +
                                  ss2nn(Round(MainUnit.TransferItem^.EndTime - MainUnit.TransferItem^.StartTime) div 1000);
         RateLabel.Caption := Mainunit.MainForm.BytesToAbbr(GetAverageRate) + '/Sec';
      End;
      DestLabel.Caption := MainUnit.TransferItem^.Filename + ' to ' +
      MainUnit.TransferItem^.IP_Address + ' (port: ' + inttostr(MainUnit.TransferItem^.Port) + ')';
   End;

End;



procedure TTransferWindowForm.FormShow(Sender: TObject);
begin
   with TResourceStream.Create(hInstance, 'RECEIVE_AVI', RT_RCDATA) do
   try
    SaveToFile(extractfilepath(application.ExeName)+'\RECEIVE1.AVI');
   finally
       Free;
   end;
   with TResourceStream.Create(hInstance, 'SEND_AVI', RT_RCDATA) do
   try
    SaveToFile(extractfilepath(application.ExeName)+'\SEND1.AVI');
   finally
       Free;
   end;
   Lastposition := 0;
   Temptime     := GetTickCount;
   UpdateDisplay;
   Timer.Enabled := True;
end;

Function  TTransferWindowForm.GetAverageRate : Longint;
Var
   nBytesReceived, nTimeElapsed, nBps : Longint;
Begin
   {Calculate the amount of seconds passed since the transfer started}
   nTimeElapsed := (MainUnit.TransferItem^.EndTime - MainUnit.TransferItem^.StartTime) div 1000;
   {Check for 0/Sec elapsed, setting default if so, to prevent division by zero}
   if nTimeElapsed <= 0 then nTimeElapsed := 1;
   {Calculate bytes per second}
   nBytesReceived := MainUnit.TransferItem^.Position;
   nBps := (nBytesReceived div nTimeElapsed);
   Result := nBps;
End;

Function  TTransferWindowForm.GetRate(Position : Longint; LastPosition : Longint) : Longint;
Var
   nBytesReceived, nTimeElapsed, nBps : Longint;
Begin
   {Calculate the amount of seconds passed since the transfer started}
   nTimeElapsed := (GetTickCount - TempTime) div 1000;
   {Check for 0/Sec elapsed, setting default if so, to prevent division by zero}
   if nTimeElapsed = 0 then nTimeElapsed := 1;
   {Calculate bytes per second}
   nBytesReceived := (Position - LastPosition);
   nBps := (nBytesReceived div nTimeElapsed);
   Result := nBps;
End;

function TTransferWindowForm.ss2nn(Seconds : Longint): String;
var
  nMin, nSec: Integer;
begin
  {Check for less than 1/Min}
  if Seconds < 60 then Result := '0 mins ' + IntToStr(Seconds) + ' secs'
  else begin
    {Determine minutes}
    nMin := Seconds div 60;
    {Determine seconds}
    nSec := Seconds - (nMin * 60);
    {Return Result}
    Result := IntToStr(nMin) + ' mins ' + IntToStr(nSec) + ' secs';
  end;
end;

procedure TTransferWindowForm.TimerTimer(Sender: TObject);
begin
   Timer.Interval := 1000;
   MainUnit.TransferItem := MainUnit.Transferlist.Items[ItemIdx];
   If (MainUnit.TransferItem^.EndTime = 0) Then
   Begin
      Rate := GetRate(MainUnit.TransferItem^.Position, LastPosition);
      LastPosition := MainUnit.TransferItem^.Position;
      If (MainUnit.TransferItem^.Filesize = 0) Then
      Begin
         TimeLeftLabel.Caption := Mainunit.MainForm.BytesToAbbr(MainUnit.TransferItem^.Position) + ' copied...';
         RateLabel.Caption := Mainunit.MainForm.BytesToAbbr(Rate) + '/Sec';
      End Else
      Begin
         ProgressBar.Max := MainUnit.TransferItem^.Filesize;
         ProgressBar.Position := MainUnit.TransferItem^.Position;
         If (MainUnit.TransferItem^.Filesize - MainUnit.TransferItem^.Position) > 0 Then
             TimeLeftLabel.Caption := ss2nn(Round((MainUnit.TransferItem^.Filesize - MainUnit.TransferItem^.Position) / 1024) div (Rate div 1024))
                                      + ' (' + Mainunit.MainForm.BytesToAbbr(MainUnit.TransferItem^.Position) + ' of ' +
                                      Mainunit.MainForm.BytesToAbbr(MainUnit.TransferItem^.Filesize) + ' copied)';
                                      RateLabel.Caption := Mainunit.MainForm.BytesToAbbr(Rate) + '/Sec';
      End;
   End Else
   Begin
      Timer.Enabled := False;
      UpdateDisplay;
      Exit;
   End;
   Temptime := GetTickCount;
end;

procedure TTransferWindowForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Animate.Active := False;
   Animate.FileName := '';
   DeleteFile(extractfilepath(application.ExeName)+'\RECEIVE1.AVI');
   DeleteFile(extractfilepath(application.ExeName)+'\SEND1.AVI');
end;

end.
