unit RegUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, aspr_api, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDFill;

type
  TRegForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    RegNameEdit: TEdit;
    Label3: TLabel;
    RegEdit: TEdit;
    RegButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LMDFill1: TLMDFill;
    procedure RegButtonClick(Sender: TObject);
    procedure RegEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RegNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RegNameEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RegEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
     {}
  public
    { Public declarations }
  end;

var
  RegForm: TRegForm;

implementation

{$R *.dfm}

uses MainUnit;

procedure TRegForm.RegButtonClick(Sender: TObject);
begin
 If CheckKeyAndDecrypt( PChar(RegEdit.Text), PChar(RegNameEdit.Text), False ) then
   Begin
      MessageDlg('Registration Key Valid!'+#13+#13+'Congratulations, you have successfully registered the version of QuickTFTP Desktop Pro.', mtInformation, [mbOk], 0);
      Config.RegName := RegNameEdit.Text;
      Config.RegKey  := RegEdit.Text;
      ModalResult := MrOK;
      PostMessage(self.handle, WM_CLOSE, 0, 0);
   end Else MessageDlg('Invalid Registration Key!'+#13+#13+'Make sure you have typed the Regsitration Name and Registration Key exactly'+#13+'as it appears in the email sent to you.', mtWarning, [mbOk], 0);
end;

procedure TRegForm.RegEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (Length(RegEdit.Text) = 36) and (Length(RegNameEdit.Text) > 0) Then
       RegButton.Enabled := True
   Else RegButton.Enabled := False;
end;

procedure TRegForm.RegNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (Length(RegEdit.Text) = 36) and (Length(RegNameEdit.Text) > 0) Then
       RegButton.Enabled := True
   Else RegButton.Enabled := False;
end;

procedure TRegForm.RegNameEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (Length(RegEdit.Text) = 36) and (Length(RegNameEdit.Text) > 0) Then
       RegButton.Enabled := True
   Else RegButton.Enabled := False;
end;

procedure TRegForm.RegEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (Length(RegEdit.Text) = 36) and (Length(RegNameEdit.Text) > 0) Then
       RegButton.Enabled := True
   Else RegButton.Enabled := False;
end;

end.
