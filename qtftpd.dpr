program qtftpd;

uses
  Forms,
  Windows,
  MainUnit in 'MainUnit.pas' {MainForm},
  ConfigUnit in 'ConfigUnit.pas' {ConfigForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  RegUnit in 'RegUnit.pas' {RegForm},
  TipUnit in 'TipUnit.pas' {TipsForm},
  SecurityAddUnit in 'SecurityAddUnit.pas' {SecurityAddForm},
  FileinfoUnit in 'FileinfoUnit.pas' {FileInfoForm},
  TransferWindowUnit in 'TransferWindowUnit.pas' {TransferWindowForm};

{$R *.res}
{$D-,L-,O+,Q-,R-,Y-,S-}

var
	MutexHandle: THandle;
	hwind:HWND;

begin
	MutexHandle := CreateMutex(nil, TRUE, 'MysampleAppMutex'); // should be a unique string
	IF MutexHandle <> 0 then
    begin
		IF GetLastError = ERROR_ALREADY_EXISTS then
		begin
		  MessageBox(0, 'An instance of this application is already running.',
		  	'Quick TFTP Server already running', mb_IconHand);
		  CloseHandle(MutexHandle);
		  hwind := 0;
		  repeat
         hwind:=Windows.FindWindowEx(0,hwind,'TApplication','Quick TFTP Server');
		  until (hwind<>Application.Handle);
      IF (hwind<>0) then
      begin
         Windows.ShowWindow(hwind,SW_SHOWNORMAL);
			   Windows.SetForegroundWindow(hwind);
      end;
      Halt;
		end
	end;
  Application.Initialize;
  Application.Title := 'QuickTFTP Desktop Pro';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
