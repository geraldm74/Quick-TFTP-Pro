unit SecurityAddUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Math, UEditIPAddr;

type
  TSecurityAddForm = class(TForm)
    IPRadio: TRadioButton;
    SubnetRadio: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    NetEdit: CEditIPAddr;
    MaskEdit: CEditIPAddr;
    procedure IPRadioClick(Sender: TObject);
    procedure SubnetRadioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure CheckOptions;
    Function  CheckSubnet(octsused : Integer) : Boolean;
  public
    { Public declarations }
  end;

var
  SecurityAddForm                      : TSecurityAddForm;
  NetOct1,NetOct2,NetOct3,NetOct4      : Integer;
  MaskOct1,MaskOct2,MaskOct3,MaskOct4  : Integer;

implementation

{$R *.dfm}

procedure TSecurityAddForm.CheckOptions;
Begin
    If (IPRadio.Checked) Then
    Begin
       Label1.Caption := 'IP Address:';
       Label2.Hide;
       MaskEdit.Hide;
    End Else
    Begin
       Label1.Caption := 'Network ID:';
       Label2.Show;
       MaskEdit.Show;
    End;
End;

procedure TSecurityAddForm.IPRadioClick(Sender: TObject);
begin
   CheckOptions;
end;

procedure TSecurityAddForm.SubnetRadioClick(Sender: TObject);
begin
   CheckOptions;
end;

procedure TSecurityAddForm.FormShow(Sender: TObject);
begin
   CheckOptions;
end;


Function TSecurityAddForm.CheckSubnet(octsused : Integer) : Boolean;
Var
  StartSubnet : Extended;
  MaxSubnets  : Extended;
  IsValid     : Boolean;
  i           : Extended;
Begin
  IsValid     := True;
  StartSubnet := 0;
  MaxSubnets  := 0;
  Case octsused of
        1 : StartSubnet := 256 - MaskOct1;
        2 : StartSubnet := 256 - MaskOct2;
        3 : StartSubnet := 256 - MaskOct3;
        4 : StartSubnet := 256 - MaskOct4;
  End;
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
  I := 0;
  While (I < (StartSubnet*MaxSubnets)) and Not(IsValid) Do
  Begin
     i := i + StartSubnet;
     Case octsused of
       1 : If (NetOct1 = I) Then IsValid := True;
       2 : If (NetOct2 = I) Then IsValid := True;
       3 : If (NetOct3 = I) Then IsValid := True;
       4 : If (NetOct4 = I) Then IsValid := True;
     End;
  End;
  If Not(IsValid) Then Result := False
  Else Result := True;
End;

procedure TSecurityAddForm.BitBtn1Click(Sender: TObject);
Var
  OkOct1, OkOct2, OkOct3, OkOct4 : Boolean;
  IsValid : Boolean;
  a,b : Integer;
  tmpstr : String;
begin
   OkOct1 := False;
   OkOct2 := False;
   OkOct3 := False;
   OkOct4 := False;
   If (SubnetRadio.Checked) Then
   Begin
      tmpstr := MaskEdit.Text;
      a := pos('.',tmpstr);
      If strtoint(copy(tmpstr,1,(a-1))) In [255,254,252,248,240,224,192,128,0] Then
      Begin
         OkOct1 := True;
         MaskOct1 := strtoint(copy(tmpstr,1,(a-1)));
      End;
      tmpstr[a] := ',';
      b := pos('.',tmpstr);
      If strtoint(copy(tmpstr,a+1,(b-a-1))) In [255,254,252,248,240,224,192,128,0] Then
      Begin
         OkOct2 := True;
         MaskOct2 := strtoint(copy(tmpstr,a+1,(b-a-1)));
      End;
      a := b;
      tmpstr[a] := ',';
      b := pos('.',tmpstr);
      If strtoint(copy(tmpstr,a+1,(b-a-1))) In [255,254,252,248,240,224,192,128,0] Then
      Begin
         OkOct3 := True;
         MaskOct3 := strtoint(copy(tmpstr,a+1,(b-a-1)));
      End;
      tmpstr[b] := ',';
      If strtoint(copy(tmpstr,b+1,length(tmpstr))) In [255,254,252,248,240,224,192,128,0] Then
      Begin
         OkOct4 := True;
         MaskOct4 := strtoint(copy(tmpstr,b+1,length(tmpstr)));
      End;
      If Not(OkOct1) or Not(OkOct2) or Not(OkOct3) or Not(OkOct4) Then
      Begin
         MessageDlg('Invalid Subnet mask!'+#13+'Please type in a correct subnet mask.', mtError, [mbOk], 0);
         Exit;
      End;
      // Get IP Address
      tmpstr := NetEdit.Text;
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

      If (MaskOct1 <> 255) Then IsValid := CheckSubnet(1)
      Else
      If (MaskOct1 = 255) and (MaskOct2 <> 255) Then IsValid := CheckSubnet(2)
      Else
      If (MaskOct1 = 255) and (MaskOct2 = 255) and
         (MaskOct3 <> 255) Then IsValid := CheckSubnet(3)
      Else IsValid := CheckSubnet(4);
      If Not(IsValid) Then
      Begin
         MessageDlg('Invalid Subnet ID!'+#13+'Please type in a correct subnet ID.', mtError, [mbOk], 0);
         Exit;
      End;
      ModalResult := MrOk;
      Exit;
   End Else
   Begin
      tmpstr := NetEdit.Text;
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
      If (NetOct1 in [0,255]) or (NetOct2 = 255) or (NetOct3 = 255) or (NetOct4 in [0,255]) Then
      Begin
         MessageDlg('Invalid IP Address!'+#13+'Please type in a correct IP Address.', mtError, [mbOk], 0);
         Exit;
      End;
   End;
   ModalResult := MrOk;
   Exit;
end;

end.
