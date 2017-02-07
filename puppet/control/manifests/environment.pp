class control::environment{
	file{'/etc/environment':
		ensure  => present,
		content => template('/etc/puppet/environments/production/modules/control/templates/environment.erb'),

	}


}
