unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uDPLinkLabel, ExtCtrls, jpeg, shellapi, Buttons, IniFiles;

type
  TAboutForm = class(TForm)
    VersionLabel: TLabel;
    CopyRightLabel: TLabel;
    LicenceButton: TButton;
    CloseButton: TButton;
    DPLinkLabel2: TDPLinkLabel;
    Label6: TLabel;
    Image1: TImage;
    GroupBox2: TGroupBox;
    RegButton: TBitBtn;
    RegLabel1: TLabel;
    RegLabel3: TLabel;
    RegLabel4: TLabel;
    UnRegImage: TImage;
    Label1: TLabel;
    DPLinkLabel3: TDPLinkLabel;
    RegImage: TImage;
    GroupBox1: TGroupBox;
    RegLabel2: TLabel;
    procedure LicenceButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RegButtonClick(Sender: TObject);
  private
    procedure UpdateList;
    procedure SaveRegInfo;
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses MainUnit, RegUnit;

{$R *.dfm}
{$D-,L-,O+,Q-,R-,Y-,S-}

procedure TAboutForm.LicenceButtonClick(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar(ExtractFileDir(Application.ExeName)+'\Licence Agreement.chm'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.UpdateList;
Begin
   VersionLabel.Caption := 'Version ' + MainUnit.Version;
   If (Config.RegKey = '') then
   begin
      RegLabel1.Visible := True;
      RegLabel2.Visible  := True;
      RegLabel3.Visible := False;
      RegLabel4.Visible := False;
      RegImage.Visible   := False;
      UnRegImage.Visible := True;
      reglabel1.Font.Style := [fsBold];
      RegLabel1.Caption := 'Unregistered Version';
      If (DaysLeft > 0) then
                 RegLabel2.Caption := 'Trial days remaining: ' + inttostr(DaysLeft)
      Else RegLabel2.Caption := 'Trial Expired!';
   End Else
   Begin
      {$I include\aspr_crypt_begin2.inc}
      RegButton.Enabled := False;
      RegLabel1.Visible := True;
      RegLabel2.Visible  := False;
      RegLabel3.Visible := True;
      RegLabel4.Visible := True;
      reglabel1.Font.Style := [];
      RegLabel1.Caption := 'Registration Name:';
      RegLabel3.Caption := Config.RegName;
      RegLabel4.Caption := Config.RegKey;
      UnRegImage.Visible := False;
      RegImage.Visible   := True;
      {$I include\aspr_crypt_end2.inc}
   End;
End;


procedure TAboutForm.FormShow(Sender: TObject);
begin
   UpdateList;
end;

procedure TAboutForm.SaveRegInfo;
Var
  inifile    : TIniFile;
Begin
   inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     try
        inifile.WriteString('Registration','Name', Config.RegName);
        inifile.WriteString('Registration','Key', Config.RegKey);
     Finally
        inifile.Free;
     End;
End;

procedure TAboutForm.RegButtonClick(Sender: TObject);
begin
  If (RegForm = Nil) then RegForm := TRegForm.Create(Self);
  If (RegForm.ShowModal = mrOK) Then
  Begin
     SaveRegInfo;
     application.ProcessMessages;
     MainForm.Check;
     UpdateList;
  End;
  FreeandNil(RegForm);
end;

end.
