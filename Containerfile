FROM node:22.23-alpine3.23@sha256:46825fbbd4e996a78b7a2cdc08d75e38a5a505bdab95dcda55605359bf124bc6
ENV YARN_VERSION=4
USER root

# Remove yarn classic
RUN rm -rf /opt/yarn-* /usr/local/bin/yarn /usr/local/bin/yarnpkg

# Install yarn
ENV COREPACK_HOME=/usr/local/share/corepack
RUN corepack enable \
 && mkdir -p $COREPACK_HOME \
 && corepack prepare yarn@${YARN_VERSION} --activate

# Add license
RUN mkdir -p /licenses
COPY LICENSE /licenses

# Labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.name="michaelvaldron/node-dev"
LABEL org.label-schema.description="NodeJS developer container image"

USER 1000
