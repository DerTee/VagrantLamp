user { 'ubuntu':
	ensure => present,
	uid    => '1000',
	gid    => '1000'
}

# change motd:
file { '/etc/update-motd.d/00-header':
	ensure  => present,
	mode    => '755',
	source => '/vagrant/manifests/motd/00-header'
}
file { '/etc/update-motd.d/01-vagrant-info':
	ensure  => present,
	mode    => '755',
	source => '/vagrant/manifests/motd/01-vagrant-info'
}
file { '/etc/update-motd.d/10-help-text':
	ensure => absent
}
file { '/etc/update-motd.d/51-cloudguest':
	ensure => absent
}


class { 'apt':
}

class { '::php::globals':
  php_version => '7.0',
  # config_root => '/etc/php/7.0',
}->
class { '::php':
  	composer => true,
  	settings   => {
	    'PHP/max_execution_time'  => '90',
	    'PHP/max_input_time'      => '300',
	    'PHP/memory_limit'        => '64M',
	    'PHP/post_max_size'       => '32M',
	    'PHP/upload_max_filesize' => '32M',
	    'Date/date.timezone'      => 'Europe/Berlin',
	},
	zend_extensions => { 
		xdebug => {
			provider => pecl,
		},
	}
}

class { 'apache': 
	default_vhost => false,
	mpm_module => prefork,
}
apache::vhost { 'localhost':  # define vhost resource
 	port       => '80',
	docroot    => '/vagrant/html',
}
class  { 'apache::mod::php':
	package_name => 'libapache2-mod-php7.0'
}

class { '::mysql::server':
  root_password => 'root',
}
#class { '::mysql::client':
#	bindings_enable => true,
#}
#class { '::mysql::bindings':
#}