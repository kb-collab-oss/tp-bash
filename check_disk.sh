#!/bin/bash

SEUIL="${1:-80}"

UTILISATION=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$UTILISATION" -ge "$SEUIL" ]; then
	echo "Alerte : Espace disque à ${UTILISATION}% (Seuil: ${SEUIL})"
	exit 1
fi

echo "Disque OK : ${UTILISATION}%"
exit 0
