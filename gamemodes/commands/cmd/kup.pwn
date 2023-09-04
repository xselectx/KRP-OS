//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kup ]--------------------------------------------------//
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

ShowShopDialog(playerid)
{
	ShowPlayerDialogEx(playerid, D_SHOP_CATEGORY, DIALOG_STYLE_LIST, "Sklep 24/7", "Produkty spo�ywcze\nSprz�t\nInne", "Dalej", "Zamknij");	
}

YCMD:kup(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
			if(GUIExit[playerid] == 0)
			{
				ShowShopDialog(playerid);
			}
		}
		else if(IsAtClothShop(playerid) && GUIExit[playerid] == 0)
			ShowPlayerDialogEx(playerid, D_CLOTH_CATEGORY, DIALOG_STYLE_LIST, "Sklep z ubraniami", "Ubrania\nNakrycia g�owy\nOkulary\nZegarki\nMaski", "Dalej", "Zamknij");
		else if(PlayerToPoint(5.0, playerid, 809.4175,-1420.2585,-22.6193))
		{
				if(kasjerkaWolna == 666)
				{
					kasjerkaWolna = playerid; 
					format(string, sizeof(string), "Bilet zwyk�y\t %d$\nBilet VIP\t %d$", cenaNorm, cenaVIP);
					ShowPlayerDialogEx(playerid, 6997,DIALOG_STYLE_LIST,  "Vinyl-Club", string, "Akceptuj", "Odrzu�"); 
				}
				else
				{
					format(string, sizeof(string), "Aktualnie kasjerka obs�uguje %s - odczekaj chwile!", GetNick(kasjerkaWolna));
					sendTipMessage(playerid, string);
				}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 800.8901,-1410.6635,-22.6093) 
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 833.8511,-1391.2689,-17.6433))
		{
			if(PlayerInfo[playerid][pAge] >= 18)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, 833.8511,-1391.2689,-17.6433))
				{
					SetPVarInt(playerid, "jestPrzyBarzeVIP", 1);
				}
				new stringBig[256]; 
				format(stringBig, sizeof(stringBig), 
				"Nazwa\tKoszt\tMoc (vol)\n\
				{FF0000}%s\t{80FF00}$%d\t15\n\
				{FF0000}%s\t{80FF00}$%d\t30\n\
				{FF0000}%s\t{80FF00}$%d\t40\n\
				{FF0000}%s\t{80FF00}$%d\t60", 
				drinkName1, drinkCost1, 
				drinkName2, drinkCost2,
				drinkName3, drinkCost3,
				drinkName4, drinkCost4); 
				ShowPlayerDialogEx(playerid, 6996, DIALOG_STYLE_TABLIST_HEADERS, "Vinyl-Club", stringBig, "Pij", "Odrzu�", true);
			}
			else
			{
				SendClientMessage(playerid, -1, "Barman_Jaros�aw m�wi: Nieletnim nie sprzedajemy alkoholu!");
				return 1;
			}
		}
		else 
		{
			sendErrorMessage(playerid, "Nie jeste� w miejscu, w kt�rym mo�na u�y� tej komendy.");
			return 1;
		}
	}
	return 1;
}
