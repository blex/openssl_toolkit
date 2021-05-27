#!/bin/bash
# Generate a server certificate

_target="_server_"
_days="3650"
_root_cert="_root_cert_.crt"
_root_cert_key="_root_cert_key_.key"

while getopts t:d:c:k: flag
do
    case "${flag}" in
        t) _target=${OPTARG};;
        d) _days=${OPTARG};;
	c) _root_cert=${OPTARG};;
	k) _root_cert_key=${OPTARG};;
    esac
done

echo "> Create certificate for '$_target', expried after $_days days and signed by $_root_cert"
openssl genrsa -out $_target.key 4096
openssl req -new -sha256 -key $_target.key -subj "/C=TW/ST=Taipei/L=Taipei/O=Organization/OU=Server Certificate/CN=$_target" -out $_target.csr
openssl req -in $_target.csr -noout -text
openssl x509 -req -in $_target.csr -CA $_root_cert -CAkey $_root_cert_key -CAcreateserial -out $_target.crt -days $_days -sha256
openssl x509 -in $_target.crt -text -noout
echo "> Done"
