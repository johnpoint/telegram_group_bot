#!/usr/bin/python
# coding:utf-8

import telebot

import config

TOKEN = config.TOKEN
bot = telebot.TeleBot(TOKEN)

bot.polling()