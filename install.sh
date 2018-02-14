#!/bin/bash

mkdir $HOME/.local/share/icons

git clone https://github.com/snwh/suru-icon-theme.git

patch -p0 < index.theme.patch

for file in suru-icon-theme/Suru/*x*/places/folder*
do
  convert -colorspace gray "$file" "$file"
  convert -fill "#87A752" -tint 100 "$file" "$file" 
done

for file in suru-icon-theme/Suru/*x*/places/user*
do
  convert -colorspace gray "$file" "$file"
  convert -fill "#87A752" -tint 100 "$file" "$file" 
done

for file in suru-icon-theme/Suru/*x*/status/folder*
do
  convert -colorspace gray "$file" "$file"
  convert -fill "#87A752" -tint 100 "$file" "$file" 
done

cp -r suru-icon-theme/Suru $HOME/.local/share/icons/Suru-MATE

gsettings set org.mate.interface icon-theme Suru-MATE
