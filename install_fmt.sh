#!/usr/bin/env bash
readonly FMT_VERSION="${1}"

echo "Cloning FMT"
# shellcheck disable=SC2164
cd /compiler-explorer/libs
mkdir fmt
for version in ${FMT_VERSION}
do
    echo "Git clone FMT ${version}"
    git clone https://github.com/fmtlib/fmt.git "$version"
    # shellcheck disable=SC2164
    cd "$version"
    git checkout "$version"
    # shellcheck disable=SC2103
    cd ..
done
