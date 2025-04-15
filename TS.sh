#!/bin/bash

CONFIG_FILE="$HOME/.ts_config"

# === Fonction d'affichage lettre par lettre ===
afficher_lettre_par_lettre() {
  texte="$1"
  for ((i=0; i<${#texte}; i++)); do
    echo -n "${texte:$i:1}"
    sleep 0.03
  done
  echo ""
}

# === Logo animé ligne par ligne ===
clear
echo -e "\e[1;36m"
logo=(
"           ╔════════════════════════════════╗"
"           ╚════════════════════════════════╝"
"                  ████████╗  ███████╗"
"                  ╚══██╔══╝  ██╔════╝"
"                     ██║     ███████╗"
"                     ██║         ██║"
"                     ██║     ███████║"
"                     ╚═╝     ╚══════╝"
"           ╔════════════════════════════════╗"
"           TAHIRY TS - Termux Tools"
"         Ity dia outil azonao ampiasaina amin'ny termux"
"           ╚════════════════════════════════╝"
)
for ligne in "${logo[@]}"; do
  echo "$ligne"
  sleep 0.1
done
echo -e "\e[0m"

# === Contacts développeur (automatique ou via menu) ===
afficher_contacts() {
  echo -e "\e[1;33m"
  echo "╔════════════════════════════════╗"
  echo "║       CONTACT DÉVELOPPEUR      ║"
  echo "╠════════════════════════════════╣"
  echo "║ [1] Facebook 1                 ║"
  echo "║ [2] Facebook 2                 ║"
  echo "║ [3] Email                      ║"
  echo "║ [0] Retour                     ║"
  echo "╚════════════════════════════════╝"
  echo -e "\e[0m"
  read -p "Choisissez une option de contact : " contact

  case $contact in
    1) am start -a android.intent.action.VIEW -d "https://www.facebook.com/profile.php?id=61553579523412" > /dev/null 2>&1 ;;
    2) am start -a android.intent.action.VIEW -d "https://www.facebook.com/profile.php?id=61553657020034" > /dev/null 2>&1 ;;
    3) am start -a android.intent.action.SENDTO -d "mailto:tahiryandriatefy52@gmail.com" > /dev/null 2>&1 ;;
    0) return ;;
    *) echo "Choix invalide." ;;
  esac
}

# === Accès direct dès le lancement ===
afficher_contacts

# === Authentification par clé ===
read -p "Connexion - Entrez la clé d'accès : " key
if [[ "$key" != "ts2024" ]]; then
  echo "Clé invalide."
  exit 1
fi

# === Charger config Telegram si dispo ===
[[ -f $CONFIG_FILE ]] && source "$CONFIG_FILE"

# === Fonction de config Telegram ===
configurer_telegram() {
  echo -e "\nConfiguration du compte Telegram :"
  read -p "Bot token Telegram : " TELEGRAM_TOKEN
  read -p "Chat ID Telegram : " TELEGRAM_ID

  echo "TELEGRAM_TOKEN=\"$TELEGRAM_TOKEN\"" > "$CONFIG_FILE"
  echo "TELEGRAM_ID=\"$TELEGRAM_ID\"" >> "$CONFIG_FILE"
  echo -e "\n[✓] Configuration sauvegardée !"
}

# === Mise à jour complète ===
mettre_a_jour() {
  echo -e "\n\033[1;34m[~] Mise à jour du script TS...\033[0m"
  cd ~/TS || { echo "Dossier TS introuvable !"; return; }
  git pull && chmod +x TS.sh && cp TS.sh $PREFIX/bin/ts
  echo -e "\n\033[1;32m[✓] Mise à jour terminée avec succès !\033[0m"
  sleep 2
}

# === MENU PRINCIPAL ===
while true; do
  echo -e "\e[1;32m"
  echo "╔════════════════════════════════╗"
  echo "║         MENU PRINCIPAL         ║"
  echo "╠════════════════════════════════╣"
  echo "║ 1. Envoyer une commande SMM    ║"
  echo "║ 2. Voir l'historique           ║"
  echo "║ 3. Mise à jour rapide          ║"
  echo "║ 4. Mise à jour complète        ║"
  echo "║ 5. Connecter à Telegram        ║"
  echo "║ 6. Infos Développeur           ║"
  echo "║ 0. Quitter                     ║"
  echo "╚════════════════════════════════╝"
  echo -e "\e[0m"
  read -p "Choix : " choix

  case $choix in
    1)
      read -p "Entrez votre commande SMM : " cmd
      echo "$(date): $cmd" >> ts_history.log
      echo "Commande envoyée: $cmd"
      if [[ -n "$TELEGRAM_TOKEN" && -n "$TELEGRAM_ID" ]]; then
        curl -s -X POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage \
          -d chat_id=$TELEGRAM_ID \
          -d text="Commande SMM Kingdom : $cmd" > /dev/null
      else
        echo "Pas encore connecté à Telegram."
      fi
      ;;
    2) [ -f ts_history.log ] && cat ts_history.log || echo "Aucun historique." ;;
    3) echo "Mise à jour rapide..."; git pull && chmod +x TS.sh ;;
    4) mettre_a_jour ;;
    5) configurer_telegram ;;
    6) afficher_contacts ;;
    0) echo "Fermeture..."; exit 0 ;;
    *) echo "Choix invalide." ;;
  esac
done