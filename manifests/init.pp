# == Class: jenkins
# ===========================
#
#
# Description of the Class:
#
#   Install and configure the Jenkins CI service
#      including plug-ins and current jobs
#
#
# Document all Parameters:
#
#   package_name       = the Jenkins package
#   version            = specific version of Jenkins to install (needs to be like this: '4.1.2-29.el6')
#   java_install       = 'true' for installing the correct Java version
#   java_package       = explicit version the java package i.E. java-1.8.0-openjdk
#   jvm_memory         = set-up the JVM memory requirements
#   jvm_port           = Java listenign port
#   user               = Jenkins user
#   uid                = Jenkins uid/gid NATS default
#   home_dir           = Jenkins home directory
#   repo_server        = CName or IP address of repository server
#   plugin_cli         = Jenkins CLI file
#   plugin_location    = URL to install Jenkins plugins from
#   jenkins_url        = Jenkins URL: http://some_server:8080/<jenkins_url>
#   jenkins_tmp        = Jenkins tmp directory
#   jenkins_setup      = extra set-up parameter for installation
#   ad_enable          = configure AD when set to true
#   ad_name            = Name of AD connection
#   ad_servers         = the AD server string in CSV
#   ad_site            = the AD domain strings
#   ad_bind            = the AD bind name
#   ad_passwd          = the passwd for AD lookup
#
#
# ===========================
#
#
# == Authors
# ----------
#
# Author: Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2017  NATS / Addi.
#
#
class jenkins (
  $package_name       = $jenkins::params::package_name,
  $version            = $jenkins::params::version,
  $java_install       = $jenkins::params::java_install,
  $java_package       = $jenkins::params::java_package,
  $jvm_memory         = $jenkins::params::jvm_memory,
  $jvm_port           = $jenkins::params::jvm_port,
  $user               = $jenkins::params::user,
  $uid                = $jenkins::params::uid,
  $home_dir           = $jenkins::params::home_dir,
  $repo_server        = $jenkins::params::repo_server,
  $plugin_cli         = $jenkins::params::plugin_cli,
  $plugin_location    = $jenkins::params::plugin_location,
  $jenkins_url        = $jenkins::params::jenkins_url,
  $jenkins_tmp        = $jenkins::params::jenkins_tmp,
  $jenkins_setup      = $jenkins::params::jenkins_setup,
  $ad_enable          = $jenkins::params::ad_enable,
  $ad_name            = $jenkins::params::ad_name,
  $ad_servers         = $jenkins::params::ad_servers,
  $ad_site            = $jenkins::params::ad_site,
  $ad_bind            = $jenkins::params::ad_bind,
  $ad_passwd          = $jenkins::params::ad_passwd,
  $export_haproxy     = undef
) inherits jenkins::params {

  contain jenkins::account
  contain jenkins::install
  contain jenkins::config
  contain jenkins::service
  contain jenkins::plugins
  contain jenkins::setup
  Class['::jenkins::account']
  ~> Class['::jenkins::install']
  ~> Class['::jenkins::config']
  ~> Class['::jenkins::service']
  ~> Class['::jenkins::plugins']
  ~> Class['::jenkins::setup']

  if ($export_haproxy) {
    profiles::haproxy::export{'ciserver':
      ports => $jvm_port,
    }
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
