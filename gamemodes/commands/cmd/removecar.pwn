//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ removecar ]-----------------------------------------------//
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

YCMD:removecar(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return 1;
    new car;
    if(sscanf(params, "d", car)) return sendTipMessage(playerid, "U�yj /removecar [Car UID]");

    new uid = Car_GetIDXFromUID(car);
    if(uid == -1)
    {
        sendTipMessageEx(playerid, COLOR_GRAD2, "Pojazd nie by� wczytany do systemu, inicjalizacja ...");
        uid = Car_LoadEx(car);
        if(uid == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
    }
    new str[128];
    format(str, 128, "[CAR] Usuni�to pojazd (UID: %d) przez %s", CarData[uid][c_UID], GetNickEx(playerid));
	SendClientMessage(playerid, COLOR_GRAD2, str);
    Log(adminLog, WARNING, "Admin %s usun�� pojazd o UID %d", GetPlayerLogName(playerid), CarData[uid][c_UID]);
    Car_Destroy(uid);

    return 1;
}
