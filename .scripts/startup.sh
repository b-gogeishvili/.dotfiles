exists=$(hyprctl monitors | grep DP-4)

echo $exists > ~/startup.log
