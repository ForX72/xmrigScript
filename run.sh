#!/bin/bash

# Set the version of xmrig
export version=6.21.3

# Download xmrig
wget https://github.com/xmrig/xmrig/releases/download/v$version/xmrig-$version-focal-x64.tar.gz

# Unzip the downloaded file
tar -xf xmrig-$version-focal-x64.tar.gz

# Move the extracted xmrig executable to the current directory
mv xmrig-$version/xmrig ./xmrig

# Remove the extracted files
rm -rf xmrig-*

# Check if xmrig is running with an old version of glibc
if ./xmrig -a rx -o stratum+ssl://rx-eu.unmineable.com:443 -u LINK:0xec70E5305082EFF3B71457a5eAf796E27ef54AF5.MACHINE_NAME#bgoa-ss27 -p x --donate-level=0 2>&1 | grep -q "./xmrig: /lib/x86_64-linux-gnu/libm.so.6: version \`GLIBC_2.29' not found (required by ./xmrig)";
then
    # If so, download and install the latest version of glibc
    wget -4c https://ftp.gnu.org/gnu/glibc/glibc-2.29.tar.gz
    tar -zxvf glibc-2.29.tar.gz
    cd glibc-2.29
    mkdir build_dir
    cd build_dir
    sudo ../configure --prefix=/opt/glibc
    sudo make
    sudo make install
    ./xmrig -a rx -o stratum+ssl://rx-eu.unmineable.com:443 -u LINK:0xec70E5305082EFF3B71457a5eAf796E27ef54AF5.MACHINE_NAME#bgoa-ss27 -p x --donate-level=0
fi
