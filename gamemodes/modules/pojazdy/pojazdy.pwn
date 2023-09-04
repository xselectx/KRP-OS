//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pojazdy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	System pojazd�w.
*/

//

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new newcar = GetPlayerVehicleID(playerid);
		if(IsARower(newcar))
		{
  			CruiseControl_Static_TurnOn(playerid, 1);
		}
    }
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetPVarInt(playerid, "timer_StaticCruiseControl")) CruiseControl_Static_TurnOff(playerid);
    if(GetPVarInt(playerid, "timer_CruiseControl")) CruiseControl_TurnOff(playerid);
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerDisconnect(playerid)
{
    CruiseControl_Static_TurnOff(playerid);
    CruiseControl_TurnOff(playerid);
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerConnect(playerid)
{
    if(GetPVarInt(playerid, "timer_StaticCruiseControl")) CruiseControl_Static_TurnOff(playerid);
    if(GetPVarInt(playerid, "timer_CruiseControl")) CruiseControl_TurnOff(playerid);
    pCruiseSpeed[playerid] = DEFAULT_CRUISESPEED;
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
	{
        if(PRESSED(KEY_LOOK_BEHIND) && !GetPVarInt(playerid, "timer_StaticCruiseControl")  && HasItemType(playerid, ITEM_TYPE_TEMPOMAT) != -1)
        {
            new carid;
            carid = GetPlayerVehicleID(playerid);
            if(!IsARower(carid) && !IsABoat(carid) && !IsAPlane(carid))
            {
                if(GetPVarInt(playerid, "timer_CruiseControl"))
                {
                    CruiseControl_TurnOff(playerid);
                }
                else
                {
                    CruiseControl_TurnOn(playerid);
                }
            }
        }
	}
}
//-----------------<[ Funkcje: ]>------------------

CruiseControl_HideTXD(playerid)
{
    PlayerTextDrawHide(playerid, CRUISECONTROL_AMOUNT[playerid]);
}

CruiseControl_SetSpeed(playerid, speed, bool:positive)
{
    if(pCruiseCanChange[playerid] == 1)
    {
        if(pCruiseSpeed[playerid] < 140 && positive)
        {
            pCruiseSpeed[playerid] += speed;
            pCruiseCanChange[playerid] = 0;
            SetTimerEx("CruiseControl_ChangedKeyBool", 400, false, "i", playerid);
        }
        else if(pCruiseSpeed[playerid] > 30 && !positive)
        {
            pCruiseSpeed[playerid] -= speed;
            pCruiseCanChange[playerid] = 0;
            SetTimerEx("CruiseControl_ChangedKeyBool", 400, false, "i", playerid);
        } 
        CruiseControl_UpdateTXD(playerid);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    }
}

CruiseControl_UpdateTXD(playerid)
{
    new updatedMaxSpeed = pCruiseSpeed[playerid];
    new string[128];
    format(string, sizeof(string), "~r~MAX: ~w~%dKM", updatedMaxSpeed);
    PlayerTextDrawSetString(playerid, CRUISECONTROL_AMOUNT[playerid], string);
    PlayerTextDrawShow(playerid, CRUISECONTROL_AMOUNT[playerid]);
}

CruiseControl_ShowTXD(playerid)
{   
    PlayerTextDrawSetString(playerid, CRUISECONTROL_AMOUNT[playerid], "_");
    PlayerTextDrawShow(playerid, CRUISECONTROL_AMOUNT[playerid]);
    CruiseControl_UpdateTXD(playerid);
}

CruiseControl_Static_TurnOff(playerid)
{
    CruiseControl_HideTXD(playerid);
    KillTimer(GetPVarInt(playerid, "timer_StaticCruiseControl"));
    DeletePVar(playerid, "timer_StaticCruiseControl");
    pCruiseCanChange[playerid] = 1;
}


CruiseControl_TurnOff(playerid)
{
    CruiseControl_HideTXD(playerid);
    KillTimer(GetPVarInt(playerid, "timer_CruiseControl"));
    pCruiseSpeed[playerid] = DEFAULT_CRUISESPEED;
    pCruiseTXD[playerid] = 0;
    DeletePVar(playerid, "timer_CruiseControl");
    pCruiseCanChange[playerid] = 1;
}

CruiseControl_TurnOn(playerid)
{
    CruiseControl_ShowTXD(playerid);
    new timer = SetTimerEx("CruiseControl", 200, true, "i", playerid);
    SetPVarInt(playerid, "timer_CruiseControl", timer);
}
Car_AddSlotToQueue(id)
{
    if(strlen(Car_SlotQueue) < 1020)
    {
        new lStr[8];
        format(lStr, 8, "%d|", id);
        strcat(Car_SlotQueue, lStr);
    }
}

Car_GetFromQueue()
{
    new lID[8];
    new pos = strfind(Car_SlotQueue, "|");
    if(pos != -1)
    {
        strmid(lID, Car_SlotQueue, 0, pos);
        strdel(Car_SlotQueue, 0, pos+1);
        return strval(lID);
    }
    return -1;
}

ShowCarsForPlayer(playerid, forplayerid)
{
    new lStr[512], lSlots, lMaxCars = PlayerInfo[playerid][pCarSlots], lID;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		lID = PlayerInfo[playerid][pCars][i];
        if( lID != 0)
        {
            if(CarData[lID][c_UID] == 0) continue;
            if(lSlots < lMaxCars)
            {
                format(lStr, 512, "%s{000000}%d\t{8FCB04}%s\n", lStr, lID, VehicleNames[CarData[lID][c_Model]-400]);
            }
            else
            {
                format(lStr, 512, "%s{000000}-%d\t{888888}%s\n", lStr, lID, VehicleNames[CarData[lID][c_Model]-400]);
            }
            lSlots++;
        }
    }
    if(lSlots > 0) ShowPlayerDialogEx(forplayerid, D_AUTO, DIALOG_STYLE_LIST, "Twoje pojazdy", lStr, "Wybierz", "Anuluj");
    else SendClientMessage(forplayerid, COLOR_GRAD2, "Brak jakichkolwiek pojazd�w!");
}

