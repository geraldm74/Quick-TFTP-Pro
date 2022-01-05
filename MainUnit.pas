{$J+}
unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ProgressCyl, ToolWin, ComCtrls, Menus, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPServer, IdTrivialFTPServer, StdCtrls, ImgList, ShellAPI,
  ShellCtrls, XPMan, DateUtils, IniFiles, IdSocketHandle, ExtCtrls,
  LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint, LMDShapeHint,
  LMDWndProcComponent, LMDTrayIcon, Registry, XPMenu, Math,
  AdvToolBtn, AdvToolBar, AdvMenus, AdvListV, FolderDialog, LMDBrowseDlg, aspr_api;

type
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    TFTP: TIdTrivialFTPServer;
    FilesView: TListView;
    ImageList1: TImageList;
    FilesViewPopup: TPopupMenu;
    OpenDialog: TOpenDialog;
    ActivityView: TListView;
    RemoveFilesPopup: TMenuItem;
    Splitter1: TSplitter;
    LMDShapeHint1: TLMDShapeHint;
    SuspendFiles1: TMenuItem;
    ClearAccessCount1: TMenuItem;
    AddFiles1: TMenuItem;
    ActivityLogPopup: TPopupMenu;
    ClearLog1: TMenuItem;
    QuickSave1: TMenuItem;
    SaveDialog: TSaveDialog;
    TrayIcon: TLMDTrayIcon;
    TrayIconPopup: TPopupMenu;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    LogQuickSave1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Fileinformation1: TMenuItem;
    RefreshDeviceList1: TMenuItem;
    TipsTimer: TTimer;
    AutoRefreshTimer: TTimer;
    MainMenu1: TAdvMainMenu;
    Session1: TMenuItem;
    Setup1: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    OpenFileList1: TMenuItem;
    SaveFileList1: TMenuItem;
    N1: TMenuItem;
    StartTFTP1: TMenuItem;
    StopTFTP1: TMenuItem;
    N2: TMenuItem;
    Exit2: TMenuItem;
    Configuration1: TMenuItem;
    Hidetoolbar1: TMenuItem;
    Hidestatusbar1: TMenuItem;
    HideActivitylog1: TMenuItem;
    N3: TMenuItem;
    ClearActivityLog1: TMenuItem;
    RefreshFilesList1: TMenuItem;
    CheckForUpdates1: TMenuItem;
    ipOfTheDay1: TMenuItem;
    Website1: TMenuItem;
    N4: TMenuItem;
    Help2: TMenuItem;
    LicenseInformation1: TMenuItem;
    N5: TMenuItem;
    About1: TMenuItem;
    AdvMenuStyler1: TAdvMenuStyler;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvToolBarButton7: TAdvToolBarButton;
    AdvToolBarButton8: TAdvToolBarButton;
    AdvToolBarSeparator3: TAdvToolBarSeparator;
    AdvToolBarButton9: TAdvToolBarButton;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    AdvToolBarButton10: TAdvToolBarButton;
    AdvToolBarSeparator5: TAdvToolBarSeparator;
    AdvToolBarButton11: TAdvToolBarButton;
    AdvToolBarButton12: TAdvToolBarButton;
    Splitter2: TSplitter;
    ProgressListView: TListView;
    TransferPopup: TPopupMenu;
    Details1: TMenuItem;
    HideTransLog1: TMenuItem;
    AdvToolBarButton13: TAdvToolBarButton;
    AdvToolBarSeparator6: TAdvToolBarSeparator;
    BrowseFolderDialog: TLMDBrowseDlg;
    procedure Close1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RemoveFilesPopupClick(Sender: TObject);
    procedure Configuration2Click(Sender: TObject);
    procedure TFTPReadFile(Sender: TObject; var FileName: String;
      const PeerInfo: TPeerInfo; var GrantAccess: Boolean;
      var AStream: TStream; var FreeStreamOnComplete: Boolean);
    procedure TFTPTransferComplete(Sender: TObject; const Success: Boolean;
      const PeerInfo: TPeerInfo; AStream: TStream;
      const WriteOperation: Boolean);
    procedure LicenceInfo1Click(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure StartTFTP1Click(Sender: TObject);
    procedure StopTFTP1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TFTPWriteFile(Sender: TObject; var FileName: String;
      const PeerInfo: TPeerInfo; var GrantAccess: Boolean;
      var AStream: TStream; var FreeStreamOnComplete: Boolean);
    procedure ActivityViewResize(Sender: TObject);
    procedure FilesViewResize(Sender: TObject);
    procedure SuspendFiles1Click(Sender: TObject);
    procedure AddFiles1Click(Sender: TObject);
    procedure ClearAccessCount1Click(Sender: TObject);
    procedure LoadFileList1Click(Sender: TObject);
    procedure SaveFileList1Click(Sender: TObject);
    procedure ClearLog1Click(Sender: TObject);
    procedure AppMinimizeEvent(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure QuickSave1Click(Sender: TObject);
    procedure LogQuickSave1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure ipoftheday1Click(Sender: TObject);
    procedure Website1Click(Sender: TObject);
    procedure Hidetoolbar1Click(Sender: TObject);
    procedure HideStatusbar1Click(Sender: TObject);
    procedure HideActivitylog1Click(Sender: TObject);
    procedure ClearActivitylog1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FilesViewPopupPopup(Sender: TObject);
    procedure ActivityLogPopupPopup(Sender: TObject);
    procedure Fileinformation1Click(Sender: TObject);
    procedure RefreshDeviceList1Click(Sender: TObject);
    procedure RefreshDeviceList2Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure FilesViewDblClick(Sender: TObject);
    procedure FilesViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TipsTimerTimer(Sender: TObject);
    procedure AutoRefreshTimerTimer(Sender: TObject);
    procedure Checkforupdates1Click(Sender: TObject);
    procedure ProgressListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure OpenFileList1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure Configuration1Click(Sender: TObject);
    procedure RefreshFilesList1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure LicenseInformation1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure AdvToolBarButton1Click(Sender: TObject);
    procedure AdvToolBarButton2Click(Sender: TObject);
    procedure AdvToolBarButton3Click(Sender: TObject);
    procedure AdvToolBarButton4Click(Sender: TObject);
    procedure AdvToolBarButton5Click(Sender: TObject);
    procedure AdvToolBarButton6Click(Sender: TObject);
    procedure AdvToolBarButton7Click(Sender: TObject);
    procedure AdvToolBarButton8Click(Sender: TObject);
    procedure AdvToolBarButton9Click(Sender: TObject);
    procedure AdvToolBarButton10Click(Sender: TObject);
    procedure AdvToolBarButton11Click(Sender: TObject);
    procedure AdvToolBarButton12Click(Sender: TObject);
    procedure TFTPSizeRequest(Sender: TObject; const FileName: String;
      const PeerInfo: TPeerInfo; var size: int64;
      const WriteOperation: Boolean);
    procedure TransferPopupPopup(Sender: TObject);
    procedure ProgressListViewDblClick(Sender: TObject);
    procedure Details1Click(Sender: TObject);
    procedure ProgressListViewClick(Sender: TObject);
    procedure HideTransLog1Click(Sender: TObject);
    procedure AdvToolBarButton13Click(Sender: TObject);
  private
     function  GetHugeFileSize(afilename : String) : int64;
     procedure LoadIniFile;
     procedure UpDateTFTPSettings;
     Procedure AddBindings;
     Procedure UpdateStatusBar(status : string);
     procedure UpdateAccessCount(Item : TListItem);
     Procedure WriteActivityLog(imageindex : Integer; a,b,c,status : String);
     Procedure WriteLastActivityLog(imageindex : Integer; a,b,c,status : String);
     procedure SaveToLog(Item: TListItem);
     procedure IncFileNum(Var LogFilename : String; Var CurrentfileNum : Integer);
     procedure AppendToLog(LogFilename: String; Item: TListItem);
     Procedure AppendLineFileView(Line : String);
     procedure CheckAutoRefresh;
     function  QuickSave(LogFilename : String) : Boolean;
     Function  Padnumber(TheNumber,paddingbits: Integer) : String;
     Function  GetFileNum(var filename : String) : Integer;
     Function  FileSizeOk(fname : String) : Boolean;
     Function  GetDateFilename : String;
     Function  SaveFilesView(FileName : String) : Boolean;
     Function  LoadFilesView(FileName : String) : Boolean;
     Function  SecurityCheck(remoteip : String; sectype : Integer) : Boolean;
     Function  CheckSecurityMatchSubnet(Ip, Net, Mask : String) : Boolean;
     procedure TipsOnStartUp;
     Procedure LoadSecurityItems;
     Procedure LoadFilesList(Filename : String);
     procedure CheckStartupParam;
     Function  CheckIfOverright(i : Integer) : Boolean;
     Procedure AddTransfer(const PeerInfo: TPeerInfo; Filename : String; Size : Longint; Writeop : Boolean; Starttime : DWord);
     Procedure DelTransfer(const PeerInfo: TPeerInfo);
     Procedure DelTransferbyName(Const IPAddr : String; Const Port : Integer; Const FName : String = '');
     Function  FindTransfer(const PeerInfo: TPeerInfo) : Integer;
     Function  FindTransferinList(const Index : Integer) : Integer;
     Procedure AddEndTransfer(const PeerInfo : TPeerInfo; const Ended : DWord);
     procedure CleanupTransferWindow(PeerInfo : TPeerInfo; Success : Boolean);
     Function  RemoveTrailingSlash(Const s : String) : String;
     Function  FileInList(const FileName : String) : Boolean;
     Function  FileInDestDir(const FileName : String) : Boolean;
     procedure LoadTransferDetailWindow;
  public
     procedure WMDROPFILES(var Msg: TMessage);
     procedure LBWindowProc(var Message: TMessage);
     function BytesToAbbr(const NumBytes: Int64;
               const Format: string = '0.##'): string;
     Procedure Check;
     Procedure UpdateFileProgress(Filename : String; RemoteIP : TPeerInfo; FTransType : Integer; Size, Position : Int64);
  end;

  {*************************************************************}
  {***************** Progress FileStream Start *****************}
  {*************************************************************}

  TNotifyEvent = Procedure(Filename : String; RemoteIP : TPeerInfo; FTransType : Integer; Size, Position : Int64) of Object;

  TProgressFileStream = class(TFileStream)
  private
    // Private declarations
    FNotifyEvent : TNotifyEvent;
    FFIleName    : String;
    FRemoteIP    : TPeerInfo;
    FTransType   : Integer;
  protected
    // Protected declarations
  public
    constructor Create(FileName: string;
                       RemoteIP : TPeerInfo;
                       TransType : Integer;
                       Mode: Word;
                       NotifyEvent : TNotifyEvent); overload;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
  published
    // Published declarations
  end;

  {*************************************************************}
  {****************** Progress FileStream End ******************}
  {*************************************************************}

  TConfig = Record
               AcceptIncoming : Boolean;
               AddNew         : Boolean;
               LogActivity    : Boolean;
               LogSizeLimit   : Boolean;
               LogOptions     : Boolean;
               Overwrite      : Boolean;
               Tips           : Boolean;
               Autostart      : Boolean;
               SecurityOn     : Boolean;
               LoadOnStartup  : Boolean;
               RefreshAfterLoad : Boolean;
               RemoveDead     : Boolean;
               AutoRefresh    : Boolean;
               MinOnStartup   : Boolean;
               RMTransfer     : Boolean;
               TSize          : Boolean;
               ClientTimeOut  : Boolean;
               EnableFirewall : Boolean;
               AutoRefreshInterval : Integer;
               LogSize        : Integer;
               IPPort         : Integer;
               MaxPort        : Integer;
               MinPort        : Integer;
               LogFormat      : Integer;
               BufferSize     : Integer;
               Timeout        : Integer;
               MaxDLConn      : Integer;
               MaxULConn      : Integer;
               BindIps        : String;
               DestDir        : String;
               LogDir         : String;
               LastSaved      : String;
               RegName        : String;
               RegKey         : String;
  End;
  SecurityRec = Record
                  Net_Address  : String[15];
                  Mask_Address : String[15];
                  // IP Security Type: 1 = Single IP, 2 = Subnet
                  IPType       : Integer;
                  // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
                  SecurityType : Integer;
  End;
  PSecurityItem = ^SecurityRec;

  TransferRec = Record
                   IP_Address : String[15];
                   Port       : Integer;
                   Filename   : String[100];
                   Filesize   : Int64;
                   Position   : Int64;
                   WriteOp    : Boolean;
                   StartTime  : DWord;
                   EndTime    : DWord;
  End;
  PTransferRec = ^TransferRec;


var
  MainForm       : TMainForm;
  OldLBWindowProc: TWndMethod;
  DLConns        : Integer;
  ULConns        : Integer;
  Config         : TConfig;
  timeup         : Boolean;
  Stopping       : Boolean;
  FP             : Boolean;
  Version        : String = '3.8';
  DaysLeft       : Integer;
  SecurityList   : TList;
  SecurityItem   : PSecurityItem;
  Unlimited      : Boolean;   // Registered = Unlimited connections upto config.maxconn
  // Used to store information on current file transfers
  Transferlist   : TList;
  TransferItem   : PTransferRec;

  Const
  sizelimitlog   = 'qtftp0';
  savefileext    = '.qtf';
  PaddingSize    = 5;
  UserKey        : PChar  = nil;
  UserName       : PChar  = nil;
  ModeName       : PChar  = nil;
  TrialDaysTotal : DWORD  = DWORD(-1);
  TrialDaysLeft  : DWORD  = DWORD(-1);




implementation

uses ConfigUnit, AboutUnit, md5, TipUnit, FileinfoUnit, TransferWindowUnit;

{$R *.dfm}

{*************************************************************}
{***************** Progress FileStream Start *****************}
{*************************************************************}

constructor TProgressFileStream.Create(FileName: string;
                       RemoteIP : TPeerInfo;
                       TransType : Integer;
                       Mode: Word;
                       NotifyEvent : TNotifyEvent);
begin
  inherited Create(FileName, Mode);
  FNotifyEvent := NotifyEvent;
  FFileName := FileName;
  FRemoteIP := RemoteIP;
  FTransType := TransType;
end;

function TProgressFileStream.Read(var Buffer; Count: Longint): Longint;
begin
  result := inherited Read(Buffer, Count);
  if Assigned(FNotifyEvent) then  FNotifyEvent(FFileName, FRemoteIP, FTransType, Size, Position);
end;

function TProgressFileStream.Write(const Buffer; Count: Longint): Longint;
begin
  result := inherited Write(Buffer, Count);
  if Assigned(FNotifyEvent) then FNotifyEvent(FFileName, FRemoteIP, FTransType, Size, Position);
end;




{*************************************************************}
{****************** Progress FileStream End ******************}
{*************************************************************}

procedure TMainForm.WMDROPFILES(var Msg: TMessage);
var
  pcFileName                 : PChar;
  b, i, iSize, iFileCount    : integer;
  item, FindItem             : TListItem;
  Found                      : Boolean;
begin
  pcFileName := ''; // to avoid compiler warning message
  iFileCount := DragQueryFile(Msg.WParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
  begin
    iSize := DragQueryFile(Msg.wParam, 0, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    DragQueryFile(Msg.WParam, i, pcFileName, iSize);
    if FileExists(pcFileName) then
    Begin
       If (filesview.Items.Count > 0) then
       Begin
          Found := False;
          For b := 0 to (filesview.Items.Count - 1) do
          Begin
             FindItem := filesview.Items.Item[b];
             If (FindItem.SubItems.Strings[0] + '\' +
                  FindItem.Caption) = pcFileName then
                    Found := True;
             Application.ProcessMessages;
          End;
          If Not(Found) Then
          Begin
             Item := FilesView.Items.Add;
             Item.Caption := Extractfilename(pcFileName);
             Item.SubItems.Append(RemoveTrailingSlash(ExtractFileDir(pcFileName)));
             Item.SubItems.Append('0');
             Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(pcFileName)));
             FilesView.Update;
          End;
       End Else
       Begin
          Item := FilesView.Items.Add;
          Item.Caption := Extractfilename(pcFileName);
          Item.SubItems.Append(RemoveTrailingSlash(ExtractFileDir(pcFileName)));
          Item.SubItems.Append('0');
          Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(pcFileName)));
          FilesView.Update;
       End;
    End;
    StrDispose(pcFileName);
  end;
  DragFinish(Msg.WParam);
