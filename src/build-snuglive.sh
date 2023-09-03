#!/bin/bash

install_snuglinux_func="/usr/share/snuglinux/install-snuglinux.func"

FILE_COFIG="/etc/snuglive.conf"

if ! [ -f "${install_snuglinux_func}" ]; then
   echo "Install the package install_snuglinux"
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

_clear(){
  name=$1
  if [ -d $name ]; then
     rm -Rf "$name"
     if [ $? != 0 ]; then
        show_message FAILED_EXECUTE_COMMAND "rm -Rf "$name""
        exit 1
     fi
  else
     rm -f $name
     if [ $? != 0 ]; then
#       show_message FAILED_EXECUTE_COMMAND "$name"
       exit 1
     fi
  fi
}

sbat(){
   sbat_file="${pkgdir}/usr/share/grub/sbat.csv"
   if ! [ -f ${sbat_file} ]; then
      touch "${sbat_file}"
      echo "sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md" >> "${sbat_file}"
      echo "grub,1,Free Software Foundation,grub,${_pkgver},https//www.gnu.org/software/grub/" >> "${sbat_file}"
      echo "grub.arch,1,Arch Linux,grub,${_pkgver},https://archlinux.org/packages/core/x86_64/grub/" >> "${sbat_file}"
   fi
}

sbat

_clear ${PATCH_SNUGLIVE}/iso
_clear ${PATCH_SNUGLIVE}/work_dir

mkarchiso -v -w ${PATCH_SNUGLIVE}/work_dir -o ${PATCH_SNUGLIVE}/out_dir ${PATCH_SNUGLIVE}
