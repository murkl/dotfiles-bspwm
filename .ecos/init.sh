#!/bin/sh
VERSION="1"

# This script will install all dependencies for this dotfiles repository
# and will automatically call by the ecos installation routine

ECOS_CONFIG_HOME="$HOME/.ecos/config"
ECOS_CONFIG_FILE="$ECOS_CONFIG_HOME/ecos.conf"

# ///////////////////////////////////////////
# MAIN
# ///////////////////////////////////////////

init() {

    # ///////////////////////////////////////////
    # Install packages
    # ///////////////////////////////////////////

    packages=""

    # Bspwm & dependencies
    packages="$packages xorg-server xorg-xinit"     # Graphical Server
    packages="$packages pulseaudio-alsa"            # Audio
    packages="$packages bspwm sxhkd"                # Window manager & Shortcut manager
    packages="$packages polybar"                    # Status bar
    packages="$packages dunst libnotify"            # Notification
    packages="$packages rofi"                       # App launcher
    packages="$packages picom"                      # Window commpositor
    packages="$packages redshift"                   # Night mode
    packages="$packages unclutter"                  # Hide mouse pointer
    packages="$packages kitty"                      # Terminal emulator
    packages="$packages neovim neovim-plug"         # Editor
    packages="$packages ranger ueberzug"            # File manager
    packages="$packages sxiv"                       # Image viewer
    packages="$packages xwallpaper"                 # Wallpaper
    packages="$packages scrot"                      # Screenshot tool
    packages="$packages pass"                       # Password manager
    packages="$packages zathura zathura-pdf-mupdf"  # PDF viewer
    packages="$packages mpd mpc ncmpcpp"            # Music player
    packages="$packages mpv"                        # Video player
    packages="$packages gotop-bin neofetch"         # Monitoring
    packages="$packages qutebrowser python-adblock" # Browser
    packages="$packages atool zip unzip unrar"      # Archive manager
    packages="$packages geary"                      # E-Mail

    # Miscellaneous
    packages="$packages gnome-keyring"
    packages="$packages xdg-user-dirs"
    packages="$packages zsh-autosuggestions zsh-syntax-highlighting"
    packages="$packages xorg-xsetroot xorg-xset xorg-xkill"
    packages="$packages wmctrl xclip xdotool"
    packages="$packages pacman-contrib"
    packages="$packages man-db"
    packages="$packages simple-mtpfs fuseiso"
    packages="$packages pulsemixer"
    packages="$packages openssh sshpass"
    packages="$packages wget youtube-dl rsync"
    packages="$packages zenity jq bc"
    packages="$packages nfs-utils samba"
    packages="$packages ttf-dejavu ttf-liberation"
    packages="$packages hunspell hunspell-en_us hunspell-de"
    packages="$packages galculator"

    # VSCodium
    packages="$packages vscodium-bin vscodium-bin-marketplace"

    # Nemo
    packages="$packages nemo nemo-fileroller nemo-image-converter"
    packages="$packages gvfs gvfs-smb gvfs-mtp"
    packages="$packages gnome-disk-utility"

    # Install packages
    print_title "INSTALL PACKAGES"
    paru --noconfirm --needed --sudoloop -Syyu $packages

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Gnome keyring with PAM
    # ///////////////////////////////////////////

    print_title "CONFIGURE PAM"

    {
        echo "#%PAM-1.0"
        echo ""
        echo "auth       required     pam_securetty.so"
        echo "auth       requisite    pam_nologin.so"
        echo "auth       include      system-local-login"
        echo "auth       optional     pam_gnome_keyring.so"
        echo "account    include      system-local-login"
        echo "session    include      system-local-login"
        echo "session    optional     pam_gnome_keyring.so auto_start"
    } >"/tmp/pam-login"

    sudo cp "/tmp/pam-login" "/etc/pam.d/login"

    echo -e "DONE"

    # ///////////////////////////////////////////
    # GnuPG
    # ///////////////////////////////////////////

    mkdir -p "$HOME/.local/share/gnupg"
    echo 'pinentry-program /usr/bin/pinentry-gnome3' >"$HOME/.local/share/gnupg/gpg-agent.conf"
    # Set correct gnupg permission
    chmod -R go-rwx "$HOME/.local/share/gnupg"
    echo -e "DONE"

    # ///////////////////////////////////////////
    # XDG
    # ///////////////////////////////////////////

    print_title "CONFIGURE XDG"

    # Disable auto run of XDG to use user-dir.dirs instead
    sudo sed -i 's/enabled=True/enabled=False/g' /etc/xdg/user-dirs.conf
    # Update dirs

    xdg-user-dirs-update --force

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Configure Samba
    # ///////////////////////////////////////////

    print_title "CONFIGURE SAMBA"

    if [ ! -f "/etc/samba/smb.conf" ]; then
        {
            echo "[global]"
            echo "   workgroup = WORKGROUP"
            echo "   log file = /var/log/samba/%m"
        } >"/tmp/smb.conf"
        sudo mv "/tmp/smb.conf" "/etc/samba/smb.conf"
    fi

    sudo systemctl enable smb.service

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Nemo Open Terminal (F4)
    # ///////////////////////////////////////////

    print_title "NEMO TERMINAL SHORTCUT"

    mkdir -p "$HOME/.gnome2/accels/"
    echo '(gtk_accel_path "<Actions>/DirViewActions/OpenInTerminal" "F4")' >"$HOME/.gnome2/accels/nemo"

    # Cinnamon
    gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty
    gsettings set org.cinnamon.desktop.interface can-change-accels true

    # GNOME
    gsettings set org.gnome.desktop.default-applications.terminal exec kitty
    gsettings set org.gnome.desktop.interface can-change-accels true

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Remove orphans
    # ///////////////////////////////////////////

    print_title "REMOVE ORPHANS"

    sudo pacman --noconfirm -Rs $(pacman -Qtdq)

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Create symlinks
    # ///////////////////////////////////////////
    print_title "CREATE SYM LINKS"

    sudo ln -sf /usr/bin/rofi /usr/bin/dmenu
    sudo ln -sf /usr/bin/nvim /usr/bin/vim

    echo -e "DONE"

    # ///////////////////////////////////////////
    # Create default dirs
    # ///////////////////////////////////////////

    print_title "CREATE DIRS"

    mkdir -p "$HOME/Desktop"
    mkdir -p "$HOME/Documents"
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/Music"
    mkdir -p "$HOME/Pictures"
    mkdir -p "$HOME/Projects"
    mkdir -p "$HOME/Templates"
    mkdir -p "$HOME/Videos"

    # ///////////////////////////////////////////
    # CHECK ENV
    # ///////////////////////////////////////////

    # Create config dir and file
    mkdir -p "$ECOS_CONFIG_HOME"
    touch "$ECOS_CONFIG_FILE"

    # Check values
    check_env "ECOS_CORE" '$HOME/.ecos/bin/ecos'
    check_env "ECOS_CONFIG_HOME" '$HOME/.ecos/config'
    check_env "ECOS_CONFIG_FILE" '$ECOS_CONFIG_HOME/ecos.conf'

    check_env "ECOS_MONITOR" 'HDMI-2'
    check_env "ECOS_WIRELESS_INTERFACE" 'wlp8s0'
    check_env "ECOS_BATTERY_INTERFACE" 'BAT1'
    check_env "ECOS_BATTERY_ADAPTER" 'ACAD'

    check_env "ECOS_BACKUP_SOURCE" '$HOME'
    check_env "ECOS_BACKUP_DESTINATION" '/mnt/crypt-usb/$USER'
    check_env "ECOS_BACKUP_SSH_HOST" ''
    check_env "ECOS_BACKUP_SSH_USER" ''
    check_env "ECOS_BACKUP_SSH_PASS" ''

    check_env "ECOS_POSTEO_SERVER" 'posteo.de:993'
    check_env "ECOS_POSTEO_EMAIL" 'user@posteo.de'
    check_env "ECOS_POSTEO_PASSWORD" ''
    check_env "ECOS_WEATHER_LOCATION" 'Kassel'

    check_env "ECOS_DOWNLOAD_MUSIC" '$HOME/Downloads/Music'
    check_env "ECOS_DOWNLOAD_VIDEOS" '$HOME/Downloads/Videos'
    check_env "ECOS_DOWNLOAD_MOVIES" '$HOME/Downloads/Movies'

    check_env "ECOS_SCREENSHOTS" '$HOME/Desktop/Screenshots'

    # ECOS DEFAULT APPS
    check_env "ECOS_TERMINAL" 'kitty'
    check_env "ECOS_TERMINAL_CLASS" 'kitty'
    check_env "ECOS_EDITOR" 'vscodium'
    check_env "ECOS_EDITOR_CLASS" 'VSCodium'
    check_env "ECOS_FILES" 'nemo'
    check_env "ECOS_FILES_CLASS" 'Nemo'
    check_env "ECOS_BROWSER" 'qutebrowser'
    check_env "ECOS_BROWSER_CLASS" 'qutebrowser'
    check_env "ECOS_EMAIL" 'geary'
    check_env "ECOS_EMAIL_CLASS" 'Geary'
    check_env "ECOS_MUSIC" 'kitty -e ncmpcpp'
    check_env "ECOS_MUSIC_CLASS" ''

    # Load config file
    echo -e "DONE"

}

update() {
    echo "nothing"
}

remove() {
    echo "nothing"
}

# ///////////////////////////////////////////
# HELPER
# ///////////////////////////////////////////

print_title() {
    echo -e "\n"
    echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo -e "> $1"
    echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
}

check_env() {
    local config_key="$1"
    local config_value="$2"
    touch "$ECOS_CONFIG_FILE"
    if ! grep -qrnw "$ECOS_CONFIG_FILE" -e "$config_key=*"; then
        echo "export $config_key=\"$config_value\"" >>"$ECOS_CONFIG_FILE"
    fi
}

##################################################
# START
##################################################

if [ "$1" = "--version" ]; then
    echo -e "$VERSION"
    exit $?
fi

if [ "$1" = "--init" ]; then
    init "$@"
    exit $?
fi

if [ "$1" = "--update" ]; then
    update "$@"
    exit $?
fi

if [ "$1" = "--remove" ]; then
    remove "$@"
    exit $?
fi

##################################################
# HELP
##################################################

echo "USE WITH PARAMETERS"
echo "--version"
echo "--init"
echo "--update"
echo "--remove"
