//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ ochrona ]------------------------------------------------//
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

YCMD:ochrona(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pJob] != 8 && !CheckPlayerPerm(playerid, PERM_LEGALGUNDEALER))
    {
		sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� ochroniarzem lub pracownikiem GS'a");
		return 1;
    }
	new giveplayerid, money;
	if( sscanf(params, "k<fix>d", giveplayerid, money))
	{
		sendTipMessage(playerid, "U�yj /ochrona [playerid/Cz��Nicku] [cena]");
		return 1;
	}

	if(money < 60 || money > 250) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od 60 do 250!"); return 1; }
	if(IsPlayerConnected(giveplayerid))
	{
	    if(giveplayerid != INVALID_PLAYER_ID)
	    {
	        if(ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
			{
                if(gettime() < GetPVarInt(playerid, "armoryTimeLimit"))
                {
                    return sendErrorMessage(playerid, "Kamizelki oferowa� mo�esz co 45 sekundy");
                }
			    if(giveplayerid == playerid)
			    {
			        /*if(gettime() < GetPVarInt(playerid, "selfArmorLimit")) {
                        return sendErrorMessage(playerid, "Mo�esz oferowa� kamizelke samemu sobie co 15 minut");
                    }
                    SetPVarInt(playerid, "selfArmorLimit", gettime() + 900);
                    SetPlayerArmour(playerid, 100);

                    sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Da�e� sobie samemu kamizelk�");*/
			        return sendErrorMessage(playerid, "Nie mo�esz dawa� sobie samemu kamizelki.");
			    }
			    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
			    format(string, sizeof(string), "* Oferujesz ochron� %s za $%d.", giveplayer, money);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Ochroniarz %s oferuje ci kamielk� za $%d, (wpisz /akceptuj ochrona) aby akceptowa�", sendername, money);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				GuardOffer[giveplayerid] = playerid;
				GuardPrice[giveplayerid] = money;

                SetPVarInt(playerid, "armoryTimeLimit", gettime() + 45);
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie ma takiego gracza!");
	}
	return 1;
}
