//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ dajstartowypojazd ]---------------------------------------------//
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

YCMD:dajstartowypojazd(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 3000)
        return noAccessMessage(playerid);
    if(isnull(params))
        return sendTipMessage(playerid, "U¿yj: /dajstartowypojazd [ID gracza]");
    new targetid = strval(params);
    if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
        return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje.");
    if(!BeginnerCarDialog(targetid))
        return sendErrorMessage(playerid, "Ten gracz nie mo¿e otrzymaæ startowego pojazdu.");
    va_SendClientMessage(playerid, COLOR_LIGHTGREEN, "Da³eœ %s dialog startowego pojazdu", GetNick(targetid));
    va_SendClientMessage(targetid, COLOR_LIGHTGREEN, "%s da³ Ci mo¿liwoœæ wyboru startowego pojazdu", GetNick(playerid));
    return 1;
}