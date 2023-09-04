//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ getint ]------------------------------------------------//
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

YCMD:getint(playerid, params[], help)
{
	new gracz, string[64];
	if( sscanf(params, "k<fix>", gracz))
	{
		sendTipMessage(playerid, "U�yj /getint [nick/id]");
		return 1;
	}

	if(!IsPlayerConnected(gracz))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}

	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		format(string, sizeof(string), "Interior gracza %s to %d.", GetNick(gracz), GetPlayerInterior(gracz));
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
