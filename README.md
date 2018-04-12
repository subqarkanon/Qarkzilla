# Qarkzilla
Bash script which relies on wget to archive an 8ch thread, including the image thumbnails and full size images.

This solves the issue with [wget] not retrieving both the thumbnail images and the full size images when archiving an 8ch thread. It also does a couple minor rewrites to the URLs and has a one line perl command which strips out the tiny row of header images which shows up at the top of an 8ch page. Perl is not required, it will work with just wget/sed.

It can take awhile to pull down a thread, as it has not been optimized. The script could easily be extended to work for multiple threads, but is currently hardcoded to archive a single thread from the qresearch board.

Instructions are simple and embedded in the qarkzilla.sh script.
