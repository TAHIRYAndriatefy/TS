#!/bin/bash

CONFIG_FILE="$HOME/.ts_config"

# === Logo TS en ASCII ===
clear
echo -e "\e[1;36m"
cat << "EOF"
╔════════════════════════════════╗
╚════════════════════════════════╝
████████╗  ███████╗
╚══██╔══╝  ██╔════╝
   ██║     ███████╗
   ██║          ██║
   ██║     ███████║
   ╚═╝     ╚══════╝
╔════════════════════════════════╗
TAHIRY TS - Termux Tools
"Ity dia outil iray azonao instalé amin'ny termux"
╚════════════════════════════════╝
EOF
echo -e "\e[0m"

# === Infos contact ===
echo -e "\e[1;34m[ Contact développeur ]\e[0m"
echo -e "[1] Facebook 1 : \e[4;34mhttps://www.facebook.com/profile.php?id=61553579523412\e[0m"
echo -e "[2] Facebook 2 : \e[4;34mhttps://www.facebook.com/profile.php?id=61553657020034\e[0m"
echo -e "[3] Email      : \e[4;34mtahiryandriatefy52@gmail.com\e[0m"

# === Authentification ===
read -p "Entrez la clé d'accès : " key
if [[ "$key" != "ts2024" ]]; then
    echo "Clé invalide."
    exit 1
fi

# === Charger la configuration Telegram si elle existe ===
if [[ -f $CONFIG_FILE ]]; then
    source "$CONFIG_FILE"
fi

# === Sauvegarde configuration Telegram ===
configurer_telegram() {
    echo -e "\nConfiguration du compte Telegram :"
    read -p "Entrer votre bot token Telegram : " TELEGRAM_TOKEN
    read -p "Entrer votre chat ID Telegram : " TELEGRAM_ID

    echo "TELEGRAM_TOKEN=\"$TELEGRAM_TOKEN\"" > "$CONFIG_FILE"
    echo "TELEGRAM_ID=\"$TELEGRAM_ID\"" >> "$CONFIG_FILE"
    echo -e "\n[✓] Configuration sauvegardée avec succès !"
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
    echo "║ 5. Connecter à Telegram (Bot)  ║"
    echo "║ 0. Quitter                     ║"
    echo "╚════════════════════════════════╝"
    echo -e "\e[0m"
    read -p "Choix : " choix

    case $choix in
        1)
            read -p "Entrez votre commande SMM (ex: Achat, Liker, etc.) : " cmd
            echo "$(date): $cmd" >> ts_history.log
            echo "Commande envoyée: $cmd"
            if [[ -n "$TELEGRAM_TOKEN" && -n "$TELEGRAM_ID" ]]; then
                curl -s -X POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage                      -d chat_id=$TELEGRAM_ID                      -d text="Commande SMM Kingdom : $cmd" > /dev/null
            else
                echo "Vous n'êtes pas encore connecté à Telegram. Option 5."
            fi
            ;;
        2)
            [ -f ts_history.log ] && cat ts_history.log || echo "Aucun historique"
            ;;
        3)
            echo "Mise à jour rapide..."
            git pull && chmod +x TS.sh
            ;;
        4)
            mettre_a_jour
            ;;
        5)
            configurer_telegram
            ;;
        0)
            echo "Fermeture du script..."
            exit 0
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
done
