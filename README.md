# MyDearFreya
Script to install Elementary OS 0.3 (Freya) onto your Chromebook

Courtesy of Reddit user Skitals, more discussion here: http://www.reddit.com/r/Crouton/comments/32akho/any_guides_to_getting_the_new_elementary_freya/

## How to Install
1. Put the Chromebook in Developer mode by holding Esc + Refresh and tapping the Power button
2. Download Crouton script  https://github.com/dnschneid/crouton
3. Download MyDearFreya script, either at https://drive.google.com/folderview?id=0B5m4MQHPNKZjc1FfWldnWnZyM2M&usp=sharing, or from this GitHub repository
4. Make sure freya.sh and crouton are in your ~/Downloads folder. To install, from a crosh shell run:
    ```shell
    $ cd ~/Downloads
    $ sudo sh freya.sh
    ```
5. This script is not fully automated (yet)... follow the prompts, and enter the commands as directed.
6. NOTE: After the OS is installed, you must return to the crosh shell and enter ```sudo sh freya.sh continue``` to get the startelementary script!
7. After installation, you can enter elementary from a crosh shell with:
    ```shell
    $ sudo startelementary
    ```


## After Install
1. There may be updates pushed into elementary OS Freya since the last release. Install these updates for updated packages, security patches, and improved performance.

    To do so, click on your Applications bar and launch Software Updates. It will automatically check for updates the first time you launch it. Click “Install Updates” to begin the update.

2. Upon using Elementary OS you may find that your changes in System Settings do not save; if so, run the following command from terminal
    ```shell
    $ sudo chown -R $USER:$USER /home/$USER/.config
    ```

3. You may also find that the Software Center does not work; if so, run the following command from terminal
    ```shell
    $ sudo chown -R $USER:$USER /home/$USER/.cache
    ```

4. You can add the Elementary Tweaks tool to your System Settings to allow additional UI Tweaks
    ```shell
    $ sudo add-apt-repository ppa:mpstark/elementary-tweaks-daily
    $ sudo apt-get update
    $ sudo apt-get install elementary-tweaks
    ```

5. Install Ubuntu Restricted Extras to get codecs for playing mp3's
    ```shell
    $ sudo apt-get install ubuntu-restricted-extras
    ```

6. Here are a few links showing more things you can do after installing Elementary OS. These include installing alternative web browsers like Firefox or Chrome, or installing other programs:
    * http://itsfoss.com/things-todo-elementary-os-freya/
    * http://fuckyeah-elementaryos.tumblr.com/post/117983423013/things-to-do-after-installing-elementary-os-freya
    * http://www.binarytides.com/better-elementary-os-luna/

7. Anytime you need to switch between Chrome OS and Elementary OS, use CTRL+ALT+SHIFT+BACK or CTRL+ALT+SHIFT+FORWARD (the BACK and FORWARD keys are on the top row of your keyboard, next to Esc).


## Changes
### v0.04
- fixed .config ownership which broke wallpaper and probably other stuff
- disabled touchpad setting that was causing some users problems

### v0.03
- fixed Software Center (.cache permissions were wrong)
- disabled network interface (Chrome OS controls this, it was causing Software Center to not work)
- includes entire start script now instead of copying xfce script, which you didn't have if you've never installed the xfce4 target
- reverted cursor size for non-Pixel users. Pixel users can uncomment the line in the script, or after booting, from terminal enter: gsettings set org.gnome.desktop.interface cursor-size 48

### v0.02
- No longer installs an initial DE target... works with only x11
- Now adds sources via PPA instead of copying freya /etc/apt sources
- Added touchpad and cursor tweaks
- Fixed missing clock


=======================================

Based MyDearWatson by AldousP:
https://github.com/AldousP/MyDearWatson
