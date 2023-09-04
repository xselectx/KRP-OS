new g_ProtectionEnabled[MAX_PLAYERS];
new g_HasProtection[MAX_PLAYERS];

public DisableProtection(playerid);

public DisableProtection(playerid)
{
    g_ProtectionEnabled[playerid] = false;
    g_HasProtection[playerid] = true;
    SendClientMessage(playerid, COLOR_RED, "Ochrona startowa zostala wylaczona.");
    return 1;
}

hook OnPlayerDamage(&playerid, &issuerid)
{
    if(IsPlayerConnected(issuerid) && issuerid != INVALID_PLAYER_ID)
    {
        if(g_ProtectionEnabled[issuerid])
        {
            DisableProtection(issuerid);
        }
    }
    if (g_ProtectionEnabled[playerid])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Nie mo¿esz umrzeæ podczas 10-sekundowej ochrony!");
        SendClientMessage(issuerid, COLOR_YELLOW, "Twój cel jest chroniony i nie mo¿esz go zraniæ!");
        return 0;
    }
    return 1;
}
#define INVALID_TIMER_ID 0
new PlantedSmokes[10];
new g_SmokeTimers[10];

forward RemoveSmokeObject(timerid, smokeid);
public RemoveSmokeObject(timerid, smokeid)
{
    DestroyDynamicObject(PlantedSmokes[smokeid]);
    PlantedSmokes[smokeid] = 0;
    g_SmokeTimers[smokeid] = INVALID_TIMER_ID;
    return 0;
}

YCMD:usunalldym(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin]) return noAccessMessage(playerid);
    for(new smokeid = 0; smokeid < sizeof(PlantedSmokes); smokeid++)
    {
        if(!PlantedSmokes[smokeid]) continue;
        if (g_SmokeTimers[smokeid] != INVALID_TIMER_ID)
        {
            KillTimer(g_SmokeTimers[smokeid]);
            g_SmokeTimers[smokeid] = INVALID_TIMER_ID;
        }
        
        DestroyDynamicObject(PlantedSmokes[smokeid]);
        PlantedSmokes[smokeid] = 0;

        va_SendClientMessage(playerid, -1, "Usun¹³eœ zadymiarkê ID: %d", smokeid+1);
    }
    return 1;
}

YCMD:usundym(playerid, params[])
{
    new smokeid;
    if(sscanf(params, "i", smokeid))
    {
        return SendClientMessage(playerid, COLOR_WHITE, "Uzyj: /usundym <id>");
    }
    else if (smokeid < 1 || smokeid > 10) return SendClientMessage(playerid, COLOR_WHITE, "Uzyj: /usundym <1-10>");
    
    if (g_SmokeTimers[smokeid - 1] != INVALID_TIMER_ID)
    {
        KillTimer(g_SmokeTimers[smokeid - 1]);
        g_SmokeTimers[smokeid - 1] = INVALID_TIMER_ID;
    }
    
    DestroyDynamicObject(PlantedSmokes[smokeid - 1]);
    PlantedSmokes[smokeid - 1] = 0;
    
    return SendClientMessage(playerid, COLOR_WHITE, "Pomyslnie usunales urzadzenie do dymu!");
}

stock FindEmptySlot()
{
    new
        i = 0;
    while (i < sizeof (PlantedSmokes) && PlantedSmokes[i])
    {
        i++;
    }
    if (i == sizeof (PlantedSmokes)) return -1;
    return i;
}


new PlantedFlares[10];
new g_FlareTimers[10];

YCMD:usunflare(playerid, params[])
{
    new flareid;
    if(sscanf(params, "i", flareid))
    {
        return SendClientMessage(playerid, COLOR_WHITE, "Uzyj: /usunflare <id>");
    }
    else if (flareid < 1 || flareid > 10) return SendClientMessage(playerid, COLOR_WHITE, "Uzyj: /usunflare <1-10>");
    
    if (g_FlareTimers[flareid - 1] != INVALID_TIMER_ID)
    {
        KillTimer(g_FlareTimers[flareid - 1]);
        g_FlareTimers[flareid - 1] = INVALID_TIMER_ID;
    }
    
    DestroyDynamicObject(PlantedFlares[flareid - 1]);
    PlantedFlares[flareid - 1] = 0;
    
    return SendClientMessage(playerid, COLOR_WHITE, "Pomyslnie usunales flare!");
}

YCMD:usunallflara(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin]) return noAccessMessage(playerid);
    for(new flareid = 0; flareid < sizeof(PlantedFlares); flareid++)
    {
        if(!PlantedFlares[flareid]) continue;
        if (g_FlareTimers[flareid] != INVALID_TIMER_ID)
        {
            KillTimer(g_FlareTimers[flareid]);
            g_FlareTimers[flareid] = INVALID_TIMER_ID;
        }
        
        DestroyDynamicObject(PlantedFlares[flareid]);
        PlantedFlares[flareid] = 0;

        va_SendClientMessage(playerid, -1, "Usun¹³eœ flarê ID: %d", flareid+1);
    }
    return 1;
}

stock FindEmptySlot1()
{
    new i = 0;
    while (i < sizeof(PlantedFlares) && PlantedFlares[i])
    {
        i++;
    }
    if (i == sizeof(PlantedFlares)) return -1;
    return i;
}
forward RemoveFlareObject(timerid, flareid);
public RemoveFlareObject(timerid, flareid)
{
    DestroyDynamicObject(PlantedFlares[flareid]);
    PlantedFlares[flareid] = 0;
    g_FlareTimers[flareid] = INVALID_TIMER_ID;
    return 0;
}