Car_MakePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0)
        {
            PlayerInfo[playerid][pCars][i] = uid;
            break;
        }
    }

    if(uid >= MAX_CARS) return 0;
    CarData[uid][c_OwnerType] = CAR_OWNER_PLAYER;
    CarData[uid][c_Owner] = PlayerInfo[playerid][pUID];
    CarData[uid][c_Keys] = 0;
    new lStr[256]; 
    format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `KluczykiDoAuta`='0' WHERE `KluczykiDoAuta`='%d'", IDAuta[playerid]);
    mysql_query(lStr);
    Car_Save(uid, CAR_SAVE_OWNER);
    return 1;
}

Car_RemovePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == uid)
        {
            PlayerInfo[playerid][pCars][i] = 0;
            break;
        }
    }
}

Car_Create(model, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{
    new lUID, lStr[256], idx=-1;
    format(lStr, 256, "INSERT INTO `mru_cars` (`model`, `x`, `y`, `z`, `angle`, `color1`, `color2`) VALUES (%d, %.2f, %.2f, %.2f, %.1f, %d, %d)", model, x, y, z, angle, color1, color2);
    if(mysql_query(lStr))
    {
        lUID = mysql_insert_id();

        new bool:doadd=false;
        idx = Car_GetFromQueue();
        if(idx == -1) idx = gCars, doadd=true;

        CarData[idx][c_UID] = lUID;
        CarData[idx][c_ID] = CreateVehicle(model, x, y, z, angle, color1, color2, -1);
        CarData[idx][c_Owner] = 0;
        CarData[idx][c_OwnerType] = 0;
        CarData[idx][c_Model] = model;
        CarData[idx][c_Pos][0] = x;
        CarData[idx][c_Pos][1] = y;
        CarData[idx][c_Pos][2] = z;
        CarData[idx][c_Rot] = angle;
        CarData[idx][c_HP] = 1000.0;
        CarData[idx][c_Tires] = 0;
        CarData[idx][c_Color][0] = color1;
        CarData[idx][c_Color][1] = color2;
        CarData[idx][c_Nitro] = 0;
        CarData[idx][c_bHydraulika] = false;
        CarData[idx][c_Felgi] = 0;
        CarData[idx][c_Malunek] = 3;
        CarData[idx][c_Spoiler] = 0;
        CarData[idx][c_Bumper][0] = 0;
        CarData[idx][c_Bumper][1] = 0;
        CarData[idx][c_Keys] = 0;
        CarData[idx][c_Neon] = 0;
        CarData[idx][c_Rang] = 0;
        CarData[idx][c_Int] = -1;
        CarData[idx][c_VW] = -1;
		CarData[idx][c_Siren] = 0;
        CarData[idx][c_Sideskirt] = 0;
        CarData[idx][c_Hood] = 0;
        CarData[idx][c_Exhaust] = 0;
        CarData[idx][c_Vents] = 0;
        CarData[idx][c_Lamps] = 0;
        CarData[idx][c_Roof] = 0;
        strcat(CarData[idx][c_Rejestracja], "0"); 

        SetVehicleParamsEx(CarData[idx][c_ID], 0, 0, 0, 0, 0, 0, 0);

        VehicleUID[CarData[idx][c_ID]][vUID] = idx;
        if(doadd)
        {
            gCars++;
            return gCars-1;
        }
    }
    return idx;
}

Car_Load()
{
    new lStr[512], lLoad=gCars;
    format(lStr, 128, "SELECT * FROM `mru_cars` WHERE `ownertype` !='%d' AND `ownertype` != '%d'", CAR_OWNER_PLAYER, INVALID_CAR_OWNER);
    mysql_query(lStr);
    mysql_store_result();
    while(mysql_fetch_row_format(lStr, "|"))
    {
        sscanf(lStr, "p<|>ddddfffffddddldddddddddds[32]ddddddd",
        CarData[gCars][c_UID],
        CarData[gCars][c_OwnerType],
        CarData[gCars][c_Owner],
        CarData[gCars][c_Model],
        CarData[gCars][c_Pos][0],
        CarData[gCars][c_Pos][1],
        CarData[gCars][c_Pos][2],
        CarData[gCars][c_Rot],
        CarData[gCars][c_HP],
        CarData[gCars][c_Tires],
        CarData[gCars][c_Color][0],
        CarData[gCars][c_Color][1],
        CarData[gCars][c_Nitro],
        CarData[gCars][c_bHydraulika],
        CarData[gCars][c_Felgi],
        CarData[gCars][c_Malunek],
        CarData[gCars][c_Spoiler],
        CarData[gCars][c_Bumper][0],
        CarData[gCars][c_Bumper][1],
        CarData[gCars][c_Keys],
        CarData[gCars][c_Neon],
        CarData[gCars][c_Rang],
        CarData[gCars][c_Int],
        CarData[gCars][c_VW],
        CarData[gCars][c_Rejestracja],
        CarData[gCars][c_Sideskirt],
        CarData[gCars][c_Hood],
        CarData[gCars][c_Exhaust],
        CarData[gCars][c_Vents],
        CarData[gCars][c_Lamps],
        CarData[gCars][c_Roof],
        CarData[gCars][c_Siren]);

        gCars++;
    }
    mysql_free_result();

    //SPAWN
    for(new i=lLoad;i<gCars;i++)
    {
        new vid = Car_Spawn(i, false);

		//Sultany PD:
		if(CarData[i][c_Siren] == 1)
		{
			if(CarData[i][c_Model] == 411)
				PDTuneInfernus(vid);
			else if(CarData[i][c_Model] == 560)
				PDTuneSultan(vid);
		}

        //Komunikacja miejska napis nad pojazdem
        if((CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_KT && (CarData[i][c_Model] == 431 || CarData[i][c_Model] == 437 || CarData[i][c_Model] == 418)) || (CarData[i][c_OwnerType] == CAR_OWNER_JOB && CarData[i][c_Owner] == JOB_BUSDRIVER))
        {
            if(gKMCounter < sizeof(Busnapisn))
            {
                KomunikacjaMiejsca[CarData[i][c_ID]] = gKMCounter;
                if(CarData[i][c_Model] == 431 || CarData[i][c_Model] == 437) Busnapisn[gKMCounter] = CreateDynamic3DTextLabel("� Komunikacja miejska �", COLOR_BLUE, 0.0,0.0,3.5, 30.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
                else Busnapisn[gKMCounter] = CreateDynamic3DTextLabel("� Komunikacja miejska �", COLOR_BLUE, 0.0,0.0,1.5, 30.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
                gKMCounter++;
            }
        }
        //Opis dla pojazd�w z wypo�yczalni
        if(CarData[i][c_OwnerType] == CAR_OWNER_SPECIAL && CarData[i][c_Owner] == RENT_CAR)
        {
            CarOpis[CarData[i][c_ID]] = CreateDynamic3DTextLabel("Wypo�yczalnia pojazd�w\nGROTTI", COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
        }
        //Obiekty na dachach tax�wek
        if(CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_KT)
        {
            if(CarData[i][c_Model] == 560) AttachDynamicObjectToVehicle(CreateDynamicObject(19310, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, -0.424999, 0.919999, 0.000000, 0.000000, 0.000000); //sultan
            else if(CarData[i][c_Model] == 409) AttachDynamicObjectToVehicle(CreateDynamicObject(19310, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, 0.349999, 0.929999, 0.000000, 0.000000, 0.000000); //lima
            else if(CarData[i][c_Model] == 487) AttachDynamicObjectToVehicle(CreateDynamicObject(19311, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, 1.284999, 1.629998, 0.000000, -0.000001, 90.449951); //heli
        }
        //Obiekty na dachach pojazd�w DMV
        if(CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_GOV)
        {
            new elkaDMV;
            if(CarData[i][c_Model] == 496)
            {
                elkaDMV = CreateDynamicObject(2363,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 24, 1, -1, 255, 0);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.170, -0.230, 0.550, 0.000, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "Urz�d Miasta\nLos Santos", 90, "Ariel", 32, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], -0.020, 1.670, 0.270, 83.800, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 92, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.000, -0.265, 1.147, 17.899, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 92, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.000, -0.535, 1.186, -16.400, 0.000, 0.000);
            }
        }
    }

	//naprawione:
	new qText[128], lText[128], ldesc[128];
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(VehicleUID[i][vUID] == 0) continue;
        if(CarData[VehicleUID[i][vUID]][c_UID] > 0)
		{
			
			format(qText, sizeof(qText), "SELECT `desc` FROM `mru_opisy` WHERE `typ`=2 AND `owner`=%d LIMIT 1", CarData[VehicleUID[i][vUID]][c_UID]);
			mysql_query(qText);
			mysql_store_result();
			if(mysql_num_rows())
			{
				mysql_fetch_row_format(lStr, "|");
				sscanf(lStr, "s[128]", ldesc);
				
				WordWrap(ldesc, true, lText);

				CarOpis[i] = CreateDynamic3DTextLabel(lText, COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, i);
				format(CarOpisCaller[i], MAX_PLAYER_NAME, "SYSTEM");

				strcat(CarDesc[i], ldesc);
			}
		}
	}
	
    mysql_free_result();
    printf("Wczytano %d pojazd�w", gCars-1);
}

Car_LoadEx(lUID)
{
    new lStr[256];
    new lVehID = Car_GetFromQueue(), bool:doadd=false;
    if(lVehID == -1) lVehID = gCars, doadd=true;
    format(lStr, 256, "SELECT * FROM `mru_cars` WHERE `UID`='%d'", lUID);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(lStr, "|");
        sscanf(lStr, "p<|>ddddfffffddddldddddddddds[32]ddddddd",
        CarData[lVehID][c_UID],
        CarData[lVehID][c_OwnerType],
        CarData[lVehID][c_Owner],
        CarData[lVehID][c_Model],
        CarData[lVehID][c_Pos][0],
        CarData[lVehID][c_Pos][1],
        CarData[lVehID][c_Pos][2],
        CarData[lVehID][c_Rot],
        CarData[lVehID][c_HP],
        CarData[lVehID][c_Tires],
        CarData[lVehID][c_Color][0],
        CarData[lVehID][c_Color][1],
        CarData[lVehID][c_Nitro],
        CarData[lVehID][c_bHydraulika],
        CarData[lVehID][c_Felgi],
        CarData[lVehID][c_Malunek],
        CarData[lVehID][c_Spoiler],
        CarData[lVehID][c_Bumper][0],
        CarData[lVehID][c_Bumper][1],
        CarData[lVehID][c_Keys],
        CarData[lVehID][c_Neon],
        CarData[lVehID][c_Rang],
        CarData[lVehID][c_Int],
        CarData[lVehID][c_VW],
        CarData[lVehID][c_Rejestracja],
        CarData[lVehID][c_Sideskirt],
        CarData[lVehID][c_Hood],
        CarData[lVehID][c_Exhaust],
        CarData[lVehID][c_Vents],
        CarData[lVehID][c_Lamps],
        CarData[lVehID][c_Roof],
        CarData[lVehID][c_Siren]);

        if(doadd) gCars++;

        mysql_free_result();
    }
    else return -1;
    return lVehID;
}

Car_LoadForPlayer(playerid)
{
    new lStr[256], lUsed = 0, lPUID = PlayerInfo[playerid][pUID], lList[64], lsID, lsSearch[8];

    for(new i=0;i<MAX_VEHICLES;i++)
    {
        new lcar = VehicleUID[i][vUID];
        if(lcar == 0) continue;
        if(CarData[lcar][c_OwnerType] == CAR_OWNER_PLAYER && CarData[lcar][c_Owner] == lPUID)
        {
            format(lStr, 64, "%d|", CarData[lcar][c_UID]);
            strcat(lList, lStr);
            //Przypisanie auta, kt�re ju� istenije w grze - brak potrzeby ponownego �adowania do systemu, tylko pobranie z bazy.
            PlayerInfo[playerid][pCars][lUsed++] = lcar;
        }
    }

    new lVehID = Car_GetFromQueue();
    if(lVehID == -1) lVehID = gCars;

    format(lStr, 128, "SELECT * FROM `mru_cars` WHERE `ownertype`='%d' AND `owner`='%d'", CAR_OWNER_PLAYER, lPUID);
    mysql_query(lStr);
    mysql_store_result();
    while(mysql_fetch_row_format(lStr, "|"))
    {
        sscanf(lStr, "p<|>d", lsID);
        format(lsSearch, 8, "%d|", lsID);
        if(strfind(lList, lsSearch) == -1)
        {
            sscanf(lStr, "p<|>ddddfffffddddldddddddddds[32]ddddddd",
            CarData[lVehID][c_UID],
            CarData[lVehID][c_OwnerType],
            CarData[lVehID][c_Owner],
            CarData[lVehID][c_Model],
            CarData[lVehID][c_Pos][0],
            CarData[lVehID][c_Pos][1],
            CarData[lVehID][c_Pos][2],
            CarData[lVehID][c_Rot],
            CarData[lVehID][c_HP],
            CarData[lVehID][c_Tires],
            CarData[lVehID][c_Color][0],
            CarData[lVehID][c_Color][1],
            CarData[lVehID][c_Nitro],
            CarData[lVehID][c_bHydraulika],
            CarData[lVehID][c_Felgi],
            CarData[lVehID][c_Malunek],
            CarData[lVehID][c_Spoiler],
            CarData[lVehID][c_Bumper][0],
            CarData[lVehID][c_Bumper][1],
            CarData[lVehID][c_Keys],
            CarData[lVehID][c_Neon],
            CarData[lVehID][c_Rang],
            CarData[lVehID][c_Int],
            CarData[lVehID][c_VW],
            CarData[lVehID][c_Rejestracja],
            CarData[lVehID][c_Sideskirt],
            CarData[lVehID][c_Hood],
            CarData[lVehID][c_Exhaust],
            CarData[lVehID][c_Vents],
            CarData[lVehID][c_Lamps],
            CarData[lVehID][c_Roof],
            CarData[lVehID][c_Siren]);

            PlayerInfo[playerid][pCars][lUsed++] = lVehID;

            lVehID = Car_GetFromQueue();
            if(lVehID == -1) lVehID = ++gCars;
        }
    }
    mysql_free_result();

    new keys = PlayerInfo[playerid][pKluczeAuta];
    if(keys > 0)
    {
        //Wczytanie pojazdu z kluczyk�w
        new id = Car_GetIDXFromUID(keys);
        if(id == -1) Car_LoadEx(keys);
    }
}

Car_UnloadForPlayer(playerid)
{
    new lVehUID;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		lVehUID = PlayerInfo[playerid][pCars][i];
        if(lVehUID <= 0 || lVehUID >= MAX_CARS) continue;
        if(CarData[lVehUID][c_ID] != 0) continue;
        Car_ClearMem(lVehUID);
    }
}

CountPlayerCars(playerid)
{
    new lCount;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0) continue;
        else lCount++;
    }
    return lCount;
}

