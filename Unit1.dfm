object Form1: TForm1
  Left = 1660
  Top = 262
  Caption = 'IP Range Calculator'
  ClientHeight = 263
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object ListBox1: TListBox
    Left = 177
    Top = 0
    Width = 177
    Height = 244
    Align = alLeft
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
    ExplicitHeight = 243
  end
  object Memo1: TMemo
    Left = 354
    Top = 0
    Width = 269
    Height = 244
    TabStop = False
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 265
    ExplicitHeight = 243
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 244
    Align = alLeft
    TabOrder = 2
    ExplicitHeight = 243
    DesignSize = (
      177
      244)
    object Label1: TLabel
      Left = 10
      Top = 14
      Width = 28
      Height = 13
      Caption = 'Start :'
    end
    object Label2: TLabel
      Left = 10
      Top = 62
      Width = 25
      Height = 13
      Caption = 'End :'
    end
    object Edit6: TEdit
      Left = 50
      Top = 77
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 0
      Text = '168'
      OnKeyPress = Edit1KeyPress
    end
    object Edit5: TEdit
      Left = 10
      Top = 77
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 1
      Text = '192'
      OnKeyPress = Edit1KeyPress
    end
    object Edit7: TEdit
      Left = 90
      Top = 77
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 2
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit8: TEdit
      Left = 130
      Top = 77
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 3
      Text = '255'
      OnKeyPress = Edit1KeyPress
    end
    object Edit4: TEdit
      Left = 130
      Top = 29
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 4
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit3: TEdit
      Left = 89
      Top = 29
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 5
      Text = '0'
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 50
      Top = 29
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 6
      Text = '168'
      OnKeyPress = Edit1KeyPress
    end
    object Edit1: TEdit
      Left = 10
      Top = 29
      Width = 33
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 7
      Text = '192'
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 10
      Top = 213
      Width = 153
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Generate Range >>'
      TabOrder = 8
      TabStop = False
      OnClick = Button1Click
      ExplicitTop = 212
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 135
      Width = 67
      Height = 17
      TabStop = False
      Caption = 'Stay Top'
      TabOrder = 9
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 112
      Width = 84
      Height = 17
      TabStop = False
      Caption = 'Save Range'
      TabOrder = 10
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 244
    Width = 623
    Height = 19
    Panels = <
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 243
    ExplicitWidth = 619
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 40
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object Copyall1: TMenuItem
      Caption = 'Copy all'
      OnClick = Copyall1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Geolocation1: TMenuItem
      Caption = 'Geolocation'
      OnClick = Geolocation1Click
    end
    object Ping1: TMenuItem
      Caption = 'Ping'
      OnClick = Ping1Click
    end
    object racert1: TMenuItem
      Caption = 'Tracert'
      OnClick = racert1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object NetworkIP1: TMenuItem
      Caption = 'Network IP'
      OnClick = NetworkIP1Click
    end
    object ExternalIP1: TMenuItem
      Caption = 'External IPv4'
      OnClick = ExternalIP1Click
    end
    object ExternalIPv61: TMenuItem
      Caption = 'External IPv6'
      OnClick = ExternalIPv61Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object HostURL1: TMenuItem
      Caption = 'Host URL'
      OnClick = HostURL1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 296
    Top = 40
  end
end
