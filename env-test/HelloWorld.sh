#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "Less than one argument"
  exit 1
fi

if [ $# -lt 2 ]; then
  echo "Less than two argument"
  exit 1
fi

if [ $# -lt 3 ]; then
  echo "Less than 3 arguments"
  exit 1
fi
