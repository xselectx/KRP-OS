//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ucisz ]-------------------------------------------------//
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

YCMD:ucisz(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U�yj /ucisz [playerid/Cz��Nicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 5 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
				    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					if(PlayerInfo[playa][pMuted] == 0)
					{
						PlayerInfo[playa][pMuted] = 1;
        				Log(adminLog, WARNING, "Admin %s uciszy� %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
						format(string, sizeof(string), "AdmCmd: %s uciszyl %s",GetNickEx(playerid), giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta�e� uciszony przez administratora %s, widocznie powiedzia�e� co� z�ego :)", GetNickEx(playerid));
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					else
					{
						PlayerInfo[playa][pMuted] = 0;
        				Log(adminLog, WARNING, "Admin %s odciszy� %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
						format(string, sizeof(string), "AdmCmd: %s odciszy� %s",GetNickEx(playerid), giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta�e� odciszony przez administratora %s, popraw si� :)", GetNickEx(playerid));
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
