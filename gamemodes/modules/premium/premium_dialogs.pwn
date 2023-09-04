//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  premium                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*

*/

//

//-----------------<[ Dialogi: ]>-------------------
premium_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == PREMIUM_DIALOG(MENU))
	{
		return 1;
	}
	//------------------ MENU DIALOG OPTIONS ------------------
	else if(dialogid == PREMIUM_DIALOG(KUP_KP))
	{
		if(response)
		{
			if((PremiumInfo[playerid][pKP] && PremiumInfo[playerid][pMC] >= PRZEDLUZ_KP_CENA) || PremiumInfo[playerid][pMC] >= MIESIAC_KP_CENA)
			{
				if(IsPlayerPremium(playerid)) 
				{
					PrzedluzKP(playerid);
					DialogMenuDotacje(playerid);
				}
				else
				{
					KupKP(playerid);
					DialogMenuDotacje(playerid);
				}
			}
			else
			{
				_MruGracz(playerid, "Nie masz wystarczaj�cej ilo�ci Kotnik Coin'�w aby przed�u�y�/zakupi� konto premium!");
				DialogKupKP(playerid);
			}
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(DOTACJE))
	{
		DialogMenuDotacje(playerid);
	}
	//------------------ DIALOG US�UGI PREMIUM ------------------
	else if(dialogid == PREMIUM_DIALOG(LICYTACJE))
	{
		if(response)
		{
			//TODO: stworzy� licytacje
			SendClientMessage(playerid, -1, "W budowie.");
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(POJAZDY))
	{
		if(response)
		{
			if(!PlayerToPoint(10.0, playerid, 2132.0371,-1149.7332,24.2372))
			{
				_MruGracz(playerid, "Aby kupi� pojazd unikatowy musisz znajdowa� si� przy salonie aut.");
				DialogPojazdyPremium(playerid);
				return 1;
			}
			KupPojazdPremium(playerid, listitem);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(PRZEDMIOTY))
	{
		if(response)
		{
			if(!IsAtClothShop(playerid))
			{
				_MruGracz(playerid, "Aby kupi� unikatowy przedmiot, musisz znajdowa� si� w sklepie z ubraniami.");
				DialogPrzedmioty(playerid);
				return 1;
			}

			if(PlayerHasAttachedObject(playerid, PrzedmiotyPremium[listitem][Model]))
			{
				sendErrorMessage(playerid, "Masz ju� ten przedmiot!");
				return DialogPrzedmioty(playerid);
			}

			KupPrzedmiotPremium(playerid, listitem);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(SLOTY_POJAZDU))
	{
		if(response)
		{
			KupSlotPojazdu(playerid);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(ZMIANY_NICKU))
	{
		if(response)
		{
			KupZmianeNicku(playerid);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(SKINY))
	{
		if(response)
		{
			if(PlayerHasSkin(playerid, SkinyPremium[listitem][Model]))
			{
				sendErrorMessage(playerid, "Masz ju� ten skin!");
				return DialogSkiny(playerid);
			}

			if(!IsAtClothShop(playerid))
			{
				_MruGracz(playerid, "Aby kupi� unikatowy skin, musisz znajdowa� si� w sklepie z ubraniami.");
				DialogSkiny(playerid);
				return 1;
			}
			
			KupSkinPremium(playerid, listitem);
			DialogSkinyPremiumGracza(playerid);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(TELEFON))
	{
		if(response)
		{
			KupNumerTelefonu(playerid, inputtext);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(ZMIENSKIN))
	{
		if(response)
		{
			new skin = DynamicGui_GetDataInt(playerid, listitem);
			new param[4];
			valstr(param, skin);
			return RunCommand(playerid, "/premiumskin",  param); 
		}
		else
		{
			return 1;
		}
	}
	return 1;
}

DialogMenuDotacje(playerid)
{
	new string[1024], kpinfo[40] = ""#PREMIUM_EMBED2"Brak";
	if(IsPlayerPremium(playerid))
	{
		new date[3], null;
		TimestampToDate(PremiumInfo[playerid][pExpires],date[0],date[1],date[2],null, null, null, 2);
		format(kpinfo, sizeof(kpinfo), ""#PREMIUM_EMBED2"(Wygasa: %02d.%02d.%d)", date[2], date[1], date[0]);
	}

	format(string, sizeof(string), ""#HQ_COLOR_TEKST"Ilo�� KotnikCoins: \t\t"#PREMIUM_EMBED2"%d KC\n" \
		""#HQ_COLOR_TEKST"Konto Premium: \t\t%s", PremiumInfo[playerid][pMC], kpinfo);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(MENU), DIALOG_STYLE_LIST, "Premium", string, "Wybierz", "Wyjd�");
	return 1;
}

//------- MENU DIALOG ------------------
static DialogKupKP(playerid)
{
	new string[256];
	if(IsPlayerPremium(playerid))
		format(string, sizeof(string), "Mo�esz przed�u�y� konto premium o 30 dni za "INCOLOR_GREEN""#PRZEDLUZ_KP_CENA" Kotnik Coins�w\nCzy chcesz to zrobi�?");
	else
		format(string, sizeof(string), "Mo�esz kupi� konto premium na 30 dni za "INCOLOR_GREEN""#MIESIAC_KP_CENA" Kotnik Coins�w\nCzy chcesz to zrobi�?");
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(KUP_KP), DIALOG_STYLE_MSGBOX, "Premium - KP", string, "Tak", "Nie");
}

static stock DialogRynekMC(playerid) //TODO: stworzy� licytacje
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(RYNEK_MC), DIALOG_STYLE_LIST, "Premium - Rynek KC", 
		"Oferty kupna Kotnik Coin�w\n"\
		"Oferty sprzeda�y Kotnik Coin�w\n"\
		"Stw�rz ofert� kupna\n"\
		"Stw�rz ofert� sprzeda�y\n"\
		"Moje oferty\n"\
		"Historia transakcji",
	"Wybierz", "Wr��");
}

//------- US�UGI PREMIUM ------------------

DialogPojazdyPremium(playerid)
{
	new string[1590];
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
	{
		strcat(string, sprintf("%d\t%s~n~~g~%dKC\n", PojazdyPremium[i][Model], VehicleNames[PojazdyPremium[i][Model]-400], PojazdyPremium[i][Cena]));
	}
	string[strlen(string)-1] = '\0';
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(POJAZDY), DIALOG_STYLE_PREVIEW_MODEL, "Premium - Us�ugi - Pojazdy", string, "Kup", "Wstecz");
	sendTipMessageEx(playerid, COLOR_RED, "Uwaga klikni�cie w pojazd powoduje jego natychmiastowy zakup!"); 
	sendTipMessageEx(playerid, COLOR_RED, "Je�eli nie jeste� zdecydowany nie naciskaj w nazw� pojazdu."); 
	return 1;
}

DialogPrzedmioty(playerid)
{
	new substring[32];
	static string[MAX_PREMIUM_ITEMS * sizeof(substring)];

	if(isnull(string)) {
        for (new i; i < MAX_PREMIUM_ITEMS; i++) {
            format(substring, sizeof(substring), "%i\t~g~%dKC\n", PrzedmiotyPremium[i][Model], PrzedmiotyPremium[i][Cena]);
            strcat(string, substring);
        } 
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(PRZEDMIOTY), DIALOG_STYLE_PREVIEW_MODEL,
		"Premium - Us�ugi - Przedmioty",
		string,
		"Kup", "Wstecz"
	);
	return 1;
}

DialogSlotyPojazdu(playerid)
{
	new string[300];
	format(string, sizeof(string), "Aktualnie posiadasz "INCOLOR_WHITE"%d"INCOLOR_DIALOG" slot�w na pojazdy.\nMo�esz dokupi� dodatkowe sloty za Kotnik Coiny, lecz nie mo�esz posiada� wi�cej slot�w, ni� "INCOLOR_ORANGE""#MAX_CAR_SLOT""INCOLOR_DIALOG".\nKoszt 1 slota to "INCOLOR_GREEN""#CAR_SLOT_CENA""INCOLOR_DIALOG" Kotnik Coins.\nAby dokupi� slot, naci�nij"INCOLOR_WHITE"\"Kup\"", PlayerInfo[playerid][pCarSlots]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SLOTY_POJAZDU), DIALOG_STYLE_MSGBOX, "Premium - Us�ugi - Sloty", string, "Kup", "Wr��");
	return 1;
}

DialogZmianyNicku(playerid)
{
	new string[256];
	format(string, sizeof(string), "Aktualnie posiadasz "INCOLOR_WHITE"%d"INCOLOR_DIALOG" mo�liwo�ci zmiany nicku.\nMo�esz dokupi� dodatkowe zmiany nicku za Kotnik Coiny.\n\nKoszt 1 zmiany nicku to "INCOLOR_GREEN""#ZMIANA_NICKU_CENA""INCOLOR_DIALOG" Kotnik Coins.\nAby dokupi� slot, naci�nij"INCOLOR_WHITE"\"Kup\"", PlayerInfo[playerid][pZmienilNick]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIANY_NICKU), DIALOG_STYLE_MSGBOX, "Premium - Us�ugi - Zmiany nicku", string, "Kup", "Wr��");
	return 1;
}

DialogSkiny(playerid)
{
	new substring[32];
	static string[MAX_PREMIUM_SKINS * sizeof(substring)];

	if(isnull(string)) {
        for (new i; i < MAX_PREMIUM_SKINS; i++) {
            format(substring, sizeof(substring), "%i\t~g~%dKC\n", SkinyPremium[i][Model], SkinyPremium[i][Cena]);
            strcat(string, substring);
        } 
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SKINY), DIALOG_STYLE_PREVIEW_MODEL, 
		"Premium - Us�ugi - Skiny", 
		string,
		"Kup", "Wstecz"
	);
	return 1;
}

DialogSkinyPremiumGracza(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[5*MAX_PREMIUM_SKINS];

	VECTOR_foreach(v : VPremiumSkins[playerid])
	{
		new skin = MEM_get_val(v);
		strcat(list, sprintf("%d\n", skin));
		count++;
		DynamicGui_AddRow(playerid, 1, skin);
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz unikatowych skin�w.");

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIENSKIN), DIALOG_STYLE_PREVIEW_MODEL, "Premium - Twoje skiny", list, "Ustaw", "Wyjdz");

	return true;
}

DialogTelefon(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(TELEFON), DIALOG_STYLE_INPUT, "Premium - Us�ugi - Telefon", 
		"Aby ustawi� nowy numer telefonu, wpisz go w okienko ni�ej i naci�nij "INCOLOR_WHITE"\"Kup\""INCOLOR_DIALOG".\n"\
		"Ceny numer�w w zale�no�ci od ilo�ci cyfr:\n"\
		"1 cyfra - "INCOLOR_GREEN""#TELEFON_CENA_1" KC"INCOLOR_DIALOG"\n"\
		"2 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_2" KC"INCOLOR_DIALOG"\n"\
		"3 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_3" KC"INCOLOR_DIALOG"\n"\
		"4 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_4" KC"INCOLOR_DIALOG"\n"\
		"wi�cej ni� 4 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_5" KC"INCOLOR_DIALOG"\n",
	"Wybierz", "Wr��");
	return 1;
}