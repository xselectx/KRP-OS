//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ kickduty ]----------------------------------------------//
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

YCMD:kickduty(playerid, params[], help)
{
    new targetid;
    if(sscanf(params, "k<fix>", targetid))
    {
        return sendTipMessage(playerid, "U�yj: /kickduty [id gracza]");
    }
    if(PlayerInfo[playerid][pAdmin] < 1000) 
    {
        return noAccessMessage(playerid);
    }
    if(!IsPlayerConnected(targetid))
    {
        return sendErrorMessage(playerid, "Gracz o podanym ID nie jest po��czony z serwerem.");
    }
    if(!OnDuty[targetid] && !JobDuty[targetid])
    {
        return sendErrorMessage(playerid, "Ten gracz nie jest na duty!");
    }
    SetPlayerSkinEx(targetid, PlayerInfo[targetid][pSkin]);
    PrzywrocBron(targetid);
    PrintDutyTime(targetid);
    OnDuty[targetid] = 0;
    JobDuty[targetid] = 0;
    SetPlayerToTeamColor(targetid);
    SetPlayerSpawnSkin(targetid);
    UpdatePlayer3DName(targetid);
    va_SendClientMessage(playerid, COLOR_RED, "Wyrzuci�e� gracza %s ze s�u�by.", GetNick(targetid));
    va_SendClientMessage(targetid, COLOR_RED, "Administrator %s wyrzuci� Ci� ze s�u�by.", GetNick(playerid));
    return 1;
}