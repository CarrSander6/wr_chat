FROM primetoninc/jdk:1.8
MAINTAINER dongGe
ARG workdir=/app
VOLUME ${workdir}
WORKDIR ${workdir}
ADD red-package.jar red-package.jar
ENV JAVA_OPTS="-server -Xms1024m -Xmx4096m -Xss20m -Djava.awt.headless=true -Dfile.encoding=utf-8"
ENV TZ=Asia/Shanghai
ENTRYPOINT java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar red-package.jar
