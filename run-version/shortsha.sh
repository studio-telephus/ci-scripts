#!/usr/bin/env bash
: "${CI_COMMIT_SHA?}"

export CI_COMMIT_SHA_SHORT=$(echo $CI_COMMIT_SHA | cut -c1-10)
