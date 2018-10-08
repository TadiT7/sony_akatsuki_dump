#!/system/bin/sh

# Copyright (C) 2018 Sony Mobile Communications Inc.

src_dir='/data/vendor/wifi/wlan_logs'
target_default_dir='/storage/emulated/0/logalong'

command=$1

delete_files_in_directory()
{
    echo "Removing $src_dir"
    rm -rf $src_dir
}

copy_wlan_driver_logs_to_logalong_directory()
{
    target_dir=`getprop sys.wlan.driver.log.directory`
    if [ -z $target_dir ]; then
        target_dir=$target_default_dir
    fi
    echo "Copying from $src_dir to $target_dir"
    cp -a $src_dir/* $target_dir/
}

#if the start logging then delete the files in src_dir and set the property for start logging.
if [ $command -eq 1 ]; then
    delete_files_in_directory
    setprop ctl.start cnss_diag
fi

#if stop then set the property to stop logging and copy the files from src_dir to target_dir
if [ $command -eq 0 ]; then
    setprop ctl.stop cnss_diag
    copy_wlan_driver_logs_to_logalong_directory
fi
