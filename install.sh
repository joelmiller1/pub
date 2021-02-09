#!/bin/bash
# test install script
# to run, enter the following command into terminal:
# curl -sSL https://raw.githubusercontent.com/joelmiller1/pub/main/install.sh | bash
#
# curl to bash is potentially dangerous, so know you are trusting me with your computer:
# https://pi-hole.net/2016/07/25/curling-and-piping-to-bash#page-content
#
# Fide sed vide
echo "making temp directory..."
mkdir lab2
cd lab2

# download the things
echo "downloading files to be extracted..."
curl -sSL -O -J https://github.com/joelmiller1/pub/raw/main/files/CSCE692Project.tgz
curl -sSL -O -J https://github.com/joelmiller1/pub/raw/main/files/simplesim-3v0e.tgz

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

# download run script
cd ../CSCE692Project/benchmarks/go
curl -sSL -O -J https://raw.githubusercontent.com/joelmiller1/pub/main/files/run.sh
./run.sh
