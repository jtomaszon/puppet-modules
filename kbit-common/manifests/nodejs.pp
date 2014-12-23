# == Class: nodejs
#
class kbit-common::nodejs {

  exec { 'install-nodejs-repo':
    command => 'curl -sL https://deb.nodesource.com/setup | sudo bash -',
    path    => ['/bin', '/usr/bin'],
    creates => '/etc/apt/sources.list.d/nodesource.list'
  }
  
  package { 'nodejs':
    ensure => present,
    require => Exec['install-nodejs-repo']
  }
  
  file { "/usr/bin/node":
    require => Package['nodejs']
  }
  
}
