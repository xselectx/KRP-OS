//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  biznesy                                                  //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System biznesów.
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
biznesy_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused listitem
	//  When multiple versions of the same callback are hooked with y_hooks, they are all always called,
	//   regardless of the return value of previous hooks. 
	//  This can be prevented by using the two additional return values introduced in y_hooks:
    // -1: Stop processing this callback instantly and return 0.
    // -2: Stop processing this callback instantly and return 1. 

	if(dialogid == DIALOG_PANEL_BIZ)
	{
		if(!response)
		{
			return 1;
		}
		if(response)
		{
			new string[124];
			new giveplayerid = strval(inputtext); 
			if(GetPVarInt(playerid, "bizWhatToDo") == 1)//Przyjmij pracownika
			{
				if(IsPlayerConnected(giveplayerid))
				{
					if(GetPlayerBusiness(giveplayerid) != INVALID_BIZ_ID)
					{
						sendErrorMessage(playerid, "Ten gracz ma ju� biznes!"); 
						return 1; 
					}
					if(playerid == giveplayerid)
					{
						sendErrorMessage(playerid, "Nie mo�esz przyj�� samego siebie!"); 
						return 1;
					}
					PlayerInfo[giveplayerid ][pBusinessMember] = PlayerInfo[playerid][pBusinessOwner]; 
					format(string, sizeof(string), "Zosta�e� przyj�ty do %s przez %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name], GetNick(playerid));
					sendTipMessageEx(giveplayerid , COLOR_BLUE, string); 
					format(string, sizeof(string), "Przyj��e� %s do swojego biznesu!", GetNick(giveplayerid)); 
					sendTipMessageEx(playerid, COLOR_BLUE, string); 
				}
			}
			else if(GetPVarInt(playerid, "bizWhatToDo") == 2)//Zwolnij pracownika
			{
				if(IsPlayerConnected(giveplayerid))
				{
					if(PlayerInfo[playerid][pBusinessOwner] != PlayerInfo[giveplayerid][pBusinessMember])
					{
						format(string, sizeof(string), "Gracz %s nie jest cz�onkiem twojego biznesu!", GetNick(giveplayerid)); 
						sendErrorMessage(playerid, string); 
						return 1;
					}
					PlayerInfo[giveplayerid ][pBusinessMember] = INVALID_BIZ_ID; 
					format(string, sizeof(string), "Zosta�e� zwolniony z %s przez %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name], GetNick(playerid));
					sendTipMessageEx(giveplayerid , COLOR_BLUE, string); 
					format(string, sizeof(string), "Zwolni�e� %s ze swojego biznesu!", GetNick(giveplayerid )); 
					sendTipMessageEx(playerid, COLOR_BLUE, string); 
				}
			}
			else if(GetPVarInt(playerid, "bizWhatToDo") == 3)
			{
				new valueMoney = FunkcjaK(inputtext); 
				new businessID = PlayerInfo[playerid][pBusinessOwner];
				if(kaska[playerid] < valueMoney)
				{
					sendErrorMessage(playerid, "Nie posiadasz przy sobie takiej got�wki!"); 
					return 1;
				}
				if(Business[businessID][b_moneyPocket]+valueMoney > 1_000_000_000)
				{
					sendErrorMessage(playerid, "Nie mo�esz wsadzi� takiej got�wki - sejf jest przepe�niony!"); 
					return 1;
				}
				if(valueMoney <= 0)
				{
					sendErrorMessage(playerid, "Warto�� nie mo�e by� podana z ''-''"); 
					return 1;
				}
				format(string, sizeof(string), "Wp�aci�e� do sejfu $%d, jest w nim teraz $%d", 
					valueMoney, 
					Business[businessID][b_moneyPocket]+valueMoney
				);
				sendTipMessageEx(playerid, COLOR_BLUE, string); 
				Business[businessID][b_moneyPocket] = Business[businessID][b_moneyPocket]+valueMoney; 
				ZabierzKaseDone(playerid, valueMoney); 
				SaveBusiness(Business[businessID][b_ID]); 

				Log(payLog, WARNING, "%s wp�aci� do biznesu %s kwot� %d$. Nowy stan: %d$",
					GetPlayerLogName(playerid),
					GetBusinessLogName(businessID), 
					valueMoney,
					Business[businessID][b_moneyPocket]
				);
			}
			else if(GetPVarInt(playerid, "bizWhatToDo") == 4)
			{
				new valueMoney = FunkcjaK(inputtext); 
				new businessID = PlayerInfo[playerid][pBusinessOwner];
				if(Business[businessID][b_moneyPocket] < valueMoney)
				{
					sendErrorMessage(playerid, "Nie posiadasz w sejfie biznesu takiej got�wki!"); 
					return 1;
				}
				if(valueMoney <= 0)
				{
					sendErrorMessage(playerid, "Warto�� nie mo�e by� podana z ''-''"); 
					return 1;
				}
				format(string, sizeof(string), "Wp�aci�e� do sejfu $%d, jest w nim teraz $%d", 
					valueMoney, 
					Business[businessID][b_moneyPocket]-valueMoney
				);
				sendTipMessageEx(playerid, COLOR_BLUE, string); 
				Business[businessID][b_moneyPocket] = Business[businessID][b_moneyPocket]-valueMoney; 
				DajKaseDone(playerid, valueMoney); 
				Log(payLog, WARNING, "%s wyp�aci� z biznesu %s kwot� %d$. Nowy stan: %d$",
					GetPlayerLogName(playerid),
					GetBusinessLogName(businessID), 
					valueMoney,
					Business[businessID][b_moneyPocket]
				);
				SaveBusiness(Business[businessID][b_ID]);
			}
		}
		return 1;
	}
	else if(dialogid == D_BIZ_WRITE)
	{
		if(!response)
		{
			sendErrorMessage(playerid, "Wyszed�e� z panelu tworzenia biznesu"); 
			return 1;
		}
		new value, string[124]; 
		if(response)
		{
			if(GetPVarInt(playerid, "MustBe") == 0)//Kwota kasy za jaka gracz ma kupic
			{
				value = FunkcjaK(inputtext); 
				SetPVarInt(playerid, "SetBizCost", value); 
				SetPVarInt(playerid, "MustBe", 1); 
				ShowPlayerDialogEx(playerid, D_BIZ_WRITE, DIALOG_STYLE_INPUT, "Kotnik Role Play", "Wprowad� poni�ej maksymalny zysk\nkt�ry gracz b�dzie m�g� otrzyma� co godzine.", "Dalej", "Wyjd�"); 
				return 1;
			}
			if(GetPVarInt(playerid, "MustBe") == 1)
			{
				value = FunkcjaK(inputtext); 
				SetPVarInt(playerid, "SetBizMoney", value); 
				SetPVarInt(playerid, "MustBe", 2); 
				ShowPlayerDialogEx(playerid, D_BIZ_WRITE, DIALOG_STYLE_INPUT, "Kotnik Role Play", "Wpisz poni�ej nazw� biznesu", "Dalej", "Wyjd�"); 
				return 1;
			}
			if(GetPVarInt(playerid, "MustBe") == 2)
			{
				if(strlen(inputtext) > 3 && strlen(inputtext) < 64)
				{
					SetPVarString(playerid, "SetBizName", inputtext); 
					sendTipMessageEx(playerid, COLOR_GREEN, "===[Tworzenie biznesu 1/3]==="); 
					format(string, sizeof(string), "Nazwa biznesu: %s", inputtext); 
					sendTipMessage(playerid, string); 
					format(string, sizeof(string), "Cena: $%d", GetPVarInt(playerid, "SetBizCost"));
					sendTipMessage(playerid, string); 
					format(string, sizeof(string), "Odsetki uwarunkowane (max): $%d", GetPVarInt(playerid, "SetBizMoney")); 
					sendTipMessage(playerid, string); 
					sendTipMessage(playerid, "Teraz trzeba wybra� pozycj� wej�cia - sta� w miejscu i wpisz /stworzbiznes"); 
					SetPVarInt(playerid, "ActionCreateBiz", 1); 
				}
				else
				{
					ShowPlayerDialogEx(playerid, D_BIZ_WRITE, DIALOG_STYLE_INPUT, "Kotnik Role Play", "Wpisz poni�ej nazw� biznesu\nMINIMALNIE 3 ZNAKI", "Dalej", "Wyjd�"); 
				}
				return 1;
			}
		}
		return 1;
	}
	return 0;
}
//end