//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wypisz ]------------------------------------------------//
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

YCMD:wypisz(playerid, params[], help)
{
	//new string[128];
	//new giveplayer[MAX_PLAYER_NAME];
	//new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAUrzednik(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
        {
            new x_nr[16];
			new giveplayerid;
			if( sscanf(params, "s[16] k<fix>", x_nr, giveplayerid))
			{
                sendTipMessage(playerid, "U�yj /wydaj [nazwa dokumentu] [playerid]");
                sendTipMessage(playerid, "Dost�pne dokumenty: dowod");
				return 1;
			}
		    if(strcmp(x_nr,"dowod",true) == 0)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Da�e� dow�d osobisty %s", GetNickEx(giveplayerid)));
                        if(giveplayerid != playerid)
                            SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("Urz�dnik %s da� Tobie dow�d osobisty", GetNickEx(playerid)));

				        PlayerInfo[giveplayerid][pDowod] = 1;
				        return 1;
			        }
				}
				else
				{
				    sendErrorMessage(playerid, "Gracz jest nieaktywny!");
				    return 1;
				}
			}
        }
        else
        {
            sendErrorMessage(playerid, "Tylko urz�dnicy maj� prawo do wydawania dowod�w!");
            return 1;
        }
    }
    return 1;
}
