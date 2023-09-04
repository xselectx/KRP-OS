//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ vopis ]-------------------------------------------------//
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

YCMD:vopis(playerid, params[], help)
{
    new var[8], id=-1;
    if(sscanf(params, "s[8]D(-1)", var, id) && PlayerInfo[playerid][pAdmin] > 0)
	{
		sendTipMessage(playerid, "U�yj /vopis (usu�) (id pojazdu)");
	}
	
    if(strlen(var) == 4 && (strcmp(var, "usu�", true) == 0 || strcmp(var, "usun", true) == 0))
    {
        if(id != -1 && PlayerInfo[playerid][pAdmin] >= 1)
        {
            if(Car_GetOwnerType(id) != CAR_OWNER_PLAYER && !Uprawnienia(playerid, ACCESS_EDITCAR)) 
			{
				return SendClientMessage(playerid, COLOR_GRAD2, "Nie mo�na usun�� opisu pojazdu systemowego.");
			}
            if(!CarOpis_Usun(playerid, id)) 
			{
				return SendClientMessage(playerid, -1, "Opis: Pojazd nie posiada opisu.");
			}
			
			new str[64];
			format(str, sizeof(str), "(OPIS) - Usun��e� opis pojazdu ustawiony przez gracza %s.", CarOpisCaller[id]);
			SendClientMessage(playerid, COLOR_PURPLE, str);
			Log(adminLog, WARNING, "Admin %s usun�� opis pojazdu %s ustawiony przez gracza %s", 
						GetPlayerLogName(playerid),
                        GetVehicleLogName(id),
						CarOpisCaller[id]);
			return 1;
        }
        else
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(vehicleid == 0) return 1;
            if(!IsCarOwner(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale�y do Ciebie.");
            if(!CarOpis_Usun(playerid, vehicleid, true)) return SendClientMessage(playerid, -1, "Opis: Pojazd nie posiada opisu.");
        }
        return 1;
    }

    if(PlayerInfo[playerid][pBP] == 0)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid == 0) return 1;
        if(!IsCarOwner(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale�y do Ciebie.");

        new opis[128];
        format(opis, sizeof opis, "%s", CarDesc[vehicleid]);
        ReColor(opis);
        
        new lStr[256];
        format(lStr, sizeof lStr, "%s\n� Ustaw opis\n� Zmie� opis\n� {FF0000}Usu�", opis);
        ShowPlayerDialogEx(playerid, D_VEHOPIS, DIALOG_STYLE_LIST, "Opis pojazdu", lStr, "Wybierz", "Wyjd�");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokad� pisania na czatach globalnych, nie mo�esz utworzy� opisu.");
    }
    return 1;
}
