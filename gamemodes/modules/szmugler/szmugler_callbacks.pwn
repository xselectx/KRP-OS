//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  pizzaman                                                 //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	Praca dorywcza Magazynier
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	Create3DTextLabel("Praca Szmuglera - Tylko dla Organizacji Przestepczych!\n{FFFFFF}(/{929292}okradaj}) aby zacz¹æ okradac Tira.", 0xFFA500AA, -76.32, -1559.37, 2.6, 40, 0, 0);
    Create3DTextLabel("Praca Szmuglera - Tylko dla Organizacji Przestepczych!\n{FFFFFF}(/{929292}sprzedaj{FFFFFF}) aby sprzedaæ ³up z kradzie¿y.", 0xFFA500AA, 761.80, -612.54, 15.55, 40, 0, 0);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    Kradnie[playerid] = 0;
    OkradanieTira[playerid] = 0;
    Kradnie[playerid] = 0;
    ACSzmugler[playerid] = 0;
	return 1;
}
//end