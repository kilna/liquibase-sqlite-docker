FROM kilna/liquibase
LABEL maintainer="Kilna kilna@kilna.com"

ARG jdbc_driver_version
ENV jdbc_driver_version=${jdbc_driver_version:-3.20.0}
ARG jdbc_driver_download_url=https://bitbucket.org/xerial/sqlite-jdbc/downloads

ENV LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/sqlite-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.sqlite.JDBC}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:sqlite:${DATABASE}'}

COPY test/ /opt/test_liquibase_sqlite/
RUN set -e -o pipefail;\
    echo "JDBC DRIVER VERSION: $jdbc_driver_version";\
    cd /opt/jdbc;\
    chmod +x /opt/test_liquibase_sqlite/run_test.sh;\
    jarfile=sqlite-jdbc-${jdbc_driver_version}.jar;\
    curl -SOLs ${jdbc_driver_download_url}/${jarfile};\
    ln -s ${jarfile} sqlite-jdbc.jar

