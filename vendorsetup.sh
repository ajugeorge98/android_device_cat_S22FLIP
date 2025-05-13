#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="S22FLIP"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
        #Language
   	    export TW_DEFAULT_LANGUAGE="en"

   	    #Building
	    export LC_ALL="C"
            export FOX_MANIFEST_VER="11.0"
 	    export ALLOW_MISSING_DEPENDENCIES=true
	    export FOX_TARGET_DEVICES="S22FLIP"
	    export TARGET_DEVICE_ALT="S22FLIP"
	    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"

        #Debug
           export FOX_INSTALLER_DEBUG_MODE="1"
           export FOX_IGNORE_LOGICAL_MOUNT_ERRORS="1"

        #Binaries
            export FOX_USE_SED_BINARY="1"
	    export FOX_USE_XZ_UTILS="1"
	    export FOX_USE_GREP_BINARY="1"
	    export FOX_USE_BASH_SHELL="1"
	    export FOX_ASH_IS_BASH="1"
            export FOX_USE_TAR_BINARY="1"
	    export FOX_USE_NANO_EDITOR="1"

	    #Magiskboot
	    export FOX_USE_MAGISKBOOT="1"
	    export FOX_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
	    export FOX_PATCH_VBMETA_FLAG=1

	    #Magisk
	    export FOX_USE_SPECIFIC_MAGISK_ZIP="/home/pranav/Magisk/Magisk-v24.3.zip"


	    #Backup
            export FOX_SKIP_MULTIUSER_FOLDERS_BACKUP="1"
            export FOX_QUICK_BACKUP_LIST="/boot;/data;"

	    # screen settings
	    # export FOX_SCREEN_H=2400
	    # export FOX_STATUS_H=100
	    # export FOX_STATUS_INDENT_LEFT=48
	    # export FOX_STATUS_INDENT_RIGHT=48
	    # export FOX_CLOCK_POS="1"

	    #Partitions
            export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	    export FOX_VIRTUAL_AB_DEVICE=1

        #Features
        export FOX_ENABLE_APP_MANAGER=0
        export FOX_DELETE_AROMAFM="1"
        export FOX_USE_GREEN_LED="0"

        #Maintainer Stuff
        export FOX_MAINTAINER="ajugeorge"
        export FOX_MAINTAINER_PATCH_VERSION="5"

	    # run a process after formatting data to work-around MTP issues
	    export FOX_RUN_POST_FORMAT_PROCESS="1"

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
