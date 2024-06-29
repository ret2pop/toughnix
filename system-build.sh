#!/bin/sh
sudo nixos-rebuild switch
cd /home/preston/src/hyprnixmacs
git add "./"
git commit -m "$1"
git push origin main
cd /home/preston/org/website
git add "./"
git commit -m "$2"
git push origin main
rsync -azvP ~/website_html/ root@nullring.xyz:/usr/share/nginx/ret2pop/
aspell -d en dump master | aspell -l en expand > ~/.local/share/my.dict
#cd /home/preston/org/website/
#git add .
#git commit "$2"
#git push origin main
