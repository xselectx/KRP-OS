//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ nickooc ]---------------------------------------------------//
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

YCMD:nickooc(playerid, params[], help)
{
    if(!PlayerInfo[playerid][pAdmin] && !IsAScripter(playerid))
        return noAccessMessage(playerid);
    new nick[24];
    if(sscanf(params, "s[24]", nick))
        return sendTipMessage(playerid, "U�yj: /nickooc [nazwa postaci]");
    strreplace(nick, " ", "_");
    new ooc[MAX_PLAYER_NAME];
    ooc = MruMySQL_GetNickOOCFromName(nick);
    va_SendClientMessage(playerid, -1, "Nick OOC gracza o nicku: %s to: %s", nick, ooc);
    return 1;
}