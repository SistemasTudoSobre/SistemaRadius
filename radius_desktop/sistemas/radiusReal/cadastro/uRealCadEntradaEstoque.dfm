inherited frmEntradaEstoque: TfrmEntradaEstoque
  Caption = 'Movimento de produto em estoque'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlGeral: TPanel
    object Label1: TLabel
      Left = 8
      Top = 17
      Width = 37
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 8
      Top = 98
      Width = 42
      Height = 13
      Caption = 'Produto:'
    end
    object Label3: TLabel
      Left = 8
      Top = 125
      Width = 60
      Height = 13
      Caption = 'Quantidade:'
    end
    object Label4: TLabel
      Left = 8
      Top = 43
      Width = 40
      Height = 13
      Caption = 'Usu'#225'rio:'
    end
    object Label5: TLabel
      Left = 8
      Top = 70
      Width = 56
      Height = 13
      Caption = 'Movimento:'
    end
    object DBEdit1: TDBEdit
      Left = 73
      Top = 9
      Width = 73
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataSource = dsPadrao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 73
      Top = 90
      Width = 73
      Height = 21
      Hint = 'C'#243'digo do fornecedor'
      DataSource = dsPadrao
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = DBEdit2Change
    end
    object btnEdtNomeProduto: TButtonedEdit
      Left = 152
      Top = 90
      Width = 378
      Height = 21
      Hint = 'Nome do fornecedor'
      TabStop = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = False
      TabOrder = 5
    end
    object DBEdit3: TDBEdit
      Left = 74
      Top = 117
      Width = 73
      Height = 21
      Hint = 'C'#243'digo do fornecedor'
      DataSource = dsPadrao
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object Edit1: TEdit
      Left = 152
      Top = 36
      Width = 176
      Height = 21
      TabStop = False
      Color = clBtnFace
      ParentShowHint = False
      ReadOnly = True
      ShowHint = False
      TabOrder = 6
    end
    object DBEdit4: TDBEdit
      Left = 73
      Top = 63
      Width = 73
      Height = 21
      Hint = 'C'#243'digo do fornecedor'
      Color = clBtnFace
      DataSource = dsPadrao
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 2
      OnChange = DBEdit4Change
    end
    object ButtonedEdit1: TButtonedEdit
      Left = 152
      Top = 63
      Width = 378
      Height = 21
      Hint = 'Nome do fornecedor'
      TabStop = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = False
      TabOrder = 7
    end
    object DBEdit5: TDBEdit
      Left = 73
      Top = 36
      Width = 73
      Height = 21
      Hint = 'C'#243'digo do fornecedor'
      Color = clBtnFace
      DataSource = dsPadrao
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      OnChange = DBEdit5Change
    end
  end
  inherited FDTablePadrao: TFDTable
    IndexFieldNames = 'ID_COD_ESTOQUE'
  end
  inherited imgList: TImageList
    Bitmap = {
      494C010101000800400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6392
      B80021669C007FA6C300FFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C99BF00548C
      BB0088B4DD00175E9600FFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF78A1C7006396C4009CC0
      E4006598C7002E6EA200FFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFE6CC
      B700D9B09000D1A37D00CE9E7900D0A48200AB9E960074A1CC00AACBE80075A3
      CE003E78AC00DCE6EF00FFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFE6C7AD00E8C9
      AD00F5E1CD00F7E5D300F7E5D100F3DDC800DFB99B00C7A7900085ADD5004D84
      B800DFE8F100FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFEFD9C500EDD0B600F8E8
      D900F5DEC800F3D8BC00F3D6BA00F4DBC100F7E4D200DFBA9C009D949200E1EA
      F300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFECCCAF00F7E7D700F6E1
      CC00F4DBC100F4DABF00F3D8BC00F3D7BA00F4DBC100F3DEC900CFA58500FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFEECCAB00F9ECDF00F5DF
      C800F5DDC500F4DCC200F4DAC000F3D9BD00F3D7BC00F8E6D300D1A37D00FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFF2D1B100F9EDE100F6E1
      CC00F5DFC900F5DEC700F4DCC300F4DBC100F4DABF00F8E7D600D5A88400FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFF6D9BE00F9EBDE00F7E7
      D600F6E1CC00F5E0CA00F5DEC800F5DDC400F6E1CB00F5E2D000DDB69600FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFAE8D500F8E2CC00FAEE
      E300F7E7D600F6E2CE00F6E1CB00F6E3D000F9EADD00ECCFB400EAD1BC00FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFF9E2CB00F9E2
      CD00FAECDE00F9EEE200F9EDE200F8E9DA00F0D5BC00EBCDB400FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFAE8
      D700F7DBBF00F4D4B500F2D1B100F1D2B500F3DECB00FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
