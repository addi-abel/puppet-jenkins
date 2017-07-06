# == Class jenkins::plugins
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
class jenkins::plugins (
  $package_name       = $jenkins::params::package_name,
  $jvm_port           = $jenkins::params::jvm_port,
  $user               = $jenkins::params::user,
  $home_dir           = $jenkins::params::home_dir,
  $jenkins_url        = $jenkins::params::jenkins_url,
  $plugin_location    = $jenkins::params::plugin_location,
  $plugin_cli         = $jenkins::params::plugin_cli,
  $plugins            = $jenkins::pluginlist::plugins
) inherits jenkins::params {

  notify { "## --->>> Waiting for completed start-up of: ${package_name}": }

  exec { 'check_running':
    command   => "grep 'Jenkins is fully up and running' /var/log/${user}/${user}.log",
    path      => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/:/bin/:/sbin/',
    tries     => 5,
    try_sleep => 5,
  }

  notify { "## --->>> Installing plugins for package: ${package_name}": }

  $plugins.each | String $plugin | {
    $plugin_array = split($plugin, 'hpi')
    $plugin_name  = "${plugin_array[0]}jpi"
    notify { "## --->>> creating: ${home_dir}/plugins/${plugin_name}": }
    exec { $plugin:
      command   => "java -jar ${plugin_cli} -s http://localhost:${jvm_port}/${jenkins_url}/ install-plugin ${plugin_location}/${plugin} -deploy",
      creates   => "${home_dir}/plugins/${plugin_name}",
      path      => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/:/bin/:/sbin/',
      tries     => 3,
      try_sleep => 3,
    }
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
