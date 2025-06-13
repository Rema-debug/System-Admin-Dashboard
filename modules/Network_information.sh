#!/bin/bash

clear

pipe_network() {
    nmcli device show >./pipe/nmcli_device.txt
    nmcli connection show >./pipe/nmcli_connection.txt
    dig >./pipe/dig.txt
    ip stats >./pipe/ip_stats.txt
    ip route >./pipe/ip_route.txt
    ip link >./pipe/ip_link.txt
    ip address >./pipe/ip.txt
}
render_network() {
    nmcli_device_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/nmcli_device.txt)
    nmcli_connection=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/nmcli_connection.txt)

    dig_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/dig.txt)
    ip_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/ip.txt)
    ip_stats_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/ip_stats.txt)
    ip_route_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/ip.txt)
    ip_link_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/ip.txt)
    ip_address_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 <./pipe/ip.txt)

    right_pane=$(gum join --vertical "$nmcli_device_window" "$ip_stats_window" "$nmcli_connection")

    left_pane=$(gum join --vertical "$ip_window" "$ip_link_window" "$ip_route_window" "$ip_address_window" "$dig_window")

    gum join --horizontal "$right_pane" "$left_pane"
}
pipe_network
render_network

# TODO: Show DNS NEYWORK-TRAFFIC and some other things
