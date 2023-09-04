//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zniszcz ]------------------------------------------------//
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

YCMD:zniszcz(playerid, params[])
{
	if(isnull(params))
		return sendTipMessage(playerid, "U¿yj: /zniszcz [plantacja]");
	switch(YHash(params))
	{
		case _H<plantacja>:
		{
			if(!IsAPolicja(playerid))
				return sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie grupy, która ma dostêp do tej komendy!");
			new id = GetClosestPlant(playerid);
			if(id == -1) return sendErrorMessage(playerid, "Nie znajdujesz siê w pobli¿u ¿adnej plantacji.");
			new targetid = GetPlayerIDFromUID(Plantacja[id][p_Owner]);
			if(IsPlayerConnected(targetid) && targetid != INVALID_PLAYER_ID)
			{
				SendClientMessage(targetid, COLOR_LIGHTBLUE, "Twoja plantacja zosta³a zniszczona!");
			}
			UsunPlantacje(id);
			RunCommand(playerid, "/me", "niszczy plantacjê");
		}
		default: sendTipMessage(playerid, "Nieprawid³owa opcja.");
	}
	return 1;
}