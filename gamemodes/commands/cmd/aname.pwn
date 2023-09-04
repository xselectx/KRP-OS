//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ a ]---------------------------------------------------//
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

YCMD:aname(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_TEMPNAME))
        return noAccessMessage(playerid);
    new name[24], nick[24];
    if(sscanf(params, "s[24]", name))
        return sendTipMessage(playerid, "U¿yj: /aname [tymczasowa nazwa]");
    if(CheckVulgarityString(name))
        return sendErrorMessage(playerid, "Nick nie mo¿e byæ wulgarny!");
    if(GetPVarString(playerid, "maska_nick", nick, 24))
    {
        SetPlayerColor(playerid, TEAM_HIT_COLOR);
        SetPlayerName(playerid, nick);
		SetRPName(playerid);
		format(PlayerInfo[playerid][pNick], 24, "%s", nick);
        DeletePVar(playerid, "maska_nick");
        sendTipMessage(playerid, "Przywróci³eœ swój stary nick.");
    }
    else
    {
        SetPVarString(playerid, "maska_nick", GetNick(playerid));
        SetRPName(playerid);
        SetPlayerName(playerid, name);
        Log(nickLog, WARNING, "Gracz %s ustawi³ tymczasowy nick %s", GetPlayerLogName(playerid), name);
        sendTipMessage(playerid, "Ustawi³eœ tymczasowy nick.");
    }
    return 1;
}