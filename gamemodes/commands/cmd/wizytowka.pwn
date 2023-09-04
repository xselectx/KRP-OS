//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wizytowka ]-----------------------------------------------//
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

YCMD:wizytowka(playerid, params[], help)
{
	if(GetPhoneNumber(playerid) == 0)
	{
		sendErrorMessage(playerid, "Nie masz telefonu, nie mo�esz dawa� graczom wizyt�wek.");
		return 1;
	}

	new giveplayerid, nazwa[MAX_KONTAKT_NAME_1], string[128];
	format(string, sizeof(string), "k<fix>S(%s)["#MAX_KONTAKT_NAME_1"]", GetNick(playerid));
	if(sscanf(params, string, giveplayerid, nazwa))
	{
		sendTipMessage(playerid, "U�yj /wizytowka [ID/Nick Gracza] (nazwa - domy�lnie nick)");
		return 1;
	}
	
	if(!IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}
	
	if(!ProxDetectorS(10.0, playerid, giveplayerid))
	{
		sendErrorMessage(playerid, "Jeste� za daleko od tego gracza.");
		return 1;
	}
	
	if(GetPhoneNumber(giveplayerid) == 0)
	{
		sendErrorMessage(playerid, "Ten gracz nie ma telefonu, nie mo�esz da� mu wizyt�wki.");
		return 1;
	}
	
	if(giveplayerid == playerid) 
	{
		sendErrorMessage(playerid, "Nie mo�esz da� wizyt�wki samemu sobie!"); 
		return 1;
	}
	
	if(GetPVarInt(giveplayerid, "wizytowka") == playerid)
	{
		sendErrorMessage(playerid, "Ju� oferujesz temu graczowi swoj� wizyt�wk�."); 
		return 1;
	}
	
	if(strlen(nazwa) > MAX_KONTAKT_NAME)
	{
		sendErrorMessage(playerid, "Nazwa kontaktu mo�e mie� maksymalnie "#MAX_KONTAKT_NAME" znaki!");
		return 1;
	}
	
	format(string, sizeof(string), "* Oferujesz %s wizyt�wk�.", GetNick(giveplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* %s proponuje wizyt�wk� o tre�ci: %s, (wpisz /akceptuj wizytowka) aby akceptowa�.", GetNick(playerid), nazwa);
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	SetPVarString(giveplayerid, "wizytowka-nazwa", nazwa);
	SetPVarInt(giveplayerid, "wizytowka", playerid);
	return 1;
}
