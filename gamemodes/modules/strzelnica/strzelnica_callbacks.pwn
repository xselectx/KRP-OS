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
// Opis:

//

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    st_initPlaces();
    return 1;
}

hook OnPlayerLeaveDynArea(playerid, area)
{
    if(IsValidDynamicArea(area))
    {
        new extraid = Streamer_GetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_EXTRA_ID);
        if(extraid >= ST_CHECKSUM) //found
        {
            new id = extraid-ST_CHECKSUM;
            if(id < 0 || id > MAX_ST) return 1;
            if(stPlayer[playerid][stp_place] != id) return 1;
            SetPlayerPos(playerid, stData[id][st_posx], stData[id][st_posy], stData[id][st_posz]);
            ShowPlayerDialogEx(playerid, D_STLEAVE, DIALOG_STYLE_MSGBOX, "Strzelnica", "Naciœnij 'OK' aby opuœciæ strzelnice i wróciæ do poprzedniej pozycji\n{FF0000}UWAGA! TWÓJ SKILL NIE WZROŒNIE JE¯ELI WYJDZIESZ", "OK", "-");
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case D_STLEAVE:
        {
            if(!response) return 1;
            st_stop(playerid, "");
            sendErrorMessage(playerid, "Pamiêtaj, ¿e gdy wymuszasz wyjœcie ze strzelnicy twój skill nie wzroœnie.");
        }
        case D_STWEAPON:
        {
            if(!response)
            {
                SetPVarInt(playerid, "st-seller", INVALID_PLAYER_ID);
                return 1;
            }
            new price = DynamicGui_GetDataInt(playerid, listitem), weapon = DynamicGui_GetValue(playerid, listitem);
            if(price < 1 || weapon < 1) return 1;
            new seller = GetPVarInt(playerid, "st-seller");
            if(kaska[playerid] < price)
            {
                if(seller != INVALID_PLAYER_ID && IsPlayerConnected(seller))
                {
                    sendErrorMessage(seller, "Tego gracza nie staæ na to!");
                }
                return sendErrorMessage(playerid, "Nie staæ Ciê na to!");
            }
            SetPVarInt(playerid, "st-weapon", weapon);
            SetPVarInt(playerid, "st-price", price);
            new gunname[32];
            GetWeaponName(weapon, gunname, sizeof(gunname));
            ShowPlayerDialogEx(playerid, D_STPAYMENT, DIALOG_STYLE_MSGBOX, "Strzelnica - Zakup wstêpu", sprintf("{FFFFFF}Czy na pewno chcesz kupiæ wstêp na strzelnice za ${00FF00}%d{FFFFFF}?\nTwoja wybrana broñ: {FF0000}%s", price, gunname), "Tak", "Nie");
        }
        case D_STPAYMENT:
        {
            if(!response)
            {
                SetPVarInt(playerid, "st-seller", INVALID_PLAYER_ID);
                return 1;
            }
            if(GetPVarInt(playerid, "strzelnica-org") <= 0) return 1;

            new price = GetPVarInt(playerid, "st-price"), weapon = GetPVarInt(playerid, "st-weapon");
            new seller = GetPVarInt(playerid, "st-seller"), money = GetPVarInt(playerid, "st-money");
            if(kaska[playerid] < price || weapon == 0 || price == 0) return 1;
            ZabierzKaseDone(playerid, price);
            st_start(playerid, weapon);
            SetPVarInt(playerid, "st-seller", INVALID_PLAYER_ID);
            if(seller != INVALID_PLAYER_ID && IsPlayerConnected(seller))
            {
                DajKaseDone(seller, money);
                va_SendClientMessage(seller, COLOR_BLUE, "SPRZEDA¯: %s kupi³ od Ciebie wstêp na strzelnice. Otrzymujesz %d$", GetNick(playerid), money);
                Log(payLog, WARNING, "%s kupi³ od %s wstêp na strzelnice za %d$ (prowizja %d$)", GetPlayerLogName(playerid), GetPlayerLogName(seller), price, money);
                price -= money; //do sejfu
            }
            else
            {
                price /= 2;
            }
            Sejf_Add(GetPVarInt(playerid, "strzelnica-org"), price);
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(IsValidDynamicObject(stPlayer[playerid][stp_targets][0]))
    {
        for(new i = 0; i < TARGET_COUNT; i++)
        {
            new objectid = stPlayer[playerid][stp_targets][i];
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(objectid, x, y, z);
            new rnd = random(sizeof(st_targets));
            new Float:tx = st_targets[rnd][0], Float:ty = st_targets[rnd][1], Float:tz = st_targets[rnd][2];
            if(GetPlayerAmmo(playerid) == 0) return 1;
            if(GetPlayerWeapon(playerid) != GetPVarInt(playerid, "bypassac-forweapon")) return 1;
            if(IsPlayerAimingAt(playerid, x, y, z, 0.13) && PRESSED(KEY_FIRE) && gettime() > stPlayer[playerid][stp_tick])
            {
                //max punktów
                SetDynamicObjectPos(objectid, tx, ty, tz);
                stPlayer[playerid][stp_points] += 40;
                stPlayer[playerid][stp_accurate]++;
                stPlayer[playerid][stp_lastshot] = gettime();
                GameTextForPlayer(playerid, "+40", 800, 3);
                return 1;
            }
            else if(IsPlayerAimingAt(playerid, x, y, z, 0.3) && PRESSED(KEY_FIRE) && gettime() > stPlayer[playerid][stp_tick])
            {
                //20 punktów
                SetDynamicObjectPos(objectid, tx, ty, tz);
                stPlayer[playerid][stp_points] += 20;
                stPlayer[playerid][stp_accurate]++;
                stPlayer[playerid][stp_lastshot] = gettime();
                GameTextForPlayer(playerid, "+20", 800, 3);
                return 1;
            }
            else if(IsPlayerAimingAt(playerid, x, y, z, 0.4) && PRESSED(KEY_FIRE) && gettime() > stPlayer[playerid][stp_tick])
            {
                //10 punktów
                SetDynamicObjectPos(objectid, tx, ty, tz);
                stPlayer[playerid][stp_points] += 10;
                stPlayer[playerid][stp_accurate]++;
                stPlayer[playerid][stp_lastshot] = gettime();
                GameTextForPlayer(playerid, "+10", 800, 3);
                return 1;
            }
            else if(PRESSED(KEY_FIRE) && gettime() > stPlayer[playerid][stp_tick] && i == TARGET_COUNT-1)
            {
                //nic
                stPlayer[playerid][stp_tick] = gettime()+1;
                stPlayer[playerid][stp_misses]++;
                GameTextForPlayer(playerid, "+0", 800, 3);
                return 1;
            }
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    st_resetPlayerVariable(playerid);
    st_createplayerTextDraw(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    st_destroyplayerTextDraw(playerid);
    new place = stPlayer[playerid][stp_place];
    if(place == -1 || place > MAX_ST) 
        return 1;
    stData[place][st_occupiedby] = INVALID_PLAYER_ID;
    st_destroyObjects(playerid);
    return 1;
}