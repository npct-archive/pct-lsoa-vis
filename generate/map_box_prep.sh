#!/bin/sh

FILE=$1

if [ -z "${FILE}" ]; then
  echo "Missing file name, call using \n ./map_box_prep.sh FILE.tiff"
  exit 1
fi

if [ ! -e "$FILE" ]; then
  echo "File '${FILE}' not found"
  exit 1
fi

INCREASED_RES=${FILE%.*}-increased-res.tiff
rm -f ${INCREASED_RES}
gdalwarp -tr 10 10 -r bilinear -tap ${FILE} ${INCREASED_RES}

COLOURED=${FILE%.*}-coloured.tiff
rm -f ${COLOURED}
gdaldem color-relief ${INCREASED_RES} -alpha colour.txt ${COLOURED}
rm ${INCREASED_RES}

MBTILES=${FILE%.*}.mbtiles
rm -f ${MBTILES}
gdal_translate ${COLOURED} ${MBTILES} -of MBTILES
rm ${COLOURED}
