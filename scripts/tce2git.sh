#!/bin/bash

set -e
set -x

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
for i in "${ip_host[@]}";
do
 estado=$(printf "GET services\nColumns: state \nFilter: description = SSHD \nFilter: host_address = ${i}\n" | netcat 16.0.74.31 6557 || echo "4")

 if [[ $estado == "0" ]] ; then
   echo "INFO: La conexion ssh del front ${i} esta disponible"
   scp -q metro@${i}:/home/metro/repositorio/*.tar.gz ${TMPDIR}
 else
   echo "ERROR: La conexion ssh del front ${i} no esta disponible"
 fi
done
}

get_hostname() {
  NODE_TMP=${i%.tar.gz}
  NODE=${NODE_TMP/\_/\-}
}

detect_tce() {
  TCE=''
  if tar -tf $i home/metro/control.key 2>/dev/null 1>&2; then
    TCE='parsec'
  elif tar -tf $i usr/local/tce/tce 2>/dev/null 1>&2; then
    TCE='old'
  fi
}


detect_mbt() {

if [[ $TCE == 'old' ]]; then
 rm -rf ${BASEDIR}/${NODE}/sistema/V/Mbt
 mbt=$(tar xfO $i var/spool/cron/crontabs/metro |grep MBT |awk '{print $7}')
 if [[ ! -z $mbt ]]; then
  for i in "${mbt[@]}";
  do 
  mkdir -p ${BASEDIR}/${NODE}/sistema/V/Mbt/$i
  done
 fi 
fi
}

extract_file(){

if tar -tf $i >/dev/null; then
  rm -rf "${BASEDIR:?}/${NODE}"
  mkdir ${BASEDIR}/${NODE}
  if [[ $TCE == 'parsec' ]]; then
    tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/control.key
    tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/hosts home/metro/services
    tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/sistema
  elif [[ $TCE == 'old' ]]; then
    tar --strip=2 -C ${BASEDIR}/${NODE} -xzf ${TMPDIR}/$i etc/inet/hosts etc/inet/services
    tar --transform 's,usr/local/tce/tce,control.key,' -C ${BASEDIR}/${NODE} -xzf $i usr/local/tce/tce
    tar --strip=2 -C ${BASEDIR}/${NODE} -xzf $i home/metro/sistema
  fi
else
  echo "Error de contenido en fichero tar"
  continue
fi

}

find_empty_dir() {
empty=$(find ${BASEDIR}/${NODE} -type d -empty)
for i in "${empty[@]}";
do
touch $i/.keep
done
}

clean_state_files(){
find ${BASEDIR}/${NODE} -type f -name 'cmv.*.bin' -o -name 'jactual.txt' -o -name 'ProgVentilacion_bck' -o -name '*.gz'| xargs -i rm -f {};
find ${BASEDIR}/${NODE} -type d -name 'MBT00000' | xargs -i rm -rf {};
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
    detect_tce
    extract_file
    detect_mbt
    clean_state_files
    find_empty_dir
    git_push
  done
  clean_temp_files
}

main "$@"
