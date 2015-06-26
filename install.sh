#!/bin/bash

# Version
VERSION="2.2.9"

# install needed dependencies
apt-get install -y libodbc1 unixodbc libpq5 libmysql++-dev libmysqlclient-dev checkinstall

# Download sphinx and libstemmer_c
wget http://sphinxsearch.com/files/sphinx-${VERSION}-release.tar.gz
tar xzf sphinx-${VERSION}-release.tar.gz
cd sphinx-${VERSION}-release/
wget http://snowball.tartarus.org/dist/libstemmer_c.tgz
tar xvf libstemmer_c.tgz

# Configure and compile sphinxsearch
./configure --with-libstemmer --enable-id64 --prefix=/usr --exec-prefix=/usr --localstatedir=/var --sysconfdir=/etc/sphinx && make -j4

# Create the deb
cp -a ../etc .
find etc > customfiles.txt
checkinstall --include=customfiles.txt --pkgname=sphinxsearch --pkgversion=${VERSION} --maintainer=matteo.mattei@gmail.com --install=no --strip=yes -y

# Copy deb file
cp *.deb ../

# Cleanup
cd ..
rm -rf sphinx-${VERSION}-*
