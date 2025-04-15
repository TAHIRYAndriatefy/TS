#!/bin/bash

# === Logo TS en ASCII ===
clear
echo -e "\e[1;36m"
cat << "EOF"
████████╗  ███████╗
╚══██╔══╝  ██╔════╝
   ██║     ███████╗  
   ██║          ██║
   ██║     ███████║
   ╚═╝     ╚══════╝
      TAHIRY TS - Termux Tools

# Affichage centré du logo
while IFS= read -r line; do
  printf "%*s\n" $(((${#line} + cols) / 2)) "$line"
done <<< "$logo"

EOF
echo -e "\e[0m"

# === Authentification ===
read -p "Entrez la clé d'accès : " key
if [[ "$key" != "ts2024" ]]; then
  echo "Clé invalide."
  exit 1
fi

# === Menu stylisé avec couleurs ===
while true; do
  echo -e "\e[1;32m"
  echo "╔════════════════════════════════╗"
  echo "║         MENU PRINCIPAL         ║"
  echo "╠════════════════════════════════╣"
  echo "║ 1. Envoyer une commande SMM    ║"
  echo "║ 2. Voir l'historique           ║"
  echo "║ 3. Mettre à jour le script     ║"
  echo "║ 4. Infos développeur           ║"
  echo "║ 0. Quitter                     ║"
  echo "╚════════════════════════════════╝"
  echo -e "\e[0m"
  read -p "Choix : " choix

  case $choix in
    1)
      # === Envoi d'une commande ===
      read -p "Entrez votre commande SMM : " cmd
      echo "$(date): $cmd" >> ts_history.log
      echo "Commande envoyée: $cmd"
      # Envoi de la notification via Telegram (remplace TON_TOKEN et TON_ID)
      curl -s -X POST https://api.telegram.org/botTON_TOKEN/sendMessage \
           -d chat_id=TON_ID \
           -d text="Commande TS : $cmd" > /dev/null
      ;;
    2)
      # === Historique des commandes ===
      [ -f ts_history.log ] && cat ts_history.log || echo "Aucun historique"
      ;;
    3)
      # === Mise à jour automatique du script ===
      echo "Mise à jour en cours..."
      git pull
      chmod +x TS.sh
      echo "Mise à jour terminée."
      ;;
    4)
      # === Infos développeur ===
      echo "Développé par TAHIRY TS"
      echo "Facebook 1: https://www.facebook.com/profile.php?id=61553579523412"
      echo "Facebook 2: https://www.facebook.com/profile.php?id=61553657020034"
      echo "Email: tahiryandriatefy52@gmail.com"
      ;;
    0)
      exit 0
      ;;
    *)
      echo "Choix invalide." ;;
  esac
done
