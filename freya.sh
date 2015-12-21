#!/bin/sh

#MyDearFreya v0.04

chroot () {
	#Chroot specific functions that are run from within Trusty when this script is called with an argument of "installelementary"
	#------------------------------------------------------------------
    echo Setting language variables...
    sudo sed -i '1s/^/LC_ALL=en_US.UTF-8\n/' /etc/environment
    sudo sed -i '1s/^/LANGUAGE=en_US.UTF-8\n/' /etc/environment
    sudo sed -i '1s/^/LANG=en_US.UTF-8\n/' /etc/environment
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8

    echo Installing software-properties-common...
    sudo apt-get -y -qq install software-properties-common

    echo Adding Elementary OS repositories...
    sudo apt-add-repository -y ppa:elementary-os/os-patches
    sudo apt-add-repository -y ppa:elementary-os/stable

    echo Updating package lists...
    sudo apt-get -qq update

    echo Performing distribution upgrade...
    sudo apt-get -y -qq dist-upgrade

    echo Installing elementary-desktop... this will take some time...
	sudo apt-get -y -qq install elementary-desktop

    echo Installing some UI tweaks...
    #dbus-launch gsettings set org.gnome.settings-daemon.peripherals.touchpad disable-while-typing true
    dbus-launch gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
    dbus-launch gsettings set org.gnome.settings-daemon.peripherals.touchpad motion-acceleration 5.0
    #dbus-launch gsettings set org.gnome.desktop.interface cursor-size 48

    echo Fixing permissions...
    sudo chown -R $USER:$USER /home/$USER/.cache
    sudo chown -R $USER:$USER /home/$USER/.config
    sudo sed -i '1s/^/iface wlan0 inet manual\n/' /etc/network/interfaces

    echo Creating your startelementary scripts...
	cd /usr/bin
	sudo echo '#!/bin/sh
  exec xinit /usr/bin/xinit_pantheon' >> startelementary
	sudo chmod +x startelementary
	sudo chown root:root startelementary
	sudo echo '#!/bin/sh
  gnome-session --session=pantheon' >> xinit_pantheon
	sudo chmod +x xinit_pantheon
	sudo chown root:root xinit_pantheon
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo To continue...
    echo Exit the chroot with the command:
    echo '      exit'
    echo ==================================================
    echo ==================================================
    echo if it hangs unmounting, hit Ctrl+C to return to the crosh shell...
    echo and enter the following command from the chrosh shell:
    echo '      sudo sh freya.sh continue'
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo ==================================================
}

chrome () {

	sh -e crouton -r trusty -t x11,extension -n freya
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo To continue, enter your chroot:
    echo '      sudo enter-chroot -n freya'
    echo ==================================================
    echo ==================================================
    echo And from the chroot, enter the following command:
    echo '      sudo sh ~/Downloads/freya.sh installelementary'
    echo ==================================================
    echo ==================================================
    echo ==================================================
    echo ==================================================
}

tryagain () {
    C
    echo Picking up where we left off...
    echo =========================
    scriptinstall
}

scriptinstall () {
sudo echo '#!/bin/sh -e
# Copyright (c) 2014 The crouton Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

APPLICATION="${0##*/}"

USAGE="$APPLICATION [options]

Wraps enter-chroot to start an Elementary OS session.
By default, it will log into the primary user on the first chroot found.

Options are directly passed to enter-chroot; run enter-chroot to list them."

exec sh -e "`dirname "\`readlink -f "$0"\`"`/enter-chroot" -n freya "$@" "" \
    exec startelementary' >> /usr/local/bin/startelementary
    sudo chown root:root /usr/local/bin/startelementary
    sudo chmod +x /usr/local/bin/startelementary
    echo All done, entering Elementary OS Freya...
    sleep 1
	sudo startelementary

}


if [ "$1" = "installelementary" ]
then chroot
elif [ "$1" = "continue" ]
then tryagain
else chrome
fi
