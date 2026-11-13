# Réponses aux questions de réflexion - TP2 DevOps

## Exercice 2.1
La commande `chmod 644` octroie les droits de lecture et d'écriture au propriétaire, et uniquement de lecture au groupe et aux autres. Le fichier n'est donc pas exécutable par son propriétaire. Pour cela, il faudrait faire `chmod +x`.

## Exercice 2.2
Les guillemets autour de `"$UTILISATION"` dans le test `if` évitent une erreur de syntaxe Bash critique si la variable est vide. Sans eux, Bash lirait `if [ -ge 80 ]` et planterait. Avec eux, il lit `if [ "" -ge 80 ]` et évalue la condition proprement.

## Exercice 2.3
Si on retire `set -Eeuo pipefail` et que `tar` échoue, le script continuera à tort. Le risque est qu'il exécute l'étape suivante et supprime les anciennes sauvegardes (`rm`) alors qu'aucune nouvelle n'a pu être créée, entraînant une perte de données.

## Exercice 2.4
`cron` nécessite des chemins absolus car il s'exécute en arrière-plan dans un environnement restreint, la variable `$PATH` est très limitée, et son répertoire de travail n'est pas le projet courant tp-bash. Sans chemin absolu, il ne trouvera ni les scripts ni les dossiers.

## Exercice 2.5
**Étapes à ajouter pour un vrai pipeline CI :**
1. Installation automatique des dépendances comme `npm install`.
2. Étape de compilation/build du code.
3. Analyse statique (linting) pour vérifier la qualité.
4. Exécution des tests automatisés.

**Points de défaillance à gérer (`exit 1`) :**
- Échec de connexion réseau ou d'authentification lors du `git pull`.
- Impossible de télécharger une dépendance.
- Erreur de compilation du code.
- Échec d'un test unitaire ou d'intégration (régression détectée).
