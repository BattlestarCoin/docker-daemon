#!/bin/bash

CONFIG=/home/batl/.batl/batl.conf

declare -A target
declare -A envar

if [[ -n "${RPCUSER}" ]]; then
target[RPCUSER]=rpcuser
envar[RPCUSER]=$RPCUSER
fi

if [[ -n "${PRCPASS}" ]]; then
target[PRCPASS]=rpcpassword
envar[PRCPASS]=$PRCPASS
fi

if [[ -n "${RPCIP}" ]]; then
envar[RPCIP]=$RPCIP
target[RPCIP]=rpcallowip
fi

for i in "${!target[@]}"
do
	if [[ -n "${envar[$i]}" ]]; then
		if grep -Fq "${target[$i]}" $CONFIG
		then
			sed -i -e "s|^${target[$i]}.*|${target[$i]}=${envar[$i]}|" $CONFIG
		else
			echo "${target[$i]}=${envar[$i]}" >> $CONFIG
		fi
	fi
done

exec "$@"
