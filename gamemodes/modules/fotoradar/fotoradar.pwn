//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  Fotoradar                                                //
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
// Autor: Dawidoskyy
// Data utworzenia: 20.01.2022
//Opis:
/*
	Fotoradar
*/

//

//-----------------<[ Funkcje: ]>-------------------

new Text:fotoradar;
new radarekTimer[MAX_PLAYERS];

stock FotoradarOnGameModeInit()
{
	fotoradar = TextDrawCreate(0.0, 0.0, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawUseBox(fotoradar, 1);
	TextDrawBoxColor(fotoradar, 0xFFFFFF66);
	TextDrawTextSize(fotoradar, 640.0, 400.0);
}

forward Ograniczenia(playerid);
public Ograniczenia(playerid)
{
	//new vir = GetPlayerVirtualWorld(playerid);
	foreach(new i : DynamicObjects)
	{
		if(ObjectInfo[i][o_Model] != 18880) continue;
		if(IsPlayerInRangeOfPoint(playerid, 35.0, ObjectInfo[i][o_X], ObjectInfo[i][o_Y], ObjectInfo[i][o_Z]) && GetPlayerState(playerid)==PLAYER_STATE_DRIVER && GetPVarInt(playerid, "radar")!=1)
		{
			new Float:vel[3], Float:vSpeed, vehicleid = GetPlayerVehicleID(playerid);
			if(vehicleid == 0) continue;
			GetVehicleVelocity(vehicleid, vel[0], vel[1], vel[2]);
			vSpeed = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
			if(floatround(vSpeed)>135)
			{
				if(OnDuty[playerid] > 0 && IsAPolicja(playerid)) return 0; // Nie dziala dla pd na duty
				new String[258];
				PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
				radarekTimer[playerid] = SetTimerEx("radarek", 500, 0, "u", playerid);
				format(String, sizeof(String), "~w~Otrzymujesz mandat w~n~wysokosci $"#PRICE_FOTORADAR".~n~~n~~y~Twoja predkosc: %dkm/h ~n~Limit predkosci: 135km/h",floatround(vSpeed));
				TextDrawInfoOn(playerid, String, 8000);
				TextDrawShowForPlayer(playerid,fotoradar);
				SetTimerEx("radarek", 250, 0, "u", playerid);
				ZabierzKaseDone(playerid, PRICE_FOTORADAR);
				Sejf_Add(11, PRICE_FOTORADAR);
				SetPVarInt(playerid, "radar", 1);
				SetTimerEx("fotoradarek", 60000, 0, "u", playerid);
			}
		}
	}
	return 1;
}
forward fotoradarek(playerid); public fotoradarek(playerid)
{
    SetPVarInt(playerid, "radar", 0);
    return 1;
}
forward radarek(playerid); public radarek(playerid)
{
	KillTimer(radarekTimer[playerid]);
	TextDrawHideForPlayer(playerid, fotoradar);
	return 1;
}

//end