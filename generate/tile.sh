#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f $0)")
export PATH=$PATH:${SCRIPT_DIR}

FILE=$1
BARE_NAME=${FILE%.*}

if [ -z "${FILE}" ]; then
  echo "Missing file name, call using \n ./map_box_prep.sh FILE.tiff"
  exit 1
fi

if [ ! -e "$FILE" ]; then
  echo "File '${FILE}' not found"
  exit 1
fi

COLOURED=${BARE_NAME}-coloured.tiff

if [ ! -e "$COLOURED" ]; then
  echo "Colouring in the raster"
  gdaldem color-relief ${FILE} -nearest_color_entry -alpha colour.txt ${COLOURED}
fi

rm -rf ${BARE_NAME}
gdal2tiles.py ${COLOURED} -w none -z 5-15 ${BARE_NAME}

upload.sh ${BARE_NAME}
