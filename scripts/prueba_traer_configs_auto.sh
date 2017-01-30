#!/bin/bash

set -e
#set -x

TMPDIR=$(mktemp -d)
BASEDIR=${TMPDIR}/pctce-configs/nodes

E_BAD_INPUT=101
E_BAD_FRONT=102

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}


git_clone() {
cd ${TMPDIR}
echo "INFO: Clonando repositorio..."
git clone root@16.0.96.20:metro/pctce-configs.git
}

get_file(){
ip_host=(16.0.62.30 16.0.62.31 16.0.62.32 16.0.62.33 16.0.62.34 16.0.62.35 16.0.62.36 16.0.62.37 16.0.62.38 16.0.62.39 16.0.62.41)
for i in ${ip_host[@]};
do
 estado=$(printf "GET services\nColumns: state \nFilter: description = SSHD \nFilter: host_address = ${i}\n" | netcat 16.0.74.31 6557)

 if [[ $estado == "0" ]] ; then
   echo "INFO: La conexion ssh del front ${i} esta disponible"
   scp -q metro@${i}:/home/metro/repositorio/*.tar.gz ${TMPDIR}
 else
   echo "ERROR: La conexion ssh del front ${i} no esta disponible"
 fi
done
rm -rf front*.tar.gz tcepatata*
}

get_hostname() {
NODE_TMP=${i%.tar.gz}
NODE=${NODE_TMP/\_/\-}

}

extract_file(){
rm -rf ${BASEDIR}/${NODE}
mkdir ${BASEDIR}/${NODE}
file1=${NODE}/home/metro/control.key
file2=${NODE}/usr/local/tce/tce
if tar -tzf $i |grep "$file1" >/dev/null 2>&1; then
 tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/control.key
 tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/hosts home/metro/services
 else
    echo "ERROR: Fallo al descomprimir los ficheros hosts, services y control.key en $i"
elif tar -tzf $i |grep "$file2" >/dev/null 2>&1; then
 tar --strip=2 -C ${BASEDIR}/${NODE} -xzf ${TMPDIR}/$i etc/inet/hosts etc/inet/services
 tar --transform 's,usr/local/tce/tce,control.key,' -C ${BASEDIR}/${NODE} -xzf $i usr/local/tce/tce
 else
    echo "ERROR: Fallo al descomprimir hosts y services y/o renombrar el fichero tce a control.key en $i"
fi
tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/sistema || echo "ERROR: Fallo al descomprimir el directorio home/metro/sistema en $i"
rm -rf $i
}

clean_state_files(){
find ${BASEDIR}/${NODE} -type f -name cmv.*.bin -o -name jactual.txt -o -name ProgVentilacion_bck| xargs -i rm -f {};
}

clean_temp_files(){
rm -rf ${TMPDIR}
echo "FIN DEL SCRIPT"
}

git_push(){
cd ${BASEDIR}
git add ${BASEDIR}/${NODE}
if ! git diff-index --quiet HEAD -- ; then
  echo "INFO: Subiendo cambios detectados de ${NODE} a Git"
  git commit -a -m "Auto-commit de cambios en ${NODE} `date +'%Y-%m-%d %H:%M:%S'`"
  git push origin master
fi
cd ${TMPDIR}
}

main(){
  git_clone
  get_file
  for i in *.tar.gz; do
    get_hostname
    extract_file
    clean_state_files
    git_push
  done
  clean_temp_files
}

main "$@"
