//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ vopispomoc ]----------------------------------------------//
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

YCMD:vopispomoc(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		SendClientMessage(playerid, COLOR_P@,"|___________ Jak u�ywa� komendy {CC0033}/vopis{99CC00}___________|");
		SendClientMessage(playerid, COLOR_WHITE,"----> 1. Zamieszczaj tylko to czego 'nie wida�'");
		SendClientMessage(playerid, COLOR_WHITE,"         Przyk�ad 1: {99CC00}Przyciemniane szyby, kartka na przodzie z napisem: Sprzedam");
		SendClientMessage(playerid, COLOR_WHITE,"----> 2. NIE zamieszczaj reklam");
		SendClientMessage(playerid, COLOR_WHITE,"Opis jest czatem globalnym IC. Je�eli b�dziesz go u�ywa� �le mo�esz otrzyma� blokad� tej komendy.");
		SendClientMessage(playerid, COLOR_P@,"{99CC00}|___________ >>> Wi�cej pomocy na Kotnik-RP.pl <<< ___________|");
	}
	return 1;
}
