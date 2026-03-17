#!/bin/bash

# Écoute les events Hyprland en continu
handle() {
    case $1 in

        # Moniteur débranché ou laptop fermé
        monitorremoved*)
            MONITOR="${1#monitorremoved>>}"

            if [[ "$MONITOR" == "eDP-1" ]]; then
                # Laptop fermé/désactivé → migrer tous ses workspaces vers HDMI-A-1
                for ws in 2 4 6 8 10; do
                    hyprctl dispatch moveworkspacetomonitor "$ws HDMI-A-1" 2>/dev/null
                done
            fi
        ;;

        # Moniteur rebranché
        monitoradded*)
            MONITOR="${1#monitoradded>>}"

            if [[ "$MONITOR" == "eDP-1" ]]; then
                # Laptop rouvert → remettre les workspaces pairs sur eDP-1
                for ws in 2 4 6 8 10; do
                    hyprctl dispatch moveworkspacetomonitor "$ws eDP-1" 2>/dev/null
                done
            fi

            if [[ "$MONITOR" == "HDMI-A-1" ]]; then
                # Moniteur externe rebranché → remettre les workspaces impairs
                for ws in 1 3 5 7 9; do
                    hyprctl dispatch moveworkspacetomonitor "$ws HDMI-A-1" 2>/dev/null
                done
            fi
        ;;

    esac
}

# Boucle sur le socket d'events Hyprland
socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    handle "$line"
done
