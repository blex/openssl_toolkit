#!/bin/bash
# Generate a root certificate

_days=3650
_target="_default_"

while getopts t:d: flag
do
    case "${flag}" in
        t) _target=${OPTARG};;
        d) _days=${OPTARG};;
    esac
done

echo "> Create root certificate '$_target', expried after $_days days"

#create private key
echo ">>> Create private key: $_target.key"
openssl genrsa -out ./$_target.key 4096
#create root CA certificate
echo ">>> Create certificate: $_target.crt"
openssl req -x509 -new -nodes -key ./$_target.key -sha256 -days $_days -out ./$_target.crt -subj "/C=TW/ST=Taipei/L=Taipei/O=Organization/OU=RootCA/CN=$_target"
echo "> Done"

