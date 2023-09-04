//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   tatuaz                                                  //
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
// Data utworzenia: 23.06.2023
//Opis:
/*
	
*/

//

//-----------------<[ Funkcje: ]>-------------------

forward Tattoo_Create(playerid, creatorid, id, index, bone, Float:fX, Float:fY, Float:fZ, Float:fRX, Float:fRY, Float:fRZ);
public Tattoo_Create(playerid, creatorid, id, index, bone, Float:fX, Float:fY, Float:fZ, Float:fRX, Float:fRY, Float:fRZ)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(GetPVarInt(playerid, "Tattoo-Offer") == INVALID_PLAYER_ID) return 0;

    new slot = GetFreeSlotTattoo(playerid);
    if(slot == -1) return 0;

    mysql_query_format("INSERT INTO `mru_tattoo` (`ID`, `offsetX`, `offsetY`, `offsetZ`, `rX`, `rY`, `rZ`, `owner`, `bone`) VALUES ('%d', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d')", id, fX, fY, fZ, fRX, fRY, fRZ, PlayerInfo[playerid][pUID], bone);
    if(mysql_insert_id() < 1) return sendErrorMessage(playerid, "Wyst¹pi³ b³¹d zapisu!");
    PlayerTattoo[playerid][slot][t_UID] = mysql_insert_id();
    PlayerTattoo[playerid][slot][t_ID] = id;
    PlayerTattoo[playerid][slot][t_offsetX] = fX;
    PlayerTattoo[playerid][slot][t_offsetY] = fY;
    PlayerTattoo[playerid][slot][t_offsetZ] = fZ;
    PlayerTattoo[playerid][slot][t_RX] = fRX;
    PlayerTattoo[playerid][slot][t_RY] = fRY;
    PlayerTattoo[playerid][slot][t_RZ] = fRZ;
    PlayerTattoo[playerid][slot][t_bone] = bone;
    PlayerTattoo[playerid][slot][t_index] = index;
    _MruGracz(playerid, "Tatua¿ wykonany!");
    _MruGracz(creatorid, "Tatua¿ wykonany!");
    Tattoo_Failure(playerid);

    SetPlayerAttachedObject(playerid, index, Tattoo_Models[id][dModel], bone, fX, fY, fZ, fRX, fRY, fRZ, Tattoo_Models[id][dScaleX], Tattoo_Models[id][dScaleY], Tattoo_Models[id][dScaleZ]);
    return 1;
}

stock Tattoo_Delete(playerid, slot)
{
    mysql_query_format("DELETE FROM `mru_tattoo` WHERE `UID` = '%d'", PlayerTattoo[playerid][slot][t_UID]);
    RemovePlayerAttachedObject(playerid, PlayerTattoo[playerid][slot][t_index]);
    PlayerTattoo[playerid][slot][t_UID] = 0;
    PlayerTattoo[playerid][slot][t_ID] = 0;
    PlayerTattoo[playerid][slot][t_offsetX] = 0;
    PlayerTattoo[playerid][slot][t_offsetY] = 0;
    PlayerTattoo[playerid][slot][t_offsetZ] = 0;
    PlayerTattoo[playerid][slot][t_RX] = 0;
    PlayerTattoo[playerid][slot][t_RY] = 0;
    PlayerTattoo[playerid][slot][t_RZ] = 0;
    PlayerTattoo[playerid][slot][t_bone] = 0;
    PlayerTattoo[playerid][slot][t_index] = 0;
    sendErrorMessage(playerid, sprintf("Usun¹³eœ tatua¿ o ID: %d", slot+1));
    return 1;
}

stock Tattoo_Failure(playerid)
{
    SetPVarInt(playerid, "Tattoo-Offer", INVALID_PLAYER_ID);
    DeletePVar(playerid, "Tattoo-Price");
    DeletePVar(playerid, "Tattoo-ObjectIndex");
    DeletePVar(playerid, "Tattoo-ModelIndex");
    DeletePVar(playerid, "Tattoo-Bone");
    DeletePVar(playerid, "Tattoo-EditingObj");
    return 1;
}

stock Tattoo_StartMaking(playerid, creatorid, id, index, bone, Float:fX, Float:fY, Float:fZ, Float:fRX, Float:fRY, Float:fRZ)
{
    new price = GetPVarInt(playerid, "Tattoo-Price");
    if(!IsPlayerConnected(creatorid)) return sendErrorMessage(playerid, "Gracz, który sk³ada³ Ci ofertê wyszed³ z gry.");
    if(!IsPlayerNear(playerid, creatorid)) return sendErrorMessage(playerid, "Nie jesteœ w pobli¿u gracza, który sk³ada³ Ci ofertê.");
    if(!GroupPlayerDutyPerm(creatorid, PERM_TATTOO)) return sendErrorMessage(playerid, "Gracz, który sk³ada³ Ci ofertê zszed³ ze s³u¿by!");
    if(kaska[playerid] < price) return sendErrorMessage(playerid, "Nie masz tylu pieniêdzy!");

    new groupid = GetPlayerGroupUID(creatorid, OnDuty[playerid]-1);
    if(!IsValidGroup(groupid)) return sendErrorMessage(playerid, "Gracz, który sk³ada³ Ci ofertê zszed³ ze s³u¿by!");
    DajKase(playerid, -price);
    DajKase(creatorid, price/2);
    Sejf_Add(groupid, price/2);

    va_SendClientMessage(creatorid, COLOR_LIGHTBLUE, "Otrzymujesz $%d za wykonanie tatua¿u.", price/2);
    va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tatua¿ysta %s zacz¹³ wykonywaæ tatua¿, poczekaj 60 sekund.", GetNick(creatorid));
    TextDrawInfoOn(playerid, "trwa wykonywanie tatuazu~n~poczekaj 60 sekund", 60000);
    TextDrawInfoOn(creatorid, "trwa wykonywanie tatuazu~n~poczekaj 60 sekund", 60000);
    SetTimerEx("Tattoo_Create", 60000, false, "dddddffffff", playerid, creatorid, id, index, bone, fX, fY, fZ, fRX, fRY, fRZ);
    return 1;
}

stock LoadTattooItem(playerid, slot)
{   
    new id = PlayerTattoo[playerid][slot][t_ID];
    new index = Tattoo_FindFreeIndex(playerid);
    if(index == -1) return 0;
    SetPlayerAttachedObject(playerid, index, Tattoo_Models[id][dModel], PlayerTattoo[playerid][slot][t_bone], PlayerTattoo[playerid][slot][t_offsetX], PlayerTattoo[playerid][slot][t_offsetY], PlayerTattoo[playerid][slot][t_offsetZ], PlayerTattoo[playerid][slot][t_RX], PlayerTattoo[playerid][slot][t_RY], PlayerTattoo[playerid][slot][t_RZ], Tattoo_Models[id][dScaleX], Tattoo_Models[id][dScaleY], Tattoo_Models[id][dScaleZ]);
    PlayerTattoo[playerid][slot][t_index] = index;
    return 1;
}

stock Tattoo_FindFreeIndex(playerid)
{
    for(new i = 0; i < sizeof(Tattoo_Index); i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, Tattoo_Index[i]))
            return Tattoo_Index[i];
    }
    //another way
    for(new i = 0; i < 10; i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
            return i;
    }
    return -1;
}

GetFreeSlotTattoo(playerid)
{
    for(new i = 0; i < MAX_PLAYER_TATTOO; i++)
    {
        if(PlayerTattoo[playerid][i][t_UID] == 0)
            return i;
    }
    return -1;
}

