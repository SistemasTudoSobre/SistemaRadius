object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 303
  Width = 591
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=\\192.168.0.101\TudoSobre\SistemasTudoSobre\banco\radiu' +
        's.db'
      'DriverID=SQLite')
    Left = 56
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 64
    Top = 80
  end
end
