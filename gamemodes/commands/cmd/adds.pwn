//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ adds ]-------------------------------------------------//
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

YCMD:adds(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pLevel] >= 3)
		{
			sendTipMessage(playerid, "W trakcie prac"); 
		}
		else
		{
			sendErrorMessage(playerid, "Dodatki s� dost�pne od 3 lvl'a"); 
		}
	}
	return 1;
}

YCMD:rd(playerid, params[]) { 
	new text[2048]; 
	if(file_read(params,text))
	{
		for (new start = 0, length = strlen(text); start < length; start += 120)
        {
			new max = 120;
			if(start+120 > 2034) max = 2034-start;
            new chunk[121]; // 120 characters + null terminator
            strmid(chunk, text, start, start+max);
            SendClientMessage(playerid, -1, chunk);
			if(max < 120) break;
        }
	}
	else SendClientMessage(playerid, -1, "Nie mo�na odczyta� pliku");
}
