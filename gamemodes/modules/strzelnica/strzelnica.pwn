//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  strzelnica                                                  //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: renosk
// Data utworzenia: 02.05.2023

stock st_initPlaces()
{
    for(new i = 0; i < sizeof(st_spawn); i++)
    {
        stData[i][st_areaid] = CreateDynamicSphere(st_spawn[i][0], st_spawn[i][1], st_spawn[i][2], 0.8);
        CreateDynamic3DTextLabel(sprintf("Stanowisko %d", i+1), COLOR_WHITE, st_spawn[i][0], st_spawn[i][1], st_spawn[i][2], 1.8);
        stData[i][st_posx] = st_spawn[i][0];
        stData[i][st_posy] = st_spawn[i][1];
        stData[i][st_posz] = st_spawn[i][2];
        stData[i][st_posa] = st_spawn[i][3];
        stData[i][st_occupiedby] = INVALID_PLAYER_ID;
        Streamer_SetIntData(STREAMER_TYPE_AREA, stData[i][st_areaid], E_STREAMER_EXTRA_ID, ST_CHECKSUM+i); //do sprawdzania czy strefa jest podpisana pod strzelnice
    }
}

stock st_getPlayerWeaponSkill(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    new skillid = st_getSkillIDByWeapon(weaponid);
    if(skillid == -1 || skillid > 5) //MAX VALUE FOR PWEAPONSKILL 
    {
        return 0;
    }
    new skill = PlayerInfo[playerid][pWeaponSkill][skillid];
    if(skill >= 0 && skill <= 9)
        return 1;
    if(skill >= 10 && skill <= 19)
        return 2;
    else if(skill >= 20 && skill <= 29)
        return 3;
    else if(skill >= 30 && skill <= 39)
        return 4;
    else
        return 5;
}

stock Float:st_getWeaponMultiplier(playerid, weaponid)
{
    new Float:multiplier = 1.0;
    switch(st_getPlayerWeaponSkill(playerid, weaponid))
    {
        case 2: multiplier = 1.1;
        case 3: multiplier = 1.2;
        case 4: multiplier = 1.3;
        case 5: multiplier = 1.4;
    }
    return multiplier;
}

stock st_addSkillToWeapon(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    new skillid = st_getSkillIDByWeapon(weaponid);
    if(skillid == -1 || skillid > 5) //MAX VALUE FOR PWEAPONSKILL 
    {
        return 0;
    }
    PlayerInfo[playerid][pWeaponSkill][skillid]++;
    switch(PlayerInfo[playerid][pWeaponSkill][skillid])
    {
        case 10, 20, 30, 40:
        {
            new gunname[32];
            GetWeaponName(weaponid, gunname, sizeof(gunname));
            SendClientMessage(playerid, COLOR_BLUE, "** Pamiêtaj, ¿e mo¿esz sprawdziæ swoje umiejêtnoœci za pomoc¹ komendy /wskill");
            return va_SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci u¿ywania broni %s wzros³y na %d level. Twój DMG z tej broni wzrós³ do %.0f!", gunname, st_getPlayerWeaponSkill(playerid, weaponid), GetWeaponDamage(weaponid)*st_getWeaponMultiplier(playerid, weaponid));
        }
    }
    return 1;
}

