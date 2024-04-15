#!/bin/sh

# resize, pull down and add text
convert uZ1ZdF5.png -resize 800x600 -background black -compose Copy -gravity South  -extent 800x600 -pointsize 80 -channel RGBA -gravity NorthEast -fill darkred -draw "text 25,60 TechTipsLinux"   1.png;

# green text
convert uZ1ZdF5.png -resize 800x600 -background green -compose Copy -gravity North  -extent 800x600 -pointsize 60 -channel RGBA -gravity SouthEast -fill lightgrey -stroke black -draw "text 15,68 TechTipsLinux"   1.png ;
