#!/usr/bin/env bash
set -eux

for f in $(find . -name main-es2015.*.js); do
    envsubst '${SPA_API_URL}' < $f > "$f.tmp"
    cp "$f.tmp" $f
done

exec "$@"
