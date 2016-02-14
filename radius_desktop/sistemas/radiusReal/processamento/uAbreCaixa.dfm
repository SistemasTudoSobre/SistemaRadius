inherited frmAberturaCaixa: TfrmAberturaCaixa
  BorderStyle = bsDialog
  Caption = 'Abertura de Caixa'
  ClientHeight = 121
  ClientWidth = 263
  OnShow = FormShow
  ExplicitWidth = 269
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 27
    Height = 13
    Caption = 'Data:'
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 56
    Height = 13
    Caption = 'Valor inicial:'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 40
    Height = 13
    Caption = 'Usu'#225'rio:'
  end
  object Edit1: TEdit
    Left = 70
    Top = 8
    Width = 65
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 141
    Top = 8
    Width = 65
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 70
    Top = 59
    Width = 136
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
  end
  object Button1: TButton
    Left = 70
    Top = 86
    Width = 136
    Height = 25
    Caption = 'Abrir Caixa'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 70
    Top = 35
    Width = 136
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 216
    Top = 8
  end
end
