inherited frmKeyGen: TfrmKeyGen
  Caption = 'KeyGen'
  ClientHeight = 163
  ClientWidth = 580
  ExplicitWidth = 596
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 13
  object lblResultado: TLabel
    Left = 126
    Top = 72
    Width = 99
    Height = 13
    Caption = '                                 '
  end
  object Button1: TButton
    Left = 8
    Top = 35
    Width = 108
    Height = 25
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 66
    Width = 108
    Height = 25
    Caption = 'Validar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object maskSerial: TMaskEdit
    Left = 322
    Top = 37
    Width = 108
    Height = 21
    Hint = 'Serial para libera'#231#227'o do sistema'
    EditMask = '0000\-0000\-0000;1;_'
    MaxLength = 14
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '    -    -    '
  end
  object edtValidade: TEdit
    Left = 122
    Top = 37
    Width = 67
    Height = 21
    TabOrder = 3
    Text = '25/09/2016'
  end
  object edtCnj: TEdit
    Left = 195
    Top = 37
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 4
    Text = '0123456789'
  end
end
