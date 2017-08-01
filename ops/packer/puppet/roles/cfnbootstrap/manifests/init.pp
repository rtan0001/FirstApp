include ::archive

# install cfn-bootstrap packages
class cfnbootstrap {
  archive { '/tmp/aws-cfn-bootstrap-latest.tar.gz':
    ensure       => present,
    extract      => true,
    extract_path => '/tmp',
    source       => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    cleanup      => true
  }

  exec { 'build cfn-bootstrap':
    command => 'python setup.py build',
    cwd     => '/tmp/aws-cfn-bootstrap-1.4',
    path    => '/bin'
  }

  exec { 'install cfn-bootstrap':
    command => 'python setup.py install',
    cwd     => '/tmp/aws-cfn-bootstrap-1.4',
    path    => '/bin'
  }
}