end;
















procedure TMainForm.LBWindowProc(var Message: TMessage);
begin
  if Message.Msg = WM_DROPFILES then
    WMDROPFILES(Message); // handle WM_DROPFILES message
  OldLBWindowProc(Message);  // call default ListBox1 WindowProc method to handle all other messages
end;






Procedure TMainForm.UpdateFileProgress(Filename : String; RemoteIP : TPeerInfo; FTransType : Integer; Size, Position : Int64);
Var
   EntryFound         : Boolean;
   i,a                : Integer;
   ProgressItem       : TListItem;
   Pos1               : Integer;
   TempTransferItem   : PTransferRec;
Begin
    i          := -1;
    EntryFound := False;
   //Transtype:
   //    0 = File Read
   //    1 = File Write
   If (FTransType = 0) Then
   Begin
      If (ProgressListView.Items.Count > 0) Then
      Begin
         Repeat
            Inc(i);
            If (ProgressListView.Items.Item[i].SubItems[0] = Filename) and
               (ProgressListView.Items.Item[i].SubItems[1] = RemoteIP.PeerIP) and
               (ProgressListView.Items.Item[i].SubItems[2] = Inttostr(RemoteIP.PeerPort)) Then EntryFound := True;
         Until (EntryFound) or (i = (ProgressListView.Items.Count - 1));
      End;
      If Not(EntryFound) Then
      Begin
//         EntryFound := False;
         ProgressItem := ProgressListView.Items.Add;
         ProgressItem.ImageIndex := 7;
         ProgressItem.Caption := 'Download';
         ProgressItem.SubItems.Append(FileName);
         ProgressItem.SubItems.Append(RemoteIP.PeerIP);
         ProgressItem.SubItems.Append(Inttostr(RemoteIP.PeerPort));
         ProgressItem.SubItems.Append('Starting Transfer...');
      End Else // Entry Found !!!!
      Begin
         Pos1 := (Position * 100) div size;
         ProgressListView.Items.Item[i].SubItems[3] := Inttostr(Pos1)+'% Complete...';
         If (FindTransfer(RemoteIP) > -1) Then
         Begin
            TempTransferItem := TransferList.Items[FindTransfer(RemoteIP)];
            TempTransferItem^.Filesize := size;
            TempTransferItem^.Position := Position;
         End;
      End;
   End;
   If (FTransType = 1) Then
   Begin
      If (ProgressListView.Items.Count > 0) Then
      Begin
         Repeat
            Inc(i);
            If (ProgressListView.Items.Item[i].SubItems[0] = Filename) and
               (ProgressListView.Items.Item[i].SubItems[1] = RemoteIP.PeerIP) Then EntryFound := True;
         Until (EntryFound) or (i = (ProgressListView.Items.Count - 1));
      End;
      If Not(EntryFound) Then
      Begin
         ProgressItem := ProgressListView.Items.Add;
         ProgressItem.ImageIndex := 6;
         ProgressItem.Caption := 'Upload';
         ProgressItem.SubItems.Append(FileName);
         ProgressItem.SubItems.Append(RemoteIP.PeerIP);
         ProgressItem.SubItems.Append(Inttostr(RemoteIP.PeerPort));
         ProgressItem.SubItems.Append('Starting Transfer...');
      End Else // Entry Found !!!!
      Begin
         If (TransferList.Count > 0) Then
         Begin
            a := FindTransfer(RemoteIP);
            If (a >= 0) Then
            Begin
               TransferItem := TransferList.Items[a];
               If (TransferItem^.Filesize > 0) Then
               Begin
                  Size := TransferItem^.Filesize;
                  Pos1 := (Position * 100) div Size;
                  ProgressListView.Items.Item[i].SubItems[3] := Inttostr(Pos1)+'% Complete...';
                  TransferItem := TransferList.Items[FindTransfer(RemoteIP)];
                  TransferItem^.Position := Position;
               End Else
               Begin
                  ProgressListView.Items.Item[i].SubItems[3] := BytesToAbbr(Position)+' Received...';
                  TempTransferItem := TransferList.Items[FindTransfer(RemoteIP)];
                  TempTransferItem^.Position := Position;
               End;
            End;
         End;
      End;
   End;
End;

procedure TMainForm.FormCreate(Sender: TObject);
begin
   DLConns := 0;
   ULConns := 0;
   FP   := False;
   OldLBWindowProc := FilesView.WindowProc; // store defualt WindowProc
   FilesView.WindowProc := LBWindowProc; // replace default WindowProc
   DragAcceptFiles(FilesView.Handle, True); // now ListBox1 accept dropped files

   Application.OnMinimize := AppMinimizeEvent;
   StatusBar1.Panels[0].Text := 'Stopped.';
   StatusBar1.Panels[1].Text := 'Connection count: ' +Inttostr(DLConns+ULConns);
   LoadIniFile;
   UpDateTFTPSettings;
   LoadSecurityItems;
   If (Config.LoadOnStartup) and (Config.LastSaved <> '') Then
   Begin
      LoadFilesList(Config.LastSaved);
      If (Config.RefreshAfterLoad) Then AdvToolBarButton7Click(Sender);
      If (Config.Autostart) Then AdvToolBarButton3Click(Sender);
   End;
   CheckAutoRefresh;
   CheckStartupParam;
   ProgressListView.DoubleBuffered := True;
   Transferlist := TList.Create;
end;

procedure TMainForm.CheckStartupParam;
Begin
   If ParamCount = 0 then exit;
   If (ParamStr(1) = '-cm') and (Config.MinOnStartup = True) then TrayIcon.Active := True;
End;

procedure TMainForm.CheckAutoRefresh;
Begin
   If (Config.AutoRefresh) Then
   Begin
      AutoRefreshTimer.Interval := (Config.AutoRefreshInterval * 60000); // ms to minutes
      AutoRefreshTimer.Enabled := True;
   End Else AutoRefreshTimer.Enabled := False;
End;

procedure TMainForm.AutoRefreshTimerTimer(Sender: TObject);
begin
   AdvToolBarButton7Click(Sender);
end;

procedure TMainForm.AppMinimizeEvent(Sender: TObject);
Begin
    TrayIcon.Active := True;
End;






























Procedure TMainForm.Check;
Begin
   If CheckKeyAndDecrypt( PChar(Config.RegKey), PChar(Config.RegName), False ) then
   Begin
      {$I include\aspr_crypt_begin1.inc}
      Statusbar1.Panels[2].Text := 'Registered version.';
      Unlimited := True;
      {$I include\aspr_crypt_end1.inc}
   end Else Begin
      Config.RegKey  := '';
      Config.RegName := '';
      If GetTrialDays( 0, TrialDaysTotal, TrialDaysLeft ) then
      begin
         DaysLeft := TrialDaysLeft;
         Statusbar1.Panels[2].Text := 'Unregistered version: '+inttostr(TrialDaysLeft) + ' days left.';
         If TrialDaysLeft = 0 then
         Begin
            Statusbar1.Panels[2].Text := 'Unregistered version: Trial Expired.';
            If (AboutForm = Nil) then AboutForm := TAboutForm.Create(Self);
            AboutForm.Position := poScreenCenter;
            AboutForm.ShowModal;
            FreeandNil(AboutForm);
            If Not(CheckKeyAndDecrypt( PChar(Config.RegKey), PChar(Config.RegName), False )) then Close
            else Check;
         End;
      End else
      Begin
         If TrialDaysLeft = 0 then
         Begin
            Statusbar1.Panels[2].Text := 'Unregistered version: Trial Expired.';
            If (AboutForm = Nil) then AboutForm := TAboutForm.Create(Self);
            AboutForm.Position := poScreenCenter;
            AboutForm.ShowModal;
            FreeandNil(AboutForm);
            If Not(CheckKeyAndDecrypt( PChar(Config.RegKey), PChar(Config.RegName), False )) then Close
            else Check;
         End;
      End;
   End;
End;





