Car_AddTune(vehicleid)
{
    new uid = VehicleUID[vehicleid][vUID];
    if(CarData[uid][c_Nitro] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Nitro]);
    if(CarData[uid][c_bHydraulika]) AddVehicleComponent(vehicleid, 1087);
    if(CarData[uid][c_Spoiler] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Spoiler]);
    if(CarData[uid][c_Felgi] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Felgi]);
    if(CarData[uid][c_Bumper][0] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Bumper][0]);
    if(CarData[uid][c_Bumper][1] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Bumper][1]);
    if(CarData[uid][c_Sideskirt] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Sideskirt]);
    if(CarData[uid][c_Hood] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Hood]);
    if(CarData[uid][c_Exhaust] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Exhaust]);
    if(CarData[uid][c_Vents] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Vents]);
    if(CarData[uid][c_Lamps] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Lamps]);
    if(CarData[uid][c_Roof] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Roof]);
    ChangeVehiclePaintjob(vehicleid, CarData[uid][c_Malunek]);
    ChangeVehicleColor(vehicleid, CarData[uid][c_Color][0], CarData[uid][c_Color][1]);
}

IsCarOwner(playerid, vehicle, bool:kluczyki=false)
{
    new uid = VehicleUID[vehicle][vUID];
    if(uid == 0) return 0;
    if(kluczyki)
    {
        if(CarData[uid][c_UID] == PlayerInfo[playerid][pKluczeAuta]) return 1;
    }
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(CarData[VehicleUID[vehicle][vUID]][c_Owner] == PlayerInfo[playerid][pUID] && CarData[VehicleUID[vehicle][vUID]][c_OwnerType] == CAR_OWNER_PLAYER)
        {
            return 1;
        }
    }
    return 0;
}

