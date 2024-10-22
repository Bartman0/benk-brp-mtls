## Usage

The gen-client-cert.sh script expects two arguments:

1. the path to the file with the server certificate in pfx format
2. the name under which you would like to register the client certificate under

So in somewhat more detail, these are the steps to perform:

1. copy the server certificate in pfx format to the ./mtls/certs directory

```sh
   cp <path to pfx file>/<pfx filename>.pfx ./mtls/certs/
```

1. execute the script to generate an mTLS client certificate

```sh
   ./gen-client-cert.sh ./mtls/certs/<pfx filename>.pfx mtls-client
```

1. you'll find the client certificate in `./mtls/client_certs/mtls-client.cert.pem`

## Testing

You can test the server and client certificates by running a server and client using the following commands:

```
# server:
openssl s_server -accept 3000 -cert ./mtls/certs/<pfx filename>.pfx -key ./mtls/certs/<pfx filename>.pfx -CAfile mtls/certs/ca-bundle.crt -verify_return_error -state -debug

# client:
openssl s_client -connect 127.0.0.1:3000 -key ./mtls/client_certs/mtls-client.key.pem -cert ./mtls/client_certs/mtls-client.cert.pem -CAfile ./mtls/certs/ca-bundle.crt -state -debug -showcerts
```
