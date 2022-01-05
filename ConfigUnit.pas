unit ConfigUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Winsock, IdBaseComponent,
  IdComponent, IdRawBase, IdRawClient, IdIcmpClient, IniFiles,
  LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint, LMDShapeHint,
  LMDBrowseDlg, ComCtrls, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDCustomComboBox, LMDComboBox, XPMenu,
  Menus, ImgList, Registry, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDFill;

type
  TConfigForm = class(TForm)
    SaveButton: TBitBtn;
    CloseButton: TBitBtn;
    BrowseDlg: TLMDBrowseDlg;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    BindIPList: TListBox;
    AddButton: TBitBtn;
    Removebutton: TBitBtn;
    AvailIPList: TListBox;
    Label2: TLabel;
    TabSheet4: TTabSheet;
    NoAcceptRadio: TRadioButton;
    AcceptRadio: TRadioButton;
    Destedit: TLabeledEdit;
    addnewCheck: TCheckBox;
    Browsebutton: TBitBtn;
    TabSheet5: TTabSheet;
    NologRadio: TRadioButton;
    LogRadio: TRadioButton;
    LogFormatCombo: TLMDComboBox;
    LogFormatLabel: TLabel;
    LogLimitGroupBox: TGroupBox;
    LogSizeRadio: TRadioButton;
    LogSizeEdit: TLMDSpinEdit;
    LogKBLabel: TLabel;
    LogSepRadio: TRadioButton;
    LogFolderEdit: TLabeledEdit;
    LogFolderButton: TBitBtn;
    LogOptionsCheck: TCheckBox;
    OverwriteCheck: TCheckBox;
    SecurityPopup: TPopupMenu;
    SecurityImageList: TImageList;
    ConfigTree: TTreeView;
    TreeImages: TImageList;
    TabSheet6: TTabSheet;
    GroupBox6: TGroupBox;
    StartOnStartUpCheck: TCheckBox;
    MinOnStartupCheck: TCheckBox;
    LoadonstartupCheck: TCheckBox;
    RefreshAfterLoadCheck: TCheckBox;
    AutoStartTFTPCheck: TCheckBox;
    AutoRefreshCheck: TCheckBox;
    RefreshTimeEdit: TLMDSpinEdit;
    RefreshMinuteLabel: TLabel;
    RemovedeadfilesCheck: TCheckBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    DisableSecurityRadio: TRadioButton;
    EnableSecurityRadio: TRadioButton;
    SecurityListView: TListView;
    addacceptbutton: TBitBtn;
    removeacceptbutton: TBitBtn;
    RemoveAllSecurityButton: TBitBtn;
    SecurityUpButton: TBitBtn;
    SecurityDownButton: TBitBtn;
    SecurityPanel: TPanel;
    ReadCheckBox: TCheckBox;
    WriteCheckBox: TCheckBox;
    DenyCheckBox: TCheckBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    LogSizeTextLabel: TLabel;
    TSizeCheck: TCheckBox;
    TimeoutEdit: TLMDSpinEdit;
    TimeoutCheck: TCheckBox;
    RestrictLabel4: TLabel;
    RestrictLabel2: TLabel;
    RestrictLabel1: TLabel;
    RestrictLabel: TLabel;
    PortEdit: TLMDSpinEdit;
    MaxULConnectEdit: TLMDSpinEdit;
    MaxDLConnectEdit: TLMDSpinEdit;
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    BufferSizeEdit: TLMDSpinEdit;
    LMDFill1: TLMDFill;
    Label13: TLabel;
    GroupBox5: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    EnableFirewallCheck: TCheckBox;
    MaxLabel: TLabel;
    MinLabel: TLabel;
    MaxPortEdit: TLMDSpinEdit;
    MinPortEdit: TLMDSpinEdit;
    LMDFill2: TLMDFill;
    Label8: TLabel;
    LMDFill3: TLMDFill;
    Label11: TLabel;
    LMDFill4: TLMDFill;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    GroupBox12: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox13: TGroupBox;
    Label10: TLabel;
    Label12: TLabel;
    LMDFill5: TLMDFill;
    Label18: TLabel;
    Label19: TLabel;
    LMDFill6: TLMDFill;
    Label20: TLabel;
    Label21: TLabel;
    CheckBox1: TCheckBox;
    procedure CloseButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure RemovebuttonClick(Sender: TObject);
    procedure BrowsebuttonClick(Sender: TObject);
    procedure NoAcceptRadioClick(Sender: TObject);
    procedure AcceptRadioClick(Sender: TObject);
    procedure NologRadioClick(Sender: TObject);
    procedure LogRadioClick(Sender: TObject);
    procedure LogFolderButtonClick(Sender: TObject);
    procedure LogOptionsCheckClick(Sender: TObject);
    procedure addacceptbuttonClick(Sender: TObject);
    procedure ReadCheckBoxClick(Sender: TObject);
    procedure WriteCheckBoxClick(Sender: TObject);
    procedure DenyCheckBoxClick(Sender: TObject);
    procedure CheckSecuritySelection;
    procedure SecurityListViewClick(Sender: TObject);
    procedure removeacceptbuttonClick(Sender: TObject);
    procedure RemoveAllSecurityButtonClick(Sender: TObject);
    procedure DisableSecurityRadioClick(Sender: TObject);
    procedure EnableSecurityRadioClick(Sender: TObject);
    procedure SecurityUpButtonClick(Sender: TObject);
    procedure SecurityDownButtonClick(Sender: TObject);
    procedure AutoRefreshCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigTreeClick(Sender: TObject);
    procedure StartOnStartUpCheckClick(Sender: TObject);
    procedure EnableFirewallCheckClick(Sender: TObject);
    procedure MaxPortEditExit(Sender: TObject);
    procedure MinPortEditExit(Sender: TObject);
  private
    function  getIPs : Tstrings;
    procedure SaveIniFile;
    procedure LoadIniFile;
    procedure CheckBindings;
    procedure CheckAcceptPos;
    Procedure CheckLoggingPos;
    procedure UpdateSecurityView;
    procedure UpdateItemSecurity(Idx : Integer);
    procedure EnableSecurity;
    procedure SaveSecurityList;
    procedure LoadSecurityList;
    Procedure CheckStartOnStartupCheck;
    Procedure CheckStartOnStartup;
  public
    {}
  end;

  SecurityRec = Record
                  Net_Address  : String[15];
                  Mask_Address : String[15];
                  // IP Security Type: 1 = Single IP, 2 = Subnet
                  IPType       : Integer;
                  // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
                  SecurityType : Integer;
  End;
  PSecurity = ^SecurityRec;

