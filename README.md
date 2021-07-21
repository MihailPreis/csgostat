# CSGO Stat


![Downloads](https://img.shields.io/github/downloads/MihailPreis/csgostat/total?style=flat-square) ![Last commit](https://img.shields.io/github/last-commit/MihailPreis/csgostat?style=flat-square) ![Open issues](https://img.shields.io/github/issues/MihailPreis/csgostat?style=flat-square) ![Closed issues](https://img.shields.io/github/issues-closed/MihailPreis/csgostat?style=flat-square) ![Size](https://img.shields.io/github/repo-size/MihailPreis/csgostat?style=flat-square) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/MihailPreis/csgostat/Compile%20with%20SourceMod?style=flat-square)

## Description ##
Custom shitty shit CSGO stat tracking system for addict buddies


## Requirements ##
- Sourcemod and Metamod


## Installation ##
1. Grab the latest release from the release page and unzip it in your sourcemod folder.
2. Restart the server or type `sm plugins load csgostat` in the console to load the plugin.
3. The config file will be automatically generated in cfg/sourcemod/

## Configuration ##
- You can modify the phrases in addons/sourcemod/translations/csgostat.phrases.txt.
- Once the plugin has been loaded, you can modify the cvars in cfg/sourcemod/csgostat.cfg.


## Usage with Telegram Bot ##
Really, we has a telegram fucking bot.

### Deploy bot
```
$ cd bot
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
$ echo "BOT_TOKEN=<token>\nSQ3_DB_PATH=<path to sqlite db>" > .env
$ python csgostatbot.py
```

### Bot as Linux service
Edit `csgostatbot.service` and run next in terminal:
```
$ sudo cp csgostatbot.service /etc/systemd/system/csgostatbot.service
$ sudo systemctl enable csgostatbot
$ sudo systemctl start csgostatbot
```

### Usage bot
1. Create bot in [BotFather](https://t.me/BotFather).
2. Go to "Deploy bot" and finish him.
3. Say to bot `/start`.
4. Oh, well. Also say to bot `/topmaps` and fuck off.
