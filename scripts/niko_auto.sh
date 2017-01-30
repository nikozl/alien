#!/bin/bash

set -e
set -x

BASEDIR=/home/niko/repomirror/pruebas

get_file(){
TMP_DIR=$(mktemp -d)
cp -a /home/niko/Downloads/*.tar.gz ${TMP_DIR}
}

extract_file(){
cd ${TMP_DIR}
for i in *.tar.gz
do
file=${i%.tar.gz}/images/pxeboot/vmlinuz
 if tar -tzf $i |grep "$file" >/dev/null 2>&1; then
   echo "$i contains vmlinuz"
   echo "Extrayendo $i files..."
   tar --strip=3 --transform 's/vmlinuz/vmlinuz_centos6/' --transform 's/initrd.img/initrd.img_centos6/' -C ${BASEDIR} -xvzf $i centos6/images/pxeboot/vmlinuz centos6/images/pxeboot/initrd.img || tar --strip=3 --transform 's/vmlinuz/vmlinuz_centos7/' --transform 's/initrd.img/initrd.img_centos7/' -C ${BASEDIR} -xvzf $i centos7/images/pxeboot/vmlinuz centos7/images/pxeboot/initrd.img 
 else
   echo "No"
 fi
done
}

clean_file(){
#cd ${TMP_DIR}
#mv * ${BASEDIR}
rm -rf ${TMP_DIR}
cd ${BASEDIR}
ls -lrt
}
get_file "$@"
extract_file "$@"
clean_file "$@"