var
  ConfigForm        : TConfigForm;
  SecurityList      : TList;
  Security          : PSecurity;
  SecurityClick     : Boolean;
  CurrentSecuritySelected : integer;

implementation

{$R *.dfm}
{$D-,L-,O+,Q-,R-,Y-,S-}

uses MainUnit, SecurityAddUnit;

procedure TConfigForm.CloseButtonClick(Sender: TObject);
begin
  Try
    If (SecurityList.Count > 0) Then SecurityList.Clear;
  Finally
    SecurityList.Free;
  End;
  ModalResult := mrOK;
end;

procedure TConfigForm.SaveButtonClick(Sender: TObject);
begin
   SaveIniFile;
   CheckStartOnStartup;
   Try
     If (SecurityList.Count > 0) Then SaveSecurityList
     Else DeleteFile(ChangeFileExt(Application.ExeName,'.SEC'));
     SecurityList.Clear;
   Finally
     SecurityList.Free;
   End;

   ModalResult := mrOK;
end;

procedure TConfigForm.CheckAcceptPos;
Begin
    If NoAcceptRadio.Checked Then
    Begin
       Destedit.Enabled := False;
       Browsebutton.Enabled := False;
       addnewCheck.Enabled := False;
       OverwriteCheck.Enabled := False;
    End Else
    Begin
       AcceptRadio.Checked := True;
       Destedit.Enabled := True;
       Browsebutton.Enabled := True;
       addnewCheck.Enabled := True;
       OverwriteCheck.Enabled := True;
    End;
End;

procedure TConfigForm.FormCreate(Sender: TObject);
begin
    CurrentSecuritySelected := -1;
    SecurityList := TList.Create;
    SecurityClick := True;
    AvailIPList.Items := getIPs;
    LoadIniFile;
    CheckAcceptPos;
    LoadSecurityList;
end;

procedure TConfigForm.SaveIniFile;
Var
  inifile    : TIniFile;
  BindIps    : String;
  AcceptIps  : String;
  a          : Integer;
Begin
   BindIps := '';
   AcceptIps := '';
   If Length(DestEdit.text) > 0 Then
      If Destedit.Text[Length(Destedit.Text)] = '\' Then
       Destedit.Text := Copy(Destedit.Text, 1, Length(Destedit.Text)-1);
   If (BindIPList.Count > 0) then
   Begin
      a := 0;
      repeat
         If a < (BindIpList.Count - 1) then
            BindIps := BindIps + BindIPList.Items.Strings[a] + ';'
         Else If a = (BindIpList.Count - 1) then
            BindIps := BindIps + BindIPList.Items.Strings[a];
         Inc(a);
      Until a >= BindIpList.Count;
   End;
   inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     try
       inifile.WriteInteger('TFTP Settings','Port', PortEdit.value);
       inifile.WriteInteger('TFTP Settings','BufferSize', BufferSizeEdit.value);
       inifile.WriteInteger('TFTP Settings','Timeout', TimeoutEdit.value);
       inifile.WriteBool('TFTP Settings','AutoStartTFTP', AutoStartTFTPCheck.Checked);
       inifile.WriteBool('TFTP Settings','SecurityOn', EnableSecurityRadio.Checked);
       inifile.WriteBool('TFTP Settings','LoadOnStartup', LoadonstartupCheck.Checked);
       inifile.WriteBool('TFTP Settings','RefreshAfterLoad', RefreshAfterLoadCheck.Checked);
       inifile.WriteBool('TFTP Settings','RemoveDead', RemovedeadfilesCheck.Checked);
       inifile.WriteBool('TFTP Settings','AutoRefresh', AutoRefreshCheck.Checked);
       inifile.WriteInteger('TFTP Settings','AutoRefreshInterval', RefreshTimeEdit.Value);
       inifile.WriteBool('TFTP Settings','StartOnStartup', StartOnStartUpCheck.Checked);
       inifile.WriteBool('TFTP Settings','MinOnStartup', MinOnStartUpCheck.Checked);
       inifile.WriteInteger('TFTP Settings','MaxDLConn', MaxDLConnectEdit.Value);
       inifile.WriteInteger('TFTP Settings','MaxULConn', MaxULConnectEdit.Value);
       inifile.WriteBool('TFTP Settings','RMTransfer', true{RemoveTransferCheck.Checked});
       inifile.WriteBool('TFTP Settings','TSize', TSizeCheck.Checked);
       inifile.WriteBool('TFTP Settings','ClientTimeout', TimeoutCheck.Checked);
       inifile.WriteString('IP Settings','Bind', BindIps);
       inifile.WriteBool('FileAccepting','Accept', AcceptRadio.Checked);
       inifile.WriteBool('FileAccepting','AddNew', addnewCheck.Checked);
       inifile.WriteBool('FileAccepting','Overwrite', OverwriteCheck.Checked);
       inifile.Writestring('FileAccepting','DestDir', Destedit.Text);
       inifile.WriteBool('Logging','Log', LogRadio.Checked);
       inifile.WriteInteger('Logging','LogFormat', Logformatcombo.ItemIndex);
       inifile.WriteBool('Logging','LogLimitOptions', LogOptionsCheck.Checked);
       inifile.WriteBool('Logging','LogLimit', LogSizeRadio.Checked);
       inifile.WriteInteger('Logging','LogSize', LogSizeEdit.Value);
       inifile.Writestring('Logging','LogFolder', LogFolderEdit.Text);
       inifile.WriteBool('Firewall','Enable', EnableFirewallCheck.Checked);
       inifile.WriteInteger('Firewall','MinPort', MinPortEdit.Value);
       inifile.WriteInteger('Firewall','MaxPort', MaxPortEdit.Value);

     Finally
        inifile.Free;
     End;
