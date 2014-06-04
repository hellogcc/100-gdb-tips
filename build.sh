#!/bin/sh

# This script invokes md2min to convert markdown files to minimal html files,
# using github css. So go and md2min should be available before you run it. 
# See https://github.com/fairlyblank/md2min
# See http://code.google.com/p/go

TOPDIR=`dirname $0`

if [ ! type -P go >/dev/null 2>&1 ]; then
  echo "error: can't find go, which is necessary for building html"
  exit 0
fi

if [ ! type -P md2min >/dev/null 2>&1 ]; then
  echo "error: can't find md2min, which is necessary for building html"
  exit 0
fi

mkdir -p "$TOPDIR/html"

(
export SRC="$TOPDIR/src"
export HTML="$TOPDIR/html"
go run "$TOPDIR/utils/build.go"
)

