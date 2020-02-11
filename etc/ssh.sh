#!/bin/sh
ssh qnap << EOF
  cd /share/USBDisk1/Sync/
  pwd
  /usr/local/sbin/unrar e -r *.rar
  pwd
  cd /share/USBDisk2/Sync/
  /usr/local/sbin/unrar e -r *.rar
EOF

# #  @author:       Alexandre Plennevaux
# #  @description:  MIRROR DISTANT FOLDER TO LOCAL FOLDER VIA FTP
# #
# # FTP LOGIN

# HOST='hiro.cloud.seedboxes.cc'
# USER='hiro'
# PASSWORD='FvhRUdTbiD6ePJn8roz2'
# PORT=41023

# # DISTANT DIRECTORY
# REMOTE_DIR='/home/user/files/downloads/def/TV'

# #LOCAL DIRECTORY
# LOCAL_DIR='/share/USBDisk2/Sync'

# # RUNTIME!
# echo
# echo "Starting download $REMOTE_DIR from $HOST to $LOCAL_DIR"
# date

# lftp -u "$USER","$PASSWORD" sftp://$HOST:$PORT <<EOF
# # the next 3 lines put you in ftpes mode. Uncomment if you are having trouble connecting.
# # set ftp:ssl-force true
# # set ftp:ssl-protect-data true
# set ssl:verify-certificate no
# set sftp:auto-confirm yes
# # transfer starts now...
# mirror --use-pget-n=7 $REMOTE_DIR $LOCAL_DIR;
# exit
# EOF
# echo
# echo "Transfer finished"
# date

# cd $LOCAL_DIR
# ls
# unrar e -r *.rar
# chmod -R 755 *.*
