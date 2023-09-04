//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              System Narko                                                 //
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
// Autor: Dawidoskyy
// Data utworzenia: 18.12.2021
//Opis:
/*
	System Narko
*/

//

#include <YSI_Coding\y_hooks>

// ========[ENUMY + NEWY]========

#define MAX_PLANTACJA_PLAYER 5
#define MAX_PLANTACJA 150

enum ePlantacja {
    p_Owner,
    Float:p_Pos[3],
    Object:p_Object,
    Text3D:p_Label,
    bool:p_CanGather
};
new Plantacja[MAX_PLANTACJA][ePlantacja];

new Iterator:I_Plantacja<MAX_PLANTACJA>;

enum nInfo
{
	pZuzyl, // Iloœæ jak¹ zu¿y³/spali³ gracz narkotyków.
	pPodWplywem, // Gdy jesteœmy pod wp³ywem narkotyku. || 1 - TAK, 0 - NIE.
	pTimerKill
};

new nPlayer[MAX_PLAYERS][nInfo];
new ndstring[128];


//-----------------<[ Funkcje: ]>-------------------

// ========[DEFINICJE - KOLORY]========
new hpRegenDelay = 5; // liczba sekund przed nastêpnym zregenerowaniem punktów HP
//new Float:hpRegenRate = 5.0; // liczba punktów HP zregenerowanych na sekundê
#define C_SZARY	"{C0C0C0}"
#define C_BIALY	"{FFFFFF}"
#define C_CZERWONY	"{FF0000}"
#define C_NIEBIESKI	"{4169E1}"
#define C_ZIELONY	"{ADFF2F}"
#define DO "{9797FF}"
#define ME "{FFB76F}"
#define KOLOR_JA 0xB871FFFF
#define KOLOR_DO 0x9797FFFF

// ========[DEFINICJE - DIALOGI]========
#define DIALOG_NMENU	8356
#define DIALOG_NKUP	8355
#define DIALOG_NKUP2 8355
#define DIALOG_NSPRZEDAJ	8354
#define DIALOG_NZASADZ	8353
#define DIALOG_NUZYL	8352
#define DIALOG_NSPRZEDAJBOTOWI	8351

// ========[PUBLICKI]========

hook OnGameModeInit()
{
	for(new i = 0; i < MAX_PLANTACJA; i++)
		Plantacja[i][p_Label] = CreateDynamic3DTextLabel(" ", 0xC0C0C0FF, 0.0, 0.0, 0.0, 10.0);
	return 1;
}

stock OnPlayerSpawnNarko(playerid)
{
	SetPlayerDrunkLevel(playerid, 0); // Brak "lataj¹cej kamery".
	return 1;
}
 
stock OnPlayerDeathNarko(playerid)
{
	nPlayer[playerid][pPodWplywem] = 0; // Ustawiamy, ¿e mo¿e u¿yæ narkotyk po œmierci.
	SetPlayerWeather(playerid, 1); // Domyœlna pogoda.
	SetPlayerDrunkLevel(playerid, 0); // Brak "lataj¹cej kamery".
	return 1;
}

