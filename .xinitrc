# Program to set a wallpaper at the start of the system
nitrogen --restore &
# Programa to download images automatically every minute, hour, etc
#variety &
# Program to lock our desktop
#xscreensaver -nosplash &
# Program to bind keys
#xbindkeys &
# Volume icon for manage the volume level
volumeicon &
# Program to administrate the network
nm-applet &
# Command to set the keyboard map to us intl
setxkbmap us intl &
# Program to install and update the system graphically
pamac-tray &
# Import the display (this command is essential for the work of dunst)
systemctl --user import-environment DISPLAY &
# Start dunst service (notifier)
systemctl start --user dunst.service &

dte(){
  dte="$(date +"%A %d de %B")"
  echo -e "$dte"
}

hr(){
  hr="$(date +"%H:%M")"
  echo -e "$hr"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "$mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "$cpu% cpu"
}

while true; do
     xsetroot -name "$(cpu) | $(mem) | $(dte) | $(hr)"
     sleep 1s    # Update time every second
done &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec dwm
