# == Class: newrelic
#
class kbit-common::newrelic {
  file { 'newrelic.list':
    path => '/etc/apt/sources.list.d/newrelic.list',
    content => 'deb http://apt.newrelic.com/debian/ newrelic non-free',
    before => Exec['apt-udp'],
  }
  
  exec { "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 548C16BF":
    alias => 'newrelic-repo',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
    unless => 'apt-key list | grep 548C16BF',
    before => File['newrelic.list'],
  }
  
  exec { "aptitude update newrelic":
    alias => 'apt-udp-newrelic',
    command => "/usr/bin/aptitude update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    require => Exec['newrelic-repo'],
  }
  
  package { 'newrelic-sysmond':
    ensure => latest,
    require => Exec['apt-udp-newrelic'],
  }

  file { 'newrelic.cfg':
    path => '/etc/newrelic/nrsysmond.cfg',
    source => 'puppet:///modules/kbit-common/nrsysmond.cfg',
    require => Package['newrelic-sysmond'],
  }

  service { 'newrelic-sysmond':
    ensure => running,
    require => [ 
      File['newrelic.cfg'], 
      Package['newrelic-sysmond']
    ] 
  }

}
