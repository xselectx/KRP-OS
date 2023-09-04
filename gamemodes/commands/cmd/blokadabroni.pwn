//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ blokadabroni ]-------------------------------------------------//
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

YCMD:blokadabroni(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1)
        return noAccessMessage(playerid);
    new player, opt1[64], opt2[64];
    if(sscanf(params, "k<fix>s[64]S()[64]", player, opt1, opt2))
        return sendTipMessage(playerid, "U�yj: /blokadabroni [ID gracza] [zdejmij/nadaj]");
    if(!IsPlayerConnected(player))
        return sendErrorMessage(playerid, "Ten gracz nie istnieje!");
    switch(YHash(opt1))
    {
        case _H<zdejmij>:
        {
            if(PlayerInfo[player][pWeaponBlock] < gettime())
                return sendErrorMessage(playerid, "Ten gracz nie posiada aktywnej blokady broni!");
            PlayerInfo[player][pWeaponBlock] = 0;
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "* Zdj��e� blokad� broni graczowi %s.", GetNick(player));
            Log(adminLog, WARNING, "%s zdj�� blokad� broni dla %s.", GetPlayerLogName(playerid), GetPlayerLogName(player));
        }
        case _H<nadaj>:
        {
            new time;
            if(sscanf(opt2, "d", time))
                return sendTipMessage(playerid, "U�yj: /blokadabroni [ID gracza] [nadaj] [czas w minutach]");
            if(PlayerInfo[player][pWeaponBlock] > gettime())
                return sendErrorMessage(playerid, "Ten gracz ma aktywn� blokad� broni!");
            if(time < 1 || time > 240)
                return sendErrorMessage(playerid, "Maksymalnie 240 minut!");
            new sec = time*60;
            PlayerInfo[player][pWeaponBlock] = gettime()+sec;
            va_SendClientMessage(playerid, COLOR_LIGHTRED, "* Nada�e� blokad� broni dla gracza %s na okres %d minut.", GetNick(player), time);
            Log(adminLog, WARNING, "%s nada� blokad� broni dla %s na okres %d minut.", GetPlayerLogName(playerid), GetPlayerLogName(player), time);

        }
        default: sendTipMessage(playerid, "Nieprawid�owa opcja.");
    }
    return 1;
}