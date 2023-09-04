//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ aprzeszukaj ]--------------------------------------------------//
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

YCMD:aprzeszukaj(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1 && !IsAScripter(playerid))
        return noAccessMessage(playerid);
    new giveplayerid, type[16];
    if(sscanf(params, "k<fix>s[16]", giveplayerid, type)) return sendTipMessage(playerid, "U¿yj: /aprzeszukaj [Nick/ID] [przedmioty/kasa]");
    if(!strcmp(type, "przedmioty", true))
        return PrintPlayerItems(giveplayerid, playerid);
    else if(!strcmp(type, "kasa", true))
        return SendClientMessage(playerid, COLOR_NEWS, sprintf("Pieni¹dze gracza %s. Portfel %d$ | Bank %d$ | GetPlayerMoney %d$", GetNick(giveplayerid), kaska[giveplayerid], PlayerInfo[giveplayerid][pAccount], GetPlayerMoney(giveplayerid)));
    else
        return sendTipMessage(playerid, "Nieprawid³owa opcja.");
}