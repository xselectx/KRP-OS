//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ komendy ]-----------------------------------------------//
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
// Autor: Mrucznik
// Data utworzenia: 2019-4-28

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/

YCMD:komendy2(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda wy�wietlaj�ca list� wszystkich komend, jakie mo�esz u�y�.");
        return 1;
    }

    //command body
    new count = Command_GetPlayerCommandCount(playerid);
    for (new i = 0; i != count; ++i)
    {
        SendClientMessage(playerid, 0xFF0000AA, Command_GetNext(i, playerid));
    }
    return 1;
}