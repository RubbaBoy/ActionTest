## First do dart2native bin/server.dart -k aot -o server.aot
#
#FROM google/dart AS dartc
#FROM bitnami/minideb
#
#COPY --from=dartc /usr/lib/dart/bin/dartaotruntime /dartaotruntime
#
#RUN mkdir -p /usr/src/app
#ONBUILD ADD . /usr/src/app
#ONBUILD RUN
#ONBUILD ADD entrypoint.aot /.
#
## Code file to execute when the docker container starts up (`entrypoint.sh`)
#ENTRYPOINT ["/dartaotruntime", "entrypoint.aot"]

FROM google/dart:2.6-dev AS dart-runtime

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD bin /app/bin/
ADD lib /app/lib/
RUN pub get --offline
RUN dart2native /app/bin/server.dart -o /app/server

FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29

COPY --from=dart-runtime /app/server /server

ENTRYPOINT ["/server"]
