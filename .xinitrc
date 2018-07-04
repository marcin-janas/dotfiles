xsetroot -solid "#ececec" &
setxkbmap pl &

while true; do
    xsetroot -name "`~/bin/py_monitor.py` | `uptime | sed 's/.*://'` | `date +'%A, %x, %X'`"
    sleep 1
done &

xset +fp /usr/share/fonts/terminus/

wmname LG3D &

exec dwm
