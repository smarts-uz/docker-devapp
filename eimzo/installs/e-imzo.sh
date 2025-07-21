#!/bin/bash

: <<'END'

java -Dfile.encoding=UTF-8 -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0

java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0

java -jar /var/app/client/vpn-client.jar /var/app/client/client-eimzo.conf

END


