//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ sprzedajapteczka ]-------------------------------------------//
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

YCMD:sprzedajapteczke(playerid, params[], help)
{
	if(GroupPlayerDutyPerm(playerid, PERM_MEDIC))
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /sprzedajapteczka [id]");
		if(!IsPlayerConnected(id) ) return sendErrorMessage(playerid, "Ten gracz nie jest zalogowanay");
		new Float:x, Float:y, Float:z, tmp[128];
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko³o ciebie");
		if(PlayerInfo[id][pHealthPacks] >= MAX_HEALTH_PACKS) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz posiada maksymaln¹ iloœæ apteczek");
		format(tmp, sizeof tmp, "Proponujesz %s kupno apteczki za %d$", GetNick(id), (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
		SendClientMessage(playerid, -1, tmp);
		format(tmp, sizeof tmp, "Lekarz %s proponuje Ci kupno apteczki za %d$", GetNick(playerid), (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
		SetPVarInt(id, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(id, D_ERS_SPRZEDAZ_APTECZKI, DIALOG_STYLE_MSGBOX, "LSMC", tmp, "Kup", "Anuluj");
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie grupy, która mo¿e sprzedawaæ apteczki.");
	}
	return 1;
}
