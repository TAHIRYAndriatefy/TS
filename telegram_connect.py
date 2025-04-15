from telethon.sync import TelegramClient
import os

api_id = int(input("Entrez votre API_ID Telegram : "))
api_hash = input("Entrez votre API_HASH Telegram : ")
phone = input("Entrez votre numéro de téléphone Telegram (ex: +261xxxxxxxxx) : ")

with TelegramClient('anon', api_id, api_hash) as client:
    client.send_message('me', 'Connexion réussie à TS sur Termux !')
    print("Connexion réussie ! Session sauvegardée.")
