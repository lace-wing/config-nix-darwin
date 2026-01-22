#!/bin/bash

#SOURCE: https://github.com/nicolas-martin/awesome-sketchybar/blob/master/plugins/Comprehensive-Network-Status-Icon.md

. "$CONFIG_DIR/icons.sh"
. "$CONFIG_DIR/colors.sh"

# When switching between devices, it's possible to get hit with multiple
# concurrent events, some of which may occur before `scutil` picks up the
# changes, resulting in race conditions.
sleep 0.5

services=$(networksetup -listnetworkserviceorder)
devices=($(scutil --nwi | sed -n "s/.*Network interfaces: \([^,]*\).*/\1/p"))

color=$WHITE

id=0

if [[ "$devices" =~ ^utun.* ]]; then
  id=1
fi

test -n "$devices" && service=$(echo "$services" |
  sed -n "s/.*Hardware Port: \([^,]*\), Device: ${devices[id]}.*/\1/p")

case $service in
"iPhone USB") icon=$NET_USB ;;
"Thunderbolt Bridge") icon=$NET_THUNDERBOLT ;;

Wi-Fi)
  ssid=$(ipconfig getsummary "${devices[id]}" |
    sed -n "s/SSID : \(.*\)/\1/p")
  case $ssid in
  *iPhone*) icon=$NET_HOTSPOT ;;
  "")
    icon=$NET_DISCONNECTED
    color=$GREY
    ;;
  *) icon=$NET_WIFI ;;
  esac
  ;;
*)
  wifi_device=$(echo "$services" |
    sed -n "s/.*Hardware Port: Wi-Fi, Device: \([^\)]*\).*/\1/p")
  test -n "$wifi_device" && status=$(
    networksetup -getairportpower "$wifi_device" | awk '{print $NF}'
  )
  icon=$(test "$status" = On && echo "$NET_DISCONNECTED" || echo "$NET_OFF")
  color=$GREY
  ;;
esac

if [ $id = 1 ]; then
  icon+=$NET_GLOB
fi

sketchybar --set "$NAME" icon="$icon" icon.color="$color"
