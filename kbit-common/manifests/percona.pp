# == Class: percona
#
class kbit-common::percona {
  file { 'percona.list':
    path => '/etc/apt/sources.list.d/percona.list',
    content => "deb http://repo.percona.com/apt ${lsbdistcodename} main",
    before => Exec['apt-udp'],
  }
  
  exec { "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1C4CBDCDCD2EFD2A":
    alias => 'percona-repo',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
    unless => 'apt-key list | grep CD2EFD2A',
    before => File['percona.list'],
  }
  
  exec { "aptitude update":
    alias => 'apt-udp',
    command => "/usr/bin/aptitude update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    require => Exec['percona-repo'],
  }
  
  package { ['percona-server-client-5.5']:
    ensure => latest,
    require => Exec['apt-udp'],
  }

}
