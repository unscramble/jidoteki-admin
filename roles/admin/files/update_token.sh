#!/bin/sh
#
# Generic script for updating an API token
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble. See the LICENSE file (MIT).
# https://unscramble.co.jp
#
# VERSION: 0.6.0

set -u
set -e

admin_dir="/opt/jidoteki/admin"
uploads_dir="${admin_dir}/home/sftp/uploads"

fail_and_exit() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Invalid or missing API token" 2>&1 | tee -a "${admin_dir}/log/update.log"
  exit 1
}

################

move_api_token() {
  cd "${uploads_dir}"

  if [ -f "api.token" ]; then
    echo "[`date +%s`][VIRTUAL APPLIANCE] Updating API token. Please wait.." 2>&1 | tee -a "${admin_dir}/log/update.log"
    mv -f api.token ${admin_dir}/etc/
    chmod 640 "${admin_dir}/etc/api.token" ; chown root:admin "${admin_dir}/etc/api.token"
    echo "[`date +%s`][VIRTUAL APPLIANCE] Updating API token successful" 2>&1 | tee -a "${admin_dir}/log/update.log"
  fi
}

################

move_api_token || fail_and_exit

exit 0
