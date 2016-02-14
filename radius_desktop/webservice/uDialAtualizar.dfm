object frmAtualizacao: TfrmAtualizacao
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Radius'
  ClientHeight = 64
  ClientWidth = 405
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
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 405
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'ATUALIZA'#199#195'O DO SISTEMA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 246
  end
  object pbprogresso: TProgressBar
    Left = 0
    Top = 28
    Width = 405
    Height = 17
    Align = alBottom
    TabOrder = 0
  end
  object statusBar: TStatusBar
    Left = 0
    Top = 45
    Width = 405
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object IdHTTP: TIdHTTP
    OnWork = IdHTTPWork
    OnWorkBegin = IdHTTPWorkBegin
    OnWorkEnd = IdHTTPWorkEnd
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
  end
end
