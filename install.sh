#!/bin/bash
# test install script
# to run, enter the following command into terminal:
# curl -sSL https://raw.githubusercontent.com/joelmiller1/pub/main/install.sh | bash
#
# this is potentially dangerous, so know the implications of it:
# https://pi-hole.net/2016/07/25/curling-and-piping-to-bash#page-content
echo "making temp directory..."
mkdir csce692_lab2
cd csce692_lab2

# download the things
echo "downloading files to be extracted..."
curl -sSL https://github.com/joelmiller1/pub/blob/main/files/CSCE692Project.tgz?raw=true
curl -sSL https://github.com/joelmiller1/pub/blob/main/files/simplesim-3v0e.tgz?raw=true

# extract the things
echo "extracting files..."
tar zxvf CSCE692Project.tgz
tar zxvf simplesim-3v0e.tgz

# make the things (assuming default config e.g. little endian)
cd simplesim-3.0
make config-pisa
make
make sim-tests
#im a noob with bash
add2path="export PATH=\$PATH:"
add2path+=$(pwd)
echo $add2path >> ~/.bashrc
echo "finished..."
