//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   tuning                                                  //
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
// Autor: xSeLeCTx
// Data utworzenia: 10.07.2021
//Opis:
/*
	Nowy system tuningu, dzialajacy na zasadzie obiektow doczepialnych do pojazdu
*/

//

//-----------------<[ Funkcje: ]>-------------------

DialogListaTune(type, bool:custom = true, playerid = INVALID_PLAYER_ID)
{
	if(custom)
	{
		new string[2048];
		for(new i=0;i<sizeof(TuneParts);i++)
		{
			if(TuneParts[i][tune_Type] == type)
				format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, TuneParts[i][tune_Model], TuneParts[i][tune_Cost], GetComponentName(TuneParts[i][tune_Model]));
		}
		strdel(string, strlen(string)-1, strlen(string));
		safe_return string;
	}
	else
	{
		new string[2048];
		new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
		if(GetPVarInt(playerid, "Tune_check")) vehicleid = GetPlayerVehicleID(playerid);
		new modelid = GetVehicleModel(vehicleid);
		switch(type)
		{
			case TUNE_TYPE_BUMPER_FRONT:
			{
				for(new i = 0; i<sizeof Tune_FrontBumper; i++)
					if(VehicleSupportsComponent(modelid, Tune_FrontBumper[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_FrontBumper[i], 2000, GetComponentName(Tune_FrontBumper[i]));
			}
			case TUNE_TYPE_SPOILER:
			{
				for(new i = 0; i<sizeof Tune_Spoilers; i++)
					if(VehicleSupportsComponent(modelid, Tune_Spoilers[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Spoilers[i], 2000, GetComponentName(Tune_Spoilers[i]));
			}
			case TUNE_TYPE_BUMPER_REAR:
			{
				for(new i = 0; i<sizeof Tune_RearBumper; i++)
					if(VehicleSupportsComponent(modelid, Tune_RearBumper[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_RearBumper[i], 2000, GetComponentName(Tune_RearBumper[i]));
			}
			case TUNE_TYPE_SIDESKIRT:
			{
				for(new i = 0; i<sizeof Tune_Sideskirts; i++)
					if(VehicleSupportsComponent(modelid, Tune_Sideskirts[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Sideskirts[i], 2000, GetComponentName(Tune_Sideskirts[i]));
			}
			case TUNE_TYPE_ROOFS:
			{
				for(new i = 0; i<sizeof Tune_Roofs; i++)
					if(VehicleSupportsComponent(modelid, Tune_Roofs[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Roofs[i], 2000, GetComponentName(Tune_Roofs[i]));
			}
			case TUNE_TYPE_HOODS:
			{
				for(new i = 0; i<sizeof Tune_Hoods; i++)
					if(VehicleSupportsComponent(modelid, Tune_Hoods[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Hoods[i], 2000, GetComponentName(Tune_Hoods[i]));
			}
			case TUNE_TYPE_EXHAUSTS:
			{
				for(new i = 0; i<sizeof Tune_Exhausts; i++)
					if(VehicleSupportsComponent(modelid, Tune_Exhausts[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Exhausts[i], 2000, GetComponentName(Tune_Exhausts[i]));
			}
			case TUNE_TYPE_VENTS:
			{
				for(new i = 0; i<sizeof Tune_Vents; i++)
					if(VehicleSupportsComponent(modelid, Tune_Vents[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Vents[i], 2000, GetComponentName(Tune_Vents[i]));
			}
			case TUNE_TYPE_LAMPS:
			{
				for(new i = 0; i<sizeof Tune_Lamps; i++)
					if(VehicleSupportsComponent(modelid, Tune_Lamps[i]))
						format(string, sizeof(string), "%s%d\t~g~~h~%d$~n~~w~%s\n", string, Tune_Lamps[i], 2000, GetComponentName(Tune_Lamps[i]));
			}
			case TUNE_TYPE_FELGA:
			{
				for(new i = 0; i<sizeof Tune_Wheels; i++)
					if(VehicleSupportsComponent(modelid, Tune_Wheels[i]))
						format(string, sizeof(string), "%s%d(0.0, 0.0, 90, 1.0)\t~g~~h~%d$~n~~w~%s\n", string, Tune_Wheels[i], 2000, GetComponentName(Tune_Wheels[i]));
			}
		}
		strdel(string, strlen(string)-1, strlen(string));
		safe_return string;
	}
}

CancelTune(playerid, bool:cancel = true)
{
	SetPVarInt(playerid, "Tune_active", 0);

	new giveplayerid = GetPVarInt(playerid, "Tune_giveplayerid");

	if(cancel)
	{
		if(IsPlayerConnected(giveplayerid)) SendClientMessage(giveplayerid, COLOR_GRAD2, "Tuning zosta³ anulowany!");
		if(playerid != giveplayerid) SendClientMessage(playerid, COLOR_GRAD2, "Tuning zosta³ anulowany!");
	
		new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
		new Float:x, Float:y, Float:z;
		new Float:ang;
		GetVehiclePos(vehicleid, x, y, z);
		GetVehicleZAngle(vehicleid, ang);
		new vehUID = VehicleUID[vehicleid][vUID];
		Car_Unspawn(vehicleid);
		vehicleid = Car_Spawn(vehUID);
		SetVehiclePos(vehicleid, x, y, z);
		SetVehicleZAngle(vehicleid, ang);
	}

	for(new i = 0; i<MAX_TUNE_PARTS; i++)
	{
		TuneRecipe[giveplayerid][i][tuneR_Active] = 0;
	}

	new area = GetPVarInt(giveplayerid, "Tune_area");
	
	SetPVarInt(giveplayerid, "Tune_PendingInvite", 0);
	SetPVarInt(giveplayerid, "Tune_mechanik", 0);
	SetPVarInt(giveplayerid, "Tune_area", 0);

	if(area != 0) DestroyDynamicArea(area);

	SetPVarInt(playerid, "Tune_giveplayerid", 0);
	SetPVarInt(playerid, "Tune_vehicleid", 0);
	SetPVarInt(playerid, "Tune_type", 0);
	return 1;
}

FinishTune(playerid)
{
	new giveplayerid = GetPVarInt(playerid, "Tune_giveplayerid");
	new cost = GetTuneCost(giveplayerid);
	new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
	if(kaska[giveplayerid] < cost)
	{
		SendClientMessage(giveplayerid, COLOR_GRAD2, sprintf("Nie staæ Ciê na ten tuning, kosztuje on %d$! Tuner mo¿e teraz usun¹æ czêœæ tuningu.", cost));
		SendClientMessage(playerid, COLOR_GRAD2, sprintf("Tego gracza nie staæ na ten tuning! Oferta zosta³a anulowana i mo¿esz teraz ponownie u¿yæ /tuning %d by usun¹æ czêœæ tuningu.", giveplayerid));
		SetPVarInt(giveplayerid, "Tune_PendingInvite", 0);
		return 1;
	}

	for(new i = 0; i<MAX_TUNE_PARTS; i++)
	{
		if(TuneRecipe[giveplayerid][i][tuneR_Custom] == 0)
		{
			switch(TuneRecipe[giveplayerid][i][tuneR_Type])
			{
				case TUNE_TYPE_BUMPER_FRONT:
					CarData[VehicleUID[vehicleid][vUID]][c_Bumper][0] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_BUMPER_REAR:
					CarData[VehicleUID[vehicleid][vUID]][c_Bumper][1] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_SPOILER:
					CarData[VehicleUID[vehicleid][vUID]][c_Spoiler] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_SIDESKIRT:
					CarData[VehicleUID[vehicleid][vUID]][c_Sideskirt] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_ROOFS:
					CarData[VehicleUID[vehicleid][vUID]][c_Roof] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_HOODS:
					CarData[VehicleUID[vehicleid][vUID]][c_Hood] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_EXHAUSTS:
					CarData[VehicleUID[vehicleid][vUID]][c_Exhaust] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_VENTS:
					CarData[VehicleUID[vehicleid][vUID]][c_Vents] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_LAMPS:
					CarData[VehicleUID[vehicleid][vUID]][c_Lamps] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_NITRO:
					CarData[VehicleUID[vehicleid][vUID]][c_Nitro] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_FELGA:
					CarData[VehicleUID[vehicleid][vUID]][c_Felgi] = TuneRecipe[giveplayerid][i][tuneR_Model];
				case TUNE_TYPE_HYDRA:
					CarData[VehicleUID[vehicleid][vUID]][c_bHydraulika] = TuneRecipe[giveplayerid][i][tuneR_Val];
				case TUNE_TYPE_NEON:
					CarData[VehicleUID[vehicleid][vUID]][c_Neon] = TuneRecipe[giveplayerid][i][tuneR_Val];
			}
		}
		TuneRecipe[giveplayerid][i][tuneR_Active] = 0;
	}

	SendClientMessage(giveplayerid, COLOR_GRAD2, sprintf("Akceptujesz tuning od gracza %s [%d]. Zap³aci³eœ %d$!", GetNick(playerid), playerid, cost));
	SendClientMessage(playerid, COLOR_GRAD2, sprintf("Gracz %s [%d] zaakceptowa³ ofertê tuningu. Dosta³eœ %d$!", GetNick(giveplayerid), giveplayerid, floatround(float(cost)*0.3)));
	
	ZabierzKaseDone(giveplayerid, cost);
	DajKaseDone(playerid, floatround(float(cost)*0.3));
	Car_Save(VehicleUID[vehicleid][vUID], CAR_SAVE_TUNE);
	CancelTune(playerid, false);
	return 1;
}

GetTuneCost(playerid)
{
	new cost = 0;
	for(new i = 0; i<MAX_TUNE_PARTS; i++)
	{
		if(TuneRecipe[playerid][i][tuneR_Active] == 1)
		{
			cost+=TuneRecipe[playerid][i][tuneR_Cost];
		}
	}
	return cost;
}

ShowTunePanel(playerid)
{
	new string[256];
	for(new i = 0; i < sizeof TuneTypeNames; i++)
	{
		if(strlen(TuneTypeNames[i]) <= 1) break;
		format(string, sizeof(string), "%s» %s\n", string, TuneTypeNames[i]);
	}
	if(!GetPVarInt(playerid, "Tune_check")) format(string, sizeof(string), "%s» Usuñ tuning\n» Zakoñcz tuning", string);
	return ShowPlayerDialogEx(playerid, D_TUNE_PANEL, DIALOG_STYLE_LIST, "{99e805} Panel Tuningu", string, "Wybierz", "Anuluj");
}

ShowTuneOptions(playerid)
{
	new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
    if(GetPVarInt(playerid, "Tune_check")) vehicleid = GetPlayerVehicleID(playerid);
	new vehiclemodel = GetVehicleModel(vehicleid);
	new type = GetPVarInt(playerid, "Tune_type");
	if(IsVehicleTunable(vehiclemodel, type))
	{
		for(new i=0;i<sizeof(TuneParts);i++)
		{
			if(TuneParts[i][tune_Type] == type)
			{
				return ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SELECT, DIALOG_STYLE_LIST, sprintf("{99e805} Panel Tuningu{ffffff} » %s » Wybór ", TuneTypeNames[type]), "» Fabryczne\n» Niestandardowe", "Wybierz", "Anuluj");
			}
			
		}
		return Tune_OnDialogResponse(playerid, D_TUNE_PANEL_SELECT, true, 0, " "); // Skip do dialogu ze stockowymi
	}
	else
	{
		for(new i=0;i<sizeof(TuneParts);i++)
		{
			if(TuneParts[i][tune_Type] == type)
			{
				return ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SHOWCASE, DIALOG_STYLE_PREVMODEL, sprintf("Panel Tuningu{ffffff} » %s", TuneTypeNames[type]), DialogListaTune(type), "Zamontuj", "Anuluj");
			}
		}
		sendTipMessage(playerid, "Ten pojazd nie jest zdolny do przeprowadzenia tego rodzaju modyfikacji.");
		return ShowTunePanel(playerid);
	}

}

AddTuneToRecipe(playerid, tuneName[], tuneType, tuneCost, tuneModel, tuneVal, tuneCustom = 1,
Float:tuneOX = 0.0, Float:tuneOY = 0.0, Float:tuneOZ = 0.0, 
Float:tuneRX = 0.0, Float:tuneRY = 0.0, Float:tuneRZ = 0.0)
{
	for(new i = 0; i<MAX_TUNE_PARTS; i++)
	{
		if(TuneRecipe[playerid][i][tuneR_Active] == 0 || (TuneRecipe[playerid][i][tuneR_Active] == 1 && TuneRecipe[playerid][i][tuneR_Type] == tuneType && TuneRecipe[playerid][i][tuneR_Custom] == 0 && tuneCustom == 0))
		{
			TuneRecipe[playerid][i][tuneR_Active] = 1;
			format(TuneRecipe[playerid][i][tuneR_Name], 64, "%s", tuneName);
			TuneRecipe[playerid][i][tuneR_Type] = tuneType;
			TuneRecipe[playerid][i][tuneR_Custom] = tuneCustom;	
			TuneRecipe[playerid][i][tuneR_Cost] = tuneCost;
			TuneRecipe[playerid][i][tuneR_Model] = tuneModel;
			TuneRecipe[playerid][i][tuneR_Val] = tuneVal;
			TuneRecipe[playerid][i][tuneR_OX] = tuneOX;
			TuneRecipe[playerid][i][tuneR_OY] = tuneOY;
			TuneRecipe[playerid][i][tuneR_OZ] = tuneOZ;
			TuneRecipe[playerid][i][tuneR_RX] = tuneRX;
			TuneRecipe[playerid][i][tuneR_RY] = tuneRY;
			TuneRecipe[playerid][i][tuneR_RZ] = tuneRZ;
			if(!IsAProductionServer()) PrintRecipe(playerid);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Dodano %s za %d$ do listy tuningu.", tuneName, tuneCost));
			if(playerid != GetPVarInt(playerid, "Tune_mechanik"))
				SendClientMessage(GetPVarInt(playerid, "Tune_mechanik"), COLOR_LIGHTBLUE, sprintf("Dodano %s za %d$ do listy tuningu.", tuneName, tuneCost));
			return 1;
		}
	}
	sendErrorMessage(playerid, "Brak miejsca na kolejny tuning!");
	sendErrorMessage(GetPVarInt(playerid, "Tune_mechanik"), "Ten gracz nie ma ju¿ miejsca na kolejny tuning!");
	return 1;
}

PrintRecipe(playerid)
{
	for(new i = 0; i<MAX_TUNE_PARTS; i++)
	{
		if(TuneRecipe[playerid][i][tuneR_Active] == 1)
		{
			printf("%d. %s | Type: %d | Custom: %d | Cost: %d | Model: %d | Val: %d | XYZ: %f %f %f | Rot XYZ: %f %f %f", 
			i,
			TuneRecipe[playerid][i][tuneR_Name],
			TuneRecipe[playerid][i][tuneR_Type],
			TuneRecipe[playerid][i][tuneR_Custom],
			TuneRecipe[playerid][i][tuneR_Cost],
			TuneRecipe[playerid][i][tuneR_Model],
			TuneRecipe[playerid][i][tuneR_Val],
			TuneRecipe[playerid][i][tuneR_OX],
			TuneRecipe[playerid][i][tuneR_OY],
			TuneRecipe[playerid][i][tuneR_OZ],
			TuneRecipe[playerid][i][tuneR_RX],
			TuneRecipe[playerid][i][tuneR_RY],
			TuneRecipe[playerid][i][tuneR_RZ]);
		}
	}
}
				// tuner,  gracz tuningowany
AcceptTuneOffer(playerid, giveplayerid)
{
	SetPVarInt(giveplayerid, "Tune_PendingInvite", 0);
	SetPVarInt(giveplayerid, "Tune_mechanik", playerid);
	SetPVarInt(playerid, "Tune_giveplayerid", giveplayerid);
	SetPVarInt(playerid, "Tune_vehicleid", GetPlayerVehicleID(giveplayerid));
	SetPVarInt(playerid, "Tune_active", 1);
	SendClientMessage(giveplayerid, COLOR_GRAD2, sprintf("Akceptujesz ofertê tuningu gracza %s [%d]. Wpisz /koszyk by zobaczyæ listê tuningow¹, lub wpisz /anuluj tuning, aby anulowaæ!", GetNick(playerid), playerid));
	return SendClientMessage(playerid, COLOR_GRAD2, sprintf("Gracz %s [%d] zaakceptowa³ ofertê tuningu. Wpisz {bfbfbf}/tuning %d{BFC0C2} aby rozpocz¹æ!", GetNick(giveplayerid), giveplayerid, giveplayerid));
}

GetTunePartFromModel(modelid)
{
	for(new i = 0; i<sizeof(TuneParts); i++)
	{
		if(TuneParts[i][tune_Model] == modelid)
		{
			return i;
		}
	}
	return -1;
}

stock VehicleSupportedPaintJobs(modelid)
{
	new count = 0;
	if(!(400 <= modelid <= 611))
	{
		return 0;
	}
	for(new x = 0; x < sizeof(Tune_LegalPaintJobs); x++)
	{
		if(Tune_LegalPaintJobs[x][0] != modelid)
		{
			continue;
		}

		for(new y = 1; y < sizeof(Tune_LegalPaintJobs[]); y++)
		{
			if(Tune_LegalPaintJobs[x][y] >= 0)
			{
				count++;
			}
		}
		break;
	}
	return count;
}

stock VehicleSupportsComponent(modelid, componentid)
{
	if(!(400 <= modelid <= 611))
	{
		return 0;
	}

	// Check if the component is a wheel, stereo, hydraulics or nitro.
	if(GetVehicleComponentType(componentid) == CARMODTYPE_WHEELS || componentid == 1086 || componentid == 1087 || (1008 <= componentid <= 1010))
	{
		return 1;
	}
	else
	{
		for(new x = 0; x < sizeof(Tune_LegalMods); x++)
		{
			if(Tune_LegalMods[x][0] != modelid)
			{
				continue;
			}

			for(new y = 1; y < sizeof(Tune_LegalMods[]); y++)
			{
				if(Tune_LegalMods[x][y] == componentid)
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

stock IsVehicleTunable(modelid, type)
{
	new count = 0;
	switch(type)
	{
		case TUNE_TYPE_BUMPER_FRONT:
		{
			for(new i = 0; i<sizeof Tune_FrontBumper; i++)
				if(VehicleSupportsComponent(modelid, Tune_FrontBumper[i]))
					count++;
		}
		case TUNE_TYPE_SPOILER:
		{
			for(new i = 0; i<sizeof Tune_Spoilers; i++)
				if(VehicleSupportsComponent(modelid, Tune_Spoilers[i]))
					count++;
		}
		case TUNE_TYPE_BUMPER_REAR:
		{
			for(new i = 0; i<sizeof Tune_RearBumper; i++)
				if(VehicleSupportsComponent(modelid, Tune_RearBumper[i]))
					count++;
		}
		case TUNE_TYPE_SIDESKIRT:
		{
			for(new i = 0; i<sizeof Tune_Sideskirts; i++)
				if(VehicleSupportsComponent(modelid, Tune_Sideskirts[i]))
					count++;
		}
		case TUNE_TYPE_ROOFS:
		{
			for(new i = 0; i<sizeof Tune_Roofs; i++)
				if(VehicleSupportsComponent(modelid, Tune_Roofs[i]))
					count++;
		}
		case TUNE_TYPE_HOODS:
		{
			for(new i = 0; i<sizeof Tune_Hoods; i++)
				if(VehicleSupportsComponent(modelid, Tune_Hoods[i]))
					count++;
		}
		case TUNE_TYPE_EXHAUSTS:
		{
			for(new i = 0; i<sizeof Tune_Exhausts; i++)
				if(VehicleSupportsComponent(modelid, Tune_Exhausts[i]))
					count++;
		}
		case TUNE_TYPE_VENTS:
		{
			for(new i = 0; i<sizeof Tune_Vents; i++)
				if(VehicleSupportsComponent(modelid, Tune_Vents[i]))
					count++;
		}
		case TUNE_TYPE_LAMPS:
		{
			for(new i = 0; i<sizeof Tune_Lamps; i++)
				if(VehicleSupportsComponent(modelid, Tune_Lamps[i]))
					count++;
		}
		case TUNE_TYPE_FELGA:
		{
			for(new i = 0; i<sizeof Tune_Wheels; i++)
				if(VehicleSupportsComponent(modelid, Tune_Wheels[i]))
					count++;
		}
	}
	if(count > 0) return 1;
	return 0;
}

stock GetComponentName(component)
{
	new modname[50];
	switch(component)
	{
	   case 1000: format(modname, sizeof(modname), "Pro");
	   case 1001: format(modname, sizeof(modname), "Win");
	   case 1002: format(modname, sizeof(modname), "Drag");
	   case 1003: format(modname, sizeof(modname), "Alpha");
	   case 1004: format(modname, sizeof(modname), "Champ");
	   case 1005: format(modname, sizeof(modname), "Fury");
	   case 1006: format(modname, sizeof(modname), "Roof");
	   case 1007: format(modname, sizeof(modname), "Sideskirt");
	   case 1008: format(modname, sizeof(modname), "Nitrous x5");
	   case 1009: format(modname, sizeof(modname), "Nitrous x2");
	   case 1010: format(modname, sizeof(modname), "Nitrous x10");
	   case 1011: format(modname, sizeof(modname), "Race");
	   case 1012: format(modname, sizeof(modname), "Worx");
	   case 1013: format(modname, sizeof(modname), "Round Fog Lights");
	   case 1014: format(modname, sizeof(modname), "Champ");
	   case 1015: format(modname, sizeof(modname), "Race");
	   case 1016: format(modname, sizeof(modname), "Worx");
	   case 1017: format(modname, sizeof(modname), "Sideskirt");
	   case 1018: format(modname, sizeof(modname), "Upswept");
	   case 1019: format(modname, sizeof(modname), "Twin");
	   case 1020: format(modname, sizeof(modname), "Large");
	   case 1021: format(modname, sizeof(modname), "Medium");
	   case 1022: format(modname, sizeof(modname), "Small");
	   case 1023: format(modname, sizeof(modname), "Fury");
	   case 1024: format(modname, sizeof(modname), "Square Fog Lights");
	   case 1025: format(modname, sizeof(modname), "Offroad");
	   case 1026, 1036, 1047, 1056, 1069, 1090: format(modname, sizeof(modname), "Alien");
	   case 1027, 1040, 1051, 1062, 1071, 1094: format(modname, sizeof(modname), "Alien");
	   case 1028, 1034, 1046, 1064, 1065, 1092: format(modname, sizeof(modname), "Alien");
	   case 1029, 1037, 1045, 1059, 1066, 1089: format(modname, sizeof(modname), "X-Flow");
	   case 1030, 1039, 1048, 1057, 1070, 1095: format(modname, sizeof(modname), "X-Flow");
	   case 1031, 1041, 1052, 1063, 1072, 1093: format(modname, sizeof(modname), "X-Flow");
	   case 1032, 1038, 1054, 1055, 1067, 1088: format(modname, sizeof(modname), "Alien");
	   case 1033, 1035, 1053, 1061, 1068, 1091: format(modname, sizeof(modname), "X-Flow");
	   case 1042: format(modname, sizeof(modname), "Chrome");
	   case 1099: format(modname, sizeof(modname), "Chrome");
	   case 1043, 1105, 1114, 1127, 1132, 1135: format(modname, sizeof(modname), "Slamin");
	   case 1044, 1104, 1113, 1126, 1129, 1136: format(modname, sizeof(modname), "Chrome");
	   case 1050, 1058, 1139, 1146, 1158, 1163: format(modname, sizeof(modname), "X-Flow");
	   case 1049, 1060, 1138, 1147, 1162, 1164: format(modname, sizeof(modname), "Alien");
	   case 1073: format(modname, sizeof(modname), "Shadow");
	   case 1074: format(modname, sizeof(modname), "Mega");
	   case 1075: format(modname, sizeof(modname), "Rimshine");
	   case 1076: format(modname, sizeof(modname), "Wires");
	   case 1077: format(modname, sizeof(modname), "Classic");
	   case 1078: format(modname, sizeof(modname), "Twist");
	   case 1079: format(modname, sizeof(modname), "Cutter");
	   case 1080: format(modname, sizeof(modname), "Stitch");
	   case 1081: format(modname, sizeof(modname), "Grove");
	   case 1082: format(modname, sizeof(modname), "Import");
	   case 1083: format(modname, sizeof(modname), "Dollar");
	   case 1084: format(modname, sizeof(modname), "Trance");
	   case 1085: format(modname, sizeof(modname), "Atomic");
	   case 1086: format(modname, sizeof(modname), "Stereo");
	   case 1087: format(modname, sizeof(modname), "Hydraulics");
	   case 1096: format(modname, sizeof(modname), "Ahab");
	   case 1097: format(modname, sizeof(modname), "Virtual");
	   case 1098: format(modname, sizeof(modname), "Access");
	   case 1100: format(modname, sizeof(modname), "Chrome Grill");
	   case 1101: format(modname, sizeof(modname), "Chrome Flames");
	   case 1102, 1107: format(modname, sizeof(modname), "Chrome Strip");
	   case 1103: format(modname, sizeof(modname), "Convertible Roof");
	   case 1106, 1124: format(modname, sizeof(modname), "Chrome Arches");
	   case 1108, 1133, 1134: format(modname, sizeof(modname), "Chrome Strip");
	   case 1109: format(modname, sizeof(modname), "Chrome");
	   case 1110: format(modname, sizeof(modname), "Slamin");
	   case 1111, 1112: format(modname, sizeof(modname), "Front Sign");
	   case 1115: format(modname, sizeof(modname), "Chrome Front Bullbars");
	   case 1116: format(modname, sizeof(modname), "Slamin Front Bullbars");
	   case 1117, 1174, 1179, 1182, 1189, 1191: format(modname, sizeof(modname), "Chrome");
	   case 1175, 1181, 1185, 1188, 1190: format(modname, sizeof(modname), "Slamin");
	   case 1176, 1180, 1184, 1187, 1192: format(modname, sizeof(modname), "Chrome");
	   case 1177, 1178, 1183, 1186, 1193: format(modname, sizeof(modname), "Slamin");
	   case 1118: format(modname, sizeof(modname), "Chrome Trim");
	   case 1119: format(modname, sizeof(modname), "Wheelcovers");
	   case 1120: format(modname, sizeof(modname), "Chrome Trim");
	   case 1121: format(modname, sizeof(modname), "Wheelcovers");
	   case 1122: format(modname, sizeof(modname), "Chrome Flames");
	   case 1123: format(modname, sizeof(modname), "Bullbar Chrome Bars");
	   case 1125: format(modname, sizeof(modname), "Bullbar Chrome Lights");
	   case 1128: format(modname, sizeof(modname), "Vinyl Hardtop Roof");
	   case 1130: format(modname, sizeof(modname), "Hardtop Roof");
	   case 1131: format(modname, sizeof(modname), "Softtop Roof");
	   case 1140, 1148, 1151, 1156, 1161, 1167: format(modname, sizeof(modname), "X-Flow");
	   case 1141, 1149, 1150, 1154, 1159, 1168: format(modname, sizeof(modname), "Alien");
	   case 1142: format(modname, sizeof(modname), "Oval");
	   case 1143: format(modname, sizeof(modname), "Oval");
	   case 1144: format(modname, sizeof(modname), "Square");
	   case 1145: format(modname, sizeof(modname), "Square");
	   case 1152, 1157, 1165, 1170, 1172, 1173: format(modname, sizeof(modname), "X-Flow");
	   case 1153, 1155, 1160, 1166, 1169, 1171: format(modname, sizeof(modname), "Alien");
	   default: format(modname, sizeof(modname), "");
	   
	}
	return modname;
}
//end