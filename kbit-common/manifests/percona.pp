# == Class: percona
#
class kbit-common::percona {

  case $osfamily {
    'Debian': {
      $perconaPackages = [
        'percona-server-server-5.6',
        'percona-server-client-5.6'
      ]
      $mycnf = '/etc/mysql/my.cnf'

    }

    'RedHat': {
      $perconaPackages = [
        'Percona-Server-server-56',
        'Percona-Server-client-56',
        'Percona-Server-shared-56'
      ]
      $mycnf = '/etc/my.cnf'
    }
  }

  case $osfamily {
    'Debian': {
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
      package { [$perconaPackages]:
        ensure => latest,
        require => Exec['apt-udp'],
      }
    }
    'RedHat': {
      exec { "rpm -Uvh http://www.percona.com/redir/downloads/percona-release/redhat/latest/percona-release-0.1-3.noarch.rpm":
        alias  => 'percona-repo',
        path   => ["/bin", "/usr/bin", "/usr/sbin"],
        unless => 'file /etc/yum.repo.d/percona-release.repo',
      }
      package { [$perconaPackages]:
        ensure        => latest,
        require       => Exec['percona-repo'],
      }
    }

  }

  package {'percona-toolkit':
    ensure  => latest,
    require => Package[$perconaPackages[0]],
  }

  service {'mysql':
    ensure  => 'running',
    enable  => 'true',
    require => Package[$perconaPackages[0]],
  }

  file {$mycnf:
    path    => '/etc/my.cnf',
    source  => 'puppet:///modules/kbit-common/my.cnf',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 0400,
    subscribe => Service['mysql'],
  }

}
