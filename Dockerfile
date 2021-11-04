FROM alpine:3.14
LABEL maintainer="Georg Rollinger <georg.rollinger@posteo.net>"
ENV clang_version=11
LABEL description="Clang Format ${clang_version}"
# TODO - Maybe not add bash and just use sh instead?
RUN apk add --no-cache clang=${clang_version} git jq bash
COPY .clang-format /.clang-format
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]