# Usage

1. copy the server certificate in pfx format to the ./mtls/certs directory
   ```
   cp <path to pfx file>/<pfx file>.pfx ./mtls/certs/
   ```
1. execute the script to generate an mTLS client certificate
   ```
   ./gen-client-cert.sh ./mtls/certs/kv-dpbk-ont-01-xero-benk-brp-amsterdam-nl-20241016.pfx mtls-client
   ```
1. you'll find the client certificate in ./mtls/client_certs/mtls-client.cert.pem
