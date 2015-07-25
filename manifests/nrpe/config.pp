# Class: icinga2::nrpe::config
#
# This subclass configures Icinga clients.
#
class icinga2::nrpe::config {
  #The NRPE configuration base directory:
  file { $::icinga2::params::nrpe_config_basedir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package[$::icinga2::nrpe::icinga2_client_packages],
  }

  #The folder that will hold our command definition files:
  file { '/etc/nagios/nrpe.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => $::icinga2::nrpe::nrpe_purge_unmanaged,
    recurse => true,
    require => Package[$::icinga2::nrpe::icinga2_client_packages],
  }

  file { '/etc/nrpe.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => $::icinga2::nrpe::nrpe_purge_unmanaged,
    recurse => true,
    require => Package[$::icinga2::nrpe::icinga2_client_packages],
  }

  #File resource for /etc/nagios/nrpe.cfg
  file { '/etc/nagios/nrpe.cfg':
    ensure  => file,
    path    => '/etc/nagios/nrpe.cfg',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icinga2/nrpe.cfg.erb'),
    require => Package[$::icinga2::nrpe::icinga2_client_packages],
  }
}

