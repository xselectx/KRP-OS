//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ wezzlecenie ]----------------------------------------------//
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
	id pojazdu: 578
*/

YCMD:wezzlecenie(playerid, params[], help)
{
    if(IsPlayerInGroup(playerid, FRAC_KT))
    {
    	new veh = GetPlayerVehicleID(playerid);
    	if(veh == 0) return sendTipMessage(playerid, "Musisz by� w poje�dzie firmowym.");
    	if(Car_GetOwnerType(veh) != CAR_OWNER_FRACTION || Car_GetOwner(veh) != FRAC_KT) return sendTipMessage(playerid, "Musisz by� w poje�dzie firmowym.");
    	if(GetVehicleModel(veh) != 578) return sendErrorMessage(playerid, " Tym pojazdem nie we�miesz zlecenia.");

    	if(GetPVarInt(playerid, "trans") == 0)
    	{
    	    ShowPlayerDialogEx(playerid, D_TRANSPORT, DIALOG_STYLE_LIST, "Rodzaj zlecenia", "Szybkie zlecenie\nCentrum transportu", "Wybierz", "Wyjd�");
    	}
    	else return sendErrorMessage(playerid, "Masz ju� zlecenie.");
    	return 1;
    }
	return 1;
}
