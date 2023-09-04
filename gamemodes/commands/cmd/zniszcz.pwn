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
		return sendTipMessage(playerid, "U�yj: /zniszcz [plantacja]");
	switch(YHash(params))
	{
		case _H<plantacja>:
		{
			if(!IsAPolicja(playerid))
				return sendErrorMessage(playerid, "Nie jeste� na s�u�bie grupy, kt�ra ma dost�p do tej komendy!");
			new id = GetClosestPlant(playerid);
			if(id == -1) return sendErrorMessage(playerid, "Nie znajdujesz si� w pobli�u �adnej plantacji.");
			new targetid = GetPlayerIDFromUID(Plantacja[id][p_Owner]);
			if(IsPlayerConnected(targetid) && targetid != INVALID_PLAYER_ID)
			{
				SendClientMessage(targetid, COLOR_LIGHTBLUE, "Twoja plantacja zosta�a zniszczona!");
			}
			UsunPlantacje(id);
			RunCommand(playerid, "/me", "niszczy plantacj�");
		}
		default: sendTipMessage(playerid, "Nieprawid�owa opcja.");
	}
	return 1;
}