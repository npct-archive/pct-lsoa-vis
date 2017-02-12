#!/bin/sh
UPLOAD_DIR=$1

echo "Compressing the (non blank) tiles before uploading to the server\n"
rm -f ${UPLOAD_DIR}.tar.gz

# Tiles of size 334 bytes are empty so we don't need to transfer them
find . -name "*.png" -size +335c -type f | tar -czf ${UPLOAD_DIR}.tar.gz -T -

echo "Uploading the tiles to the tileserver\n"
scp ${UPLOAD_DIR}.tar.gz root@npttile.vs.mythic-beasts.com:/var/www/html/
rm -f ${UPLOAD_DIR}.tar.gz

echo "Decompressing the tiles on the tileserver\n"
ssh root@npttile.vs.mythic-beasts.com "tar -xzf /var/www/html/${UPLOAD_DIR}.tar.gz -C /var/www/html"
