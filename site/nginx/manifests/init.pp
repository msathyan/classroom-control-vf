class nginx (
  $package = $nginx::params::package,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $logdir = $nginx::params::logdir,
  $user = $nginx::params::user,
  ) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  file { [ $docroot, "${confdir}/conf.d" ]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}


#class nginx {
#  case $::osfamily {
#    'debian': {
#      include nginx::debian
#    }
#    'windows': {
#      include nginx::windows
#    }
#    'redhat': {
#      include nginx::redhat
#    }
#    default: {
#      fail("Operating system #{operatingsystem} is not supported.")
#    }
#  }
#}

#class nginx {
#File{
#  owner   => 'root',
#  group   => 'root',
#  mode    => '0644',
#}

 #file { '/etc/nginx/nginx.conf':
#  ensure  => file,
#  source  => 'puppet:///modules/nginx/nginx.conf',
#  require => Package['nginx'],
# }

# file { '/etc/nginx/conf.d':
#  ensure  => directory,
#  require => File['/etc/nginx/nginx.conf'],
# }

# file { '/etc/nginx/conf.d/default.conf':
#  ensure  => file,
#  source  => 'puppet:///modules/nginx/default.conf',
# }
 
# file { '/var/www':
#  ensure  => directory,
#  require => File['/etc/nginx/conf.d/default.conf'],
# }
 
# file { '/var/www/index.html':
#  ensure  => file,
#  source  => 'puppet:///modules/nginx/index.html',
# }
 
 #package { 'nginx':
#  ensure => present,
# }

# service { 'nginx':
#  ensure    => running,
#  enable    => true,
#  subscribe => File['/etc/nginx/conf.d/default.conf','/etc/nginx/nginx.conf'],
# }
#}
