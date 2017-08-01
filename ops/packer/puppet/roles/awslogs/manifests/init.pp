include ::archive

# install awslogs
class awslogs {

  archive { '/tmp/awslogs-agent-setup.py':
    ensure       => present,
    extract_path => '/tmp',
    source       => 'http://s3.amazonaws.com//aws-cloudwatch/downloads/latest/awslogs-agent-setup.py',
  }

  exec { 'install-awslogs':
    command => 'python /tmp/awslogs-agent-setup.py -n -r ap-southeast-2 -c /tmp/awslogs.conf',
    path    => [ '/sbin:/bin:/usr/sbin:/usr/bin' ],
    require => [ Archive['/tmp/awslogs-agent-setup.py'], File['/tmp/awslogs.conf'] ],
    creates => '/var/awslogs/etc',
  }

  service { 'awslogs':
    require => [ Exec['install-awslogs'], File['/var/awslogs/etc/config/base.conf'], File['/var/awslogs/etc/config/ugm.conf'] ],
    enable  => true,
  }

  file { '/tmp/awslogs.conf':
    ensure => 'present',
    source => 'puppet:///modules/awslogs/awslogs.conf',
    mode   => '0644',
  }

  file { '/var/awslogs/etc/config/base.conf':
    ensure  => 'present',
    source  => 'puppet:///modules/awslogs/base.conf',
    mode    => '0644',
    require => Exec['install-awslogs'],
  }

  file { '/var/awslogs/etc/config/ugm.conf':
    ensure  => 'present',
    source  => 'puppet:///modules/awslogs/ugm.conf',
    mode    => '0644',
    require => Exec['install-awslogs'],
  }
}
