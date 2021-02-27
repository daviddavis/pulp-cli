#!/bin/bash

set -e

if [ -z $1 ]
then
  echo "Forgot to specify a version (e.g. .ci/release.sh 0.1.0)."
  exit 1
else
  version="$1"
fi

if [ -z "$(pip list | grep bumpversion)" ]
then
  echo "Missing bumpversion. Aborting."
  exit 1
fi

if [ -z "$(pip list | grep towncrier)" ]
then
  echo "Missing towncrier."
  exit 1
fi

if ! git diff-index --quiet HEAD --
then
  echo "Detected local uncommited changes. Aborting."
  exit 1
fi

changelog=$(towncrier --draft --version $version)

towncrier --yes --version $version
git commit -am "Generating changelog for $version" -m "[noissue]"

bumpversion release
git commit -am "$version release" -m "$changelog" -m "[noissue]"
git tag $version

bumpversion minor
new_version="$(cat .bumpversion.cfg | grep "current_version = " | cut -d" " -f3)"
git commit -am "Bumping version to $new_version" -m "[noissue]"

echo "Release tag created successfully."
