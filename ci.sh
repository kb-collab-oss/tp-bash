#!/bin/bash
# Arrête le script en cas d'erreur ou de variable non définie
set -Eeuo pipefail

# Récupération du premier argument (URL du dépôt)
URL_DEPOT="${1:-}"
FICHIER_LOG="pipeline.log"

# Définition de la fonction de journalisation horodatée
journaliser() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$FICHIER_LOG"
}

# Test si la variable est vide
if [ -z "$URL_DEPOT" ]; then
    journaliser "ERREUR : Aucune URL de dépôt fournie en argument."
    exit 1
fi

journaliser "Démarrage du pipeline CI/CD..."

# Récupère le nom du dossier à partir de l'URL (ex: "tp-bash")
DOSSIER=$(basename "$URL_DEPOT" .git)

# Vérifie si le dossier existe déjà (clone vs pull)
if [ -d "$DOSSIER" ]; then
    journaliser "Le dépôt existe déjà. Exécution de git pull..."
    cd "$DOSSIER"
    git pull 2>&1 | tee -a "../$FICHIER_LOG"
    cd ..
else
    journaliser "Clonage du dépôt $URL_DEPOT..."
    git clone "$URL_DEPOT" 2>&1 | tee -a "$FICHIER_LOG"
fi

# Simulation de l'exécution des tests
journaliser "Exécution des tests automatisés..."
echo "✅ Test unitaire 1 : Connexion BDD... OK" | tee -a "$FICHIER_LOG"
echo "✅ Test unitaire 2 : Calcul moyenne... OK" | tee -a "$FICHIER_LOG"

journaliser "SUCCÈS : Le pipeline s'est terminé sans erreur."
exit 0