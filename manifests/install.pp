# == Class jenkins::install
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
class jenkins::install (
  $package_name       = $jenkins::params::package_name,
  $java_install       = $jenkins::params::java_install,
  $java_package       = $jenkins::params::java_package,
  $version            = $jenkins::params::version
) inherits jenkins::params {

  notify { "## --->>> Installing package: ${package_name}": }

  include jenkins::repo

  # install the Jenkins rpm
  package { 'Jenkins CI':
    ensure => $version,
    name   => $package_name,
  }

  # install the git rpm
  package { 'Git':
    ensure => present,
    name   => 'git',
  }

  # install the Java dependency
  if ($java_install) {
    package { $java_package :
      ensure => present,
    }
    package { 'java-devel':
      ensure => 'present',
    }
  }

# # Sort out the dreaded selinux:
# selinux::port { 'allow_jenkins_port':
#   context  => 'jenkins_port_t',
#   port     => $ssl_management_port,
#   protocol => 'tcp',
# }

}


# -----------------------
# vim: set ts=2 sw=2 et :
