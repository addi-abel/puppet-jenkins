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
  $package_name = $jenkins::params::package_name
) inherits jenkins::params {

  notify { "## --->>> Creating yum.repo for: ${package_name}": }

  yumrepo {'jenkins':
    descr    => 'Jenkins',
    baseurl  => 'http://rpmrepo.abel.uk.com/jenkins/redhat-stable/',
    gpgcheck => 1,
    gpgkey   => 'http://rpmrepo.abel.uk.com/jenkins/jenkins-io.key',
    enabled  => 1,
  }

}


# -----------------------
# vim: set ts=2 sw=2 et :
