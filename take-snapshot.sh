#!/bin/sh
# Put the arguments sent by Octolapse into variables for easy use
SNAPSHOT_NUMBER=$1
DELAY_SECONDS=$2
DATA_DIRECTORY=$3
SNAPSHOT_DIRECTORY=$4
SNAPSHOT_FILENAME=$5
SNAPSHOT_FULL_PATH=$6

# Check to see if the snapshot directory exists
if [ ! -d "${SNAPSHOT_DIRECTORY}" ];
then
  echo "Creating directory: ${SNAPSHOT_DIRECTORY}"
  mkdir -p "${SNAPSHOT_DIRECTORY}"
fi

# IMPORTANT - You must add gphoto2 and pktriggercord-cli to your /etc/sudoers file in order to execute gphoto2 and pktriggercord-cli without sudo
# otherwise the following line will fail.
sudo pktriggercord-cli --model=K-30 --file_format=JPEG --output_file="${SNAPSHOT_FULL_PATH}"

#for f in *-0000.jpg; do mv "$f" "${f%-0000.jpg}"; done
#for f in *; do mv "$f" "$f.jpg"; done
#for file in *.jpg ; do mv $file ${file//-0000.jpg/.jpg} ; done
cd ${SNAPSHOT_DIRECTORY}
rename "s/-0000.jpg/.jpg/" *-0000.jpg


if [ ! -f "${SNAPSHOT_FULL_PATH}" ];
then
  echo "The snapshot was not found in the expected directory: '${SNAPSHOT_FULL_PATH}'." >&2 
  exit 1
fi
