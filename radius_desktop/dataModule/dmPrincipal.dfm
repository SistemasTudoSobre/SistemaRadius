object frmDmPrincipal: TfrmDmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 352
  Width = 553
  object FDConnexao: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\Jonathan\Desktop\migracao\banco\RADIUS.GDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 152
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 32
  end
end
