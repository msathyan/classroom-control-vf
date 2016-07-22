class nginx::windows {
File{
  owner   => 'Administrator',
  group   => 'Administrators',
}

 file { 'C:/ProgramData/nginx/nginx.conf':
  ensure  => file,
  content  => template('nginx/nginx.conf.erb'),
  require => Package['nginx-service'],
 }

 file { 'C:/ProgramData/nginx/conf.d':
  ensure  => directory,
  require => File['C:/ProgramData/nginx/nginx.conf'],
 }

 file { 'C:/ProgramData/nginx/conf.d/default.conf':
  ensure  => file,
  content  => template('nginx/default.conf.erb'),
 }
 
 file { 'C:/ProgramData/nginx/html':
  ensure  => directory,
  require => File['C:/ProgramData/nginx/conf.d/default.conf'],
 }
 
  file { 'C:/ProgramData/nginx/html/index.html':
  ensure  => file,
  source  => 'puppet:///modules/nginx/index.html',
 }
 
 package { 'nginx-service':
  ensure => present,
 }

 service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['C:/ProgramData/nginx/conf.d/default.conf','C:/ProgramData/nginx/nginx.conf'],
 }
}
