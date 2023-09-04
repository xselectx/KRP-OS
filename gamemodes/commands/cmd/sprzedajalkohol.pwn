//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ sprzedajalkohol ]--------------------------------------------//
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

YCMD:sprzedajalkohol(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAPrzestepca(playerid) || PlayerInfo[playerid][pAdmin] >= 1000 || CheckPlayerPerm(playerid, PERM_CLUB))
        {
			
     		new x_nr[16];
			new giveplayerid;
			if( sscanf(params, "s[16] u", x_nr, giveplayerid))
			{
				sendTipMessage(playerid, "U¯YJ: /sprzedaja [nazwa] [playerid]");
				sendTipMessage(playerid, "Dostêpne nazwy: Piwo, Wino, Cygaro");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid) || giveplayerid != INVALID_PLAYER_ID)
			{
				if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5 && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{
					if(Item_Count(giveplayerid)+5 >= GetPlayerItemLimit(giveplayerid))
						return sendErrorMessage(playerid, "Ten gracz ma za du¿o przedmiotów!");
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					if(strcmp(x_nr,"piwo",true) == 0)
					{
						if(kaska[playerid] < PRICE_PIWO)
							return sendErrorMessage(playerid, "Nie staæ Ciê na to!");
						format(string, sizeof(string), "* Sprzeda³eœ Piwo graczowi: %s, koszt sprzeda¿y: "#PRICE_PIWO"$.",giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Gracz %s sprzeda³ tobie Piwo 'Mroczny Gul'.",sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						Item_Add("Piwo Mroczny Gul", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[giveplayerid][pUID], ITEM_TYPE_ALCOHOL, 0, 0, true, giveplayerid, 1);
						ZabierzKaseDone(playerid, PRICE_PIWO);
						return 1;
					}
					else if(strcmp(x_nr,"wino",true) == 0)
					{
						if(kaska[playerid] < PRICE_WINO)
							return sendErrorMessage(playerid, "Nie staæ Ciê na to!");
						format(string, sizeof(string), "* Sprzeda³eœ Wino graczowi: %s, koszt sprzeda¿y: "#PRICE_WINO"$.",giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Gracz %s sprzeda³ tobie Wino 'Komandos'.",sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						Item_Add("Wino Komandos", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[giveplayerid][pUID], ITEM_TYPE_ALCOHOL, 0, 0, true, giveplayerid, 1);
						ZabierzKaseDone(playerid, PRICE_WINO);
						return 1;
					}
					else if(strcmp(x_nr,"cygaro",true) == 0)
					{
						if(kaska[playerid] < PRICE_CYGARO)
							return sendErrorMessage(playerid, "Nie staæ Ciê na to!");
						format(string, sizeof(string), "* Sprzeda³eœ Paczkê Cygar graczowi: %s, koszt sprzeda¿y: "#PRICE_CYGARO"$.",giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Gracz %s sprzeda³ tobie paczkê 5 cygar kolumbijskich.",sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						Item_Add("Cygaro", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[giveplayerid][pUID], ITEM_TYPE_CIGARETTE, 0, 0, true, giveplayerid, 5);
						ZabierzKaseDone(playerid, PRICE_CYGARO);
						return 1;
					}
				}
				else
				{
					format(string, sizeof(string), "Jesteœ zbyt daleko od gracza %s.",giveplayer);
					sendErrorMessage(playerid, string);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Gracz jest nieaktywny!");
				return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie masz czego sprzedaæ / nie jesteœ z Mafii !");
            return 1;
        }
    }
    return 1;
}
