object FormOsKey: TFormOsKey
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = ' OsKey v0.2'
  ClientHeight = 406
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    0000000000000888888888800000000000000000000000888888880700000000
    0000000000000088888888077000000000000000000000088888807777000000
    0000000000000000000000777700000000000000000000008880080770000000
    0000000000000000080F0080700000000000F0F00000000000F0F00000000000
    0000F0F00000000000F00F000000000000000FF0000000000FFF000000000000
    0000FFF000000000FFF0F000000000000000FFF000000000FFF0000000000000
    0000FFF00000000FFF0F000F00000000000FFFF00000000FFF0000F000000000
    000FFFF0000000FFFFF00F0000000000000FFFFF00000FFFF00FF00000000000
    000FFFFFF000FFFF0F0F00000000000000FFFFFFFFFFFFFF00F0000000000000
    00FFFFFFFFFFFFF0F00000000000000000FFFFFFFFFFFF0F0000000000000000
    0FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFF000000000000000000
    0FFFFFFFFFFFF00000000000000000190FFFFFFFFFFF00000000000000000190
    FFFFFFFFFFF000000000000000000910FFFFFFFFFF0000000000000000000191
    00FFFFFFF0000000000000000000091919000000090000000000000000000091
    9191919190000000000000000000000019191910000000000000000000000000
    0000000000000000000000000000FFFF001FFFFF000FFFFF8007FFFF8003FFFF
    C001FFFFC001FFFFE003FF1FF003FE0FF807FE0FF81FFE0FF03FFE0FE03FFE0F
    E067FE0FC047FC0FC08FFC0F801FFC07003FFC00007FF80000FFF80001FFF800
    07FFF0000FFFF0001FFFC0003FFF80007FFF0000FFFF0001FFFF0001FFFF0001
    FFFF8003FFFFC007FFFFF01FFFFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    000008888000000000000088077000000000000000000000F000000880000000
    F000000000000000F00000F00F000000F0000FF7F0000000FF00FF7F0000000F
    FFFFF7F00000000FFFFFFF000000000FFFFFF00000000000FFFF000000000990
    00000000000001199900000000000000000000000000FF030000FF010000FF80
    0000F3810000E3C10000E3830000E3890000E3030000E0070000C00F0000C01F
    0000803F0000007F000000FF000000FF000081FF0000}
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 159
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 8
    Top = 178
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 193
    Top = 187
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 193
    Top = 206
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label10: TLabel
    Left = 8
    Top = 201
    Width = 38
    Height = 13
    Caption = 'Label10'
  end
  object aktiveLabel: TLabel
    Left = 8
    Top = 225
    Width = 55
    Height = 13
    Caption = 'aktiveLabel'
  end
  object txtStatus: TMemo
    Left = 8
    Top = 47
    Width = 344
    Height = 106
    ReadOnly = True
    TabOrder = 0
    OnChange = txtStatusChange
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 33
    Caption = 'Nastav sken kl'#225'vesnice'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 8
    Width = 161
    Height = 33
    Caption = 'Zru'#353' sken kl'#225'vesnice'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 376
    Top = 8
    Width = 257
    Height = 225
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 49
      Height = 13
      Caption = 'Nastaven'#237
    end
    object CestaLabelEdit: TLabeledEdit
      Left = 8
      Top = 55
      Width = 185
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'Cesta k soubor'#367'm'
      TabOrder = 0
      OnDblClick = CestaLabelEditDblClick
    end
    object BitBtn1: TBitBtn
      Left = 199
      Top = 53
      Width = 25
      Height = 25
      Caption = '. . .'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object Button5: TButton
      Left = 8
      Top = 82
      Width = 89
      Height = 25
      Caption = 'Add registry '
      TabOrder = 2
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 103
      Top = 82
      Width = 75
      Height = 25
      Caption = 'Delete Registry'
      TabOrder = 3
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 8
      Top = 113
      Width = 89
      Height = 25
      Caption = 'schovej'
      TabOrder = 4
      OnClick = Button7Click
    end
    object Button3: TButton
      Left = 103
      Top = 113
      Width = 75
      Height = 25
      Caption = 'skryj soubor'
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 8
      Top = 144
      Width = 89
      Height = 25
      Caption = 'MapDrive'
      TabOrder = 6
      OnClick = Button4Click
    end
    object Button8: TButton
      Left = 103
      Top = 144
      Width = 75
      Height = 25
      Caption = 'UnMap'
      TabOrder = 7
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 8
      Top = 175
      Width = 89
      Height = 25
      Caption = 'ini'
      TabOrder = 8
      OnClick = Button9Click
    end
  end
  object Edit1: TEdit
    Left = 231
    Top = 157
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object LabeledEdit1: TLabeledEdit
    Left = 231
    Top = 198
    Width = 121
    Height = 21
    EditLabel.Width = 18
    EditLabel.Height = 13
    EditLabel.Caption = 'poc'
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 376
    Top = 239
    Width = 257
    Height = 154
    Caption = 'Log'
    TabOrder = 6
    object ListBox1: TListBox
      Left = 16
      Top = 16
      Width = 225
      Height = 121
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 185
    Top = 225
    Width = 185
    Height = 168
    Caption = 'Nastaven'#237' ini'
    TabOrder = 7
    object Label6: TLabel
      Left = 24
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object Label7: TLabel
      Left = 64
      Top = 24
      Width = 12
      Height = 13
      Caption = '00'
    end
    object Label8: TLabel
      Left = 13
      Top = 43
      Width = 36
      Height = 13
      Caption = 'Enable:'
    end
    object Label9: TLabel
      Left = 64
      Top = 43
      Width = 22
      Height = 13
      Caption = 'True'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 352
    Top = 120
  end
  object OpenDialog1: TOpenDialog
    FileName = 'C:\delphi\undetectable-keylogger-master\Project1.res'
    Options = [ofAllowMultiSelect, ofPathMustExist, ofEnableSizing]
    Left = 352
    Top = 80
  end
  object TrayIcon1: TTrayIcon
    Hint = 'Oskey '
    BalloonFlags = bfInfo
    Icon.Data = {
      0000010002002020100000000000E80200002600000010101000000000002801
      00000E0300002800000020000000400000000100040000000000800200000000
      0000000000000000000000000000000000000000800000800000008080008000
      0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
      0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000888888888800000000000000000000000888888880700000000
      0000000000000088888888077000000000000000000000088888807777000000
      0000000000000000000000777700000000000000000000008880080770000000
      0000000000000000080F0080700000000000F0F00000000000F0F00000000000
      0000F0F00000000000F00F000000000000000FF0000000000FFF000000000000
      0000FFF000000000FFF0F000000000000000FFF000000000FFF0000000000000
      0000FFF00000000FFF0F000F00000000000FFFF00000000FFF0000F000000000
      000FFFF0000000FFFFF00F0000000000000FFFFF00000FFFF00FF00000000000
      000FFFFFF000FFFF0F0F00000000000000FFFFFFFFFFFFFF00F0000000000000
      00FFFFFFFFFFFFF0F00000000000000000FFFFFFFFFFFF0F0000000000000000
      0FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFF000000000000000000
      0FFFFFFFFFFFF00000000000000000190FFFFFFFFFFF00000000000000000190
      FFFFFFFFFFF000000000000000000910FFFFFFFFFF0000000000000000000191
      00FFFFFFF0000000000000000000091919000000090000000000000000000091
      9191919190000000000000000000000019191910000000000000000000000000
      0000000000000000000000000000FFFF001FFFFF000FFFFF8007FFFF8003FFFF
      C001FFFFC001FFFFE003FF1FF003FE0FF807FE0FF81FFE0FF03FFE0FE03FFE0F
      E067FE0FC047FC0FC08FFC0F801FFC07003FFC00007FF80000FFF80001FFF800
      07FFF0000FFFF0001FFFC0003FFF80007FFF0000FFFF0001FFFF0001FFFF0001
      FFFF8003FFFFC007FFFFF01FFFFF280000001000000020000000010004000000
      0000C00000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
      000008888000000000000088077000000000000000000000F000000880000000
      F000000000000000F00000F00F000000F0000FF7F0000000FF00FF7F0000000F
      FFFFF7F00000000FFFFFFF000000000FFFFFF00000000000FFFF000000000990
      00000000000001199900000000000000000000000000FF030000FF010000FF80
      0000F3810000E3C10000E3830000E3890000E3030000E0070000C00F0000C01F
      0000803F0000007F000000FF000000FF000081FF0000}
    Visible = True
    OnClick = TrayIcon1Click
    OnDblClick = TrayIcon1DblClick
    Left = 352
    Top = 32
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 352
    Top = 184
  end
end