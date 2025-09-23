FROM teamprodevs/proliga-front:main

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Alpine/installs.sh" "/installs.sh"
ADD "./node-lesaapp/installs/build.sh" "/build.sh"

RUN sh /installs.sh
RUN sh /build.sh

EXPOSE 22
EXPOSE 3000
