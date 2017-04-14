class { 'apt':
  update => {
    frequency => 'daily',
  },
}

class { '::php':
}

class { 'apache': 
	default_vhost => false,
	mpm_module => prefork, # needed for apache mod_php
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