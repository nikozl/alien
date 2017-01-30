class snmp(
    $package	= 'net-snmp',
    $service	= 'snmpd',
    $configfile = '/etc/snmp/snmpd.conf',
    $community	= 'puppet',
    $syscontact = 'Niko <nikolemur@gmail.com>',
    $server	= '127.0.0.1',


) {

   Class['snmp::install'] -> Class['snmp::config'] ~> Class['snmp::service']


   include snmp::params
   include snmp::install
   include snmp::config
   include snmp::service
}
