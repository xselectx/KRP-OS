//-----------------------------------------------<< Przedmioty >>-------------------------------------------------//
//                                                 Telefon                                                //
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
	System telefonu
*/

//

//------------------<[ Telefon: ]>--------------------

// * - Telefony * - //

stock PhoneError(playerid, bool:showagain = true, message[] = "")
{
	if(showagain) PhonePanel(playerid, DynamicGui_GetDialogValue(playerid));
	else {
		SetPVarInt(playerid, "PhonePanel", 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		RemovePlayerAttachedObject(playerid, 4);
	}
	if(strlen(message)) sendErrorMessage(playerid, message);
	return 1;
}

stock PhonePanel(playerid, itemid, bool:action = false)
{
	if(action) 
	{
		ProxDetector(30.0, playerid, sprintf("* %s wyci¹ga telefon z kieszeni", GetNick(playerid)), COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SetPlayerAttachedObject(playerid, 4, -2002, 6, 0, 0.006, 0.015, -28.8, 0, 2.8);
	}
	new options[248];
	format(options, sizeof options, "Zadzwoñ\nWyœlij SMS\nPrzelew na telefon\n%s", (Item[itemid][i_Used]) ? ("Wy³¹cz") : ("W³¹cz"));
	ShowPlayerDialogEx(playerid, D_PHONE_PANEL, DIALOG_STYLE_LIST, "Telefon", options, "Wykonaj", "Zamknij");
	DynamicGui_SetDialogValue(playerid, itemid);
	SetPVarInt(playerid, "PhonePanel", 1);
	return 1;
}

stock PhoneCall(number1, number2, playerid)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
    if(!IsPlayerConnected(playerid))
	{
		return 1;
	}
	
	if(gPlayerLogged[playerid] == 0)
	{
		return 1;
	}
	
	if(GetPhoneNumber(playerid) == 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu !");
		PhoneError(playerid, false);
		return 1;
	}
	if(Kajdanki_JestemSkuty[playerid])
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ telefonu podczas bycia skutym!");
		PhoneError(playerid, false);
		return 1;
	}
	if(PlayerInfo[playerid][pJailed] != 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu w wiêzieniu!"); 
		PhoneError(playerid, false);
		return 1;
	}
	
	if(number2 == number1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz zadzwoniæ sam do siebie.");
		PhoneError(playerid, false);
		return 1;
	}
	
	if(number2 < 1)
	{
		sendErrorMessage(playerid, "Niepoprawny numer telefonu.");
		PhoneError(playerid, false);
		return 1;
	}
	
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		sendErrorMessage(playerid, "Dzwonisz ju¿ do kogoœ.");
		PhoneError(playerid, false);
		return 1;
	}

	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ telefonu podczas s³u¿by administratora!"); 
		PhoneError(playerid, false);
		return 1;
	}
	
	new reciverid;
	if(number2 != 911)
	{
		reciverid = GetPlayerIDByPhone(number2);
		if(reciverid == INVALID_PLAYER_ID)
		{
			sendErrorMessage(playerid, "Gracz o takim numerze jest offline.");
			PhoneError(playerid, false);
			return 1;
		}

		if(GetPlayerAdminDutyStatus(reciverid) == 1)
		{
			sendErrorMessage(playerid, "Osoba do której próbujesz zadzwoniæ jest nieosi¹galna!"); 
			PhoneError(playerid, false);
			return 1;
		}
		
		if(GetPhoneOnline(reciverid) == 0)
		{
			sendErrorMessage(playerid, "Gracz ma wy³¹czony telefon.");
			return 1;
		}
		
		if(Mobile[reciverid] != INVALID_PLAYER_ID)
		{
			sendErrorMessage(playerid, "Gracz ju¿ z kimœ rozmawia.");
			PhoneError(playerid, false);
			return 1;
		}
	}
	
	//all ok, lecim
	GetPlayerName(playerid, sendername, sizeof(sendername));
	format(string, sizeof(string), "* %s wyjmuje telefon, wybiera numer i wykonuje po³¹czenie.", sendername);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	
	SendClientMessage(playerid, COLOR_WHITE, "Trwa ³¹czenie, proszê czekaæ...");
	SendClientMessage(playerid, COLOR_WHITE, "WSKAZÓWKA: U¿yj chatu IC aby rozmawiaæ przez telefon i /z aby sie roz³¹czyæ.");
	PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	if(PlayerInfo[playerid][pInjury] == 0 && PlayerInfo[playerid][pBW] == 0) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

	if(number2 == 911)
	{
		if(GUIExit[playerid] == 0)
		{
			//ShowPlayerDialogEx(playerid, 112, DIALOG_STYLE_LIST, "Numer alarmowy", "Policja\nStra¿ Po¿arna\nMedyk\nSheriff", "Wybierz", "Roz³¹cz siê");
			ShowPlayerDialogEx(playerid, 112, DIALOG_STYLE_LIST, "Numer alarmowy", "Policja\nSzpital\nStra¿ Po¿arna", "Wybierz", "Roz³¹cz siê");
		}
		else
		{
			sendErrorMessage(playerid, "Masz ju¿ otwarte inne okienko GUI, zamknij je i spróbuj jeszcze raz.");
			PhoneError(playerid, false);
		}
		return 1;
	}
	else
	{
		StartACall(playerid, reciverid);
	}
	return 1;
}

