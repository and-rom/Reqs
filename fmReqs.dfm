object Form1: TForm1
  Left = 0
  Top = 377
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1079#1072#1087#1088#1086#1089#1086#1074
  ClientHeight = 298
  ClientWidth = 1250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000130B0000130B000000000000000000000000
    0000000000000000000000000000000000000000000B0D12167026384BD00000
    0079000000390000004600000021000000000000000000000000000000000000
    0000000000000000000000000005040609622F465DD673A1D0FF6AA2DAFF1C3D
    5FF901020384000000400000004D000000250000000000000000000000000000
    00000000000001030455293D51CB6390BCFF7AB1E7FF81B6EAFF5B8EC1FF3369
    A1FF24476BFC0204068C0000003F0000004E0000002900000000000000000304
    0645253749C15E89B3FF7AB0E6FF5C93C7FF3D72A4FF71A5D7FF5488BBFF3063
    97FF376DA4FF264C73FF03070A96000000400000004D00000024000000012B41
    56DC6CA1D6FF6197CBFF3B70A2FF2C6194FF356B9EFF72A6D9FF5083B7FF2D60
    95FF33669AFF366DA4FF29517AFF05090EA000000043000000390000000A354E
    68D64D7DADFF295C8CFF30679AFF2D6091FF2F5D88FF6293C3FF4F83B9FF3F73
    A7FF306397FF33669AFF366CA3FF2A5580FF080F16AB000000380000000D344C
    65D54E7EAEFF295B8AFF2C5B87FF3C6893FF5889BBFF74ABE0FF73A0CDFF7EA1
    BFFF679AC8FF2C5F94FF326599FF386FA8FF1E3C5AFB0000004E0000000C344D
    65D54E7EAEFF335F89FF5485B6FF76AADEFF8FBFEDFFA5C0DAFFA1A6A9FF5958
    57FF8AA8C0FF6BA0CFFF2D6196FF356BA2FF1E3D5CF20000002C000000032E47
    60D5639AD2FF7BABDBFFA0C7EDFFB3CAE0FFB9BEC3FFCECCC9FFBFBEBDFF6463
    63FF5D5C5BFF8BA8BFFF72A6D4FF3268A0FF1C3A5AED0000000F000000003E52
    66DFB3D7F8FFB7C9DBFFCACDD0FFD2D0CDFFDDDCDBFFBFBFBFFFA4A4A4FF8C8D
    8DFF70706FFF62605FFF809BB1FF75ABDBFF234262F200000013000000001D1D
    1D783C4144BE6F757AF8F1F0EEFFC9C9C9FFA9A9A9FFA2A2A2FFA3A3A3FFAFAF
    AFFF939393FF7C7A77FF4A545EFF84B7E5FF3D5263DC0000000E000000000000
    0000000000004D4C4CD4B1B1B1FFABABABFFA7A7A7FFAFAFAFFFAFAFAFFFA8A8
    A8FFB0B0B0FF989796FF656B70FC1B2530930000001C00000000000000000000
    00000000000000000056454545EBAAAAAAFFBBBBBBFFADADADFFAEAFAFFFADAD
    ADFFAFAFAFFFC1C2C2FF474746C3000000000000000000000000000000000000
    0000000000000000000000000043424242E5ADADADFFB8B8B8FFB2B2B2FFBDBD
    BDFF8D8D8DE92424247D00000014000000000000000000000000000000000000
    0000000000000000000000000000000000473F3F3FE3B4B4B4FF9B9B9BF02F2F
    2F8A0000001B0000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000001000000502828289E000000240000
    000000000000000000000000000000000000000000000000000000000000FEFF
    E1FFF83F65FFE01F21FF800F78FF0007D9FF0003FEFF0003FFFF0003FFFF0003
    C0FF000349FF800300F2C0070090E00F0021F03F0000F87F0000FDFF0000}
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1258
    Height = 297
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1047#1072#1087#1088#1086#1089#1099
      object Label1: TLabel
        Left = 679
        Top = 11
        Width = 39
        Height = 13
        Caption = #1044#1083#1080#1085#1072': '
      end
      object StringGrid1: TStringGrid
        Left = 0
        Top = 35
        Width = 1258
        Height = 201
        ColCount = 1
        DefaultColWidth = 139
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -10
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentFont = False
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        OnGetEditText = StringGrid1GetEditText
        OnKeyUp = StringGrid1KeyUp
        OnSelectCell = StringGrid1SelectCell
        OnSetEditText = StringGrid1SetEditText
      end
      object EditLine: TEdit
        Left = 0
        Top = 8
        Width = 673
        Height = 21
        TabOrder = 1
        OnChange = EditLineChange
        OnEnter = EditLineEnter
        OnExit = EditLineExit
      end
      object btCreateReqs: TButton
        Left = 3
        Top = 242
        Width = 97
        Height = 25
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1088#1086#1089#1099
        TabOrder = 2
        OnClick = btCreateReqsClick
      end
      object btnSave: TButton
        Left = 187
        Top = 242
        Width = 75
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 3
        OnClick = btnSaveClick
      end
      object btnOpen: TButton
        Left = 268
        Top = 242
        Width = 75
        Height = 25
        Caption = #1054#1090#1082#1088#1099#1090#1100
        TabOrder = 4
        OnClick = btnOpenClick
      end
      object btnNew: TButton
        Left = 106
        Top = 242
        Width = 75
        Height = 25
        Caption = #1057#1086#1079#1076#1072#1090#1100
        TabOrder = 5
        OnClick = btnNewClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 3
      object RadioGroup1: TRadioGroup
        Left = 3
        Top = 3
        Width = 185
        Height = 81
        Caption = #1053#1086#1089#1080#1090#1077#1083#1100
        ItemIndex = 0
        Items.Strings = (
          'ruToken'
          'eToken'
          #1055#1091#1089#1090#1086#1081' '#1055#1048#1053)
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 90
        Width = 185
        Height = 105
        Caption = #1043#1086#1088#1103#1095#1080#1077' '#1082#1083#1072#1074#1080#1096#1080
        TabOrder = 1
        object Label2: TLabel
          Left = 19
          Top = 20
          Width = 12
          Height = 13
          Caption = 'F5'
        end
        object ComboBox1: TComboBox
          Left = 37
          Top = 19
          Width = 145
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  object ida: TIdAntiFreeze
    Left = 744
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 872
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 800
    Top = 8
  end
end
