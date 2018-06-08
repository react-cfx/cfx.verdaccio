FROM mooxe/node

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y

RUN /bin/bash -lc 'yrm add verdaccio http://verdaccio:4873'
RUN /bin/bash -lc 'yrm use verdaccio'
RUN /bin/bash -lc 'npm config set always-auth true'
