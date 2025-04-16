#!/bin/bash
CONFIG_FILE="$HOME/.ts_config"
SCRIPT_NAME="smm_auto.py"
SESSION_FILE=".telegram.session"

# === Fonction animation lettre par lettre ===
print_slow() {
  str="$1"
  delay="${2:-0.02}"
  for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}"
    sleep $delay
  done
  echo ""
}

#!/bin/bash
logo=(
"           ╔════════════════════════════════╗"
"           ╚════════════════════════════════╝"
"                  ████████╗  ███████╗"
"                  ╚══██╔══╝  ██╔════╝"
"                     ██║     ███████╗ "
"                     ██║          ██║"
"                     ██║     ███████║"
"                     ╚═╝     ╚══════╝"
"           ╔════════════════════════════════╗"
"               TAHIRY TS - Termux Tools"
"            Ity dia outil iray azonao instalé
                     amin'ny termux"
"           ╚════════════════════════════════╝"
)
clear
for line in "${logo[@]}"; do
  echo -e "\e[1;36m$line\e[0m"
  sleep 0.03
done

# === Menu Contact juste après horloge ===
sleep 1
echo -e "\e[1;33m"
echo        "╔════════════════════════════════╗"
echo        "║       CONTACT DÉVELOPPEUR      ║"
echo        "╠════════════════════════════════╣"
echo        "║ [1] 📱 Facebook 1              ║"
echo        "║ [2] 📱 Facebook 2    
  ║"
echo        "║ [3]  ☎️ Email                  ║"
echo        "║ [0]  ↩️ Ignorer                ║"
echo        "╚════════════════════════════════╝"
echo -e "\e[0m"
read -p "Misafidiana isa mba hidirana : " contact

case $contact in
  1) am start -a android.intent.action.VIEW -d "https://www.facebook.com/profile.php?id=61553579523412" >/dev/null 2>&1 ;;
  2) am start -a android.intent.action.VIEW -d "https://www.facebook.com/profile.php?id=61553657020034" >/dev/null 2>&1 ;;
  3) am start -a android.intent.action.SENDTO -d "mailto:tahiryandriatefy52@gmail.com" >/dev/null 2>&1 ;;
  0) echo "Ok, ndao hanohy ..." ;;
  *) echo "❌ Diso ilay safidinao.fa tsy maninona ndao hotohizana ↩️ " ;;
esac

# === Authentification ===

read -p "🔐 Apidiro ny kaody miafina ↩️:" key
if [[ "$key" != "ts2027" ]]; then
  echo "❌ Clé  diso ilay  kaody  tsindrio ny  CTRL+D "
  exit 1
fi

[[ -f $CONFIG_FILE ]] && source "$CONFIG_FILE"
configurer_telegram() {
  echo -e "\nConfiguration du compte Telegram :"
  read -p "Entrer votre bot token Telegram : " TELEGRAM_TOKEN
  read -p "Entrer votre chat ID Telegram : " TELEGRAM_ID
  echo "TELEGRAM_TOKEN=\"$TELEGRAM_TOKEN\"" > "$CONFIG2_FILE"
  echo "TELEGRAM_ID=\"$TELEGRAM_ID\"" >> "$CONFIG2_FILE"
  echo -e "\n[✓] Tafiditra soamatsara ilay momba !"
}

mettre_a_jour() {
  echo -e "\n\033[1;34m[~] Manavao ilay script TS izahay...\033[0m"
  cd ~/TS || { echo "Dossier TS introuvable !"; return; }
  git pull && chmod +x TS.sh && cp TS.sh $PREFIX/bin/ts
  echo -e "\n\033[1;32m ✅ Vita soamatsara ny fanavaozana !\033[0m"
  sleep 2
}

start_script() {
    echo -e "\033[1;36m[+] Lancement du script automatique SMM Kingdom...\033[0m"
    python $SCRIPT_NAME
}
while true; do
  echo -e "\e[1;32m"
  echo     "╔════════════════════════════════╗"
  echo     "║         MENU PRINCIPAL         ║"
  echo     "╠════════════════════════════════╣"
  echo     "║ 1. Envoyer une commande SMM    ║"
  echo     "║ 2. Voir l'historique           ║"
  echo     "║ 3. Mise à jour rapide          ║"
  echo     "║ 4. Mise à jour complète        ║"
  echo     "║ 5. Connecter à Telegram (bot)  ║"
  echo     "║ 6. Connexion Telegram personnel║"
  echo     "║ 7. Lancer le bot auto  
    ║"
  echo     "║ 0. Quitter                     ║"
  echo     "╚════════════════════════════════╝"
  echo -e "\e[0m"
  read -p "Choix : " choix

  case $choix in
    1)
      read -p "Entrez votre commande SMM : " cmd
      echo "$(date): $cmd" >> ts_history.log
      echo "Commande envoyée: $cmd"
      if [[ -n "$TELEGRAM_TOKEN" && -n "$TELEGRAM_ID" ]]; then
        curl -s -X POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage \
          -d chat_id=$TELEGRAM_ID -d text="Commande SMM Kingdom : $cmd" > /dev/null
      else
        echo "Non connecté à Telegram. Option 5."
      fi ;;
    2) [ -f ts_history.log ] && cat ts_history.log || echo "Aucun historique" ;;
    3) echo "🥰 Mahandrasa kely azafady..." && git pull && chmod +x TS.sh ;;
    4) read -p "mettre à jour : " cmd
  echo "[$(date '+%H:%M:%S')] $cmd" >> ts_history.log
    mettre_a_jour ;;
    5) configurer_telegram ;;
    6)
      echo -ne "Hiditra Telegram personnel"
      for i in {1...9}; do echo -n ".."; sleep 1.0; done
      python3 tg_login.py ;;
    7) start_script ;;
    0) echo "Veloma eee..." && exit 0 ;;
    *) echo "❌ Diso ny safidinao !." ;;
  esac
done