Car_IsValid(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return 1;
}

Car_GetOwnerType(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_OwnerType];
}

Car_GetOwner(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_Owner];
}

Car_Spawn(lUID, bool:loaddesc=true)
{
    if(GetVehicleModel(CarData[lUID][c_ID]) != 0) return 0;

    new vehicleid, expire=-1;

    if(CarData[lUID][c_OwnerType] == CAR_OWNER_JOB)
    {
        expire = 1200; //Respawn co 20 minut dla pojazd�w nale��cych do pracy dorywczej
    }

    if(CarData[lUID][c_Owner] == FRAC_KT)
    {
        if(CarData[lUID][c_Model] == 530) expire = 30;
    }

    if(CarData[lUID][c_Model] == 537 || CarData[lUID][c_Model] == 538)
        vehicleid = AddStaticVehicleEx(CarData[lUID][c_Model], CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_Color][0], CarData[lUID][c_Color][1], expire, CarData[lUID][c_Siren]);
    else
       vehicleid = CreateVehicle(CarData[lUID][c_Model], CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_Color][0], CarData[lUID][c_Color][1], expire, CarData[lUID][c_Siren]);
    VehicleUID[vehicleid][vUID] = lUID;

    new rejestracja[32];
    if(isnull(CarData[lUID][c_Rejestracja]) || strlen(CarData[lUID][c_Rejestracja]) <= 1)
		format(rejestracja, sizeof(rejestracja), "DMV %d", CarData[lUID][c_UID]);
	else
		format(rejestracja, sizeof(rejestracja), "%s", CarData[lUID][c_Rejestracja]);

    SetVehicleNumberPlate(vehicleid, rejestracja);
	RespawnVehicleEx(vehicleid);
	//
    Car_AddTune(vehicleid);
    CarData[lUID][c_ID] = vehicleid;

	SetVehicleHealth(vehicleid, CarData[lUID][c_HP]);

    UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, CarData[lUID][c_Tires]);


    if(CarData[lUID][c_Int] == -1) CarData[lUID][c_Int] = 0;
    LinkVehicleToInterior(vehicleid, CarData[lUID][c_Int]);
    if(CarData[lUID][c_VW] == -1) CarData[lUID][c_VW] = 0;
    SetVehicleVirtualWorld(vehicleid, CarData[lUID][c_VW]);

    SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);

    if(loaddesc) MruMySQL_WczytajOpis(vehicleid, CarData[lUID][c_UID], 2);
    return vehicleid;
}

