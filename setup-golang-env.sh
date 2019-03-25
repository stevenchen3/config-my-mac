#!/bin/bash

set -x

# Install go from official website
# See https://golang.org/doc/install

VERSION=${1:-"1.12.1"}
OS=${2:-"darwin"}
ARCH=${3:-"amd64"}

curl -L --retry 3 https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz | tar -C /tmp -xzf -

# Set GOPATH, GOBIN


# Install package manager, e.g., dep, glide
