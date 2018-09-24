#!/bin/bash

timeout=2000

check_state() {
   synclient  | awk -F= '{ gsub(/[ \t]+/, ""); if ($1 == "TouchpadOff") print $2; }'
}

case "${1}" in
[oO][nN])
	t=0
	msg=${1^^}
	;;
[oO][fF][fF])
	t=1
	msg=${1^^}
	;;
--help)
	echo "Usage: ${0} [on|off]"
	exit 0
	;;
*)
	t=$(( ! $(check_state) ))
	(( t == 0 )) && msg='ON' || msg='OFF'
	;;
esac

synclient TouchpadOff=${t}
notify-send -t "${timeout}" 'Touchpad' "${msg^^}"
