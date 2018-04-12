#!/bin/bash
#
#    .g8""8q.                   `7MM
#  .dP'    `YM.                   MM
#  dM'      `MM  ,6"Yb.  `7Mb,od8 MM  ,MP'
#  MM        MM 8)   MM    MM' "' MM ;Y
#  MM.      ,MP  ,pm9MM    MM     MM;Mm
#  `Mb.    ,dP' 8M   MM    MM     MM `Mb.    zilla.sh
#    `"bmmd"'   `Moo9^Yo..JMML. .JMML. YA.   Version 0.3 beta
#        MMb                                 "qark respex ur bandwidth" flavor
#         `bQq'
#
# install: save this to a file named qarkzilla.sh. then chmod +x qarkzilla.sh.
#
# usage: the command "sudo ./qarkzilla.sh 494745" will archive 8ch.net/qresearch/res/494745.html
# into a folder named 494745, with _both_ the display thumbnails and larger images preserved.
#
# ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAw+SpEEp7mvF8hwSSu4tSdEtpPUsPr1r6uu8f9Bb6ouvAZyl9ugfuvjlxz
# rbqTHdM/A/ICmfmwJaebssfccRLt5VLtg93PM8YnV2VgUjcyZu0mwtEC/n+HFX/zWHR0lpkN1YGI+EclCpTkFmuCmwSdA
# N2guyx3l/n/KORI6O2sQgP11lNX0K3i9BLPmKbJdpTXkbp3rJc6VtaSz4VJQR8OXiqNh2BN5KsolynPPeUA5m5U+o5ei2
# j3uaN9TULq5yzXMSAkh+hOiLQwlZilk1xrjtQO++u7R8xnSBNRDvmvbr7hl2K4d+HEvyE+7YbzAThezbvxXjhlz+z9EY+
# TVlatw== rsa-key-20180412
#
# grab the main page and all html assets (-P)
wget -E -H -k -K -p -nd -nv \
-e robots=off --limit-rate=100k --wait=10 --random-wait \
-P $1 -U "Qarkzilla 0.3.beta (wget) from SubQarkanon" \
https://8ch.net/qresearch/res/$1.html
# move the thumbs which just got created into their own directory
mkdir $1/thumb
for file in $1/*.png $1/*.jpg $1/*.jpeg $1/*.gif
do
  mv $file $1/thumb
done
# rewrite html links for thumb (display) images
sed -i 's/<img class="post-image" src="/<img src="thumb\//g' $1/$1.html
# rewrite internal html links for larger images
sed -i 's/https:\/\/media.8ch.net\/file_store\///g' $1/$1.html
# finally, retrieve the larger images and drop them in main folder
wget -nd -r -l 1 -H -A jpg,jpeg,png,gif -nv \
-e robots=off --limit-rate=100k --wait=10 --random-wait \
-P $1 -U "Qarkzilla 0.3.beta (wget) from SubQarkanon" \
https://8ch.net/qresearch/res/$1.html
# if perl is installed, use it to rewrite html, removing tiny, unused sitenav header
if perl < /dev/null > /dev/null 2>&1  ; then
   perl -pe 's/<div class="boardlist.*?<\/div>//g' \
   $1/$1.html > $1/$1.tmp && mv $1/$1.tmp $1/$1.html
fi
