//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ biegnij ]------------------------------------------------//
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

YCMD:biegnij(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 2000)//chwilowa blokada
		{
			if(GetPlayerStrong(playerid) <= 980)
			{
				if(!IsPlayerInAnyVehicle(playerid))
				{
					if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
					{
						sendErrorMessage(playerid, "Rozpocz��e� ju� bieg! Najpierw go uko�cz"); 
						return 1;
					}
					if(PlayerRunStat[playerid] == 3)
					{
						sendTipMessage(playerid, "Wykona�e� dzi� 3 biegi! Mo�e wystarczy?");
						return 1;
					}
					if(IsPlayerInRangeOfPoint(playerid, 10, 2005.9244,-1442.3917,13.5631))//Od szpitala Jeff do Placu
					{
						SetPVarInt(playerid, "ZaliczylBaze", 0);
						SetPVarInt(playerid, "WybralBieg", 1);
						SetPVarInt(playerid, "RozpoczalBieg", 1);
						if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
						{
							SetPlayerCheckpoint(playerid, 1861.5981,-1453.0206,13.5625, 5);
							sendTipMessage(playerid, "Rozpoczynasz bieg, zdob�d� pierwszy checkpoint!");
							sendTipMessageEx(playerid, COLOR_NEWS, "Cel: Plac Manewrowy Los Santos"); 
						}
					}
					else if(IsPlayerInRangeOfPoint(playerid, 10, 806.4952,-1334.9512,13.5469))//Od dworca Market do Pos�gu ILOVELS
					{
						SetPVarInt(playerid, "ZaliczylBaze", 0);
						SetPVarInt(playerid, "WybralBieg", 2);
						SetPVarInt(playerid, "RozpoczalBieg", 1);
						if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
						{
							sendTipMessage(playerid, "Rozpoczynasz bieg, zdob�d� pierwszy checkpoint!");
							sendTipMessageEx(playerid, COLOR_NEWS, "Cel: Pos�g I_LOVE_LS"); 
							SetPlayerCheckpoint(playerid, 645.5999,-1327.7279,13.5522, 3);
						}
					}
					else
					{
						sendTipMessage(playerid, "Nie jeste� na jednym z mo�liwych tor�w biegu"); 
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Najpierw wyjd� z pojazdu"); 
				}
			}
			else
			{
				sendTipMessage(playerid, "Jeste� ju� maksymalnie wysportowany! Bieg Ci nic nie da"); 
			}
		}
	}
	return 1;
}
