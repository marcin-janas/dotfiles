S=⋮

while true; do xsetroot -solid lightgray -name \
" $(awk '{print $1" "$2" "$3}' /proc/loadavg) \
$S $([[ $(cat /sys/class/net/wlp1s0/operstate 2>/dev/null) == "up" ]] \
&& echo ▼ $(iw dev wlp1s0 link|awk '/SSID/{print $2}') || echo ▽) \
$S 🎵 ◀ $(pamixer --get-volume-human) \
$S ✶ $(brightnessctl info|grep -oE '[0-9]*%') \
$S $([[ $(cat $(find /sys/devices -name conservation_mode) 2>/dev/null) == "1" ]] \
&& echo ≢ || echo ≡) ⚡ \
$(sed -e 's/Discharging/-/' -e 's/Charging/+/' -e 's/Unknown/?/' -e 's/Full//' -e 's/Not charging/~/' /sys/class/power_supply/BAT0/status) \
$(cat /sys/class/power_supply/BAT0/capacity)% \
$S $(date +"%jD %UW %Y %B %d %A 󱑆 %I:%M:%S") "; \
sleep 1s; done &

setxkbmap pl

exec dwm

