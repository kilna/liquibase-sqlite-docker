#!/bin/bash
set -e -o pipefail

echo "Adding sqlite"
apk add sqlite

echo "Creating sqlite db"
sqlite3 liquibase.db .databases

echo "Applying changelog"
liquibase updateTestingRollback

