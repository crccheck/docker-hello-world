#!/usr/bin/env bash

export REPO="roninen/hello-world"

# First 7 chars of commit hash
export COMMIT=${TRAVIS_COMMIT::7}

# Escape slashes in branch names
export BRANCH=${TRAVIS_BRANCH//\//_}

if [ "$TRAVIS_PULL_REQUEST" != false ]; then
    echo "Tagging pull request" "$TRAVIS_PULL_REQUEST"
    export BASE="$REPO:pr-$TRAVIS_PULL_REQUEST"
    docker tag hello-world "$BASE"
    docker tag "$BASE" "$BASE-travis-$TRAVIS_BUILD_NUMBER"
    docker push "$BASE"
    docker push "$BASE-travis-$TRAVIS_BUILD_NUMBER"
    exit 0
fi

if [ "$TRAVIS_BRANCH" == "master" ] ; then
    echo "Tagging master"
    docker tag hello-world "$REPO:$COMMIT"
    docker tag "$REPO:$COMMIT" $REPO:latest
    docker tag "$REPO:$COMMIT" "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    docker push "$REPO:$COMMIT"
    docker push "$REPO:latest"
    docker push "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    exit 0
fi

if [ "$TRAVIS_BRANCH" != "master" ] ; then
    echo "Tagging branch " "$TRAVIS_BRANCH"
    docker tag hello-world "$REPO:$COMMIT"
    docker tag "$REPO:$COMMIT" "$REPO:$BRANCH"
    docker tag "$REPO:$COMMIT" "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    docker push "$REPO:$COMMIT"
    docker push "$REPO:travis-$TRAVIS_BUILD_NUMBER"
    docker push "$REPO:$BRANCH"
    exit 0
fi