Procedure TMainForm.WriteActivityLog(imageindex : Integer; a,b,c,status : String);
Var
  ActivityItem : TListItem;
Begin
   ActivityItem := ActivityView.Items.Add;
   ActivityItem.ImageIndex := imageindex;
   ActivityItem.SubItems.Append(a);
   ActivityItem.SubItems.Append(b);
   ActivityItem.SubItems.Append(c);
   ActivityItem.SubItems.Append(status);
End;

Procedure TMainForm.WriteLastActivityLog(imageindex : Integer; a,b,c,status : String);
Begin
   Activityview.Items.Item[activityview.Items.Count-1].ImageIndex := ImageIndex;
   Activityview.Items.Item[activityview.Items.Count-1].SubItems[0] := a;
   Activityview.Items.Item[activityview.Items.Count-1].SubItems[1] := b;
   Activityview.Items.Item[activityview.Items.Count-1].SubItems[2] := c;
   Activityview.Items.Item[activityview.Items.Count-1].SubItems[3] := status;
End;

Procedure TMainForm.UpdateStatusBar(status : string);
Begin
     StatusBar1.Panels[0].Text := status;
     StatusBar1.Panels[1].Text := 'Connection count: ' +Inttostr(DLConns+ULConns);
End;

procedure TMainForm.UpDateTFTPSettings;
Begin
   TFTP.DefaultPort := Config.IPPort;
   TFTP.BufferSize := Config.BufferSize;
   TFTP.ReceiveTimeout := Config.Timeout;
   If (Config.ClientTimeOut) Then TFTP.AcceptTimeOut := True
   Else TFTP.AcceptTimeOut := False;
End;

Procedure TMainForm.LoadIniFile;
Var
  inifile   : TIniFile;
Begin
     inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     Try
        Config.Tips             := inifile.ReadBool('General','TipsOnStartUp', True);
        Config.IPPort           := inifile.ReadInteger('TFTP Settings','Port', 69);
        Config.BufferSize       := inifile.ReadInteger('TFTP Settings','BufferSize', 8192);
        Config.Timeout          := inifile.ReadInteger('TFTP Settings','Timeout', 3);
        Config.Autostart        := inifile.ReadBool('TFTP Settings','AutoStartTFTP', False);
        Config.SecurityOn       := inifile.ReadBool('TFTP Settings','SecurityOn', false);
        Config.LoadOnStartup    := inifile.ReadBool('TFTP Settings','LoadOnStartup', False);
        Config.RefreshAfterLoad := inifile.ReadBool('TFTP Settings','RefreshAfterLoad', True);
        Config.RemoveDead       := inifile.ReadBool('TFTP Settings','RemoveDead', False);
        Config.AutoRefresh      := inifile.ReadBool('TFTP Settings','AutoRefresh', False);
        Config.AutoRefreshInterval := inifile.ReadInteger('TFTP Settings','AutoRefreshInterval', 1);
        Config.MinOnStartup     := inifile.ReadBool('TFTP Settings','MinOnStartup', False);
        Config.MaxDLConn        := inifile.ReadInteger('TFTP Settings','MaxDLConn', 1);
        Config.MaxULConn        := inifile.ReadInteger('TFTP Settings','MaxULConn', 1);
        Config.RMTransfer       := True {nifile.ReadBool('TFTP Settings','RMTransfer', True)};
        Config.TSize            := inifile.ReadBool('TFTP Settings','TSize', True);
        Config.ClientTimeOut    := inifile.ReadBool('TFTP Settings','ClientTimeout', True);
        Config.BindIps          := inifile.ReadString('IP Settings','Bind', 'All');
        Config.AcceptIncoming   := inifile.ReadBool('FileAccepting','Accept', False);
        Config.AddNew           := inifile.ReadBool('FileAccepting','AddNew', False);
        Config.Overwrite        := inifile.ReadBool('FileAccepting','Overwrite', False);
        Config.DestDir          := inifile.Readstring('FileAccepting','DestDir', '');
        Config.LogActivity      := inifile.ReadBool('Logging','Log', False);
        Config.LogFormat        := inifile.ReadInteger('Logging','LogFormat', 0);
        Config.LogOptions       := inifile.ReadBool('Logging','LogLimitOptions', False);
        Config.LogSizeLimit     := inifile.ReadBool('Logging','LogLimit', True);
        Config.LogSize          := inifile.ReadInteger('Logging','LogSize', 100);
        Config.LogDir           := inifile.Readstring('Logging','LogFolder', ExtractFileDir(Application.ExeName));
        Config.LastSaved        := inifile.ReadString('Lasted Saved','File', '');
        Config.RegName          := inifile.ReadString('Registration','Name', '');
        Config.RegKey           := inifile.ReadString('Registration','Key', '');
        Config.EnableFirewall   := inifile.ReadBool('Firewall','Enable', False);
        Config.MinPort          := inifile.ReadInteger('Firewall','MinPort', 1024);
        Config.MaxPort          := inifile.ReadInteger('Firewall','MaxPort', 65535);
     Finally
        inifile.Free;
     End;
End;

procedure TMainForm.Close1Click(Sender: TObject);
begin
   Close;
end;


Function TMainForm.GetHugeFileSize(afilename : String) : int64;
var 
  FileHandle: hFile;
begin
  FileHandle := FileOpen(aFileName, fmOpenRead or fmShareDenyNone);
  try
    LARGE_INTEGER(Result).LowPart := GetFileSize
      (FileHandle, @LARGE_INTEGER(Result).HighPart);
    if LARGE_INTEGER(Result).LowPart = $FFFFFFFF then
      Win32Check(GetLastError = NO_ERROR);
  finally
    FileClose(FileHandle);
  end; 
End;

function TMainForm.BytesToAbbr(const NumBytes: Int64;
  const Format: string = '0.##'): string;
const
  KiloByte = Int64(1024);
  MegaByte = KiloByte * 1024; 
  GigaByte = MegaByte * 1024; 
  TeraByte = GigaByte * 1024; 
var 
  Value: Double;
  Suffix: string; 
begin 
  Value := 0.0; //This gets rid of compiler warning 

  //We need this check first since Case doesn't work with 
  //integer values > 32 bits (as of D5); 
  if NumBytes >= GigaByte then begin
    if NumBytes < TeraByte then begin 
      Suffix := ' GB'; 
      Value := NumBytes / GigaByte;
    end
    else begin 
      Suffix := ' TB'; 
      Value := NumBytes / TeraByte; 
    end; 
  end 
  else  //NumBytes is less than 1 GB 
    case NumBytes of 
      0..KiloByte-1:  begin 
        Suffix := ' bytes';
        Value := NumBytes 
      end; 

      KiloByte..MegaByte-1: begin 
        Suffix := ' KB'; 
        Value := NumBytes / KiloByte; 
      end; 

      MegaByte..GigaByte-1: begin 
        Suffix := ' MB'; 
        Value := NumBytes / MegaByte;
      end;
    end;

  Result := FormatFloat(Format, Value) + Suffix;
end;


Procedure TMainForm.RemoveFilesPopupClick(Sender: TObject);
begin
   AdvToolBarButton6Click(Sender);
end;

Procedure TMainForm.AddBindings;
Var
   BindHandle       : TIdSocketHandle;
   Prevpos, Nextpos : integer;
Begin
     TFTP.Bindings.Clear;
     BindHandle := TFTP.Bindings.add;
     If (Config.EnableFirewall) Then
     Begin
        BindHandle.ClientPortMin := Config.MinPort;
        BindHandle.ClientPortMax := Config.MaxPort;
        BindHandle.Port := 0;
     End Else
     Begin
       BindHandle.ClientPortMin := 0;
       BindHandle.ClientPortMin := 0;
     End;
     If (Config.BindIps = 'All') then
     Begin
        BindHandle.IP := '0.0.0.0';
        BindHandle.Port := Config.IPPort;
     End Else
     If (Pos(';',Config.BindIps) = 0) then
     Begin
        BindHandle.IP := Config.BindIps;
        BindHandle.Port := Config.IPPort;
     End Else
     Begin
         prevpos := POS(';',config.BindIps);
         BindHandle.IP := Copy(Config.BindIps,1,(prevpos - 1));
         BindHandle.Port := Config.IPPort;
         Config.BindIps[prevpos] := ' ';
         nextpos := POS(';',config.BindIps);
         While (nextpos <> 0) Do
         Begin
            BindHandle := TFTP.Bindings.add;
            BindHandle.IP := Copy(Config.BindIps,(prevpos + 1),(nextpos - 1));
            BindHandle.Port := Config.IPPort;
            prevpos := nextpos;
            Config.BindIps[prevpos] := ' ';
            nextpos := POS(';',config.BindIps);
            Application.ProcessMessages;
            If (Config.EnableFirewall) Then
            Begin
               BindHandle.ClientPortMin := Config.MinPort;
               BindHandle.ClientPortMax := Config.MaxPort;
               BindHandle.Port := 0;
            End Else
            Begin
               BindHandle.ClientPortMin := 0;
               BindHandle.ClientPortMin := 0;
            End;
         End;
         If (nextpos = 0) Then
         Begin
            BindHandle := TFTP.Bindings.add;
            BindHandle.IP := Copy(Config.BindIps,(prevpos + 1), length(Config.BindIps));
            BindHandle.Port := Config.IPPort;
            If (Config.EnableFirewall) Then
            Begin
               BindHandle.ClientPortMin := Config.MinPort;
               BindHandle.ClientPortMax := Config.MaxPort;
               BindHandle.Port := 0;
            End Else
            Begin
               BindHandle.ClientPortMin := 0;
               BindHandle.ClientPortMin := 0;
            End;
         End;
     End;
End;

procedure TMainForm.Configuration2Click(Sender: TObject);
begin
   AdvToolBarButton10Click(Sender);
end;

procedure TMainForm.TFTPReadFile(Sender: TObject; var FileName: String;
  const PeerInfo: TPeerInfo; var GrantAccess: Boolean;
  var AStream: TStream; var FreeStreamOnComplete: Boolean);
Var
  Fexists : Boolean;
  i       : Integer;
  TheFile : String;
