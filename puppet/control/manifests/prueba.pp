class control::prueba{
	file {'/root/prueba':
		ensure  => present,
		content => template('/etc/puppet/environments/production/modules/control/templates/prueba.erb'),
             }
}
