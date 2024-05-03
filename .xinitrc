#!/bin/sh

/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


#[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

xsetroot -cursor_name left_ptr &

#xrandr --output eDP-1 --mode 1920x1080 --dpi 120 &
xrandr --output eDP-1 --mode 1920x1080 & 

# disable touchpad
xinput disable $(xinput list | grep "TM3276-022" | awk '{print $5}' | tail -c2) &

# turn off beep
xset b off &

# setbg
#hsetroot -solid "#303030" &
#hsetroot -center /home/m/Pictures/Wallpaper.png &
#sxhkd -c ~/.config/2bwm/2bwmrc &
#exec 2bwm


session=${1:-dk}
case $session in
    2bwm)
        #exec dbus-run-session -- 2bwm;;
        #hsetroot -solid "#303030" &
        hsetroot -solid "#636161" &
        exec 2bwm;;
    openbox)
        exec openbox-session;;
    bspwm)
        hsetroot -cover Pictures/oMuGsZb.jpg &
        sxhkd &
	picom -b 2> /dev/null &
	dunst &
	flashfocus 2> /dev/null &
	exec bspwm;;
     dk)
        #hsetroot -cover Pictures/oMuGsZb.jpg &
	hsetroot -solid "#636161" &
        picom -b 2> /dev/null &
        dunst &
        noisetorch -i 2> /dev/null &
        flashfocus 2> /dev/null &
#        sxhkd -c ~/.config/dk/sxhkdrc &
        exec dk;; 
# No known session, try to run it as command
    *   )
        exec $1;;
esac
