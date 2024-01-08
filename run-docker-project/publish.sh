#!/usr/bin/env bash
: "${CI_PUBLISH_TAGS?}"
: "${CI_NEXUS_DOCKER_PUBLISH_PASSWORD?}"
: "${CI_NEXUS_DOCKER_PUBLISH_USER?}"
: "${CI_NEXUS_DOCKER_URL?}"

DOCKER_REPOSITORY_URI="$CI_NEXUS_DOCKER_URL/$CI_REGISTRY_IMAGE"

tags=(${CI_PUBLISH_TAGS//,/ })
first_tag=${tags[0]}
tags_length=${#tags[@]}

echo -n $CI_NEXUS_DOCKER_PUBLISH_PASSWORD | docker login -u $CI_NEXUS_DOCKER_PUBLISH_USER --password-stdin $CI_NEXUS_DOCKER_URL

# fetches the latest image (not failing if image is not found)
docker pull $DOCKER_REPOSITORY_URI:latest || true

# builds the project, passing proxy variables, and vcs vars for LABEL
# notice the cache-from, which is going to use the image we just pulled locally
# the built image is tagged locally with the commit SHA, and then pushed to
# the GitLab registry
docker build \
  --pull \
  --build-arg VCS_URL=$CI_PROJECT_URL \
  --cache-from $DOCKER_REPOSITORY_URI:latest \
  --tag $DOCKER_REPOSITORY_URI:$first_tag \
  .

docker push $DOCKER_REPOSITORY_URI:$first_tag

if [ $tags_length -gt 1 ]; then
  echo "Found additional tags. Proceeding to tag & Push."
  for ((i = 1; i < ${tags_length}; i++)); do
    tg=${tags[$i]}
    echo "Tagging & pushing [$i] - $tg"
    docker tag $DOCKER_REPOSITORY_URI:$first_tag $DOCKER_REPOSITORY_URI:$tg
    docker push $DOCKER_REPOSITORY_URI:$tg
  done
else
  echo "No additional tags found."
fi


