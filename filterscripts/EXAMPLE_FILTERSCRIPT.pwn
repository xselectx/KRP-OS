//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu�: EXAMPLE_FILTERSCRIPT.pwn ]---------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*

*/
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

//

#include <a_samp>


//------------------<[ Makra: ]>-------------------
//------------------<[ Define: ]>-------------------
//-----------------<[ Zmienne: ]>-------------------
//------------------<[ Enumy: ]>--------------------
//------------------<[ Forwardy: ]>--------------------
//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -EXAMPLE_FILTERSCRIPT- zaladowany");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -EXAMPLE_FILTERSCRIPT- wylaczony");
	print("--------------------------------------\n");
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------