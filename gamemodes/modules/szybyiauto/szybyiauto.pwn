#define VEHICLE_WDS_DEBUG
YCMD:vszyba(playerid, params[])
{
	new string[256];
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid == 0) return sendErrorMessage(playerid, "Musisz byæ w aucie!");
	if(IsABoat(vehicleid) || IsABike(vehicleid) || IsACarBezSzyb(vehicleid))
    {
        sendErrorMessage(playerid, "W tym pojeŸdzie nie ma szyb!");
        return 1;
    }

	new seatid = GetPlayerVehicleSeat(playerid);

	switch(seatid){
		case 0:
		{	
			if(IsVehicleWindowOpened(vehicleid, FL_DOOR)){
				CloseVehicleWindow(vehicleid, FL_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o zamkniête. Pamiêtaj, gracze nie s³ysz¹ Ciebie. (/vszyba)");
				format(string, 256, "*** %s zamkn¹³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
			else{
				OpenVehicleWindow(vehicleid, FL_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o otwarte.");
				format(string, 256, "*** %s otworzy³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
		}
		case 1:
		{
			if(IsVehicleWindowOpened(vehicleid, FR_DOOR)){
				CloseVehicleWindow(vehicleid, FR_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o zamkniête. Pamiêtaj, gracze nie s³ysz¹ Ciebie. (/vszyba)");
				format(string, 256, "*** %s zamkn¹³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
			else{
				OpenVehicleWindow(vehicleid, FR_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o otwarte.");
				format(string, 256, "*** %s otworzy³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
		}
		case 2:
		{
			if(IsVehicleWindowOpened(vehicleid, BL_DOOR)){
				CloseVehicleWindow(vehicleid, BL_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o zamkniête. Pamiêtaj, gracze nie s³ysz¹ Ciebie. (/vszyba)");
				format(string, 256, "*** %s zamkn¹³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
			else{
				OpenVehicleWindow(vehicleid, BL_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o otwarte.");
				format(string, 256, "*** %s otworzy³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
		}
		case 3:
		{
			if(IsVehicleWindowOpened(vehicleid, BR_DOOR)){
				CloseVehicleWindow(vehicleid, BR_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o zamkniête. Pamiêtaj, gracze nie s³ysz¹ Ciebie. (/vszyba)");
				format(string, 256, "*** %s zamkn¹³ szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
			else{
				OpenVehicleWindow(vehicleid, BR_DOOR);
				sendTipMessageEx(playerid, COLOR_GRAD1, "Okno zosta³o otwarte.");
				format(string, 256, "*** %s otworzy szybê w pojeŸdzie ***", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
			}
		}
	}
    return 1;
}

YCMD:vszyby(playerid, params[]){
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid == 0) return sendErrorMessage(playerid, "Musisz byæ w aucie!");
	if(IsABoat(vehicleid) || IsABike(vehicleid) || IsACarBezSzyb(vehicleid)){
        sendErrorMessage(playerid, "W tym pojeŸdzie nie ma szyb!");
        return 1;
    }

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		for(new i=0; i<=3; i++){
			switch(i){
				case 0:
				{	
					if(IsVehicleWindowOpened(vehicleid, FL_DOOR)){
						CloseVehicleWindow(vehicleid, FL_DOOR);
					}
				}
				case 1:
				{
					if(IsVehicleWindowOpened(vehicleid, FR_DOOR)){
						CloseVehicleWindow(vehicleid, FR_DOOR);
					}
				}
				case 2:
				{
					if(IsVehicleWindowOpened(vehicleid, BL_DOOR)){
						CloseVehicleWindow(vehicleid, BL_DOOR);
					}
				}
				case 3:
				{
					if(IsVehicleWindowOpened(vehicleid, BR_DOOR)){
						CloseVehicleWindow(vehicleid, BR_DOOR);
					}
				}
			}
		}
		sendTipMessageEx(playerid, COLOR_GRAD1, "Zamkn¹³eœ otwarte szyby w pojeŸdzie!");
	}
	else{
		sendErrorMessage(playerid, "Musisz byæ kierowc¹!");
        return 1;
	}
    return 1;
}