#! /bin/bash

curl --silent --request PUT --data $(date |tr " " "/") http://172.17.0.4:8500/v1/kv/prueba/fecha
python /app.py
