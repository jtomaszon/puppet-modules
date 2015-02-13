# == Class: percona
#
class kbit-common::users {

  $user = "deploy"

  group { $user:
    ensure           => 'present',
    name             => $user,
    gid              => '500',
    before           => User[$user],
  } 

  user { $user:
    ensure           => 'present',
    uid              => '500',
    gid              => '500',
    groups           => ['sudo'],
    home             => '/home/deploy',
    password         => '$6$UPa0H.jw$Qqm6hlSoXEhjOoYyUavdb7tYPXV4GPlBMEhii6dTRWahHGGUcXsMtZL1dIQWlmiMSa5ULfcLnzTqlnMwCnss.0',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    managehome       =>  true,
  }

  file { 'home':
    path => "/home/$user",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => 0700,
    require => User[$user],
  }
 
  file { 'ssh':
    path => "/home/$user/.ssh",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => 0700,
    require => File['home'],
  }

  ssh_authorized_key { 'jzon':
    user => $user,
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDQAD3KQO07DwPi5cfpPT6h/eYlS25nhEGKEM5UD+sEeJux1SfUzKFGEqVptyJOiygE9g6SsMmWbJB9HEuqYiQVyzLE58UUMQundX3wHUPnb41xxdnkxckS60lYhcBmO5SbBmFt6LzXapVkI/whYOAS+0y1MtHzZeo9gnzv6KkxjW/tIMzvJCffeuRrKY5v58Xdm3LAXxjM46fqDxCeiC3mfYux1tfDl10svG/ZNUia32G4zWyjU3ClH6MM3xQuEG1Q1c8PbO7Gr74gk1AUAd7u9CO4XIgOJXQ/vm43I7EpCz2rgApI5q8UyLzxF/BzEsnF2altX7TrJsMtDePw0Igt',
    require => File['ssh'],
  }

}