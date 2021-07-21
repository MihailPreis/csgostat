#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

Database g_hDatabase;

public Plugin myinfo =
  {
	name = "CSGO Stat",
	author = "M.Price",
	description = "Custom shitty shit CSGO stat tracking system for addict buddies",
	version = "1.0",
	url = "https://github.com/MihailPreis/csgostat"};


public void OnPluginStart()
{
    Database.Connect(SQL_Connection, "storage-local");

    HookEvent("nextlevel_changed", Event_NextLevelChanged);

    PrintToServer("CSGO Stat running successfull.");
}

public void SQL_Connection(Database hDatabase, const char[] sError, int iData)
{
    if(hDatabase == null)
        ThrowError(sError);
    else
    {
        g_hDatabase = hDatabase;
        g_hDatabase.Query(SQL_Error, "CREATE TABLE IF NOT EXISTS topmaps (mapname TEXT NOT NULL, counter INTEGER DEFAULT 0, lastupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UNIQUE(mapname))");
    }
}

public void Event_NextLevelChanged(Event event, const char[] name, bool dontBroadcast)
{
    static char nextlevel[PLATFORM_MAX_PATH], iQuery[PLATFORM_MAX_PATH], uQuery[PLATFORM_MAX_PATH];

    event.GetString("nextlevel", nextlevel, sizeof(nextlevel));

    Format(iQuery, sizeof(iQuery), "INSERT OR IGNORE INTO topmaps (mapname, counter) VALUES ('%s', 0)", nextlevel);
    g_hDatabase.Query(SQL_Error, iQuery);

    Format(uQuery, sizeof(uQuery), "UPDATE topmaps SET counter = counter + 1 , lastupdate = CURRENT_TIMESTAMP WHERE mapname = '%s'", nextlevel);
    g_hDatabase.Query(SQL_Error, uQuery);
}

public void SQL_Error(Database hDatabase, DBResultSet hResults, const char[] sError, int iData)
{
    if(hResults == null)
        ThrowError(sError);
}
