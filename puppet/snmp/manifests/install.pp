class snmp::install {
   package {'snmp':
	ensure  => installed,
	name    => "${snmp::package}",
     }

}
