# http proxy

### proxy.py
[proxy.py](https://github.com/abhinavsingh/proxy.py)

```
pip install --upgrade proxy.py

pip install git+https://github.com/abhinavsingh/proxy.py.git@master

python -m proxy
```


#### help
```

D:\projects>proxy --help
usage: proxy [-h] [--backlog BACKLOG] [--basic-auth BASIC_AUTH]
             [--ca-key-file CA_KEY_FILE] [--ca-cert-dir CA_CERT_DIR]
             [--ca-cert-file CA_CERT_FILE] [--ca-file CA_FILE]
             [--ca-signing-key-file CA_SIGNING_KEY_FILE]
             [--cert-file CERT_FILE]
             [--client-recvbuf-size CLIENT_RECVBUF_SIZE]
             [--devtools-ws-path DEVTOOLS_WS_PATH]
             [--disable-headers DISABLE_HEADERS] [--disable-http-proxy]
             [--enable-dashboard] [--enable-devtools] [--enable-events]
             [--enable-static-server] [--enable-web-server]
             [--hostname HOSTNAME] [--key-file KEY_FILE]
             [--log-level LOG_LEVEL] [--log-file LOG_FILE]
             [--log-format LOG_FORMAT] [--num-workers NUM_WORKERS]
             [--open-file-limit OPEN_FILE_LIMIT] [--pac-file PAC_FILE]
             [--pac-file-url-path PAC_FILE_URL_PATH] [--pid-file PID_FILE]
             [--plugins PLUGINS] [--port PORT]
             [--server-recvbuf-size SERVER_RECVBUF_SIZE]
             [--static-server-dir STATIC_SERVER_DIR] [--threadless]
             [--timeout TIMEOUT] [--version]

proxy.py v2.2.0

optional arguments:
  -h, --help            show this help message and exit
  --backlog BACKLOG     Default: 100. Maximum number of pending connections to
                        proxy server
  --basic-auth BASIC_AUTH
                        Default: No authentication. Specify colon separated
                        user:password to enable basic authentication.
  --ca-key-file CA_KEY_FILE
                        Default: None. CA key to use for signing dynamically
                        generated HTTPS certificates. If used, must also pass
                        --ca-cert-file and --ca-signing-key-file
  --ca-cert-dir CA_CERT_DIR
                        Default: ~/.proxy.py. Directory to store dynamically
                        generated certificates. Also see --ca-key-file, --ca-
                        cert-file and --ca-signing-key-file
  --ca-cert-file CA_CERT_FILE
                        Default: None. Signing certificate to use for signing
                        dynamically generated HTTPS certificates. If used,
                        must also pass --ca-key-file and --ca-signing-key-file
  --ca-file CA_FILE     Default: None. Provide path to custom CA file for peer
                        certificate validation. Specially useful on MacOS.
  --ca-signing-key-file CA_SIGNING_KEY_FILE
                        Default: None. CA signing key to use for dynamic
                        generation of HTTPS certificates. If used, must also
                        pass --ca-key-file and --ca-cert-file
  --cert-file CERT_FILE
                        Default: None. Server certificate to enable end-to-end
                        TLS encryption with clients. If used, must also pass
                        --key-file.
  --client-recvbuf-size CLIENT_RECVBUF_SIZE
                        Default: 1 MB. Maximum amount of data received from
                        the client in a single recv() operation. Bump this
                        value for faster uploads at the expense of increased
                        RAM.
  --devtools-ws-path DEVTOOLS_WS_PATH
                        Default: /devtools. Only applicable if --enable-
                        devtools is used.
  --disable-headers DISABLE_HEADERS
                        Default: None. Comma separated list of headers to
                        remove before dispatching client request to upstream
                        server.
  --disable-http-proxy  Default: False. Whether to disable
                        proxy.HttpProxyPlugin.
  --enable-dashboard    Default: False. Enables proxy.py dashboard.
  --enable-devtools     Default: False. Enables integration with Chrome
                        Devtool Frontend. Also see --devtools-ws-path.
  --enable-events       Default: False. Enables core to dispatch lifecycle
                        events. Plugins can be used to subscribe for core
                        events.
  --enable-static-server
                        Default: False. Enable inbuilt static file server.
                        Optionally, also use --static-server-dir to serve
                        static content from custom directory. By default,
                        static file server serves out of installed proxy.py
                        python module folder.
  --enable-web-server   Default: False. Whether to enable
                        proxy.HttpWebServerPlugin.
  --hostname HOSTNAME   Default: ::1. Server IP address.
  --key-file KEY_FILE   Default: None. Server key file to enable end-to-end
                        TLS encryption with clients. If used, must also pass
                        --cert-file.
  --log-level LOG_LEVEL
                        Valid options: DEBUG, INFO (default), WARNING, ERROR,
                        CRITICAL. Both upper and lowercase values are allowed.
                        You may also simply use the leading character e.g.
                        --log-level d
  --log-file LOG_FILE   Default: sys.stdout. Log file destination.
  --log-format LOG_FORMAT
                        Log format for Python logger.
  --num-workers NUM_WORKERS
                        Defaults to number of CPU cores.
  --open-file-limit OPEN_FILE_LIMIT
                        Default: 1024. Maximum number of files (TCP
                        connections) that proxy.py can open concurrently.
  --pac-file PAC_FILE   A file (Proxy Auto Configuration) or string to serve
                        when the server receives a direct file request. Using
                        this option enables proxy.HttpWebServerPlugin.
  --pac-file-url-path PAC_FILE_URL_PATH
                        Default: /. Web server path to serve the PAC file.
  --pid-file PID_FILE   Default: None. Save parent process ID to a file.
  --plugins PLUGINS     Comma separated plugins
  --port PORT           Default: 8899. Server port.
  --server-recvbuf-size SERVER_RECVBUF_SIZE
                        Default: 1 MB. Maximum amount of data received from
                        the server in a single recv() operation. Bump this
                        value for faster downloads at the expense of increased
                        RAM.
  --static-server-dir STATIC_SERVER_DIR
                        Default: "public" folder in directory where proxy.py
                        is placed. This option is only applicable when static
                        server is also enabled. See --enable-static-server.
  --threadless          Default: False. When disabled a new thread is spawned
                        to handle each client connection.
  --timeout TIMEOUT     Default: 10. Number of seconds after which an inactive
                        connection must be dropped. Inactivity is defined by
                        no data sent or received by the client.
  --version, -v         Prints proxy.py version.

Proxy.py not working? Report at:
https://github.com/abhinavsingh/proxy.py/issues/new

```