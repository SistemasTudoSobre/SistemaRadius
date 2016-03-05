unit uConstantes;

interface

uses dmPrincipal, FireDAC.Comp.Client, Vcl.Forms;

const
  PROTOCOLO = 'http://';
  DOMINIO = 'tudosobre.info';
  SITE_OFICIAL = PROTOCOLO + DOMINIO;
  RADIUS_SUB_DOMINIO = 'http://demo.nrgthemes.com/projects/nrghostwp/'; // PROTOCOLO + 'radius.' + DOMINIO;
  RADIUS_URL_ATUALIZACAO = RADIUS_SUB_DOMINIO + '/' + 'atualizacao';
  RADIUS_ARQUIVO_WEB_ATUALIZACAO = 'atualizacao.php';
  RADIUS_WEB_SERVICE_ATUALIZACAO = RADIUS_URL_ATUALIZACAO + '/' + RADIUS_ARQUIVO_WEB_ATUALIZACAO;
  RADIUS_URL_SUPORTE = RADIUS_SUB_DOMINIO + '/' + 'suporte';
  RADIUS_ARQUIVO_WEB_SUPORTE = 'suporte.php';
  RADIUS_WEB_SERVICE_SUPORTE = RADIUS_URL_SUPORTE + '/' + RADIUS_ARQUIVO_WEB_SUPORTE;
  RADIUS_BUILD = 'RadiusDesktop';
  CONSTANTE_NOVA = 'GITHUB';

var
  conexaoSistema: TFDConnection;

implementation

//

initialization

if dmPrincipal.frmDmPrincipal = nil then
  Application.CreateForm(TfrmDmPrincipal, frmDmPrincipal);

conexaoSistema := dmPrincipal.frmDmPrincipal.FDConnexao;

end.
