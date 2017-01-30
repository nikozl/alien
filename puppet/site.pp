node 'metro11.eliop.es' {


#Package['httpd'] -> Service['httpd']

class {'snmp':}

#class {'http':}

user {'lemur':
    ensure => 'present', 
    home => '/home/lemur',
    password => 'hola',
    managehome => true, 

}


service { 'sshd':
    ensure    => running,
    enable    => true,
  }


service { 'nfs-server':
    ensure    => running,
    enable    => true,
}

}



node 'nikopc.rim.metromadrid.net' {

user {'lemur':
    ensure => 'present',
    home => '/home/lemur',
    password => 'hola',
    managehome => true,

}

service { 'nfs-server':
   ensure   => running,
   enable   => true, 
}

}

node 'nik.puppet.local' {

class {'snmp':}

user {'lemur':
    ensure => 'present',
    home => '/home/lemur',
    password => 'hola',
    managehome => true,

}

}
