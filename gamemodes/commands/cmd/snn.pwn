//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ snn ]--------------------------------------------------//
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

YCMD:snn(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 25)
	{
	    noAccessMessage(playerid);
	    return 1;
	}

	new string[128];
	new sendername[MAX_PLAYER_NAME];

	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(isnull(params))
	{
		sendTipMessage(playerid, "U�yj /snn [cnn textformat ~n~=nowa linia ~r~=czerwony ~g~=zielony ~b~=niebieski ~w~=bia�y ~y~=��ty]");
		return 1;
	}
	format(string, sizeof(string), "  ~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~                         %s",params);
    if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
    GameTextForAll(string, 3000, 1);
	format(string, sizeof(string), "AdmCmd: %s [ID: %d] napisal cos na /snn", sendername, playerid);
	ABroadCast(COLOR_PANICRED,string,1);

	Log(adminLog, WARNING, "Admin %s u�y� /snn o tre�ci: %s", GetPlayerLogName(playerid), params);
	return 1;
}
