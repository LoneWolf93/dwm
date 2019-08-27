# Programa para aplicar un fondo de escritorio
nitrogen --restore &
# Programa para descargar automaticamente imagenes de Internet
#variety &
# Programa para bloquear el portatil/ordenador
#xscreensaver -nosplash &
# Programa para bindear teclas
#xbindkeys &
# Icono que se aniade en trayer para bajar, silencias y subir el volumen con alsamixer
volumeicon &
# Programa para administrar la red
nm-applet &
# Cambiamos el idioma del teclado a estadounidense internacional
setxkbmap us intl &
# Programa para actualizar e instalar paquetes con pacman
pamac-tray &
# Importar pantalla para que funcione el dunst
systemctl --user import-environment DISPLAY &
# Iniciar el servicio dunst (notifier)
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
