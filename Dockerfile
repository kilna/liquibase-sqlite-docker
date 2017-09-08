FROM kilna/liquibase
LABEL maintainer="Kilna kilna@kilna.com"

ARG sqlite_jdbc_version=3.20.0
ARG sqlite_jdbc_download_url=https://bitbucket.org/xerial/sqlite-jdbc/downloads

ENV LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/sqlite-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.sqlite.JDBC}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:sqlite:${DATABASE}'}

COPY test/ /opt/test_liquibase_sqlite/
RUN set -e -o pipefail;\
    cd /opt/jdbc;\
    chmod +x /opt/test_liquibase_sqlite/run_test.sh;\
    jarfile=sqlite-jdbc-${sqlite_jdbc_version}.jar;\
    curl -SOLs ${sqlite_jdbc_download_url}/${jarfile};\
    ln -s ${jarfile} sqlite-jdbc.jar;\
    set | grep -F LIQUIBASE_

