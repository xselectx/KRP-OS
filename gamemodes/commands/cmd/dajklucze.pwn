//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ dajklucze ]-----------------------------------------------//
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

YCMD:dajklucze(playerid, params[], help)
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(gPlayerLogged[playerid] == 1)
	{
	    new playa, numerp;
		if( sscanf(params, "k<fix>d", playa, numerp))
		{
			sendTipMessage(playerid, "U�yj /dajkluczyki [Nick/ID] [numer wozu]");
			return 1;
		}

		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        numerp--;
		if(numerp >=0 && numerp < MAX_CAR_SLOT)
		{
		    if(playa != INVALID_PLAYER_ID)
		    {
				if(playa == playerid) return sendErrorMessage(playerid, "Sam sobie chcesz da� klucze, pijany jeste�?");
				if(GetDistanceBetweenPlayers(playerid,playa) > 5) return sendErrorMessage(playerid, "Ten gracz jest za daleko!");
		        if(PlayerInfo[playa][pKluczeAuta] == 0)
		        {
                    if(PlayerInfo[playerid][pCars][numerp] == 0) return sendErrorMessage(playerid, "Nie masz wozu pod tym numerem");

					if(CarData[PlayerInfo[playerid][pCars][numerp]][c_Keys] == 0)
					{
						PlayerInfo[playa][pKluczeAuta] = CarData[PlayerInfo[playerid][pCars][numerp]][c_UID];
                        CarData[PlayerInfo[playerid][pCars][numerp]][c_Keys] = PlayerInfo[playa][pUID];
						Car_Save(PlayerInfo[playerid][pCars][numerp], CAR_SAVE_OWNER);
				    }
				    else
				    {
				        sendTipMessage(playerid, "Da�e� ju� komu� kluczyki od tego wozu, aby je zabra� wpisz /zabierzkluczyki");
				        return 1;
					}

					format(string, sizeof(string), "Dosta�e� kluczyki do pojazdu od %s. Wpisz /autoklucze aby co� z nim zrobi�. Aby je wywali� wpisz /wywalklucz.",sendername);
     				SendClientMessage(playa, 0xFFC0CB, string);
     				format(string, sizeof(string), "Da�e� %s kluczyki do twojego pojazdu. Je�li chcesz mu je odebra� wpisz /odbierzklucze.",giveplayer);
     				SendClientMessage(playerid, 0xFFC0CB, string);
     				format(string, sizeof(string), "* %s wyjmuje kluczyki i podaje je %s.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					Log(payLog, WARNING, "%s da� %s kluczyki do pojazdu %s",
						GetPlayerLogName(playerid),
						GetPlayerLogName(playa),
						GetCarDataLogName(PlayerInfo[playerid][pCars][numerp]));
     			}
     			else
     			{
     			    sendTipMessage(playerid, "Ten gracz ma ju� kluczyki. Popro� go o /wywalklucze");
     			}
	    	}
		    else
		    {
		        sendErrorMessage(playerid, "Taki gracz nie istnieje");
		    }
		}
		else
		{
		    sendTipMessage(playerid, "Numer pojazdu od 1");
		}
	}
	return 1;
}
