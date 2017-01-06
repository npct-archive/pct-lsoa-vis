#!/bin/sh

FILE=$1
gdaldem color-relief ${FILE} -alpha colour.txt ${FILE%.*}-coloured.tif
