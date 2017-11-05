#!/bin/bash

# This script will not run correctly in PowerShell

numerrors=0

# Virtualbox and Vagrant must be installed
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
# http://unix.stackexchange.com/questions/46541/how-can-i-use-bashs-if-test-and-find-commands-together

if hash virtualbox
then
    echo "OK: Virtualbox installerad" >&2
elif [[ -d /c/Program\ Files/Oracle && -n $(find /c/Program\ Files/Oracle -iname "*vbox*") ]]
then
    echo "OK: VirtualBox är installerad (windows)" >&2
elif [[ -d /Applications/VirtualBox.app && -n $(find /Applications/VirtualBox.app -iname "*vbox*") ]]
then
    echo "OK: VirtualBox är installerad (mac)"
else
  numerrors=$((numerrors + 1))
  echo "Virtualbox måste vara installerad" >&2
fi
# TODO test Linux

if [[ $(hash vagrant) ]]
then
  numerrors=$((numerrors + 1))
  echo "Vagrant måste vara installerad" >&2
else
  echo "OK: Vagrant är installerad"
fi

# Check folder structure
## Parent directory must be "webdev"
DN=$(dirname "$PWD")
if [[ $(basename "$DN") != "webdev" ]]
then
  numerrors=$((numerrors + 1))
  echo "Föräldrakatalogen heter inte 'webdev" >&2
  echo "Du är i $PWD" >&2
fi

## Current directory must be "ips-hs"
## eller ett namn som inleds med de tecknen
## för att tillåta flera aparallella instanser
pwdtemp=$(basename "$PWD")
if [[ ${pwdtemp:0:6} != "ips-hs" ]]
then
  numerrors=$((numerrors + 1))
  echo "Du är inte i katalogen 'ips-hs' just nu" >&2
  echo "Du är i $PWD" >&2
fi

## There must be a webprojects subdirectory
## That in turn has "webbutveckling-1/"html" as subdirs
if [[ ! -d ../webprojects ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'webprojects' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -d ../webprojects/webbutveckling-1 ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'webbutveckling-1' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -d ../webprojects/webbutveckling-1/servertest ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'servertest' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -f ../webprojects/webbutveckling-1/servertest/index.php ]]
then
  numerrors=$((numerrors + 1))
  echo "Filen 'index.php' saknas i katalogen servertest" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -d ../webprojects/webbutveckling-1/uppgifter ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'uppgifter' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -d ../webprojects/webbutveckling-1/laxhjalpen ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'laxhjalpen' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ ! -d ../webprojects/webbutveckling-1/laxhjalpen/html ]]
then
  numerrors=$((numerrors + 1))
  echo "Katalogen 'laxhjalpen/html' saknas" >&2
  echo "Skapa den enligt uppgift noll i arbetsboken" >&2
fi

if [[ $numerrors > 0 ]]
then
  echo "Antal fel: $numerrors"
  echo "Skriptet avbryts"
  exit $numerrors
fi

webdev=$(dirname "$PWD")
webdev=$(echo $webdev | sed 's/ /\\ /g')
webprojects="$webdev/webprojects"

# Original logic, new folders + additions
if [ "$(uname)" == "Darwin" ]
then
	# Mac OSX
    sed "s@map\: \.@map\: $webprojects@g" Homestead.yaml.neutral > Homestead.yaml
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
    # Linux
	sed "s@map\: \.@map\: $webprojects@g" Homestead.yaml.neutral > Homestead.yaml
elif [ -n "$COMSPEC" -a -x "$COMSPEC" ]
then
  # PWD must not contain non-ascii characters
  if [[ $(echo "$PWD" | grep -P "[\x80-\xFF]") ]]
  then
    echo "Sökvägen innehåller icke-ascii-tecken (Fatal error)" >&2
    exit 1
  fi
  # Windows - add colon
	var=$webprojects
	sub=${var:0:1} 
	workdir=${var/$sub/""};

	sub=${workdir:1:1}
	workdir=${workdir/$sub/":/"}
	sed "s@map\: \.@map\: $workdir@g" Homestead.yaml.neutral > Homestead.yaml
	echo "s@map\: \.@map\: $workdir@g"
else
    echo "Okänt operativsystem" >&2
    exit 1
fi
echo "Filen Homestead.yaml har ändrats för att passa dig. Kontrollera den!"
echo "Starta Vagrant med kommandot 'vagrant up' i den här katalogen"
echo "Första gången tar det en stund"
exit 0
