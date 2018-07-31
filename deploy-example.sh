#!/bin/sh
cd showcase &&
webdev build &&
cp ../fnx_ui/lib/css/*.css build/packages/fnx_ui/css/ &&
cd build &&
gcloud --project ma-web compute scp * static-ma:/usr/share/nginx/www/demo.fnx.io/fnx_ui/ng5 --recurse --zone europe-west1-b;
#cvrk.sh "Deploynuta nova verze fnx_ui -dart viz: http://demo.fnx.io/fnx_ui/ng2/";
