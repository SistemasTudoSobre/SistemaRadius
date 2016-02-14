object dmRelatorioFast: TdmRelatorioFast
  OldCreateOrder = False
  Height = 239
  Width = 302
  object frxReportModelo: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42388.847666203700000000
    ReportOptions.LastChange = 42395.861208148150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 8
    Datasets = <
      item
        DataSet = frxDBDatasetModelo
        DataSetName = 'frxDBModelo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxReportModelo.Child1
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 98.267780000000000000
        end
        object Picture1: TfrxPictureView
          Width = 113.385900000000000000
          Height = 98.267780000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[cliente]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 30.236239999999990000
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[tituloRelatorio]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Width = 464.882190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RADIUS - SISTEMAS INTEGRADOS - [usuario]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 604.724800000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 668.976810000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
      end
      object Page: TfrxMemoView
        Left = 570.709030000000000000
        Width = 147.401670000000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          '[Page] / [TotalPages#]')
        ParentFont = False
        Formats = <
          item
          end
          item
          end>
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 139.842610000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxDBDatasetModelo: TfrxDBDataset
    UserName = 'frxDBModelo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODIGO=CODIGO')
    DataSet = cdsModelo
    BCDToCurrency = False
    Left = 64
    Top = 8
  end
  object cdsModelo: TClientDataSet
    PersistDataPacket.Data = {
      290000009619E0BD010000001800000001000000000003000000290006434F44
      49474F04000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 8
    object cdsModeloCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object frxReportListagemProduto: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42388.847666203700000000
    ReportOptions.LastChange = 42395.879402025470000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 72
    Datasets = <
      item
        DataSet = frxDBDatasetListagemProduto
        DataSetName = 'frxDBModelo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxReportListagemProduto.Child1
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 98.267780000000000000
        end
        object Picture1: TfrxPictureView
          Width = 113.385900000000000000
          Height = 98.267780000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[cliente]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 30.236239999999990000
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[tituloRelatorio]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 359.055350000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Width = 464.882190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RADIUS - SISTEMAS INTEGRADOS - [usuario]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 604.724800000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 668.976810000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
      end
      object Page: TfrxMemoView
        Left = 570.709030000000000000
        Width = 147.401670000000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          '[Page] / [TotalPages#]')
        ParentFont = False
        Formats = <
          item
          end
          item
          end>
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetListagemProduto
        DataSetName = 'frxDBModelo'
        RowCount = 0
        object frxDBModeloID_PRODUTO: TfrxMemoView
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'ID_PRODUTO'
          DataSet = frxDBDatasetListagemProduto
          DataSetName = 'frxDBModelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBModelo."ID_PRODUTO"]')
          ParentFont = False
        end
        object frxDBModeloNOME_PRODUTO: TfrxMemoView
          Left = 94.488250000000000000
          Width = 510.236550000000000000
          Height = 15.118120000000000000
          DataField = 'NOME_PRODUTO'
          DataSet = frxDBDatasetListagemProduto
          DataSetName = 'frxDBModelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBModelo."NOME_PRODUTO"]')
          ParentFont = False
        end
        object frxDBModeloVALOR_PRODUTO: TfrxMemoView
          Left = 604.724800000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_PRODUTO'
          DataSet = frxDBDatasetListagemProduto
          DataSetName = 'frxDBModelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBModelo."VALOR_PRODUTO"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'C'#211'DIGO:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 94.488250000000000000
          Width = 510.236550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'NOME DO PRODUTO:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 604.724800000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 139.842610000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxDBDatasetListagemProduto: TfrxDBDataset
    UserName = 'frxDBModelo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_PRODUTO=ID_PRODUTO'
      'NOME_PRODUTO=NOME_PRODUTO'
      'VALOR_PRODUTO=VALOR_PRODUTO')
    DataSet = cdsListagemProduto
    BCDToCurrency = False
    Left = 64
    Top = 72
  end
  object cdsListagemProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 72
    object cdsListagemProdutoID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object cdsListagemProdutoNOME_PRODUTO: TStringField
      FieldName = 'NOME_PRODUTO'
      Size = 150
    end
    object cdsListagemProdutoVALOR_PRODUTO: TCurrencyField
      FieldName = 'VALOR_PRODUTO'
    end
  end
end
