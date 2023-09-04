//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ szukani ]------------------------------------------------//
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

YCMD:szukani(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if(IsPlayerInGroup(playerid, 1) || PlayerInfo[playerid][pLider] == 1)
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista Poszukiwanych:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    //if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 5 || PoziomPoszukiwania[i] == 10) // tymczasowo off bo nie ma FBI
					if(PoziomPoszukiwania[i] >= 1)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else if(IsPlayerInGroup(playerid, 2) || PlayerInfo[playerid][pLider] == 2)
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista Poszukiwanych:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 6)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0)
			{
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else if(PlayerInfo[playerid][pJob] == 2 || CheckPlayerPerm(playerid, PERM_LAWYER))
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista potencjalnych klientów:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 2)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else
		{
		   	new x;
			SendClientMessage(playerid, COLOR_GREEN, "Najbardziej poszukiwani przestêpcy:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 10)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
	}//not connected
	return 1;
}
