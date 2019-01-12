#!/usr/bin/env bats

NS=pfillion
VERSION=latest
IMAGE_NAME=drone-golang

@test "Go package is installed" {
    run docker run --rm $NS/$IMAGE_NAME:$VERSION which go

    [ "$output" = "/usr/local/go/bin/go" ]
    [ "$status" -eq 0 ]
}

@test "make package is installed" {
    run docker run --rm $NS/$IMAGE_NAME:$VERSION which make

    [ "$output" = "/usr/bin/make" ]
    [ "$status" -eq 0 ]
}

@test "git package is installed" {
    run docker run --rm $NS/$IMAGE_NAME:$VERSION which git

    [ "$output" = "/usr/bin/git" ]
    [ "$status" -eq 0 ]
}

@test "CGO is disabled by default" {
    run docker run --rm $NS/$IMAGE_NAME:$VERSION printenv CGO_ENABLED

    [ "$output" = "0" ]
    [ "$status" -eq 0 ]
}