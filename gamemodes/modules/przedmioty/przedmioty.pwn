//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 przedmioty                                                //
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
// Autor: renosk
// Data utworzenia: 06.05.2021
//Opis:
/*
	System przedmiotów
*/

//

//-----------------<[ Funkcje: ]>-------------------

stock Item_Count(playerid)
{
	new count = 0;
	foreach(new i : PlayerItems[playerid])
	{
		if(Item[i][i_ValueSecret] == ITEM_NOT_COUNT)
			count += 1;
		else
			count += Item[i][i_Quantity];
	}
	return count;
}

stock GetPlayerItemLimit(playerid)
{
	new limit = MAX_ITEM_LIMIT;
	if(IsPlayerPremiumOld(playerid)) limit = MAX_ITEM_LIMIT_PREMIUM;
	return limit;
}

stock Item_Use(playerid, itemid)
{
	if(!IsItemConsumable(Item[itemid][i_ItemType])) return sendTipMessage(playerid, "Ten przedmiot jest niezu¿ywalny.");
	if(Item[itemid][i_Owner] != PlayerInfo[playerid][pUID] || Item[itemid][i_OwnerType] != ITEM_OWNER_TYPE_PLAYER)
		return sendErrorMessage(playerid, "Ten przedmiot nie nale¿y do Ciebie!");

	//if(Item[itemid][i_Used]) Item[itemid][i_Used] = 0;
	//else Item[itemid][i_Used] = 1;

	new limit = MAX_ITEM_LIMIT;
	if(IsPlayerPremiumOld(playerid)) limit = MAX_ITEM_LIMIT_PREMIUM;

	if(Item_Count(playerid) > limit) return SendClientMessage(playerid, COLOR_PANICRED, sprintf("Nie mo¿esz u¿yæ ¿adnego przedmiotu, poniewa¿ przekroczy³eœ limit (%d). Wyrzuæ/zniszcz jakiœ przedmiot z twojego ekwipunku.", limit));

	switch(Item[itemid][i_ItemType])
	{
		case ITEM_TYPE_PHONE:
			PhonePanel(playerid, itemid, true);
		case ITEM_TYPE_SPRUNK:
		{
			if(gettime() - GetPVarInt(playerid, "lastDamage") < 120)
				return sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ podczas walki!");
			new Float:hp;
			GetPlayerHealth(playerid, hp);
			if(hp > 70) return sendTipMessage(playerid, "Twoje HP musi spaœæ poni¿ej 70 hp!");
			hp += SPRUNK_HP;
			if(hp > 100) hp = 100;
			ProxDetector(10.0, playerid, sprintf("* %s wypija %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
			SetPlayerHealth(playerid, hp);
			SendClientMessage(playerid, COLOR_GREY, "	Dodano ci 30 hp.");
			Item_Delete(itemid);
		}
		case ITEM_TYPE_CBRADIO:
		{
			if(!Item[itemid][i_Used])
			{
				if(HasActiveItemType(playerid, ITEM_TYPE_CBRADIO) != -1)
					return ShowPlayerInfoDialog(playerid, "Informacja", "Taki typ przedmiotu jest ju¿ w u¿yciu!");
			}
			Item[itemid][i_Used] = !Item[itemid][i_Used];
			MSGBOX_Show(playerid, sprintf("CB-RADIO %s", (Item[itemid][i_Used]) ? ("~g~ON") : ("~r~OFF")), MSGBOX_ICON_TYPE_OK);
		}
		case ITEM_TYPE_MASKA:
		{
		if (GetPlayerAdminDutyStatus(playerid) == 1)
		{
			return sendErrorMessage(playerid, "Nie mo¿esz za³o¿yæ maski bêd¹c na AdminDuty!");
		}

		if (IsAFBI(playerid))
		{
			if (GroupRank(playerid, FRAC_FBI) < 1)
			{
				return sendErrorMessage(playerid, "Maska jest dostêpna od [1] rangi");
			}
		}
		else if (IsPlayerInGroup(playerid, FRAC_LSPD))
		{
			if (GroupRank(playerid, FRAC_LSPD) < 1)
			{
				return sendErrorMessage(playerid, "Maska jest dostêpna od [1] rangi");
			}
			else
			{
				if (OnDuty[playerid] < 1)
				{
					return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Najpierw u¿yj /duty !");
				}
				if (GetPlayerSkin(playerid) != 285)
				{
					return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "¯eby u¿yæ maski musisz mieæ skin SWAT (/swat)");
				}
			}
		}

		if (AntySpam[playerid] == 1)
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
			return 1;
		}

		SetTimerEx("AntySpamTimer", 5000, 0, "d", playerid);
		AntySpam[playerid] = 1;
		new string[64];
		new sendername[MAX_PLAYER_NAME];
		new nick[32];
		if (GetPVarString(playerid, "maska_nick", nick, 24))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga maskê z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			if (!IsAPolicja(playerid))
			{
				RemovePlayerAttachedObject(playerid, 1);
			}
			MSGBOX_Show(playerid, "~g~~h~Pokazano ~w~twarz", MSGBOX_ICON_TYPE_OK);
			SetPlayerName(playerid, nick);
			SetRPName(playerid);
			format(PlayerInfo[playerid][pNick], 24, "%s", nick);
			DeletePVar(playerid, "maska_nick");
		}
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new Float:X, Float:Y, Float:Z, pName[MAX_PLAYER_NAME];
			GetPlayerPos(playerid, X, Y, Z);
			format(string, sizeof(string), "* %s zak³ada maskê na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			if (!IsAPolicja(playerid) || !IsAFBI(playerid))
			{
				SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90); //maska hokeisty biala
			}
			MSGBOX_Show(playerid, "~r~~h~Ukryto ~w~twarz", MSGBOX_ICON_TYPE_OK);
			new maskid[6];
			GenString(maskid, sizeof(maskid));
			strToUpper(maskid);
			if (PlayerInfo[playerid][pSex] == 1)
			{
				format(pName, sizeof(pName), "Zamaskowany_%d", maskid);
			}
			else
			{
				format(pName, sizeof(pName), "Zamaskowana_%d", maskid);
			}
			if (SetPlayerName(playerid, pName))
			{
				//SetPlayerColor(playerid, COLOR_BLACK);
				SetRPName(playerid);
				format(PlayerInfo[playerid][pNick], 24, "%s", pName);
				SetPVarString(playerid, "maska_nick", sendername);
				Log(nickLog, WARNING, "Gracz %s za³o¿y³ maskê %s", GetPlayerLogName(playerid), pName);
				//sendErrorMessage(playerid, "OSTRZE¯ENIE: Nadu¿ywanie maski skutkuje natychmiastowym wyrzuceniem z frakcji.");
			}
		}
		}	    
		case ITEM_TYPE_WEAPON:
		{
			if(GetPVarInt(playerid, "mozeUsunacBronie") == 1) return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ broni do czasu zrespienia siê, u¿y³eœ /wb");
			//tymczasowe rozwiazanie
			SetWeaponValue(playerid, GetWeaponSlot(Item[itemid][i_Value1]), Item[itemid][i_Value1], Item[itemid][i_Value2], Item[itemid][i_ValueSecret]);
			GivePlayerWeapon(playerid, Item[itemid][i_Value1], Item[itemid][i_Value2]);
			SetPlayerArmedWeapon(playerid, Item[itemid][i_Value1]);
			va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Doda³eœ broñ %s [ammo: %d] do ekwipunku broni.", Item[itemid][i_Name], Item[itemid][i_Value2]);
			Item_Delete(itemid);
		}
		case ITEM_TYPE_ZDRAPKA:
		{
			if(!Zdrapka) return sendErrorMessage(playerid, "Zdrapki zosta³y wy³¹czone!");
			new string[248];
			if(PlayerGames[playerid] >= 4)
				return sendTipMessage(playerid, "Przepraszamy, przekroczy³eœ godzinny limit zdrapek! Spróbuj za godzinê."); 
			ProxDetector(20.0, playerid, sprintf("* %s zdrapuje zdrapkê", GetNick(playerid)),COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			new winValue = true_random(100);
			new playerValue = true_random(100);
			if(playerValue > winValue && playerValue >= 85)
			{
				format(string, sizeof(string), "Po zdrapaniu widaæ wygran¹ "#PRICE_ZDRAPKA_WIN3"$! ((%s))", GetNick(playerid));
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				DajKaseDone(playerid, PRICE_ZDRAPKA_WIN3); 
				format(string, sizeof(string), "ItemLog: Gracz %s zdrapa³ ze zdrapki "#PRICE_ZDRAPKA_WIN3"$", GetNick(playerid)); 
				ABroadCast(COLOR_LIGHTRED, string, 3000);
				Log(itemLog, WARNING, "%s zdrapuje ze zdrapki "#PRICE_ZDRAPKA_WIN3"$", GetPlayerLogName(playerid));
			}
			else if(playerValue > winValue && playerValue < 85 && playerValue >= 50)
			{
				format(string, sizeof(string), "Po zdrapaniu widaæ wygran¹ "#PRICE_ZDRAPKA_WIN2"$! ((%s))", GetNick(playerid));
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				DajKaseDone(playerid, PRICE_ZDRAPKA_WIN2); 
				format(string, sizeof(string), "ItemLog: Gracz %s zdrapa³ ze zdrapki "#PRICE_ZDRAPKA_WIN2"$", GetNick(playerid)); 
				ABroadCast(COLOR_LIGHTRED, string, 3000);
				Log(itemLog, WARNING, "%s zdrapuje ze zdrapki "#PRICE_ZDRAPKA_WIN2"$", GetPlayerLogName(playerid));
			}
			else if(playerValue < winValue && playerValue > 50)
			{
				format(string, sizeof(string), "Po zdrapaniu widaæ wygran¹ "#PRICE_ZDRAPKA_WIN1"$! ((%s))", GetNick(playerid));
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				DajKaseDone(playerid, PRICE_ZDRAPKA_WIN1); 
				format(string, sizeof(string), "ItemLog: Gracz %s zdrapa³ ze zdrapki "#PRICE_ZDRAPKA_WIN1"$", GetNick(playerid)); 
				ABroadCast(COLOR_LIGHTRED, string, 3000);
				Log(itemLog, WARNING, "%s zdrapuje ze zdrapki "#PRICE_ZDRAPKA_WIN1"$", GetPlayerLogName(playerid));
			}
			else
			{
				format(string, sizeof(string), "Po zdrapaniu widaæ napis ''Graj dalej'' ((%s))", GetNick(playerid));
				ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				Log(itemLog, WARNING, "%s zdrapuje ze zdrapki 0$", GetPlayerLogName(playerid));
			}
			PlayerGames[playerid]++;
			Item_Delete(itemid); 
		}
		case ITEM_TYPE_ALCOHOL:
		{
			ProxDetector(10.0, playerid, sprintf("* %s wypija %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			new rnd = random(2);
			if(rnd == 1) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
			else SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			PlayerInfo[playerid][pThirst] -= 10.0;
			Item_Delete(itemid);
		}
		case ITEM_TYPE_CIGARETTE:
		{
			ProxDetector(10.0, playerid, sprintf("* %s wyci¹ga z kieszeni %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
			Item_Delete(itemid);
		}
		case ITEM_TYPE_MP3:
		{
			ProxDetector(10.0, playerid, sprintf("* %s wyci¹ga MP3", GetNick(playerid)), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			return ShowPlayerDialogEx(playerid, DIALOGID_MUZYKA, DIALOG_STYLE_LIST, "Odtwarzacz MP3.","Kotnik Radio\n""SAN Radio kana³ 1\n""SAN Radio kana³ 2\n""Radio ZET\n""RMF FM\n""RMF MAXXX\n""Radio ESKA\n""Lepa Station\n""Radio Jasna Góra\n""W³asny stream\n""MP3 OFF","Start",""); //zmieñ dialogid
		}
		case ITEM_TYPE_KOSTKA:
		{
			new string[248];
			new dice = true_random(6)+1;
			format(string, sizeof(string), "*** %s rzuca kostk¹ i wypada liczba %d", GetNick(playerid),dice);
			ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
		}
		case ITEM_TYPE_APTECZKA: sendTipMessage(playerid, "U¿yj: /apteczka [id gracza]");
		case ITEM_TYPE_PHONEBOOK: sendTipMessage(playerid, "U¿yj: /numer [numer telefonu]");
		case ITEM_TYPE_TEMPOMAT: sendTipMessage(playerid, "Wciœnij 2 podczas jazdy, ¿eby aktywowaæ tempomat. Aby zwiêkszyæ prêdkoœæ auta wciœnij strza³kê w górê, zmniejszanie strza³k¹ w dó³.");
		case ITEM_TYPE_FOOD:
		{
			if(PlayerInfo[playerid][pHunger] < 3.0) return sendTipMessage(playerid, "Nie jesteœ g³odny!");
			if(Item[itemid][i_Value2] <= 0) return sendTipMessage(playerid, "Ten produkt nie nadaje siê do spo¿ycia!");
			ProxDetector(10.0, playerid, sprintf("* %s zjada %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);
			PlayerInfo[playerid][pHunger] -= float(Item[itemid][i_Value2]);

			SetPlayerDrunkLevel(playerid, 2000);
			Item_Delete(itemid);

			if(gettime() - GetPVarInt(playerid, "lastDamage") > 120)
			{
				new Float:hp;
				GetPlayerHealth(playerid, hp);
				if(hp + 20 > 100) return 1;
				SetPlayerHealth(playerid, hp + 20);
			}
		}
		case ITEM_TYPE_DRINK:
		{
			if(PlayerInfo[playerid][pThirst] < 3.0) return sendTipMessage(playerid, "Ten przedmiot jest Ci aktualnie niepotrzebny.");
			if(Item[itemid][i_Value2] <= 0) return sendTipMessage(playerid, "Ten produkt nie nadaje siê do spo¿ycia!");
			ProxDetector(10.0, playerid, sprintf("* %s wypija %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
			PlayerInfo[playerid][pThirst] -= float(Item[itemid][i_Value2]);
			SetPlayerDrunkLevel(playerid, 2000);
			Item_Delete(itemid);
		}
		case ITEM_TYPE_ATTACH:
		{
			if(!Item[itemid][i_Used])
			{
				new query[200], Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz;
				mysql_query_format("SELECT `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz` FROM `mru_attached` WHERE `UID` = '%d'", Item[itemid][i_UID]);
				mysql_store_result();
				new index = 0, limit_i = 8;
				if(IsPlayerPremiumOld(playerid)) limit_i = 10;
				for(new i = 5; i < limit_i; i++)
				{
					if(PlayerInfo[playerid][pAttached][i] == 0 && !IsPlayerAttachedObjectSlotUsed(playerid, i))
					{
						index = i;
						break;
					}
				}
				if(index==0) return sendErrorMessage(playerid, "Brak wolnego slotu.");
				if(mysql_num_rows())
				{
					mysql_fetch_row_format(query);
					sscanf(query, "p<|>fffffffff", x, y, z, rx, ry, rz, sx, sy, sz);
					SetPlayerAttachedObject(playerid, index, Item[itemid][i_Value1], Item[itemid][i_Value2], x, y, z, rx, ry, rz, sx, sy, sz);
				}
				else SetPlayerAttachedObject(playerid, index, Item[itemid][i_Value1], Item[itemid][i_Value2]);
				PlayerInfo[playerid][pAttached][index] = Item[itemid][i_UID];
				EditAttachedObject(playerid, index);
				SetPVarInt(playerid, "Editing-AttachedObject", 1);
				Item[itemid][i_Used] = 1;
				Item[itemid][i_tmpValue] = index;
				mysql_free_result();
			}
			else
			{
				for(new i = 0; i < 10; i++)
				{
					if(PlayerInfo[playerid][pAttached][i] == Item[itemid][i_UID])
					{
						RemovePlayerAttachedObject(playerid, i);
						sendTipMessage(playerid, "Obiekt zosta³ zdjêty.");
						Item[itemid][i_Used] = 0;
						Item[itemid][i_tmpValue] = 0;
						PlayerInfo[playerid][pAttached][i] = 0;
						return 1;
					}
				}
			}
		}
		case ITEM_TYPE_SKIN:
		{
			if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
			{
				sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");
				return 1;
			}
			if(IsPlayerInAnyVehicle(playerid))
				return sendErrorMessage(playerid, "Nie mo¿esz siê przebraæ w pojeŸdzie!");
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(!Item[itemid][i_Used])
			{
				if(HasActiveItemType(playerid, ITEM_TYPE_SKIN) != -1)
					return ShowPlayerInfoDialog(playerid, "Informacja", "Taki typ przedmiotu jest ju¿ w u¿yciu!");
				SetPlayerSkin(playerid, Item[itemid][i_Value1]);
				//PlayerInfo[playerid][pModel] = Item[itemid][i_Value1];
				ProxDetector(5.0, playerid, sprintf("** %s przebiera siê.", GetNick(playerid)), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				Item[itemid][i_Used] = 1;
				SetSpawnInfo(playerid, 0, Item[itemid][i_Value1], x, y, z, 0.0, 0, 0, 0, 0, 0, 0);
			}
			else
			{
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				ProxDetector(5.0, playerid, sprintf("** %s przebiera siê.", GetNick(playerid)), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				Item[itemid][i_Used] = 0;
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], x, y, z, 0.0, 0, 0, 0, 0, 0, 0);
			}
		}
		case ITEM_TYPE_VAPE:
		{
			if(GetPVarInt(playerid, "UsingEKiep") == 0 && Item[itemid][i_Used] == 0)
			{
				if(HasActiveItemType(playerid, ITEM_TYPE_VAPE) != -1)
					return ShowPlayerInfoDialog(playerid, "Informacja", "Taki typ przedmiotu jest ju¿ w u¿yciu!");
				Item[itemid][i_Used] = 1;
				sendTipMessage(playerid, sprintf("Aby u¿yæ %s wciœnij prawy przycisk myszki.", Item[itemid][i_Name]));
				SetPlayerAttachedObject(playerid, 7, -2000, 6, 0.04, 0.0, 0.07);
				SetPVarInt(playerid, "UsingEKiep", 1);
				SetPVarInt(playerid, "CanUseItem", 1);
				SetPVarInt(playerid, "EkiepItemID", itemid);
	
				SetPlayerChatBubble(playerid, sprintf("* bierze %s *", Item[itemid][i_Name]), COLOR_PURPLE, 15.0, 7500);
			} 
			else
			{
				Item[itemid][i_Used] = 0;
				sendTipMessage(playerid, sprintf("Odk³adasz %s", Item[itemid][i_Name]));
				RemovePlayerAttachedObject(playerid, 7);
				SetPVarInt(playerid, "UsingEKiep", 0);
				SetPVarInt(playerid, "CanUseItem", 1);
				SetPVarInt(playerid, "PuszczaChmure", 0);
	
				SetPlayerChatBubble(playerid, sprintf("* odk³ada %s *", Item[itemid][i_Name]), COLOR_PURPLE, 15.0, 7500);
			}
		}
		case ITEM_TYPE_MARIHUANA:
		{
			//new String[256];
			new tekst[300];
			if(nPlayer[playerid][pPodWplywem] != 1)
			{
				// INFORMACJE
				//format(String, sizeof(String),"* wyjmuje z kieszeni skrêta po czym zapala go. (( "ME"(%d) %s "DO"))",playerid,GetPlayerNNick(playerid));
				GameTextForPlayer(playerid,"~g~Zazyles ~p~narkotyk...", 10000, 1);
				strcat(tekst, ""C_SZARY"Postanawiasz zapalaæ skrêta "C_ZIELONY"(narkotyk)"C_SZARY".\n");
				strcat(tekst, ""C_SZARY"Po zapaleniu skrêta Twoja postaæ dostaje urojeñ.\n");
				strcat(tekst, ""C_SZARY"Zwiêksza siê stan Twojego"C_CZERWONY" zdrowia"C_SZARY".\n");
				ShowPlayerDialogEx(playerid, DIALOG_NMENU, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Zapalasz skrêta:", tekst, "Okej", "");
				// USTAWIENIA
				SetPlayerWeather(playerid, -66); // Ustawia pogode.
				SetPlayerTime(playerid,12,00); // Ustawia czas na 12.00
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY); // Animacja.
				SetTimerEx("zwyklyStan", 180000, false, "i", playerid); // Likwiduje stan "na haju" po czasie: 3min.
				nPlayer[playerid][pZuzyl] += 1; // Dodaje zuzyty narkotyk.
				nPlayer[playerid][pPodWplywem] = 1; // Ustawia, ¿e nasz gracz jest pod wp³ywem narkotyku. || 1 - Pod wp³ywem, 0 - Czysty.
				nPlayer[playerid][pTimerKill] = 0;
				SetTimerEx("healthRegen", hpRegenDelay * 1000, false, "i", playerid); // ustawia timer do regeneracji HP
				Item_Delete(itemid);
			}
			else
			{
				format(tekst, sizeof(tekst), ""C_SZARY"Twoja postaæ jest ju¿ pod wp³ywem nieznanej substancji..\n");
				ShowPlayerDialogEx(playerid, DIALOG_NUZYL, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Ju¿ spo¿y³eœ nieznan¹ substancjê:", tekst, "Okej", "");
			}
			return 1;
		}
		case ITEM_TYPE_KRZAK:
		{
			new plantacja_count = 0;
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i : I_Plantacja)
			{
				if(Plantacja[i][p_Owner] == PlayerInfo[playerid][pUID]) plantacja_count++;
				if(GetDistanceBetweenPoints(X, Y, Z, Plantacja[i][p_Pos][0], Plantacja[i][p_Pos][1], Plantacja[i][p_Pos][2]) < 3.1)
					return sendErrorMessage(playerid, "Znajdujesz siê za blisko jakiejœ plantacji!");
			}

			if(plantacja_count >= MAX_PLANTACJA_PLAYER) 
				return sendErrorMessage(playerid, "Nie mo¿esz mieæ wiêcej ni¿ "#MAX_PLANTACJA_PLAYER" plantacji!");
			if(GetPlayerInterior(playerid) != 0)
				return sendErrorMessage(playerid, "Nie mo¿esz zasiaæ plantacji w pomieszczeniu.");
			if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
				return sendErrorMessage(playerid, "Musisz byæ pieszo, aby zasadziæ plantacjê.");

		
			if(!IsAPrzestepca(playerid, 0)) return noAccessMessage(playerid);
			new id = Iter_Free(I_Plantacja);
			if(id == -1) return sendErrorMessage(playerid, "Na serwerze jest ju¿ zasadzone zbyt du¿o plantacji, musisz poczekaæ chwilê.");
			
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0); // Animacja.
			SetTimerEx("ZbierzUP3DText", 900000, false, "i", id);
			Plantacja[id][p_Object] = CreateDynamicObject(862, X, Y, Z-1.0, 0, 0, 0); // Pobiera pozycje + tworzy obiekt roœliny prze graczem.
			new output[256];
			format(output, sizeof(output), ""C_ZIELONY"Plantacja roœliny\n"C_SZARY"Nie mo¿esz jeszcze zebraæ roœliny!\n"C_SZARY"Zasadzona przez: %s\nID: %d", GetNick(playerid), id);
			//Plantacja[id][p_Label] = CreateDynamic3DTextLabel(output,0xC0C0C0FF,X,Y,Z,20.0); // Tworzy 3D Text na plantacji.
			UpdateDynamic3DTextLabelText(Plantacja[id][p_Label], 0xC0C0C0FF, output);
			Streamer_SetItemPos(STREAMER_TYPE_3D_TEXT_LABEL, Plantacja[id][p_Label], X, Y, Z);
			Plantacja[id][p_Pos][0] = X;
			Plantacja[id][p_Pos][1] = Y;
			Plantacja[id][p_Pos][2] = Z;
			Plantacja[id][p_Owner] = PlayerInfo[playerid][pUID];
			Plantacja[id][p_CanGather] = false;
			Iter_Add(I_Plantacja, id);
			Item_Delete(itemid);
			TextDrawInfoOn(playerid,"~y~Plantacja~w~ zostala posadzona~n~Plony beda gotowe do zbioru za ~y~15~w~ minut~n~Nie wychodz do tego czasu z ~y~serwera!",8000);
			FirstDrugs(playerid);
		}
		case ITEM_TYPE_DYM:
		{
			new Float:playerPos[3], tmpstring[256];
			GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
			new slot = FindEmptySlot();
			if(slot == -1) return SendClientMessage(playerid, COLOR_WHITE, "Limit urzadzenia do dymu (10) zostal usiagniety, usun kilka wpisujac /usundym <1-10>");
			format(tmpstring, sizeof(tmpstring), "Pomyslnie polozyles urzadzenie do dymu! (ID: %i)", FindEmptySlot() + 1);
			SendClientMessage(playerid, COLOR_WHITE, tmpstring);
			PlantedSmokes[slot] = CreateDynamicObject(2780, playerPos[0], playerPos[1], playerPos[2] - 1, 0, 0, 0);

			Item_Delete(itemid);
			g_SmokeTimers[slot] = SetTimerEx("RemoveSmokeObject", 30000, false, "d", slot);
			
			return 1;
		}
		case ITEM_TYPE_FLARA:
		{
			new Float:playerPos[3], tmpstring[256];
			GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,0,1);
			new slot = FindEmptySlot1();
			if(slot == -1) return SendClientMessage(playerid, COLOR_WHITE, "Limit flary (10) zostal usiagniety, usun kilka wpisujac /usundym <1-10>");
			format(tmpstring, sizeof(tmpstring), "Pomyslnie polozyles flare (ID: %i)", FindEmptySlot1() + 1);
			SendClientMessage(playerid, COLOR_WHITE, tmpstring);
			PlantedFlares[slot] = CreateDynamicObject(18728, playerPos[0], playerPos[1], playerPos[2] - 1, 0, 0, 0);
			
			Item_Delete(itemid);
			g_FlareTimers[slot] = SetTimerEx("RemoveFlareObject", 30000, false, "d", slot);
			
			return 1;
		}
		case ITEM_TYPE_DESKOROLKA:
		{
			if(BlockDeska[playerid] == 1) return SendClientMessage(playerid,COLOR_BIALY,"Nie mo¿esz teraz u¿yæ tej komendy!.");
			if(!IsPlayerInAnyVehicle(playerid)){
				ApplyAnimation(playerid, "CARRY","null",0,0,0,0,0,0,0);
				ApplyAnimation(playerid, "SKATE","null",0,0,0,0,0,0,0);
				ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
				SetPlayerArmedWeapon(playerid,0);
				if(!InfoSkate[playerid][sActive]){
					InfoSkate[playerid][sActive] = true;
					DestroyObject(InfoSkate[playerid][sSkate]);
					RemovePlayerAttachedObject(playerid,INDEX_SKATE);
					#if TYPE_SKATE == 0
					SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,6,-0.055999,0.013000,0.000000,-84.099983,0.000000,-106.099998,1.000000,1.000000,1.000000);
					#else
					// the skate is placed in the back
					SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,1,0.055999,-0.173999,-0.007000,-95.999893,-1.600010,24.099992,1.000000,1.000000,1.000000);
					#endif
					PlayerPlaySound(playerid,21000,0,0,0);
				}else{
					InfoSkate[playerid][sActive] = false;
					DestroyObject(InfoSkate[playerid][sSkate]);
					RemovePlayerAttachedObject(playerid,INDEX_SKATE);
					PlayerPlaySound(playerid,21000,0,0,0);
				}
			}else SendClientMessage(playerid,-1,"{FFFFFF}INFO: {00B7FF}Nie mo¿esz jeŸdziæ na desce w samochodzie{FFFFFF}!.");
			return true;
		}
		case ITEM_TYPE_ZEGAREK:
		{
			SendClientMessage(playerid, KOLOR_BIALY, "Tego itemu nie da siê u¿yæ");		
		}
		case ITEM_TYPE_LANCUSZEK:
		{
			SendClientMessage(playerid, KOLOR_BIALY, "Tego itemu nie da siê u¿yæ");			
		}
		case ITEM_TYPE_KAWALEKM4:
		{
			SendClientMessage(playerid, KOLOR_BIALY, "Tego itemu nie da siê u¿yæ");			
		}
	    case ITEM_TYPE_KAWALEKAK:
		{
			SendClientMessage(playerid, KOLOR_BIALY, "Tego itemu nie da siê u¿yæ");			
		}
		case ITEM_TYPE_WYTRYCH:
		{
			new string[128];
			new sendername[MAX_PLAYER_NAME];

			if(IsPlayerConnected(playerid))
			{
				if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
					if(Car_IsValid(GetPlayerVehicleID(playerid)))
					{
						return sendTipMessageEx(playerid, COLOR_GRAD2, "Tego pojazdu nie da siê ukraœæ, poniewa¿ jest z wypo¿yczalni!");
					}
					
					if(NieSpamujKradnij[playerid] == 0)
					{
						if(Iter_Contains(StolenVehicles[playerid], GetPlayerVehicleID(playerid)))
						{
							sendErrorMessage(playerid, "Ju¿ ukrad³eœ ten wóz.");
							return 1;
						}
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string),"* %s wyci¹ga m³otek i rozwala os³onkê po czym wyjmuje 2 kabelki.", sendername);
						ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						NieSpamujKradnij[playerid] = 1;
						KradziezTick[playerid] = gettime()+6;
						KradziezEtap[playerid] = 1;
						KradniecieWozu[playerid] = INVALID_VEHICLE_ID;
						Item_Delete(itemid);
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Ju¿ próbujesz ukraœæ wóz !");
					}
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w pojeŸdzie !");
				}
			}
		}
		default: sendTipMessage(playerid, "Nie mo¿esz u¿yæ tego przedmiotu.");
	}
	SaveItem(itemid);
	return 1;
}

stock Item_Drop(playerid, itemid)
{
	if(!CanDrop(Item[itemid][i_ItemType], itemid)) return sendTipMessage(playerid, "Nie mo¿esz wyrzuciæ tego przedmiotu.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Nie mo¿esz tego teraz zrobiæ.");
	if(GetPVarInt(playerid, "Offering-ItemID") == itemid) return sendErrorMessage(playerid, "Nie mo¿esz teraz wyrzuciæ tego przedmiotu!");

	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);
	z-=0.8;

	Iter_Remove(PlayerItems[playerid], itemid);

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);

	ProxDetector(10.0, playerid, sprintf("* %s odk³ada przedmiot %s na ziemiê", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);

	Log(itemLog, WARNING, "%s wyrzuca przedmiot %s na ziemiê", GetPlayerLogName(playerid), GetItemLogName(itemid));

	if(Item[itemid][i_ItemType] == ITEM_TYPE_ATTACH && IsPlayerAttachedObjectSlotUsed(playerid, Item[itemid][i_tmpValue])) {
		RemovePlayerAttachedObject(playerid, Item[itemid][i_tmpValue]);
		PlayerInfo[playerid][pAttached][Item[itemid][i_tmpValue]] = 0;
	}
	else if(Item[itemid][i_ItemType] == ITEM_TYPE_SKIN)
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	else if(Item[itemid][i_ItemType] == ITEM_TYPE_VAPE)
	{
		RemovePlayerAttachedObject(playerid, 7);
		SetPVarInt(playerid, "UsingEKiep", 0);
		SetPVarInt(playerid, "CanUseItem", 1);
		SetPVarInt(playerid, "PuszczaChmure", 0);
	}

	Item[itemid][i_3DText] = CreateDynamic3DTextLabel(sprintf("(ID: %d) %s x%d", itemid, Item[itemid][i_Name], Item[itemid][i_Quantity]), COLOR_WHITE, x, y, z, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw, int);
	Item[itemid][i_Pos][0] = x;
	Item[itemid][i_Pos][1] = y;
	Item[itemid][i_Pos][2] = z;
	Item[itemid][i_VW] = vw;
	Item[itemid][i_INT] = int;
	Item[itemid][i_OwnerType] = ITEM_OWNER_TYPE_DROPPED;
	Item[itemid][i_Dropped] = 1;
	Item[itemid][i_Used] = 0;

	//mysql_query_format("UPDATE `mru_items` SET `X` = '%f', `Y` = '%f', `Z` = '%f', `vw` = '%d', `int` = '%d', `owner_type` = '%d', `dropped` = '1' WHERE UID = '%d'", x, y, z, vw, int, Item[itemid][i_OwnerType], Item[itemid][i_UID]);
	SaveItem(itemid);
	return 1;
}

stock Item_Destroy(playerid, itemid, action = 0, quantity = 65535)
{
	if(Item[itemid][i_ItemType] == ITEM_TYPE_VAPE)
	{
		RemovePlayerAttachedObject(playerid, 7);
		SetPVarInt(playerid, "UsingEKiep", 0);
		SetPVarInt(playerid, "CanUseItem", 1);
		SetPVarInt(playerid, "PuszczaChmure", 0);
	}
	if(quantity == 65535) quantity = Item[itemid][i_Quantity];
	if(action) ProxDetector(30.0, playerid, sprintf("* %s niszczy przedmiot %dx %s", GetNick(playerid), quantity, Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	Log(itemLog, WARNING, "%s niszczy przedmiot %s", GetPlayerLogName(playerid), GetItemLogName(itemid));
	Item_Delete(itemid, true, quantity);
	return 1;
}

stock Item_Delete(itemid, bool:frommysql = true, quantity = 1, bool:fromiter = true)
{
	new playerid = INVALID_PLAYER_ID;
	if(Item[itemid][i_OwnerType] == ITEM_OWNER_TYPE_PLAYER)
		playerid = GetPlayerIDFromUID(Item[itemid][i_Owner]);
	new bool:delete = true;
	if(IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID)
	{
		if(Iter_Contains(PlayerItems[playerid], itemid))
		{
			if(quantity != Item[itemid][i_Quantity])
			{
				delete = false;
				Item[itemid][i_Quantity] -= quantity;
				if(Item[itemid][i_Quantity]<=0) {
					if(fromiter) Iter_Remove(PlayerItems[playerid], itemid);
					Item[itemid][i_Quantity] = 0;
					delete = true;
				}
			}
			else if(fromiter)
				Iter_Remove(PlayerItems[playerid], itemid);
			if(Item[itemid][i_Used])
			{
				if(Item[itemid][i_ItemType] == ITEM_TYPE_ATTACH && IsPlayerAttachedObjectSlotUsed(playerid, Item[itemid][i_tmpValue])) { 
					RemovePlayerAttachedObject(playerid, Item[itemid][i_tmpValue]);
					PlayerInfo[playerid][pAttached][Item[itemid][i_tmpValue]] = 0;
				}
				else if(Item[itemid][i_ItemType] == ITEM_TYPE_SKIN)
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			}
		}
	}
	if(!delete) return 0;
	if(fromiter)  Iter_Remove(Items, itemid);
	if(frommysql) mysql_query(sprintf("DELETE FROM `mru_items` WHERE UID = '%d'", Item[itemid][i_UID]));
	if(IsValidDynamic3DTextLabel(Item[itemid][i_3DText])) DestroyDynamic3DTextLabel(Item[itemid][i_3DText]);
	Item[itemid][i_UID] = 0;
	Item[itemid][i_Used] = 0;
	Item[itemid][i_ValueSecret] = 0;
	return 1;
}

stock Item_Add(name[], owner_type, owner, type, value1, value2, bool:insertinto = true, forplayer = INVALID_PLAYER_ID, quantity = 1, secretValue = 0)
{
	new id = Iter_Free(Items);
	if(id == -1) return -1;
	if(forplayer != INVALID_PLAYER_ID && IsPlayerConnected(forplayer)) 
	{
		//³¹czenie przedmiotów
		new has = HasItemType(forplayer, type);
		if(has != -1)
		{
			if(!strcmp(Item[has][i_Name], name, true) && Item[has][i_Value1] == value1 && Item[has][i_Value2] == value2 && Item[has][i_ValueSecret] == secretValue)
			{
				Item[has][i_Quantity] += quantity;
				SaveItem(has);
				return 1;
			}
		}
		new limit = MAX_ITEM_LIMIT;
		if(IsPlayerPremiumOld(forplayer)) limit = MAX_ITEM_LIMIT_PREMIUM;
		if(Item_Count(forplayer) > limit) return SendClientMessage(forplayer, COLOR_PANICRED, sprintf("Nie mo¿esz kupiæ ¿adnego przedmiotu, poniewa¿ przekroczy³eœ limit (%d). Wyrzuæ/zniszcz jakiœ przedmiot z twojego ekwipunku.", limit));
		Iter_Add(PlayerItems[forplayer], id);
	}
	if(type == ITEM_TYPE_WEAPON)
	{
		new slot = GetWeaponSlot(Item[id][i_Value1]);
		if(slot == 10 || slot == 9)
			Item[id][i_ValueSecret] = 1;
	}
	if(!insertinto) Item[id][i_UID] = id+555511;
	else
	{
		new query[248];
		format(query, sizeof query, "INSERT INTO `mru_items` (`name`, `owner_type`, `owner`, `item_type`, `value1`, `value2`, `quantity`, `server_id`, `secretValue`) VALUES ('%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')", name, owner_type, owner, type, value1, value2, quantity, id, secretValue);
		mysql_query(query);
		Item[id][i_UID] = mysql_insert_id();
	}
	format(Item[id][i_Name], 40, name);
	Item[id][i_OwnerType] = owner_type;
	Item[id][i_Owner] = owner;
	Item[id][i_ItemType] = type;
	Item[id][i_Value1] = value1;
	Item[id][i_Value2] = value2;
	Item[id][i_Quantity] = quantity;
	Item[id][i_ValueSecret] = secretValue;
	Iter_Add(Items, id);
	return id;
}

stock Item_EditValues(itemid, value1, value2)
{
	Item[itemid][i_Value1] = value1;
	Item[itemid][i_Value2] = value2;
	//mysql_query_format("UPDATE `mru_items` SET `owner_type` = '%d', `owner` = '%d', `dropped` = '0' WHERE UID = '%d'", Item[itemid][i_OwnerType], Item[itemid][i_Owner], Item[itemid][i_UID]);
	SaveItem(itemid);
	return 1;
}

stock Item_Pickup(playerid, itemid, quantity = 65535)
{
	if(quantity == 65535) quantity = Item[itemid][i_Quantity];
	if(Item[itemid][i_OwnerType] != ITEM_OWNER_TYPE_DROPPED || !Item[itemid][i_UID] || quantity > Item[itemid][i_Quantity])
		return sendErrorMessage(playerid, "Coœ posz³o nie tak!");
	if(quantity != Item[itemid][i_Quantity]) //trzeba stworzyc osobny przedmiot
	{
		new id = Item_Add(Item[itemid][i_Name], ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], Item[itemid][i_ItemType], Item[itemid][i_Value1], Item[itemid][i_Value2], true, playerid, quantity, Item[itemid][i_ValueSecret]);
		Item[itemid][i_Quantity] -= quantity;
		ProxDetector(10.0, playerid, sprintf("* %s podnosi przedmiot %s (x%d)", GetNick(playerid), Item[itemid][i_Name], quantity), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
		Log(itemLog, WARNING, "%s podnosi przedmiot z ziemi (z tego powodu tworzy nowy przedmiot %s razy %d)", GetPlayerLogName(playerid), GetItemLogName(id), quantity);
		UpdateDynamic3DTextLabelText(Item[itemid][i_3DText], COLOR_WHITE, sprintf("(ID: %d) %s x%d", itemid, Item[itemid][i_Name], Item[itemid][i_Quantity]));
		if(Item[itemid][i_Quantity] < 1)
		{
			if(IsValidDynamic3DTextLabel(Item[itemid][i_3DText])) DestroyDynamic3DTextLabel(Item[itemid][i_3DText]);
			Item_Delete(itemid);
		}
		return 1;
	}
	ProxDetector(10.0, playerid, sprintf("* %s podnosi przedmiot %s", GetNick(playerid), Item[itemid][i_Name]), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	if(IsValidDynamic3DTextLabel(Item[itemid][i_3DText])) DestroyDynamic3DTextLabel(Item[itemid][i_3DText]);
	Log(itemLog, WARNING, "%s podnosi przedmiot %s z ziemi (x%d)", GetPlayerLogName(playerid), GetItemLogName(itemid), quantity);
	if(Item[itemid][i_ItemType] == ITEM_TYPE_MATS)
	{
		new has = HasItemType(playerid, Item[itemid][i_ItemType]);
		if(has != -1)
		{
			Item[has][i_Quantity] += Item[itemid][i_Quantity];
			Item_Delete(itemid, true, Item[itemid][i_Quantity]);
			return 1;
		}
	}
	Item[itemid][i_OwnerType] = ITEM_OWNER_TYPE_PLAYER;
	Item[itemid][i_Owner] = PlayerInfo[playerid][pUID];
	Item[itemid][i_Dropped] = 0;
	Iter_Add(PlayerItems[playerid], itemid);
	//mysql_query_format("UPDATE `mru_items` SET `owner_type` = '%d', `owner` = '%d', `dropped` = '0' WHERE UID = '%d'", Item[itemid][i_OwnerType], Item[itemid][i_Owner], Item[itemid][i_UID]);
	SaveItem(itemid);
	return 1;
}

stock Item_Offer(itemid, playerid, giveplayerid, quantity)
{
	SendClientMessage(playerid, COLOR_NEWS, "Oferta zosta³a wys³ana.");
	ShowPlayerDialogEx(giveplayerid, D_ITEM_OFFER, DIALOG_STYLE_MSGBOX, sprintf("Oferta od gracza %s", GetNick(playerid)), sprintf("Gracz %s (ID: %d) chce Ci podarowaæ przedmiot %s x%d(ID: %d).", GetNick(playerid), playerid, Item[itemid][i_Name], quantity, itemid), "Przyjmij", "Odrzuæ");
	SetPVarInt(giveplayerid, "Offer-ID", playerid);
	SetPVarInt(giveplayerid, "Offer-ItemID", itemid);
	SetPVarInt(giveplayerid, "Offer-Quant", quantity);
	SetPVarInt(playerid, "Offering-ItemID", itemid);
	DeletePVar(playerid, "g_quantity");

	Log(itemLog, WARNING, "%s oferuje przedmiot %s x%d graczowi %s", GetPlayerLogName(playerid), GetItemLogName(itemid), quantity, GetPlayerLogName(giveplayerid));
	return 1;
}

stock Item_FailOffer(playerid)
{
	SetPVarInt(playerid, "Offer-ID", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "Offer-ItemID", -1);

	SendClientMessage(playerid, COLOR_PANICRED, "Ktoœ inny zaakceptowa³ ofertê/przedmiot przesta³ istnieæ/przekroczy³eœ limit przedmiotów. Oferta anulowana.");
	return 1;
}

stock FindItemByName(playerid, name[])
{
	foreach(new i : PlayerItems[playerid]) 
	{
		if(Item[i][i_Owner] != PlayerInfo[playerid][pUID]) continue;
		if(strfind(Item[i][i_Name], name, true) != -1) return i;
	}
	return -1;
}

stock FindItemByUID(item_uid)
{
	foreach(new i : Items)
	{
		if(Item[i][i_UID] == item_uid)
			return i;
	}
	return -1;
}

stock PrintPlayerItems(playerid, giveplayerid)
{
	new lstring[2048];
	lstring = "Typ\tNazwa";
	if(Iter_Count(PlayerItems[playerid]) < 1) return sendErrorMessage(giveplayerid, "Ten gracz nie ma ¿adnych przedmiotów.");
	foreach(new i : PlayerItems[playerid])
	{
		if(Item[i][i_ItemType] > sizeof ItemTypes-1)
		{
			sendTipMessage(giveplayerid, sprintf("Ten gracz ma zbugowany item o UID: %d!", Item[i][i_UID]));
			continue;
		}
		strcat(lstring, sprintf("\n%s\t{%s}%s x%d", ItemTypes[Item[i][i_ItemType]], (Item[i][i_Used]) ? ("f5c242") : ("196e75"), Item[i][i_Name], Item[i][i_Quantity]));
	}
	ShowPlayerDialogEx(giveplayerid, 0, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Przedmioty gracza %s", GetNick(playerid)), lstring, "Zamknij", #);
	return 1;
}

stock IsItemConsumable(itemtype)
{
	switch(itemtype)
	{
		case ITEM_TYPE_LOM: return 0;
		case ITEM_TYPE_CONDOM: return 0;
		case ITEM_TYPE_MATS: return 0;
	}
	return 1;
}

stock CanDrop(itemtype, itemid = -1)
{
	switch(itemtype)
	{
		case ITEM_TYPE_PHONE: return 0;
		case ITEM_TYPE_WEAPON:
		{
			if(itemid != -1)
			{
				new slot = GetWeaponSlot(Item[itemid][i_Value1]);
				if(slot == 10) //dozwolone bronie
					return 1;
				else
					return 0;
			}
			else
				return 0;
		}
	}
	return 1;
}

stock CanGive(playerid, itemtype, itemid = -1)
{
	switch(itemtype)
	{
		case ITEM_TYPE_PHONE: return 0;//todoXD
		case ITEM_TYPE_WEAPON:
		{
			if(itemid != -1)
			{
				new slot = GetWeaponSlot(Item[itemid][i_Value1]);
				if(slot == 10) //dozwolone bronie
					return 1;
			}
			return 0;
		}
		case ITEM_TYPE_MATS: 
		{
			sendTipMessage(playerid, "U¿yj: /sprzedajmats");
			return 0;
		}
	}
	return 1;
}

stock HasItemType(playerid, itemtype)
{
	foreach(new i : PlayerItems[playerid]) 
	{
		if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_PLAYER || Item[i][i_Owner] != PlayerInfo[playerid][pUID]) 
			continue;
		if(Item[i][i_ItemType] == itemtype) 
			return i;
	}
	return -1;
}

stock HasActiveItemType(playerid, itemtype)
{
	foreach(new i : PlayerItems[playerid]) if(Item[i][i_Used] && Item[i][i_ItemType] == itemtype) return i;
	return -1;
}

stock Item_AfterLogin(playerid)
{
	new Float:x2, Float:y2, Float:z2;
	GetPlayerPos(playerid, x2, y2, z2);
	foreach(new i : PlayerItems[playerid])
	{
		//OBIEKTY PRZYCZEPIALNE

		if(Item[i][i_ItemType] == ITEM_TYPE_ATTACH && Item[i][i_Used])
		{
			new query[200], Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz;
			mysql_query_format("SELECT `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz` FROM `mru_attached` WHERE `UID` = '%d'", Item[i][i_UID]);
			mysql_store_result();
			new index = Item[i][i_tmpValue];
			if(IsPlayerAttachedObjectSlotUsed(playerid, index) || index == 0)
			{
				new limit_i = 8;
				if(IsPlayerPremiumOld(playerid)) limit_i = 10;
				for(new l = 5; l < limit_i; l++)
				{
					if(PlayerInfo[playerid][pAttached][l] == 0 && !IsPlayerAttachedObjectSlotUsed(playerid, l))
					{
						index = l;
						break;
					}
				}
				if(index==0)
					Item[i][i_Used] = 0;
			}
			if(mysql_num_rows() && index != 0)
			{
				mysql_fetch_row_format(query);
				sscanf(query, "p<|>fffffffff", x, y, z, rx, ry, rz, sx, sy, sz);
				//RemovePlayerAttachedObject(playerid, index);
				SetPlayerAttachedObject(playerid, index, Item[i][i_Value1], Item[i][i_Value2], x, y, z, rx, ry, rz, sx, sy, sz);
				PlayerInfo[playerid][pAttached][index] = Item[i][i_UID];
				Item[i][i_tmpValue] = index;
			}
			else Item[i][i_Used] = 0;
			mysql_free_result();
		}

		//SKINY

		if(Item[i][i_ItemType] == ITEM_TYPE_SKIN && Item[i][i_Used] && !PlayerInfo[playerid][pUniform]) {
			SetPlayerSkin(playerid, Item[i][i_Value1]);
			SetSpawnInfo(playerid, 0, Item[i][i_Value1], x2, y2, z2, 0.0, 0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

stock RemovePlayerItems(playerid)
{
	if(Iter_Count(PlayerItems[playerid]) <= 0) return 0;
	foreach(new i : PlayerItems[playerid])
	{
		if(!Item[i][i_UID]) continue;
		if(Item[i][i_ItemType] == ITEM_TYPE_PHONE) continue;
		Item_Delete(i, true, Item[i][i_Quantity], false);
		Iter_SafeRemove(PlayerItems[playerid], i, i);
		Iter_Remove(Items, i);
	}
	return 1;
}

stock Item_SetOwner(itemid, owner_type, owner_id)
{
	if(Item[itemid][i_OwnerType] == ITEM_OWNER_TYPE_PLAYER || owner_type == ITEM_OWNER_TYPE_PLAYER)
	{
		if(Item[itemid][i_OwnerType] == ITEM_OWNER_TYPE_PLAYER) //player -> inny typ
		{
			new playerid = GetPlayerIDFromUID(Item[itemid][i_Owner]);
			if(IsPlayerConnected(playerid))
			{
				if(Iter_Contains(PlayerItems[playerid], itemid))
					Iter_Remove(PlayerItems[playerid], itemid);
			}
		}
		else if(owner_type == ITEM_OWNER_TYPE_PLAYER) //inny typ -> player
		{
			new playerid = GetPlayerIDFromUID(owner_id);
			if(IsPlayerConnected(playerid))
			{
				if(!Iter_Contains(PlayerItems[playerid], itemid))
					Iter_Add(PlayerItems[playerid], itemid);
			}
		}
	}
	if(Item[itemid][i_OwnerType] == ITEM_OWNER_TYPE_DROPPED)
	{
		DestroyDynamic3DTextLabel(Item[itemid][i_3DText]);
		Item[itemid][i_Dropped] = 0;
	}
	Item[itemid][i_OwnerType] = owner_type;
	Item[itemid][i_Owner] = owner_id;
	SaveItem(itemid);
	return 1;
}

//Matsy

stock CountMats(playerid)
{
	new count = 0, item = HasItemType(playerid, ITEM_TYPE_MATS);
	if(item != -1)
		count = Item[item][i_Quantity];
	return count;
}

stock TakeMats(playerid, odejmij, info = 1)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new item = HasItemType(playerid, ITEM_TYPE_MATS);
	if(item == -1) return 0;
	Item[item][i_Quantity] -= odejmij;
	SaveItem(item);
	if(Item[item][i_Quantity] <= 0)
		Item_Delete(item);
	if(info) GameTextForPlayer(playerid, sprintf("~r~-%d mats", odejmij), 3000, 1);
	return odejmij;
}

stock CountNarko(playerid)
{
	new count = 0, item = HasItemType(playerid, ITEM_TYPE_MARIHUANA);
	if(item != -1)
		count = Item[item][i_Quantity];
	return count;
}

stock TakeNarko(playerid, odejmij, info = 1){
	if(!IsPlayerConnected(playerid)) return 0;
	new item = HasItemType(playerid, ITEM_TYPE_MARIHUANA);
	if(item == -1) return 0;
	Item[item][i_Quantity] -= odejmij;
	SaveItem(item);
	if(Item[item][i_Quantity] <= 0)
		Item_Delete(item);
	if(info) GameTextForPlayer(playerid, sprintf("~r~-%d narko", odejmij), 3000, 1);
	return odejmij;
}

stock ConvertMatsToItems(playerid)
{
	if(PlayerInfo[playerid][pMats] > 0)
	{
		SendClientMessage(playerid, COLOR_PANICRED, "* Twoje materia³y zosta³y przeniesione do systemu przedmiotów.");
		Item_Add("Materia³y", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, PlayerInfo[playerid][pMats], ITEM_NOT_COUNT);
		PlayerInfo[playerid][pMats] = 0;
	}
	return 1;
}

forward PlayerEkiepChmura(playerid, stage, chmura, itemid);
public PlayerEkiepChmura(playerid, stage, chmura, itemid)
{
	if(stage == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, Float:x, Float:y, Float:z);
		chmura = CreateDynamicObject(18716, Float:x, Float:y, Float:z-0.5, 0, 0, 0);
		SetPlayerPos(playerid, Float:x+0.01, Float:y, Float:z);
		SetTimerEx("PlayerEkiepChmura", 300, false, "ddd", playerid, 2, chmura);
		SetTimerEx("ChmuraPodazanie", 100, false, "dd", playerid, chmura);
		SetPVarInt(playerid, "PlayerEkiepChmuraStage", 1);
	}
	else if(stage == 2)
	{
		DestroyDynamicObject(chmura);
		SetTimerEx("PlayerEkiepChmura", 2000, false, "ddd", playerid, 3, 0);
		SetPVarInt(playerid, "PlayerEkiepChmuraStage", 2);
	}
	else
	{
		new SpalonaGrzala = random(100);
		if(SpalonaGrzala == 5)
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid, 7)) RemovePlayerAttachedObject(playerid, 7);
    		SetPVarInt(playerid, "UsingEKiep", 0);
    		SetPVarInt(playerid, "PuszczaChmure", 0);
    		new Float:health;
    		GetPlayerHealth(playerid, Float:health);
    		if((health - 10) <= 0) SetPlayerHealth(playerid, 1);
    		else SetPlayerHealth(playerid, health-10);
    		sendTipMessage(playerid, "Spali³eœ grza³kê.");
    		SetPlayerChatBubble(playerid, "* spali³ grza³kê *", COLOR_PURPLE, 15.0, 7500);
			SetPlayerDrunkLevel(playerid, 4000);
			Item_Delete(itemid);
		}
		
		SetPVarInt(playerid, "PuszczaChmure", 0);
	}
	
}

forward ChmuraPodazanie(playerid, chmura);
public ChmuraPodazanie(playerid, chmura)
{
	if(GetPVarInt(playerid, "PlayerEkiepChmuraStage") == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, Float:x, Float:y, Float:z);
		MoveDynamicObject(chmura, Float:x, Float:y, Float:z-0.5, 10);
		SetTimerEx("ChmuraPodazanie", 100, false, "dd", playerid, chmura);
	}
}

//Bagazniki

stock BagaznikCount(vehicleUID)
{
	new count = 0;
	foreach(new i : Items)
	{
		if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_VEHICLE || Item[i][i_Owner] != vehicleUID) continue;
		count++;
	}
	return count;
}