//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnGameModeInit()
{
	hunger_icon = TextDrawCreate(594.000000, 2.000000, "hud:radar_dateFood");
	TextDrawFont(hunger_icon, 4);
	TextDrawLetterSize(hunger_icon, 0.600000, 2.000000);
	TextDrawTextSize(hunger_icon, 12.000000, 12.000000);
	TextDrawSetOutline(hunger_icon, 1);
	TextDrawSetShadow(hunger_icon, 0);
	TextDrawAlignment(hunger_icon, 1);
	TextDrawColor(hunger_icon, -1);
	TextDrawBackgroundColor(hunger_icon, 255);
	TextDrawBoxColor(hunger_icon, 50);
	TextDrawUseBox(hunger_icon, 1);
	TextDrawSetProportional(hunger_icon, 1);
	TextDrawSetSelectable(hunger_icon, 0);

	thirst_icon = TextDrawCreate(616.000000, 2.000000, "hud:radar_dateDrink");
	TextDrawFont(thirst_icon, 4);
	TextDrawLetterSize(thirst_icon, 0.600000, 2.000000);
	TextDrawTextSize(thirst_icon, 12.000000, 12.000000);
	TextDrawSetOutline(thirst_icon, 1);
	TextDrawSetShadow(thirst_icon, 0);
	TextDrawAlignment(thirst_icon, 1);
	TextDrawColor(thirst_icon, -1);
	TextDrawBackgroundColor(thirst_icon, 255);
	TextDrawBoxColor(thirst_icon, 50);
	TextDrawUseBox(thirst_icon, 1);
	TextDrawSetProportional(thirst_icon, 1);
	TextDrawSetSelectable(thirst_icon, 0);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "bw-cooldown", gettime() + 600);

	//PlayerHungerBar[playerid] = CreatePlayerProgressBar(playerid, 548.0, 62.0, 62.500, 4.000, COLOR_GREEN, MAX_ALLOWED_HUNGER);
	hunger_value[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 15.000000, "0%%");
	PlayerTextDrawFont(playerid, hunger_value[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hunger_value[playerid], 0.137500, 1.000000);
	PlayerTextDrawTextSize(playerid, hunger_value[playerid], 566.500000, 8.000000);
	PlayerTextDrawSetOutline(playerid, hunger_value[playerid], 1);
	PlayerTextDrawSetShadow(playerid, hunger_value[playerid], 0);
	PlayerTextDrawAlignment(playerid, hunger_value[playerid], 2);
	PlayerTextDrawColor(playerid, hunger_value[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hunger_value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hunger_value[playerid], 50);
	PlayerTextDrawUseBox(playerid, hunger_value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, hunger_value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hunger_value[playerid], 0);

	thirst_value[playerid] = CreatePlayerTextDraw(playerid, 622.000000, 15.000000, "0%%");
	PlayerTextDrawFont(playerid, thirst_value[playerid], 1);
	PlayerTextDrawLetterSize(playerid, thirst_value[playerid], 0.137500, 1.000000);
	PlayerTextDrawTextSize(playerid, thirst_value[playerid], 566.500000, 8.000000);
	PlayerTextDrawSetOutline(playerid, thirst_value[playerid], 1);
	PlayerTextDrawSetShadow(playerid, thirst_value[playerid], 0);
	PlayerTextDrawAlignment(playerid, thirst_value[playerid], 2);
	PlayerTextDrawColor(playerid, thirst_value[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, thirst_value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, thirst_value[playerid], 50);
	PlayerTextDrawUseBox(playerid, thirst_value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, thirst_value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, thirst_value[playerid], 0);
	return 1;
}

//end