End;

procedure TConfigForm.LoadIniFile;
Var
  inifile   : TIniFile;
  BindIps   : String;
  a         : integer;
Begin
  If FileExists(ChangeFileExt(Application.ExeName, '.ini')) Then
  Begin
     inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     Try
        PortEdit.Value := inifile.ReadInteger('TFTP Settings','Port', 69);
        BufferSizeEdit.value := inifile.ReadInteger('TFTP Settings','BufferSize', 8192);
        TimeoutEdit.value := inifile.ReadInteger('TFTP Settings','Timeout', 3);
        AutoStartTFTPCheck.Checked := inifile.ReadBool('TFTP Settings','AutoStartTFTP', AutoStartTFTPCheck.Checked);
        EnableSecurityRadio.Checked := inifile.ReadBool('TFTP Settings','SecurityOn', EnableSecurityRadio.Checked);
        LoadonstartupCheck.Checked := inifile.ReadBool('TFTP Settings','LoadOnStartup', LoadonstartupCheck.Checked);
        RefreshAfterLoadCheck.Checked := inifile.ReadBool('TFTP Settings','RefreshAfterLoad', RefreshAfterLoadCheck.Checked);
        RemovedeadfilesCheck.Checked := inifile.ReadBool('TFTP Settings','RemoveDead', RemovedeadfilesCheck.Checked);
        AutoRefreshCheck.Checked := inifile.ReadBool('TFTP Settings','AutoRefresh', AutoRefreshCheck.Checked);
        RefreshTimeEdit.Value := inifile.ReadInteger('TFTP Settings','AutoRefreshInterval', RefreshTimeEdit.Value);
        StartOnStartUpCheck.Checked := inifile.ReadBool('TFTP Settings','StartOnStartup', StartOnStartUpCheck.Checked);
        MinOnStartUpCheck.Checked := inifile.ReadBool('TFTP Settings','MinOnStartup', MinOnStartUpCheck.Checked);
        MaxDLConnectEdit.Value := inifile.ReadInteger('TFTP Settings','MaxDLConn', MaxDLConnectEdit.Value);
        MaxULConnectEdit.Value := inifile.ReadInteger('TFTP Settings','MaxU:Conn', MaxULConnectEdit.Value);
        //RemoveTransferCheck.Checked := inifile.ReadBool('TFTP Settings','RMTransfer', RemoveTransferCheck.Checked);
        TSizeCheck.Checked := inifile.ReadBool('TFTP Settings','TSize', TSizeCheck.Checked);
        TimeoutCheck.Checked := inifile.ReadBool('TFTP Settings','ClientTimeout', TimeoutCheck.Checked);
        BindIps := inifile.ReadString('IP Settings','Bind', 'All');
        AcceptRadio.Checked := inifile.ReadBool('FileAccepting','Accept', AcceptRadio.Checked);
        addnewCheck.Checked := inifile.ReadBool('FileAccepting','AddNew', addnewCheck.Checked);
        OverwriteCheck.Checked := inifile.ReadBool('FileAccepting','Overwrite', OverwriteCheck.Checked);
        Destedit.Text := inifile.Readstring('FileAccepting','DestDir', '');
        LogRadio.Checked := inifile.ReadBool('Logging','Log', False);
        Logformatcombo.ItemIndex := inifile.ReadInteger('Logging','LogFormat', 0);
        LogOptionsCheck.Checked := inifile.ReadBool('Logging','LogLimitOptions', False);
        LogSizeRadio.Checked := inifile.ReadBool('Logging','LogLimit', True);
        LogSizeEdit.Value := inifile.ReadInteger('Logging','LogSize', 100);
        LogFolderEdit.Text := inifile.Readstring('Logging','LogFolder', ExtractFileDir(Application.ExeName));
        EnableFirewallCheck.Checked := inifile.ReadBool('Firewall','Enable', False);
        MinPortEdit.Value := inifile.ReadInteger('Firewall','MinPort', 1024);
        MaxPortEdit.Value := inifile.ReadInteger('Firewall','MaxPort', 65535);
     Finally
        inifile.Free;
     End;
     If (Length(BindIps) > 0) and (Pos(';', BindIps) > 0) Then
     Begin
        a := Pos(';', BindIps);
        While a > 0 do
        Begin
           BindIPList.Items.Append(Copy(BindIps, 0, (a - 1)));
           BindIps := Copy(BindIps, (a+1), length(BindIps));
           a := Pos(';', BindIps);
        End;
     End Else
     If (Length(BindIps) > 0) and (Pos(';', BindIps) = 0) Then
         BindIPList.Items.Append(BindIps);
  End ELse
  Begin
     // INI File does not exist
     inifile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     try
        inifile.WriteInteger('TFTP Settings','Port', PortEdit.value);
        inifile.WriteInteger('TFTP Settings','BufferSize', BufferSizeEdit.value);
        inifile.WriteInteger('TFTP Settings','Timeout', TimeoutEdit.value);
        inifile.WriteBool('TFTP Settings','AutoStartTFTP', AutoStartTFTPCheck.Checked);
        inifile.WriteBool('TFTP Settings','SecurityOn', EnableSecurityRadio.Checked);
        inifile.WriteBool('TFTP Settings','LoadOnStartup', LoadonstartupCheck.Checked);
        inifile.WriteBool('TFTP Settings','RefreshAfterLoad', RefreshAfterLoadCheck.Checked);
        inifile.WriteBool('TFTP Settings','RemoveDead', RemovedeadfilesCheck.Checked);
        inifile.WriteBool('TFTP Settings','AutoRefresh', AutoRefreshCheck.Checked);
        inifile.WriteInteger('TFTP Settings','AutoRefreshInterval', RefreshTimeEdit.Value);
        inifile.WriteBool('TFTP Settings','StartOnStartup', StartOnStartUpCheck.Checked);
        inifile.WriteBool('TFTP Settings','MinOnStartup', MinOnStartUpCheck.Checked);
        inifile.WriteInteger('TFTP Settings','MaxDLConn', MaxDLConnectEdit.Value);
        inifile.WriteInteger('TFTP Settings','MaxULConn', MaxULConnectEdit.Value);
        inifile.WriteBool('TFTP Settings','RMTransfer', true{RemoveTransferCheck.Checked});
        inifile.WriteBool('TFTP Settings','TSize', TSizeCheck.Checked);
        inifile.WriteBool('TFTP Settings','ClientTimeout', TimeoutCheck.Checked);
        inifile.WriteString('IP Settings','Bind', 'All');
        inifile.WriteBool('FileAccepting','Accept', False);
        inifile.WriteBool('FileAccepting','AddNew', False);
        inifile.WriteBool('FileAccepting','Overwrite', False);
        inifile.Writestring('FileAccepting','DestDir', '');
        inifile.WriteBool('Logging','Log', False);
        inifile.WriteInteger('Logging','LogFormat', 0);
        inifile.WriteBool('Logging','LogLimitOptions', False);
        inifile.WriteBool('Logging','LogLimit', True);
        inifile.WriteInteger('Logging','LogSize', 100);
        inifile.Writestring('Logging','LogFolder', ExtractFileDir(Application.ExeName));
        inifile.WriteBool('Firewall','Enable', False);
        inifile.WriteInteger('Firewall','MinPort', 1024);
        inifile.WriteInteger('Firewall','MaxPort', 65535);
     Finally
        inifile.Free;
     End;
     BindIPList.Items.Clear;
     BindIPList.Items.Append('All');
  End;
  CheckBindings;
  CheckLoggingPos;
  CheckAcceptPos;
  CheckStartOnStartupCheck;
