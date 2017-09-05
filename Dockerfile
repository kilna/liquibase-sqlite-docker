FROM kilna/liquibase

ARG sqlite_jdbc_version=3.20.0
ARG sqlite_jdbc_download_url=https://bitbucket.org/xerial/sqlite-jdbc/downloads

ENV LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/sqlite-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.sqlite.JDBC}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:sqlite:${DATABASE}'}

COPY test/ /opt/test/
RUN cd /opt/jdbc;\
    jarfile=sqlite-jdbc-${sqlite_jdbc_version}.jar;\
    curl -SOLs ${sqlite_jdbc_download_url}/${jarfile};\
    ln -s ${jarfile} sqlite-jdbc.jar;\
    set | grep -F LIQUIBASE_

