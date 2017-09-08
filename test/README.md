# liquibase-sqlite-docker/test

This directory contains a test to ensure the SQLite JDBC driver works with liquibase within the container.

At build-time this directory is copies into /opt/test_liquibase_sqlite, and to validate the built image, DockerHub runs the [run_test.sh](./run_test.sh) script automatically via docker-compose.test.yml.
