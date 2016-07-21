define users::managed_user (
    $username = $title,
    $homedir = "/home/$title",
    $usergroup = 'foo',
) {
  user { "$title":
    ensure  => present,
    groups  => $usergroup,
    home    => $homedir,
  }
  file { "/home/$title" :
    ensure => directory,
    owner  => $title,
    group  => $title,
    mode   => '0700',
}

  file { "/home/${title}/.bashrc":
    ensure => present,
    owner  => $title,
    group  => $title,
    mode   => '0640',
    content => template('users/bashrc.erb'),
  }
  file { "/home/${title}/.ssh":
    ensure => directory,
    owner  => $title,
    group  => $title,
    mode   => '0600',
  }
}
