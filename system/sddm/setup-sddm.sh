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

# Copy config file
sudo cp $DOTS_PATH/custom.conf $SDDM_PATH/configs/custom.conf
echo "copied config!"

# Decided not add mp4 files in my git repository
# Add background videos/images manually to $SDDM_PATH/backgrounds
# sudo cp $DOTS_PATH/backgrounds/*.mp4 $SDDM_PATH/backgrounds/

if [[ $(tail -n1 $SDDM_PATH/metadata.desktop) != "ConfigFile=configs/custom.conf" ]]; then
    echo "ConfigFile=configs/custom.conf" >> $SDDM_PATH/metadata.desktop
fi

echo "done!"
