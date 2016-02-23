inherited frmFechamentoCaixa: TfrmFechamentoCaixa
  BorderStyle = bsDialog
  Caption = 'Fechamento de Caixa'
  ClientHeight = 154
  ClientWidth = 224
  OnShow = FormShow
  ExplicitWidth = 230
  ExplicitHeight = 183
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
    Top = 70
    Width = 58
    Height = 13
    Caption = 'Valor Inicial:'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 40
    Height = 13
    Caption = 'Usu'#225'rio:'
  end
  object Label5: TLabel
    Left = 8
    Top = 97
    Width = 48
    Height = 13
    Caption = 'Em Caixa:'
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 65
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 143
    Top = 8
    Width = 65
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 72
    Top = 62
    Width = 136
    Height = 21
    TabStop = False
    Alignment = taRightJustify
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 72
    Top = 116
    Width = 136
    Height = 25
    Caption = 'Fechar Caixa'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 72
    Top = 35
    Width = 136
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object Edit6: TEdit
    Left = 72
    Top = 89
    Width = 136
    Height = 21
    Alignment = taRightJustify
    Color = clWhite
    TabOrder = 5
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 24
    Top = 120
  end
end
