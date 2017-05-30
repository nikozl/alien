#!/bin/bash
#
#
# Copia el script cfgequipo2std.sh en cada máquina
# este creará dos cfgequipo nuevos, standard y non-standard
# Se traerá de cada máquina ambos cfgequipos ademas del resto de cfgs
# situados en /home/siv/sistema/V, /etc/hosts,  /etc/services 
# y /etc/dgrp.backingstore
#
# Definimos rutas de rsh y rcp pq en algunas máquina intenta conectar con KRB4
RSH="/usr/bin/rsh"
RCP="/usr/bin/rcp"
SERVIMG="16.2.96.21"
SIV_HOME="/home/siv"
DESTINO="/home/siv/Repositorio/juanjo"
DESTINO2="/home/siv/Repositorio/targz"
FICHEROS=( "home/siv/sistema/V/Cfg*.CFG"\
           "home/siv/sistema/V/CtrlMegaf/MGF*/*.CFG"\
           "home/siv/sistema/V/Anden/*/Cfg*.CFG"\
           "home/siv/sistema/V/Anden/*/xAndenMSG"\
           "home/siv/sistema/V/Anden/*/xMegafAndenMSG*")
PUPPET="/etc/puppet/puppet.conf"
ESTACIONES=(`cat /sannas/local/sistema/V/CfgConfig.CFG | awk '{print $4}' | egrep ^siv`)

for i in ${ESTACIONES[@]}
  do
  uname=`${RSH} $i uname`
  
      # Creamos carpeta local
      mkdir -p ${DESTINO}/${i}
    
      # Generamos tar con ficheros necesarios y rutas relativas
      ${RSH} $i "cd /; tar cf ${SIV_HOME}/${i}.tar ${FICHEROS[@]}" &> /dev/null
      ${RSH} $i "gzip ${SIV_HOME}/${i}.tar" &> /dev/null
    
      # Nos traemos el tar generado
      ${RCP} $i:${SIV_HOME}/${i}.tar.gz ${DESTINO}/${i}/ 
      ${RCP} $i:${SIV_HOME}/${i}.tar.gz ${DESTINO2} 
  
      # Eliminamos ficheros creados de maquina remota
      ${RSH} $i "rm ${SIV_HOME}/${i}.tar.gz"
    
      # Eliminamos ficheros de tars anteriores
      if [ -d ${DESTINO}/${i}/home ];
        then rm -rf ${DESTINO}/${i}/home ${DESTINO}/${i}/etc
      fi
      
      # Extraemos y borramos fichero tar
      tar -C ${DESTINO}/${i} -xf ${DESTINO}/${i}/${i}.tar.gz 
      rm ${DESTINO}/${i}/${i}.tar.gz

      # Restablecemos permisos. 755 dirs y 644 files. 
      find ${DESTINO}/${i} -type d -print0 | xargs -0 chmod 755
      find ${DESTINO}/${i} -type f -print0 | xargs -0 chmod 644

      # Añadimos entradas necesarias en /etc/hosts
      # echo "${SERVIMG} servimg.set.winumi.net" >> ${DESTINO}/${i}/etc/hosts
  done



# Limpiamos cores.
for j in $(find ${DESTINO} -print | grep -i core); do
  rm -f $j
done

# Borramos el CfgEquipo.CFg actual porque usaremos el estandarizado (por puppet)
find ${DESTINO} -name CfgEquipo.CFG -exec rm {} \;

# Copiamos todo al servidor Puppet
#ssh ${SERVIMG} "mkdir -p /home/siv/configs"
#scp -qr ${DESTINO}/* ${SERVIMG}:${SIV_HOME}/configs/
