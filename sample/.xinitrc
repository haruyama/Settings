# ---- language-env DON'T MODIFY THIS LINE!
# 以下のシェル変数によって、動作が変わります。
# $TERMINAL_EMULATOR
# $WINDOW_MANAGER

xset b off
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

#PATH=$HOME/bin:$PATH:/usr/X11R6/bin
#=======================================================================
# 日本語入力 (XIM) の設定
# XIM サーバーの名前を定義する
# (XIM, XIM2 は、language-env だけで使うシェル変数です)
#XIM=jmode
#XIM2=--noissue
# XIM サーバーを起動する
#if type $XIM &> /dev/null
#then
#  bblaunch -s $XIM $XIM2 &
#fi
# #XMODIFIERS=@im=$XIM
uim-xim &
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim

# export XMODIFIERS=@im=ibus
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# ibus-daemon --xim &
#export GTK_IM_MODULE=scim
#export QT_IM_MODULE=scim

#XMODIFIERS=@im=uim-prime
# export XMODIFIERS

#=======================================================================
# ターミナルエミュレータ (xterm, kterm, rxvt, ...) を起動する
# .xsession の、language-env が書き込んだよりも前で $TERMINAL_EMULATOR を
# 設定すると、動作が変わります。
# $TERMINAL_EMULATOR が設定されていれば、それを起動する。
# $TERMINAL_EMULATOR が NONE なら、起動しない。
#      ウィンドウマネージャーから起動するなどの場合に指定してください。
# $TERMINAL_EMULATOR が設定されていなければ、デフォルトの動作
#      (krxvt -> kterm -> rxvt -> Eterm -> gnome-terminal -> xterm の順で検索)
#
# krxvt は、rxvt-ml パッケージに入っている日本語対応 rxvt です。
#-----------------------------------------------------------------------
#=======================================================================
# 背景
# (xlogo64 は、xlib6g-dev パッケージに入っています)
#xsetroot -bitmap /usr/X11R6/include/X11/bitmaps/xlogo64 -fg RoyalBlue -bg RoyalBlue4 &
#xsetroot -solid SkyBlue
# マウスカーソルを矢印の形にする
#xsetroot -cursor /usr/include/X11/bitmaps/left_ptr /usr/include/X11/bitmaps/left_ptrmsk
#
#=======================================================================
# セッションマネージャ、ウィンドウマネージャ、ターミナルエミュレータの
# いずれかを実行します。 最低どれかひとつは必要です。
# 実行するウィンドウマネージャを $WINDOW_MANAGER で指定可能です。
if [ -x "$WINDOW_MANAGER" ]; then
  realstartup=$WINDOW_MANAGER
elif [ -x /usr/bin/x-session-manager ]; then
  realstartup=x-session-manager
elif [ -x /usr/bin/x-window-manager ]; then
  realstartup=x-window-manager
elif [ -x /usr/bin/x-terminal-emulator ]; then
  realstartup=x-terminal-emulator
fi
xrdb -load ~/.Xresources
#wmbutton&
#xautolock &
#multi-gnome-terminal&
#wmbattery &
unclutter -not QEMU&
#exec env LANG=UTF-8 LC_ALL=UTF-8 /usr/bin/fluxbox
#gnome-session&
#aoss artsd &
#artsd -a alsa&
#wmix&
wmmixer -w &
#wmpinboard -w &
#xset -dpms 
#exec env LANG=UTF-8 LC_ALL=UTF-8 /usr/local/bin/fluxbox
#xbindkeys
#(sleep 12; xrandr --output VGA-0 --off --output S-video --off --output DVI-0 --mode 1920x1200 --pos 0x0 --rotate normal; Esetroot -scale /home/haruyama/lib/pics/WP033.jpg)&
synergys
xset m 3 150
xset dpms 0 0 0
#xset dpms 2400 2800 3600
#xautolock -time 4 -locker "xlock -nolock -mousemotion -nice 19" &
#bbpager &
#gconftool-2 --spawn
#exec env LANG=UTF-8 LC_ALL=UTF-8 ssh-agent /usr/bin/fluxbox
#Esetroot -scale /home/haruyama/lib/pics/WP033.jpg
#eval `gpg-agent --daemon`
gtodo &

#eval `dbus-launch --sh-syntax`
#/usr/lib/libgconf2-4/gconfd-2&
#/usr/lib/dconf/dconf-service&
#gnome-settings-daemon&
/usr/lib/notification-daemon/notification-daemon &
exec ssh-agent /usr/bin/fluxbox --enable-gnome
#exec /usr/bin/gnome-session
#
# exec gnome-session

# ---- language-env end DON'T MODIFY THIS LINE!
