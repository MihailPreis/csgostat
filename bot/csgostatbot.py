import sqlite3
import logging
import os

from functools import partial
from dotenv import load_dotenv
from telegram import Update
from telegram.ext import Updater, CommandHandler, CallbackContext

load_dotenv()
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

GROUP_ID = os.getenv('GROUP_ID')
BOT_TOKEN = os.getenv('BOT_TOKEN')
if not BOT_TOKEN:
    raise Exception('Missing BOT_TOKEN env.')
SQ3_PATH = os.getenv('SQ3_DB_PATH')
if not SQ3_PATH:
    raise Exception('Missing SQ3_DB_PATH env.')
if not os.path.exists(SQ3_PATH):
    raise Exception('Database path is invalid.')
DB = f'file:{SQ3_PATH}?mode=ro'
connect = partial(sqlite3.connect, DB, uri=True)


def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text('Hi! Fuck off.')


def topmaps(update: Update, context: CallbackContext) -> None:
    if GROUP_ID and update.message.chat.id != int(GROUP_ID):
        update.message.reply_text('lol, fucking error')
        return
    try:
        with connect() as con:
            cur = con.cursor()
            _data = '\n'.join(
                [f" - {x[0]} x{x[1]}" for x in cur.execute('SELECT * FROM topmaps ORDER BY counter')][:5])
            update.message.reply_text(f"Top maps:\n{_data}")
    except Exception as e:
        logger.error(e)
        update.message.reply_text('lol, fucking error')


updater = Updater(BOT_TOKEN)
dispatcher = updater.dispatcher
dispatcher.add_handler(CommandHandler("start", start))
dispatcher.add_handler(CommandHandler("help", start))
dispatcher.add_handler(CommandHandler("topmaps", topmaps))
updater.start_polling()
updater.idle()
