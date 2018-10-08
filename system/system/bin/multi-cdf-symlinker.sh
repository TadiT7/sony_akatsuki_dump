#!/system/bin/sh

# Copyright (C) 2013 Sony Mobile Communications Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# NOTE: This file has been modified by Sony Mobile Communications Inc.
# Modifications are licensed under the License.

# Script to create symlinks depending on currently active configuration

active_customization="$(/system/bin/getprop ro.semc.version.cust.active)"
src_dir="/data/customization"

customized_filenames=""
customized_filenames+="clatd.conf "
customized_filenames+="extra-bootanimation.zip "
customized_filenames+="shutdown.mp4 "
customized_filenames+="dpm.conf "
customized_filenames+="preset_networks.conf "

potential_prefixes=""
if [ -n "${active_customization}" ]; then
    potential_prefixes+="/oem/android-config/${active_customization} "
    potential_prefixes+="/system/etc/customization/settings/${active_customization} "
fi
potential_prefixes+="/oem/android-config "
potential_prefixes+="/system/etc/customization/settings/defaults "


for filename in ${customized_filenames}; do
    src="${src_dir}/${filename}"
    /system/bin/rm -f "$src"
    for prefix in ${potential_prefixes}; do
        dest="${prefix}/${filename}"
        if [ -e "${dest}" ]; then
            /system/bin/ln -s "${dest}" "${src}"
            continue 2 # on to the next filename
        fi
    done
done
