//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ slap ]-------------------------------------------------//
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

YCMD:slap(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if(sscanf(params, "k<fix>", playa))
		{
			return sendTipMessage(playerid, "U�yj /slap [playerid/Cz��Nicku]");
		}

		if (PlayerInfo[playerid][pAdmin] >=1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || PlayerInfo[playerid][pZG] >= 2 || IsAScripter(playerid) || IsAGameMaster(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					if(PlayerInfo[playa][pAdmin] > PlayerInfo[playerid][pAdmin])
						return sendTipMessage(playerid, "Nie mo�esz u�y� /slap na adminie, kt�ry ma wy�sz� rang� od Ciebie!");			
					new Float:shealth;
					new Float:slx, Float:sly, Float:slz;
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerHealth(playa, shealth);
					SetPlayerHealth(playa, shealth-5);
					GetPlayerPos(playa, slx, sly, slz);
					SetPlayerPos(playa, slx, sly, slz+5);
					PlayerPlaySound(playa, 1130, slx, sly, slz+5);
        			Log(punishmentLog, WARNING, "Admin %s da� slapa %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
					format(string, sizeof(string), "AdmCmd: %s da� klapsa w dupsko %s",GetNickEx(playerid), giveplayer);
					ABroadCast(COLOR_LIGHTRED,string,1);
					format(string, sizeof(string), "Dosta�e� klapsa w dupsko od administratora %s, widocznie zrobi�e� co� z�ego :)", GetNickEx(playerid));
					SendClientMessage(playa, COLOR_PANICRED, string);
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
