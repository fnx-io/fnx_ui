#!/bin/sh
dartdoc &&
cd doc/api &&
gcloud --project ma-web compute copy-files * static-ma:/usr/share/nginx/www/demo.fnx.io/fnx_ui/doc --zone europe-west1-b;
