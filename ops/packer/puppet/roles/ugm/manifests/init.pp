include ::archive

# install the ugm application
class ugm {

    if $::package_name == undef {
        $resolved_package_name = 'unit-guide-editor-3.4.1-b54'
    }
    else {
        $resolved_package_name = $::package_name
    }

  package { ['unzip']:
    ensure        => installed,
    allow_virtual => false
  }

  archive { '/tmp/unit-guide-editor.zip':
    ensure       => present,
    extract      => true,
    extract_path => '/opt',
    source       => "https://monashuni.artifactoryonline.com/monashuni/deploy-apps/ugm/3.4/${resolved_package_name}.zip",
    cleanup      => true,
    username     => $::artifactory_user,
    password     => $::artifactory_password,
    require      => Package['unzip']
  }

  file { '/opt/ugm' :
    ensure  => 'directory',
    recurse => true,
    source  => "file:///opt/${resolved_package_name}",
    require => Archive['/tmp/unit-guide-editor.zip']
  }

  file { "/opt/${resolved_package_name}" :
    ensure  => 'absent',
    purge   => true,
    recurse => true,
    force   => true,
    require => File['/opt/ugm']
  }

  file { '/opt/ugm/appConf/ugeprops.xml.jinja':
    source  => 'puppet:///modules/ugm/ugeprops.xml.jinja',
    require => File['/opt/ugm']
  }

  file { '/opt/ugm/setEnvironment.sh.jinja':
    source  => 'puppet:///modules/ugm/setEnvironment.sh.jinja',
    require => File['/opt/ugm']
  }

  exec { 'fix permissions':
    command => '/bin/chmod +x start.sh stop.sh',
    cwd     => '/opt/ugm',
    require => File['/opt/ugm']
  }

  file { '/etc/systemd/system/ugm.service':
    source  => 'puppet:///modules/ugm/ugm.service',
    require => File['/opt/ugm']
  }

  service { 'ugm':
    enable  => false,
    require => File['/etc/systemd/system/ugm.service']
  }

}