begin
  i := -1;
  Fexists := False;
  Inc(DLConns);
  If Not(Unlimited) And (DLconns > 1) Then
  Begin
     WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Send error: Max connections reached!');
     GrantAccess := False;
     exit;
  End;
  If (Unlimited) And (Config.MaxDLConn <> 0) Then
      If (Unlimited) And (DLConns > Config.MaxDLConn) Then
      Begin
         WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Send error: Max connections reached!');
         GrantAccess := False;
         exit;
      End;
  Try
     If FilesView.Items.Count > 0 then
     Repeat
        Inc(i);
        If AnsiUpperCase(FilesView.Items.Item[i].Caption) = AnsiUpperCase(FileName) then
           Fexists := True;
        Application.ProcessMessages;
     Until (i >= (FilesView.Items.Count - 1)) or (Fexists = True);
     If ((Fexists = True) and (SecurityCheck(PeerInfo.PeerIP,1))) and
        Fileexists(FilesView.Items.Item[i].SubItems.Strings[0]+'\'+FileName) and
        (FilesView.Items.Item[i].ImageIndex = 0) Then
     Begin
        UpdateStatusBar('Started.');
        TheFile := FilesView.Items.Item[i].SubItems.Strings[0]+'\'+FileName;
        WriteActivityLog(1,Datetimetostr(Now),TheFile,PeerInfo.PeerIP,'Transfer: Sending file...');
        //AStream := TFileStream.Create(TheFile,fmOpenRead + fmShareDenyWrite);
        AStream := TProgressFileStream.Create(TheFile,PeerInfo,0,(fmOpenRead+fmShareDenyNone),UpdateFileProgress);
        FreeStreamOnComplete := True;
        GrantAccess := True;
     End Else
     Begin
        If (SecurityCheck(PeerInfo.PeerIP,1)) and (FilesView.Items.Item[i].ImageIndex = 0) Then
        Begin
           WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Send error: File does not exist!');
           If (Fexists = True) and Not(Fileexists(FilesView.Items.Item[i].SubItems.Strings[0]+
                 '\'+FileName)) Then
           Begin
              Filesview.Items.Delete(i);
              FilesView.Update;
           End;
           GrantAccess := False;
        End;
        // Security Type: 1 = Read, 2 = Write
        If Not(SecurityCheck(PeerInfo.PeerIP,1)) Then
        Begin
           WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Send error: Unauthorised!');
           GrantAccess := False;
        End Else
        If Not(FilesView.Items.Item[i].ImageIndex = 0) Then
        Begin
           WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Send error: File Suspended!');
           GrantAccess := False;
        End;
     End;
  Except
       On E: Exception Do
       Begin
           Dec(DLConns);
           UpdateStatusBar('Started.');
           TheFile := FileName;
           WriteLastActivityLog(3,Datetimetostr(Now),TheFile,PeerInfo.PeerIP,'Send error: Unknown error!');
           GrantAccess := False;
       End;
  End;
end;

procedure TMainForm.UpdateAccessCount(Item : TListItem);
Var
  i       : Integer;
  Count   : Integer;
  Fexists : Boolean;
Begin
     i := -1;
     Fexists := False;
     If FilesView.Items.Count > 0 then
     Repeat
        Inc(i);
        If AnsiUpperCase(FilesView.Items.Item[i].Caption) = AnsiUpperCase(ExtractFilename(Item.SubItems.Strings[1])) then
           Fexists := True;
        Application.ProcessMessages;
     Until (i >= (FilesView.Items.Count - 1)) or (Fexists = True);
     If Not(Fexists) then exit;
     Count := strtoint(FilesView.Items.Item[i].SubItems.Strings[1]);
     Inc(Count);
     FilesView.Items.Item[i].SubItems.Strings[1] := inttostr(Count);
End;

Function TMainForm.CheckIfOverright(i : Integer) : Boolean;
Var
  a : Integer;
  AlreadyExists : Boolean;
Begin
     AlreadyExists := false;
     If (FilesView.Items.Count < 1) Then
     Begin
         Result := False;
         Exit;
     End;
     a := -1;
     Repeat
        Inc(a);
        If uppercase(FilesView.Items.Item[a].SubItems[0]+'\'+FilesView.Items.Item[a].Caption) = uppercase(ActivityView.Items.Item[i].SubItems.strings[1]) Then AlreadyExists := True;
     Until (i >= (FilesView.Items.Count - 1)) or (AlreadyExists = True);
     Result := AlreadyExists;
End;

procedure TMainForm.CleanupTransferWindow(PeerInfo : TPeerInfo; Success : Boolean);
Var
  i     : Integer;
  Found : Boolean;
Begin
   If (Progresslistview.items.Count = 0) Then Exit;
   i := -1;
   Found := False;
   Repeat
      Inc(i);
      If (Progresslistview.Items.Item[i].SubItems[1] = Peerinfo.PeerIP) and
         (Progresslistview.Items.Item[i].SubItems[2] = Inttostr(Peerinfo.PeerPort)) Then Found := True;
   Until (Found) or (i = Progresslistview.items.Count - 1);
   If Not(Found) Then
   Begin
      DelTransfer(PeerInfo);
      Exit;
   End;
   Progresslistview.Items.Item[i].SubItems[3] := 'Finished';
   If (Config.RMTransfer) Then
   Begin
      If (TransferWindowForm <> Nil) Then AddEndTransfer(PeerInfo, GetTickCount)
      Else DelTransfer(PeerInfo);
      Progresslistview.Items.Delete(i);
   End Else AddEndTransfer(PeerInfo, GetTickCount);
End;

procedure TMainForm.TFTPTransferComplete(Sender: TObject;
  const Success: Boolean; const PeerInfo: TPeerInfo; AStream: TStream;
  const WriteOperation: Boolean);
Var
  i,a          : Integer;
  Found        : Boolean;
  FExists      : Boolean;
  Item         : TListItem;
begin
     If (WriteOperation) Then Dec(ULConns)
     Else Dec(DLConns);
     UpdateStatusBar('Started.');
     If (DLConns <= 0) and (ULConns <= 0) and (Stopping) Then StatusBar1.Panels[0].Text := 'Stopped.';
     i := -1;
     FExists := False;
     If (AStream <> Nil) Then AStream.Free;
     Repeat
        Inc(i);
        Application.ProcessMessages;
        If (ActivityView.Items.Item[i].SubItems.strings[2] = PeerInfo.PeerIP) Then
           If (ActivityView.Items.Item[i].SubItems.strings[3] = 'Transfer: Sending file...') or
              (ActivityView.Items.Item[i].SubItems.strings[3] = 'Transfer: Receiving file...') Then
                 Fexists := True;
     Until (i >= (ActivityView.Items.Count - 1)) or (Fexists = True);
     If (Fexists = True) Then
     Begin
        If (Success) Then
        Begin
           ActivityView.Items.Item[i].ImageIndex := 2;
           If (ActivityView.Items.Item[i].SubItems.strings[3] = 'Transfer: Sending file...') Then
           Begin
               ActivityView.Items.Item[i].SubItems.strings[3] := 'Transfer: Send file complete.';
               UpdateAccessCount(ActivityView.Items.Item[i]);
           End
           Else Begin
              ActivityView.Items.Item[i].SubItems.strings[3] := 'Transfer: Receive file complete.';










































              If (Config.AddNew) and (Config.Overwrite) and Not(CheckIfOverright(i)) and Not(FileInList(Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]))) Then
              Begin
                 Item := FilesView.Items.Add;
                 Item.ImageIndex := 0;
                 Item.Caption := Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]);
                 Item.SubItems.Append(ExtractFileDir(ActivityView.Items.Item[i].SubItems.Strings[1]));
                 Item.SubItems.Append('0');
                 Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(ActivityView.Items.Item[i].SubItems.Strings[1])));
                 FilesView.Update;
              End Else
              If (Config.AddNew) Then // and (Config.Overwrite) and (FileInList(Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]))) Then
              Begin
                  Found := False;
                  a := - 1;
                  Repeat
                      Inc(a);
                      If (FilesView.Items.Count > 0) Then
                        If uppercase((Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]))) = uppercase(FilesView.Items.Item[a].Caption) Then
                           Found := True;
                  Until (Found) or (a >= (FilesView.Items.Count - 1));
                  If (Found) Then
                  Begin
                     Item := FilesView.Items.Item[a];
                     Item.ImageIndex := 0;
                     Item.Caption := Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]);
                     Item.SubItems[0] := ExtractFileDir(ActivityView.Items.Item[i].SubItems.Strings[1]);
                     Item.SubItems[1] := '0';
                     Item.SubItems[2] := BytesToAbbr(GetHugeFileSize(ActivityView.Items.Item[i].SubItems.Strings[1]));
                     FilesView.Update;
                  End Else
                  Begin
                     Item := FilesView.Items.Add;
                     Item.ImageIndex := 0;
                     Item.Caption := Extractfilename(ActivityView.Items.Item[i].SubItems.Strings[1]);
                     Item.SubItems.Append(ExtractFileDir(ActivityView.Items.Item[i].SubItems.Strings[1]));
                     Item.SubItems.Append('0');
                     Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(ActivityView.Items.Item[i].SubItems.Strings[1])));
                     FilesView.Update;
                  End;
              End;

           End;
        End Else
        Begin
           ActivityView.Items.Item[i].ImageIndex := 3;
           ActivityView.Items.Item[i].SubItems.strings[3] := 'Error transfering!';
        End;
        If (Config.LogActivity) Then SaveToLog(ActivityView.Items.Item[i]);
     End;
     CleanupTransferWindow(PeerInfo, Success);
end;

