//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ boombox ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:boombox(playerid, params[], help)
{
    
    new sub[16], var[128];
    sscanf(params, "S()[16]S()[128]", sub, var);

    new frac;
    for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
    {
        if(PlayerInfo[playerid][pGrupa][i] != 0)
        {
            if(GroupHavePerm(PlayerInfo[playerid][pGrupa][i], PERM_GANG))
            {
                frac = PlayerInfo[playerid][pGrupa][i];
                break;
            }
        }
    }
    if(frac == 0 && !CheckPlayerPerm(playerid, PERM_GANG) && !CheckPlayerPerm(playerid, PERM_CLUB) && !CheckPlayerPerm(playerid, PERM_MAFIA)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Boombox tylko dla organizacji typu gang/klub/mafia!");
    else sendTipMessage(playerid, "Boombox tylko dla gangów.");


    if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0)
    {
        if(strcmp(sub, "szukaj", true) == 0)
        {
            new owner=-1;
            if(!isnull(var))
            owner = strval(var);
            SendClientMessage(playerid, COLOR_GREEN, "Boomboxy w pobli¿u:");
            for(new i = 0; i < MAX_BOOMBOX; i++)
            {
                if(owner != -1)
                {
                    if(!IsPlayerConnected(owner)) break;
                    if(BoomBoxData[i][BBD_Gang] != owner+1) continue;
                    va_SendClientMessage(playerid, COLOR_GREY, "ID: %d, Stworzony przez: %s", i, GetNickEx(BoomBoxData[i][BBD_Gang]-1));
                    break;
                }
                if(IsPlayerInRangeOfPoint(playerid, 3.0, BoomBoxData[i][BBD_x], BoomBoxData[i][BBD_y], BoomBoxData[i][BBD_z]))
                    va_SendClientMessage(playerid, COLOR_GREY, "ID: %d, Stworzony przez: %s", i, GetNickEx(BoomBoxData[i][BBD_Gang]-1));
            }
            return 1;
        }
        if(strcmp(sub, "usun", true) == 0)
        {
            new bbxid;
            if(sscanf(var, "d", bbxid))
                return sendTipMessage(playerid, "U¿yj: /boombox usun [id (mo¿esz sprawdziæ poprzez /boombox szukaj)]");
            if(bbxid > MAX_BOOMBOX-1 || bbxid < 0)
                return 0;
            if(BoomBoxData[bbxid][BBD_Obj] != 0) DestroyDynamicObject(BoomBoxData[bbxid][BBD_Obj]);
            BoomBoxData[bbxid][BBD_x] = 0;
            BoomBoxData[bbxid][BBD_y] = 0;
            BoomBoxData[bbxid][BBD_z] = 0;
            BoomBoxData[bbxid][BBD_Standby] = false;
            BoomBoxData[bbxid][BBD_Carried] = -1;
            BoomBoxData[bbxid][BBD_ID] = 0;
            BoomBoxData[bbxid][BBD_Gang] = 0;
            SendClientMessage(playerid, -1, "DONE.");
            return 1;
        }
    }
    new id=-1;
    for(new i=0;i<MAX_BOOMBOX;i++)
    {
        if(BoomBoxData[i][BBD_Gang] == playerid+1)
        {
            id=i;
            break;
        }
    }
    if(id != -1)
    {
        if(isnull(sub))
        {
            if(BoomBoxData[id][BBD_Carried]-1 == playerid)
            {
                BBD_Putdown(playerid, id);
            }
            else
            {
                if(!IsPlayerInRangeOfPoint(playerid, 1.4, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z])) return sendTipMessageEx(playerid, COLOR_GRAD2, "Musisz byæ obok boomboxa.");
                if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) return sendTipMessageEx(playerid, COLOR_GRAD2, "Przykucnij do radia.");
                BBD_Pickup(playerid, id);
            }
        }
        else
        {

            if(strcmp(sub, "znajdz", true) == 0 || strcmp(sub, "znajdŸ", true) == 0)
            {
                SetPlayerCheckpoint(playerid, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z], 2.0);
                SendClientMessage(playerid, -1, "Je¿eli nie mo¿esz znaleŸæ boombox'a poproœ administratora o usuniêcie go.");
                return 1;
            }

            if(!IsPlayerInRangeOfPoint(playerid, 1.4, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z])) return sendTipMessageEx(playerid, COLOR_GRAD2, "Musisz byæ obok boomboxa.");
            if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) return sendTipMessageEx(playerid, COLOR_GRAD2, "Przykucnij do radia.");
            if(strcmp(sub, "off", true) == 0)
            {
                BoomBoxData[id][BBD_Standby] = false;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s wy³¹cza boomboxa.", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
            else if(strcmp(sub, "on", true) == 0)
            {
                if(strlen(BoomBoxData[id][BBD_URL]) < 10) return 1;
                BoomBoxData[id][BBD_Standby] = true;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s w³¹cza boomboxa.", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
            else if(strcmp(sub, "url", true) == 0)
            {
                format(BoomBoxData[id][BBD_URL], 128, "%s", var);
                BoomBoxData[id][BBD_Standby] = true;
                BoomBoxData[id][BBD_Refresh] = true;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s zmienia nutê w boomboxie", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
        }
    }
    else
    {

        id = BBD_GetID();
        if(id == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Osi¹gniêto limit boomboxów (15).");
        BoomBoxData[id][BBD_ID] = playerid+1;
        BoomBoxData[id][BBD_Gang] = playerid+1;
        BBD_Pickup(playerid, id);
    }
    return 1;
}
