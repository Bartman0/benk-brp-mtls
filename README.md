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
