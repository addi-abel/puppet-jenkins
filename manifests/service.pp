# == Class jenkins::service
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
class jenkins::service (
  $package_name       = $jenkins::params::package_name,
  $jvm_memory         = $jenkins::params::jvm_memory,
  $user               = $jenkins::params::user,
) inherits jenkins::params {

  notify { "## --->>> Starting the service: ${package_name}": }

  file { '/etc/init.d/jenkins':
    ensure  => absent,
  }

  file { "/usr/lib/systemd/system/${user}.service":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('jenkins/service.erb'),
  }~> exec { 'daemon_update':
    command => '/usr/bin/systemctl daemon-reload'
  }

  service { $user:
    ensure    => 'running',
    enable    => true,
    subscribe => File["/usr/lib/systemd/system/${user}.service"],
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