/*
    Czyszczenie pojazdu z pami�ci - OverLoad Protect
    Podczas unspawnowania pojazdu, sprawdzane jest, czy na serwerze obecnie jest
    w�asciciel pojazdu. Je�eli jest, czyszczenie zostaje pomini�te.
    W przeciwnym wypadku, pojazd ulega usuni�ciu z pami�ci, do kolejki zostaje
    dodany wolny index.
*/

Car_ClearMem(lVehID)
{
    if(CarData[lVehID][c_ID] != 0) VehicleUID[CarData[lVehID][c_ID]][vUID] = 0;
    CarData[lVehID][c_UID]= 0;
    CarData[lVehID][c_ID]= 0;
    CarData[lVehID][c_OwnerType]= 0;
    CarData[lVehID][c_Owner]= 0;
    CarData[lVehID][c_Model]= 0;
    CarData[lVehID][c_Keys]= 0;
    //Uznajemy index za ponowny do u�ycia.
    Car_AddSlotToQueue(lVehID);
}

Car_GetIDXFromUID(lUID)
{
    for(new i=0;i<MAX_CARS;i++)
    {
        if(CarData[i][c_UID] == lUID) return i;
    }
    return -1;
}

Car_Unspawn(v, bool:playercall=false)
{
    if(GetVehicleModel(v) == 0) return 0;
    GetVehicleHealth(v, CarData[VehicleUID[v][vUID]][c_HP]);
    new panels, doors, lights;
    GetVehicleDamageStatus(v, panels, doors, lights, CarData[VehicleUID[v][vUID]][c_Tires]);

    Car_Save(VehicleUID[v][vUID], CAR_SAVE_STATE);
    Car_Save(VehicleUID[v][vUID], CAR_SAVE_TUNE);

	if(VehicleUID[v][vNeon])
   	{
		DestroyDynamicObject(VehicleUID[v][vNeonObject][0]);
   		DestroyDynamicObject(VehicleUID[v][vNeonObject][1]);
		VehicleUID[v][vNeon] = false;
	}
	if(VehicleUID[v][vSiren] != 0)
    {
    	DestroyDynamicObject(VehicleUID[v][vSiren]);
	    VehicleUID[v][vSiren] = 0;
	}
    CarOpis_Usun(INVALID_PLAYER_ID, v);

    DestroyVehicle(v);

    //OverLoad Protect:
    if(CarData[VehicleUID[v][vUID]][c_OwnerType] == CAR_OWNER_PLAYER && !playercall)
    {
        new lOwner = CarData[VehicleUID[v][vUID]][c_Owner], bool:lExist=false;
        new keys = CarData[VehicleUID[v][vUID]][c_Keys];
        foreach(new i : Player)
        {
            if(PlayerInfo[i][pUID] == 0) continue;
            if(PlayerInfo[i][pUID] == lOwner || PlayerInfo[i][pUID] == keys)
            {
                lExist=true;
                break;
            }
        }
        if(!lExist)
        {
            Car_ClearMem(VehicleUID[v][vUID]);
        }
    }
    CarData[VehicleUID[v][vUID]][c_ID] = 0;
    VehicleUID[v][vUID] = 0;
    return 1;
}

Car_Destroy(lV)
{
    if(CarData[lV][c_ID] != 0) Car_Unspawn(CarData[lV][c_ID], true);
    new lStr[64];
    format(lStr, 64, "DELETE FROM `mru_cars` WHERE `UID`='%d'", CarData[lV][c_UID]);
    mysql_query(lStr);

    Car_ClearMem(lV);
}

