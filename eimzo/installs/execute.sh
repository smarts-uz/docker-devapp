#!/sbin/openrc-run

java -jar /var/app/client/vpn-client.jar /var/app/client/client-eimzo.conf

java -Dfile.encoding=UTF-8 -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0
