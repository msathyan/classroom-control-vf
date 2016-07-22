class nginx::redhat {
File{
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

 file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content  => template('nginx/nginx.conf.erb'),
  require => Package['nginx'],
 }

 file { '/etc/nginx/conf.d':
  ensure  => directory,
  require => File['/etc/nginx/nginx.conf'],
 }

 file { '/etc/nginx/conf.d/default.conf':
  ensure  => file,
  content  => template('nginx/default.conf.erb'),
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
