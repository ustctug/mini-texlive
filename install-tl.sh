#!/bin/bash

REMOTE="http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet"
TEXLIVE=2015
PACKAGES="zhnumber zapfding"
DOCPACKAGES="latexmk texdoc ctex"
SRCPACKAGES=""

mkdir -p /tmp/install-texlive
cd /tmp/install-texlive/

curl -sSL $REMOTE/install-tl-unx.tar.gz | tar -xzv -C ./ --strip-components=1

cat << EOF > texlive.profile
selected_scheme scheme-basic
TEXMFHOME ~/.texmf
collection-basic 1
collection-genericrecommended 1
collection-latex 1
collection-latexextra 1
collection-latexrecommended 1
collection-xetex 1
option_autobackup 0
option_doc 0
option_src 0
EOF

PLATFORM=`./install-tl --print-platform`
TEXBIN="/usr/local/texlive/${TEXLIVE}/bin/${PLATFORM}"
./install-tl -profile texlive.profile -repository $REMOTE

echo 'export PATH=$PATH':$TEXBIN >> ~/.bash_profile
$TEXBIN/tlmgr install $PACKAGES
$TEXBIN/tlmgr install --with-doc $DOCPACKAGES
$TEXBIN/tlmgr install --with-doc --with-src $SRCPACKAGES