End;

procedure TConfigForm.CheckBindings;
Var
  a : Integer;
Begin
   // Get rid of IP address which is not currently used by the computer
   a := 0;
   If (AvailIPList.Count > 0) then
   Repeat
     If BindIPList.Items.IndexOf(AvailIPList.Items.Strings[a]) > - 1 then
       AvailIPList.Items.Delete(a);
     AvailIPList.Update;
     Inc(a);
   Until a >= AvailIPList.Count;
   // Delete IP address from the available list if they already appear in the Bind list
   a := 0;
   If (BindIPList.Count > 0) then
   Repeat
     If AvailIPList.Items.IndexOf(BindIPList.Items.Strings[a]) > - 1 then
       AvailIPList.Items.Delete(AvailIPList.Items.IndexOf(BindIPList.Items.Strings[a]))
     Else Inc(a);
   Until a >= BindIPList.Count;
End;


function TConfigForm.getIPs: Tstrings;
type
   TaPInAddr = array[0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
var
   phe: PHostEnt;
   pptr: PaPInAddr;
   Buffer: array[0..63] of Char;
   I: Integer;
   GInitData: TWSAData;
begin
    WSAStartup($101, GInitData);
    Result := TstringList.Create;
    Result.Clear;
    GetHostName(Buffer, SizeOf(Buffer));
    phe := GetHostByName(buffer);
    if phe = nil then Exit;
    pPtr := PaPInAddr(phe^.h_addr_list);
    I    := 0;
    while pPtr^[I] <> nil do
    begin
       Result.Add(inet_ntoa(pptr^[I]^));
       Inc(I);
    end;
    WSACleanup;
end;

procedure TConfigForm.AddButtonClick(Sender: TObject);
Var
  i : Integer;
begin
   If AvailIPList.SelCount > 0 then
   Begin
      If BindIPList.Items.IndexOf('All') <> -1 then
         BindIPList.Items.Delete(BindIPList.Items.IndexOf('All'));
      i := 0;
      Repeat
         If AvailIPList.Selected[i] Then
         Begin
            bindIPList.Items.Append(AvailIPList.Items.Strings[i]);
            AvailIPList.Items.Delete(i)
         End Else Inc(i);
      Until i >= AvailIPList.Count;
   End;
end;

procedure TConfigForm.RemovebuttonClick(Sender: TObject);
var
  i : Integer;
begin
   If BindIPList.SelCount > 0 then
   Begin
      i := 0;
      Repeat
         If (BindIPList.Selected[i]) and (BindIPList.Items.Strings[i] <> 'All') then
         Begin
            AvailIPList.Items.Append(BindIPList.Items.Strings[i]);
            BindIPList.Items.Delete(i);
         End else Inc(i);
      Until i >= BindIPList.Count;
      If BindIPList.Count = 0 then BindIPList.Items.Append('All');
   End;
end;

procedure TConfigForm.BrowsebuttonClick(Sender: TObject);
begin
   If Destedit.text <> '' then
      BrowseDlg.SelectedFolder := Destedit.text;
   If (BrowseDlg.Execute) then
       Destedit.Text := BrowseDlg.SelectedFolder;
end;

procedure TConfigForm.NoAcceptRadioClick(Sender: TObject);
begin
   CheckAcceptPos;
end;

procedure TConfigForm.AcceptRadioClick(Sender: TObject);
begin
   CheckAcceptPos;
end;

procedure TConfigForm.NologRadioClick(Sender: TObject);
begin
   CheckLoggingPos;
end;

procedure TConfigForm.LogRadioClick(Sender: TObject);
begin
   CheckLoggingPos;
end;

procedure TConfigForm.LogOptionsCheckClick(Sender: TObject);
begin
  CheckLoggingPos;
end;

Procedure TConfigForm.CheckLoggingPos;
Begin
   If LogRadio.Checked Then
   Begin
      LogFormatLabel.Enabled := True;
      LogFormatCombo.Enabled := True;
      LogLimitGroupBox.Enabled := True;
      LogSizeRadio.Enabled := True;
      LogSepRadio.Enabled := True;
      LogSizeEdit.Enabled := True;
      LogKBLabel.Enabled := True;
      LogFolderEdit.Enabled := True;
      LogFolderButton.Enabled := True;
      LogOptionsCheck.Enabled := True;
      LogSizeTextLabel.Enabled := True;
   End;
   If NoLogRadio.Checked Then
   Begin
      LogFormatLabel.Enabled := False;
      LogFormatCombo.Enabled := False;
      LogLimitGroupBox.Enabled := False;
      LogSizeRadio.Enabled := False;
      LogSepRadio.Enabled := False;
      LogSizeEdit.Enabled := False;
      LogKBLabel.Enabled := False;
      LogFolderEdit.Enabled := False;
      LogFolderButton.Enabled := False;
      LogOptionsCheck.Enabled := False;
      LogSizeTextLabel.Enabled := False;
   End;
   If LogOptionsCheck.Checked and LogRadio.Checked Then
   Begin
      LogLimitGroupBox.Enabled := True;
      LogSizeRadio.Enabled := True;
      LogSepRadio.Enabled := True;
      LogSizeEdit.Enabled := True;
      LogKBLabel.Enabled := True;
      LogSizeTextLabel.Enabled := True;
  End;
  If Not(LogOptionsCheck.Checked) Then
  Begin
      LogLimitGroupBox.Enabled := False;
      LogSizeRadio.Enabled := False;
      LogSepRadio.Enabled := False;
      LogSizeEdit.Enabled := False;
      LogKBLabel.Enabled := False;
      LogSizeTextLabel.Enabled := False;
  End;

End;


procedure TConfigForm.LogFolderButtonClick(Sender: TObject);
begin
   If LogFolderEdit.text <> '' then
      BrowseDlg.SelectedFolder := LogFolderEdit.text;
   If (BrowseDlg.Execute) then
       LogFolderEdit.Text := BrowseDlg.SelectedFolder;
end;

procedure TConfigForm.UpdateSecurityView;
Var
  a     : Integer;
  aitem : TListItem;
Begin
  SecurityListView.Items.BeginUpdate;
  SecurityListView.Items.Clear;
  If (SecurityList.Count = 0) Then
  Begin
     SecurityListView.Items.EndUpdate;
     Exit;
  End;
  For a := 0 to (SecurityList.Count - 1) Do
  Begin
     Security := SecurityList.Items[a];
     aitem := SecurityListView.Items.Add;
     Case Security^.IPType of
           1: aitem.Caption := Security^.Net_Address;
           2: aitem.Caption := Security^.Net_Address+'  ('+ Security^.Mask_Address+')';
     End;
     // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
     Case Security^.SecurityType of
           1: aitem.ImageIndex := 0;
           2: aitem.ImageIndex := 1;
           3: aitem.ImageIndex := 3;
           4: aitem.ImageIndex := 2;
     End;
  End;
  SecurityListView.Items.EndUpdate;
End;

procedure TConfigForm.addacceptbuttonClick(Sender: TObject);
Var
  a     : Integer;
begin
  If (SecurityAddForm = Nil) then SecurityAddForm := TSecurityAddForm.Create(ConfigForm);
  If SecurityAddForm.ShowModal = MrOk Then
  Begin
     If SecurityAddForm.IPRadio.Checked Then
     Begin
        if SecurityListView.Items.Count > 0 then
          For a := 0 to (SecurityListView.Items.Count - 1) Do
            If SecurityListView.Items.Item[a].Caption = SecurityAddForm.NetEdit.Text Then
            Begin
               MessageDlg('IP Address already exists in security list.', mtError, [mbOk], 0);
               Exit;
            End;
        New(Security);
        Security^.Net_Address := SecurityAddForm.NetEdit.Text;
        Security^.Mask_Address := '255.255.255.255';
        Security^.IPType := 1;
        Security^.SecurityType := 1;
     End Else
     Begin
        if SecurityListView.Items.Count > 0 then
          For a := 0 to (SecurityListView.Items.Count - 1) Do
            If SecurityListView.Items.Item[a].Caption = (SecurityAddForm.NetEdit.Text+'  ('+ Security^.Mask_Address+')') Then
            Begin
               MessageDlg('Subnet already exists in security list.', mtError, [mbOk], 0);
               Exit;
            End;
        New(Security);
        Security^.Net_Address := SecurityAddForm.NetEdit.Text;
        Security^.Mask_Address := SecurityAddForm.MaskEdit.Text;
        Security^.IPType := 2;
        Security^.SecurityType := 1;
     End;
     SecurityList.Add(Security);
     UpdateSecurityView;
  End;
  FreeandNil(SecurityAddForm);
end;

procedure TConfigForm.UpdateItemSecurity(Idx : Integer);
Begin
   // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
   Security := SecurityList.Items[Idx];
   If (ReadCheckBox.Checked) and (WriteCheckBox.Checked) Then
       Security^.SecurityType := 4;
   If (ReadCheckBox.Checked) and Not(WriteCheckBox.Checked) Then
       Security^.SecurityType := 1;
   If Not(ReadCheckBox.Checked) and (WriteCheckBox.Checked) Then
       Security^.SecurityType := 2;
   If Not(ReadCheckBox.Checked) and Not(WriteCheckBox.Checked) Then
       Security^.SecurityType := 3;
   UpdateSecurityView;
   SecurityListView.SetFocus;
   If (SecurityListView.Items.Count > Idx) Then
   Begin
      SecurityListView.Items.Item[Idx].Selected := True;
   End;
End;

procedure TConfigForm.ReadCheckBoxClick(Sender: TObject);
begin
   If Not(SecurityClick) Then Exit;
   If ReadCheckBox.Checked Then
   Begin
      DenyCheckBox.Checked := False;
      UpdateItemSecurity(CurrentSecuritySelected);
   End;
   If Not(ReadCheckBox.Checked) and Not(WriteCheckBox.Checked) Then
   Begin
      DenyCheckBox.Checked := True;
   End;
   UpdateItemSecurity(CurrentSecuritySelected);
end;

procedure TConfigForm.WriteCheckBoxClick(Sender: TObject);
begin
   If Not(SecurityClick) Then Exit;
   If WriteCheckBox.Checked Then
   Begin
      DenyCheckBox.Checked := False;
      UpdateItemSecurity(CurrentSecuritySelected);
   End;
   If Not(ReadCheckBox.Checked) and Not(WriteCheckBox.Checked) Then
   Begin
      DenyCheckBox.Checked := True;
   End;
   UpdateItemSecurity(CurrentSecuritySelected);
end;

procedure TConfigForm.DenyCheckBoxClick(Sender: TObject);
begin
   If Not(SecurityClick) Then Exit;
   If DenyCheckBox.Checked Then
   Begin
      ReadCheckBox.Checked := False;
      WriteCheckBox.Checked := False;
      UpdateItemSecurity(CurrentSecuritySelected);
   End;
   If Not(DenyCheckBox.Checked) and Not(ReadCheckBox.Checked) and
      Not(WriteCheckBox.Checked) Then
   Begin
      DenyCheckBox.Checked := True;
   End;
   UpdateItemSecurity(CurrentSecuritySelected);
end;

procedure TConfigForm.CheckSecuritySelection;
Begin
  If (SecurityListView.SelCount <> 1) Then
  Begin
     SecurityClick          := False;
     ReadCheckBox .Checked  := False;
     ReadCheckBox.Checked   := False;
     WriteCheckBox.Checked  := False;
     DenyCheckBox.Checked   := False;
     ReadCheckBox.Enabled   := False;
     WriteCheckBox.Enabled  := False;
     DenyCheckBox.Enabled   := False;
     removeacceptbutton.Enabled := False;
     SecurityUpButton.Enabled := False;
     SecurityDownButton.Enabled := False;
     SecurityClick          := True;
     CurrentSecuritySelected := -1;
     exit;
  End;
  SecurityUpButton.Enabled := True;
  SecurityDownButton.Enabled := True;
  ReadCheckBox.Enabled := True;
  WriteCheckBox.Enabled := True;
  DenyCheckBox.Enabled := True;
  removeacceptbutton.Enabled := True;
  CurrentSecuritySelected := SecurityListView.Selected.Index;
  Security := SecurityList.Items[CurrentSecuritySelected];
  SecurityClick := False;
  // Security Type: 1 = Read, 2 = Write, 3 = Deny, 4 = Read/Write
  Case Security^.SecurityType of
             1 : Begin
                    ReadCheckBox.Checked  := True;
                    WriteCheckBox.Checked := False;
                    DenyCheckBox.Checked  := False;
                 End;
             2 : Begin
                    ReadCheckBox.Checked  := False;
                    WriteCheckBox.Checked := True;
                    DenyCheckBox.Checked  := False;
                 End;
             3 : Begin
                    ReadCheckBox.Checked  := False;
                    WriteCheckBox.Checked := False;
                    DenyCheckBox.Checked  := True;
                 End;
             4 : Begin
                    ReadCheckBox.Checked  := True;
                    WriteCheckBox.Checked := True;
                    DenyCheckBox.Checked  := False;
                 End;
  End;
  SecurityClick := True;
  SecurityListView.SetFocus;
End;

procedure TConfigForm.SecurityListViewClick(Sender: TObject);
begin
   CheckSecuritySelection;
end;

procedure TConfigForm.removeacceptbuttonClick(Sender: TObject);
begin
   If Assigned(SecurityListView.Selected) Then
   Begin
      SecurityList.Delete(SecurityListView.Selected.Index);
      SecurityList.Capacity := (SecurityList.Capacity - 1);
      UpdateSecurityView;
      CheckSecuritySelection;
   End;
end;

procedure TConfigForm.RemoveAllSecurityButtonClick(Sender: TObject);
begin
   If MessageDlg('Are you sure you want to remove all security settings?', mtWarning, [mbYes, mbNo], 0) = mrYes Then
   Begin
      SecurityList.Clear;
      UpdateSecurityView;
      CheckSecuritySelection;
   End;
end;

procedure TConfigForm.EnableSecurity;
Begin
   Case EnableSecurityRadio.Checked Of
      True : Begin
                SecurityListView.Clear;
                UpdateSecurityView;
                SecurityListView.Enabled := True;
                addacceptbutton.Enabled := True;
                RemoveAllSecurityButton.Enabled := True;
                SecurityUpButton.enabled := False;
                SecurityDownButton.enabled := False;
                ReadCheckBox.Enabled := False;
                WriteCheckBox.Enabled := False;
                DenyCheckBox.Enabled := False;
                SecurityPanel.Enabled := True;
             End;
      False: Begin
                SecurityListView.Clear;
                SecurityListView.Enabled := False;
                addacceptbutton.Enabled := False;
                removeacceptbutton.Enabled := False;
                RemoveAllSecurityButton.Enabled := False;
                SecurityUpButton.enabled := False;
                SecurityDownButton.enabled := False;
                ReadCheckBox.Enabled := False;
                WriteCheckBox.Enabled := False;
                DenyCheckBox.Enabled := False;
                SecurityPanel.Enabled := False;
             End;
      End;
End;

procedure TConfigForm.DisableSecurityRadioClick(Sender: TObject);
begin
   EnableSecurity;
end;

procedure TConfigForm.EnableSecurityRadioClick(Sender: TObject);
begin
   EnableSecurity;
end;

procedure TConfigForm.SecurityUpButtonClick(Sender: TObject);
begin
   If (CurrentSecuritySelected = 0) Then
   Begin
      SecurityListView.SetFocus;
      SecurityListView.Items.Item[CurrentSecuritySelected].Selected := True;
      Exit;
   End;
   SecurityList.Exchange(CurrentSecuritySelected,(CurrentSecuritySelected-1));
   UpdateSecurityView;
   Dec(CurrentSecuritySelected);
   SecurityListView.SetFocus;
   SecurityListView.Items.Item[CurrentSecuritySelected].Selected := True;
end;

procedure TConfigForm.SecurityDownButtonClick(Sender: TObject);
begin
   If (CurrentSecuritySelected >= (SecurityListView.Items.Count-1)) Then
   Begin
      SecurityListView.SetFocus;
      SecurityListView.Items.Item[CurrentSecuritySelected].Selected := True;
      Exit;
   End;
   SecurityList.Exchange(CurrentSecuritySelected,(CurrentSecuritySelected+1));
   UpdateSecurityView;
   Inc(CurrentSecuritySelected);
   SecurityListView.SetFocus;
   SecurityListView.Items.Item[CurrentSecuritySelected].Selected := True;
end;

procedure TConfigForm.SaveSecurityList;
Var
  SecFile: TFileStream;
  a      : Integer;
Begin
   a := 0;
   SecFile := TFileStream.Create(ChangeFileExt(Application.ExeName,'.SEC'),fmCreate);
   Try
     While (a < SecurityList.Count) Do
     Begin
       Security := SecurityList.Items[a];
       SecFile.Write(Security^, Sizeof(Security^));
       Inc(a);
     End;
   Finally
     SecFile.Free;
   End;
End;

procedure TConfigForm.LoadSecurityList;
Var
  SecFile: TFileStream;
Begin
   If Not(FileExists(ChangeFileExt(Application.ExeName,'.SEC'))) Then Exit;
   SecFile := TFileStream.Create(ChangeFileExt(Application.ExeName,'.SEC'),fmOpenRead);
   SecFile.Position := 0;
   Try
     While (SecFile.Position < Secfile.Size) Do
     Begin
       New(Security);
       SecFile.Read(Security^, Sizeof(SecurityRec));
       SecurityList.Add(Security);
     End;
   Finally
     SecFile.Free;
     UpdateSecurityView;
   End;
End;

procedure TConfigForm.AutoRefreshCheckClick(Sender: TObject);
begin
   Case AutoRefreshCheck.Checked of
         True : Begin
                   RefreshTimeEdit.Enabled := True;
                   RefreshMinuteLabel.Enabled := True;
         End;
         False : Begin
                   RefreshTimeEdit.Enabled := False;
                   RefreshMinuteLabel.Enabled := False;
         End;
   End;

end;

procedure TConfigForm.FormShow(Sender: TObject);
begin
    If Not(MainUnit.Unlimited) Then
    Begin
       MaxULConnectEdit.Value := 1;
       MaxULConnectEdit.Enabled := False;
       MaxDLConnectEdit.Value := 1;
       MaxDLConnectEdit.Enabled := False;
       RestrictLabel1.Enabled := False;
       RestrictLabel2.Enabled := False;
       RestrictLabel4.Enabled := False;
       RestrictLabel.Visible := True;
       //RestrictLabel.Show;
    End Else
    Begin
       //MaxULConnectEdit.Value := 1;
       MaxULConnectEdit.Enabled := True;
       //MaxDLConnectEdit.Value := 1;
       MaxDLConnectEdit.Enabled := True;
       RestrictLabel1.Enabled := True;
       RestrictLabel2.Enabled := True;
       RestrictLabel4.Enabled := True;
       RestrictLabel.Visible := False;
    End;
    ConfigTree.AutoExpand := True;
    ConfigTree.Items.Item[1].Selected := True;
    ConfigTree.SetFocus;
    PageControl1.ActivePageIndex := 0;
end;

procedure TConfigForm.ConfigTreeClick(Sender: TObject);
begin
   Case ConfigTree.Selected.Index of
        0     : PageControl1.ActivePageIndex := 0;
        1     : PageControl1.ActivePageIndex := 1;
        2     : PageControl1.ActivePageIndex := 2;
        3     : PageControl1.ActivePageIndex := 4;
        4     : PageControl1.ActivePageIndex := 5;
        5     : PageControl1.ActivePageIndex := 3;
   End;
end;

procedure TConfigForm.StartOnStartUpCheckClick(Sender: TObject);
begin
   CheckStartOnStartupCheck;
end;

Procedure TConfigForm.CheckStartOnStartupCheck;
Begin
   Case StartOnStartUpCheck.Checked Of
            True  : MinOnStartupCheck.Enabled := True;
            False : Begin
                       MinOnStartupCheck.Checked := False;
                       MinOnStartupCheck.Enabled := False;
                    End;
   End;
End;

Procedure TConfigForm.CheckStartOnStartup;
var
  Reg: TRegistry;
begin
  If StartOnStartupCheck.Checked Then
  Begin
     Reg := TRegistry.Create;
     try
       Reg.RootKey := HKEY_LOCAL_MACHINE;
       if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
       begin
          Reg.WriteString('QuickTFTP','"' + Application.ExeName + '" -cm');
          Reg.CloseKey;
       end;
       finally
          Reg.Free;
          inherited;
       end;
  End Else
  Begin
     Reg := TRegistry.Create;
     try
       Reg.RootKey := HKEY_LOCAL_MACHINE;
       if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
       begin
          Reg.DeleteValue('QuickTFTP');
          Reg.CloseKey;
       end;
       finally
          Reg.Free;
          inherited;
       end;
  End;
end;



procedure TConfigForm.EnableFirewallCheckClick(Sender: TObject);
begin
   If (EnableFirewallCheck.Checked) Then
   Begin
      MaxLabel.Enabled := true;
      MinLabel.Enabled := true;
      MaxPortEdit.Enabled := true;
      MinPortEdit.Enabled := true;
   End Else
   Begin
      MaxLabel.Enabled := false;
      MinLabel.Enabled := false;
      MaxPortEdit.Enabled := false;
      MinPortEdit.Enabled := false;
   End;
end;

procedure TConfigForm.MaxPortEditExit(Sender: TObject);
begin
  If (MaxPortEdit.Value < MinPortEdit.Value) Then
      MaxPortEdit.Value := MinPortEdit.Value;
end;

procedure TConfigForm.MinPortEditExit(Sender: TObject);
begin
  If (MinPortEdit.Value > MaxPortEdit.Value) Then
      MinPortEdit.Value := MaxPortEdit.Value;
end;

end.
