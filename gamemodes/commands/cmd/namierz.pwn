//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ namierz ]------------------------------------------------//
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

YCMD:namierz(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 1 || IsPlayerInGroup(playerid, FRAC_FBI) || IsAHA(playerid) || (IsAPolicja(playerid) && GetPlayerSkin(playerid) == 285))
		{
			if(UsedFind[playerid] != 0)
			{
				sendTipMessage(playerid, "Szuka�e� ju� numeru telefonu, spr�buj ponownie za 2 minuty!");
				return 1;
			}
            new givenumber;
			new giveplayerid = INVALID_PLAYER_ID;
			if(sscanf(params, "d", givenumber))
			{
				sendTipMessage(playerid, "U�yj /namierz [numer telefonu]");
				return 1;
			}
            if(givenumber <= 0) return sendTipMessage(playerid, "Niepoprawny numer telefonu!");

            foreach(new i : Player)
            {
                foreach(new p : PlayerItems[i]) 
				{
					if(Item[p][i_Value1] == givenumber && Item[p][i_ItemType] == ITEM_TYPE_PHONE)
					{
                    	giveplayerid = i;
						break;
					}
				}
            }
            if(giveplayerid == INVALID_PLAYER_ID) return sendTipMessage(playerid, "Nie uda�o si� namierzy� numeru...");
			if(giveplayerid == playerid)
			{
				sendErrorMessage(playerid, "Nie mo�esz szuka� samego siebie!"); return 1;
			}
			if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
			{
				sendErrorMessage(playerid, "Nie mo�esz namierzy� tego gracza.");
				return 1;
			}
			if(PlayerInfo[playerid][pJob] == 1 && lowcaz[playerid] != giveplayerid)
			{
				sendErrorMessage(playerid, "Nie masz zlecenia na tego gracza!");
				return 1;
			}
			new points, range;
			new level = PlayerInfo[playerid][pDetSkill];
			if(level >= 0 && level <= 50)
			{ points = 12; range = 100;}
			else if(level >= 51 && level <= 100)
			{ points = 16; range = 80;}
			else if(level >= 101 && level <= 200)
			{ points = 20; range = 70;}
			else if(level >= 201 && level <= 400)
			{ points = 24; range = 60;}
			else if(level >= 401)
			{ points = 35; range = 45;}
			
            //zone[killerid] = GangZoneCreate(X-(wantedlevel*500),Y-(wantedlevel*500),X+(wantedlevel*500),Y+(wantedlevel*500));
			
            //FindTime[playerid] = 1; 
			//FindTimePoints[playerid] = points;
			PlayerInfo[playerid][pDetSkill] ++;
			UsedFind[playerid] = 1;
            new msg[128];
			//TaxiAccepted[playerid] = giveplayerid;
			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(giveplayerid, pZone, MAX_ZONE_NAME);
            format(msg, sizeof(msg), "Numer telefonu %d znajduje si� w okolicy %s. Strefa zaznaczona na mapie kolorem r�owym.", givenumber, pZone);
            sendTipMessageEx(playerid, COLOR_GREY, msg);
            format(msg, sizeof(msg), "Strefa zniknie za: %d sekund/y", points);
            sendTipMessageEx(playerid, COLOR_GREY, msg);
            SetPVarInt(playerid, "findtime", points);
            SetPVarInt(playerid, "finding", 1);
            SetPVarInt(playerid, "findingId", giveplayerid);
            SetPVarInt(playerid, "findingRange", range);
			//SendClientMessage(playerid, COLOR_GREY, "Skill (�owca Nagr�d/Detektyw) +1");
            sendNotification(playerid, "PRACA", "~b~~h~Skill (Detektyw) +1", 5000);
			if(PlayerInfo[playerid][pDetSkill] == 50)
			{ 
                //SendClientMessage(playerid, COLOR_YELLOW, "* Tw�j skill �owcy Nagr�d jest teraz na poziomie 2, mo�esz teraz szuka� d�u�ej."); 
                sendNotification(playerid, "PRACA", "~b~~h~Skill (Detektyw) +1~n~~n~~b~Twoj skill wzrosl!~n~~b~Mozesz teraz szukac dluzej", 5000);
            }
			else if(PlayerInfo[playerid][pDetSkill] == 100)
			{ sendNotification(playerid, "PRACA", "~b~~h~Skill (Detektyw) +1~n~~n~Twoj skill wzrosl!~n~Mozesz teraz szukac dluzej", 5000); }
			else if(PlayerInfo[playerid][pDetSkill] == 200)
			{ sendNotification(playerid, "PRACA", "~b~~h~Skill (Detektyw) +1~n~~n~Twoj skill wzrosl!~n~Mozesz teraz szukac dluzej", 5000); }
			else if(PlayerInfo[playerid][pDetSkill] == 400)
			{ sendNotification(playerid, "PRACA", "~b~~h~Skill (Detektyw) +1~n~~n~Twoj skill wzrosl!~n~Mozesz teraz szukac dluzej", 5000); }
			//}
			//else
			//{
			//	sendErrorMessage(playerid, "Z�e ID/Nick !");
			//}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jeste� agentem FBI lub operatorem SWAT!");
		}
	}
	return 1;
}
