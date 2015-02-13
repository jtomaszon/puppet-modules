# == Class: fail2ban
#
class kbit-common::fail2ban {

  package { 'fail2ban':
    ensure => latest,
  } 

  file { 'jail.conf':
    path => "/etc/fail2ban/jail.conf",
    mode => 0644,
    content => template("kbit-common/jail.conf.erb"),
    require => Package['fail2ban'],
    notify => Service['fail2ban'],
  }

  service {'fail2ban':
    ensure => running,
    require => Package['fail2ban']
  }

}
