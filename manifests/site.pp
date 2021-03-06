## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}


node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  notify { "Hello, my name is ${::hostname}": }
  # file { '/etc/motd':
  #  ensure => file,
  #  owner => 'demo',
  #  group => 'demo',
  #  mode => '0777',
  #  content => "Learing Puppet",
  # }
  #file_line { 'hostnameadd':
  #  path => '/etc/hosts',
  #  line => '127.0.0.1 testing.puppetlabs.vm',
  #}
  #exec { 'motd':
  #  path  => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  #  command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motd",
  #  onlyif => 'test `cat /etc/motd |grep Puppet>/dev/null;echo $?` -eq 0',
  #  }
  #include users
  #include skeleton
  #if $facts['is_virtual'] == true {
  # $disp=capitalize($facts['virtual'])
  # notify {"this is ${disp}":}
  #}
  #users::managed_user { "jose": }
  #users::managed_user { "alice": }
  #users::managed_user { "chen": }
  #include nginx
  $message = hiera('message')
  notify { $message: }
}
