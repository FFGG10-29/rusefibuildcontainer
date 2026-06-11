FROM ubuntu:noble 
COPY config.sh /config.sh 
COPY provide_gcc.sh /provide_gcc.sh 
COPY upload_ini.sh /upload_ini.sh 
RUN chmod 777 /upload_ini.sh 
 
# 转换 CRLF → LF 
RUN sed -i 's/\r$//' /config.sh /provide_gcc.sh /upload_ini.sh 
 
RUN /config.sh 
# GCC 软链接已在 provide_gcc.sh 中创建 
CMD ["/bin/bash"]