Car_Save(lUID, lType)
{
    new lStr[256];
    switch(lType)
    {
        case CAR_SAVE_OWNER:
        {
            format(lStr, sizeof(lStr), "UPDATE `mru_cars` SET `owner`='%d', `ownertype`='%d', `keys`='%d', `ranga`='%d' WHERE `UID`='%d'", CarData[lUID][c_Owner], CarData[lUID][c_OwnerType], CarData[lUID][c_Keys], CarData[lUID][c_Rang], CarData[lUID][c_UID]);
            mysql_query(lStr);
        }
        case CAR_SAVE_STATE:
        {
            format(lStr, sizeof(lStr), "UPDATE `mru_cars` SET `model`='%d', `x`='%f', `y`='%f', `z`='%f', `angle`='%.1f', `hp`='%.1f', `tires`='%d', `int`='%d', `vw`='%d' WHERE `UID`='%d'", CarData[lUID][c_Model], CarData[lUID][c_Pos][0], CarData[lUID][c_Pos][1], CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_HP], CarData[lUID][c_Tires], CarData[lUID][c_Int], CarData[lUID][c_VW], CarData[lUID][c_UID]);
            mysql_query(lStr);
        }
        case CAR_SAVE_TUNE:
        {
            format(lStr, sizeof(lStr), "UPDATE `mru_cars` SET `color1`='%d', `color2`='%d', `nitro`='%d', `hydraulika`='%d', `felgi`='%d', `malunek`='%d', `spoiler`='%d', `bumper1`='%d', `bumper2`='%d', `neon`='%d' WHERE `UID`='%d'", CarData[lUID][c_Color][0],CarData[lUID][c_Color][1],CarData[lUID][c_Nitro],CarData[lUID][c_bHydraulika],CarData[lUID][c_Felgi],CarData[lUID][c_Malunek],CarData[lUID][c_Spoiler], CarData[lUID][c_Bumper][0], CarData[lUID][c_Bumper][1], CarData[lUID][c_Neon], CarData[lUID][c_UID]);
            //printf(lStr);
            mysql_query(lStr);
            format(lStr, sizeof(lStr), "UPDATE `mru_cars` SET `sideskirt`='%d', `hood`='%d', `exhaust`='%d', `vent`='%d', `lamps`='%d', `roof`='%d' WHERE `UID`='%d'", CarData[lUID][c_Sideskirt],CarData[lUID][c_Hood],CarData[lUID][c_Exhaust],CarData[lUID][c_Vents],CarData[lUID][c_Lamps], CarData[lUID][c_Roof], CarData[lUID][c_UID]);
            //printf(lStr);
            mysql_query(lStr);
        }
        default:
        {
            Car_Save(lUID, CAR_SAVE_OWNER);
            Car_Save(lUID, CAR_SAVE_STATE);
            Car_Save(lUID, CAR_SAVE_TUNE);
        }
    }
}

//standart
IsABoatModel(carid)
{
	if(carid == 472 || carid == 473 || carid == 493 || carid == 595 || carid == 484 || carid == 430 || carid == 453 || carid == 452 || carid == 446 || carid == 454)//�odzie
	{
		return 1;
	}
	return 0;
}

IsAPlaneModel(carid)
{
	if(carid == 592 || carid == 577 || carid == 511 || carid == 512 || carid == 593 || carid == 520 || carid == 553 || carid == 476 || carid == 519 || carid == 460 || carid == 513)//samoloty
	{
		return 1;
	}
	return 0;
}

IsAHeliModel(carid)
{
    if(carid == 548 || carid == 425 || carid == 417 || carid == 487 || carid == 488 || carid == 497 || carid == 563 || carid == 447 || carid == 469)//helikoptery
	{
		return 1;
	}
    return 0;
}

Car_PrintOwner(car)
{
    new lStr[64];
    new type = CarData[car][c_OwnerType];
    switch(type)
    {
        case INVALID_CAR_OWNER: lStr="Brak";
        case CAR_OWNER_FRACTION:
        {
            format(lStr, sizeof(lStr), "%s", GroupInfo[CarData[car][c_Owner]][g_Name]);
        }
        case CAR_OWNER_PLAYER:
        {
            format(lStr, sizeof(lStr), "SELECT `Nick` FROM mru_konta WHERE `UID`='%d'", CarData[car][c_Owner]);
            mysql_query(lStr);
            mysql_store_result();
            if(mysql_num_rows())
            {
                mysql_fetch_row_format(lStr, "|");
                mysql_free_result();
            }
			else
			{
				format(lStr, sizeof(lStr), "Nieistniej�cy");
			}
        }
        case CAR_OWNER_JOB:
        {
            format(lStr, sizeof(lStr), "%s", JobNames[CarData[car][c_Owner]]);
        }
        case CAR_OWNER_SPECIAL:
        {
            switch(CarData[car][c_Owner])
            {
                case 1: lStr="Wypo�yczalnia";
                case 2: lStr="GoKart";
                case 3: lStr="�u�el";
                default: lStr="Brak";
            }
        }
        case CAR_OWNER_PUBLIC:
        {
            lStr = "Brak";
        }
        default: lStr="Brak";
    }
    return lStr;
}

ShowCarEditDialog(playerid)
{
    new lStr[512], car = GetPVarInt(playerid, "edit-car"), Float:lHP;
    if(CarData[car][c_ID] == 0) lHP = CarData[car][c_HP];
    else GetVehicleHealth(CarData[car][c_ID], lHP);
    new color1 = VehicleColoursTableRGBA[clamp(CarData[car][c_Color][0], 0, 255)], color2=VehicleColoursTableRGBA[clamp(CarData[car][c_Color][1], 0, 255)];
    format(lStr, sizeof(lStr), "{FFFFFF}Model:\t\t{8FCB04}%d{FFFFFF}\t[ {8FCB04}%s {FFFFFF}]\nW�a�ciciel:\t{8FCB04}%s{FFFFFF} � {8FCB04}%s{FFFFFF} (UID: {8FCB04}%d{FFFFFF})\nRanga:\t\t{8FCB04}%d{FFFFFF}\nOpis Pojazdu\nStan:\t\t{8FCB04}%.1f{FFFFFF}\%\nZaparkuj tutaj\nUsu� kluczyki\n{%06x}Kolor I\n{%06x}Kolor II", CarData[car][c_Model], VehicleNames[CarData[car][c_Model]-400], (CarData[car][c_OwnerType] >= 6) ? ("ZBUGOWANY W�A�CICIEL") : (CarOwnerNames[CarData[car][c_OwnerType]]), Car_PrintOwner(car), CarData[car][c_Owner], CarData[car][c_Rang], lHP/10, RGBAtoRGB(color1), RGBAtoRGB(color2));
    ShowPlayerDialogEx(playerid, D_EDIT_CAR_MENU, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}pojazd�w", lStr, "Wybierz", "Wr��");
    return 1;
}