stock OnDialogResponseNarko(playerid, dialogid, response, listitem)
{
	if(dialogid == DIALOG_NKUP) // U¿yty w CMD:nkup
	{
		if(response == 1) // Je¿eli wciœnie KUP.
		{
			//new tekst[500];
			switch(listitem)
			{
				case 0: // Je¿eli chcê kupiæ KRZAK
				{
					GameTextForPlayer(playerid,"~g~Kupiono ~p~krzak.", 10000, 1);
					DajKaseDone(playerid, -PRICE_NARKO_KRZAK); 
					Item_Add("Krzak", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_KRZAK, 0, 0, true, playerid, 1, ITEM_NOT_COUNT);
					format(ndstring, sizeof(ndstring), ""C_ZIELONY"Pomyœlnie"C_SZARY" zakupi³eœ roœline.");
					ShowPlayerDialogEx(playerid, DIALOG_NKUP, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Uda³o siê!:", ndstring, "Okej", "");
				}
			}
		}
		return 1;
	}
	return 0;
}
stock OnDialogResponseNarko2(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused listitem
	if(dialogid == DIALOG_NSPRZEDAJBOTOWI)
	{
		new ilosc, stringnarko[258];
		if(!response) return 1;
		if(sscanf(inputtext, "d", ilosc)) return ShowPlayerDialogEx(playerid, DIALOG_NSPRZEDAJBOTOWI, DIALOG_STYLE_INPUT, ""C_NIEBIESKI"Sprzedawanie narkotyku:", "Wpisz ile narkotyków chcesz sprzedaæ", "Dalej", ""); 
		new id= HasItemType(playerid, ITEM_TYPE_MARIHUANA);
		if(id != -1) Item_Delete(id, true, ilosc);
		format(stringnarko, sizeof(stringnarko), "Sprzedales %d marihuany za %d$", ilosc, PRICE_NARKO_DRUG * ilosc);
		SendClientMessage(playerid, COLOR_BIALY, "Steve_Burton mówi: Nastêpnym razem nie zawracaj mi gitary tak¹ gównian¹ iloœci¹. **splun¹³ klientowi na buty**");
		SendRadioMessage(FRAC_LSPD, COLOR_LIGHTRED, "HQ: Podejrzana osoba moim zdaniem handluje narkotykami na El Corona!!", 0, 1); 
		GameTextForPlayer(playerid, stringnarko, 5000, 3);
		DajKaseDone(playerid, PRICE_NARKO_DRUG * ilosc);
		return 1;
	}
	return 0;
}
// ========[KOMENDY - GRACZA]========
stock OnPlayerKeyStateChangeNarko(playerid, newkeys)
{
	if(newkeys==KEY_YES)
	{
		new tekst[500];
		if(DoInRange(5.0, playerid, 2309.1284,-2130.5847,13.5735)) // Odleg³oœæ od miejsca kupna.
		{
			if(!IsAPrzestepca(playerid, 0)) return noAccessMessage(playerid);
			if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) // Je¿eli nie jesteœmy "na nogach" tylko np. w aucie to wywali info.
			{
				format(tekst, sizeof(tekst), ""C_SZARY"Aby otworzyæ menu kupna nie mo¿esz siedzieæ w aucie.");
				ShowPlayerDialogEx(playerid, DIALOG_NKUP, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Coœ jest nie tak!:", tekst, "Okej", "");			
				return 0;
			}
			ShowPlayerDialogEx(playerid, DIALOG_NKUP, DIALOG_STYLE_TABLIST_HEADERS, ""C_BIALY"Mo¿e coœ Ciê zainteresuje?", "{d9d9d9}ID\tNazwa\tKoszt\n1\tSadzonka do plantacji\t"C_ZIELONY"$"#PRICE_NARKO_KRZAK"", "{d9d9d9}KUP", "{d9d9d9}Anuluj");
		}
	}
	return 1;
}
stock OnPlayerKeyStateChangeNarko2(playerid, newkeys)
{
	if(newkeys==KEY_YES)
	{
		new tekst[500];
		if(DoInRange(5.0, playerid, 1892.84, -2107.69, 13.58)) // Odleg³oœæ od miejsca kupna.
		{
			if(!IsAPrzestepca(playerid, 0)) return noAccessMessage(playerid);
			if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) // Je¿eli nie jesteœmy "na nogach" tylko np. w aucie to wywali info.
			{
				format(tekst, sizeof(tekst), ""C_SZARY"Aby otworzyæ menu kupna nie mo¿esz siedzieæ w aucie.");
				ShowPlayerDialogEx(playerid, DIALOG_NSPRZEDAJBOTOWI, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Coœ jest nie tak!:", tekst, "Okej", "");			
				return 0;
			}
			return ShowPlayerDialogEx(playerid, DIALOG_NSPRZEDAJBOTOWI, DIALOG_STYLE_INPUT, ""C_NIEBIESKI"Sprzedawanie narkotyku:", "Wpisz ile narkotyków chcesz sprzedaæ", "Dalej", "");
		}
	}
	return 1;
}

YCMD:nzbierz(playerid, params[])
{
    new tekst[300];
    if(!IsAPrzestepca(playerid, 0)) return noAccessMessage(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendErrorMessage(playerid, "Aby zebraæ plantacjê musisz byæ pieszo.");
	new id = GetClosestPlant(playerid);
	if(id == -1 || !Iter_Contains(I_Plantacja, id))
		return sendErrorMessage(playerid, "Nie znajdujesz siê w pobli¿u ¿adnej plantacji!");
	if(Plantacja[id][p_Owner] != PlayerInfo[playerid][pUID] && Plantacja[id][p_Owner] > 0)
		return sendErrorMessage(playerid, "Ta plantacja nie zosta³a zasadzona przez Ciebie.");
	if(Plantacja[id][p_CanGather] == false)
		return sendErrorMessage(playerid, "Nie mo¿esz zebraæ jeszcze roœliny!");
	else
	{
		ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0);
		Item_Add("Marihuana", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MARIHUANA, 0, 0, true, playerid, 6);
		UsunPlantacje(id);

		format(tekst, sizeof(tekst), ""C_SZARY"Plantacja zosta³a pomyœlnie przez Ciebie zebrana!\nOtrzyma³eœ: ("C_ZIELONY"6"C_SZARY") gram narkotyków.");
        return ShowPlayerDialogEx(playerid, DIALOG_NZASADZ, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Plantacja zebrana!:", tekst, "Okej", "");
	}
}
forward healthRegen(playerid);

public healthRegen(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
    new Float:newHealth = health + 15.0;

    if(newHealth > 100.0)
    {
        newHealth = 100.0;
    }
    SetPlayerHealth(playerid, newHealth);
	if (nPlayer[playerid][pTimerKill] <4)
		SetTimerEx("healthRegen", hpRegenDelay * 1000, false, "i", playerid); // ustawia timer do regeneracji HP

	nPlayer[playerid][pTimerKill] += 1;
    return 1;
}

// ========[STOCKI I FORWARDY, INNE]========

stock DoInRange(Float: radi, playerid, Float:x, Float:y, Float:z)//sprawdza odleglosc od miejsca
{
	if(IsPlayerInRangeOfPoint(playerid, radi, x, y, z)) return 1;
	return 0;
}

stock nNick(playerid)
{
    new PlayerNick[MAX_PLAYER_NAME], string[256];
    GetPlayerName(playerid,PlayerNick,sizeof(PlayerNick));
    format(string,sizeof(string),nSRC,PlayerNick);
    return string;
}

stock GetPlayerNNick(playerid)//zwraca nick
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}
forward zwyklyStan(playerid);
public zwyklyStan(playerid)
{
	new tekst[300];
	nPlayer[playerid][pPodWplywem] = 0; // Ustawia, ¿e gracz ju¿ mo¿e zu¿yæ nastêpny narkotyk.
    SetPlayerWeather(playerid, 1);
    SetPlayerDrunkLevel(playerid, 0);
	format(tekst, sizeof(tekst), ""C_SZARY"Stan Twojej postaci po spo¿yciu nieznanej substancji wróci³ do normy.\n");
	ShowPlayerDialogEx(playerid, DIALOG_NUZYL, DIALOG_STYLE_MSGBOX,""C_NIEBIESKI"Wracasz do normy!:", tekst, "Okej", "");
	return 1;
}

forward ZbierzUP3DText(plantacja_id);
public ZbierzUP3DText(plantacja_id)
{
	if(!Iter_Contains(I_Plantacja, plantacja_id)) return 0;
	new nick[24], output[256];
	strmid(nick, MruMySQL_GetNameFromUID(Plantacja[plantacja_id][p_Owner]), 0, MAX_PLAYER_NAME);
	format(output, sizeof(output), ""C_ZIELONY"Plantacja roœliny\n"C_SZARY"Roœlina jest ju¿ gotowa do zbioru!\nAby zebraæ roœlinê wpisz: /nzbierz.\nStworzona przez: %s\nID: %d", (isnull(nick)) ? ("Brak w³aœciciela") : (nick), plantacja_id);
	UpdateDynamic3DTextLabelText(Plantacja[plantacja_id][p_Label], 0xC0C0C0FF,output);
	Plantacja[plantacja_id][p_CanGather] = true;
	return 1;
}

stock UsunPlantacje(id)
{
	if(!Iter_Contains(I_Plantacja, id)) return 0;
	DestroyDynamicObject(Plantacja[id][p_Object]);
    //DestroyDynamic3DTextLabel(Plantacja[id][p_Label]);
	UpdateDynamic3DTextLabelText(Plantacja[id][p_Label], 0xC0C0C0FF, " ");
	Plantacja[id][p_Owner] = 0;
	Plantacja[id][p_Pos][0] = 0.0; 
	Plantacja[id][p_Pos][1] = 0.0; 
	Plantacja[id][p_Pos][2] = 0.0; 
	Plantacja[id][p_CanGather] = false;
	Iter_Remove(I_Plantacja, id);
	return 1;
}

stock GetClosestPlant(playerid, Float:dist = 3.0)
{
	foreach(new i : I_Plantacja)
	{
		if(IsPlayerInRangeOfPoint(playerid, dist, Plantacja[i][p_Pos][0], Plantacja[i][p_Pos][1], Plantacja[i][p_Pos][2]))
			return i;
	}
	return -1;
}

YCMD:usunplantacje(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return noAccessMessage(playerid);
	if(isnull(params))
		return sendTipMessage(playerid, "U¿yj: /usunplantacje [ID]");
	new plantacja_id = strval(params);
	if(!Iter_Contains(I_Plantacja, plantacja_id))
		return sendErrorMessage(playerid, "Plantacja o podanym ID nie istnieje!");
	UsunPlantacje(plantacja_id);
	va_SendClientMessage(playerid, COLOR_GREEN, "* Usun¹³eœ plantacjê o ID: %d", plantacja_id);
	return 1;
}

YCMD:gotoplantacja(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return noAccessMessage(playerid);
	if(isnull(params))
		return sendTipMessage(playerid, "U¿yj: /gotoplantacja [ID]");
	new plantacja_id = strval(params);
	if(!Iter_Contains(I_Plantacja, plantacja_id))
		return sendErrorMessage(playerid, "Plantacja o podanym ID nie istnieje!");
	SetPlayerPos(playerid, Plantacja[plantacja_id][p_Pos][0], Plantacja[plantacja_id][p_Pos][1], Plantacja[plantacja_id][p_Pos][2]);
	SendClientMessage(playerid, COLOR_GRAD2, " Zosta³eœ teleportowany!");
	return 1;
}