procedure TMainForm.LicenceInfo1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar(ExtractFileDir(Application.ExeName)+'\Licence Agreement.chm'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.About2Click(Sender: TObject);
begin
   AdvToolBarButton11Click(Sender);
end;

procedure TMainForm.StartTFTP1Click(Sender: TObject);
begin
   AdvToolBarButton3Click(Sender);
end;

procedure TMainForm.StopTFTP1Click(Sender: TObject);
begin
   AdvToolBarButton4Click(Sender);
end;

procedure TMainForm.TipsOnStartUp;
Begin
   If Not(Config.Tips) Then Exit;
   ipoftheday1Click(self);
End;

procedure TMainForm.FormShow(Sender: TObject);
begin
   Check;
   Caption := 'QuickTFTP Desktop Pro   v' + version;
   If (Config.Tips) Then TipsTimer.Enabled := True;
end;

procedure TMainForm.TipsTimerTimer(Sender: TObject);
begin
   TipsTimer.Enabled := False;
   TipsOnStartUp;
end;

Function TMainForm.FileInList(const FileName : String) : Boolean;
Var
  i     : Integer;
  Found : Boolean;
Begin
   Result := False;
   Found  := False;
   i := -1;
   If (FilesView.Items.Count > 0) Then
   Repeat
      Inc(i);
      If (uppercase(FilesView.Items.Item[i].Caption) = uppercase(filename)) Then Found := True;
   Until (i = FilesView.Items.Count - 1) or (Found);
   If (Found) Then
   Begin
       Result := True;
       Exit;
   End;
   If (Config.AcceptIncoming) Then
      If Fileexists(Config.DestDir + '\' + Filename) Then Result := True;
End;

Function TMainForm.FileInDestDir(const FileName : String) : Boolean;
Begin
   Result := False;
   If (Config.AcceptIncoming) Then
      If Fileexists(Config.DestDir + '\' + Filename) Then Result := True;
End;



procedure TMainForm.TFTPWriteFile(Sender: TObject; var FileName: String;
  const PeerInfo: TPeerInfo; var GrantAccess: Boolean;
  var AStream: TStream; var FreeStreamOnComplete: Boolean);
Begin
   Inc(ULConns);
   // Security Type: 1 = Read, 2 = Write
   If Not(Unlimited) And (ULConns > 1) Then
   Begin
      WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: Max connections reached!');
      GrantAccess := False;
      exit;
   End;
   If (Unlimited) And (Config.MaxDLConn <> 0) Then
       If (Unlimited) And (ULConns > Config.MaxULConn) Then
       Begin
          WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: Max connections reached!');
          GrantAccess := False;
          exit;
       End;
   If Not(Config.AcceptIncoming) or Not(SecurityCheck(PeerInfo.PeerIP,2)) Then
   Begin
       GrantAccess := False;
       WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: Unauthorised!');
       Exit;
   End;

   If (Config.AcceptIncoming) Then
   Begin
       If (FileInList(FileName)) and Not(Config.Overwrite) Then
       Begin
          GrantAccess := False;
          WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: File Already Exists!');
          Exit;
      End;
      If (FileInDestDir(FileName)) and Not(Config.Overwrite) Then
       Begin
          GrantAccess := False;
          WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: File Already Exists!');
          Exit;
      End;
   End;

   If Not(DirectoryExists(Config.DestDir)) Then
   Begin
       If Not(CreateDir(Config.DestDir)) Then
       Begin
          GrantAccess := False;
          WriteActivityLog(3,Datetimetostr(Now),FileName,PeerInfo.PeerIP,'Receive error: Upload folder not found!');
          Exit;
       End;
   End;
   UpdateStatusBar('Started.');
   WriteActivityLog(1,Datetimetostr(Now),Config.DestDir+'\'+FileName,PeerInfo.PeerIP,'Transfer: Receiving file...');
   //AStream := TFileStream.Create(Config.DestDir+'\'+FileName,fmCreate);
   AStream := TProgressFileStream.Create(Config.DestDir+'\'+FileName,PeerInfo,1,fmCreate,UpdateFileProgress);
   FreeStreamOnComplete := True;
   GrantAccess := True;
end;

procedure TMainForm.ActivityViewResize(Sender: TObject);
begin
    ActivityView.Update;
    ActivityView.Refresh;
end;

procedure TMainForm.FilesViewResize(Sender: TObject);
begin
   FilesView.Update;
   FilesView.Refresh;
end;

procedure TMainForm.SuspendFiles1Click(Sender: TObject);
Var
  i : Integer;
begin
   i := 0;
   Filesview.SetFocus;
   If (Filesview.SelCount = 1) then
   Begin
      If Filesview.Items.Item[Filesview.Selected.Index].ImageIndex = 4 Then
         Filesview.Items.Item[Filesview.Selected.Index].ImageIndex := 0
      Else Filesview.Items.Item[Filesview.Selected.Index].ImageIndex := 4;
      Filesview.Items.Item[Filesview.Selected.Index].Selected := False;
      FilesView.Update;
   End;
   If (Filesview.SelCount > 1) then
   Repeat
      If (Filesview.Items.Item[i].Selected = True) Then
      Begin
         If Filesview.Items.Item[i].ImageIndex = 4 Then
            Filesview.Items.Item[i].ImageIndex := 0
         Else Filesview.Items.Item[i].ImageIndex := 4;
         Filesview.Items.Item[i].Selected := False;
      End;
      inc(i);
      Application.ProcessMessages;
   Until (i = Filesview.Items.Count);
   FilesView.Update;
end;

procedure TMainForm.AddFiles1Click(Sender: TObject);
begin
   AdvToolBarButton5Click(Sender);
end;

procedure TMainForm.ClearAccessCount1Click(Sender: TObject);
Var
  i : Integer;
begin
   i := 0;
   Filesview.SetFocus;
   If (Filesview.SelCount = 1) then
   Begin
      Filesview.Items.Item[Filesview.Selected.Index].SubItems.Strings[1] := '0';
      FilesView.Update;
      Exit;
   End;
   If (Filesview.SelCount > 1) then
   Repeat
      If (Filesview.Items.Item[i].Selected = True) Then
      Begin
        Filesview.Items.Item[i].SubItems.Strings[1] := '0';
        Filesview.Items.Item[i].Selected := False;
      End;
      inc(i);
      If (i >= Filesview.Items.Count) Then i := 0;
      Application.ProcessMessages;
   Until (Filesview.SelCount = 0);
   FilesView.Update;
end;

Procedure TMainForm.AppendLineFileView(Line : String);
Var
  fname, fpath, accessed : String;
  a,b                    : Integer;
  Item                   : TListItem;
Begin
   a := Pos('|',Line);
   Line[a] := ' ';
   b := Pos('|',line);
   fname := copy(line,1,(a-1));
   fpath := copy(line,(a+1),(b-a-1));
   accessed := Copy(line,(b+1),length(line));
   Item := FilesView.Items.Add;
   Item.Caption := fname;
   Item.SubItems.Append(fpath);
   Item.SubItems.Append(accessed);
   Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(fpath+'\'+fname)));
End;

Function TMainForm.LoadFilesView(FileName : String) : Boolean;
Var
   F : TextFile;
   line : String;
Begin
   If Not(FileExists(FileName)) Then
   Begin
      Result := False;
      Exit;
   End;
   {$I-}
   Try
      AssignFile(F, FileName);
      Reset(F);
      FilesView.Clear;
      While Not(EOF(F)) Do
      Begin
         Readln(F,Line);
         AppendLineFileView(Line);
         Application.ProcessMessages;
      End;
      CloseFile(F);
      Result := True;
   Except
      On E: Exception do Result := False;
   End;
   {$I+}
End;

Procedure TMainForm.LoadFilesList(Filename : String);
Begin
  If Not(LoadFilesView(FileName)) Then
     WriteActivityLog(3,Datetimetostr(Now),' ',' ','Application: Error loading files list!')
  Else WriteActivityLog(2,Datetimetostr(Now),' ',' ','Application: Loaded files list.')
End;

procedure TMainForm.LoadFileList1Click(Sender: TObject);
begin
   AdvToolBarButton1Click(Sender);
end;

Function TMainForm.SaveFilesView(FileName : String) : Boolean;
Var
   inifile   : TIniFile;
   F         : TextFile;
   i         : Integer;
Begin
   {$I-}
   Try
      AssignFile(F, FileName);
      Rewrite(F);
      For i := 0 to (FilesView.Items.Count -1) do
      Begin
         Writeln(F,
         FilesView.Items.Item[i].Caption+'|'+
         FilesView.Items.Item[i].SubItems[0]+'|'+
         FilesView.Items.Item[i].SubItems[1]);
         Application.ProcessMessages;
      End;
      CloseFile(F);
      Config.LastSaved := FileName;
      If FileExists(ChangeFileExt(Application.ExeName, '.INI')) Then
      Begin
         inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.INI'));
         Try
           inifile.WriteString('Lasted Saved','File', Config.LastSaved);
         Finally
           inifile.Free;
         End;
      End;
      Result := True;
   Except
      On E: Exception do Result := False;
   End;
   {$I+}
End;

procedure TMainForm.SaveFileList1Click(Sender: TObject);
begin
   AdvToolBarButton2Click(Sender);
end;

procedure TMainForm.ClearLog1Click(Sender: TObject);
begin
   AdvToolBarButton9Click(Sender);
end;

Function TMainForm.Padnumber(TheNumber,paddingbits: Integer) : String;
Var
  diff,b : Integer;
  pad    : String;
Begin
  pad := '';
  Try
    diff := paddingbits - length(inttostr(TheNumber));
    If diff > 0 Then
    Begin
       For b := 1 to diff do
       Begin
          pad := pad + '0';
       End;
       pad := pad + inttostr(TheNumber);
    End
    Else If Diff = 0 Then pad := inttostr(TheNumber);
  Result := pad;
  Except
     On E: Exception do
     Begin
         Result := '';
         Exit;
     End;
  End;
End;

Function TMainForm.GetFileNum(var filename : String) : Integer;
Var
  sr       : TSearchRec;
  str      : String;
  i        : Integer;
Begin
   i := 0;
   filename := '';
   If Not(Fileexists(Config.LogDir + '\' + sizelimitlog +padnumber(1,paddingsize)+'.log')) and
      (Config.LogFormat = 0) Then
   Begin
      Result := 1;
      FileName := sizelimitlog+padnumber(1,paddingsize)+'.log';
      Exit;
   End Else
   If Not(Fileexists(Config.LogDir + '\' + sizelimitlog +padnumber(1,paddingsize)+'.csv')) and
      (Config.LogFormat = 1) Then
   Begin
      Result := 1;
      FileName := sizelimitlog+padnumber(1,paddingsize)+'.csv';
      Exit;
   End;
   If (Config.LogFormat = 0) Then str := sizelimitlog+'*.log' Else
   If (Config.LogFormat = 1) Then str := sizelimitlog+'*.csv';
   If FindFirst(Config.LogDir+'\'+str, faAnyFile, sr) = 0 then
   begin
      repeat
        Inc(i);
        filename := extractfilename(sr.Name);
      until FindNext(sr) <> 0;
      FindClose(sr);
   End;
   Result := i;
End;

Function TMainForm.FileSizeOk(fname : String) : Boolean;
Var
  a : longint;
Begin
  Result := False;
  a := GetHugefilesize(Config.LogDir + '\' + fname);
  If a < (Config.LogSize * 1024) then Result := True;
End;

procedure TMainForm.IncFileNum(Var LogFilename : String; Var CurrentfileNum : Integer);
Begin
   Inc(CurrentFileNum);
   If (Config.LogFormat = 0) Then
       LogFilename := sizelimitlog +padnumber(CurrentFileNum,paddingsize)+'.log'
   Else If (Config.LogFormat = 1) Then
       LogFilename := sizelimitlog +padnumber(CurrentFileNum,paddingsize)+'.csv';
End;

procedure TMainForm.AppendToLog(LogFilename: String; Item: TListItem);
Var
  F            : textfile;
  a            : Integer;
Begin
   {$I-}
   Try
     Assignfile(F,Config.LogDir+'\'+LogFilename);
     If FileExists(Config.LogDir+'\'+LogFilename) Then Append(F)
     Else Rewrite(F);
     If (filesize(F) < 1) and (Config.LogFormat = 1) Then
     Begin
        For a := 1 to (ActivityView.Columns.Count -2) do
        Begin
           Write(F,ActivityView.Columns.Items[a].Caption+',');
           Application.ProcessMessages;
        End;
        Writeln(F,ActivityView.Columns.Items[ActivityView.Columns.Count -1].Caption);
     End;
     If (Config.LogFormat = 0) Then
     Begin
        For a := 0 to (Item.SubItems.Count - 2) do
          Write(F, Item.SubItems.Strings[a]+'    ');
        Writeln(F, Item.SubItems.Strings[Item.SubItems.Count - 1]);
     End
     Else Begin
     If (Config.LogFormat = 1) Then
        For a := 0 to (Item.SubItems.Count - 2) do
          Write(F, Item.SubItems.Strings[a]+',');
        Writeln(F, Item.SubItems.Strings[Item.SubItems.Count - 1]);
     End;
     CloseFile(F);
   Except
     On E: Exception do
     Begin
        WriteActivityLog(3,Datetimetostr(Now),' ',' ','Log error: Cannot write to log!');
        Exit;
     End;
   End;
   {$I+}
End;

Function TMainForm.GetDateFilename : String;
Const
   Logprefex = 'qtftp';
Var
   Year,
   Month,
   Day     : Word;
   Fname   : String;
Begin
   DecodeDate(Date,Year, Month, Day);
   Year := (Year - 2000);
   Fname := logprefex + padNumber(year,2)
                      + padNumber(month,2)
                      + padnumber(day,2);
   If (Config.LogFormat = 0) Then
       Fname := Fname + '.log'
   Else if (Config.LogFormat = 1) Then
       Fname := Fname + '.csv';
   Result := Fname;
End;

procedure TMainForm.SaveToLog(Item: TListItem);
Var
  CurrentfileNum : Integer;
  LogFileName    : String;
Begin
   CurrentFileNum := 0;
   If Not(DirectoryExists(Config.LogDir)) Then
      If Not(CreateDir(Config.LogDir)) Then
      Begin
         WriteActivityLog(3,Datetimetostr(Now),' ',' ','Log error: Log directory error');
         Exit;
      End;
   If (Config.LogOptions) and (Config.LogSizeLimit) Then
   Begin
      CurrentfileNum := GetFileNum(LogFilename);
      If Not(FileSizeOk(LogFilename)) then IncFileNum(LogFilename,CurrentfileNum);
      AppendToLog(LogFilename,Item);
   End Else
   If (Config.LogOptions) and Not(Config.LogSizeLimit) Then
   Begin
      LogFilename := GetDateFilename;
      AppendToLog(LogFilename,Item);
   End Else
   If Not(Config.LogOptions) Then
   Begin
      If (Config.LogFormat = 0) Then
        AppendToLog('qtftplog.log',Item)
      Else if (Config.LogFormat = 1) Then
        AppendToLog('qtftplog.csv',Item);
   End;
End;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
   AdvToolBarButton12Click(Sender);
end;

Function TMainForm.QuickSave(LogFilename : String) : Boolean;
Var
  F            : textfile;
  a,i          : Integer;
  item         : TListItem;
Begin
   {$I-}
   Result := True;
   Try
     Assignfile(F,LogFilename);
     Rewrite(F);
     If (filesize(F) < 1) and (ExtractFileExt(LogFilename) = '.csv') Then
     Begin
        For a := 1 to (ActivityView.Columns.Count -2) do
        Begin
           Write(F,ActivityView.Columns.Items[a].Caption+',');
           Application.ProcessMessages;
        End;
        Writeln(F,ActivityView.Columns.Items[ActivityView.Columns.Count -1].Caption);
     End;
     For i := 0 to (Activityview.Items.Count -1) Do
     Begin
        Item := Activityview.Items.Item[i];
        If (ExtractFileExt(LogFilename) = '.log') Then
        Begin
           For a := 0 to (Item.SubItems.Count - 2) do
           Begin
              Write(F, Item.SubItems.Strings[a]+'    ');
              Application.ProcessMessages;
           End;
           Writeln(F, Item.SubItems.Strings[Item.SubItems.Count - 1]);
        End
        Else Begin
        If (ExtractFileExt(LogFilename) = '.csv') Then
           For a := 0 to (Item.SubItems.Count - 2) do
           Begin
              Write(F, Item.SubItems.Strings[a]+',');
              Application.ProcessMessages;
           End;
           Writeln(F, Item.SubItems.Strings[Item.SubItems.Count - 1]);
        End;
     End;
     CloseFile(F);
   Except
      On E: Exception do
      Begin
         Result := False;
         Exit;
      End;
   End;
   {$I+}
   If (IOResult <> 0) Then Result := False;
End;

procedure TMainForm.QuickSave1Click(Sender: TObject);
Var
  ok : Boolean;
begin
  ok := True;
  If (Activityview.Items.Count < 1) Then Exit;
  SaveDialog.FileName := '';
  SaveDialog.Options := [ofPathMustExist, ofFileMustExist, OfEnableSizing];
  SaveDialog.Filter := 'Log file (*.log)|*.log|Comma delimited file (*.csv)|*.csv';
  SaveDialog.InitialDir := ExtractFileDir(Application.ExeName);
  If Not(SaveDialog.Execute) Then Exit;
  If ExtractFileExt(SaveDialog.FileName) = '' Then
     SaveDialog.FileName := SaveDialog.FileName + '.log';
  If Not(QuickSave(SaveDialog.FileName)) Then ok := False;
  If OK then WriteActivityLog(2,Datetimetostr(Now),' ',' ','Application: Saved activity log.')
  Else WriteActivityLog(3,Datetimetostr(Now),' ',' ','Application: Quick save failed!');
end;

procedure TMainForm.LogQuickSave1Click(Sender: TObject);
begin
   QuickSave1Click(Sender);
end;

procedure TMainForm.Help1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar(ExtractFileDir(Application.ExeName)+'\Help.chm'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.ipoftheday1Click(Sender: TObject);
begin
   If (TipsForm = Nil) then TipsForm := TTipsForm.Create(MainForm);
   TipsForm.ShowModal;
   FreeandNil(TipsForm);
end;

procedure TMainForm.Website1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar('http://www.gjsolutions.co.uk/'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.Hidetoolbar1Click(Sender: TObject);
begin
   If Hidetoolbar1.Checked Then AdvToolBar1.Show
   Else AdvToolBar1.Hide;
end;

procedure TMainForm.HideStatusbar1Click(Sender: TObject);
Var
  ActivityViewVisable : Boolean;
  ProgressViewVisable : Boolean;
begin
   ActivityViewVisable := ActivityView.Visible;
   ProgressViewVisable := ProgressListView.Visible;
   If Hidestatusbar1.Checked Then
   Begin
      ActivityView.Hide;
      ProgressListView.Hide;
      Splitter1.Hide;
      Splitter2.Hide;
      StatusBar1.Show;
      If (ProgressViewVisable) Then
      Begin
         Splitter1.Show;
         ProgressListView.Show;
         If (ActivityViewVisable) Then Splitter2.Show;
      End;
      If (ActivityViewVisable) Then ActivityView.Show;
   End Else StatusBar1.Hide;
end;

procedure TMainForm.HideActivitylog1Click(Sender: TObject);
Var
  ProgressViewVisable : Boolean;
begin
   ProgressViewVisable := ProgressListView.Visible;
   If HideActivityLog1.Checked Then
   Begin
      MainForm.VertScrollBar.Visible := False;
      ActivityView.Hide;
      ProgressListView.Hide;
      Splitter1.Hide;
      Splitter2.Hide;
      Splitter1.Align := AlNone;
      Splitter2.Align := AlNone;
      ProgressListView.Align := AlNone;
      ActivityView.Align := AlNone;
      ActivityView.Show;
      ActivityView.Align := AlBottom;
      If (ProgressViewVisable) Then
      Begin
         Splitter2.Show;
         Splitter2.Align := AlBottom;
         ProgressListView.Show;
         ProgressListView.Align := AlBottom;
         Splitter1.Show;
         Splitter1.Align := AlBottom;
      End Else
      Begin
         Splitter1.Show;
         Splitter1.Align := AlBottom;
      End;
      MainForm.VertScrollBar.Visible := True;
   End Else
   Begin
       ActivityView.Hide;
       If (Splitter2.Visible) Then Splitter2.Hide;
       If Not(ProgressViewVisable) Then Splitter1.Hide;
   End;
end;

procedure TMainForm.HideTransLog1Click(Sender: TObject);
begin
   If HideTransLog1.Checked Then
   Begin
      MainForm.VertScrollBar.Visible := False;
      Splitter1.Hide;
      Splitter2.Hide;
      ProgressListView.Align := alNone;
      Splitter1.Align := alNone;
      Splitter2.Align := alBottom;
      If (ActivityView.Visible) Then Splitter2.Show;
      ProgressListView.Show;
      ProgressListView.Align := AlBottom;
      Splitter1.Show;
      Splitter1.Align := Albottom;
      MainForm.VertScrollBar.Visible := True;
   End Else Begin
       ProgressListView.Hide;
       Splitter2.Hide;
       If Not(ActivityView.Visible) Then Splitter1.Hide;
   End;
end;


procedure TMainForm.ClearActivitylog1Click(Sender: TObject);
begin
   AdvToolBarButton9Click(Sender);
end;

Procedure TMainForm.LoadSecurityItems;
Var
  SecFile: TFileStream;
Begin
   If Not(FileExists(ChangeFileExt(Application.ExeName,'.SEC'))) Then Exit;
   SecurityList := TList.Create;
   SecFile := TFileStream.Create(ChangeFileExt(Application.ExeName,'.SEC'),fmOpenRead);
   SecFile.Position := 0;
   Try
     While (SecFile.Position < Secfile.Size) Do
     Begin
       New(SecurityItem);
       SecFile.Read(SecurityItem^, Sizeof(SecurityRec));
       SecurityList.Add(SecurityItem);
     End;
   Finally
     SecFile.Free;
   End;
End;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   If (TFTP.Active) Then TFTP.Active := False;
   If Assigned(SecurityList) Then
   Begin
      Try
        SecurityList.Clear;
      Finally
        SecurityList.Free;
      End;
   End;
   Transferlist.Free;
end;

Function TMainForm.SecurityCheck(remoteip : String; sectype : Integer) : Boolean;
Var
   a                               : Integer;
   match                           : Boolean;
Begin
   Result := False;
   If Not(Config.SecurityOn) Then
   Begin
      Result := True;
      Exit;
   End;
   If (SecurityList.Count = 0) Then Exit;
   a := 0;
   Match := False;
   While (a < SecurityList.Count) and Not(Match) Do
   Begin
      SecurityItem := SecurityList.Items[a];
      // IP Security Type: 1 = Single IP, 2 = Subnet
      If SecurityItem^.IPType = 1 Then
      Begin
          If (RemoteIP = SecurityItem^.Net_Address) Then Match := True;
      End Else
      If (CheckSecurityMatchSubnet(remoteip, SecurityItem^.Net_Address, SecurityItem^.Mask_Address)) Then
         Match := True;
      Inc(a);
   End;
   if (a = SecurityList.Count) and Not(Match) Then Exit;
   If (Match) Then
   Begin
      // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
      If (secType = 1) and ((SecurityItem^.SecurityType = 1) or (SecurityItem^.SecurityType = 4)) Then
            Result := True;
      If (secType = 2) and ((SecurityItem^.SecurityType = 2) or (SecurityItem^.SecurityType = 4)) Then
            Result := True;
   End;
End;

Function TMainForm.CheckSecurityMatchSubnet(Ip, Net, Mask : String) : Boolean;
Var
   Netoct1, Netoct2, Netoct3, Netoct4,
   Maskoct1, Maskoct2, Maskoct3, Maskoct4,
   IPoct1, IPoct2, IPoct3, IPoct4  : Integer;
   a,b         : Integer;
   tmpstr      : String;
   octsused    : Integer;
   StartSubnet : Extended;
   MaxSubnets  : Extended;
   c           : Extended;
begin
   Result := False;
   StartSubnet := 0;
   MaxSubnets := 0;
   // Get IP Address
   tmpstr := Ip;
   a := pos('.',tmpstr);
   IPOct1 := strtoint(copy(tmpstr,1,(a-1)));
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   IPOct2 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   a := b;
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   IPOct3 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   tmpstr[b] := ',';
   IPOct4 := strtoint(copy(tmpstr,b+1,length(tmpstr)));
   // Get NETWORK Address
   tmpstr := Net;
   a := pos('.',tmpstr);
   NetOct1 := strtoint(copy(tmpstr,1,(a-1)));
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   NetOct2 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   a := b;
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   NetOct3 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   tmpstr[b] := ',';
   NetOct4 := strtoint(copy(tmpstr,b+1,length(tmpstr)));
   // Get MASK Address
   tmpstr := Mask;
   a := pos('.',tmpstr);
   MaskOct1 := strtoint(copy(tmpstr,1,(a-1)));
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   MaskOct2 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   a := b;
   tmpstr[a] := ',';
   b := pos('.',tmpstr);
   MaskOct3 := strtoint(copy(tmpstr,a+1,(b-a-1)));
   tmpstr[b] := ',';
   MaskOct4 := strtoint(copy(tmpstr,b+1,length(tmpstr)));
   //Octs used
   If (MaskOct1 <> 255) Then octsused := 1
   Else If (MaskOct1 = 255) and (MaskOct2 <> 255) Then octsused := 2
   Else If (MaskOct1 = 255) and (MaskOct2 = 255) and (MaskOct3 <> 255) Then octsused := 3
   Else octsused := 4;
   //Check for full class subnets (class a/b/c)
   Case octsused of
        2 : If MaskOct2 = 0 Then
               If (IPOct1 = NetOct1) Then
               Begin
                  Result := True;
                  Exit;
               End;
        3 : If MaskOct3 = 0 Then
               If (IPOct1 = NetOct1) and (IPOct2 = NetOct2) Then
               Begin
                  Result := True;
                  Exit;
               End;
        4 : If MaskOct4 = 0 Then
               If (IPOct1 = NetOct1) and (IPOct2 = NetOct2) and (IPOct3 = NetOct3) Then
               Begin
                  Result := True;
                  Exit;
               End;
   End;
   //Get start subnet
   Case octsused of
        1 : StartSubnet := 256 - MaskOct1;
        2 : StartSubnet := 256 - MaskOct2;
        3 : StartSubnet := 256 - MaskOct3;
        4 : StartSubnet := 256 - MaskOct4;
   End;
   //Get max subnets
   Case octsused of
        1 :   Case MaskOct1 of
                 254  : MaxSubnets := IntPower(2,7) - 2; // 7 bits = 128 64 32 16 8 4 2
                 252  : MaxSubnets := IntPower(2,6) - 2; // 6 bits = 128 64 32 16 8 4
                 248  : MaxSubnets := IntPower(2,5) - 2; // 5 bits = 128 64 32 16 8
                 240  : MaxSubnets := IntPower(2,4) - 2; // 4 bits = 128 64 32 16
                 224  : MaxSubnets := IntPower(2,3) - 2; // 3 bits = 128 64 32
                 192  : MaxSubnets := IntPower(2,2) - 2; // 2 bits = 128 64
                 128  : MaxSubnets := IntPower(2,1) - 1; // 1 bits = 128 = only minus 1 otherwise = 0 = bad !!
              End;
        2 :   Case MaskOct2 of
                 254  : MaxSubnets := IntPower(2,7) - 2; // 7 bits = 128 64 32 16 8 4 2
                 252  : MaxSubnets := IntPower(2,6) - 2; // 6 bits = 128 64 32 16 8 4
                 248  : MaxSubnets := IntPower(2,5) - 2; // 5 bits = 128 64 32 16 8
                 240  : MaxSubnets := IntPower(2,4) - 2; // 4 bits = 128 64 32 16
                 224  : MaxSubnets := IntPower(2,3) - 2; // 3 bits = 128 64 32
                 192  : MaxSubnets := IntPower(2,2) - 2; // 2 bits = 128 64
                 128  : MaxSubnets := IntPower(2,1) - 1; // 1 bits = 128  = only minus 1 otherwise = 0 = bad !!
              End;
        3 :   Case MaskOct3 of
                 254  : MaxSubnets := IntPower(2,7) - 2; // 7 bits = 128 64 32 16 8 4 2
                 252  : MaxSubnets := IntPower(2,6) - 2; // 6 bits = 128 64 32 16 8 4
                 248  : MaxSubnets := IntPower(2,5) - 2; // 5 bits = 128 64 32 16 8
                 240  : MaxSubnets := IntPower(2,4) - 2; // 4 bits = 128 64 32 16
                 224  : MaxSubnets := IntPower(2,3) - 2; // 3 bits = 128 64 32
                 192  : MaxSubnets := IntPower(2,2) - 2; // 2 bits = 128 64
                 128  : MaxSubnets := IntPower(2,1) - 1; // 1 bits = 128 = only minus 1 otherwise = 0 = bad !!
              End;
        4 :   Case MaskOct4 of
                 254  : MaxSubnets := IntPower(2,7) - 2; // 7 bits = 128 64 32 16 8 4 2
                 252  : MaxSubnets := IntPower(2,6) - 2; // 6 bits = 128 64 32 16 8 4
                 248  : MaxSubnets := IntPower(2,5) - 2; // 5 bits = 128 64 32 16 8
                 240  : MaxSubnets := IntPower(2,4) - 2; // 4 bits = 128 64 32 16
                 224  : MaxSubnets := IntPower(2,3) - 2; // 3 bits = 128 64 32
                 192  : MaxSubnets := IntPower(2,2) - 2; // 2 bits = 128 64
                 128  : MaxSubnets := IntPower(2,1) - 1; // 1 bits = 128 = only minus 1 otherwise = 0 = bad !!
              End;
        End;
        c := 0;
        While (a < (StartSubnet*MaxSubnets)) and Not(Result) Do
        Begin
           c := c + StartSubnet;
           Case octsused of
                1 : If (NetOct1 = c) and (c < IPOct1) and ((c + StartSubnet) > (IPOct1 + 1)) Then Result := True;
                2 : If (NetOct2 = c) and (c < IPOct2) and ((c + StartSubnet) > (IPOct2 + 1)) Then Result := True;
                3 : If (NetOct3 = c) and (c < IPOct3) and ((c + StartSubnet) > (IPOct3 + 1)) Then Result := True;
                4 : If (NetOct4 = c) and (c < IPOct4) and ((c + StartSubnet) > (IPOct4 + 1)) Then Result := True;
                // We add 1 because we cannot use the subnet broadcast address
           End;
        End;
End;


procedure TMainForm.FilesViewPopupPopup(Sender: TObject);
begin
  If FilesView.SelCount = 0 Then
  Begin
     AddFiles1.Enabled := True;
     RemoveFilesPopup.Enabled := False;
     SuspendFiles1.Enabled := False;
     ClearAccessCount1.Enabled := False;
     Fileinformation1.Enabled := False;
  End;
  If FilesView.SelCount = 1 Then
  Begin
     AddFiles1.Enabled := True;
     RemoveFilesPopup.Enabled := True;
     SuspendFiles1.Enabled := True;
     ClearAccessCount1.Enabled := True;
     Fileinformation1.Enabled := True;
  End;
  If FilesView.SelCount > 1 Then
  Begin
     AddFiles1.Enabled := True;
     RemoveFilesPopup.Enabled := True;
     SuspendFiles1.Enabled := True;
     ClearAccessCount1.Enabled := True;
     Fileinformation1.Enabled := False;
  End;
  If FilesView.Items.Count > 0 Then RefreshDeviceList1.Enabled := True
  Else RefreshDeviceList1.Enabled := False;
end;

procedure TMainForm.ActivityLogPopupPopup(Sender: TObject);
begin
   If (ActivityView.Items.Count > 0) Then
   Begin
      ClearLog1.Enabled := True;
      QuickSave1.Enabled := True;
   End Else
   Begin
      ClearLog1.Enabled := False;
      QuickSave1.Enabled := False;
   End;
end;

procedure TMainForm.Fileinformation1Click(Sender: TObject);
begin
   If (FileInfoForm = Nil) then FileInfoForm := TFileInfoForm.Create(MainForm);
   FileInfoForm.ShowModal;
   FreeandNil(FileInfoForm);
end;

procedure TMainForm.RefreshDeviceList1Click(Sender: TObject);
begin
   AdvToolBarButton7Click(Sender);
end;

procedure TMainForm.RefreshDeviceList2Click(Sender: TObject);
begin
   AdvToolBarButton7Click(Sender);
end;

procedure TMainForm.View1Click(Sender: TObject);
begin
   If ActivityView.Items.Count > 0 Then ClearActivitylog1.Enabled := True
   Else ClearActivitylog1.Enabled := False;
   If FilesView.Items.Count > 0 Then RefreshDeviceList1.Enabled := True
   Else RefreshDeviceList1.Enabled := False;
end;

procedure TMainForm.File1Click(Sender: TObject);
begin
   If FilesView.Items.Count > 0 Then SaveFileList1.Enabled := True
   Else SaveFileList1.Enabled := False;
end;

procedure TMainForm.Open1Click(Sender: TObject);
begin
   TrayIcon.Active := False;
   MainForm.Show;
   Application.BringToFront;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
   Open1Click(Sender);
end;

procedure TMainForm.FilesViewDblClick(Sender: TObject);
begin
   If (FilesView.SelCount = 1) then Fileinformation1Click(Sender);
end;

procedure TMainForm.FilesViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   // key 13 = enter
   If (FilesView.SelCount = 1) and (Key = 13) then Fileinformation1Click(Sender);
   // key 46 = del
   If (FilesView.SelCount > 0) and (Key = 46)  then AdvToolBarButton6Click(Sender);
end;

procedure TMainForm.Checkforupdates1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar('http://www.gjsolutions.co.uk/checkupdates/checkupdates.aspx?AppName=qtftpd&AppVer='+version),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.ProgressListViewChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
Var
  ProgressBar  : TProgressCyl;
Begin
   ProgressBar := TProgressCyl(ProgressListView.Items[Item.Index].Data);
   If Assigned(ProgressBar) Then
   Begin
      ProgressBar.Update;
      ProgressBar.Visible := True;
   End;
End;

procedure TMainForm.OpenFileList1Click(Sender: TObject);
begin
   AdvToolBarButton1Click(Sender);
end;

procedure TMainForm.Exit2Click(Sender: TObject);
begin
   Close;
end;

procedure TMainForm.Configuration1Click(Sender: TObject);
begin
   AdvToolBarButton10Click(Sender);
end;

procedure TMainForm.RefreshFilesList1Click(Sender: TObject);
begin
   AdvToolBarButton7Click(Sender);
end;

procedure TMainForm.Help2Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar(ExtractFileDir(Application.ExeName)+'\qtftpd.chm'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.LicenseInformation1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open', PChar(ExtractFileDir(Application.ExeName)+'\LICENCE AGREEMENT.chm'),
   nil,nil, SW_SHOWNORMAL);
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
   AdvToolBarButton11Click(Sender);
end;

procedure TMainForm.AdvToolBarButton1Click(Sender: TObject);
begin
  OpenDialog.Title := 'Open Files List...';
  OpenDialog.Filename := '';
  OpenDialog.Options := [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, OfEnableSizing];
  OpenDialog.Filter := 'QuickTFTP save file (*.qtf)|*'+savefileext;
  OpenDialog.InitialDir := ExtractFileDir(Application.ExeName);
  If Not(OpenDialog.Execute) Then Exit;
  LoadFilesList(OpenDialog.FileName);
  If (Config.Autostart) Then AdvToolBarButton3Click(Sender);
end;

procedure TMainForm.AdvToolBarButton2Click(Sender: TObject);
begin
  If (FilesView.Items.Count < 1) Then Exit;
  SaveDialog.Title := 'Save Files List...';
  SaveDialog.Options := [ofPathMustExist, ofFileMustExist, OfEnableSizing];
  SaveDialog.Filter := 'QuickTFTP save file (*.qtf)|*'+savefileext;
  SaveDialog.InitialDir := ExtractFileDir(Application.ExeName);
  If Not(SaveDialog.Execute) Then Exit;
  If (extractfileext(SaveDialog.FileName) <> savefileext) Then
     SaveDialog.FileName := SaveDialog.FileName + savefileext;
  If Not(SaveFilesView(SaveDialog.FileName)) Then
     WriteActivityLog(3,Datetimetostr(Now),' ',' ','Application: Error saving file list!')
  Else
     WriteActivityLog(2,Datetimetostr(Now),' ',' ','Application: Saved file list.');
end;


procedure TMainForm.AdvToolBarButton3Click(Sender: TObject);
begin
  If (Filesview.Items.Count = 0) and not(config.AcceptIncoming) Then
  Begin
     MessageDlg('No file available.'+ #13 +
                'Please add at least one file first or accept incoming files.', mtError, [mbOk], 0);
      Exit;
  End;
  If (TFTP.Active = False) Then
  Begin
     UpDateTFTPSettings;
     AddBindings;
     TFTP.Active := True;
     StartTFTP1.Enabled := False;
     StopTFTP1.Enabled := True;
  End;
  DLConns := 0;
  ULConns := 0;
  Stopping := False;
  UpdateStatusBar('Started.');
end;

procedure TMainForm.AdvToolBarButton4Click(Sender: TObject);
begin
  If (TFTP.Active = True) Then TFTP.Active := False;;
  If (DLConns = 0) and (ULConns = 0) Then StatusBar1.Panels[0].Text := 'Stopped.'
  Else StatusBar1.Panels[0].Text := 'Stopping...';
  Stopping := True;
  StartTFTP1.Enabled := True;
  StopTFTP1.Enabled := False;
end;

Function TMainForm.RemoveTrailingSlash(Const s : String) : String;
Begin
   If Pos('\',s) = Length(s) Then
      Result := Copy(s,1, (length(s) - 1))
   Else Result := s;
End;

procedure TMainForm.AdvToolBarButton5Click(Sender: TObject);
Var a,b        : Integer;
    Item       : TListItem;
    FindItem   : TListItem;
    Found      : Boolean;
begin
  OpenDialog.Title := 'Add Files...';
  OpenDialog.Files.Clear;
  OpenDialog.Options := [ofReadOnly, OfAllowMultiSelect, OfEnableSizing];
  OpenDialog.Filter := 'All Files (*.*)|*.*';
  If (OpenDialog.Execute = True) Then
  Begin
     MainForm.Cursor := crHourGlass;
     FilesView.Items.BeginUpdate;
     For a := 0 to (OpenDialog.Files.Count - 1) Do
     Begin
        If (filesview.Items.Count > 0) then
        Begin
           Found := False;
           For b := 0 to (filesview.Items.Count - 1) do
           Begin
              FindItem := filesview.Items.Item[b];
              If uppercase(FindItem.Caption) = uppercase(Extractfilename(OpenDialog.Files.Strings[a])) then
                     Found := True;
              Application.ProcessMessages;
           End;
           If Not(Found) Then
              Begin
                 Item := FilesView.Items.Add;
                 Item.Caption := Extractfilename(OpenDialog.Files.Strings[a]);
                 Item.SubItems.Append(RemoveTrailingSlash(ExtractFileDir(OpenDialog.Files.Strings[a])));
                 Item.SubItems.Append('0');
                 Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(OpenDialog.Files.Strings[a])));
              End;
        End Else
        Begin
          Item := FilesView.Items.Add;
          Item.Caption := Extractfilename(OpenDialog.Files.Strings[a]);
          Item.SubItems.Append(RemoveTrailingSlash(ExtractFileDir(OpenDialog.Files.Strings[a])));
          // Get access count details !!!!!
          Item.SubItems.Append('0');
          Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(OpenDialog.Files.Strings[a])));
        End;
     End;
     FilesView.Items.EndUpdate;
     FilesView.Update;
     MainForm.Cursor := crDefault;
  End;
end;

procedure TMainForm.AdvToolBarButton6Click(Sender: TObject);
Var
  i : Integer;
begin
   i := 0;
   Filesview.SetFocus;
   If (Filesview.SelCount = 1) then
   Begin
      Filesview.Items.Delete(Filesview.Selected.Index);
      FilesView.Update;
      Exit;
   End;
   If (Filesview.SelCount > 1) then
   Repeat
      If (Filesview.Items.Item[i].Selected = True) Then
      Begin
        Filesview.Items.Delete(Filesview.Items.Item[i].Index);
      End;
      inc(i);
      If (i >= Filesview.Items.Count) Then i := 0;
      Application.ProcessMessages;
   Until (Filesview.SelCount = 0);
   FilesView.Update;
end;

procedure TMainForm.AdvToolBarButton7Click(Sender: TObject);
Var
  a : Integer;
begin
  MainForm.Cursor := crHourGlass;
  application.ProcessMessages;
  a := 0;
  If (FilesView.Items.Count < 1) Then Exit;
  Repeat
    If Not(FileExists(Filesview.Items.Item[a].SubItems[0] +'\'+ Filesview.Items.Item[a].Caption)) Then
    Begin
       If (Config.RemoveDead) Then
       Begin
           Filesview.Items.Delete(a);
           a := 0;
           application.ProcessMessages;
       End Else Filesview.Items.Item[a].ImageIndex := 5;
    End Else If (Filesview.Items.Item[a].ImageIndex = 5) Then Filesview.Items.Item[a].ImageIndex := 0;
    Inc(a);
  Until (a >= (FilesView.Items.Count - 1));
  MainForm.Cursor := crDefault;
end;

procedure TMainForm.AdvToolBarButton8Click(Sender: TObject);
begin
   If MessageDlg('Are you sure you want to remove all available files?', mtWarning, [mbYes, mbNo], 0) = mrNo Then Exit;
   FilesView.Clear;
   FilesView.Update;
end;

procedure TMainForm.AdvToolBarButton9Click(Sender: TObject);
begin
   ActivityView.Clear;
end;

procedure TMainForm.AdvToolBarButton10Click(Sender: TObject);
begin
  Check;
  If (ConfigForm = Nil) then ConfigForm := TConfigForm.Create(MainForm);
  ConfigForm.ShowModal;
  LoadIniFile;
  UpDateTFTPSettings;
  LoadSecurityItems;
  FreeandNil(ConfigForm);
  CheckAutoRefresh;
end;

procedure TMainForm.AdvToolBarButton11Click(Sender: TObject);
begin
  If (AboutForm = Nil) then AboutForm := TAboutForm.Create(MainForm);
  AboutForm.ShowModal;
  FreeandNil(AboutForm);
end;

procedure TMainForm.AdvToolBarButton12Click(Sender: TObject);
begin
   Close;
end;

Function  TMainForm.FindTransferinList(const Index : Integer) : Integer;
Var
  i     : Integer;
  found : Boolean;
  TItm  : PTransferRec;
Begin
   Result := -1;
   If (Transferlist.Count = 0)  or
      (ProgressListView.Items.Count <= Index) Then Exit;
   i := - 1;
   found := False;
   Repeat
      Inc(i);
      TItm := TransferList.Items[i];
      If (TItm^.IP_Address = ProgressListView.Items.Item[index].SubItems[1]) and
         (TItm^.Port       = StrToInt(ProgressListView.Items.Item[index].SubItems[2])) Then Found := True;
   Until (i = (TransferList.Count - 1)) or (Found);
   If (Found) Then Result := i;
End;


Procedure TMainForm.AddEndTransfer(const PeerInfo : TPeerInfo; const Ended : DWord);
Var
  i     : Integer;
  found : Boolean;
Begin
   If (Transferlist.Count = 0) Then Exit;
   i := 0;
   found := False;
   Repeat
      TransferItem := TransferList.Items[i];
      If (TransferItem^.IP_Address = PeerInfo.PeerIP) and
         (TransferItem^.Port       = PeerInfo.PeerPort) Then Found := True
      Else Inc(i);
   Until (i = TransferList.Count) or (Found);
   If (Found) Then TransferItem^.EndTime := Ended;
End;



Function TMainForm.FindTransfer(const PeerInfo : TPeerInfo) : Integer;
Var
  i      : Integer;
  found  : Boolean;
  Tempti : PTransferRec;
Begin
   Result := -1;
   If (Transferlist.Count = 0) Then Exit;
   i := -1;
   found := False;
   Repeat
      Inc(i);
      Tempti := TransferList.Items[i];
      If (Tempti^.IP_Address = PeerInfo.PeerIP) and
         (Tempti^.Port       = PeerInfo.PeerPort) Then Found := True;
   Until (i = TransferList.Count - 1) or (Found);
   If (Found) Then Result := i;
End;



Procedure TMainForm.AddTransfer(const PeerInfo: TPeerInfo; Filename : String; Size : Longint; writeop : Boolean; Starttime : DWord);
Var
  i   : Integer;
  TI  : PTransferRec;
Begin
   If (Transferlist.Count = 0) Then
   Begin
      New(TI);
      TI^.WriteOp := WriteOp;
      TI^.IP_Address := PeerInfo.PeerIP;
      TI^.Port       := PeerInfo.PeerPort;
      TI^.Filename   := Filename;
      TI^.Filesize   := Size;
      TI^.StartTime  := Starttime;
      TI^.EndTime    := 0;
      TransferList.Add(TI);
      TransferList.Pack;
      TransferList.Capacity := TransferList.Count + 1;
   End Else
   Begin
      i := - 1;
      Repeat
         Inc(i);
         TI := TransferList.Items[i];
         If (TI^.IP_Address = PeerInfo.PeerIP) and
            (TI^.Port = PeerInfo.PeerPort) Then
         Begin
            TransferList.Delete(i);
            TransferList.Pack;
            TransferList.Capacity := TransferList.Count;
         End;
      Until i = (TransferList.Count - 1);
      New(TI);
      TI^.WriteOp := WriteOp;
      TI^.IP_Address := PeerInfo.PeerIP;
      TI^.Port       := PeerInfo.PeerPort;
      TI^.Filename   := Filename;
      TI^.Filesize   := Size;
      TI^.StartTime  := Starttime;
      TI^.EndTime    := 0;
      TransferList.Add(TI);
      TransferList.Pack;
      TransferList.Capacity := TransferList.Count + 1;
   End;
End;

Procedure TMainForm.DelTransferbyName(Const IPAddr : String; Const Port : Integer; Const FName : String = '');
Var
  i : Integer;
Begin
   If (TransferList.Count = 0) Then Exit;
   i := 0;
   Repeat
      TransferItem := TransferList.Items[i];
      If (FName <> '') Then
      Begin
         If (TransferItem^.IP_Address = IPAddr) and
            (TransferItem^.Port = Port) and
            (TransferItem^.Filename = FName) Then
         Begin
            TransferList.Delete(i);
            TransferList.Pack;
            TransferList.Capacity := TransferList.Count;
         End Else Inc(i);
      End Else
      Begin
         If (TransferItem^.IP_Address = IPAddr) and
            (TransferItem^.Port = Port) Then
         Begin
            TransferList.Delete(i);
            TransferList.Pack;
            TransferList.Capacity := TransferList.Count;
         End Else Inc(i);
      End;
   Until (i = TransferList.Count);
End;


Procedure TMainForm.DelTransfer(const PeerInfo: TPeerInfo);
Var
  i : Integer;
Begin
   If (TransferList.Count = 0) Then Exit;
   i := 0;
   Repeat
      TransferItem := TransferList.Items[i];
      If (TransferItem^.IP_Address = PeerInfo.PeerIP) and
         (TransferItem^.Port       = PeerInfo.PeerPort) Then
      Begin
         TransferList.Delete(i);
         TransferList.Pack;
         TransferList.Capacity := TransferList.Count;
      End Else Inc(i);
   Until (i = TransferList.Count);
End;

procedure TMainForm.TFTPSizeRequest(Sender: TObject;
  const FileName: String; const PeerInfo: TPeerInfo; var size: int64;
  const WriteOperation: Boolean);
Var
  i     : Integer;

begin
   If (Size = -1) and (WriteOperation) Then
   Begin
      // add upload entry without file size
      AddTransfer(PeerInfo, Filename, 0, WriteOperation, GetTickCount);
      Exit;
   End;
   // add upload entry with file size
   If (WriteOperation) Then AddTransfer(PeerInfo, Filename, Size, WriteOperation, GetTickCount);
   If Not(WriteOperation) and (FilesView.Items.Count > 0) Then
   Begin
      For i := 0 to (FilesView.Items.Count - 1) Do
         If Uppercase(Filename) = uppercase(FilesView.Items.Item[i].Caption) Then
            If Fileexists(FilesView.Items.Item[i].SubItems[0]+'\'+FilesView.Items.Item[i].Caption) Then
                 Size := GetHugeFileSize(FilesView.Items.Item[i].SubItems[0]+'\'+FilesView.Items.Item[i].Caption);
      // add download entry with file size
      AddTransfer(PeerInfo, Filename, Size, WriteOperation, GetTickCount);

   End;
   If Not(Config.TSize) Then Size := -1;
end;

procedure TMainForm.TransferPopupPopup(Sender: TObject);
begin
   If (ProgressListView.Items.Count = 0) Then
   Begin
      Details1.Enabled := False;
      Exit;
   End;
   If (ProgressListView.Selcount = 1) Then Details1.Enabled := True;
end;

procedure TMainForm.LoadTransferDetailWindow;
Var
  i      : Integer;
  Port   : Integer;
  IPAddr : String;
  FName  : String;
Begin
   If (Progresslistview.Items.Count = 0) or
      (Progresslistview.SelCount <> 1) Then Exit;
   i := ProgressListView.Selected.Index;
   Port   := Strtoint(ProgressListView.Items.Item[i].SubItems[2]);
   IPAddr := ProgressListView.Items.Item[i].SubItems[1];
   FName  := ProgressListView.Items.Item[i].SubItems[0];
   If (TransferWindowForm = Nil) Then
       TransferWindowForm := TTransferWindowform.Create(MainForm);
   TransferWindowUnit.ItemIdx := FindTransferinList(i);
   TransferWindowForm.ShowModal;
   FreeandNil(TransferWindowForm);
   If (i >= Progresslistview.Items.Count) then DelTransferbyName(IPAddr, Port, FName);
End;

procedure TMainForm.ProgressListViewDblClick(Sender: TObject);
begin
   LoadTransferDetailWindow;
end;

procedure TMainForm.Details1Click(Sender: TObject);
begin
   LoadTransferDetailWindow;
end;

procedure TMainForm.ProgressListViewClick(Sender: TObject);
begin
   LoadTransferDetailWindow;
end;


procedure TMainForm.AdvToolBarButton13Click(Sender: TObject);
Var a          : Integer;
    Item       : TListItem;
    Found      : Boolean;
    Dir        : String;
    Filename   : String;
    SearchRec  : TSearchRec;
begin
  If (BrowseFolderDialog.Execute = True) and (DirectoryExists(BrowseFolderDialog.SelectedFolder)) Then
  Begin
     MainForm.Cursor := crHourGlass;
     FilesView.Cursor := crHourGlass;
     ProgressListView.Cursor := crHourGlass;
     ActivityView.Cursor := crHourGlass;
     StatusBar1.Cursor := crHourGlass;
     AdvToolBar1.Cursor := crHourGlass;
     FilesView.Items.BeginUpdate;
     If FindFirst(BrowseFolderDialog.SelectedFolder+'\*.*', faArchive, SearchRec) = 0 Then
     Begin
        Repeat
            Dir := BrowseFolderDialog.SelectedFolder;
            Filename := ExtractFilename(SearchRec.Name);
            Found := False;
            If (FilesView.Items.Count <> 0) Then
                For a := 0 To (FilesView.Items.Count - 1) Do
                   If (Uppercase(FilesView.Items.Item[a].Caption) = uppercase(Filename)) Then Found := True;
                Application.ProcessMessages;
            If Not(Found) Then
            Begin
               Item := FilesView.Items.Add;
               item.Caption := Filename;
               Item.SubItems.Append(RemoveTrailingSlash(Dir));
               Item.SubItems.Append('0');
               Item.SubItems.Append(BytesToAbbr(GetHugeFileSize(Dir + '\'+ Filename)));
            End;
        until FindNext(SearchRec) <> 0;
     End;
     FindClose(SearchRec);
     FilesView.Items.EndUpdate;
     FilesView.Update;
     MainForm.Cursor := crDefault;
     FilesView.Cursor := crHandPoint;
     ProgressListView.Cursor := crDefault;
     ActivityView.Cursor := crDefault;
     StatusBar1.Cursor := crDefault;
     AdvToolBar1.Cursor := crDefault;

  End;
end;

end.
