#!/bin/sh

set -e

plugin_version=$(sed -n -e 's/version:[ "]*\([^"]*\).*/\1/p' $(dirname $0)/../plugin.yaml)
SET_STATUS_VERSION=${SET_STATUS_VERSION:-$plugin_version}
env

os=$(uname -sp | tr '[:upper:] ' '[:lower:]-' | sed 's/x86_64/amd64/')
release_file="helm-set-status-${SET_STATUS_VERSION}-${os}.tar.gz"
url="https://github.com/brandond/helm-set-status/releases/download/v${SET_STATUS_VERSION}/${release_file}"

mkdir -p ${dir}

if command -v wget
then
  wget -O ${HELM_PLUGIN_DIR}/${release_file} ${url}
elif command -v curl; then
  curl -L -o ${HELM_PLUGIN_DIR}/${release_file} ${url}
fi

tar xvf ${HELM_PLUGIN_DIR}/${release_file} -C ${HELM_PLUGIN_DIR}

chmod +x ${HELM_PLUGIN_DIR}/helm-set-status

rm ${HELM_PLUGIN_DIR}/${release_file}
