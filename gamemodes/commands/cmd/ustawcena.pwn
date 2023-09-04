//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ ustawcena ]-----------------------------------------------//
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

YCMD:ustawcene(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new moneys; 
		if( sscanf(params, "d", moneys))
		{
			sendErrorMessage(playerid, "U¿yj /ustawcena [CENA]"); 
			return 1;
		}
		
		new sendername[MAX_PLAYER_NAME];
		new string[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(moneys >= PRICE_TRAIN_KT_MIN)
		{
			if(moneys <= PRICE_TRAIN_KT_MAX)
			{
				if(CheckPlayerPerm(playerid, PERM_TAXI))
				{
					format(string, sizeof(string), "Maszynista %s ustawi³ cenê podró¿y poci¹giem na %d$.", sendername, moneys);
					OOCNews(TEAM_GROVE_COLOR,string);
					CenaBiletuPociag = moneys;				
				}
				else
				{
					sendErrorMessage(playerid, "Nie jesteœ z KT!"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Maksymalna kwota jak¹ mo¿esz ustaliæ to "#PRICE_TRAIN_KT_MAX"$");
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Cena od "#PRICE_TRAIN_KT_MIN"$ do "#PRICE_TRAIN_KT_MAX"$!"); 
			return 1;
		}
	
	}
	return 1;
}
