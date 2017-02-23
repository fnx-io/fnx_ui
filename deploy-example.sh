#!/bin/sh
cd showcase &&
pub build &&
cd build;
rm `find . -name *.ng_*.json`;
cd web &&
gcloud --project ma-web compute copy-files * static-ma:/usr/share/nginx/www/demo.fnx.io/fnx_ui/ng2 --zone europe-west1-b;
#cvrk.sh "Deploynuta nova verze fnx_ui -dart viz: http://demo.fnx.io/fnx_ui/ng2/";
