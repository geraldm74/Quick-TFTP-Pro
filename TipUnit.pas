unit TipUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles;

type
  TTipsForm = class(TForm)
    Image1: TImage;
    TipsCheck: TCheckBox;
    NextTipButton: TBitBtn;
    BitBtn2: TBitBtn;
    TipText: TStaticText;
    StaticText1: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure NextTipButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Procedure DisplayTip(idx : Integer);
    Procedure SaveIniFile;
  public
    { Public declarations }
  end;

Const
    Tips : Array[1..15] of String = (
    'Stopping a file from being available for download is quick and easy, simply right-click the file and select Un/Suspend.',

'You can stop QuickTFTP Desktop Pro from servicing TFTP clients by pressing the Stop button on the toolbar.',

'Quickly share files by dragging && dropping them on to the application and clicking on the Start button.',

'Newly uploaded files can be automatically added to the available files list by selecting ''Add new files to available files list.'' check box from the Accepting Files tab in the Configuration dialog box.',

'To overwrite existing files when devices upload new files simply select the ''Overwrite existing files.'' check box from the Accepting Files tab in the Configuration dialog box.',

'Quickly save the current contents of the activity log to disk by right-clicking on the activity log window and selecting ''Log Quick Save...''.',

'Save the current list of files available for download by clicking on the ''Save File List...'' button, then next time you run QuickTFTP Desktop Pro just load the files list up by clicking on the ''Open File List...'' button.',

'To have QuickTFTP Desktop Pro running as a tray icon, simply minimize the application. To get the QuickTFTP Desktop Pro window back, right-click the tray icon and select ''Display''.',

'Many functions can be run simply by pressing a button. Check out the Shortcut tab in the Help file for a list of shortcut keys.',

'Checking to make sure you have the lastest version of Quick TFTP Desktop Pro has never been easier. Simply click ''Check for updates...'' under the Help menu.',

'You can automatically start QuickTFTP Desktop Pro when you start windows. Simply tick ''Automatically start application on system startup'' on the General tab of the configuration dialog box.',

'When you start QuickTFTP Desktop Pro you can get it to automatically load the last saved files list by ticking the ''Load last saved files list on startup'' tick box on the General tab of the configuration dialog box.',

'You can get more detail about current file transfers but clicking the left mouse button on a transfer, or by right clicking and selecting ''Details''...',

'Dead connections taking too long to timeout? Specify a lower timeout value in the ''Configuration'' dialog box, also unselect ''Accept client TIMEOUT values''.',

'You can limit the ports which QuickTFTP Desktop Pro will receive incoming data connections on. Simply select the ''Firewall'' feature from the ''Configuration'' dialog box');




var
  TipsForm: TTipsForm;
  Tipidx  : Integer;

implementation

Uses MainUnit;

{$R *.dfm}

Procedure TTipsForm.DisplayTip(idx : Integer);
Begin
   TipText.Caption := Tips[idx];
//   TipText.Constraints.MinHeight := 81;
//   TipText.Constraints.MaxHeight := 81;
//   TipText.Constraints.MinWidth  := 321;
 //  TipText.Constraints.MaxWidth  := 321;
End;


procedure TTipsForm.FormShow(Sender: TObject);
begin
  If Not(MainUnit.Config.Tips) Then TipsCheck.Checked := False;
  Randomize;
  Tipidx := (Random(Length(Tips)) + 1);
  DisplayTip(Tipidx);
end;

procedure TTipsForm.NextTipButtonClick(Sender: TObject);
begin
   If (Tipidx = Length(tips)) Then Tipidx := 0;
   Inc(Tipidx);
   DisplayTip(Tipidx);
end;

Procedure TTipsForm.SaveIniFile;
Var
  inifile    : TIniFile;
Begin
   MainUnit.Config.Tips := TipsCheck.Checked;
   Try
     inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.INI'));
     try
       inifile.WriteBool('General','TipsOnStartUp', TipsCheck.Checked);
     Finally
        inifile.Free;
     End;
   Except
     On E: Exception Do { handle error }
   End;
End;

procedure TTipsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     SaveIniFile;
end;


end.
