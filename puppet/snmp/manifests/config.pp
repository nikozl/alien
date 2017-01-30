class snmp::config {
   file {'snmpd.conf':
	ensure  => file,
	owner   => root,
	group   => root,
	mode    => 0444,
	content => template('snmp/snmpd.conf.erb'),
	path    => "${snmp::configfile}",
      }

}
