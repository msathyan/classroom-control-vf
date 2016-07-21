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
 
 file { '/var/www':
  ensure  => directory,
  require => File['/etc/nginx/conf.d/default.conf'],
 }
 
 file { '/var/www/index.html':
  ensure  => file,
  source  => 'puppet:///modules/nginx/index.html',
 }
 
 package { 'nginx':
  ensure => present,
 }

 service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/conf.d/default.conf','/etc/nginx/nginx.conf'],
 }
}
