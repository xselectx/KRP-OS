//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ dajpodatek ]----------------------------------------------//
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

YCMD:dajpodatek(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pLider] != 11)
        {
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� burmistrzem !");
			return 1;
        }
        if(Tax < 1)
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie ma pieni�dzy w funduszach !");
			return 1;
		}
		new Cops = 0;
		foreach(new i : Player)
		{
		    if(IsPlayerConnected(i))
		    {
		        if(IsPlayerInGroup(i, 1))
		        {
		            Cops += 1;
		        }
		    }
		}
		if(Cops >= 1)
		{
		    new valuex = Tax / 2;
		    new price = valuex / Cops;
		    foreach(new i : Player)
			{
			    if(IsPlayerConnected(i))
			    {
			        if(IsPlayerInGroup(i, 1))
			        {
			            format(string, sizeof(string), "* Odebra�e� $%d z funduszu podatkowego od Burmistrza.",price);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
						DajKaseDone(i, price);
						Tax -= price;
			        }
			    }
			}
			SaveStuff();
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "W tym momencie nie ma policjant�w na serwerze!");
			return 1;
		}
	}
	return 1;
}
