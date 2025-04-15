from telethon.sync import TelegramClient
import sys

message = " ".join(sys.argv[1:])

with TelegramClient('anon', api_id=123456, api_hash='your_api_hash') as client:
    client.send_message('me', message)
