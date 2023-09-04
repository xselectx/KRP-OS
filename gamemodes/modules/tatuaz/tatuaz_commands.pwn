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

//-----------------<[ Komendy: ]>-------------------

YCMD:tatuaz(playerid, params[])
{
    if(!GroupPlayerDutyPerm(playerid, PERM_TATTOO)) return sendTipMessage(playerid, "Nie jesteœ na s³u¿bie grupy z takimi uprawnieniami!");
    new targetid, price;
    if(sscanf(params, "k<fix>d", targetid, price)) return sendTipMessage(playerid, "U¿yj: /tatuaz [ID gracza] [cena od 50$ do 400$]");
    if(!IsPlayerConnected(targetid)) return sendTipMessage(playerid, "Gracz o podanym ID nie istnieje!");
    if(!IsPlayerNear(playerid, targetid)) return sendTipMessage(playerid, "Nie jesteœ w pobli¿u tego gracza!");
    if(price < 50 || price > 400) return sendTipMessage(playerid, "Cena od $50 do $400!");
    if(kaska[targetid] < price) return sendTipMessage(playerid, "Ten gracz nie ma tyle kasy!");
    if(IsPlayerConnected(GetPVarInt(targetid, "Tattoo-Offer"))) return sendTipMessage(playerid, "Ten gracz ma aktywn¹ ofertê!");
    if(GetFreeSlotTattoo(targetid) == -1) return sendErrorMessage(playerid, "Ten gracz przekroczy³ limit tatua¿y!");
    foreach(new i : Player)
    {
        if(GetPVarInt(i, "Tattoo-Offer") == playerid && IsPlayerNear(playerid, i))
            return sendErrorMessage(playerid, "Wykonujesz ju¿ komuœ tatua¿!");
    }

    SetPVarInt(targetid, "Tattoo-Offer", playerid);
    SetPVarInt(targetid, "Tattoo-Price", price);
    SetPVarInt(targetid, "Tattoo-Active", 1);
    va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wys³a³eœ ofertê wykonania tatua¿u graczowi %s za $%d, czekaj na akceptacjê.", GetNick(targetid), price);
    va_SendClientMessage(targetid, COLOR_LIGHTBLUE, "* Tatua¿ysta %s wys³a³ Ci ofertê wykonania tatua¿u za $%d. Wpisz /akceptuj tatuaz", GetNick(playerid), price);
    return 1;
}