stock st_stop(playerid, reason[] = "Koniec czasu.")
{
    SetPlayerPos(playerid, stPlayer[playerid][stp_lastpos][0], stPlayer[playerid][stp_lastpos][1], stPlayer[playerid][stp_lastpos][2]);
    SetPlayerFacingAngle(playerid, stPlayer[playerid][stp_lastpos][3]);
    SetPlayerInterior(playerid, stPlayer[playerid][stp_lastint]);
    SetPlayerVirtualWorld(playerid, stPlayer[playerid][stp_lastvw]);
    Wchodzenie(playerid);
    _MruGracz(playerid, sprintf("Wychodzisz ze strzelnicy. %s", reason));
    SetPlayerDrunkLevel(playerid, 2000);

    new id = stPlayer[playerid][stp_place];
    if(id == -1 || id > MAX_ST)
        return 0;
    stData[id][st_occupiedby] = INVALID_PLAYER_ID;
    stPlayer[playerid][stp_place] = -1;

    //Staty
    new string[348], gunname[32], misses, accurate, points;
    misses = stPlayer[playerid][stp_misses];
    accurate = stPlayer[playerid][stp_accurate];
    points = stPlayer[playerid][stp_points];
    GetWeaponName(GetPVarInt(playerid, "bypassac-forweapon"), gunname, sizeof(gunname));
    format(string, sizeof(string), "{FFFFFF}Broñ: {BA7229}%s\n{FFFFFF}Celne strza³y: {BA7229}%d\n{FFFFFF}Niecelne strza³y: {BA7229}%d\n{FFFFFF}Punkty: {BA7229}%d", gunname, accurate, misses, points);
    ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX, "Strzelnica - Statystyki", string, "OK", #);

    //
    SetPVarInt(playerid, "cantdmg", 0);
    SetPVarInt(playerid, "bypassac-forweapon", 0);
    ResetPlayerWeapons(playerid);
    PrzywrocBron(playerid);
    st_destroyObjects(playerid);
    PlayerTextDrawHide(playerid, strzelnica_textdraw[playerid]);
    st_resetPlayerVariable(playerid);
    return 1;
}

stock st_start(playerid, weapon)
{
    new id = st_getFreePlace();
    if(id == -1 || id > MAX_ST)
    {
        return _MruGracz(playerid, "Brak wolnego miejsca na strzelnicy, wróæ ponownie póŸniej!");
    }
    GetPlayerPos(playerid, stPlayer[playerid][stp_lastpos][0], stPlayer[playerid][stp_lastpos][1], stPlayer[playerid][stp_lastpos][2]);
    stPlayer[playerid][stp_lastvw] = GetPlayerVirtualWorld(playerid);
    stPlayer[playerid][stp_lastint] = GetPlayerInterior(playerid);
    stPlayer[playerid][stp_lefttime] = ST_DEFAULTTIME+5;
    stPlayer[playerid][stp_lastshot] = gettime();
    SetPlayerPos(playerid, stData[id][st_posx], stData[id][st_posy], stData[id][st_posz]);
    SetPlayerInterior(playerid, ST_INT);
    SetPlayerVirtualWorld(playerid, ST_VW);
    Wchodzenie(playerid);
    GameTextForPlayer(playerid, "Witamy na strzelnicy!", 2500, 3);
    stData[id][st_occupiedby] = playerid;
    stPlayer[playerid][stp_place] = id;
    SetCbugAllowed(false, playerid);
    PlayerTextDrawShow(playerid, strzelnica_textdraw[playerid]);

    //Objects
    stPlayer[playerid][stp_phase] = 1;
    st_createObjects(playerid, 1, id);
    st_giveWeapon(playerid, weapon);
    return 1;
}

stock st_giveWeapon(playerid, weaponid)
{
    SetPVarInt(playerid, "mozeUsunacBronie", 1);
    ResetPlayerWeapons(playerid);
    SetPVarInt(playerid, "cantdmg", 1);
    SetPVarInt(playerid, "bypassac-forweapon", weaponid);
    GivePlayerWeapon(playerid, weaponid, 1000);
    return 1;
}

stock st_destroyObjects(playerid)
{
    for(new i = 0; i < TARGET_COUNT; i++)
    {
        if(IsValidDynamicObject(stPlayer[playerid][stp_targets][i]))
            DestroyDynamicObject(stPlayer[playerid][stp_targets][i]);
        stPlayer[playerid][stp_targets][i] = INVALID_OBJECT_ID;
    }
    return 1;
}

