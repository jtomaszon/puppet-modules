class kbit-common::users {

  user { 'ubuntu':
    ensure           => 'absent'
  }

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

  ssh_authorized_key { 'michel':
    user => $user,
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAwsxZ134FbCWKd66WoZAhEt8dSckDfYO9O+9bKUKfFWPPcG34OaE9rIuGiZZJga4dvf58e5PQ/OW9Kj2J6M7WAnauS/Q+hUw6/JsgJ84heCB84weohV57fS/+auTViF1UQGYpgafU3g2RTd+TBmREnUPTeKMbRzZ6RskgsllUxFDxE2MmJp/hHogXmG4lj59ft8liiM06n9mE3+EakmmFWzUmuAJ/L3xVlCUO5IsAQS5Ws7mVZZ63FRHjYzvSWNItwXKUiHTMcQEMakPrh/yOCTuKzKOdo0LeZ/x25qkW5+b6X1/oKkWQxjrnHEZx/tErrsAoTqSArChCIzcogsYFCQ==',
    require => File['ssh'],
  }

  ssh_authorized_key { 'fabio':
    user => $user,
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVeDSwINDpk/vSxWRbcmDDw3YEFv3YbWCHhX4NnuwR6WGEWd3RF66hwu9/qoqFnE1nCSektjfuHT99IYLGM8imfL88E22AFEOd6JosqBLq4MM754PoHRRVy0oAR2ICOg7Clm7qZMhxkZcFkCKOQPXjhzowddl8KY0GKzbjgAqHZK9iY3EA6Z9iixVM2ZXb5N5t0tgYxQE9aN1kHSopanteTIbcRBBJ/83R6QbAigH6pI1/+nUxFw4k65Cx8a0alai/QioNGFfPxdxJzIqGGlVnp+54rO1oLFqPiITJaCVlICY49Pn0YEtAHhkqXt60cxyAg59oivS63T82roX8MS0f',
    require => File['ssh'],
  } 

  ssh_authorized_key { 'joao':
    user => $user,
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCyfwFhyXaNM3oeUY7orlndEsXhgxc42E6ibTHmvc4Yt4ZgmoQbO06KJ0ZjzWzPDYQdAbqkSEOib5mhg8ds7o+yW3ojIX7FSpeci31Y+A/0PN/dRh6BE5WLrc+3OBFuX2YE0N0j9l2TYqUflS1YPNdSPD6OndhojjQXoiW3EoNEAkZ7KcDlFfKf4hgmCUE3BCTr6uGxzpESJwcnnYeiczW9n23tjiZ7on55LuG8ey95/C2h94JegpP91FlNHyS7pQkGGVrtnI1ugKucHn2MN9z3POpghRzaFWrYcmd/L5c/1n2RKAhtRbtUMpI189V3fdOxsnm3Dk9xzOUVnF5rTZuX',
    require => File['ssh'],
  } 

}
