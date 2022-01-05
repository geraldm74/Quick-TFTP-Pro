object SecurityAddForm: TSecurityAddForm
  Left = 247
  Top = 783
  BorderStyle = bsDialog
  Caption = 'Add IP/Subnet'
  ClientHeight = 161
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 64
    Width = 57
    Height = 13
    Caption = 'Network ID:'
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 66
    Height = 13
    Caption = 'Subnet Mask:'
  end
  object IPRadio: TRadioButton
    Left = 8
    Top = 8
    Width = 137
    Height = 17
    Caption = 'Add single IP address'
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = IPRadioClick
  end
  object SubnetRadio: TRadioButton
    Left = 8
    Top = 32
    Width = 145
    Height = 17
    Caption = 'Add Subnet'
    TabOrder = 3
    TabStop = True
    OnClick = SubnetRadioClick
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 128
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000010000FF00FF00004B
      0000098611000A8615000D931A000C9518000C9C19000F991C000E9D1D001392
      240011A0210011A422001CA134001CB1350024BC430029B548002EC6520035CA
      5E0039D465000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000001
      0100000000000000000000000000010808010000000000000000000000010D0B
      080B0100000000000000000001100E0901040801000000000000000111120C01
      000103080100000000000000010F010000000001040100000000000000010000
      0000000001030100000000000000000000000000000001010000000000000000
      0000000000000001010000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
  end
  object BitBtn2: TBitBtn
    Left = 128
    Top = 128
    Width = 91
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000010000FF00FF000000
      9A00012AF200002CF600002CF8000733F6000031FE000431FE000134FF000C3C
      FF00123BF100103BF400143EF400103DFB001743F6001B46F6001C47F6001D48
      F6001342FF001A47F8001847FF00174AFD001A48F9001D4BFF001A4CFF001D50
      FF00224DF100224CF400204BF800214CF800214EFC002550F4002D59F4002655
      FA002355FF002659FF002E5BF9002C5FFF00325DF1003B66F3003664FA00386B
      FF004071FA004274FF00497AFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010100
      00000000000101000000000001150B010000000001040601000000000113180B
      010000010306030100000000000110180B010104060301000000000000000111
      190D060603010000000000000000000118120D05010000000000000000000001
      1D181312010000000000000000000124241D1D19110100000000000000012829
      2401011F191F010000000000012A2A26010000011F231D0100000000012C2701
      00000000011F1901000000000001010000000000000101000000000000000000
      0000000000000000000000000000000000000000000000000000}
  end
  object NetEdit: CEditIPAddr
    Left = 88
    Top = 60
    Width = 100
    Height = 21
    Constraints.MinWidth = 100
    TabOrder = 0
  end
  object MaskEdit: CEditIPAddr
    Left = 88
    Top = 84
    Width = 100
    Height = 21
    Constraints.MinWidth = 100
    TabOrder = 1
  end
end
