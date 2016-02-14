inherited frmPesquisar: TfrmPesquisar
  Caption = 'Pesquisar'
  ClientHeight = 377
  ClientWidth = 701
  ExplicitWidth = 717
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 701
    Height = 41
    Align = alTop
    TabOrder = 0
    object ComboBox1: TComboBox
      Left = 8
      Top = 8
      Width = 145
      Height = 21
      TabOrder = 0
      Items.Strings = (
        'Campos')
    end
    object ComboBox2: TComboBox
      Left = 159
      Top = 8
      Width = 145
      Height = 21
      TabOrder = 1
      Items.Strings = (
        'Modo')
    end
    object Edit1: TEdit
      Left = 310
      Top = 8
      Width = 379
      Height = 21
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 701
    Height = 336
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 699
      Height = 309
      Align = alClient
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
    end
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 310
      Width = 699
      Height = 25
      DataSource = DataSource
      Align = alBottom
      Enabled = False
      TabOrder = 1
    end
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 632
    Top = 313
  end
  object FDQuery: TFDQuery
    Left = 592
    Top = 313
  end
end
