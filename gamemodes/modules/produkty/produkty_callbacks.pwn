//----------------------------------------------<< Callbacks >>----------------------------------------------//
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
	System produkt�w dla organizacji
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case D_PRODUCTS_LIST:
		{
			if(!response) return 0;
			new pID = DynamicGui_GetValue(playerid, listitem);
			if(!Product[pID][p_UID]) return sendErrorMessage(playerid, "Co� posz�o nie tak.");
			if(Product[pID][p_Price] < 0) return sendErrorMessage(playerid, "Cena produktu jest na minusie! Zg�o� to do lidera.");
			if(!CanGive(playerid, Product[pID][p_ItemType])) return sendErrorMessage(playerid, "Sprzeda� tego przedmiotu zosta�a zablokowana. Zg�o� to do lidera!");

			ShowPlayerDialogEx(playerid, D_PRODUCTS_QUANTITY, DIALOG_STYLE_INPUT, "Panel sprzeda�y", "Ile przedmiot�w tego typu chcesz sprzeda�? (max: 100)", "Sprzedaj", "Zamknij");
			SetPVarInt(playerid, "selected-product", pID);
		}
		case D_PRODUCTS_QUANTITY:
		{
			if(!response) return 0;
			new quant = strval(inputtext), product = GetPVarInt(playerid, "selected-product");
			if(!IsNumeric(inputtext) || !strlen(inputtext) || quant < 1 || quant > 100) return ShowPlayerDialogEx(playerid, D_PRODUCTS_QUANTITY, DIALOG_STYLE_INPUT, "Panel sprzeda�y", "Ile przedmiot�w tego typu chcesz sprzeda�? (max: 100)", "Sprzedaj", "Zamknij");
			if(Product[product][p_Quant] < quant)
			{
				sendErrorMessage(playerid, "Nie mo�esz sprzeda� tylu produkt�w! (za ma�a ilo��)");
				return ShowPlayerDialogEx(playerid, D_PRODUCTS_QUANTITY, DIALOG_STYLE_INPUT, "Panel sprzeda�y", "Ile przedmiot�w tego typu chcesz sprzeda�? (max: 10)", "Sprzedaj", "Zamknij");
			}

			SetPVarInt(playerid, "selected-product-quant2", quant);
			new string[256];
			DynamicGui_Init(playerid);
			foreach(new i : Player)
			{
				if(GetPlayerState(i) == PLAYER_STATE_SPECTATING) continue;
				if(GetDistanceBetweenPlayers(playerid, i) < 5 && i != playerid)  {
					strcat(string, sprintf("\n(%d) %s", i, GetNick(i)));
					DynamicGui_AddRow(playerid, i);
				}
			}
			if(strlen(string) < 1) return sendTipMessage(playerid, "Brak graczy w pobli�u!");
			ShowPlayerDialogEx(playerid, D_PRODUCTS_PLAYERS, DIALOG_STYLE_LIST, "Panel sprzeda�y", string, "Sprzedaj", "Zamknij");
		}
		case D_PRODUCTS_PLAYERS:
		{
			if(!response) return RunCommand(playerid, "/sprzedajprodukt", "");
			new giveplayerid = DynamicGui_GetValue(playerid, listitem), product = GetPVarInt(playerid, "selected-product"), quant = GetPVarInt(playerid, "selected-product-quant2");
			SetPVarInt(playerid, "ProductPlayer-OfferingTo", giveplayerid);
			if(kaska[giveplayerid] < Product[product][p_Price]*quant)
			{
				va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Tego gracza nie sta� na zakup %s x%d za cen� $%d", Product[product][p_ProductName], quant, Product[product][p_Price]*quant);
				va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Nie sta� Ci� na przedmiot %s x%d za cen� $%d", Product[product][p_ProductName], quant, Product[product][p_Price]*quant);
				return 1;
			}
			if(!IsPlayerConnected(giveplayerid) || !gPlayerLogged[giveplayerid]) return sendErrorMessage(playerid, "Ten u�ytkownik si� roz��czy�!");
			if(!Product[product][p_UID]) return sendErrorMessage(playerid, "Ten produkt przesta� istnie�!");
			if(GetPVarInt(giveplayerid, "ProductPlayer-Offer") != INVALID_PLAYER_ID) return sendErrorMessage(playerid, "Ten gracz ma aktywn� oferte!");
			SetPVarInt(playerid, "selected-product-quant", quant);
			va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Oferujesz przedmiot %s x%d graczowi %s [%d] za cen� $%d", Product[product][p_ProductName], quant, GetNick(giveplayerid), giveplayerid, Product[product][p_Price]*quant);
			va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Gracz %s [%d] oferuje Ci przedmiot %s x%d za cen� $%d. Aby zaakceptowa� oferte wpisz /akceptuj produkt.", GetNick(playerid), playerid, Product[product][p_ProductName], quant, Product[product][p_Price]*quant);
			Log(payLog, WARNING, "%s oferuje graczowi %s produkt %s x%d za $%d", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), Product[product][p_ProductName], quant, Product[product][p_Price]*quant);
			SetPVarInt(giveplayerid, "ProductPlayer-Offer", playerid);
			SetPVarInt(giveplayerid, "ProductID-Offer", product);
		}
	}
	return 1;
}

//end