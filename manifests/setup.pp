# == Class jenkins::setup
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
class jenkins::setup (
  $package_name       = $jenkins::params::package_name,
  $user               = $jenkins::params::user,
  $home_dir           = $jenkins::params::home_dir,
  $git_server         = $jenkins::params::git_server,
  $ad_enable          = $jenkins::params::ad_enable,
  $ad_name            = $jenkins::params::ad_name,
  $ad_servers         = $jenkins::params::ad_servers,
  $ad_site            = $jenkins::params::ad_site,
  $ad_bind            = $jenkins::params::ad_bind,
  $ad_passwd          = $jenkins::params::ad_passwd,
) inherits jenkins::params {

  notify { "## --->>> Set-up the environment for: ${package_name}": }

  file { '/etc/profile.d/java.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/jenkins/java.sh',
  }

  file { "${home_dir}/jenkins.CLI.xml":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0640',
    source => 'puppet:///modules/jenkins/jenkins.CLI.xml',
  }

  file { "${home_dir}/hudson.tools.JDKInstaller.xml":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0640',
    source => 'puppet:///modules/jenkins/jdkinstaller.xml',
  }

  file { "${home_dir}/credentials.xml":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0640',
    source => 'puppet:///modules/jenkins/credentials.xml',
  }

  file { "${home_dir}/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig.xml":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    content => template('jenkins/gitlabconnectionconfig.xml.erb'),
  }

  if $ad_enable {
    file { 'configure AD':
      ensure  => present,
      name    => "${home_dir}/config.xml",
      owner   => $user,
      group   => $user,
      mode    => '0644',
      content => template('jenkins/ldap.xml.erb'),
    }
  }

  # and finally restart and load plugins and configs
  exec { 'restart the beast':
    command => 'systemctl restart jenkins',
    path    => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/:/bin/:/sbin/',
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
