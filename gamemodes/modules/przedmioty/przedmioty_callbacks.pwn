//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnPlayerDisconnect(playerid, reason)
{
	Iter_Clear(PlayerItems[playerid]);
	return 1;
}

hook OnGameModeInit()
{
	Iter_Init(PlayerItems);
	return 1;
}

hook OnGameModeExit()
{
	SaveItems();
	return 1;
}

hook OnPlayerDeath(playerid, reason)
{
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	return 1;
}

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(!PlayerInfo[playerid][pAttached][index]) return 0;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(!CheckEditionBoundaries(playerid, fOffsetX, fOffsetY, fOffsetZ, fScaleX, fScaleY, fScaleZ)){
		EditAttachedObject(playerid, index);
		return -2;
	}
	if(response)
	{
		mysql_query_format("SELECT `UID` FROM `mru_attached` WHERE `UID` = '%d'", PlayerInfo[playerid][pAttached][index]);
		mysql_store_result();
		if(mysql_num_rows())
		{
			mysql_query_format("UPDATE `mru_attached` SET `UID` = '%d', `x` = '%f', `y` = '%f', `z` = '%f', `rx` = '%f', `ry` = '%f', `rz` = '%f', `sx` = '%f', `sy` = '%f', `sz` = '%f' WHERE `UID` = '%d'", PlayerInfo[playerid][pAttached][index],
			fOffsetX,
			fOffsetY,
			fOffsetZ,
			fRotX,
			fRotY,
			fRotZ,
			fScaleX,
			fScaleY,
			fScaleZ,
			PlayerInfo[playerid][pAttached][index]);
		}
		else
		{
			mysql_query_format("INSERT INTO `mru_attached` SET `UID` = '%d', `x` = '%f', `y` = '%f', `z` = '%f', `rx` = '%f', `ry` = '%f', `rz` = '%f', `sx` = '%f', `sy` = '%f', `sz` = '%f'", PlayerInfo[playerid][pAttached][index],
			fOffsetX,
			fOffsetY,
			fOffsetZ,
			fRotX,
			fRotY,
			fRotZ,
			fScaleX,
			fScaleY,
			fScaleZ);
		}
		SetPVarInt(playerid, "Editing-AttachedObject", 0);
		SetPlayerAttachedObject(playerid, index, modelid, boneid, 
				fOffsetX, fOffsetY, fOffsetZ, 
				fRotX, fRotY, fRotZ, 
				fScaleX, fScaleY, fScaleZ
		);
		return sendTipMessage(playerid, "Pozycja zosta³a zapisana.");
	}
	else
		SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new selected = GetPVarInt(playerid, "Selected-Item");
	switch(dialogid)
	{
		case D_ITEMS:
		{
			if(!response) return 1;
			new itemid = Iter_Index(PlayerItems[playerid], listitem);
			if(!Item[itemid][i_UID]) return sendTipMessage(playerid, "Coœ posz³o nie tak.");
			ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[itemid][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");
			SetPVarInt(playerid, "Selected-Item", itemid);
		}
		case D_ITEM_OPTIONS:
		{
			if(!response) { RunCommand(playerid, "przedmioty", ""); return SetPVarInt(playerid, "Selected-Item", -1); }
			if(!Item[selected][i_UID]) return sendTipMessage(playerid, "Coœ posz³o nie tak.");
			switch(listitem)
			{
				case 0: //u¿yj
					Item_Use(playerid, selected);
				case 1: //wyrzuæ
					Item_Drop(playerid, selected);
				case 2: //zniszcz
				{
					if(Item[selected][i_Quantity] <= 1)
						Item_Destroy(playerid, selected, 1);
					else
						ShowPlayerDialogEx(playerid, D_ITEM_DESTROY_QUANTITY, DIALOG_STYLE_INPUT, "Przedmioty - Wyrzucanie przedmiotów", sprintf("Ile przedmiotów tego typu chcesz zniszczyæ? (max: %d)", Item[selected][i_Quantity]), "Zniszcz", "Cofnij");
				}
				case 3: //daj
				{
					if(Item[selected][i_Quantity] > 1) return ShowPlayerDialogEx(playerid, D_ITEM_GIVE_QUANT, DIALOG_STYLE_INPUT, "Oferowanie przedmiotu - iloœæ", sprintf("Ile przedmiotów tego typu chcesz zaoferowaæ? (max: %d)", Item[selected][i_Quantity]), "Dalej", "Zamknij");
					else
					{
						DynamicGui_Init(playerid);
						new string[728];
						foreach(new i : Player) 
						{
							if(GetPlayerState(i) == PLAYER_STATE_SPECTATING) continue;
							if(GetDistanceBetweenPlayers(playerid, i) < 5 && i != playerid)  {
								strcat(string, sprintf("\n(%d) %s", i, GetNick(i)));
								DynamicGui_AddRow(playerid, 1, i);
							}
						}
						if(strlen(string) < 1) return sendTipMessage(playerid, "Brak graczy w pobli¿u.");
						ShowPlayerDialogEx(playerid, D_ITEM_GIVE, DIALOG_STYLE_LIST, sprintf("Oferowanie przedmiotu %s (%d)", Item[selected][i_Name], selected), string, "Daj", "WyjdŸ");
					}
				}
				case 4: //info
				{
					new str[300];
					format(str, sizeof str, "\
					{ffffff}Typ: {00ff00}%s \
					\n{ffffff}Nazwa: {00ff00}%s \
					\n{ffffff}UID: {00ff00}%d \
					\n{ffffff}Server-ID: {00ff00}%d \
					\n{ffffff}Value1: {00ff00}%d \
					\n{ffffff}Value2: {00ff00}%d \
					\n{ffffff}Iloœæ: {00ff00}%d \
					\n{ffffff}Jest w bazie danych: %s",
					ItemTypes[Item[selected][i_ItemType]],
					Item[selected][i_Name],
					Item[selected][i_UID],
					selected,
					Item[selected][i_Value1],
					Item[selected][i_Value2],
					Item[selected][i_Quantity],
					(Item[selected][i_UID] >= 555511) ? ("{ff0000}Nie") : ("{00ff00}Tak"));
					ShowPlayerInfoDialog(playerid, "Informacja", str);
				}
			}
		}
		case D_ITEM_GIVE_QUANT:
		{
			if(!response) return ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");
			new quant = strval(inputtext);
			if(!IsNumeric(inputtext) || !strlen(inputtext) || quant < 1 || quant > Item[selected][i_Quantity]) {
				ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");\
				return sendErrorMessage(playerid, "Nieprawid³owa iloœæ!");
			}
			SetPVarInt(playerid, "g_quantity", quant);
			DynamicGui_Init(playerid);
			new string[728];
			foreach(new i : Player) 
			{
				if(GetPlayerState(i) == PLAYER_STATE_SPECTATING) continue;
				if(GetDistanceBetweenPlayers(playerid, i) < 5 && i != playerid)  {
					strcat(string, sprintf("\n(%d) %s", i, GetNick(i)));
					DynamicGui_AddRow(playerid, 1, i);
				}
			}
			if(strlen(string) < 1) return sendTipMessage(playerid, "Brak graczy w pobli¿u.");
			ShowPlayerDialogEx(playerid, D_ITEM_GIVE, DIALOG_STYLE_LIST, sprintf("Oferowanie przedmiotu %s x%d (%d)", Item[selected][i_Name], quant, selected), string, "Daj", "WyjdŸ");
		}
		case D_ITEM_DESTROY_QUANTITY:
		{
			if(!response) return ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");
			new quantity = strval(inputtext);
			if(!IsNumeric(inputtext) || !strlen(inputtext) || quantity < 1 || quantity > Item[selected][i_Quantity]) {ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij"); return sendErrorMessage(playerid, "Nieprawid³owa iloœæ!");}

			if(quantity > 4) {SetPVarInt(playerid, "d_quantity", quantity); return ShowPlayerDialogEx(playerid, D_ITEM_DESTROY_QUANTITY_2, DIALOG_STYLE_MSGBOX, "Przedmiot - Wyrzucanie przedmiotu", sprintf("Czy na pewno chcesz wyrzuciæ %dx %s? Ta akcja jest nieodwracalna!", quantity, Item[selected][i_Name]), "Akceptuj", "Odrzuæ");}
			DeletePVar(playerid, "d_quantity");
			Item_Destroy(playerid, selected, 1, quantity);
		}
		case D_ITEM_DESTROY_QUANTITY_2:
		{
			if(!response) return ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");
			new quantity = GetPVarInt(playerid, "d_quantity");
			if(quantity < 1 || quantity > Item[selected][i_Quantity]) {sendTipMessage(playerid, "Coœ posz³o nie tak."); return ShowPlayerDialogEx(playerid, D_ITEM_OPTIONS, DIALOG_STYLE_LIST, sprintf("Przedmiot %s", Item[selected][i_Name]), "1.	U¿yj\n2.	Wyrzuæ\n3.	Zniszcz\n4.	Daj\n5.	Informacje o przedmiocie", "Akcja", "Zamknij");}

			DeletePVar(playerid, "d_quantity");
			Item_Destroy(playerid, selected, 1, quantity);
		}
		case D_ITEM_GIVE:
		{
			if(!response) return 1;
			new giveplayerid = DynamicGui_GetDataInt(playerid, listitem), quant = GetPVarInt(playerid, "g_quantity");
			if(!IsPlayerConnected(giveplayerid)) return sendTipMessage(playerid, "Gracz nie istnieje.");
			if(!Item[selected][i_UID]) return sendTipMessage(playerid, "Przedmiot nie istnieje.");
			if(!CanGive(playerid, Item[selected][i_ItemType], selected)) return sendTipMessage(playerid, "Nie mo¿esz daæ tego przedmiotu.");
			if(IsPlayerConnected(GetPVarInt(giveplayerid, "Offer-ID"))) return sendTipMessage(playerid, "Ten gracz ma ju¿ aktywn¹ ofertê.");
			if(quant <= 0) quant = 1;
			
			Item_Offer(selected, playerid, giveplayerid, quant);
		}
		case D_ITEM_OFFER:
		{
			new itemid = GetPVarInt(playerid, "Offer-ItemID"), p = GetPVarInt(playerid, "Offer-ID"), q = GetPVarInt(playerid, "Offer-Quant");
			if(!response) {
				SendClientMessage(p, COLOR_PANICRED, "Oferta zosta³a odrzucona.");
				SetPVarInt(playerid, "Offer-ID", INVALID_PLAYER_ID);
				SetPVarInt(playerid, "Offer-ItemID", -1);
				SetPVarInt(playerid, "Offer-Quant", 0);
				SetPVarInt(p, "Offering-ItemID", -1);
				return 1;
			}
			new realquant = q;
			if(Item[itemid][i_ValueSecret] == ITEM_NOT_COUNT)
				realquant = 1;
			if(!Item[itemid][i_UID] || GetPVarInt(playerid, "Offer-ID") == INVALID_PLAYER_ID || !IsPlayerConnected(p) || Item_Count(playerid)+realquant >= GetPlayerItemLimit(playerid) || q < 1) {SetPVarInt(p, "Offering-ItemID", -1); return Item_FailOffer(playerid);}
			if(Item[itemid][i_Owner] != PlayerInfo[GetPVarInt(playerid, "Offer-ID")][pUID] || !Item[itemid][i_UID] || q > Item[itemid][i_Quantity]) {SetPVarInt(p, "Offering-ItemID", -1); return Item_FailOffer(playerid);}

			SendClientMessage(p, COLOR_LIGHTGREEN, "Oferta zosta³a zaakceptowana.");
			SendClientMessage(playerid, COLOR_NEWS, "Przedmiot zosta³ dodany do twojego ekwipunku.");
			if(IsItemConsumable(Item[itemid][i_ItemType])) SendClientMessage(playerid, COLOR_NEWS, sprintf("Aby go u¿yæ wpisz /p %s", Item[itemid][i_Name]));
			SetPVarInt(playerid, "Offer-ID", INVALID_PLAYER_ID);
			SetPVarInt(playerid, "Offer-ItemID", -1);
			SetPVarInt(playerid, "Offering-ItemID", -1);

			if(Item[itemid][i_Quantity] == q)
			{
				Log(itemLog, WARNING, "%s dostaje przedmiot %s od %s", GetPlayerLogName(playerid), GetItemLogName(itemid), GetPlayerLogName(p));
				if(Item[itemid][i_ItemType] == ITEM_TYPE_MATS)
				{
					new has = HasItemType(playerid, Item[itemid][i_ItemType]);
					if(has != -1)
					{
						Item[has][i_ItemType] += Item[itemid][i_Quantity];
						Item_Delete(itemid, true, Item[itemid][i_Quantity]);
						return 1;
					}
				}
				Iter_Remove(PlayerItems[p], itemid);
				Iter_Add(PlayerItems[playerid], itemid);
				Item[itemid][i_Owner] = PlayerInfo[playerid][pUID];
				Item[itemid][i_Used] = 0;
				if(Item[itemid][i_ItemType] == ITEM_TYPE_ATTACH && Item[itemid][i_Used] && IsPlayerAttachedObjectSlotUsed(playerid, Item[itemid][i_tmpValue]))
					RemovePlayerAttachedObject(p, Item[itemid][i_tmpValue]);
				else if(Item[itemid][i_ItemType] == ITEM_TYPE_SKIN && Item[itemid][i_Used]) 
					SetPlayerSkin(p, PlayerInfo[p][pSkin]);
				SaveItem(itemid);
			}
			else
			{
				new id = Item_Add(Item[itemid][i_Name], ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], Item[itemid][i_ItemType], Item[itemid][i_Value1], Item[itemid][i_Value2], true, playerid, q, Item[itemid][i_ValueSecret]);
				Log(itemLog, WARNING, "%s dostaje przedmiot %s (x%d) od %s", GetPlayerLogName(playerid), GetItemLogName(id), q, GetPlayerLogName(p));
				Item[itemid][i_Quantity] -= q;
				if(Item[itemid][i_Quantity] <= 0) Item_Delete(itemid);
			}

		}
		case D_ITEM_PICKUP:
		{
			if(!response) return 1;
			new itemid = DynamicGui_GetDataInt(playerid, listitem);
			if(!Item[itemid][i_UID]) return sendTipMessage(playerid, "Przedmiot nie istnieje.");
			if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Musisz byæ pieszo.");
			if(Item[itemid][i_Quantity] > 1)
			{
				SetPVarInt(playerid, "d_pickup", itemid);
				ShowPlayerDialogEx(playerid, D_ITEM_PICKUP_QUANTITY, DIALOG_STYLE_INPUT, "Przedmioty - Podnoszenie przedmiotów", sprintf("Ile przedmiotów tego typu chcesz podnieœæ? (max: %d)", Item[itemid][i_Quantity]), "Podnieœ", "Zamknij");
			}
			else Item_Pickup(playerid, itemid);
		}
		case D_ITEM_PICKUP_QUANTITY:
		{
			if(!response) return 1;
			new quantity = strval(inputtext), itemid = GetPVarInt(playerid, "d_pickup");
			if(!IsNumeric(inputtext) || !strlen(inputtext) || quantity<1) return sendErrorMessage(playerid, "Nieprawid³owa iloœæ!");
			if(quantity > Item[itemid][i_Quantity]) return sendErrorMessage(playerid, sprintf("Za du¿a iloœæ! (max: %d)", Item[itemid][i_Quantity]));
			if(!Item[itemid][i_UID] && Item[itemid][i_OwnerType] != ITEM_OWNER_TYPE_DROPPED && Item[itemid][i_Quantity] < 1) return sendErrorMessage(playerid, "Ten przedmiot zosta³ ju¿ przez kogoœ podniesiony!"); //zabezpieczenie przed kopiowaniem przedmiotow
			Item_Pickup(playerid, itemid, quantity);
		}

		//telefon

		case D_TRANSFER_NUMBER:
		{
			if(!response) return PhoneError(playerid, false);
			new itemid = DynamicGui_GetDialogValue(playerid);
			if(!Item[itemid][i_UID]) return PhoneError(playerid, false, "Coœ posz³o nie tak.");
			
		}

		case D_PHONE_PANEL:
		{
			if(!response) return PhoneError(playerid, false);
			new itemid = DynamicGui_GetDialogValue(playerid);
			if(!Item[itemid][i_UID]) return PhoneError(playerid, false, "Coœ posz³o nie tak.");
			if(listitem==0||listitem==1||listitem==2) if(!Item[itemid][i_Used]) return PhoneError(playerid, true, "Najpierw musisz w³¹czyæ telefon!");

			switch(listitem)
			{
				case 0:
					return ShowPlayerDialogEx(playerid, D_PHONE_CALL, DIALOG_STYLE_INPUT, "Telefon - Zadzwoñ", "Podaj numer na który chcesz zadzwoniæ.", "Dzwoñ", "Zamknij");
				case 1:
					return ShowPlayerDialogEx(playerid, D_SMS_NUMBER, DIALOG_STYLE_INPUT, "Telefon - Wyœlij SMS", "Podaj numer na który chcesz wys³aæ SMS.", "Dalej", "WyjdŸ");
				case 2:
					return PhoneError(playerid, true, "U¿yj: /przelew_telefon");
					//return ShowPlayerDialogEx(playerid, D_TRANSFER_NUMBER, DIALOG_STYLE_INPUT, "Telefon - Przelew na telefon", "Podaj numer na który chcesz wys³aæ przelew.", "Dalej", "WyjdŸ");
				case 3:
				{
					Item[itemid][i_Used] = !Item[itemid][i_Used];
					MSGBOX_Show(playerid, sprintf("Telefon %s", ( Item[itemid][i_Used]) ? ("~g~Wlaczony") : ("~r~Wylaczony") ), MSGBOX_ICON_TYPE_OK);
					PhoneError(playerid, false);
				}
			}
		}
		case D_PHONE_CALL:
		{
			if(!response) return PhoneError(playerid, false);
			new itemid = DynamicGui_GetDialogValue(playerid);
			if(!Item[itemid][i_UID]) return PhoneError(playerid, false, "Coœ posz³o nie tak.");
			if(!IsNumeric(inputtext)) return PhoneError(playerid, true, "Nieprawid³owy numer telefonu.");
			if(Item[itemid][i_Value1] < 1) return PhoneError(playerid, false, "Twój numer telefonu jest niepoprawny.");

			new number = strval(inputtext);

			PhoneCall(Item[itemid][i_Value1], number, playerid);
		}
		case D_SMS_NUMBER:
		{
			if(Mobile[playerid] != INVALID_PLAYER_ID || GetPVarInt(playerid, "budka-Mobile") != 999)
				return PhoneError(playerid, false, "Dzwonisz ju¿ do kogoœ...");
			new itemid = DynamicGui_GetDialogValue(playerid);
			if(!response) return PhoneError(playerid);
			if(!Item[itemid][i_UID]) return PhoneError(playerid, false, "Coœ posz³o nie tak.");
			if(!IsNumeric(inputtext)) return PhoneError(playerid, true, "Nieprawid³owy numer telefonu.");
			if(Item[itemid][i_Value1] < 1) return PhoneError(playerid, false, "Twój numer telefonu jest niepoprawny.");

			new number = strval(inputtext), p;
			if(number < 1) return PhoneError(playerid, true, "Nieprawid³owy numer telefonu.");
			
			SetPVarInt(playerid, "SMS-Number", number);
			if(IsSystemNumber(number)) return ShowPlayerDialogEx(playerid, D_SMS_SEND, DIALOG_STYLE_INPUT, "Telefon - Wyœlij SMS", "Podaj treœæ wiadomoœci.", "Wyœlij", "Zamknij");
			
			p = GetPlayerIDByPhone(number);
			if(p == playerid)
				return PhoneError(playerid, true, "Nie mo¿esz wys³aæ wiadomoœci samemu sobie!");
			Mobile[playerid] = p;

			ShowPlayerDialogEx(playerid, D_SMS_SEND, DIALOG_STYLE_INPUT, "Telefon - Wyœlij SMS", "Podaj treœæ wiadomoœci.", "Wyœlij", "Zamknij");
		}
		case D_SMS_SEND:
		{
			new itemid = DynamicGui_GetDialogValue(playerid), number = GetPVarInt(playerid, "SMS-Number");
			if(!response) {Mobile[playerid] = INVALID_PLAYER_ID; return PhonePanel(playerid, itemid);}
			if(!Item[itemid][i_UID]) {Mobile[playerid] = INVALID_PLAYER_ID; return PhoneError(playerid, false, "Coœ posz³o nie tak.");}
			if(Item[itemid][i_Value1] < 1) {Mobile[playerid] = INVALID_PLAYER_ID; return PhoneError(playerid, false, "Twój numer telefonu jest niepoprawny.");}
			if(number < 1) {Mobile[playerid] = INVALID_PLAYER_ID; PhonePanel(playerid, itemid); return PhoneError(playerid, false, "Nieprawid³owy numer telefonu.");}
			if(!IsPlayerConnected(Mobile[playerid]) || !gPlayerLogged[Mobile[playerid]]) {Mobile[playerid] = INVALID_PLAYER_ID; return PhoneError(playerid, false, "*** Wiadomoœæ nie mog³a zostaæ wys³ana. ***");}
			
			PhoneSms(playerid, Mobile[playerid], Item[itemid][i_Value1], number, inputtext);
		}

		//bagazniki

		case D_ITEM_VEHICLE_ITEMS:
		{
			new vehicleid = GetPVarInt(playerid, "bagaznik-id");
			if(!IsValidVehicle(vehicleid) || GetClosestCar(playerid) != vehicleid) return 1;
			if(!response)
			{
				DeletePVar(playerid, "bagaznik-id");
				SetTrunkState(playerid, vehicleid, 0);
				return 1;
			}
			
			new dg_value = DynamicGui_GetValue(playerid, listitem);
			if(dg_value == -1) //Schowaj
			{
				new string[1024];
				DynamicGui_Init(playerid);
				foreach(new i : PlayerItems[playerid])
				{
					if(!Item[i][i_UID] || Item[i][i_Owner] != PlayerInfo[playerid][pUID]) continue;
					if(!CanGive(playerid, Item[i][i_ItemType], i)) continue;
					format(string, sizeof(string), "%s\n(%d) %s (x%d)", string, i, Item[i][i_Name], Item[i][i_Quantity]);
					DynamicGui_AddRow(playerid, i);
				}
				if(isnull(string)) {
					SetTrunkState(playerid, vehicleid, 0);
					return sendTipMessage(playerid, "Nie posiadasz ¿adnych przedmiotów!");
				}
				ShowPlayerDialogEx(playerid, D_TRUNK_ITEMS, DIALOG_STYLE_LIST, MruTitle("Schowaj przedmiot"), string, "Schowaj", "Zamknij");
				return 1;
			}
			//Wyci¹ganie przedmiotów
			if(!Iter_Contains(Items, dg_value) || dg_value < 0) 
				return sendErrorMessage(playerid, "Ten przedmiot nie istnieje.");
			Item_SetOwner(dg_value, ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID]);
			SetTrunkState(playerid, vehicleid, 0, false);
			DeletePVar(playerid, "bagaznik-id");
			RunCommand(playerid, "ja", sprintf("wyci¹ga przedmiot %s z baga¿nika", Item[dg_value][i_Name]));
		}	
		case D_TRUNK_ITEMS:
		{
			if(!response) return RunCommand(playerid, "bagaznik", "");
			new itemid = DynamicGui_GetValue(playerid, listitem), vehicleid = GetPVarInt(playerid, "bagaznik-id");
			if(!IsValidVehicle(vehicleid) || GetClosestCar(playerid) != vehicleid) return 1;
			if(!Item[itemid][i_UID]) return 1;
			if(Item[itemid][i_Owner] != PlayerInfo[playerid][pUID] || Item[itemid][i_OwnerType] != ITEM_OWNER_TYPE_PLAYER)
				return sendErrorMessage(playerid, "Ten przedmiot nie nale¿y do Ciebie!");
			new vehicleUID = CarData[VehicleUID[vehicleid][vUID]][c_UID];
			if(vehicleUID == 0)
				return sendErrorMessage(playerid, "Ten pojazd nie istnieje.");

			Item_SetOwner(itemid, ITEM_OWNER_TYPE_VEHICLE, vehicleUID);
			SetTrunkState(playerid, vehicleid, 0, false);
			RunCommand(playerid, "ja", sprintf("chowa przedmiot %s do baga¿nika", Item[itemid][i_Name]));
			DeletePVar(playerid, "bagaznik-id");
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPVarInt(playerid, "UsingEKiep") == 1 && GetPVarInt(playerid, "PuszczaChmure") == 0 && (newkeys == KEY_HANDBRAKE || oldkeys == KEY_HANDBRAKE))
	{
		PreloadAnimLib(playerid, "GANGS");
		ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "PuszczaChmure", 1);
		SetTimerEx("PlayerEkiepChmura", 2000, false, "ddd", playerid, 1, 0);
	}
}
//end