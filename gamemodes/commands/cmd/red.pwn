//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ red ]--------------------------------------------------//
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

YCMD:red(playerid, params[], help)
{
    if(!CheckPlayerPerm(playerid, PERM_POLICE))
	{
		return sendErrorMessage(playerid, "Nie jesteœ policjantem.");
	}

	if(!GroupPlayerDutyPerm(playerid, PERM_POLICE))
	{
		return sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie.");
	}

    if(PlayerInfo[playerid][pBW] > 0)
    {
       return sendErrorMessage(playerid, "Jesteœ nieprzytomny!"); 
    }

    new str[144], akcja[144];


    new frakcja[10];
    format(frakcja, sizeof(frakcja), "%s", GroupInfo[GetPlayerGroupUID(playerid, OnDuty[playerid]-1)][g_ShortName]);

    if(PDGPS == playerid)
    {
        format(str, sizeof(str), "{FFFFFF}»»{6A5ACD} CENTRALA %s: {FFFFFF}%s:{FF0000} Odwo³ujê CODE RED", frakcja, GetNick(playerid));
        format(akcja,sizeof(akcja),"* %s wy³¹czy³ alert do wszystkich jednostek.",GetNick(playerid));
        GPSMode(playerid, true);
    }
    else
    {
        format(str, sizeof(str), "{FFFFFF}»»{6A5ACD} CENTRALA %s: {FFFFFF}%s:{FF0000} Potrzebne natychmiastowe wsparcie - {FFFFFF}CODE RED", frakcja, GetNick(playerid));
        format(akcja,sizeof(akcja),"* %s uruchomi³ alert do wszystkich jednostek.",GetNick(playerid));
        GPSMode(playerid, true);
    }

    ProxDetector(30.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    SendTeamMessage(0, COLOR_ALLDEPT, str, 0, PERM_POLICE);
    for(new i = 0; i<MAX_GROUPS; i++)
    {
        if(GroupHavePerm(i, PERM_POLICE))
        {
            PlayCrimeReportForPlayersTeam(i, playerid, 16); //lub 16
        }
    }
    return 1;
}
