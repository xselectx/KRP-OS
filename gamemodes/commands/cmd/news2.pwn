//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ news2 ]-------------------------------------------------//
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

YCMD:news2(playerid, params[], help)
{
	new string[124], text[124]; 
	if(IsPlayerConnected(playerid))
	{
		if(GroupPlayerDutyPerm(playerid, PERM_NEWS) && GroupPlayerDutyRank(playerid) >= 5)
		{
			if(sscanf(params, "s[124]", text))
			{
				sendTipMessage(playerid, "U�yj /news2 [text]"); 
				return 1;
			}
			format(string, sizeof(string), "Ustawi�e� nowy komunikat na blok informacyjny"); 
			sendTipMessageEx(playerid, COLOR_P@, string); 
			format(string, sizeof(string), "~y~NR %s:~w~%s", GetNick(playerid), Odpolszcz(text)); 
			SendNews_2(string); 
		}
		else{
			sendErrorMessage(playerid, "Ta komenda jest dost�pna od 5 stopnia w San News!"); 
			return 1;
		}
	}
	return 1;
}
