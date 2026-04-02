#!/bin/bash
set -e

# Accept Nexus URL from Jenkins (e.g., 192.168.68.124:8083)
NEXUS_URL=$1

# Extract artifactId and version from pom.xml
APP_NAME=$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)
VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

echo "--- Building: $APP_NAME version $VERSION ---"

# Build Docker Image
docker build -t "$APP_NAME:$VERSION" .

# Tagging for Nexus
docker tag "$APP_NAME:$VERSION" "$NEXUS_URL/$APP_NAME:$VERSION"
docker tag "$APP_NAME:$VERSION" "$NEXUS_URL/$APP_NAME:latest"

# Pushing
docker push "$NEXUS_URL/$APP_NAME:$VERSION"
docker push "$NEXUS_URL/$APP_NAME:latest"

echo "--- Build and Push to $NEXUS_URL Complete ---"