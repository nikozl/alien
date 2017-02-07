class control::service {
  
  file {'/etc/services':
	ensure  => present,
	content => template('/etc/puppet/environments/production/modules/control/templates/service.erb')
       }
}
