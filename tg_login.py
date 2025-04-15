from telethon.sync import TelegramClient
from telethon.errors import SessionPasswordNeededError

api_id = 22121656
api_hash = '2f92474dd31878529f02526f7180d624'
session_name = 'session'

def connect_and_send():
    client = TelegramClient(session_name, api_id, api_hash)

    with client:
        if not client.is_user_authorized():
            phone = input("Entrez votre numéro de téléphone (ex: +261XXXXXXXXX): ")
            client.send_code_request(phone)
            code = input("Entrez le code reçu par Telegram ou SMS : ")
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
