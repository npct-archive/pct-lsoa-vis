#!/bin/sh

UPLOAD_DIR=$1

scp -r ${UPLOAD_DIR} root@npttile.vs.mythic-beasts.com:/var/www/html/
