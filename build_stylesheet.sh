#!/bin/sh
echo "Building stylesheet and copying to ng2 lib directory ..."; 
cd stylesheet/ && gulp release && cp -r _dist/css ../fnx_ui/lib/;
cd ..;
