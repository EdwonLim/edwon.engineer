#!/bin/bash

rm db.json
hexo clean
hexo g
scp -r ./public/* root@123.56.155.201:/root/www/blog