stock st_createObjects(playerid, phase, id)
{
    if(id == -1 || id > MAX_ST)
        return 0;
    switch(phase)
    {
        case 1:
        {
            for(new i = 0; i < TARGET_COUNT; i++)
            {
                new rnd = random(sizeof(st_targets));
                new Float:x = st_targets[rnd][0], Float:y = st_targets[rnd][1], Float:z = st_targets[rnd][2];
                stPlayer[playerid][stp_targets][i] = CreateDynamicObject(2051, x, y, z, 0.0, 0.0, 90, -1, -1, playerid);
                Streamer_SetIntData(STREAMER_TYPE_OBJECT, stPlayer[playerid][stp_targets][i], E_STREAMER_EXTRA_ID, ST_CHECKSUM+id);
            }
        }
    }
    return 1;
}

stock st_getFreePlace()
{
    for(new i = 0; i < MAX_ST; i++)
    {
        if(stData[i][st_occupiedby] == INVALID_PLAYER_ID || !IsPlayerConnected(stData[i][st_occupiedby]))
            return i;
    }
    return -1;
}

stock st_resetPlayerVariable(playerid)
{
    for(new i = 0; _stPlayer:i != _stPlayer; i++)
    {
        stPlayer[playerid][_stPlayer:i] = 0;
    }
    stPlayer[playerid][stp_place] = -1;
    for(new i = 0; i < TARGET_COUNT; i++)
    {
        stPlayer[playerid][stp_targets][i] = INVALID_OBJECT_ID;
    }
    SetPVarInt(playerid, "cantdmg", 0);
    SetPVarInt(playerid, "stafkinfo", 0);
    SetPVarInt(playerid, "st-seller", INVALID_PLAYER_ID);
    return 1;
}

stock st_createplayerTextDraw(playerid)
{
    strzelnica_textdraw[playerid] = CreatePlayerTextDraw(playerid, 586.000000, 303.000000, "Bron: ~y~Desert Eagle~n~~w~Punkty: ~y~0~n~~w~Spedzony czas:~y~0m~n~~w~Zostalo: ~y~0m~n~~w~Typ: ~y~strzelanie do nieruchomych celow");
    PlayerTextDrawFont(playerid, strzelnica_textdraw[playerid], 1);
    PlayerTextDrawLetterSize(playerid, strzelnica_textdraw[playerid], 0.266665, 1.200000);
    PlayerTextDrawTextSize(playerid, strzelnica_textdraw[playerid], 722.000000, 88.000000);
    PlayerTextDrawSetOutline(playerid, strzelnica_textdraw[playerid], 1);
    PlayerTextDrawSetShadow(playerid, strzelnica_textdraw[playerid], 0);
    PlayerTextDrawAlignment(playerid, strzelnica_textdraw[playerid], 2);
    PlayerTextDrawColor(playerid, strzelnica_textdraw[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, strzelnica_textdraw[playerid], 255);
    PlayerTextDrawBoxColor(playerid, strzelnica_textdraw[playerid], -741092558);
    PlayerTextDrawUseBox(playerid, strzelnica_textdraw[playerid], 1);
    PlayerTextDrawSetProportional(playerid, strzelnica_textdraw[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, strzelnica_textdraw[playerid], 0);
    return 1;
}

stock st_destroyplayerTextDraw(playerid)
{
    PlayerTextDrawDestroy(playerid, strzelnica_textdraw[playerid]);
    return 1;
}

stock st_getSkillIDByWeapon(weaponid)
{
    switch(weaponid)
    {
        case WEAPON_DEAGLE: return 0;
        case WEAPON_COLT45: return 1;
        case WEAPON_SILENCED: return 2;
        case WEAPON_SHOTGUN: return 3;
        case WEAPON_M4: return 4;
        case WEAPON_AK47: return 5;
    }
    return -1;
}

stock st_getWeaponIDBySkill(skillid)
{
    switch(skillid)
    {
        case 0: return WEAPON_DEAGLE;
        case 1: return WEAPON_COLT45;
        case 2: return WEAPON_SILENCED;
        case 3: return WEAPON_SHOTGUN;
        case 4: return WEAPON_M4;
        case 5: return WEAPON_AK47;
    }
    return -1;
}