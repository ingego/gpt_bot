FROM dart:stable AS build
WORKDIR /app
COPY ./ /app

RUN dart pub get
CMD dart run
