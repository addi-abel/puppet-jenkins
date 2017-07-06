# == Class jenkins::account
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
class jenkins::account (
  $package_name = $jenkins::params::package_name,
  $uid          = $jenkins::params::uid,
  $home_dir     = $jenkins::params::home_dir
) inherits jenkins::params {

  notify { "## --->>> Creating accounts for: ${package_name}": }

  group { 'jenkins':
    ensure => present,
    gid    => $uid
  }

  user { 'jenkins':
    ensure     => present,
    home       => $home_dir,
    shell      => '/bin/false',
    comment    => 'Jenkins Automation Server',
    uid        => $uid,
    gid        => $uid,
    password   => '!!',
    managehome => true,
  }

  class { 'sudo':
    purge_ignore => '10_admin',
  }

  sudo::conf { 'jenkins' :
    priority => 20,
    content  => '#
# NATS sudoers add-on
#

# Custom nagios accout access
jenkins  ALL=(ALL) NOPASSWD: ALL',
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
