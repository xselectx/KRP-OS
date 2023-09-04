//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kontrakt ]-----------------------------------------------//
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

YCMD:kontrakt(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		new giveplayerid, moneys;
		if( sscanf(params, "k<fix>d", giveplayerid, moneys))
		{
			sendTipMessage(playerid, "U�yj /kontrakt [playerid/Cz��Nicku] [kwota]");
			return 1;
		}

		if(moneys < PRICE_HA_MIN || moneys > PRICE_HA_MAX) { sendTipMessageEx(playerid, COLOR_GREY, "Kontrakt musi wynosi� od $"#PRICE_HA_MIN", do $"#PRICE_HA_MAX"!"); return 1; }
		if(PlayerInfo[playerid][pLevel] < 3)
		{
			sendTipMessageEx(playerid, COLOR_GRAD1, "Musisz mie� 3 lvl aby podpisywa� kontrakty.");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			if(IsPlayerInGroup(playerid, 8) )
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz podpisa� kontraktu b�d�c hitmanem!");
				return 1;
			}
			else if(IsPlayerInGroup(giveplayerid, 8) ||PlayerInfo[giveplayerid][pLider] == 8)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz podpisa� kontraktu na te osobe !");
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pNewAP] >= 1 || IsAScripter(giveplayerid))
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz podpisa� kontraktu na te osobe !");
				return 1;
			}
			else if(IsAPolicja(giveplayerid) && moneys < PRICE_HA_POLICJA)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Za g�ow� policjanta trzeba zap�aci� conajmniej "#PRICE_HA_POLICJA"$ !");
				return 1;
			}
			if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz da� kontraktu na samego siebie!"); return 1; }
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new playermoney = kaska[playerid];
			if (moneys > 0 && playermoney >= moneys)
			{
				ZabierzKaseDone(playerid, moneys);
				PlayerInfo[giveplayerid][pHeadValue]+=moneys;
				format(string, sizeof(string), "%s podpisa� kontrakt na %s, nagroda za wykonanie $%d.",sendername, giveplayer, moneys);
				GroupSendMessage(8, COLOR_YELLOW, string);
				format(string, sizeof(string), "* Podpisa�e� kontrakt na %s, za $%d.",giveplayer, moneys);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GRAD1, "Z�a kwota.");
			}
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
