#!/bin/bash


# Download files for shell lesson ("The Unix Shell")
LESSON="shell-novice"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget http://swcarpentry.github.io/shell-novice/data/shell-novice-data.zip
unzip shell-novice-data.zip


# Download files for SQL lesson ("Using Databases and SQL")
LESSON="sql-novice"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget https://github.com/swcarpentry/sql-novice-survey/raw/gh-pages/files/survey.db


# Download files for python lesson ("Programming with Python")
LESSON="python-novice-inflammation"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget http://swcarpentry.github.io/python-novice-inflammation/data/python-novice-inflammation-data.zip
unzip python-novice-inflammation-data.zip
wget http://swcarpentry.github.io/python-novice-inflammation/code/python-novice-inflammation-code.zip
unzip python-novice-inflammation-code.zip


# Download files for python gapminder lesson ("Plotting and Programming in Python")
LESSON="python-novice-gapminder"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -f "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget http://swcarpentry.github.io/python-novice-gapminder/files/python-novice-gapminder-data.zip
unzip python-novice-gapminder-data.zip


# Download files for R inflammation lesson ("Programming with R")
LESSON="r-novice-inflammation"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget http://swcarpentry.github.io/r-novice-inflammation/files/r-novice-inflammation-data.zip
unzip r-novice-inflammation-data.zip


# Download files for R gapminder lesson ("R for Reproducible Scientific Analysis")
# Part 5 mentions gapminder data downloaded previously but I don't see any previous reference to it
LESSON="r-novice-gapminder"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/Owls.txt
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/feline-data.csv
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/feline-data_v2.csv
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_wide.csv
wget https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/inflammation.csv


# Download files for make lesson ("Automation and Make")
LESSON="make-novice"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget http://swcarpentry.github.io/make-novice/files/make-lesson.zip
unzip make-lesson.zip


