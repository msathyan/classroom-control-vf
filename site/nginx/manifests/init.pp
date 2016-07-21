class nginx {
 file { '/etc/nginx/nginx.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
 }

 file { '/etc/nginx/conf.d/default.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/nginx/default.conf',
  require => File['/etc/nginx/nginx.conf'],
 }
 
 file { '/var/www':
  ensure  => directory,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => File['/etc/nginx/conf.d/default.conf'],
 }
 
 file { '/var/www/index.html':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/nginx/index.html',
 }
 
 package { 'nginx':
  ensure => present,
 }

 service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/var/www/index.html'],
 }
}
