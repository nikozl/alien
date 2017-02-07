class control::niko{
       file{'/root/niko':
             ensure => present,
	     content => template('/etc/puppet/environments/production/modules/control/templates/niko.erb'), 
}

} 
