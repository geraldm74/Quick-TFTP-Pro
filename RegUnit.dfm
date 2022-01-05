object RegForm: TRegForm
  Left = 423
  Top = 794
  BorderStyle = bsDialog
  Caption = 'Enter Registration Key'
  ClientHeight = 257
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    353
    257)
  PixelsPerInch = 96
  TextHeight = 13
  object LMDFill1: TLMDFill
    Left = 8
    Top = 8
    Width = 337
    Height = 57
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
    FillObject.Gradient.EndColor = clBtnFace
  end
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 90
    Height = 13
    Caption = 'Registration Name:'
  end
  object Label3: TLabel
    Left = 8
    Top = 154
    Width = 80
    Height = 13
    Caption = 'Registration Key:'
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 237
    Height = 39
    Caption = 
      'If you have purchased QuickTFTP Desktop Pro, please enter the re' +
      'gistration name and registration key which you have received via' +
      ' email.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object RegNameEdit: TEdit
    Left = 8
    Top = 124
    Width = 337
    Height = 21
    TabOrder = 0
    OnKeyDown = RegNameEditKeyDown
    OnKeyUp = RegNameEditKeyUp
  end
  object RegEdit: TEdit
    Left = 8
    Top = 174
    Width = 337
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 36
    ParentFont = False
    TabOrder = 1
    OnKeyDown = RegEditKeyDown
    OnKeyUp = RegEditKeyUp
  end
  object RegButton: TButton
    Left = 184
    Top = 224
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Register'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = RegButtonClick
  end
  object CancelButton: TButton
    Left = 272
    Top = 224
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 81
    Width = 337
    Height = 7
    TabOrder = 4
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 209
    Width = 337
    Height = 7
    TabOrder = 5
  end
end
