# gebaseerd op:
# https://medium.com/@nisanth.m.s/guide-setting-up-mtls-authentication-with-openssl-for-client-server-communication-38c0a5cbfa05
# https://dev.to/adzubla/using-mtls-5711

if [ $# -ne 2 ]; then
	echo "usage: $0 <server_pfx_file> <client_name>"
	exit 1
fi

server_pfx_file="$1"
client_name="${2//  */-}"

openssl verify -show_chain -verbose -CAfile ./mtls/certs/DigiCert\ Global\ Root\ G2.crt -untrusted ./mtls/certs/DigiCert\ G2\ TLS\ EU\ RSA4096\ SHA384\ 2022\ CA1.crt "$server_pfx_file"

# genereer een client key, dit kan de klant ook zelf uitvoeren dan hoeven we alleen de CSR te ontvangen
openssl genrsa -out ./mtls/client_certs/"$client_name".key.pem 4096
# maak een CSR aan
openssl req -config ./mtls/openssl.cnf -new -key ./mtls/client_certs/"$client_name".key.pem -out ./mtls/client_certs/"$client_name".csr -subj "/C=NL/L=Amsterdam/O=Gemeente Amsterdam/OU=BenK/CN=${client_name}.benk-brp.amsterdam.nl/emailAddress=benk-brp@amsterdam.nl"

#openssl rsa -in ./mtls/client_certs/"$client_name".key.pem -text
#openssl req -in ./mtls/client_certs/"$client_name".csr -text

# genereer een client certificaat
openssl ca -config mtls/openssl.cnf -days 730 -notext -batch -cert "$server_pfx_file" -keyfile "$server_pfx_file" -in ./mtls/client_certs/"$client_name".csr -out ./mtls/client_certs/"$client_name".cert.pem
