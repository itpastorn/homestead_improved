#!/bin/bash

# This script will not run correctly in PowerShell

numerrors=0

# Virtualbox and Vagrant must be installed
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
# http://unix.stackexchange.com/questions/46541/how-can-i-use-bashs-if-test-and-find-commands-together

if hash virtualbox
then
    echo "OK: Virtualbox installerad"
elif [[ -d /c/Program\ Files/Oracle && -n $(find /c/Program\ Files/Oracle -iname "*vbox*") ]]
then
    echo "OK: VirtualBox är installerad (windows)"
elif [[ -d /Applications/VirtualBox.app && -n $(find /Applications/VirtualBox.app -iname "*vbox*") ]]
then
    echo "OK: VirtualBox är installerad (mac)"
else
  numerrors=$((numerrors + 1))
  echo "Virtualbox måste vara installerad"
fi
# TODO test Linux

if [[ $(hash vagrant) ]]
then
  numerrors=$((numerrors + 1))
  echo "Vagrant måste vara installerad"
else
  echo "OK: Vagrant är installerad"
fi

# Check folder structure
## Current directory must be "ips-hs"
if [[ $(basename $(dirname $PWD)) != "webdev" ]]
then
  numerrors=$((numerrors + 1))
  echo "Föräldrakatalogen heter inte 'webdev"
  echo "Du är i $PWD"
fi

## Parent directory must be "webdev"
if [[ $(basename $PWD) != "ips-hs" ]]
then
  numerrors=$((numerrors + 1))
  echo "Du är inte i katalogen 'ips-hs' just nu"
  echo "Du är i $PWD"
fi

## There must be a webprojects subdirectory
## That in turn has "webbutveckling-1/"html" as subdirs
if [[ ! -d ../webprojects ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'webprojects' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -d ../webprojects/webbutveckling-1 ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'webbutveckling-1' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -d ../webprojects/webbutveckling-1/servertest ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'servertest' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -f ../webprojects/webbutveckling-1/servertest/index.php ]]
then
  numerrors=$((numerrors + 1))
  echo "Filen 'index.php' saknas i katalogen servertest"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -d ../webprojects/webbutveckling-1/uppgifter ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'uppgifter' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -d ../webprojects/webbutveckling-1/laxhjalpen ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'laxhjalpen' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ ! -d ../webprojects/webbutveckling-1/laxhjalpen/html ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'laxhjalpen/html' saknas"
  echo "Skapa den enligt uppgift noll i arbetsboken"
fi

if [[ $numerrors > 0 ]]
then
  echo "Antal fel: $numerrors"
  echo "Skriptet avbryts"
  exit $numerrors
fi

webdev=$(dirname $PWD)
webprojects="$webdev/webprojects"

# Original logic, new folders + additions
if [ "$(uname)" == "Darwin" ]
then
	# Mac OSX
    sed '' "s@map\: \.@map\: $webprojects@g" Homestead.yaml.neutral > Homestead.yaml
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
    # Linux
	sed "s@map\: \.@map\: $webprojects@g" Homestead.yaml.neutral > Homestead.yaml
elif [ -n "$COMSPEC" -a -x "$COMSPEC" ]
then
    # Windows - add colon
	var=$webprojects
	sub=${var:0:1} 
	workdir=${var/$sub/""};

	sub=${workdir:1:1}
	workdir=${workdir/$sub/":/"}
	sed "s@map\: \.@map\: $workdir@g" Homestead.yaml.neutral > Homestead.yaml
	echo "s@map\: \.@map\: $workdir@g"
else
    echo "Okänt operativsystem"
    exit 1
fi
echo "Filen Homestead.yaml har ändrats för att passa dig. Kontrollera den!"
echo "Starta Vagrant med kommandot 'vagrant up' i den här katalogen"
echo "Första gången tar det en stund"
exit 0
