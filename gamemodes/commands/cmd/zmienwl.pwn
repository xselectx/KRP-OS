//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zmienwl ]------------------------------------------------//
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

YCMD:zmienwl(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U�yj /setwl [playerid/Cz��Nicku] [ilo�� wl]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 100 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 10 || level < 0)
				{
					sendTipMessage(playerid, "Numer WL od 0 do 10!"); return 1;
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PoziomPoszukiwania[para1] = level;
					SetPlayerWantedLevel(para1, (PoziomPoszukiwania[para1] > 6 ? 6 : PoziomPoszukiwania[para1]));
					Log(adminLog, WARNING, "Admin %s zmieni� wanted level %s na %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);
					format(string, sizeof(string), "   Tw�j Poziom Poszukiwania zosta� zmieniony na %d przez admina %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni�e� poziom poszukiwania %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
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
