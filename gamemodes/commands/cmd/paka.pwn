//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ paka ]-------------------------------------------------//
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

YCMD:paka(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if((IsAPolicja(playerid) || IsAFBI(playerid)) && GroupPlayerDutyRank(playerid) >= 3)
		{
			if(OnDuty[playerid] == 0)
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� na s�u�bie!");
			    return 1;
			}
            //267.8893,86.0968,1001.0391,172.1598,0,0,0,0,0,0); // kajdlsajdsa
	        if(!(IsPlayerInRangeOfPoint(playerid, 10.0, 222.6395,114.3951,999.0156) 
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 1560.0333,-1638.6797,28.4881)
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 1992.71, -2130.70, 30.56)
			|| PlayerToPoint(50, playerid, 599.6600, -1490.9373, 82.4881) //fbi areszt
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 1559.8517,-1646.9373,28.4881)))
			{// Jail spot
			    sendTipMessageEx(playerid, COLOR_GREY, "Musisz by� przy celach aby kogo� zaaresztowa� !");
			    return 1;
			}
			new moneys, time, bail, bailprice;
			if( sscanf(params, "dddd", moneys, time, bail, bailprice))
			{
				sendTipMessage(playerid, "U�yj /paka [grzywna] [czas (minuty)] [kaucja (0=nie 1=tak)] [koszt kaucji]");
				return 1;
			}

			if(moneys < PRICE_GRZYWNA_MIN || moneys > PRICE_GRZYWNA_MAX) { sendTipMessageEx(playerid, COLOR_GREY, "Grzywna od "#PRICE_GRZYWNA_MIN"$ do "#PRICE_GRZYWNA_MAX"$!"); return 1; }
			if(time < 1 || time > 60) { sendTipMessageEx(playerid, COLOR_GREY, "Czas wi�zienia od 1 do 60 minut!"); return 1; }
			if(bail < 0 || bail > 1) { sendTipMessageEx(playerid, COLOR_GREY, "Kaucja musi by� 1(=nie) lub 2(=tak) !"); return 1; }
			if(bailprice < PRICE_KAUCJA_MIN || bailprice > PRICE_KAUCJA_MAX) { sendTipMessageEx(playerid, COLOR_GREY, "Koszt Kaucji od "#PRICE_KAUCJA_MIN"$ do "#PRICE_KAUCJA_MAX"$!"); return 1; }
			new suspect = GetClosestPlayer(playerid);
			if(IsPlayerConnected(suspect))
			{
				if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
				{
					GetPlayerName(suspect, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(PoziomPoszukiwania[suspect] < 1)
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Gracz musi by� poszukiwany (u�yj na nim /su) !");
					    return 1;
					}
					//format(string, sizeof(string), "* Aresztowany %s !", giveplayer);
					//SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    new depo2 = floatround(float(moneys) * 0.8, floatround_round); // sejf
                    new depo3 = floatround(float(moneys) * 0.2, floatround_round); //pd
					if(IsAFBI(playerid)){
						DajKaseDone(playerid, depo3+100);
						format(string, sizeof(string), "Uwi�zi�e� %s, nagroda za przest�pc�: %d. Otrzymujesz $%d", giveplayer, moneys, depo3+100);
						Sejf_Add(PlayerInfo[playerid][pGrupa][OnDuty[playerid]-1], depo2+150);
					}
					else{
						DajKaseDone(playerid, depo3);
						format(string, sizeof(string), "Uwi�zi�e� %s, nagroda za przest�pc�: %d. Otrzymujesz $%d", giveplayer, moneys, depo3);
						Sejf_Add(PlayerInfo[playerid][pGrupa][OnDuty[playerid]-1], depo2);
					}
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					ZabierzKaseDone(suspect, moneys);
                    poscig[suspect] = 0;
					format(string, sizeof(string), "Aresztowany przez %s ~n~    grzywna $%d", sendername, moneys);
					GameTextForPlayer(suspect, string, 5000, 5);
					//RemovePlayerWeaponsTemporarity(suspect);
					if(IsPlayerInGroup(playerid, 1))
					{
						format(string, sizeof(string), "<< Policjant %s aresztowa� podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					else if(IsPlayerInGroup(playerid, 2)||PlayerInfo[playerid][pLider]==2)
					{
						format(string, sizeof(string), "<< Agent FBI %s aresztowa� podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					else if(IsPlayerInGroup(playerid, 3)||PlayerInfo[playerid][pLider]==3)
					{
						format(string, sizeof(string), "<< Funkcjonariusz %s aresztowa� podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					Kajdanki_JestemSkuty[suspect] = 0;//Kajdany
					Kajdanki_Uzyte[suspect] = 0;
					Kajdanki_PDkuje[playerid] = 0;
					Kajdanki_Uzyte[playerid] = 0;
					ClearAnimations(suspect);
					SetPlayerSpecialAction(suspect,SPECIAL_ACTION_NONE);
					RemovePlayerAttachedObject(suspect, 0);
					Kajdanki_PDkuje[suspect] = 0;
					SetPlayerInterior(suspect, 10);
					if(IsAFBI(playerid)){
						new losuj= random(sizeof(CelaFBI));
						SetPlayerPos(suspect, CelaFBI[losuj][0], CelaFBI[losuj][1], CelaFBI[losuj][2]);
					}else{
						new losuj= random(sizeof(Cela));
						SetPlayerPos(suspect, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
					}
					PlayerInfo[suspect][pJailTime] = time * 60;
					if(bail == 1)
					{
						JailPrice[suspect] = bailprice;
                        SetPVarInt(suspect, "kaucja-dlaKogo", 1);
						format(string, sizeof(string), "Zosta�e� uwi�ziony na %d sekund.   Kaucja: $%d", PlayerInfo[suspect][pJailTime], JailPrice[suspect]);
						SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
					}
					else
					{
					    JailPrice[suspect] = 0;
						format(string, sizeof(string), "Zosta�e� uwi�ziony na %d sekund.   Kaucja: Niedost�pna", PlayerInfo[suspect][pJailTime]);
						SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
					}
					PlayerInfo[suspect][pJailed] = 1;
			        PlayerInfo[suspect][pArrested] += 1;
					PoziomPoszukiwania[suspect] = 0;
					SetPlayerWantedLevel(suspect, 0);
					WantLawyer[suspect] = 1;
				}//distance
			}//not connected
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie jest wystarczaj�co blisko ciebie aby� m�g� kogo� aresztowa�.");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie masz 3 rangi / nie jeste� z PD/FBI/NG !");
		    return 1;
		}
	}//not connected
	return 1;
}
