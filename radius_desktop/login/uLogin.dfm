object fmrLogin: TfmrLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 126
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edtUsuario: TEdit
    Left = 8
    Top = 8
    Width = 265
    Height = 31
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TextHint = 'USUARIO'
  end
  object edtSenha: TEdit
    Left = 8
    Top = 45
    Width = 265
    Height = 31
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    TextHint = 'SENHA'
  end
  object bbEntrar: TBitBtn
    Left = 143
    Top = 82
    Width = 129
    Height = 31
    Caption = 'Entrar'
    Default = True
    Glyph.Data = {
      36080000424D3608000000000000360000002800000020000000100000000100
      20000000000000080000C40E0000C40E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000791FEB037B1EFF007F0004000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000505050EB515151FF4A4A4A040000000000000000000000000000000062B0
      D70D86787813B3501E989F401FE3A53F22F5AC461BFAAB441BFAA04121F69F3D
      1EEA0B7F24FA43A15FFF027C22CF007F2A06000000000000000000000000B3B3
      B30D797979134B4B4B98404040E3414141F5444444FA434343FA414141F63E3E
      3EEA575757FA828282FF535353CF5757570600000000000000006DA2D2791F72
      CDFB865F5FFBBF6035FFFEB961FFFEB962FF239751FF1D9149FF178F43FF118B
      3BFF3A9F5EFF80C196FF46A362FF058131E9006D240700000000AAAAAA798484
      84FB636363FB5D5D5DFFA6A6A6FFA6A6A6FF757575FF6E6E6EFF6B6B6BFF6565
      65FF808080FFACACACFF858585FF5B5B5BE94B4B4B0700000000297DCAFE82BA
      EEFF9F6658FFF5BB84FFFFAC5BFFFEA85AFF299B5BFF90CAA9FF8DC8A5FF8AC6
      A1FF88C59EFF6AB685FF82C297FF48A566FF007C21D700711C098B8B8BFEC3C3
      C3FF686868FFB0B0B0FF9C9C9CFF9A9A9AFF7B7B7BFFB9B9B9FFB7B7B7FFB4B4
      B4FFB2B2B2FF9E9E9EFFAEAEAEFF878787FF535353D74B4B4B09287CCEFC78B3
      EAFFB39E94FFFFB760FFFFB663FFFEB261FF319F63FF94CDADFF6FBA8EFF6BB8
      89FF66B685FF61B380FF67B582FF83C298FF3CA05CFF00781EF98B8B8BFCBDBD
      BDFF9D9D9DFFA4A4A4FFA5A5A5FFA2A2A2FF808080FFBDBDBDFFA4A4A4FFA1A1
      A1FF9E9E9EFF9A9A9AFF9D9D9DFFAEAEAEFF808080FF505050F99F5229508A54
      44FFFCC8ABFFFFD198FFFEC76DFFFEBF68FF37A36BFF96CEB0FF94CDADFF91CB
      AAFF90CBA8FF74BC90FF8AC7A1FF46A568FF07872EFB00FF00014E4E4E505555
      55FFC5C5C5FFC4C4C4FFB2B2B2FFABABABFF868686FFBEBEBEFFBDBDBDFFBABA
      BAFFBABABAFFA6A6A6FFB4B4B4FF888888FF5E5E5EFB96969601FF000001AA45
      0D60C44C1FFFF6E4D6FFFFE4A4FFFFD472FF3DA56FFF3AA36DFF36A167FF329E
      61FF55AF7CFF91CBAAFF4FAB74FF178F45FB00FF0001000000001C1C1C013F3F
      3F604B4B4BFFE1E1E1FFD3D3D3FFBBBBBBFF898989FF878787FF838383FF7F7F
      7FFF959595FFBABABAFF909090FF6B6B6BFB969696010000000000000000B648
      2407A5481369BC481CFFF4E2D4FF4E7BA9FF4D7BA8FF4D7BA8FF4E7BA9FFF3D6
      C3FF3C985DFF5AB381FF289857FF000000000000000000000000000000004949
      490742424269474747FFDFDFDFFF838383FF838383FF838383FF838383FFD3D3
      D3FF7C7C7CFF9A9A9AFF787878FF000000000000000000000000000000000000
      000099330005693A25A2346DA7FF9CCCF8FFAFD4F7FFAFD4F7FFA5CFF6FF3474
      AEFF3A9668F9319F65FF00000000000000000000000000000000000000000000
      00002E2E2E05383838A2787878FFD3D3D3FFDADADAFFDADADAFFD6D6D6FF7E7E
      7EFF7E7E7EF9818181FF00000000000000000000000000000000000000000000
      000000000000295B90C4A6CAEEFFABCCEAFFA7D0F6FFA8D0F6FFABCCEAFFA7CD
      EEFF2D6198CC0000000000000000000000000000000000000000000000000000
      000000000000656565C4D0D0D0FFD1D1D1FFD6D6D6FFD7D7D7FFD1D1D1FFD2D2
      D2FF6B6B6BCC0000000000000000000000000000000000000000000000000000
      0000000000001F5C94EDD9E8F7FF97C5F1FF8EBBE5FF7FA9D1FF89B5DFFFCDDF
      EEFF1C64A7F155AAD40600000000000000000000000000000000000000000000
      000000000000666666EDEAEAEAFFCDCDCDFFC2C2C2FFB0B0B0FFBCBCBCFFE1E1
      E1FF707070F1ADADAD0600000000000000000000000000000000000000000000
      0000000000000C3E87FF7C97B8FF8AB7E4FF719CC8FF15406EFF194472FF2245
      6BFF113B5FFA486D910700000000000000000000000000000000000000000000
      0000000000004E4E4EFF9D9D9DFFBFBFBFFFA4A4A4FF494949FF4D4D4DFF4C4C
      4CFF414141FA7373730700000000000000000000000000000000000000000000
      0000000000000F4B97FF12589FFF0F4A8AFF0F4B87FF114B87FF154C85FF1241
      75FF092D5CF10000000000000000000000000000000000000000000000000000
      0000000000005B5B5BFF656565FF565656FF565656FF565656FF575757FF4B4B
      4BFF373737F10000000000000000000000000000000000000000000000000000
      00000000000011336677114E8FFE12589BFF125899FF115393FF0F4A87FF0E3E
      71FE132D4B810000000000000000000000000000000000000000000000000000
      0000000000003E3E3E775B5B5BFE646464FF636363FF5E5E5EFF555555FF4848
      48FE333333810000000000000000000000000000000000000000000000000000
      0000000000000000000014356A7D0B488DF4104B90FF0F488AFF0C3F76F51532
      5A84000000000000000000000000000000000000000000000000000000000000
      000000000000000000004141417D565656F4595959FF555555FF4A4A4AF53A3A
      3A84000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    ModalResult = 6
    NumGlyphs = 2
    TabOrder = 2
    OnClick = bbEntrarClick
  end
  object bbCancela: TBitBtn
    Left = 8
    Top = 82
    Width = 129
    Height = 31
    Caption = 'Cancelar'
    Glyph.Data = {
      36080000424D3608000000000000360000002800000020000000100000000100
      20000000000000080000C40E0000C40E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003E3EEB413F3FDF08000000000000000000000000000000000000
      0000000000001F1FDF081F1BE341000000000000000000000000000000000000
      000000000000717171416F6F6F08000000000000000000000000000000000000
      0000000000005858580857575741000000000000000000000000000000000000
      00004A46EF414F4CF2FF3F3EE7FD3F3FDF080000000000000000000000000000
      00001F1FDF082422DEFC312FEAFF1F1BE3410000000000000000000000000000
      0000797979417E7E7EFF707070FD6F6F6F080000000000000000000000000000
      0000585858085A5A5AFC676767FF575757410000000000000000000000005252
      F3415856F5FF6361FAFF5855F6FF3B39E7FC3F3FDF0800000000000000003F1F
      DF082A2AE0FC413FF1FF4C4AF6FF312FEAFF1F1BE34100000000000000008282
      8241858585FF8F8F8FFF858585FF6D6D6DFC6F6F6F0800000000000000005C5C
      5C08606060FC747474FF7D7D7DFF676767FF5757574100000000000000005858
      F32B5B58F6FF6562FAFF7170FFFF5956F6FF3C3AE8FC3F3FDF083F3FDF082F2C
      E3FC4745F2FF6362FFFF4A48F4FF2F2DE9FF231DE12B00000000000000008686
      862B878787FF8F8F8FFF9B9B9BFF868686FF6E6E6EFC6F6F6F086F6F6F086363
      63FC797979FF919191FF7B7B7BFF656565FF5858582B00000000000000000000
      00005858F32B5B59F6FF6663FAFF7471FFFF5A58F6FF3D3BE8FC3E3CE6FD504D
      F4FF6867FFFF504EF5FF3634EBFF2929E72B0000000000000000000000000000
      00008686862B888888FF909090FF9B9B9BFF878787FF6F6F6FFC6F6F6FFD7F7F
      7FFF949494FF808080FF6B6B6BFF6262622B0000000000000000000000000000
      0000000000005858F32B5C5AF6FF6764FAFF7472FFFF7370FFFF706EFFFF6E6C
      FFFF5755F7FF3F3DEEFF2F2FE72B000000000000000000000000000000000000
      0000000000008686862B898989FF919191FF9C9C9CFF9B9B9BFF999999FF9898
      98FF858585FF727272FF6666662B000000000000000000000000000000000000
      000000000000000000005E58F32B5D5BF7FF7976FFFF5956FFFF5754FFFF7270
      FFFF4846F0FF3B3BED2B00000000000000000000000000000000000000000000
      000000000000000000008787872B8A8A8AFF9F9F9FFF898989FF878787FF9B9B
      9BFF797979FF7070702B00000000000000000000000000000000000000000000
      000000000000000000005F5FFF085754F0FD7D79FFFF5E5BFFFF5B58FFFF7674
      FFFF403FE9FD3F3FDF0800000000000000000000000000000000000000000000
      000000000000000000008F8F8F08838383FDA1A1A1FF8C8C8CFF8A8A8AFF9D9D
      9DFF727272FD6F6F6F0800000000000000000000000000000000000000000000
      0000000000005F5FFF086663F3FC706DFBFF807EFFFF7E7BFFFF7C79FFFF7977
      FFFF5E5CF7FF413EE9FC3F3FDF08000000000000000000000000000000000000
      0000000000008F8F8F088E8E8EFC979797FFA4A4A4FFA2A2A2FFA1A1A1FFA0A0
      A0FF8A8A8AFF717171FC6F6F6F08000000000000000000000000000000000000
      00007F5FFF086E6BF6FC7774FDFF8682FFFF7673FCFF6462F8FF605DF7FF6D6A
      FAFF7B79FFFF605DF7FF423FE9FC3F3FDF080000000000000000000000000000
      000092929208959595FC9D9D9DFFA7A7A7FF9C9C9CFF8F8F8FFF8B8B8BFF9595
      95FFA1A1A1FF8B8B8BFF727272FC6F6F6F080000000000000000000000007F7F
      FF086E6BF8FD7D7AFEFF8A87FFFF7C79FDFF6C69FBFF645EF92B5E5EF92B615E
      F8FF6E6CFAFF7D7AFFFF615FF7FF4340EAFC3333FF050000000000000000A5A5
      A508959595FDA1A1A1FFABABABFFA0A0A0FF959595FF8D8D8D2B8C8C8C2B8C8C
      8CFF969696FFA2A2A2FF8C8C8CFF737373FC7070700500000000000000007373
      FE1F7A77FFFF817EFFFF817EFEFF7471FDFF6A6AF92B00000000000000005E5E
      F92B625FF8FF6F6DFBFF7E7CFFFF625FF8FF4947EE6F7F7FFF02000000009C9C
      9C1FA0A0A0FFA5A5A5FFA4A4A4FF9B9B9BFF9494942B00000000000000008C8C
      8C2B8D8D8DFF979797FFA3A3A3FF8D8D8DFF7979796FA5A5A502000000000000
      00007373FE1F7A77FFFF7976FEFF7070FE2B0000000000000000000000000000
      00005E5EF92B6461F8FF6A68F9FF5350F1A8504AF22900000000000000000000
      00009C9C9C1FA0A0A0FF9F9F9FFF9A9A9A2B0000000000000000000000000000
      00008C8C8C2B8E8E8EFF939393FF808080A87D7D7D2900000000000000000000
      0000000000007373FE1F7676FE2B000000000000000000000000000000000000
      000000000000645EF92B5B5BF86F5A56F63E0000000000000000000000000000
      0000000000009C9C9C1F9E9E9E2B000000000000000000000000000000000000
      0000000000008D8D8D2B8A8A8A6F8686863E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006666FF0A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009393930A000000000000000000000000}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bbCancelaClick
  end
end
