//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gm ]-----------------------------------------------//
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

YCMD:gm(playerid, params[], help)
{
    if(!IsAGameMaster(playerid)) 
        return noAccessMessage(playerid);
    new string[256];
    if(isnull(params))
        return sendTipMessage(playerid, "U�yj: /gm [gamemaster chat]");
    format(string, sizeof string, "GameMaster %s - %s", GetNickEx(playerid), params);
    foreach(new i : Player)
    {
        if(!IsPlayerConnected(i)) continue;
        if(IsAGameMaster(i))
            SendClientMessage(i, COLOR_GREEN, string);
    }
    SendDiscordMessage(DISCORD_GM_CHAT, string);
    return 1;
}