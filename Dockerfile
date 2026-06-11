FROM ubuntu:noble
COPY config.sh /config.sh
COPY provide_gcc.sh /provide_gcc.sh
COPY upload_ini.sh /upload_ini.sh
RUN chmod 777 /upload_ini.sh

# Fix CRLF → LF from Windows host
RUN sed -i 's/\r$//' /config.sh /provide_gcc.sh /upload_ini.sh

# Build-time proxy: pass --build-arg HTTP_PROXY=http://host.docker.internal:PORT
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV HTTP_PROXY=${HTTP_PROXY} \
    HTTPS_PROXY=${HTTPS_PROXY}

RUN /config.sh
# ARM GCC 14.2 is linked to /usr/bin/ by provide_gcc.sh
CMD ["/bin/bash"]
