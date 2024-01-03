#!/usr/bin/env bash

MAJOR_REVISION=$(echo $(date +"%y%m") | sed 's/^0*//')
MINOR_REVISION=$(echo $(date +"%d%H") | sed 's/^0*//')
BUILD_REVISION=$(echo $(date +"%M%S") | sed 's/^0*//')
BUILD_REVISION_MILLI=$(echo $(date +"%3N") | sed 's/^0*//' | cut -c1-1)

export SEMVER=$MAJOR_REVISION.$MINOR_REVISION.$BUILD_REVISION$BUILD_REVISION_MILLI
echo "Semver value ${SEMVER} has been exported to the environment variable SEMVER."
