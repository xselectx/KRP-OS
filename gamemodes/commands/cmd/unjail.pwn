//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ unjail ]------------------------------------------------//
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

YCMD:unjail(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U�yj /unaj [ID gracza]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            if(PlayerInfo[playa][pJailed] == 3)
		            {
				        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "* Uwolni�e� %s.", giveplayer);
						_MruAdmin(playerid, string);
						format(string, sizeof(string), "* Zosta�e� uwolniony przez %s.", GetNickEx(playerid));
						_MruAdmin(playa, string);
						format(string, sizeof(string), "ADMCMD: Administrator %s uwolni� %s z AJ", GetNickEx(playerid), giveplayer);
						SendMessageToAdmin(string, COLOR_RED);
                        Log(punishmentLog, WARNING, "Admin %s uwolni� %s z AJ (typ: %d, czas: %ds)", 
							GetPlayerLogName(playerid), 
							GetPlayerLogName(playa), 
							PlayerInfo[playa][pJailed], 
							PlayerInfo[playa][pJailTime]);

						if(GetPVarInt(playa, "DostalDM2") != 0)
						{
							format(string, sizeof(string), "Info: %s nie zostanie zabrana bro� bo dosta� UnJail", GetNick(playa));
							sendTipMessage(playerid, string); 
						}
						PlayerInfo[playa][pJailed] = 0;
						PlayerInfo[playa][pJailTime] = 0;
						PlayerInfo[playa][pMuted] = 0;
						//SetPlayerInterior(playa, 0);
						SetPVarInt(playa, "DostalDM2", 0);//
						//SetPlayerPos(playa,-1677.0605,917.2449,-52.4141);
						//SetPlayerVirtualWorld(playa, 1);
                        //Wchodzenie(playa);
						SetPlayerSpawn(playa);
						PlayerPlaySound(playa, 0, 0.0, 0.0, 0.0);
						StopAudioStreamForPlayer(playa);
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscAJ[playerid] = iloscAJ[playerid]+1;
						}

					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GRAD1, "Ten gracz nie jest w AJ !");
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
