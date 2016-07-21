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
  file { "/home/${title}/.bashrc":
    ensure => present,
    content => template('users/bashrc.erb'),
  }
  file { "/home/${title}/.ssh":
    ensure => directory,
  }
}
