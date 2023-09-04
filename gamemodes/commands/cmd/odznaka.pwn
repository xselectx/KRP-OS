//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ odznaka ]------------------------------------------------//
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

YCMD:odznaka(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new giveplayerid, slot;
		if(sscanf(params, "k<fix>d", giveplayerid, slot))
		{
			sendTipMessage(playerid, "U¿yj /odznaka [id gracza] [slot]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if(slot < 1 || slot > MAX_PLAYER_GROUPS) return sendErrorMessage(playerid, sprintf("Slot od 1 do %d", MAX_PLAYER_GROUPS));
				if(PlayerInfo[playerid][pGrupa][slot-1] == 0) return sendErrorMessage(playerid, "Nie jesteœ w ¿adnej grupie na tym slocie!");
				if (ProxDetectorS(5.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{
					new string[64], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new grupaUID = GetPlayerGroupUID(playerid, slot-1);
					if(GroupHavePerm(grupaUID, PERM_POLICE))
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("|______________ Odznaka %s _____________|", GroupInfo[grupaUID][g_ShortName]));
						format(string, sizeof(string), "Numer odznaki: %d%d%d%d", grupaUID, PlayerInfo[playerid][pSex], GetPhoneNumber(playerid), PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", GroupRanks[grupaUID][PlayerInfo[playerid][pGrupaRank][slot-1]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] != slot)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("|_____ %s _____|", GroupInfo[grupaUID][g_Name]));
					}
					else if(GroupHavePerm(grupaUID, PERM_LEGALGUNDEALER))
					{
						SendClientMessage(giveplayerid, COLOR_GREEN, "|______________ Dokumenty GS ______________|");
						format(string, sizeof(string), "Numer seryjny: %d%d%d", PlayerInfo[playerid][pSex], GetPhoneNumber(playerid), PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Stopieñ: [%d]", PlayerInfo[playerid][pGrupaRank][slot-1]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						SendClientMessage(giveplayerid,COLOR_WHITE,"* Upowa¿nia do posiadania materia³ów i sprzeda¿y broni");
						SendClientMessage(giveplayerid,COLOR_RED,"* Nie upowa¿nia do posiadania broni ciê¿kiej");
						SendClientMessage(giveplayerid, COLOR_GREEN, "|_________________ Gunshop ________________|");
					}
					else if(GroupHavePerm(grupaUID, PERM_MEDIC) || GroupHavePerm(grupaUID, PERM_FIREDEPT))
					{
						SendClientMessage(giveplayerid, COLOR_ALLDEPT, sprintf("|______________ Identyfikator %s ______________|", GroupInfo[grupaUID][g_ShortName]));
						format(string, sizeof(string), "Numer identyfikatora: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], GroupPlayerDutyRank(playerid), GetPhoneNumber(playerid), PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", GroupRanks[grupaUID][PlayerInfo[playerid][pGrupaRank][slot-1]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Identyfikator uprawnia do uczestniczenia w akcjach");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"s³u¿b. porz. oraz dowództwo w zakresie ochrony zdrowia");
						SendClientMessage(giveplayerid, COLOR_ALLDEPT, sprintf("|____ %s ____|", GroupInfo[grupaUID][g_Name]));
					}
					else if (grupaUID == FAMILY_SAD)
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|______________ Legitymacja SCoSA _____________|");
						format(string, sizeof(string), "Imiê i nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", GroupRanks[grupaUID][PlayerInfo[playerid][pGrupaRank][slot-1]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(PlayerInfo[playerid][pGrupaRank][slot-1] > 3)
						{
							SendClientMessage(giveplayerid,COLOR_GREEN,"TA OSOBA POSIADA IMMUNITET!");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_RED,"TA OSOBA NIE POSIADA IMMUNITETU!");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|______________ Legitymacja SCoSA _____________|");
					}
					else if (GroupHavePerm(grupaUID, PERM_GOV))
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|___________ Legitymacja Urzêdu Miasta __________|");
						format(string, sizeof(string), "Imiê i nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Stopieñ: %s", GroupRanks[grupaUID][PlayerInfo[playerid][pGrupaRank][slot-1]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(PlayerInfo[playerid][pGrupaRank][slot-1] > 7)
						{
							SendClientMessage(giveplayerid,COLOR_GREEN,"TA OSOBA POSIADA IMMUNITET!");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_RED,"TA OSOBA NIE POSIADA IMMUNITETU!");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|_____________ Podpis: Burmistrz & Posiadacz __________|");
					}
					else
					{
						return sendErrorMessage(playerid, "Ta grupa nie posiada odznaki!");
					}
					//
					format(string, sizeof(string), "* %s pokazuje dokumenty %s.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
			sendErrorMessage(playerid, "Gracz jest OFFLINE!");
			return 1;
		}
	}
	return 1;
}