stock GetVehicleSpeed(carid)
{
    new Float:x,Float:y,Float:z,Float:speed,final_speed;
    GetVehicleVelocity(carid,x,y,z);
    speed = VectorSize(x, y, z) * 166.666666;
    final_speed = floatround(speed,floatround_round);
    return final_speed;
}

ShowPlayerCarDialog(playerid, type)
{
    new string[1590];
    for(new i = 0; i<sizeof(SalonAut); i++)
    {
        if(SalonAut[i][sType] == type && SalonAut[i][sActive] == 1)
        {
            strcat(string, sprintf("%d\t%s~n~~g~$%s\n", SalonAut[i][sModel], VehicleNames[SalonAut[i][sModel]-400], SalonAut[i][sCena]));
        }
    }
    DestroySalonDialog(playerid);
    SetPVarInt(playerid, "SalonCurrentType", type);
    string[strlen(string)-1] = '\0';
    ShowPlayerDialogEx(playerid, 450, DIALOG_STYLE_PREVMODEL, "Wybierz pojazd", string, "Wybierz", "Anuluj");
    return 1;
}

GetCarSalonSlotFromModel(modelid)
{
    for(new i = 0; i<sizeof(SalonAut); i++)
    {
        if(SalonAut[i][sModel] == modelid) return i;
    }
    return -1;
}

