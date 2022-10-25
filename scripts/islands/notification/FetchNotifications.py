import codecs
import sqlite3
import sys
import uuid
import time
import subprocess
import biplist
import os

from os.path import expanduser
from biplist import *

lastNotifCount = 0

def RemoveTabsNewLines(str):
    try:
        return str.replace("\t", " ").replace("\r", " ").replace("\n", "")
    except:
        pass
    return str

def GetText(string_or_binary):
    '''Converts binary or text string into text string. UUID in Sierra is now binary blob instead of hex text.'''
    uuid_text = ''
    if uuid_text:
        try:
            if type(string_or_binary) == bytes:
                uuid_text = str(uuid.UUID(bytes=string_or_binary)).upper()
            else:
                uuid_text = string_or_binary.upper()
        except Exception as ex:
            print('Error trying to convert binary value to hex text. Details: ' + str(ex))
    return uuid_text

def ReadNotifications(conn):
    try:
        conn.row_factory = sqlite3.Row
        cursor = conn.execute("SELECT Count(*) FROM record")
        curNotifCount = cursor.fetchone()[0]

        global lastNotifCount
        if curNotifCount > lastNotifCount:
            getDetails = conn.execute("SELECT (SELECT identifier from app where app.app_id=record.app_id) as app, "\
                                    "uuid, data, presented, delivered_date FROM record ORDER BY delivered_date DESC LIMIT 1")
            for row in getDetails:
                appId = row['app']
                plist = readPlistFromString(row['data'])
                req = plist['req']
                title = RemoveTabsNewLines(req.get('titl', ''))
                subtitle = RemoveTabsNewLines(req.get('subt', ''))
                message = RemoveTabsNewLines(req.get('body', ''))

                # "sketchybar --trigger dynamic_island_queue INFO=\"notification\" ISLAND_ARGS={}|{}|{}|{}"
                lastNotifCount = curNotifCount;
    except Exception as ex:
        print ("Sqlite error - \nError details: \n" + str(ex))

inputPath = sys.argv[1]
while True:
    conn = sqlite3.connect(inputPath)
    ReadNotifications(conn)
    conn.close()
    time.sleep(5)
