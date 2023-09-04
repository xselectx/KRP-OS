//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  produkty                                                 //
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
// Data utworzenia: 31.05.2021
//Opis:
/*
	System produktów dla organizacji
*/

//

//-----------------<[ Funkcje: ]>-------------------

stock product_Add(name[], org, price, value1, value2, itemtype, quant)
{
	new id = Iter_Free(Products);
	if(id == -1) return -1;
	if(!IsValidGroup(org)) return -1;

	if(!mysql_query_format("INSERT INTO `mru_products` (`orgID`, `product_name`, `price`, `value1`, `value2`, `item_type`, `quant`) VALUES ('%d', '%s', '%d', '%d', '%d', '%d', '%d')", org, name, price, value1, value2, itemtype, quant))
		return -1;
	Product[id][p_UID] = mysql_insert_id();
	format(Product[id][p_ProductName], 64, name);
	Product[id][p_OrgID] = org;
	Product[id][p_Price] = price;
	Product[id][p_Value1] = value1;
	Product[id][p_Value2] = value2;
	Product[id][p_ItemType] = itemtype;
	Product[id][p_Quant] = quant;
	Iter_Add(Products, id);
	return id;
}

stock product_Delete(pID, frommysql = 1, fromiter = 1)
{
	if(frommysql) mysql_query_format("DELETE FROM `mru_products` WHERE `UID` = %d", Product[pID][p_UID]);
	if(fromiter) Iter_Remove(Products, pID);
	Product[pID][p_UID] = 0;
	Product[pID][p_OrgID] = 0;
	return 1;
}

stock product_Save(pID)
{
	mysql_query_format("UPDATE `mru_products` SET `orgID` = '%d', \
	`product_name` = '%s', \
	`price` = '%d', \
	`value1` = '%d', \
	`value2` = '%d', \
	`item_type` = '%d', \
	`quant` = '%d' \
	WHERE `UID` = '%d'",
	Product[pID][p_OrgID],
	Product[pID][p_ProductName],
	Product[pID][p_Price],
	Product[pID][p_Value1],
	Product[pID][p_Value2],
	Product[pID][p_ItemType],
	Product[pID][p_Quant],
	Product[pID][p_UID]);
	return 1;
}

stock produkt_akceptuj(playerid)
{
	if(GetPVarInt(playerid, "ProductPlayer-Offer") == INVALID_PLAYER_ID || GetPVarInt(playerid, "ProductID-Offer") == -1)
		return SendClientMessage(playerid, -1, "Nie posiadasz aktywnej oferty.");
	new product = GetPVarInt(playerid, "ProductID-Offer"), offer = GetPVarInt(playerid, "ProductPlayer-Offer");
	if(!IsPlayerConnected(offer) || !Product[product][p_UID] || Product[product][p_Price] < 0) 
	{
		SetPVarInt(playerid, "ProductPlayer-Offer", INVALID_PLAYER_ID);
		SetPVarInt(playerid, "ProductID-Offer", -1);
		return sendErrorMessage(playerid, "Gracz oferuj¹cy wyszed³ z gry/produkt przesta³ istnieæ. Oferta anulowana!");
	}
	new quant = GetPVarInt(offer, "selected-product-quant");
	if(kaska[playerid] < Product[product][p_Price]*quant)
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie staæ Ciê na przedmiot %s x%d za cenê $%d", Product[product][p_ProductName], quant, Product[product][p_Price]*quant);
		return 1;
	}
	DajKaseDone(offer, (Product[product][p_Price]*quant)/2);
	Sejf_Add(GetPlayerGroupUID(offer, OnDuty[offer]-1), (Product[product][p_Price]*quant)/2);
	ZabierzKaseDone(playerid, Product[product][p_Price]*quant);
	va_SendClientMessage(playerid, COLOR_GREY, "* Kupi³eœ produkt %s x%d od %s [%d] za %d$!", Product[product][p_ProductName], quant, GetNick(offer), offer, Product[product][p_Price]*quant);
	va_SendClientMessage(offer, COLOR_GREY, "* Gracz %s [%d] zaakceptowa³ twoj¹ oferte. Otrzymujesz %d$!", GetNick(playerid), playerid, (Product[product][p_Price]*quant)/2);
	new item = Item_Add(Product[product][p_ProductName], ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], Product[product][p_ItemType], Product[product][p_Value1], Product[product][p_Value2], true, playerid, quant);
	Product[product][p_Quant] -= quant;
	if(Product[product][p_Quant] < 0) Product[product][p_Quant] = 0;
	product_Save(product);
	Log(payLog, WARNING, "%s kupuje produkt %s x%d od gracza %s", GetPlayerLogName(playerid), GetItemLogName(item), quant, GetPlayerLogName(offer));
	SetPVarInt(playerid, "ProductPlayer-Offer", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "ProductID-Offer", -1);
	return 1;
}

//end