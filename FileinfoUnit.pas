unit FileinfoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, LMDCustomComponent,
  LMDWndProcComponent, LMDCustomFormFill, LMDFormFill, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDEdit,
  LMDControl, LMDDrawEdge;

type
  TFileInfoForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    Label6: TLabel;
    SuspendImage: TImage;
    OkImage: TImage;
    NotfoundImage: TImage;
    StatusLabel: TLabel;
    Label9: TLabel;
    LMDFormFill1: TLMDFormFill;
    FilenameEdit: TLMDEdit;
    DirEdit: TLMDEdit;
    FilesizeEdit: TLMDEdit;
    AccessedEdit: TLMDEdit;
    ModifiedEdit: TLMDEdit;
    CountEdit: TLMDEdit;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure DisplayFileInfo;
  public
    { Public declarations }
  end;

var
  FileInfoForm: TFileInfoForm;
  Filename    : String;
  Dir         : String;
  Count       : String;
  Status      : Integer;

implementation

{$R *.dfm}

Uses MainUnit;


procedure TFileInfoForm.FormCreate(Sender: TObject);
begin
   Filename := MainForm.FilesView.Selected.Caption;
   Dir      := MainForm.FilesView.Selected.SubItems[0];
   Count    := MainForm.FilesView.Selected.SubItems[1];
   Status   := MainForm.FilesView.Selected.ImageIndex;
End;

procedure TFileInfoForm.DisplayFileInfo;
Var
  sr         : TSearchRec;
  LTime      : TFileTime;
  Systemtime : TSystemtime;
begin
   FilenameEdit.text := Filename;
   DirEdit.Text      := Dir;
   if FindFirst(Dir+'\'+Filename, faAnyFile, sr) = 0 Then
   Begin
      // Get file size
      FilesizeEdit.Text := MainForm.BytesToAbbr(sr.Size);
      // Get file last accessed time
      FileTimeToLocalFileTime(sr.FindData.ftLastAccessTime, LTime);
      FileTimeToSystemTime( LTime, SystemTime );
      AccessedEdit.Text := DateTimeToStr(SystemTimeToDateTime(SystemTime));
      // Get file last modified time
      FileTimeToLocalFileTime(sr.FindData.ftLastWriteTime, LTime);
      FileTimeToSystemTime( LTime, SystemTime );
      ModifiedEdit.Text := DateTimeToStr(SystemTimeToDateTime(SystemTime));
      Case Status of
          0 : Begin
                 NotFoundImage.Hide;
                 SuspendImage.Hide;
                 Okimage.Show;
                 StatusLabel.Caption := '(Normal)';
              End;
          4 : Begin
                 NotFoundImage.Hide;
                 SuspendImage.Show;
                 Okimage.Hide;
                 StatusLabel.Caption := '(Suspended)';
              End;
          5 : Begin
                 NotFoundImage.Show;
                 SuspendImage.Hide;
                 Okimage.Hide;
                 StatusLabel.Caption := '(File not found)';
              End;
      End;
   End Else
   Begin
      NotFoundImage.Show;
      SuspendImage.Hide;
      Okimage.Hide;
      StatusLabel.Caption := '(File not found)';
   End;
   Countedit.Text := Count;
End;

procedure TFileInfoForm.FormShow(Sender: TObject);
begin
   DisplayFileInfo;
end;

end.
