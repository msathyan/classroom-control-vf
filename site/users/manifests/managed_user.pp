define users::managed_user (
    $username = $title,
    $homedir = "/home/$title",
    $usergroup = 'foo',
) {
  file { "/home/${title}/.bashrc":
    ensure  => file,
    content => template('user/bashrc.erb'),
  }
}