CreateSalonDialog(playerid, id)
{
    Salon_Background[playerid] = CreatePlayerTextDraw(playerid, 172.000000, 127.000000, "l");
    PlayerTextDrawFont(playerid, Salon_Background[playerid], 1);
    PlayerTextDrawLetterSize(playerid, Salon_Background[playerid], 0.000000, 20.650054);
    PlayerTextDrawTextSize(playerid, Salon_Background[playerid], 464.500000, 22.500000);
    PlayerTextDrawSetOutline(playerid, Salon_Background[playerid], 1);
    PlayerTextDrawSetShadow(playerid, Salon_Background[playerid], 0);
    PlayerTextDrawAlignment(playerid, Salon_Background[playerid], 1);
    PlayerTextDrawColor(playerid, Salon_Background[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Background[playerid], 255);
    PlayerTextDrawBoxColor(playerid, Salon_Background[playerid], 176);
    PlayerTextDrawUseBox(playerid, Salon_Background[playerid], 1);
    PlayerTextDrawSetProportional(playerid, Salon_Background[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Background[playerid], 0);

    Salon_Name[playerid] = CreatePlayerTextDraw(playerid, 172.000000, 127.000000, sprintf("%s", VehicleNames[SalonAut[id][sModel]-400]));
    PlayerTextDrawFont(playerid, Salon_Name[playerid], 1);
    PlayerTextDrawLetterSize(playerid, Salon_Name[playerid], 0.412499, 1.650002);
    PlayerTextDrawTextSize(playerid, Salon_Name[playerid], 464.500000, 22.500000);
    PlayerTextDrawSetOutline(playerid, Salon_Name[playerid], 1);
    PlayerTextDrawSetShadow(playerid, Salon_Name[playerid], 0);
    PlayerTextDrawAlignment(playerid, Salon_Name[playerid], 1);
    PlayerTextDrawColor(playerid, Salon_Name[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Name[playerid], 255);
    PlayerTextDrawBoxColor(playerid, Salon_Name[playerid], 157);
    PlayerTextDrawUseBox(playerid, Salon_Name[playerid], 1);
    PlayerTextDrawSetProportional(playerid, Salon_Name[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Name[playerid], 0);

    Salon_Button[playerid][0] = CreatePlayerTextDraw(playerid, 281.000000, 290.000000, "KUP");
    PlayerTextDrawFont(playerid, Salon_Button[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, Salon_Button[playerid][0], 0.316666, 1.250000);
    PlayerTextDrawTextSize(playerid, Salon_Button[playerid][0], 400.000000, 48.000000);
    PlayerTextDrawSetOutline(playerid, Salon_Button[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, Salon_Button[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, Salon_Button[playerid][0], 2);
    PlayerTextDrawColor(playerid, Salon_Button[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Button[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, Salon_Button[playerid][0], 179);
    PlayerTextDrawUseBox(playerid, Salon_Button[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Salon_Button[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Button[playerid][0], 1);

    Salon_Button[playerid][1] = CreatePlayerTextDraw(playerid, 348.000000, 290.000000, "ANULUJ");
    PlayerTextDrawFont(playerid, Salon_Button[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, Salon_Button[playerid][1], 0.300000, 1.200000);
    PlayerTextDrawTextSize(playerid, Salon_Button[playerid][1], 400.000000, 48.000000);
    PlayerTextDrawSetOutline(playerid, Salon_Button[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, Salon_Button[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, Salon_Button[playerid][1], 2);
    PlayerTextDrawColor(playerid, Salon_Button[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Button[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, Salon_Button[playerid][1], 179);
    PlayerTextDrawUseBox(playerid, Salon_Button[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, Salon_Button[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Button[playerid][1], 1);

    Salon_Model[playerid] = CreatePlayerTextDraw(playerid, 334.000000, 143.000000, "TextDraw");
    PlayerTextDrawFont(playerid, Salon_Model[playerid], 5);
    PlayerTextDrawLetterSize(playerid, Salon_Model[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, Salon_Model[playerid], 131.500000, 134.000000);
    PlayerTextDrawSetOutline(playerid, Salon_Model[playerid], 1);
    PlayerTextDrawSetShadow(playerid, Salon_Model[playerid], 0);
    PlayerTextDrawAlignment(playerid, Salon_Model[playerid], 1);
    PlayerTextDrawColor(playerid, Salon_Model[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Model[playerid], 100);
    PlayerTextDrawBoxColor(playerid, Salon_Model[playerid], 255);
    PlayerTextDrawUseBox(playerid, Salon_Model[playerid], 1);
    PlayerTextDrawSetProportional(playerid, Salon_Model[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Model[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, Salon_Model[playerid], SalonAut[id][sModel]);
    PlayerTextDrawSetPreviewRot(playerid, Salon_Model[playerid], -19.000000, 0.000000, -46.000000, 0.910000);
    PlayerTextDrawSetPreviewVehCol(playerid, Salon_Model[playerid], 1, 1);

    new str[256];
    format(str, sizeof(str), "Predkosc: %dkm/h~n~Cena: $%s~n~Ilosc miejsc: %d~n~Typ: %s~n~Opis: %s", SalonAut[id][sVmax], SalonAut[id][sCena], SalonAut[id][sMiejsca], SalonTypy[SalonAut[id][sType]], Odpolszcz(SalonAut[id][sOpis]));
    Salon_Desc[playerid] = CreatePlayerTextDraw(playerid, 180.000000, 152.000000, str);
    PlayerTextDrawFont(playerid, Salon_Desc[playerid], 1);
    PlayerTextDrawLetterSize(playerid, Salon_Desc[playerid], 0.275000, 1.149999);
    PlayerTextDrawTextSize(playerid, Salon_Desc[playerid], 319.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, Salon_Desc[playerid], 0);
    PlayerTextDrawSetShadow(playerid, Salon_Desc[playerid], 0);
    PlayerTextDrawAlignment(playerid, Salon_Desc[playerid], 1);
    PlayerTextDrawColor(playerid, Salon_Desc[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Salon_Desc[playerid], 255);
    PlayerTextDrawBoxColor(playerid, Salon_Desc[playerid], 50);
    PlayerTextDrawUseBox(playerid, Salon_Desc[playerid], 0);
    PlayerTextDrawSetProportional(playerid, Salon_Desc[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Salon_Desc[playerid], 0);

    PlayerTextDrawShow(playerid, Salon_Background[playerid]);
    PlayerTextDrawShow(playerid, Salon_Name[playerid]);
    PlayerTextDrawShow(playerid, Salon_Button[playerid][0]);
    PlayerTextDrawShow(playerid, Salon_Button[playerid][1]);
    PlayerTextDrawShow(playerid, Salon_Model[playerid]);
    PlayerTextDrawShow(playerid, Salon_Desc[playerid]);

    SelectTextDraw(playerid, COLOR_P@);

    SetPVarInt(playerid, "SalonDialogCreated", 1);
}

DestroySalonDialog(playerid)
{
    if(GetPVarInt(playerid, "SalonDialogCreated") == 1)
    {
        PlayerTextDrawHide(playerid, Salon_Background[playerid]);
        PlayerTextDrawHide(playerid, Salon_Name[playerid]);
        PlayerTextDrawHide(playerid, Salon_Button[playerid][0]);
        PlayerTextDrawHide(playerid, Salon_Button[playerid][1]);
        PlayerTextDrawHide(playerid, Salon_Model[playerid]);
        PlayerTextDrawHide(playerid, Salon_Desc[playerid]);

        PlayerTextDrawDestroy(playerid, Salon_Background[playerid]);
        PlayerTextDrawDestroy(playerid, Salon_Name[playerid]);
        PlayerTextDrawDestroy(playerid, Salon_Button[playerid][0]);
        PlayerTextDrawDestroy(playerid, Salon_Button[playerid][1]);
        PlayerTextDrawDestroy(playerid, Salon_Model[playerid]);
        PlayerTextDrawDestroy(playerid, Salon_Desc[playerid]);

        CancelSelectTextDraw(playerid);

        SetPVarInt(playerid, "SalonDialogCreated", 0);
    }
}

Salon_ConvertStringToInt(string[])
{
    new newText[64];
    format(newText,sizeof(newText), "%s", string);
    strreplace(newText, ".", "");
    return strval(newText);
}

RefreshSalon()
{
	for(new i = 0, j = sizeof(SalonAut); i<j; i++)
		SalonAut[i][sActive] = 0;
	
	SetHalfActiveByType(SALON_TYPE_SPORT);
	SetHalfActiveByType(SALON_TYPE_NORMAL);
	SetHalfActiveByType(SALON_TYPE_LUKS);
	SetHalfActiveByType(SALON_TYPE_OFFROAD);
	SetHalfActiveByType(SALON_TYPE_PICKUP);
	SetHalfActiveByType(SALON_TYPE_KABRIO);
	SetHalfActiveByType(SALON_TYPE_LOWRIDER);
	SetHalfActiveByType(SALON_TYPE_POCKET);
	SetHalfActiveByType(SALON_TYPE_BIKE);
	SetHalfActiveByType(SALON_TYPE_OTHER);
	printf("[Salon Aut] Od�wie�ono salon");
}

SetHalfActiveByType(type)
{
    new count = 0, indices[sizeof(SalonAut)];

    for (new i = 0; i < sizeof(SalonAut); ++i)
    {
        if (SalonAut[i][sType] == type)
        {
            indices[count++] = i;
        }
    }

    for (new i = 0; i < count; ++i)
    {
        new j = random(count);
        new temp = indices[i];
        indices[i] = indices[j];
        indices[j] = temp;
    }
    
    new half = (count % 2 == 0) ? (count / 2) : ((count + 1) / 2);
    for (new i = 0; i < half; ++i)
    {
        SalonAut[indices[i]][sActive] = 1;
    }
}

//-----------------<[ Timery: ]>--------------------
/*

*/
//------------------<[ MySQL: ]>--------------------

//end