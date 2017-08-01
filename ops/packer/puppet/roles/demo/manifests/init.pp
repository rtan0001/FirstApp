include ::archive

# install the ugm application
class demo {

  file { '/opt/ugm/monash-publishing.css' :
    ensure => 'present',
    source => 'puppet:///modules/demo/monash-publishing.css',
    mode   => '0644'
  }

  file { '/opt/ugm/start.sh' :
    ensure => 'present',
    source => 'puppet:///modules/demo/start.sh',
    mode   => '0755'
  }

}