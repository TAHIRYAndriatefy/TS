# TS - Script Professionnel pour Termux

![Logo TS](https://via.placeholder.com/400x100.png?text=TS+by+TAHIRY+TS)

## Présentation
TS est un script avancé conçu pour Termux, permettant d’exécuter des commandes SMM (Social Media Marketing) de manière rapide et sécurisée. Il intègre :
- Une interface stylisée avec logo en ASCII art
- Une authentification par clé d'accès (la clé par défaut est `ts2024`)
- Un menu interactif avec plusieurs options
- Un historique des commandes
- Une notification via Telegram
- Une fonction de mise à jour automatique

## Installation

Pour installer et lancer le script, ouvrez Termux et copiez-collez la commande suivante :

```bash
pkg update && pkg install git -y && git clone https://github.com/TAHIRYAndriatefy/TS.git && cd TS && chmod +x TS.sh && ./TS.sh