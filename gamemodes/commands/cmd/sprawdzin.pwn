//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ sprawdzin ]-----------------------------------------------//
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

YCMD:sprawdzin(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return noAccessMessage(playerid);
	new string[128];
	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		SendClientMessage(playerid, -1, "U�yj /sprawdzin [playerid/Cz��Nicku]");
		return 1;
	}
	if(GetPlayerState(giveplayerid) == PLAYER_STATE_NONE) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is none.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_ONFOOT) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is foot.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is driver.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_SPAWNED) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is spawn.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_SPECTATING) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is spec.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_PASSENGER) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is passenger.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
	return 1;
}
