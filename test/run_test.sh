#!/bin/bash
set -e -o pipefail

echo "Adding sqlite"
apk --no-cache add sqlite

echo "Creating sqlite db"
sqlite3 liquibase.db .databases

echo "Applying changelog"
liquibase updateTestingRollback

