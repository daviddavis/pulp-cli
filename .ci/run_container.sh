#!/bin/sh

BASEPATH="$(dirname "$(readlink -f "$0")")"
IMAGE="pulp/pulp-fedora31"

if [ -z "${CONTAINER_RUNTIME+x}" ]
then
  if ls /usr/bin/podman
  then
    CONTAINER_RUNTIME=podman
  else
    CONTAINER_RUNTIME=docker
  fi
fi

if [ -n "$PULPCORE_VERSION" ]
then
  "${CONTAINER_RUNTIME}" build -f "${BASEPATH}/Containerfile" -t pulp --build-arg PULPCORE_VERSION="$PULPCORE_VERSION"
  IMAGE="pulp"
fi

"${CONTAINER_RUNTIME}" run --rm --detach --name "pulp" --volume "${BASEPATH}/settings:/etc/pulp" --publish "8080:80" "$IMAGE"

echo "Wait for pulp to start."
for _ in $(seq 10)
do
  sleep 3
  if curl --fail http://localhost:8080/pulp/api/v3/status/ > /dev/null 2>&1
  then
    echo "SUCCESS."
    break
  fi
done

# shellcheck disable=SC2064
trap "${CONTAINER_RUNTIME} stop pulp" EXIT

"${CONTAINER_RUNTIME}" exec -t pulp bash -c "pulpcore-manager reset-admin-password --password password"

"$@"
