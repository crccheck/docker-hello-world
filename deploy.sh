#!/usr/bin/env bash

# Skip PR deploys for now
if [ "$TRAVIS_PULL_REQUEST" == true ]; then
    echo "Skip PR deploy"
    exit 0
fi

export REPO="roninen/kerrokantasi-ui"

# Escape slashes in branch names
export BRANCH=${TRAVIS_BRANCH//\//_}

if [ "$TRAVIS_BRANCH" == "master" ] ; then
    echo "Tagging master"
    docker tag kerrokantasi-ui "$REPO:$COMMIT"
    docker tag "$REPO:$COMMIT" $REPO:latest
    docker push "$REPO:$COMMIT"
    docker push "$REPO:latest"
fi

if [ "$TRAVIS_BRANCH" != "master" ] ; then
    echo "Tagging branch " "$TRAVIS_BRANCH"
    docker tag kerrokantasi-ui "$REPO:$COMMIT"
    docker tag "$REPO:$COMMIT" "$REPO:$BRANCH"
    docker tag "$REPO:$COMMIT" "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    docker push "$REPO:$COMMIT"
    docker push "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    docker push "$REPO:$BRANCH"
fi

