#! /bin/bash

co=$(curl --request GET http://127.0.0.1:5000)
if [[  $? == 0  ]];
then
echo ${co}
fi
