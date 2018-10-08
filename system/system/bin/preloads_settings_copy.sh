#!/system/bin/sh
#
# Copyright (C) 2018 Sony Mobile Communications Inc.
# All rights, including trade secret rights, reserved.
#
# This is script for creating folder that Update Center can access
# and copying preload applications settings from /data/system to
# the new folder /data/cache/preload_applications.

source_file=/data/system/application-packages.xml
target_file=/data/cache/preload_applications/application-packages.xml
target_dir=/data/cache/preload_applications

if  [ -f "$source_file" ] && [ ! -f "$target_file" ]; then
  mkdir -p $target_dir
  chown system:cache $target_dir
  chmod 0770 $target_dir
  cp $source_file $target_file
  chown system:cache $target_file
  chmod 0660 $target_file
fi
