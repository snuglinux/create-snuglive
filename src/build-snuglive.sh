#!/bin/bash

install_snuglinux_func="/usr/share/snuglinux/install-snuglinux.func"

FILE_COFIG="/etc/snuglive.conf"

if ! [ -f "${install_snuglinux_func}" ]; then
   exit 1
fi

source ${install_snuglinux_func}

if ! [ -f ${FILE_COFIG} ]; then
   show_message NOT_FOUND_CONFIG ${FILE_COFIG}
   exit 1
else
   source "${FILE_COFIG}"
fi

if ! [ -d "${PATCH_SNUGLIVE}" ]; then
  show_message DIRECTORY_NOT_FOUND ${PATCH_SNUGLIVE}
  exit 1;
fi

mkarchiso -v -w ${PATCH_SNUGLIVE} -o ${PATCH_SNUGLIVE}/out_dir ${PATCH_SNUGLIVE}
