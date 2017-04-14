class { 'apt':
  update => {
    frequency => 'daily',
  },
}

class { '::php':
	fpm        => true,
	composer   => true,
	settings   => {
		'Date/date.timezone'         => 'Europe/Berlin',
		'PHP/error_reporting'        => 'E_ALL',
		'PHP/display_errors'         => 'On',
		'PHP/display_startup_errors' => 'On',
		'PHP/log_errors'             => 'On',
	},
	extensions => {
		mysqli => {	},
		xdebug => { },
	}
}

class { 'apache': 
	default_vhost => false,
	mpm_module => prefork, # needed for apache mod_php
}
class  { 'apache::mod::php':
	package_name => 'libapache2-mod-php7.0'
}
apache::vhost { 'localhost':  # define vhost resource
 	port       => '80',
	docroot    => '/vagrant/html',
}

class { '::mysql::server':
  root_password => 'root',
}