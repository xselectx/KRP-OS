//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ poscig ]-----------------------------------------------//
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

YCMD:poscig(playerid, params[], help)
{
	if(IsAPolicja(playerid))
	{
		if(OnDuty[playerid] > 0)
		{
			new giveplayerid;
			if(sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /poscig [id/nick]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
			{
				if(PoziomPoszukiwania[giveplayerid] >= 1)
				{
					PursuitMode(playerid, giveplayerid);
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie ma WL !");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza !");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie !");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z PD!");
	}
	return 1;
}