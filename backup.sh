#!/bin/bash
set -Eeuo pipefail

SOURCE="data"
DEST="backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="$DEST/backup_$DATE.tar.gz"

if [ ! -d "$SOURCE" ]; then
    echo "Erreur : Le dossier source $SOURCE n'existe pas." >&2
    exit 1
fi

mkdir -p "$DEST"

tar -czf "$ARCHIVE" "$SOURCE"
echo "Archive créée : $ARCHIVE"

for fichier in $(find "$DEST" -name "*.tar.gz" -mtime +7); do
    echo "Suppression de $fichier"
    rm "$fichier"
done
