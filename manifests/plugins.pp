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
  $version            = $jenkins::params::version,
  $jvm_port           = $jenkins::params::jvm_port,
  $user               = $jenkins::params::user,
  $home_dir           = $jenkins::params::home_dir,
  $jenkins_url        = $jenkins::params::jenkins_url,
  $plugin_cli         = $jenkins::params::plugin_cli,
  $plugin_location    = $jenkins::params::plugin_location,
  $plugin_update      = $jenkins::params::plugin_update,
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
    notify { "## --->>> creating: ${home_dir}/plugins/${plugin}": }
    exec { $plugin:
      command   => "java -jar ${plugin_cli} -s http://localhost:${jvm_port}/${jenkins_url}/ install-plugin ${plugin_location}/${version}-${plugin_update}/${plugin}.hpi -deploy",
      creates   => "${home_dir}/plugins/${plugin}",
      path      => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/:/bin/:/sbin/',
      tries     => 3,
      try_sleep => 3,
    }
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
