#!/bin/bash
# check requirements

apt update

# chech for time
if ! command -v time &> time
then
	echo "command 'time' not found"
	echo "will try and install..."
	apt install time
	echo "finished installing time"
else
	echo "time command found!"
fi

# check for make
if ! command -v make &> /usr/bin/make
then
	echo "command 'make' not found"
	echo "will try and install..."
	apt install make
	echo "finished installing make"
else
	echo "make command found!"
fi

# check for gcc/g++
if ! command -v gcc &> /usr/bin/gcc
then
	echo "command 'gcc' not found"
	echo "will try and install gcc, g++, and support libs..."
	apt install g++ gcc-multilib g++-multilib
	echo "finished installing gcc"
else
	echo "gcc command found!"
fi
