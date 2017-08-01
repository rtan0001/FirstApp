
# install awscli
class common {

  package { 'epel-release-7-9':
    ensure   => installed,
    source   => 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
    provider => 'rpm'
  }

  package { ['python-pip', 'openssl-devel', 'python-devel', 'gcc']:
    ensure        => installed,
    allow_virtual => true,
    require       => Package['epel-release-7-9']
  }

  file { '/usr/bin/pip-python':
    ensure  => 'link',
    target  => '/usr/bin/pip',
    require => Package['python-pip']
  }

  package { ['awscli', 'sops', 'jinja2-cli', 'pyyaml']:
    ensure   => installed,
    provider => 'pip',
    require  => File['/usr/bin/pip-python']
  }

}
