//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ depo ]-------------------------------------------------//
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

YCMD:depo(playerid, params[], help)
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(isnull(params))
        {
            sendTipMessage(playerid, "U¿yj /depo [tekst]");
            return 1;
        }
        if(gMuteDepo[playerid] == 1) return sendTipMessage(playerid, "Nie mo¿esz pisaæ na depo, zablokowa³eœ ten czat (U¿yj /togdepo)");
        if(CheckPlayerPerm(playerid, PERM_DEPO))
        {
            new group[128];
            if(OnDuty[playerid] > 0)
                format(group, sizeof(group), "[%s] %s ", GroupInfo[GetPlayerGroupUID(playerid, OnDuty[playerid]-1)][g_ShortName], GroupRanks[GetPlayerGroupUID(playerid, OnDuty[playerid]-1)][PlayerInfo[playerid][pGrupaRank][OnDuty[playerid]-1]]);
			format(string, sizeof(string), "** (( %s%s: %s )) **", group, GetNickEx(playerid), params);
			SendTeamMessage(0, COLOR_ALLDEPT, string, 1, PERM_DEPO);
            Log(chatLog, WARNING, "%s departament OOC: %s", GetPlayerLogName(playerid), params);
		}
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
    return 1;
}
