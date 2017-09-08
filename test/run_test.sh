#!/bin/bash
set -e -o pipefail

echo "Adding sqlite"
apk --no-cache add sqlite

echo "Creating sqlite db"
sqlite3 liquibase .databases

echo "Applying changelog"
liquibase --changeLogFile=/opt/test_liquibase_sqlite/changelog.xml updateTestingRollback

