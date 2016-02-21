program RadiusDesktop;

{$WEAKLINKRTTI ON}

uses
  Vcl.Forms,
  uSplash in 'splash\uSplash.pas' {frmSplash},
  uVerificarLiberacao in 'webservice\uVerificarLiberacao.pas',
  uMaster in 'master\uMaster.pas' {frmMaster},
  uAtualizar in 'webservice\uAtualizar.pas',
  uMD5 in 'criptografia\uMD5.pas',
  uDialAtualizar in 'webservice\uDialAtualizar.pas' {frmAtualizacao},
  uSuporte in 'suporte\uSuporte.pas',
  uWindows in 'windows\uWindows.pas',
  uLogs in 'logs\uLogs.pas',
  uConstantes in 'constantes\uConstantes.pas',
  uLogin in 'login\uLogin.pas' {fmrLogin},
  internet in 'webservice\internet.pas',
  uSeriaisLogicos in 'windows\uSeriaisLogicos.pas',
  uHardware in 'hardware\uHardware.pas',
  uCadMaster in 'master\cadastro\uCadMaster.pas' {frmCadMaster},
  uPrincipalSistema in 'master\principal\uPrincipalSistema.pas' {frmPrincipalSistema},
  uPrincipalRadiusReal in 'sistemas\radiusReal\principal\uPrincipalRadiusReal.pas' {frmPrincipalRadiusReal},
  uPesquisa in 'master\consulta\uPesquisa.pas' {frmPesquisar},
  uCliente in 'auxiliar\uCliente.pas',
  uConsulta in 'auxiliar\uConsulta.pas',
  uData in 'auxiliar\uData.pas',
  uHora in 'auxiliar\uHora.pas',
  uString in 'auxiliar\uString.pas',
  uUsuario in 'auxiliar\uUsuario.pas',
  uWebNavegacao in 'auxiliar\uWebNavegacao.pas' {frmNavegacao},
  uRealCadEntradaEstoque in 'sistemas\radiusReal\cadastro\uRealCadEntradaEstoque.pas' {frmEntradaEstoque},
  uRealCadProduto in 'sistemas\radiusReal\cadastro\uRealCadProduto.pas' {frmRealCadProduto},
  uPesquisasPadrao in 'sistemas\radiusReal\cadastro\pesquisas\uPesquisasPadrao.pas',
  uAbreCaixa in 'sistemas\radiusReal\processamento\uAbreCaixa.pas' {frmAberturaCaixa},
  uAlteraStatusComanda in 'sistemas\radiusReal\processamento\uAlteraStatusComanda.pas' {frmAlterarStatusComanda},
  uComanda in 'sistemas\radiusReal\processamento\uComanda.pas' {frmComanda},
  uEstoque in 'sistemas\radiusReal\processamento\uEstoque.pas',
  uFechaCaixa in 'sistemas\radiusReal\processamento\uFechaCaixa.pas' {frmFechamentoCaixa},
  uConsultaComanda in 'consultas\uConsultaComanda.pas',
  uConsultasCliente in 'consultas\uConsultasCliente.pas',
  uConsultaCaixa in 'sistemas\radiusReal\consultas\uConsultaCaixa.pas',
  uDelete in 'bancoDeDados\uDelete.pas',
  uInsert in 'bancoDeDados\uInsert.pas',
  uUpdate in 'bancoDeDados\uUpdate.pas',
  uRealRelatorio in 'sistemas\radiusReal\relatorio\uRealRelatorio.pas',
  dmPrincipal in 'dataModule\dmPrincipal.pas' {frmDmPrincipal: TDataModule},
  dmRelatoriosFast in 'dataModule\dmRelatoriosFast.pas' {dmRelatorioFast: TDataModule},
  uAuxValidacao in 'validacao\uAuxValidacao.pas',
  uValidarSistema in 'validacao\uValidarSistema.pas' {frmValidarSistema},
  uValidaSerial in 'validacao\uValidaSerial.pas',
  uFirebird in 'firebird\uFirebird.pas',
  uPrincipal in 'principal\uPrincipal.pas' {frmPrincipal},
  Vcl.Themes,
  Vcl.Styles,
  uGerarSerial in 'keygen\uGerarSerial.pas',
  uKeyGen in 'keygen\uKeyGen.pas' {frmKeyGen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDmPrincipal, frmDmPrincipal);
  Application.CreateForm(TdmRelatorioFast, dmRelatorioFast);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.Run;

end.
