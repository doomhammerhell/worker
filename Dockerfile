FROM integritee/integritee-dev:0.1.9
LABEL maintainer="zoltan@integritee.network"

# By default we warp the service
ARG BINARY_FILE=integritee-service

COPY bin/enclave.signed.so bin/end.rsa bin/end.fullchain /usr/local/bin/
COPY bin/${BINARY_FILE} /usr/local/bin/integritee

WORKDIR /usr/local/bin
RUN touch spid.txt key.txt

RUN chmod +x /usr/local/bin/integritee

# checks
RUN ldd /usr/local/bin/integritee && \
	/usr/local/bin/integritee --version

ENTRYPOINT ["/usr/local/bin/integritee"]