//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ pokazdowod ]----------------------------------------------//
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

YCMD:pokazdowod(playerid, params[], help)
{
	new string[64];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /dowod [id gracza]");
			return 1;
		}
		if (PlayerInfo[playerid][pDowod] == 0)
		{
			sendErrorMessage(playerid, "Nie posiadasz dowodu, wyrób go w urzêdzie !");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
			    if (ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{

				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
				    new atext[20];
				    new jtext[20];
                    new otext[8];
				    new age = PlayerInfo[playerid][pAge];
                    if(PlayerInfo[playerid][pSex] == 1) { atext = "Mê¿czyzna"; }
	                else if(PlayerInfo[playerid][pSex] == 2) { atext = "Kobieta"; }
	                // 1 usa 2 europa 3 azja
                    new pochodzenie = PlayerInfo[playerid][pOrigin];
                    switch(pochodzenie) {
                        case 1: otext = "USA";
                        case 2: otext = "Europa";
                        case 3: otext = "Azja";
                    }
                    // 
                    if(PlayerInfo[playerid][pJob] == 1) { jtext = "£owca Nagród"; }
                    else if(PlayerInfo[playerid][pJob] == 2 || CheckPlayerPerm(playerid, PERM_LAWYER)) { jtext = "Prawnik"; }
                    else if(PlayerInfo[playerid][pJob] == 3) { jtext = "Prostytutka"; }
                    //else if(PlayerInfo[playerid][pJob] == 4) { jtext = "Diler Zio³a"; }
                    //else if(PlayerInfo[playerid][pJob] == 5) { jtext = "Z³odziej Aut"; }
                    else if(PlayerInfo[playerid][pJob] == 6) { jtext = "Reporter"; }
                    else if(PlayerInfo[playerid][pJob] == 7) { jtext = "Mechanik"; }
                    else if(PlayerInfo[playerid][pJob] == 8) { jtext = "Ochroniarz"; }
                    //else if(PlayerInfo[playerid][pJob] == 9) { jtext = "Diler Broni"; }
                    else if(PlayerInfo[playerid][pJob] == 10) { jtext = "Kierowca Autobusu"; }
					else if(PlayerInfo[playerid][pJob] == 11) { jtext = "Rozwoziciel pizzy"; }
	                else if(PlayerInfo[playerid][pJob] == 12) { jtext = "Bokser"; }
                    else if(PlayerInfo[playerid][pJob] == 14) { jtext = "Taksówkarz"; }
                    else if(PlayerInfo[playerid][pJob] == 15) { jtext = "Gazeciarz"; }
                    else if(PlayerInfo[playerid][pJob] == 16) { jtext = "Kurier"; }
                    else { jtext = "Bezrobotny"; }
			       //
       				SendClientMessage(giveplayerid, COLOR_NEWS, "|______________ Dowód Osobisty ______________|");
					format(string, sizeof(string), "- Imie i Nazwisko: %s", sendername);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- SSN: %d%d%d%d%d%d%d", PlayerInfo[playerid][pMember],age,PlayerInfo[playerid][pLider],GetPhoneNumber(playerid),PlayerInfo[playerid][pJob],PlayerInfo[playerid][pSex],PlayerInfo[playerid][pLevel]);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- P³eæ: %s", atext);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- Pochodzenie: %s", otext);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- Wiek: %d", age);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					if(PlayerInfo[playerid][pJob] >= 1 && PlayerInfo[playerid][pJob] != 9 && PlayerInfo[playerid][pJob] != 4 && PlayerInfo[playerid][pJob] != 5)
					{
						format(string, sizeof(string), "- Praca: %s", jtext);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
					}
					format(string, sizeof(string), "- Numer telefonu: %d", GetPhoneNumber(playerid));
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					SendClientMessage(giveplayerid,COLOR_NEWS,"|______________________________________________|");
					//
					format(string, sizeof(string), "* %s pokaza³ Ci swój dowód osobisty.", sendername);
					SendClientMessage(giveplayerid, COLOR_PURPLE, string);
					format(string, sizeof(string), "* Pokaza³eœ dowód graczowi %s.", giveplayer);
					SendClientMessage(playerid, COLOR_PURPLE, string);
  				}
		        else
		        {
				    sendErrorMessage(playerid, "Gracz nie jest przed tob¹ !");
				    return 1;
				}
			}
		}
        else
        {
            sendErrorMessage(playerid, "Nie ma takiego gracza!");
            return 1;
        }
	}
    return 1;
}
