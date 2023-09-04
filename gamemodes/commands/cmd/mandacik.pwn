//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ mandacik ]-----------------------------------------------//
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

YCMD:mandat(playerid, params[])
{
    new targetid, amount;
    if(sscanf(params, "k<fix>i", targetid, amount)) return SendClientMessage(playerid, -1, "U¿yj: /mandat [playerid/CzêœæNicku] [Kwota]");
	{
    if(IsPlayerConnected(playerid))
    {
        if(!IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ policjantem!");
		    return 1;
		}
        if(OnDuty[playerid] != 1 && IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na s³u¿bie!");
		    return 1;
		}
		if(amount <= 0) return sendTipMessage(playerid, "Wysokoœæ mandatu musi byæ powy¿ej $1");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))
        {
			new str[512];
			//if(kaska[targetid] < amount) return sendErrorMessage(targetid, "Nie staÃ¦ Cie na zaplacenie mandatu");
			if(kaska[targetid] < amount) return sendErrorMessage(playerid, "Nie staæ go na zaplacenie mandatu");
			format(str, sizeof(str), "Wystawiles mandat graczowi %s o kwocie $%i!",PlayerName(targetid), amount);
			SendClientMessage(playerid, COLOR_BLUE, str);
			format(str, sizeof(str), "Dostales mandat od policjanta %s o kwocie $%i! Wpisz /akceptuj mandat",PlayerName(playerid), amount);
			SendClientMessage(targetid, COLOR_BLUE, str);
			SetPVarInt(targetid, "IdPolicjanta", playerid);
			SetPVarInt(targetid, "KwotaMandatu", amount);
			SetPVarInt(targetid, "HaveMandat", 1);
			return 1;
         }
     }
}
    return 1;
} 
