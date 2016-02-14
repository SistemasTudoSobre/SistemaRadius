inherited frmComanda: TfrmComanda
  Caption = 'Comanda'
  ClientHeight = 500
  ClientWidth = 992
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 1008
  ExplicitHeight = 539
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 992
    Height = 57
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1041
    DesignSize = (
      992
      57)
    object Label2: TLabel
      Left = 8
      Top = 5
      Width = 137
      Height = 52
      Caption = 'COD.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 519
      Top = 6
      Width = 151
      Height = 52
      Caption = 'MESA:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNomeStatusMesa: TEdit
      Left = 763
      Top = 4
      Width = 220
      Height = 47
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      ExplicitWidth = 269
    end
    object edtCodigoComanda: TEdit
      Left = 150
      Top = 4
      Width = 155
      Height = 47
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 1
      OnChange = edtCodigoComandaChange
      OnExit = edtCodigoComandaExit
    end
    object edtMesa: TEdit
      Left = 676
      Top = 4
      Width = 81
      Height = 47
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edtMesaChange
    end
    object edtStatusComanda: TEdit
      Left = 311
      Top = 4
      Width = 186
      Height = 47
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
    end
  end
  object pnlItens: TPanel
    Left = 0
    Top = 97
    Width = 992
    Height = 340
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 1041
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 990
      Height = 338
      Align = alClient
      DataSource = dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
  end
  object pnlTotal: TPanel
    Left = 0
    Top = 437
    Width = 992
    Height = 63
    Align = alBottom
    TabOrder = 3
    ExplicitWidth = 1041
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 107
      Height = 39
      Caption = 'TOTAL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtTotal: TEdit
      Left = 121
      Top = 6
      Width = 288
      Height = 47
      Alignment = taRightJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnExit = edtTotalExit
    end
    object bbAlterarMesa: TBitBtn
      Left = 415
      Top = 6
      Width = 170
      Height = 25
      Caption = 'ALTERAR MESA'
      TabOrder = 1
      OnClick = bbAlterarMesaClick
    end
    object bbCancelarComanda: TBitBtn
      Left = 415
      Top = 29
      Width = 170
      Height = 25
      Caption = 'CANCELAR COMANDA'
      TabOrder = 2
      OnClick = bbCancelarComandaClick
    end
  end
  object pnlAdicionarItem: TPanel
    Left = 0
    Top = 57
    Width = 992
    Height = 40
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 1041
    DesignSize = (
      992
      40)
    object Label4: TLabel
      Left = 8
      Top = 5
      Width = 137
      Height = 34
      Caption = 'Produto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 836
      Top = 1
      Width = 91
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Qtdt.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNomeProduto: TEdit
      Left = 311
      Top = 4
      Width = 519
      Height = 31
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object edtProduto: TEdit
      Left = 150
      Top = 4
      Width = 155
      Height = 31
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtProdutoChange
    end
    object edtQtdt: TEdit
      Left = 933
      Top = 3
      Width = 50
      Height = 31
      Anchors = [akTop, akRight]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnEnter = edtQtdtEnter
      OnExit = edtQtdtExit
      OnKeyPress = edtQtdtKeyPress
    end
  end
  object fdqProdutos: TFDQuery
    Left = 352
    Top = 140
  end
  object dsProdutos: TDataSource
    DataSet = fdqProdutos
    Left = 304
    Top = 140
  end
end
