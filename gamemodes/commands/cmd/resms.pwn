//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ resms ]-------------------------------------------------//
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

YCMD:resms(playerid, params[], help)
{
	new string[256];
	if(Kajdanki_JestemSkuty[playerid] == 1)
	{
		sendErrorMessage(playerid, "Nie mo�esz u�ywa� telefonu podczas bycia skutym!");
		return 1;
	}
	if(LastSMSNumber[playerid] == 0)
	{
		sendErrorMessage(playerid, "Nikt nie wys�a� Ci smsa");
	}
	
	if(isnull(params))
	{
		sendTipMessage(playerid, "U�yj /res [wiadomo��]");
	}
	
	format(string, sizeof(string), "%d %s", LastSMSNumber[playerid], params);
	return RunCommand(playerid, "/sms",  string);
}
