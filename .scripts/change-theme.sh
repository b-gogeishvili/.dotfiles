#!/usr/bin/env bash

# Replace Wallpaper
lockscreen() {
    hyprlock="/home/$USER/.dotfiles/.config/hypr/hyprlock.conf"

    find='^$background_image =.*'
    replace="\$background_image = /home/$USER/.dotfiles/assets/wallpapers/$1"
    sed -i "s@$find@$replace@g" $hyprlock

    find='^$text_color =.*'
    replace="\$text_color = $2"
    sed -i "s@$find@$replace@g" $hyprlock
}

wallpaper() {
    read -p "Wallpaper name => " USER_INPUT

    hyprpaper="/home/$USER/.dotfiles/.config/hypr/hyprpaper.conf"

    for pattern in preload wallpaper; do
        find="^$pattern =.*"
        replace="$pattern = /home/$USER/.dotfiles/assets/wallpapers/$USER_INPUT"

        if [[ $pattern == "wallpaper"  ]]; then
            replace="$pattern = , /home/$USER/.dotfiles/assets/wallpapers/$USER_INPUT"
        fi

        sed -i "s@$find@$replace@g" $hyprpaper
    done

    lockscreen "$USER_INPUT" $1

    systemctl --user restart hyprpaper.service

}

# Ghostty theme
tty() {
    ghostty="/home/$USER/.dotfiles/.config/ghostty/config"

    find="^theme =.*"
    replace="theme = $1"
    
    sed -i "s@$find@$replace@g" $ghostty
}

# Hyprland
hyprland() {
    hyprconf="/home/$USER/.dotfiles/.config/hypr/hyprconf/general.conf"

    for pattern in "border" "border_gr" "border_inactive"; do
        find="^\$$pattern =.*"
 
        if [[ $pattern = "border_gr"  ]]; then
            replace="\$$pattern = $2"
        elif [[ $pattern = "border_inactive" ]]; then
            replace="\$$pattern = $3"
        else
            replace="\$$pattern = $1"
        fi

        sed -i "s@$find@$replace@g" $hyprconf
    done
}

# Waybar
waybar () {
    waybar="/home/$USER/.dotfiles/.config/waybar/style.css"
    
    COUNTER=0
    for var in $@; do
        patterns=(
            "bg-color"
            "text-color"
            "hover-effect"
            "redc"
            "greenc"
            "warn"
        )
        pattern="${patterns[$COUNTER]}"

        find="^\@define-color $pattern .*"
        replace="\@define-color $pattern $var;"

        sed -i "s@$find@$replace@g" $waybar

        COUNTER=$[$COUNTER +1]
    done

    systemctl --user restart waybar.service
}

# GTK
gtk() {
    gsettings set org.gnome.desktop.interface gtk-theme "$1"
    gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"
    gsettings set org.gnome.desktop.interface cursor-size 32

    rm -rf /home/$USER/.config/gtk-4.0/*
    cp -r /home/$USER/.themes/$1/gtk-4.0/* /home/$USER/.config/gtk-4.0/
}

# VSCode
code() {
    cat > /home/$USER/.config/Code\ -\ OSS/User/settings.json <<EOF 
{
    "editor.accessibilityPageSize": 12,
    "editor.fontFamily": "'JetBrains Mono', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', 'Font Awesome v4 Compatibility'",
    "extensions.experimental.affinity": {
        "asvetliakov.vscode-neovim": 1
    },
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "$1"
}
EOF

}

# Obsidian
obsidian() {
    
}

# Entry
read -p "Enter theme [ nord, gruvbox ] => " THEME

if [[ $THEME = "gruvbox" ]]; then

    text_color="rgba(ebdbb2ee)"
    ghostty_theme="GruvboxDark"
    border="rgba(d5c4a1ee)"
    border_gr="rgba(665c54ee)"
    border_inactive="rgba(282828ee)"
    gtk_theme="Gruvbox-Dark"

    bg_color="rgba(40,40,40,1)"
    text_color="rgba(235,219,178,1)"
    hover_effect="rgba(0,0,0,0.2)"
    redc="rgba(204,35,29,1)"
    greenc="rgba(152,151,26,1)"
    warn="rgba(215,153,33,1)"

    vscode_theme="Gruvbox Dark Medium"

elif [[ $THEME = "nord" ]]; then
    
    text_color="rgba(eceff4ee)"
    ghostty_theme="nord"
    border="rgba(d8dee9ee)"
    border_gr="rgba(4c566aee)"
    border_inactive="rgba(2e3440aa)"
    gtk_theme="Nordic"

    bg_color="rgba(46,52,64,1)"
    text_color="rgba(236,239,244,1)"
    hover_effect="rgba(0,0,0,0.2)"
    redc="rgba(191,97,106,1)"
    greenc="rgba(163,190,140,1)"
    warn="rgba(235,203,139,1)"

    vscode_theme="Nord"

elif [[ $THEME = "toggle" ]]; then

    echo "todo"

else
    echo "Invalid theme name, choose from => [ nord, gruvbox ]"
    exit 1
fi

wallpaper $text_color
tty $ghostty_theme
hyprland $border $border_gr $border_inactive
waybar $bg_color $text_color $hover_effect $redc $greenc $warn
gtk $gtk_theme
code "$vscode_theme"

echo -e "\nSuccess. Restart terminal now!"