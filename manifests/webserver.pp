define multiwebserver::webserver ($webserver_name = $title, $webserver_dir, $webserver_port, $webserver_user) {
    include multiwebserver::packages # contains Package['httpd'] and Service['httpd']
    include multiwebserver::params # contains common config settings
    $vhost_dir = $apache::params::vhost_dir
    
    file { "$webserver_dir":
	ensure => 'directory',
	owner   => "$webserver_user",
	group   => "$webserver_user",
	mode    => '770',
    }
    
    file { "/etc/systemd/system/multiwebserver-instance-${webserver_user}.service":
	content => template('multiwebserver/simplehttp.service.erb'),
	# This template can access all of the parameters and variables from above.
	owner   => '',
	group   => 'www',
	mode    => '644',
	require => Package['python'],
	notify  => Service['httpd'],
      }
    }