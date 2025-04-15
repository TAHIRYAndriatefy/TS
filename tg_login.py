from telethon.sync import TelegramClient
from telethon.errors import SessionPasswordNeededError
import os

# === Paramètres ===
api_id = 22121656  # Remplace avec ton propre api_id
api_hash = '2f92474dd31878529f02526f7180d624'  # Remplace avec ton propre api_hash
session_name = 'session'

def connect_and_send():
    client = TelegramClient(session_name, api_id, api_hash)

    with client:
        if not client.is_user_authorized():
            phone = input("Entrez votre numéro de téléphone (ex: +261XXXXXXXXX): ")
            sent = client.send_code_request(phone)

            # Afficher où le code a été envoyé
            if sent.phone_code_hash:
                print("\n[!] Un code a été envoyé.")
                if sent._phone_code_type == 'app':
                    print("-> Le code a été envoyé via l'application Telegram.")
                elif sent._phone_code_type == 'sms':
                    print("-> Le code a été envoyé par SMS.")
                else:
                    print("-> Vérifiez votre Telegram ou vos SMS.")
            
            code = input("Entrez le code reçu : ")
            try:
                client.sign_in(phone, code)
            except SessionPasswordNeededError:
                pw = input("Mot de passe en deux étapes : ")
                client.sign_in(password=pw)

        print("[✓] Connecté avec succès.")
        msg = input("Entrez la commande SMM à envoyer : ")
        receiver = input("ID de réception (ou votre propre username sans @) : ")
        client.send_message(receiver, f"Commande SMM Kingdom : {msg}")
        print("[✓] Message envoyé avec succès.")

if __name__ == "__main__":
    connect_and_send()