#!/bin/sh

###
# Copy and rename the file on home directory
###

backupDotFiles () {
  TARGET_FILE_NAME=$HOME/$1
  CP_OPTION=""

  # If target is directory.
  if [ -d $TARGET_FILE_NAME ]; then
    CP_OPTION="-r"
  fi

  if [ -e $TARGET_FILE_NAME ]; then
    cp $CP_OPTION $TARGET_FILE_NAME $TARGET_FILE_NAME.backup
  fi

  return
}