stock PhoneSms(playerid, to, number1, number2, text[])
{
	new string[572];
	new smsCost; 
	smsCost = PRICE_SMS_NORMAL;
	if(PlayerInfo[playerid][pJailTime] > 0) return SendClientMessage(playerid, COLOR_GREY, "Nie mo¿esz tego u¿yæ bêd¹c w wiêzieniu!");
	Mobile[playerid] = INVALID_PLAYER_ID;
	if(number2 >= 100 && number2 <= 150)
	{
		new SanWorkers = GetFractionMembersNumber(FRAC_SN, true);
        if(gSNLockedLine[number2-100] || SanWorkers == 0) {PhoneError(playerid, false); return GameTextForPlayer(playerid, "~r~Linia zamknieta", 5000, 1);}
		//Koszt
		if(number2 == 100) smsCost = COST_SN_SMS_0; 
		else if(number2 == 110) smsCost = COST_SN_SMS_1; 
		else if(number2 == 120) smsCost = COST_SN_SMS_2; 
		else if(number2 == 130) smsCost = COST_SN_SMS_3; 
		else if(number2 == 140) smsCost = COST_SN_SMS_4; 
		else if(number2 == 150) smsCost = COST_SN_SMS_5; 

		if(kaska[playerid] < smsCost) return sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci œrodków!");

		//All its okay, continue code:
		new giveMoneyForWorker = smsCost/SanWorkers; 
		Sejf_Add(FRAC_SN, (smsCost/2)); 
		ZabierzKaseDone(playerid, smsCost); 
		format(string, sizeof(string), "Dodatkowy koszt p³atnego SMS: %d$", smsCost);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "* %s wyjmuje telefon i wysy³a wiadomoœæ.", GetNick(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    Log(chatLog, WARNING, "%s sms SAN %d: %s", GetPlayerLogName(playerid), number2, text);
		foreach(new i : Player)
		{
			if(IsPlayerInGroup(i, FRAC_SN))
			{
				if(SanDuty[i] == 1)
				{
					SendSMSMessage(GetPhoneNumber(playerid), i, text);
					format(string, sizeof(string), "P³atny SMS wygenerowa³: %d$, czyli %d$ dla ka¿dego", smsCost, giveMoneyForWorker);
					SendClientMessage(i, COLOR_YELLOW, string);
					DajKaseDone(i, giveMoneyForWorker);
				}
			}
		}
		PhoneError(playerid, false);
		return 1;
	}
	else if(number2 == 555)
	{
		if(strcmp("tak", text, true) == 0)
			SendSMSMessage(555, playerid, "Nie mam pojêcia o czym mówisz");
		else
			SendSMSMessage(555, playerid, "To proste napisz tak");
		PhoneError(playerid, false);
	}

	if(to == INVALID_PLAYER_ID)
		{PhoneError(playerid, false); return SendClientMessage(playerid, COLOR_GREY, "Nie uda³o siê wys³aæ wiadomoœci - gracz o takim numerze jest offline.");}
	if(kaska[playerid] < smsCost)
	{
		format(string, sizeof(string), "Koszt tego SMS wynosi: %d$, nie masz a¿ tylu pieniêdzy.", smsCost);
		PhoneError(playerid, false);
		return sendErrorMessage(playerid, string);
	}

	format(string, sizeof(string), "* %s wyjmuje telefon i wysy³a wiadomoœæ.", GetNick(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	Log(chatLog, WARNING, "%s sms do %s: %s", GetPlayerLogName(playerid), GetPlayerLogName(to), text);
	SavePlayerSentMessage(playerid, sprintf("%s wys³a³ SMS do %s: %s", GetNick(playerid), GetNick(to), text), FROMME);
	SavePlayerSentMessage(to, sprintf("%s otrzyma³ SMS od %s: %s", GetNick(to), GetNick(playerid), text), TOME);

	if(PlayerInfo[playerid][pPodPW] == 1 || PlayerInfo[to][pPodPW] == 1) //podgl?d admina
    {
        format(string, sizeof(string), "AdmCmd -> %s(%d) /sms -> %s(%d): %s", GetNick(playerid), playerid, GetNick(to), to, text);
        ABroadCast(COLOR_YELLOW,string,1,1);
    }
	new slotKontaktu = PobierzSlotKontaktuPoNumerze(playerid, number2);
	if(slotKontaktu >= 0)
		format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %s (%d).", text, Kontakty[playerid][slotKontaktu][eNazwa], number2);
	else
		format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %d.", text, number2);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	//pobór op³at
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof(string), "~r~$-%d", smsCost);
	GameTextForPlayer(playerid, string, 5000, 1);
	ZabierzKaseDone(playerid, smsCost);
	SendClientMessage(playerid, COLOR_WHITE, "Wiadomoœæ dostarczona.");
	SendSMSMessage(number1, to, text);
	PhoneError(playerid, false);
	return 1;
}

stock PhoneTransfer(playerid, phone, money)
{
	if(PlayerInfo[playerid][pLevel] < 3) return sendTipMessage(playerid, "Musisz mieæ 3 level!");
	if(IsSystemNumber(phone)) return sendErrorMessage(playerid, "Akcja zabroniona.");

	//Sprawdzanie:
	new id = GetPlayerIDByPhone(phone);
	if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID) return sendTipMessage(playerid, "Gracz z takim numerem jest offline!");
	if(money < 1 || PlayerInfo[playerid][pAccount] < money) return sendTipMessage(playerid, "Kwota jest na minusie / nie masz tyle na koncie!");
	if(PlayerInfo[id][pAccount]+money > MAX_MONEY_IN_BANK) return sendErrorMessage(playerid, "Gracz do którego próbowa³eœ przelaæ gotówkê - ma zbyt du¿o pieniêdzy na koncie."); 
	if(id == playerid) return sendErrorMessage(playerid, "Nie mo¿esz wys³aæ przelewu samemu sobie.");

	//Czynnoœci:
	PlayerInfo[playerid][pAccount] -= money;
	PlayerInfo[id][pAccount] += money;

	//Komunikaty:
	new string[256];
	format(string, sizeof string, "Powiadomienie: Na twoje konto wp³yne³o %d$ od numeru %d, Nadawca: BANK", money, GetPhoneNumber(playerid));
	SendClientMessage(id, COLOR_YELLOW, string);
	format(string, sizeof string, "Powiadomienie: Z twojego konta zosta³ wykonany przelew o wartoœci %d$ dla numeru %d, Nadawca: BANK", money, phone);
	SendClientMessage(playerid, COLOR_YELLOW, string);

	Log(payLog, WARNING, "%s przela³ %s kwotê %d$", 
	GetPlayerLogName(playerid),
	GetPlayerLogName(id),
	money);
				
	if(money >= 50000)//Wiadomosc dla adminow
	{
		format(string, sizeof(string), "Gracz %s wys³a³ przelew do %s w wysokoœci %d$", GetNick(playerid), GetNick(id), money);
		SendAdminMessage(COLOR_YELLOW, string);
		return 1;
	}
	return 1;
}

stock IsSystemNumber(number)
{
	if(number >= 100 && number <= 150) return 1;
	else if(number == 555) return 1;
	return 0;
}

stock GetPhoneNumber(playerid)
{
	foreach(new i : PlayerItems[playerid])
	{
		if( Item[i][i_ItemType] != ITEM_TYPE_PHONE) continue;
		return Item[i][i_Value1];
	}
	return 0;
}

stock GetPhoneOnline(playerid)
{
	new item = HasActiveItemType(playerid, ITEM_TYPE_PHONE);
	if(item != -1) return 1;
	return 0;
}

stock SetPhoneOnline(playerid, online)
{
	new item = HasItemType(playerid, ITEM_TYPE_PHONE);
	if(item == -1) return 0;
	Item[item][i_Used] = online;
	return 1;
}

stock HasPhoneNumber(playerid, number, active = 0)
{
	foreach(new i : PlayerItems[playerid])
	{
		if(active && !Item[i][i_Used]) continue;
		if(Item[i][i_ItemType] != ITEM_TYPE_PHONE) continue;
		if(Item[i][i_Value1] == number) return i;
	}
	return -1;
}

stock GetPlayerIDByPhone(phone)
{
	foreach(new i : Player)
	{
		if(Iter_Count(PlayerItems[i]) < 1) continue;
		if(HasPhoneNumber(i, phone, 1) != -1) return i;
	}
	return INVALID_PLAYER_ID;
}

//end