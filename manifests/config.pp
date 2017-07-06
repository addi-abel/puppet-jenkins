# == Class jenkins::config
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
class jenkins::config (
  $package_name       = $jenkins::params::package_name,
  $version            = $jenkins::params::version,
  $jvm_memory         = $jenkins::params::jvm_memory,
  $jvm_port           = $jenkins::params::jvm_port,
  $user               = $jenkins::params::user,
  $home_dir           = $jenkins::params::home_dir,
  $jenkins_url        = $jenkins::params::jenkins_url,
  $jenkins_tmp        = $jenkins::params::jenkins_tmp,
  $jenkins_setup      = $jenkins::params::jenkins_setup,
) inherits jenkins::params {

  notify { "## --->>> Modifying config for: ${package_name}": }

  file { '/etc/sysconfig/jenkins':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Service[$user],
    content => template('jenkins/jenkins.erb'),
  }

  $array_var1      = split($version, '-')
  $jenkins_version = $array_var1[0]

  file {"${home_dir}/config.xml":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    replace => 'yes',
    content => template('jenkins/config.xml.erb'),
  }

  file { "${home_dir}/tmp":
    ensure => directory,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0755',
  }

  firewalld_port { 'Open port 8080 for Jenkins in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8080,
    protocol => 'tcp',
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
