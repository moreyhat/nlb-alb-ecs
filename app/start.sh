#!/bin/sh

if [ -n $APP_NAME ]; then
    mkdir /usr/share/nginx/html/$APP_NAME;
    echo $APP_NAME > /usr/share/nginx/html/$APP_NAME/index.html;
fi

nginx -g 'daemon off;'