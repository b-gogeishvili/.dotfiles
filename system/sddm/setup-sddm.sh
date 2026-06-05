SDDM_PATH="/usr/share/sddm/themes/silent"
DOTS_PATH="$(pwd)"

# Install SDDM and SDDM Silent Theme
for pkg in sddm sddm-silent-theme; do
    if ! paru -Q "$pkg" &>/dev/null; then
        paru -S "$pkg"
    else
        echo "$pkg is already installed, skipping..."
    fi
done

# Create symbolic links
ln -s $DOTS_PATH/hades.conf $SDDM_PATH/configs/hades.conf
ln -s $DOTS_PATH/backgrounds/*.mp4 $SDDM_PATH/backgrounds/
echo "created links!"

if [[ $(tail -n1 $SDDM_PATH/metadata.desktop) != "ConfigFile=configs/hades.conf" ]]; then
    echo "ConfigFile=configs/hades.conf" >> $SDDM_PATH/metadata.desktop
fi

echo "done!"
