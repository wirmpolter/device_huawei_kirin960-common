#!/sbin/sh
#
# Copyright (C) 2018 The LineageOS Project
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

# Remount system as R/W
mount -o rw,remount /system

# Remove duplicated genfscon rules
sed -i "/genfscon exfat/d" /system/etc/selinux/plat_sepolicy.cil
sed -i "/genfscon fuseblk/d" /system/etc/selinux/plat_sepolicy.cil

# 8.0 vendor image specific hacks
if [ "$(grep ro.build.version.release /vendor/build.prop)" = "ro.build.version.release=8.0.0" ]; then
    # Fix logd service definition
    sed -i "s/socket logdw dgram+passcred 0222 logd logd/socket logdw dgram 0222 logd logd/g" /system/etc/init/logd.rc

fi

exit 0