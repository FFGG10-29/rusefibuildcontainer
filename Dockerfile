FROM ubuntu:noble
COPY config.sh /config.sh
COPY provide_gcc.sh /provide_gcc.sh
COPY upload_ini.sh /upload_ini.sh
RUN chmod 777 /upload_ini.sh

# 转换 CRLF → LF (Windows 宿主机文件可能带有 CRLF 换行符)
RUN sed -i 's/\r$//' /config.sh /provide_gcc.sh /upload_ini.sh

RUN /config.sh
# GCC 软链接已在 provide_gcc.sh 中创建 (14.2.rel1 → /usr/bin/)
CMD ["/bin/bash"]
