#!/bin/bash

CURRENTFOLDER=${PWD}

printf '\nInstalling Prerequisites:'
apt install git build-essential

printf '\nDownloading and installing SassC and LibSass:'
cd /usr/local/lib/
git clone https://github.com/sass/sassc.git --branch 3.2.1 --depth 1
git clone https://github.com/sass/libsass.git --branch 3.2.1 --depth 1

cd /usr/local/lib/sassc/
export SASS_LIBSASS_PATH="/usr/local/lib/libsass"
make

cd /usr/local/bin/
ln -s ../lib/sassc/bin/sassc sassc

cd ${CURRENTFOLDER}

printf '\nDownloading and installing Suru icons:'
mkdir $HOME/.local/share/icons

git clone https://github.com/snwh/suru-icon-theme.git
git -C suru-icon-theme checkout 33fb4f8

patch -p0 < index.theme.patch

for file in suru-icon-theme/Suru/*x*/places/folder*
do
  mogrify -colorspace gray "$file"
  mogrify -brightness-contrast 7x0 "$file"
  mogrify -fill "#87A752" -tint 100 "$file"
done

for file in suru-icon-theme/Suru/*x*/places/user*
do
  mogrify -colorspace gray "$file"
  mogrify -brightness-contrast 7x0 "$file"
  mogrify -fill "#87A752" -tint 100 "$file"
done

for file in suru-icon-theme/Suru/*x*/status/folder*
do
  mogrify -colorspace gray "$file"
  mogrify -brightness-contrast 7x0 "$file"
  mogrify -fill "#87A752" -tint 100 "$file"
done

cp -r suru-icon-theme/Suru $HOME/.local/share/icons/Suru-MATE

gsettings set org.mate.interface icon-theme Suru-MATE
