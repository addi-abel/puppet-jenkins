# == Class jenkins::repo
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
class jenkins::repo (
  $package_name = $jenkins::params::package_name,
  $repo_server  = $jenkins::params::repo_server
) inherits jenkins::params {

  notify { "## --->>> Creating yum.repo for: ${package_name}": }

  yumrepo {'jenkins':
    descr    => 'Jenkins',
    baseurl  => "http://${repo_server}/pkg.jenkins.io/redhat-stable/",
    gpgcheck => 1,
    gpgkey   => "http://${repo_server}/pkg.jenkins.io/jenkins-io.key",
    enabled  => 1,
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
