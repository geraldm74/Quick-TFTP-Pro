object ConfigForm: TConfigForm
  Left = 383
  Top = 606
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 500
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000033
    3333333333333333333333000000003333333333333333333333330000003333
    8888888888888888888833330000333388888888888888888888333300003333
    88888888888888888888BB330000333388888888888888888888BB3300003333
    BB888888888888888888BB3300003333BB888888888888888888BB33000033BB
    33FF8888888888882222BB88330033BB33FF8888888888882222BB8833003388
    3322222222888822222222883300338833222222228888222222228833003388
    3322222222FF222222222222330033883322222222FF22222222222233003388
    BB222222222222222222222222003388BB222222222222222222222222003388
    88222222222222222222222222003388882222222222222222222222220033FF
    8822222222333322AAAA2200000033FF8822222222333322AAAA220000000022
    2222AAAA22222222AAAA2200000000222222AAAA22222222AAAA220000000022
    AAAAAAAAAAAA2222AAAA220000000022AAAAAAAAAAAA2222AAAA220000000000
    22AAAAAAAA220022AAAA22000000000022AAAAAAAA220022AAAA220000000000
    0022AAAA2200002222222200000000000022AAAA220000222222220000000000
    0000222200000000000000000000000000002222000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000300000003C0000003C0000003C000
    0003C0000003F0000003F0000003FC000003FC000003FF00FFFFFF00FFFF}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    614
    500)
  PixelsPerInch = 96
  TextHeight = 13
  object SaveButton: TBitBtn
    Left = 394
    Top = 466
    Width = 103
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Save && Close'
    ModalResult = 1
    TabOrder = 0
    OnClick = SaveButtonClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000010000000000000101
      0100020202000303030004040400050505000606060007070700080808000909
      09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
      1100121212001313130014141400151515001616160017171700181818001919
      19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
      2100222222002323230024242400252525002626260027272700282828002929
      29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
      3100323232003333330034343400353535003636360037373700383838003939
      39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
      710072727200737373007474740075757500767676006F766F00697569006375
      630052735200407140002E6E2E00226C2200196A190010691000096809000467
      04000268020001690100006A0000006A0000006A000000690000006800000067
      000000670000006700000067000000670000006600000066000000680000006E
      000000740000007D0000008B0000009400000096000000970000009800000098
      0000009800000098000000980000009800000098000000970000009700000096
      00000094000000920000008F0000048E04000B8E0B00138E13001F8E1F003393
      33004C994A00629F5F0072A46E0081A97B008FAB87009BAD9100A4AE9700AAAC
      9C00ADB2A100B0B6A500B2BAA900B3BFAC00B4C1AE00B4C4AF00B4C6B000B5C6
      B100B6C5B200B9C7B500BCC8B900C0C9BD00C4CBC300C8CCC800CACCC900CBCC
      CB00CCCCCB00CCCCCC00CDCCCC00CDCCCC00CDCCCD00CDCCCD00CDCBCD00CECA
      CD00CEC8CE00D1BFD000D5B2D400D9A2D800DE8FDD00E37BE200E963E800EE4F
      ED00F337F200F628F600F919F900FC0CFC00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01FE00FE03FE00FC10
      FC00FA28F900F54CF500F170F100ED8FED00EAB0EA00E7C6E800E5D4E600E4DC
      E500E5E1E500E5E4E600E7E6E700E8E7E900ECECED00F0F0F000F3F3F300F6F6
      F600F8F7F700F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800DEDEDEDEDEDE
      DEDEDEDEDEDEDEDEDEDEDEDE8F8FB1B1B1B1B1B1B18F8FDEDEDEDE8F9999F28F
      8FF4F3F2C38F938FDEDEDE8F9999F28F8FF2F4F2C78F938FDEDEDE8F9999F38F
      8FF1F4F3C68F938FDEDEDE8F9999F4F4F2F1F2F2C68F938FDEDEDE8F99999999
      999999999999998FDEDEDE8F99B8B8B8B8B8B8B8B8B8998FDEDEDE8F99FFFFFF
      FFFFFFFFFFFF998FDEDEDE8F99FFFFFFFFFFFFFFFFFF998FDEDEDE8F99FFC6C6
      C6C6C6C6C6FF998FDEDEDE8F99FFFFFFFFFFFFFFFFFF998FDEDEDE8F99FFC6C6
      C6C6C6C6C6FF998FDEDEDE8F99FFFFFFFFFFFFFFFFFF998FDEDEDEDE8FFFFFFF
      FFFFFFFFFFFF8FDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE}
  end
  object CloseButton: TBitBtn
    Left = 506
    Top = 466
    Width = 103
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
    OnClick = CloseButtonClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000000000000000000000010000000100000523F5000320
      F4000220F3000320F000031FED000320EA00031FE700031EE300031FDD00031F
      D600031ED200031ECD00031EC800041EC300031DBF00031CBB00011CB800011C
      B600011CB500011DB300011CB200011CB200011BB100011AB0000119AF000115
      AC000113A9000111A500010B9A000006910000038B0000028900000288000002
      88000002890000038B0000048C0001058F0002089300050D9A000B16A6001322
      B7001B30C900253DD6002E4AE400314FE8003453EB003857ED003656EF003655
      EE003454EF003352EF002F4EEF002F4DE9002D4AE2002C47DA002D47D0002E45
      C1003144AA003443960035438A0037427C0039426D003C415C003F414A004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
      7100727272007373730074747400757575007676760077777700787878007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
      8100828282008383830084848400858585008686860087878700888888008989
      89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
      9100929292009393930094949400959595009696960097979700989898009999
      99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
      A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
      A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
      B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
      B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C4C4C400C8C8
      C800CCCCCC00D0D0D000D6D6D600DCDCDC00E0E0E000E7E7E700ECECEC00F0F0
      F000F4F4F400F7F7F700FAFAFA00FAFBFB00FBFCFC00FBFBFC00FBFBFC00F9FA
      FD00F8F9FD00F7F8FD00F5F6FD00F2F4FC00EEF1FC00EAEEFC00E6EAFC00E1E6
      FC00DBE2FB00D6DDFB00D3DBFB00D0D9FB00C7D1F900BAC6F800B0BFF800AABA
      F800A6B7F800A0B2F8009BAEF80095A9F70092A6F6008FA4F6008EA2F7008B9F
      F800899CFA008798F9008695F9008291F900818DF9008288F9008881F9009277
      F900A567FA00BA4EFA00DA2BFB00EB16FD00FC03FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FBFBFBFBFB21
      261C1C2622FBFBFBFBFBFBFBFB201C1513121213151B21FBFBFBFBFB23181113
      1313131313131824FBFBFB200F0B0E19171313151916131721FBFB1B080A0B2F
      29181813382916121BFB2008040831CEE20F18E9CE38191315221C02010607EE
      CEE3E6CEE713161313261A0000010407EECECEE512181313121C193400010104
      E8CECEE20D111313121C1C2F340100E9CEE7EDCEE30C101313261F34ED0032CE
      E60206EECE2F0E0E1521FB0FEBEE0030000101042E080A0B1BFBFB1F2CE2EB34
      000101010406070E20FBFBFB252CE5E1EE2F303334000B23FBFBFBFBFB1F0E2F
      EFEEF02F051220FBFBFBFBFBFBFBFB1F1B19191C20FBFBFBFBFB}
  end
  object PageControl1: TPageControl
    Left = 176
    Top = 0
    Width = 433
    Height = 465
    ActivePage = TabSheet6
    Align = alCustom
    Style = tsFlatButtons
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'General'
      TabVisible = False
      object LMDFill2: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label8: TLabel
        Left = 8
        Top = 8
        Width = 95
        Height = 13
        Caption = 'General Settings'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 8
        Top = 24
        Width = 146
        Height = 13
        Caption = 'Configure general settings here'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 89
        Caption = 'General Settings'
        TabOrder = 0
        object StartOnStartUpCheck: TCheckBox
          Left = 24
          Top = 32
          Width = 249
          Height = 17
          Caption = 'Automatically start application on system startup.'
          TabOrder = 0
          OnClick = StartOnStartUpCheckClick
        end
        object MinOnStartupCheck: TCheckBox
          Left = 40
          Top = 56
          Width = 121
          Height = 17
          Caption = 'Minimize on startup.'
          Enabled = False
          TabOrder = 1
        end
        object GroupBox2: TGroupBox
          Left = 88
          Top = 203
          Width = 329
          Height = 7
          TabOrder = 2
        end
      end
      object GroupBox12: TGroupBox
        Left = 0
        Top = 280
        Width = 425
        Height = 81
        Caption = 'Refresh Settings'
        TabOrder = 1
        object RefreshMinuteLabel: TLabel
          Left = 289
          Top = 26
          Width = 39
          Height = 13
          Caption = 'minutes.'
          Enabled = False
        end
        object RemovedeadfilesCheck: TCheckBox
          Left = 32
          Top = 48
          Width = 313
          Height = 17
          Caption = 'Remove files from the list which have been moved or deleted.'
          TabOrder = 0
        end
        object AutoRefreshCheck: TCheckBox
          Left = 32
          Top = 24
          Width = 201
          Height = 17
          Caption = 'Automatically refresh the files list every:'
          TabOrder = 1
          OnClick = AutoRefreshCheckClick
        end
        object RefreshTimeEdit: TLMDSpinEdit
          Left = 240
          Top = 20
          Width = 41
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          Enabled = False
          TabOrder = 2
          AutoSelect = True
          CustomButtons = <>
          MinValue = 1
          MaxValue = 60
          Value = 1
          DateTime = 0.000000000000000000
        end
      end
      object GroupBox13: TGroupBox
        Left = 0
        Top = 168
        Width = 425
        Height = 105
        Caption = 'File List Settings'
        TabOrder = 2
        object RefreshAfterLoadCheck: TCheckBox
          Left = 16
          Top = 72
          Width = 241
          Height = 17
          Caption = 'Refresh the Files List after a files list is opened.'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object LoadonstartupCheck: TCheckBox
          Left = 16
          Top = 48
          Width = 185
          Height = 17
          Caption = 'Open last saved files list on startup.'
          TabOrder = 1
        end
        object AutoStartTFTPCheck: TCheckBox
          Left = 16
          Top = 24
          Width = 193
          Height = 17
          Caption = 'Start TFTP after opening a files list.'
          TabOrder = 2
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Connection'
      ImageIndex = 5
      TabVisible = False
      object LMDFill1: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label13: TLabel
        Left = 8
        Top = 8
        Width = 115
        Height = 13
        Caption = 'Connection Settings'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 8
        Top = 24
        Width = 239
        Height = 26
        Caption = 
          'Configure connection settings here including TFTP'#13#10'and Firewall ' +
          'options.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 89
        Caption = 'Connection limits'
        TabOrder = 0
        object RestrictLabel4: TLabel
          Left = 341
          Top = 56
          Width = 65
          Height = 13
          Caption = '(0 = unlimited)'
        end
        object RestrictLabel2: TLabel
          Left = 202
          Top = 56
          Width = 42
          Height = 13
          Caption = 'Uploads:'
        end
        object RestrictLabel1: TLabel
          Left = 60
          Top = 56
          Width = 56
          Height = 13
          Caption = 'Downloads:'
        end
        object RestrictLabel: TLabel
          Left = 209
          Top = 24
          Width = 192
          Height = 13
          Caption = '( Disabled until this product is registered )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label15: TLabel
          Left = 23
          Top = 24
          Width = 176
          Height = 13
          Caption = 'Restrict simultaneous connections to:'
        end
        object MaxULConnectEdit: TLMDSpinEdit
          Left = 251
          Top = 52
          Width = 57
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          TabOrder = 0
          MaxLength = 5
          AutoSelect = True
          CustomButtons = <>
          MaxValue = 65500
          DateTime = 0.000000000000000000
        end
        object MaxDLConnectEdit: TLMDSpinEdit
          Left = 123
          Top = 52
          Width = 57
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          TabOrder = 1
          MaxLength = 5
          AutoSelect = True
          CustomButtons = <>
          MaxValue = 65500
          DateTime = 0.000000000000000000
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 168
        Width = 425
        Height = 121
        Caption = 'TFTP Settings'
        TabOrder = 1
        object Label9: TLabel
          Left = 237
          Top = 88
          Width = 42
          Height = 13
          Caption = 'Seconds'
        end
        object Label7: TLabel
          Left = 125
          Top = 88
          Width = 41
          Height = 13
          Caption = 'Timeout:'
        end
        object Label6: TLabel
          Left = 237
          Top = 56
          Width = 26
          Height = 13
          Caption = 'Bytes'
        end
        object Label5: TLabel
          Left = 112
          Top = 56
          Width = 54
          Height = 13
          Caption = 'Buffer Size:'
        end
        object Label4: TLabel
          Left = 237
          Top = 24
          Width = 92
          Height = 13
          Caption = '(TFTP default = 69)'
        end
        object Label3: TLabel
          Left = 63
          Top = 24
          Width = 103
          Height = 13
          Caption = 'UDP connection port:'
        end
        object PortEdit: TLMDSpinEdit
          Left = 171
          Top = 20
          Width = 57
          Height = 21
          Hint = 'Select a port number to use.'
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          AutoSelect = True
          CustomButtons = <>
          MaxValue = 65535
          Value = 69
          DateTime = 0.000000000000000000
        end
        object BufferSizeEdit: TLMDSpinEdit
          Left = 171
          Top = 52
          Width = 57
          Height = 21
          Hint = 'Select a receive buffer size to use.'
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoSelect = True
          CustomButtons = <>
          MinValue = 100
          MaxValue = 99999
          Value = 8192
          DateTime = 0.000000000000000000
        end
        object TimeoutEdit: TLMDSpinEdit
          Left = 171
          Top = 84
          Width = 57
          Height = 21
          Hint = 'Select a timeout period.'
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          AutoSelect = True
          CustomButtons = <>
          MinValue = 1
          MaxValue = 60
          Value = 3
          DateTime = 0.000000000000000000
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 392
        Width = 425
        Height = 57
        Caption = 'TFTP Options'
        TabOrder = 2
        object TSizeCheck: TCheckBox
          Left = 184
          Top = 24
          Width = 97
          Height = 17
          Caption = 'TSIZE option'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object TimeoutCheck: TCheckBox
          Left = 56
          Top = 24
          Width = 113
          Height = 17
          Caption = 'TIMEOUT option'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox1: TCheckBox
          Left = 288
          Top = 24
          Width = 105
          Height = 17
          Caption = 'BlockSize Option'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 2
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 296
        Width = 425
        Height = 89
        Caption = 'Firewall Ports'
        TabOrder = 3
        object MaxLabel: TLabel
          Left = 240
          Top = 52
          Width = 47
          Height = 13
          Caption = 'Maximum:'
          Enabled = False
        end
        object MinLabel: TLabel
          Left = 115
          Top = 52
          Width = 44
          Height = 13
          Caption = 'Minimum:'
          Enabled = False
        end
        object EnableFirewallCheck: TCheckBox
          Left = 56
          Top = 24
          Width = 129
          Height = 17
          Caption = 'Enable port restrictions'
          TabOrder = 0
          OnClick = EnableFirewallCheckClick
        end
        object MaxPortEdit: TLMDSpinEdit
          Left = 296
          Top = 48
          Width = 57
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          Enabled = False
          TabOrder = 1
          OnExit = MaxPortEditExit
          AutoSelect = True
          CustomButtons = <>
          Interval = 1
          MaxValue = 65535
          Value = 65535
          DateTime = 0.000000000000000000
        end
        object MinPortEdit: TLMDSpinEdit
          Left = 168
          Top = 48
          Width = 57
          Height = 21
          Bevel.Mode = bmWindows
          Caret.BlinkRate = 530
          Enabled = False
          TabOrder = 2
          OnExit = MinPortEditExit
          AutoSelect = True
          CustomButtons = <>
          Interval = 1
          MaxValue = 65535
          Value = 1025
          DateTime = 0.000000000000000000
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'IP Addresses'
      ImageIndex = 1
      TabVisible = False
      object LMDFill3: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label11: TLabel
        Left = 8
        Top = 8
        Width = 125
        Height = 13
        Caption = 'IP Addresses Settings'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 8
        Top = 24
        Width = 276
        Height = 26
        Caption = 
          'Select the local IP address(es) you wish the TFTP protocol'#13#10'to l' +
          'isten for incomming connections on.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox8: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 257
        Caption = 'IP Addresses'
        TabOrder = 0
        object Label2: TLabel
          Left = 15
          Top = 23
          Width = 140
          Height = 13
          Caption = 'List of available IP addresses:'
        end
        object Label1: TLabel
          Left = 261
          Top = 23
          Width = 151
          Height = 13
          Caption = 'Bind to only these IP addresses:'
        end
        object AvailIPList: TListBox
          Left = 263
          Top = 36
          Width = 146
          Height = 205
          Cursor = crHandPoint
          Hint = 'List of available IP addresses to bind to.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          MultiSelect = True
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Removebutton: TBitBtn
          Left = 169
          Top = 46
          Width = 88
          Height = 27
          Hint = 'Remove IP address from binding list'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = RemovebuttonClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF013002014103025104025104014303013302FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF014503014503037808039C0B03
            9F0C039F0C039D0C027E09014D04014D04FF00FFFF00FFFF00FFFF00FFFF00FF
            034F0903650904A30D03A60C03A00B029E0A039F0C03A00C03A50C03A60C0269
            06013402FF00FFFF00FFFF00FF044F09066B110AAB1F07A415049E0D029D0A03
            9D0A039E0C039E0C039E0C03A00C03A70C026A06024C04FF00FFFF00FF044F09
            10AC300DAB2809A41C039E0F16AA20D5F2D8E9F8EA48C052039E0C039E0C039F
            0C03A70C024C04FF00FF0357060D822317B6410EA92D05A013049F0D07A01182
            D589FFFFFFF4FCF640BC4A039E0C039E0C03A50C037B0801420303570617A341
            18B54A11AB3406A011039E0C049F0D039E0C74D07DFCFEFCF3FBF43EBC48039E
            0C03A10C03960A01420306680D21B1511EB751BFEDCFBAEAC6B7E9C2B8EAC5B5
            E9C2B7E9C1F6FCF7FFFFFFEEFAEF54C55E03A00C039F0C014A040874123EBD69
            2ABA5CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFCFFFFFFFFFFFFAAE3
            B003A00C039F0C02520506780E54C57A44C67452C77D57CA8156CA8057CA8149
            C57379D592FAFEFAFFFFFF97DDA51AAD3307A518039D0C01460306780E4CBD69
            83DDA722B6551CB24E22B55422B55455CA7FE1F6E9FFFFFF88D99D10AB2F0CA6
            2706A716038C0A014603FF00FF139923AAE7C568D08E16AF481BB14C39BF68F4
            FCF7FFFFFF84D99E11AA320EA7290BA42009AF1C036B0AFF00FFFF00FF139923
            56C573C5F0D866CF8C20B45223B554AAE6C096DEB119B14813AC3C12AA340FB0
            2D0A991F036B0AFF00FFFF00FFFF00FF1399236ACC88D0F4E39AE1B650C77A38
            BD672CBA5D30BB602FBC5D23BC4F11A33006620FFF00FFFF00FFFF00FFFF00FF
            FF00FF13992313992398E1B5BDEED4A7E7C490E0B178D99F49C7791B9D3D1B9D
            3DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1DA43513992313
            9923139923139923138C2AFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object AddButton: TBitBtn
          Left = 168
          Top = 84
          Width = 89
          Height = 29
          Hint = 'Add IP address to binding list'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = AddButtonClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF013002014103025104025104014303013302FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF014503014503037808039C0B03
            9F0C039F0C039D0C027E09014D04014D04FF00FFFF00FFFF00FFFF00FFFF00FF
            034F0903650904A30D03A60C03A00B029E0A039F0C03A00C03A50C03A60C0269
            06013402FF00FFFF00FFFF00FF044F09066B110AAB1F07A415049E0D029D0A03
            9D0A039E0C039E0C039E0C03A00C03A70C026A06024C04FF00FFFF00FF044F09
            10AC300DAB2809A41C039E0F48C052E9F8EAD5F2D816AA20039E0C039E0C039F
            0C03A70C024C04FF00FF0357060D822317B6410EA92D05A01341BD4BF4FCF6FF
            FFFF82D58907A010039E0C039E0C039E0C03A50C037B0801420303570617A341
            18B54A11AB3441BD4EF3FBF4FCFEFC75D07D039E0C039E0C039E0C039E0C039E
            0C03A10C03960A01420306680D21B1511EB75170D392F0FBF3FFFFFFF7FCF8B7
            E9C5B4E7BDADE5B2ADE5B2AFE5B4B1E6B603A00C039F0C014A040874123EBD69
            2ABA5CBAEACCFFFFFFFFFFFFFCFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF03A00C039F0C02520506780E54C57A44C6742CBA5CA4E3BCFFFFFFFAFEFB82
            D9A03EBF5E41C05B41BF5B41BF5841BF5707A518039D0C01460306780E4CBD69
            83DDA722B6551DB24F95DEB0FFFFFFE2F7EA4FC67511AB340FAA300FAA2E0CA6
            2706A716038C0A014603FF00FF139923AAE7C568D08E16AF481CB14D8EDCABFF
            FFFFF4FCF72DB85310A9310EA7290BA42009AF1C036B0AFF00FFFF00FF139923
            56C573C5F0D866CF8C20B4521CB24F95DEB0ABE6C11FB44E13AC3C12AA340FB0
            2D0A991F036B0AFF00FFFF00FFFF00FF1399236ACC88D0F4E39AE1B650C77A38
            BD672CBA5D30BB602FBC5D23BC4F11A33006620FFF00FFFF00FFFF00FFFF00FF
            FF00FF13992313992398E1B5BDEED4A7E7C490E0B178D99F49C7791B9D3D1B9D
            3DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1DA43513992313
            9923139923139923138C2AFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object BindIPList: TListBox
          Left = 13
          Top = 36
          Width = 148
          Height = 205
          Cursor = crHandPoint
          Hint = 'List of IP addresses which are binded.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ItemHeight = 13
          MultiSelect = True
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Security'
      ImageIndex = 2
      TabVisible = False
      object LMDFill4: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label14: TLabel
        Left = 8
        Top = 8
        Width = 97
        Height = 13
        Caption = 'Security Settings'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 8
        Top = 24
        Width = 269
        Height = 26
        Caption = 
          'Here you can restrict incoming connections from specific '#13#10'IP ad' +
          'dresses or Subnets.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox9: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 321
        Caption = 'Security Settings'
        TabOrder = 0
        object DisableSecurityRadio: TRadioButton
          Left = 7
          Top = 33
          Width = 145
          Height = 17
          Caption = 'Allow everyone full access.'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = DisableSecurityRadioClick
        end
        object EnableSecurityRadio: TRadioButton
          Left = 7
          Top = 60
          Width = 177
          Height = 17
          Caption = 'Allow only the following access:'
          TabOrder = 1
          OnClick = EnableSecurityRadioClick
        end
        object SecurityListView: TListView
          Left = 24
          Top = 96
          Width = 233
          Height = 169
          Columns = <
            item
              AutoSize = True
            end>
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ReadOnly = True
          ParentFont = False
          ShowColumnHeaders = False
          SmallImages = SecurityImageList
          StateImages = SecurityImageList
          TabOrder = 2
          ViewStyle = vsReport
          OnClick = SecurityListViewClick
        end
        object addacceptbutton: TBitBtn
          Left = 263
          Top = 95
          Width = 92
          Height = 27
          Hint = 'Add host to accepted hosts list'
          Caption = 'Add      '
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = addacceptbuttonClick
          Glyph.Data = {
            D2020000424DD202000000000000D20100002800000010000000100000000100
            08000000000000010000120B0000120B0000670000006700000000000000FFFF
            FF00FF00FF0086777700ED473100F2523A00F7E9E700EB583F00F75D4000F460
            4200924E4100B5321500DC411F00EE533000E3968300CF3F1A00FF6E4600F86A
            4400FE734F00FC724E00E9A18C00B8411700B74117006E2D130095685200035A
            050006900E00089511000A9814000A9A17000C9D19000DA01C000EA11D0010A5
            200011A5220011A6240013AB270014AC290017B02E0018B230001BB735001CBA
            38001FBF3E0020C1400022C4430023C5450025C7470027CB4B0028CC4D0029CF
            52002CD355002DD4580030D95E0034DE6500F8FAFA0057828E005A8799000B6E
            9A000B6D99005298BC00136A9C00166997002377A60007507E0013699C001563
            920000406D00024D810002426D0002375C00003C6A00003B6600033E6800064F
            83001D78BD0039ACFF0035A6FF0037A7FF002990EA00288EE6002D98FA00309D
            FB00319DFB0034A0FF000C5397002890FB002993FF002991FA002A95FE002C96
            FB000464CC002389F600268EFA00095FC2000F6DDC001F82F7002184FA000457
            C1001D7EFC001E7BF7002081FB001A70EB00166BEF0002020202020202020219
            191919020202020202020202020202191B1A1902020202171717171717020219
            1E1C19020202170F0405090719191919232019191919170C0813160E192E2B29
            2725221F1D19170D121115061932302D2A2826242119020B1015143619191919
            2F2C1919191902020A033837180B021933311902020202025E5A5D6139020219
            3534190202020245626464636639021919191902020242545658575C60653A02
            02020202020247454E4F5150555F3902020202020202434945454C52595B3902
            0202020202023C3B444A4B4D5339020202020202020202403B41484846390202
            02020202020202023E3D3F4602020202020202020202}
        end
        object removeacceptbutton: TBitBtn
          Left = 263
          Top = 134
          Width = 92
          Height = 27
          Hint = 'Remove host from accepted hosts list'
          Caption = 'Remove'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = removeacceptbuttonClick
          Glyph.Data = {
            E2020000424DE202000000000000E20100002800000010000000100000000100
            08000000000000010000120B0000120B00006B0000006B00000000000000FFFF
            FF00FF00FF0086777700FFF0EF00F84A3600ED473100F2523A00E1402300F45B
            4100F75D4000F6604200924E4100EA887400B5321500DC411F00EE533000ED9C
            8800CF3F1A00FF6E4600F86A4400FE734F00FC724E00E9A18C00B8411700E5A0
            88006E2D1300E2B09A0095685200FBFCFC0057838F005A8799000B6E9A005298
            BC00136A9C00166997002377A60007507E0013699C001563920000406D00024D
            810002426D0002375C00003C6A00003B6600033E6800064F83001D78BD0039AC
            FF0035A6FF0037A7FF002990EA00288EE6002D98FA00309DFB00319DFB0034A0
            FF000C5397002890FB002993FF002991FA002A95FE002C96FB000464CC002389
            F600268EFA00095FC2000F6DDC001F82F7002184FA000457C1001D7EFC001E7B
            F7002081FB001A70EB00166BEF005179FF005E81FF004269FF00244AF8002346
            EE002446EF00274CF3002D4ACF003A5BFB00304CCC003451D300324DC9003550
            CB002B41BB00354CC6000017B5000013960000118B0000118700000E70000119
            BC00021493000423EE000522D800021299000316A90003108B00030E6600040F
            62000000820002020202020202026A6A02026A6A0202020202020202026A5565
            6A6A615C6002021A1A1A1A1A1A6A54526766635D6A021A1206070B09051A6958
            53645F6A02021A0F0A1618110D0868594D505E6A02021A10151418041B6A574F
            5A5B51626A02020E1318171D196A4E576A6A56516A0202020C031F1E1C0E6A6A
            02026A6A020202024440434720020202020202020202022B484A4A494C200202
            020202020202283A3C3E3D42464B20020202020202022D2B343537363B452002
            020202020202292F2B2B32383F41200202020202020222212A30313339200202
            020202020202022621272E2E2C20020202020202020202022423252C02020202
            020202020202}
        end
        object RemoveAllSecurityButton: TBitBtn
          Left = 263
          Top = 173
          Width = 92
          Height = 27
          Caption = 'Remove All'
          Enabled = False
          TabOrder = 5
          OnClick = RemoveAllSecurityButtonClick
          Glyph.Data = {
            AE030000424DAE03000000000000AE0200002800000010000000100000000100
            08000000000000010000120B0000120B00009E0000009E00000000000000FFFF
            FF00FF00FF00FFF0EA00FFBD9000FCAF7400FFB47D00FFCEAA00FFD4B500F8B0
            7500FBB57E00FBB67E00FAC59800EDA56500EDA76700F3AA6B00F0AC6E00EEAB
            6D00F0AC6F00FABC8300FABF8800F8C09000F8C29300F7C29200FCD0A900EB9C
            4C00EB9D4F00EB9F5500EFAB6800EEAC6D00EFB07000EEAD6F00F0B17300EFB0
            7200EFB27500F0B27700F2B47900F2B77E00F7BC8300FAC08700FAC08800FAC0
            8900F3BF8A00FCCA9900FCD4AC00FCD4AD00EDA35400EFAC6600EEAF6E00F0B5
            7700F2B77A00F2BB8100F2BC8100F6C79200FFD8AC00F3BF8000F3C08600F3C2
            8A00F3C48A00FCD3A000FBD09F00FFD9AD00FFE0BA00F4C07D00F4C17F00F6C9
            9000F3C99000F3C99100F4CC9600FED9A700FEE0B800F6CF9900FEE2BA00FEE3
            BC00FBDCA900F7D8A600EBCA9100F8DAA300F7D8A300FBDEAC00FADDAB00F8DD
            AC00F8DEAF00FFEAC400FCE5B500FCE9BD00FFF2D100FBEBBD00FFEFC500FFF0
            C900FEF2D000FCEFC400FCF0C400FFF3CA00FFF4CB00FFF4CC00FEF2C500FEF3
            C900FEF4CB00FFF8D700FEF6CC00FEF7CC00FFFBD500FFFBD300FFFBD400FEFA
            D300FFFCD400FFFED700BCBB7900D9D9AC00FFFFD800FFFFD900FFFFDA00FFFF
            DD00FFFFE000FFFFE100FFFFE700FFFFEB00B8BC7900A3AF5E00A9B86E00EAF3
            C700C2D5A50084AB5400B5D19500B5D5980082B05B0077B45D007AB460009ACB
            87005DA9460057A74300D9EED50048A138002B9120002E9823002C962200E0F2
            DE003DA335006FBC69002B9924002A962400067F0400188A16002798240056B1
            5300007B00000079000000700000006E0000037F03000A82090041A641004BAF
            4B0080C78000058206006ABF6B00F4FEFB000202020202020202020202020202
            020202020202333A3421302202020202020202020257614F420B062B3D453102
            020202020269654A4C787B868379551F020202020D395C543C88929B8E8A5A20
            02020202110E1E413687959C0385770502020202242523120A80988B019D6C0F
            02020202170C16152A7A018491997609020202352D2C181808829A8990947E04
            1D020235534948463E6D978F96937F071D020250665F5D5958567D8D8C817C3E
            3202025B6E676A67686A73757472635E38020262716F6F706B644D3F404E6071
            4302024452514B47372F1A191B10273B29020202020202020202022E1C261413
            130202020202020202020202022828280202}
        end
        object SecurityUpButton: TBitBtn
          Left = 264
          Top = 216
          Width = 25
          Height = 25
          Hint = 'Move selected item up.'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = SecurityUpButtonClick
          Glyph.Data = {
            B6030000424DB603000000000000B60200002800000010000000100000000100
            08000000000000010000120B0000120B0000A0000000A000000000000000FFFF
            FF00FF00FF00FAFEFA0001460300014503000143030001420300013402000133
            02000130020002510400024C0400029E0A00029D0A00014D0400014A04000141
            030003A00B00039C0B00026A06000269060003960A00038C0A00037B08000378
            0800025205000357060003A70C0003A60C0003A50C0003A10C0003A00C00039F
            0C00039E0C00039E0F00039D0C00027E090004A30D00049F0D00049E0D00036B
            0A000365090007A0110006780E00044F090006680D000AA3140017AA2200AFE5
            B20005A0130006A71600034F090007A4150006620F000874120019AB270029B2
            340035B8400037BA420036B841006BCE75007FD4870098DD9E00ADE5B200AFE5
            B400B1E6B600DCF4DE0007A5180009AF1C0009A41C00066B110013992300F2FB
            F3000AAB1F000A991F000BA420000DAB28000EA6260021A336000CA627000FB0
            2D000EA729000D822300138C2A001DA435000EA92D0010AC300010AB2F0011AA
            320011A330007DD48E00F7FCF80011AB340012AA340017AF390038B454004BBF
            67008FDCA10017B641001B9D3D002BA649004CBD690056C5730088D99D00B5E9
            C200DCF4E20013AC3C0023BC4F0042B8630046BC660017A341006ACC88009DE1
            B20016AF480018B54A0019B14C001BB14C001CB24E001EB7510020B54F0021B1
            510026B754002FBC5D00F6FCF80020B4520021B5530022B655002ABA5C002CBA
            5D0030BB600038BD67003EBD690050C77A0054C57A0044C6740049C779005DCC
            86005FCC870066CF8C0068D08E0070D395008CDDAB00BAEACC0078D99F0083DD
            A70098E1B5009AE1B600BCEBCF00EDFAF20090E0B100AAE7C500C5F0D800F2FB
            F600A7E7C400BDEED400D0F4E300F7FCFA00FCFFFE00FCFEFE0002020202020A
            110B0B0609020202020202020205051913212124250F0F0202020202342A261D
            120D21201E1D15080202022D474A35280E42013C22201C140C02022D574D4623
            2241013B2222211C0C021B53635632272240013C2222221E18071B6F735D382B
            2731013C22302F1F16072E7977786A625F6901393A493F2021103784807E9501
            8E94013D43013E20211A2C8687768B5C9E9D9F03015B4E4424042C66917F768A
            7C010101685850331704024F978C72758999017159524C452902024F67988B7D
            748D8F7A6B5E514B2902020248709C93858381827B6C5A360202020202616192
            9B9A9690886464020202020202020255606E6D65540202020202}
        end
        object SecurityDownButton: TBitBtn
          Left = 264
          Top = 240
          Width = 25
          Height = 25
          Hint = 'Move selected item down.'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = SecurityDownButtonClick
          Glyph.Data = {
            C2030000424DC203000000000000C20200002800000010000000100000000100
            08000000000000010000120B0000120B0000A3000000A300000000000000FFFF
            FF00FF00FF00F8FCF800FCFEFC00014603000145030001430300014203000134
            0200013302000130020002510400024C0400029E0A00029D0A00014D0400014A
            04000141030003A00B00039C0B00026A06000269060003960A00038C0A00037B
            080003780800025205000357060003A70C0003A60C0003A50C0003A10C0003A0
            0C00039F0C00039E0C00039E0F00039D0C00027E090004A30D00049F0D00049E
            0D00036B0A000365090005A00F0006780E00044F090006680D0010A61B0054C4
            5C0005A0130006A71600034F090007A4150006620F00087412002CB5370035B8
            41003EBC480041BD4B0069CC720075D17D007ED486007FD4870090DA970098DD
            9E00DCF4DE00EEFAEF0007A5180009AF1C0009A41C00066B1100139923004CC1
            5800AAE3B000F2FBF3000AAB1F000A991F000BA42000F3FBF4000DAB280013AA
            2C0021B0390021A33600F6FCF7000CA627000FB02D000EA729000D822300138C
            2A001DA435000EA92D000FAA2E000FAA300010AC300010A9310011A3300041C0
            5B0011AB340012AA340038B454004BBF670017B641001B9D3D002BA649004CBD
            690056C5730084D99A00F4FCF60013AC3C0023BC4F0042B8630046C2670046BC
            6600B7E9C50017A341004CC56F006ACC8800EBF8EF0016AF480018B54A0019B1
            4C001BB14C001CB24E001EB7510020B54F0021B151002FBC5D0020B4520021B5
            530022B6550022B5540026B758002ABA5C002CBA5D0030BB600036BD660038BD
            67003EBD69004CC6750050C77A0054C57A00BBEBCC0044C6740049C7790066CF
            8C0068D08E00BFEDD000DEF6E70078D99F0083DDA70098E1B40098E1B5009AE1
            B600BCEBCE00BDEBCF0090E0B100BAEBCE00AAE7C500C5F0D800A7E7C400BDEE
            D400D0F4E30002020202020B120C0C070A020202020202020206061A14222225
            2610100202020202342B271E130E22211F1E16090202022E474C35290F314A30
            23211D150D02022E5E5046243A4301402823221D0D021C58665B323B4F010101
            3E28231F19081C737862496C04540403013D2C2017082F7E7C7D76016B72013C
            42013F212211378A85819497829D0138394B4121221B2D8D8F7B8884838E0161
            5552514425052D6996827B83839A01705D5C5533180502539E92777A839B0174
            5F574E452A0202536A9F91807993018B6D63564D2A0202024875A2998C898687
            7F6E60360202020202656598A1A09C9590676702020202020202025A64716F68
            590202020202}
        end
        object SecurityPanel: TPanel
          Left = 23
          Top = 267
          Width = 234
          Height = 33
          Hint = 'Type of access.'
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          object ReadCheckBox: TCheckBox
            Left = 8
            Top = 8
            Width = 57
            Height = 17
            Hint = 'Type of access.'
            Alignment = taLeftJustify
            Caption = 'Read'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            OnClick = ReadCheckBoxClick
          end
          object WriteCheckBox: TCheckBox
            Left = 88
            Top = 8
            Width = 57
            Height = 17
            Hint = 'Type of access.'
            Alignment = taLeftJustify
            Caption = 'Write'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = WriteCheckBoxClick
          end
          object DenyCheckBox: TCheckBox
            Left = 168
            Top = 8
            Width = 57
            Height = 17
            Hint = 'Type of access.'
            Alignment = taLeftJustify
            Caption = 'Deny'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = DenyCheckBoxClick
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Accepting Files'
      ImageIndex = 3
      TabVisible = False
      object LMDFill5: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label18: TLabel
        Left = 8
        Top = 24
        Width = 225
        Height = 13
        Caption = 'Choose weather to save or reject incoming files.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label19: TLabel
        Left = 8
        Top = 8
        Width = 143
        Height = 13
        Caption = 'Accepting Incoming Files'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox10: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 225
        Caption = 'Incoming Files'
        TabOrder = 0
        DesignSize = (
          425
          225)
        object OverwriteCheck: TCheckBox
          Left = 24
          Top = 191
          Width = 129
          Height = 14
          Hint = 'If the file already exists, should it be overwritten?'
          Caption = 'Overwrite existing files.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Browsebutton: TBitBtn
          Left = 24
          Top = 122
          Width = 97
          Height = 27
          Hint = 'Browse for a destination folder...'
          Caption = 'Browse...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BrowsebuttonClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FF0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
            AC0274AC097BB2FF00FFFF00FFFF00FF0274AC2EA7E10274AC7ED4FC46BCF449
            BFF449BFF64ABFF44ABFF64BC0F643BAF036A6D772C9E30274ACFF00FFFF00FF
            0274AC35AFE50274AC8ADEFF53C9F856CAFA56CAF857CAFA57CAFA58CBFB4FC5
            F43DADD87ACFE50274ACFF00FF0274AC0274AC3BB4E50274AC92E6FF5DD3FA62
            D4FA62D4FA62D4FA63D4FA63D5FA59CFF643B4D87FD3E50274AC0274AC2EA7E1
            0274AC41BBE70274AC96EEFF65DDFA69DEFB68DEFB69DEFB68DEFB69E0FC5FD9
            F741B6D880D7E50274AC0274AC35AFE50274AC45C1E60274ACEAFFFFA6F8FFAB
            FAFFACFAFFABFAFFABFAFFADFBFFA1F3FF82D1E6A7E5EF0274AC0274AC3BB4E5
            0274AC52CCEA0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
            AC0274AC0274AC0274AC0274AC41BBE70274AC74E9F874E9F874E9F874E9F874
            E9F874E9F874E9F874E9F874E9F874E9F80274ACFF00FFFF00FF0274AC45C1E6
            0274ACD4FEFF96FFFF97FFFF97FFFF99FFFF99FFFF9AFFFF9AFFFF9EFFFF8EFC
            FF0274ACFF00FFFF00FF0274AC52CCEA0274AC0274ACD4FCFE88FBFE99FCFE47
            C0DC0274AC0274AC0274AC0274AC0274AC0274ACFF00FFFF00FF0274AC74E9F8
            74E9F874E9F80274AC0274AC0274AC0274AC74E9F874E9F874E9F80274ACFF00
            FFFF00FFFF00FFFF00FF0274ACD4FEFF96FFFF97FFFF97FFFF99FFFF99FFFF9A
            FFFF9AFFFF9EFFFF8EFCFF0274ACFF00FFFF00FFFF00FFFF00FFFF00FF0274AC
            D4FCFE88FBFE99FCFE47C0DC0274AC0274AC0274AC0274AC0274ACFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF0274AC0274AC0274AC0274ACFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object addnewCheck: TCheckBox
          Left = 24
          Top = 167
          Width = 185
          Height = 14
          Hint = 
            'Once a file has been uploaded, add it to the available files lis' +
            't?'
          Caption = 'Add new files to available files list.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object Destedit: TLabeledEdit
          Left = 24
          Top = 97
          Width = 393
          Height = 21
          Hint = 'Select destination folder for uploaded files to be stored.'
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Destination folder:'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object AcceptRadio: TRadioButton
          Left = 7
          Top = 52
          Width = 282
          Height = 14
          Hint = 'Allow remote hosts to upload files'
          Caption = 'Accept incoming files (dependent on security settings):'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = AcceptRadioClick
        end
        object NoAcceptRadio: TRadioButton
          Left = 7
          Top = 26
          Width = 162
          Height = 14
          Hint = 'Do not allow remote hosts to upload files'
          Caption = 'Do not accept incoming files.'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          TabStop = True
          OnClick = NoAcceptRadioClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Logging'
      ImageIndex = 4
      TabVisible = False
      object LMDFill6: TLMDFill
        Left = 0
        Top = 0
        Width = 425
        Height = 65
        Bevel.Mode = bmCustom
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        FillObject.Style = sfGradient
        FillObject.Gradient.Color = 10485760
        FillObject.Gradient.ColorCount = 236
        FillObject.Gradient.Style = gstHorizontal
        FillObject.Gradient.EndColor = clActiveBorder
      end
      object Label20: TLabel
        Left = 8
        Top = 8
        Width = 46
        Height = 13
        Caption = 'Logging'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label21: TLabel
        Left = 8
        Top = 24
        Width = 209
        Height = 13
        Caption = 'Choose where and when log files are saved.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object GroupBox11: TGroupBox
        Left = 0
        Top = 72
        Width = 425
        Height = 305
        Caption = 'Log Settings'
        TabOrder = 0
        object LogFormatLabel: TLabel
          Left = 237
          Top = 128
          Width = 27
          Height = 13
          Caption = 'Type:'
        end
        object LogOptionsCheck: TCheckBox
          Left = 24
          Top = 167
          Width = 133
          Height = 13
          Hint = 'Enable additional logging options.'
          Caption = 'Enable log limit options:'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = LogOptionsCheckClick
        end
        object LogFolderButton: TBitBtn
          Left = 24
          Top = 122
          Width = 97
          Height = 27
          Hint = 'Browse for a destination folder...'
          Caption = 'Browse...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = LogFolderButtonClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FF0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
            AC0274AC097BB2FF00FFFF00FFFF00FF0274AC2EA7E10274AC7ED4FC46BCF449
            BFF449BFF64ABFF44ABFF64BC0F643BAF036A6D772C9E30274ACFF00FFFF00FF
            0274AC35AFE50274AC8ADEFF53C9F856CAFA56CAF857CAFA57CAFA58CBFB4FC5
            F43DADD87ACFE50274ACFF00FF0274AC0274AC3BB4E50274AC92E6FF5DD3FA62
            D4FA62D4FA62D4FA63D4FA63D5FA59CFF643B4D87FD3E50274AC0274AC2EA7E1
            0274AC41BBE70274AC96EEFF65DDFA69DEFB68DEFB69DEFB68DEFB69E0FC5FD9
            F741B6D880D7E50274AC0274AC35AFE50274AC45C1E60274ACEAFFFFA6F8FFAB
            FAFFACFAFFABFAFFABFAFFADFBFFA1F3FF82D1E6A7E5EF0274AC0274AC3BB4E5
            0274AC52CCEA0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
            AC0274AC0274AC0274AC0274AC41BBE70274AC74E9F874E9F874E9F874E9F874
            E9F874E9F874E9F874E9F874E9F874E9F80274ACFF00FFFF00FF0274AC45C1E6
            0274ACD4FEFF96FFFF97FFFF97FFFF99FFFF99FFFF9AFFFF9AFFFF9EFFFF8EFC
            FF0274ACFF00FFFF00FF0274AC52CCEA0274AC0274ACD4FCFE88FBFE99FCFE47
            C0DC0274AC0274AC0274AC0274AC0274AC0274ACFF00FFFF00FF0274AC74E9F8
            74E9F874E9F80274AC0274AC0274AC0274AC74E9F874E9F874E9F80274ACFF00
            FFFF00FFFF00FFFF00FF0274ACD4FEFF96FFFF97FFFF97FFFF99FFFF99FFFF9A
            FFFF9AFFFF9EFFFF8EFCFF0274ACFF00FFFF00FFFF00FFFF00FFFF00FF0274AC
            D4FCFE88FBFE99FCFE47C0DC0274AC0274AC0274AC0274AC0274ACFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF0274AC0274AC0274AC0274ACFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object LogFolderEdit: TLabeledEdit
          Left = 24
          Top = 97
          Width = 393
          Height = 21
          Hint = 'Select destination folder for log files to be stored'
          EditLabel.Width = 75
          EditLabel.Height = 13
          EditLabel.Caption = 'Log file folder:   '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object LogFormatCombo: TLMDComboBox
          Left = 271
          Top = 124
          Width = 146
          Height = 21
          Hint = 'Select the type of log file to be saved.'
          ItemHeight = 13
          Items.Strings = (
            'Text File (.log)'
            'Comma Delimited File (.csv)')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Text = 'Text File (.log)'
        end
        object LogRadio: TRadioButton
          Left = 7
          Top = 52
          Width = 91
          Height = 14
          Hint = 'Log activity to file.'
          Caption = 'Log activity:'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = LogRadioClick
        end
        object NologRadio: TRadioButton
          Left = 7
          Top = 26
          Width = 114
          Height = 14
          Hint = 'Do not log activity to file.'
          Caption = 'Do not log activity.'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          TabStop = True
          OnClick = NologRadioClick
        end
        object LogLimitGroupBox: TGroupBox
          Left = 48
          Top = 190
          Width = 369
          Height = 99
          Caption = 'Log limit options:'
          TabOrder = 6
          object LogKBLabel: TLabel
            Left = 254
            Top = 29
            Width = 14
            Height = 13
            Caption = 'KB'
          end
          object LogSizeTextLabel: TLabel
            Left = 32
            Top = 48
            Width = 277
            Height = 13
            Caption = '(A new log file will be created once size has been reached)'
          end
          object LogSizeRadio: TRadioButton
            Left = 13
            Top = 28
            Width = 172
            Height = 13
            Hint = 'Create a new log file once size has been reached.'
            Caption = 'Limit log files to a specified size:'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object LogSizeEdit: TLMDSpinEdit
            Left = 193
            Top = 26
            Width = 56
            Height = 21
            Bevel.Mode = bmWindows
            Caret.BlinkRate = 530
            TabOrder = 1
            AutoSelect = True
            CustomButtons = <>
            MinValue = 1
            MaxValue = 10240
            Value = 10240
            DateTime = 0.000000000000000000
          end
          object LogSepRadio: TRadioButton
            Left = 13
            Top = 71
            Width = 172
            Height = 14
            Hint = 'Create a new log file once per day.'
            Caption = 'Create a new log file every day.'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            TabStop = True
          end
        end
      end
    end
  end
  object ConfigTree: TTreeView
    Left = 0
    Top = 0
    Width = 169
    Height = 500
    Align = alLeft
    AutoExpand = True
    BorderWidth = 1
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = []
    HideSelection = False
    HotTrack = True
    Images = TreeImages
    Indent = 23
    ParentFont = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    OnClick = ConfigTreeClick
    Items.Data = {
      0100000026000000000000000000000000000000FFFFFFFF0000000006000000
      0D436F6E66696775726174696F6E20000000010000000100000001000000FFFF
      FFFF00000000000000000747656E6572616C2300000001000000010000000100
      0000FFFFFFFF00000000000000000A436F6E6E656374696F6E25000000010000
      000100000001000000FFFFFFFF00000000000000000C49502041646472657373
      657328000000010000000100000001000000FFFFFFFF00000000000000000F41
      6363657074696E672046696C657320000000010000000100000001000000FFFF
      FFFF0000000000000000074C6F6767696E672100000002000000020000000200
      0000FFFFFFFF0000000000000000085365637572697479}
  end
  object BrowseDlg: TLMDBrowseDlg
    Caption = 'Destination folder for incoming files:'
    Left = 40
    Top = 144
  end
  object SecurityPopup: TPopupMenu
    Left = 4
    Top = 144
  end
  object SecurityImageList: TImageList
    Left = 80
    Top = 144
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000747474007A7A7A007F7F7F007F7F7F007A7A7A00757575000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000033140000451B00005722000057220000471C0000361600000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000130020001410300025104000251040001430300013302000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000003260000043400000443000004430000043600000428000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B008A8A8A00949494009595950095959500959595008C8C8C007D7D
      7D007D7D7D00000000000000000000000000000000000000000000000000491C
      0000491C000080320000A5410000AA420000AA420000A741000084340000511F
      0000511F00000000000000000000000000000000000000000000000000000145
      03000145030003780800039C0B00039F0C00039F0C00039D0C00027E0900014D
      0400014D04000000000000000000000000000000000000000000000000000004
      380000043800000164000000870000008C0000008C0000008900000167000004
      3E0000043E000000000000000000000000000000000000000000808080008686
      8600969696009797970095959500949494009595950095959500969696009797
      9700868686007575750000000000000000000000000000000000592300006E2B
      0000AF440000B1450000AA420000A5410000AA420000AA420000AF440000B145
      0000702C00003616000000000000000000000000000000000000034F09000365
      090004A30D0003A60C0003A00B00029E0A00039F0C0003A00C0003A50C0003A6
      0C00026906000134020000000000000000000000000000000000000344000002
      5400000091000000930000008C000000870000008C0000008C00000091000000
      9300000257000004280000000000000000000000000080808000898989009C9C
      9C00999999009595950094949400949494009595950095959500959595009595
      950097979700868686007D7D7D000000000000000000592300007B300000C54D
      0000B8480000AA420000A5410000A5410000A7410000A7410000A7410000AA42
      0000B1450000702C0000511F00000000000000000000044F0900066B11000AAB
      1F0007A41500049E0D00029D0A00039D0A00039E0C00039E0C00039E0C0003A0
      0C0003A70C00026A0600024C04000000000000000000000A570000015F000000
      A70000009A0000008C0000008700000087000000890000008900000089000000
      8C00000093000002570000043E000000000000000000808080009F9F9F009E9E
      9E009999990095959500A1A1A100E9E9E900EFEFEF00B8B8B800959595009595
      950095959500979797007D7D7D00000000000000000059230000D4530000CC50
      0000BB490000AA420000B2551000F3E3D400F8EFE700C67F4200A7410000A741
      0000AA420000B1450000511F00000000000000000000044F090010AC30000DAB
      280009A41C00039E0F0016AA2000D5F2D800E9F8EA0048C05200039E0C00039E
      0C00039F0C0003A70C00024C04000000000000000000000A57000000B6000000
      AE0000009D0000008C00000C9400D4DAF300E7EBF8002B44AF00000089000000
      890000008C000000930000043E00000000008181810093939300A5A5A5009E9E
      9E00979797009696960098989800CECECE00F6F6F600F3F3F300B4B4B4009595
      950095959500969696008C8C8C007A7A7A005F250000A03F0000EB5C0000CC50
      0000B1450000AC430000AA460300DAAA7E00FFFFFF00FCF8F400C4793A00A741
      0000A7410000AF44000084340000451B0000035706000D82230017B641000EA9
      2D0005A01300049F0D0007A0110082D58900FFFFFF00F4FCF60040BC4A00039E
      0C00039E0C0003A50C00037B080001420300000A5B00000489000000CD000000
      AE000000930000008E0000008C007284CE00FFFFFF00F4F6FC00223BAC000000
      89000000890000009100000167000004340081818100A0A0A000A5A5A5009F9F
      9F0097979700959595009696960095959500C9C9C900F5F5F500F2F2F200B4B4
      B4009595950096969600929292007A7A7A005F250000D7540000EB5C0000D453
      0000B1450000AA420000AC430000AA420000D5A06F00FEFEFC00FCF7F300C277
      3800A7410000AC4300009E3E0000451B00000357060017A3410018B54A0011AB
      340006A01100039E0C00049F0D00039E0C0074D07D00FCFEFC00F3FBF4003EBC
      4800039E0C0003A10C0003960A0001420300000142000000B9000000CD000000
      B6000000930000008C0000008E0000008C006074C600FCFCFE00F3F4FC001F38
      A9000000890000008E00000080000004340088888800A7A7A700A8A8A800E3E3
      E300E1E1E100E0E0E000E0E0E000DFDFDF00E0E0E000F3F3F300F6F6F600F0F0
      F000BDBDBD0095959500959595007D7D7D00772E0000F6600000F8620000FED5
      AF00F8D1AC00F4CFAB00F8D0AB00F7CEA600F6CFAA00FCF8F600FFFFFF00FAF4
      EE00CB894F00AA420000AA4200004F1F000006680D0021B151001EB75100BFED
      CF00BAEAC600B7E9C200B8EAC500B5E9C200B7E9C100F6FCF700FFFFFF00EEFA
      EF0054C55E0003A00C00039F0C00014A0400000059000001D8000002DB00ACBC
      FB00A9B8F500A7B6F000A7B7F400A1B1F200A6B4F200F6F7FC00FFFFFF00EEF0
      FA003B53B70000008C0000008C0000043C008D8D8D00B4B4B400ADADAD00F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F5F5F500F6F6F600F6F6
      F600DBDBDB0096969600959595007F7F7F0089350000FF781300FF6A0400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFC00FFFFFF00FFFF
      FF00E6C6A700AC430000AA42000057220000087412003EBD69002ABA5C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFEFC00FFFFFF00FFFF
      FF00AAE3B00003A00C00039F0C000252050000006B00011BE200000BE300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFE00FFFFFF00FFFF
      FF00A2B0E10000008E0000008C00000443008D8D8D00BDBDBD00B9B9B900BDBD
      BD00BFBFBF00BFBFBF00BFBFBF00BABABA00CBCBCB00F4F4F400F6F6F600D5D5
      D500A4A4A40099999900949494007B7B7B0089350000FF882900FF801E00F489
      3100FC8C3200FC8C3100FC8C3100F8822500EDA56600FEFBF800FFFFFF00E9B8
      8C00C75A0B00B8480000A54100004B1D000006780E0054C57A0044C6740052C7
      7D0057CA810056CA800057CA810049C5730079D59200FAFEFA00FFFFFF0097DD
      A5001AAD330007A51800039D0C000146030000006B00193DEF000125E200193B
      DC00193CE300183BE300183BE3000A2EDD00667FED00F8FAFE00FFFFFF008295
      DF00000AA90000009A0000008700000439008D8D8D00B9B9B900D0D0D000A9A9
      A900A5A5A500A8A8A800A8A8A800BFBFBF00EDEDED00F6F6F600D0D0D0009F9F
      9F009C9C9C0099999900909090007B7B7B0089350000FF801E00FFAD6700FF64
      0000EE5D0000FB630000FB630000FC8B3000FCEBDA00FFFFFF00EAAF7900CF52
      0000C54D0000BB490000953A00004B1D000006780E004CBD690083DDA70022B6
      55001CB24E0022B5540022B5540055CA7F00E1F6E900FFFFFF0088D99D0010AB
      2F000CA6270006A71600038C0A000146030000006B000E32EF005A76F2000001
      E1000000D0000001DD000001DD00173AE300DAE1FC00FFFFFF006C82DD000001
      B2000000A70000009D00000077000004390000000000A4A4A400DCDCDC00C5C5
      C500A2A2A200A5A5A500B3B3B300F3F3F300F6F6F600CFCFCF009F9F9F009D9D
      9D009B9B9B009C9C9C00878787000000000000000000E65A0000FFC69300FF98
      4200E1580000EB5C0000FB751100FFF8F200FFFFFF00F0AC7000CF520000CA4F
      0000C04B0000C74E0000752D0000000000000000000021A33600AAE7C50068D0
      8E0016AF48001BB14C0039BF6800F4FCF700FFFFFF0084D99E0011AA32000EA7
      29000BA4200009AF1C00036B0A000000000000000000000AD20090A6FC002D50
      EA000000C3000000CD000017DD00F2F4FF00FFFFFF006B84EB000000B1000000
      AC000000A2000000A90000025B000000000000000000A4A4A400BDBDBD00E5E5
      E500C5C5C500A8A8A800A8A8A800DBDBDB00D5D5D500A4A4A400A1A1A1009F9F
      9F00A0A0A00098989800878787000000000000000000E65A0000FF892B00FFDA
      B700FF974100F8620000EA640500FCC69500FEB87A00E35C0100D9550000D453
      0000D7540000B4460000752D0000000000000000000021A3360056C57300C5F0
      D80066CF8C0020B4520023B55400AAE6C00096DEB10019B1480013AC3C0012AA
      34000FB02D000A991F00036B0A0000000000000000000000C8001034E400ABBA
      F3003C5EFA00000EE7000215DA0092A6F900748DF8000001C5000000BB000000
      B6000000B9000000960000025B000000000000000000000000009C9C9C00C5C5
      C500E9E9E900D7D7D700BCBCBC00B3B3B300ADADAD00AFAFAF00AFAFAF00ABAB
      AB009D9D9D008686860000000000000000000000000000000000C54D0000FF98
      4200FFE2C600FFBB7F00FF872800FF750F00FF6B0500FF6E0800FF6E0800FF67
      0100CA4F0000702C000000000000000000000000000000000000139923006ACC
      8800D0F4E3009AE1B60050C77A0038BD67002CBA5D0030BB60002FBC5D0023BC
      4F0011A3300006620F00000000000000000000000000000000000000A700294C
      E600C6D1FF007F98FF001D41F4000826F0000218EF00041CEF00000EE1000005
      E1000000AC00000257000000000000000000000000000000000000000000B9B9
      B900B9B9B900D6D6D600E3E3E300DBDBDB00D4D4D400CCCCCC00BABABA00A0A0
      A000A0A0A000000000000000000000000000000000000000000000000000FF80
      1E00FF801E00FFBA7D00FFD5AD00FFC59100FFB57400FFA55800FF832300D754
      0000D75400000000000000000000000000000000000000000000000000004BBF
      67004BBF670098E1B500BDEED400A7E7C40090E0B10078D99F0049C779001B9D
      3D001B9D3D000000000000000000000000000000000000000000000000000327
      E4001135F2007D96FF00ADBDFF0091A6FF00748FFF005574FC000529E1000002
      BB000002BB000000000000000000000000000000000000000000000000000000
      000000000000A2A2A200B0B0B000B7B7B700B4B4B400A8A8A800989898000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1580000FF700A00FF7D1900FF781300FB630000B64700000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001DA4350038B4540046BC660042B863002BA64900138C2A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000CD000051EEF000E32F2000A2AF100000EEA000006A0000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81FF81FF81FF81FE007E007E007E007
      C003C003C003C003800180018001800180018001800180010000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080018001800180018001800180018001C003C003C003C003
      E007E007E007E007F81FF81FF81FF81F00000000000000000000000000000000
      000000000000}
  end
  object TreeImages: TImageList
    Left = 112
    Top = 144
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000108ABA001895C10006689700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000188C
      BA00138FBD00066A99000982B2001399CA001E9DC9000B72A0000A6D9A002B96
      BD002692BC00000000000000000000000000893615007D3213007D3213007D32
      13007D3213007D3213007D3213007D3213007D3213007D3213007D3213007D32
      13007D3213007D3213007D321300893615000000000000000000000000000286
      BD0030A4D70045B0E1003AAADA00269ED10034A6D80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001D8F
      BA0021A5D1000999CE00078ABC000EB7EB002FCBF6001F90BB0041B0D3004CB4
      D400288EB600000000000000000000000000692A1100FFF7F000FEF4E900FEF2
      E300FEEEDD00FEEAD400FEE6CD00FDE2C500FDDEBE00FDDEBE00FCD8AF00FCD6
      AC00FCD4A700FCD4A700FCCE9D007D3213000000000000000000038AC000058F
      C40065C5ED0089D5FE007FCFFA007ACEF80062BFEA0058BBE9002FA4D7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001073A0001880AB0035A1
      C9006BD0EA0037AFD40023B8E6000FCBFF0023D0FF0044C7ED005AB6D5009CD8
      E60077C0D8000D72A100000000000000000065281000FEFAF500FEF4E900FEE6
      CD00F0D0A300F0D0A300FFFEFE00FFFEFE00FCD6AC00FDDEBE00FCD8AF00FCD9
      B000FCD6AC00FCD4A700FCCE9D00752E110000000000000000000892C7000E9A
      CC0069CCE90089DAFA007ACFF70068C2EE003FA9D70076CBF40082D1FA005BBC
      EB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000045A7CB002F9CC50039AC
      D7007DE7FF0074EAFF0040DDFF0015CFFF000DCCFF0038D9FF005EE1FF0063E5
      FF0028BCE9001C9DCE00188EC0000000000065281000FFFEFE00D0C6BA006240
      1A00656462006564620091919000FFFEFE00FFFEFE00FDE2C500FDDEBE00FCD8
      AF00FCD6AC00FCD6AC00FDD1A000752E11000000000000000000109ACC001AA4
      D4007BD5EA009DE9F8008BE0FC00499EC4002083AF0054B7E5007DCFFA0082D1
      FA001F9DCF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000878AF001190CB0035B2
      E30067D5F40079EAFF0056C6E10041A5BD00369EBA0017B7E50002C4FF0001C1
      FE0003C2FE0003BAF20005A0D8000000000065280F00FFFEFE00684E35005E81
      7A0000BDFF0000BDFF0095E9FF0091919000FFFEFE00FDE2C500FDDEBE00FCD9
      B000FCD9B000FCD6AC00FCD4A700752E1100000000000000000019A1D30028AC
      DC009DDDED00C1F6FC00A3F0FF0069BAD40016658A004EABD7007BD0FB007DCF
      F8001E9CCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000D75A5001698D40028A9
      E00052CBF30078B7C6007F7E7E007F7E7E007F7E7E007F7E7E002DAACC0000C5
      FF0009C6FE000FC5FA000487BC000000000065280F00FFFEFE005A35130000BD
      FF00004B0000004B000000BDFF0065646200F0D1A400FEE6CD00D5812700D581
      2700D5812700D5812700FCD4A7007D321300000000000000000023A9DA002FB0
      E100B5E1F000E6F8FC00BBF2FA009FE6F2004893AD0072C1E10081D5FE007BCC
      F8001E9CCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000F79AA001598D5001CA0
      DA0040C1F0007F7E7E00E2DAD9009E9F9F00978B8B00D8A4A1007F7E7E003FD1
      F80084EBFF00A1EAFB002683AB000000000065280F00FFFEFE005A35130081FF
      FE00004B0000004B000000BDFF0065646200F0D1A400FEE6CD00D5812700D581
      2700D5812700D5812700FCD6AC00752E110000000000000000001A9FD0002CB0
      D90043AFD00051B8D70047B8D90045B7D90053C1E0006CCCE90086D9F7008BD8
      FE001F9DCF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000973A5000F86BF001597
      D3002EB5EA007F7E7E00E2D9D7009D9E9E00978B8B00D1A1A0007F7E7E0062DC
      FA0097E6F70070BCD7002F8FB4000000000065281000FFFEFE00685037009F9D
      9A00FFFEFE0000BDFF00998C7A0062401A00FDDEBE00FEEAD400FEE6CD00FDE2
      C500FDDEBE00FCD9B000FCD9B000752E11000000000000000000189DCC003EBF
      DC0028A5CB002DACD0002DB1D50021A4CE0031B1D90050C1E30082D8F6006CC7
      F0001395C7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000005669500108B
      C60020AAE5007F7E7E00E2D9D7009D9E9E00978B8B00D3A3A0007F7E7E004AD8
      FC004DBBDE00015E8E00000000000000000065280F00FFFEFE00D0CBC4006850
      37005A3513005A351300684E3500CFC1B000FEEEDD00FEEEDD00FEE9D000FEE6
      CD00FDE2C500FDDEBE00FCD9B000752E11000000000000000000169DCB0041BD
      D5000483B40025A3C40070F2FA003BCBE60013A3CF000186BB001396C50038AF
      D7000F91C5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000086F
      A0000576AC007F7E7E00E6DDD9009D9E9E00978B8B00D7A5A3007F7E7E000F82
      B000117AA700000000000000000000000000692A1100FFFEFE00FFFEFE00FFFE
      FE00FFFEFE00FEFAF500FEF4E900FEF4E900FEF2E300FEEEDD00FEEAD400FEE6
      CD00FDE2C500FDE2C500FCD9B0007D321300000000000000000000000000047B
      B0000078AD001B99C1006DEBF6005FE6F6002EB1D100047EAF000786B4000D93
      C200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7E7E00DDDAD900999A9A00968A8A00CCA3A3007F7E7E000000
      0000000000000000000000000000000000009E512300CB934600C68C4100C68C
      4100C68C4100C68C4100C68C4100C68C4100C68C4100C68C4100CD995100CB93
      4600CD995100C1914E00BB955C00A15222000000000000000000000000000000
      00000481B6000C83B2000000000023ADD7001091BF00037DAF00057EB1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7E7E009E9E9E0089898900817E7E00968989007F7E7E000000
      00000000000000000000000000000000000099411500CE641400CE641400CE64
      1400CE641400CE641400CE641400CE641400CE641400D1681800F3A96600E070
      1100F3A966009F6339003553C700A6420C000000000000000000000000000000
      000035B2DE001786B600000000000000000000000000037BAD000470A1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7E7E00D8D7D700B6B7B7008F8C8C009F8F8F007F7E7E000000
      0000000000000000000000000000000000000000000093401A0093401A009340
      1A0093401A0093401A0093401A0093401A0093401A0093401A0099441C00953E
      150099441C008C3C1A00843D2400000000000000000000000000000000000000
      00002490B6005CD4E9002695B800000000000970A3000486B800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7E7E00DDDCDC00E3E2E200AAAAAA008C8787007F7E7E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031A1BF0060D7E60050C4DE0031AAD7000B80B200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7E7E007F7E7E007F7E7E007F7E7E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FE3FFFFFFFFF0000E0070000E07F0000
      E0070000C01F000080030000C00F000080010000C007000080010000C0070000
      80010000C007000080010000C007000080010000C0070000C0030000C0070000
      E0070000E00F0000F81F0000F21F0000F81F0000F39F0000F81F8001F13F0000
      F81FFFFFF83F0000FC3FFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
