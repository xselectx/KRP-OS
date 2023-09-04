//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    glod                                                   //
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
// Autor: renosk
// Data utworzenia: 26.05.2021
//Opis:
/*
	System g³odu
*/

//

//-----------------<[ Funkcje: ]>-------------------

stock htTextDrawHide(playerid)
{
	PlayerTextDrawHide(playerid, hunger_value[playerid]);
	PlayerTextDrawHide(playerid, thirst_value[playerid]);
	TextDrawHideForPlayer(playerid, hunger_icon);
	TextDrawHideForPlayer(playerid, thirst_icon);
	return 1;
}

stock htTextDrawShow(playerid)
{
	if(GetPVarInt(playerid, "TogGlod") == 1) return 0;
	new string[128];
	format(string, sizeof(string), "%.0f%%", 100-PlayerInfo[playerid][pHunger]);
	PlayerTextDrawSetString(playerid, hunger_value[playerid], string);
	format(string, sizeof(string), "%.0f%%", 100-PlayerInfo[playerid][pThirst]);
	PlayerTextDrawSetString(playerid, thirst_value[playerid], string);

	TextDrawShowForPlayer(playerid, hunger_icon);
	PlayerTextDrawShow(playerid, hunger_value[playerid]);
	TextDrawShowForPlayer(playerid, thirst_icon);
	PlayerTextDrawShow(playerid, thirst_value[playerid]);

	if(PlayerInfo[playerid][pHunger] >= 88.0)
	{
		PlayerTextDrawColor(playerid, hunger_value[playerid], 0xFF0000FF);
	}
	else
	{
		PlayerTextDrawColor(playerid, hunger_value[playerid], -1);
	}

	if(PlayerInfo[playerid][pThirst] >= 91.0)
	{
		PlayerTextDrawColor(playerid, thirst_value[playerid], 0xFF0000FF);
	}
	else
	{
		PlayerTextDrawColor(playerid, thirst_value[playerid], -1);
	}
	return 1;
}



//end