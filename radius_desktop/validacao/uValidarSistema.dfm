object frmValidarSistema: TfrmValidarSistema
  Left = 0
  Top = 0
  Caption = 'Valida'#231#227'o de Sistema'
  ClientHeight = 273
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 66
    Height = 13
    Caption = 'Serial Cliente:'
  end
  object Label3: TLabel
    Left = 7
    Top = 43
    Width = 67
    Height = 13
    Caption = 'Nome Cliente:'
  end
  object Label4: TLabel
    Left = 9
    Top = 72
    Width = 65
    Height = 13
    Caption = 'Respons'#225'vel:'
  end
  object Label5: TLabel
    Left = 173
    Top = 16
    Width = 29
    Height = 13
    Caption = 'CNPJ:'
  end
  object Button1: TButton
    Left = 80
    Top = 239
    Width = 368
    Height = 25
    Caption = 'Validar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 80
    Top = 35
    Width = 369
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object Edit4: TEdit
    Left = 80
    Top = 64
    Width = 368
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object Edit5: TEdit
    Left = 208
    Top = 8
    Width = 240
    Height = 21
    TabOrder = 3
  end
  object Edit2: TMaskEdit
    Left = 80
    Top = 8
    Width = 87
    Height = 21
    Hint = 'Serial para libera'#231#227'o do sistema'
    EditMask = '0000\-0000\-0000;1;_'
    MaxLength = 14
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = '    -    -    '
  end
  object GroupBox1: TGroupBox
    Left = 80
    Top = 91
    Width = 368
    Height = 142
    Caption = ' Novo usu'#225'rio: '
    TabOrder = 5
    object edtNomeNovoUsuario: TEdit
      Left = 11
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'edtNomeUsuario'
      TextHint = 'Nome'
    end
    object edtSenhaNovoUsuario: TEdit
      Left = 11
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edtSenhaUsuario'
      TextHint = 'Senha'
    end
    object edtConfirmSenha: TEdit
      Left = 138
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edtSenhaUsuario'
      TextHint = 'Senha'
    end
    object edtDicaSenha: TEdit
      Left = 11
      Top = 78
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'edtDicaSenha'
      TextHint = 'Dica de Senha'
    end
    object edtemail: TEdit
      Left = 11
      Top = 105
      Width = 350
      Height = 21
      TabOrder = 4
      Text = 'edtemail'
      TextHint = 'Email'
    end
  end
end
