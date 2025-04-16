from telethon.sync import TelegramClient
from telethon.tl.functions.messages import GetHistoryRequest
import time
import os

# === Connexion utilisateur ===
api_id = 22121656
api_hash = '2f92474dd31878529f02526f7180d624'
phone_number = input("Numéro de téléphone Telegram (+261...): ")
bot_username = 'SmmKingdomTasksBot'
check_interval = 60

print("Connexion au bot SMM en cours", end="")
for _ in range(5):
    print(".", end="", flush=True)
    time.sleep(0.5)
print("\n")

with TelegramClient('smm_session', api_id, api_hash) as client:
    if not client.is_user_authorized():
        client.send_code_request(phone_number)
        code = input('Entrez le code Telegram: ')
        try:
            client.sign_in(phone_number, code)
        except Exception as e:
            print(f"Erreur de connexion: {e}")
            exit()

    while True:
        try:
            messages = client(GetHistoryRequest(
                peer=bot_username,
                limit=1,
                offset_date=None,
                offset_id=0,
                max_id=0,
                min_id=0,
                add_offset=0,
                hash=0
            ))
            if messages.messages:
                last_message = messages.messages[0].message
                if 'https://www.instagram.com/' in last_message:
                    print('[+] Nouvelle tâche détectée.')
                    lines = last_message.split('\n')
                    for line in lines:
                        if 'https://www.instagram.com/' in line:
                            url = line.strip()
                            print(f'Ouverture du lien : {url}')
                            os.system(f'xdg-open {url}')
                            time.sleep(15)
                            print('Envoi de /joined pour récupérer la récompense...')
                            client.send_message(bot_username, '/joined')
                            time.sleep(10)
            else:
                print('[*] Pas de nouvelle tâche...')
        except Exception as e:
            print(f'[!] Erreur : {e}')
        time.sleep(check_interval)