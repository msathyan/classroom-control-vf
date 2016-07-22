class nginx {
File{
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

 file { '/etc/nginx/nginx.conf':
  ensure  => file,
  source  => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
 }

 file { '/etc/nginx/conf.d':
  ensure  => directory,
  require => File['/etc/nginx/nginx.conf'],
 }

 file { '/etc/nginx/conf.d/default.conf':
  ensure  => file,
  source  => 'puppet:///modules/nginx/default.conf',
 }
 
 file { 'docroot':
  ensure  => directory,
  require => File['/etc/nginx/conf.d/default.conf'],
 }
 
  file { 'html':
  ensure  => file,
  path   => $::operatingsystem ? {
    'Debian'  => '/var/www/index.html',
    'Redhat'  => '/var/www/index.html',
    'Windows' => 'C:/ProgramData/nginx/html',
    default   => '/var/www/index.html',
  },
  source  => 'puppet:///modules/nginx/index.html',
 }
 
 package { 'nginx':
  ensure => present,
  name   => $::operatingsystem ? {
    'Debian'  => 'nginx',
    'Redhat'  => 'nginx',
    'Windows' => 'nginx-service',
    default   => 'nginx',
  },
 }

 service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/conf.d/default.conf','/etc/nginx/nginx.conf'],
 }
}
