
NAME="server"
CERT="$NAME.crt"
DER="$NAME.der"
P7B="$NAME.p7b"
PFX="$NAME.pfx"

# TO DER
openssl x509 -in $CERT -out $DER -outform DER

# TO PFX
openssl pkcs12 -export -in $CERT -out $PFX -password pass:11223344
#-inkey server.key
#-certfile ca.crt

# TO P7B
openssl crl2pkcs7 -nocrl -certfile $CERT -out $P7B
