# == Class jenkins::params
# ===========================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class jenkins::params {

  $package_name       = 'jenkins'
  $version            = '2.60.1'
  $rpm_arch           = '1.1.noarch'
  $java_install       = true
  $java_package       = 'java-1.8.0-openjdk'
  $jvm_memory         = '512'
  $jvm_port           = '8080'
  $user               = 'jenkins'
  $uid                = '1100'
  $home_dir           = '/var/lib/jenkins'
  $git_server         = 'pr-repo1-rp1'
  $repo_server        = 'rpmrepo.abel.uk.com'
  $plugin_cli         = '/var/cache/jenkins/war/WEB-INF/jenkins-cli.jar'
  $plugin_location    = "http://${repo_server}/jenkins-plugins"
  $plugin_update      = '1'
  $jenkins_url        = 'jenkins/'
  $jenkins_tmp        = '-Djava.io.tmpdir=/var/lib/jenkins/tmp'
  $jenkins_setup      = '-Djenkins.install.runSetupWizard=false'
  $jenkins_done       = '/etc/puppetlabs/facter/facts.d/jenkins.yaml'
  $ad_enable          = undef
  $ad_name            = 'som2.nats.co.uk'
  $ad_servers         = 'pr-dc001-ds1.som2.nats.co.uk:3268,pr-dc002-ds1.som2.nats.co.uk:3268'
  $ad_site            = 'DC=som2,DC=nats,DC=co,DC=uk'
  $ad_bind            = 'CN=SVC_LDAPLookUp,OU=Managed Service Accounts,OU=Accounts,DC=som2,DC=nats,DC=co,DC=uk'
  $ad_passwd          = 'this is bla bla bla'

  include jenkins::pluginlist

}


# -----------------------
# vim: set ts=2 sw=2 et :
