//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   tuning                                                  //
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
// Autor: xSeLeCTx
// Data utworzenia: 10.07.2021


//

//------------------<[ Implementacja: ]>-------------------
command_koszyk_Impl(playerid)
{
	new mechanik = GetPVarInt(playerid, "Tune_mechanik");
	if(GetPVarInt(mechanik, "Tune_active") == 1 && GetPVarInt(mechanik, "Tune_giveplayerid") == playerid)
	{
		new string[1024];
		new cost;
		strcat(string, "{d9d9d9}ID\t{d9d9d9}Nazwa\t{d9d9d9}Typ\t{d9d9d9}Cena");
		for(new i = 0; i<MAX_TUNE_PARTS; i++)
		{
			if(TuneRecipe[playerid][i][tuneR_Active] == 1)
			{
				format(string, sizeof(string), "%s\n%d\t%s (%s)\t%s\t%d$", string, i, TuneRecipe[playerid][i][tuneR_Name], TuneRecipe[playerid][i][tuneR_Custom] == 0 ? "Fabryczne" : "Niestandardowe", TuneTypeNames[TuneRecipe[playerid][i][tuneR_Type]], TuneRecipe[playerid][i][tuneR_Cost]);
				cost+=TuneRecipe[playerid][i][tuneR_Cost];
			}
		}
		if(cost > 0) return ShowPlayerDialogEx(playerid, D_TUNE_BASKET, DIALOG_STYLE_TABLIST_HEADERS, sprintf("{99e805} Koszyk Tuningu (%d$)", cost), string, "OK", "");
		else return SendClientMessage(playerid, COLOR_GRAD2, "Twój koszyk jest pusty!");
	}
	else
		return SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ podczas tuningu!");
}

//end