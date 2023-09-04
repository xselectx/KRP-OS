// new FabrykaMats_Actor = INVALID_ACTOR_ID;
// new Text3D:FabrykaMats_ActorLabel;

// new Float:FabrykaMats_ActorPos[][] =
// {
// 	{2239.1765,-2258.2468,14.7647,209.8479},
// 	{2201.0283,-2198.6238,13.5547,171.1143},
// 	{2129.9502,-2276.1985,14.7836,146.9646}
// };

// new FabrykaMats_ActorSkins[] =
// {
// 	6,
// 	22,
// 	23,
// 	47
// };

// forward FabrykaActor_ReCreate();

// FabrykaMats_LoadLogic()
// {
// 	// Init Actors
// 	FabrykaActor_ReCreate();

// 	// Init 3Dtexts

// 	CreateDynamic3DTextLabel("Wiedz� ju� o nas!\nBez obaw, nie poddamy si� tak �atwo\nPoszukaj naszych diler�w materia�ami na terenie fabryki", 0xAA3333AA, 2139.1128,-2288.9380,20.6646, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
// 	// Init Timers

// 	SetTimer("FabrykaActor_ReCreate", 900000, true);
// 	return 1;
// }


// public FabrykaActor_ReCreate()
// {

// 	new Float:ActorX, Float:ActorY, Float:ActorZ;

// 	new rand = random(sizeof(FabrykaMats_ActorPos));

// 	ActorX = FabrykaMats_ActorPos[rand][0];
// 	ActorY = FabrykaMats_ActorPos[rand][1];
// 	ActorZ = FabrykaMats_ActorPos[rand][2];

// 	if(FabrykaMats_Actor == INVALID_ACTOR_ID)
// 	{
// 		FabrykaMats_Actor = CreateDynamicActor(FabrykaMats_ActorSkins[random(sizeof(FabrykaMats_ActorSkins))], ActorX, ActorY, ActorZ, FabrykaMats_ActorPos[rand][3]);
// 	}
// 	else
// 	{
// 		SetDynamicActorPos(FabrykaMats_Actor, ActorX, ActorY, ActorZ);
// 		SetDynamicActorFacingAngle(FabrykaMats_Actor, FabrykaMats_ActorPos[rand][3]);
// 	}

// 	if(FabrykaMats_ActorLabel != Text3D:INVALID_3DTEXT_ID)
// 	{
// 		Delete3DTextLabel(FabrykaMats_ActorLabel);
// 	}

// 	new Float:labelZ = ActorZ + 1;

// 	FabrykaMats_ActorLabel = CreateDynamic3DTextLabel("Handlarz materia�ami\nNaci�nij 'Y' aby pogada�", COLOR_GRAD1, ActorX, ActorY, labelZ, 7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);

// 	return 1;
// }

// // FabrykaMats_ActorTalk(playerid)
// // {
// // 	new Float:ActorX, Float:ActorY, Float:ActorZ;
// // 	GetActorPos(FabrykaMats_Actor, ActorX, ActorY, ActorZ);

// // 	if(IsPlayerInRangeOfPoint(playerid, 2, ActorX, ActorY, ActorZ))
// // 	{
// // 		return RunCommand(playerid, "/materialy",  "dostarcz");
// // 	}

// // 	return 1;
// // }

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(PlayerInfo[playerid][pAttached][index]) return 0;
	if(GetPVarInt(playerid, "Tattoo-EditingObj") == 1) return 0;
	if(response)
	{
		if(modelid == 19142) //By niceCzlowiek
		{
			//SetPlayerAttachedObject(playerid, index, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
			//playerid,7,19142,1,0.1,0.05,0.0,0.0,0.0,0.0,1.0,1.2
			
			if(fScaleX > 1.6 || fScaleY > 1.96 || fScaleZ > 1.96 || fScaleX < 0.7 || fScaleY < 0.7 || fScaleZ < 0.7) {
				RemovePlayerAttachedObject(playerid, 7);
				SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
				return sendErrorMessage(playerid, "Zmiany nie zosta�y zapisane, dodatek by� zbyt du�y lub zbyt ma�y!");
			}
			if(fOffsetX > 0.35 || fOffsetY > 0.35 || fOffsetZ > 0.35 || fOffsetX < -0.35 || fOffsetY < -0.35 || fOffsetZ < -0.35) {
				RemovePlayerAttachedObject(playerid, 7);
				SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
				return sendErrorMessage(playerid, "Zmiany nie zosta�y zapisane, dodatek by� zbyt oddalony od gracza!");
			}
			SetPVarFloat(playerid, "k_offsetX", fOffsetX);
			SetPVarFloat(playerid, "k_offsetY", fOffsetY);
			SetPVarFloat(playerid, "k_offsetZ", fOffsetZ);
			SetPVarFloat(playerid, "k_rotX", fRotX);
			SetPVarFloat(playerid, "k_rotY", fRotY);
			SetPVarFloat(playerid, "k_rotZ", fRotZ);
			SetPVarFloat(playerid, "k_scaleX", fScaleX);
			SetPVarFloat(playerid, "k_scaleY", fScaleY);
			SetPVarFloat(playerid, "k_scaleZ", fScaleZ);
			return 1;
			
		}
		if(fOffsetX > 0.95 || fOffsetY > 0.95 || fOffsetZ > 0.95 || fOffsetX < -0.95 || fOffsetY < -0.95 || fOffsetZ < -0.95) 
		{
			RemovePlayerAttachedObject(playerid, index);
			SetPlayerAttachedObject(playerid, index, modelid, boneid, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
			return sendErrorMessage(playerid, "Zmiany nie zosta�y zapisane, dodatek by� zbyt oddalony od gracza!");
		}
		sendTipMessage(playerid, "Zapisano pozycje edycji"); 
		//chwilowe rozwi�zanie (p�ki nie poszerz� tablicy) - tak aby gracz nie musia� edytowa� za ka�dym razem 
		SetPVarFloat(playerid, "d_offsetX", fOffsetX);
		SetPVarFloat(playerid, "d_offsetY", fOffsetY);
		SetPVarFloat(playerid, "d_offsetZ", fOffsetZ);
		SetPVarFloat(playerid, "d_rotX", fRotX);
		SetPVarFloat(playerid, "d_rotY", fRotY);
		SetPVarFloat(playerid, "d_rotZ", fRotZ);
		SetPVarFloat(playerid, "d_scaleX", fScaleX);
		SetPVarFloat(playerid, "d_scaleY", fScaleY);
		SetPVarFloat(playerid, "d_scaleZ", fScaleZ);
	}
	else
	{
		sendErrorMessage(playerid, "Odrzucono zapis obiektu"); 
	}
	
    return 1;
}


Player_RemoveFromVeh(playerid)
{
	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerPos(playerid, slx, sly, slz+1);
	ClearAnimations(playerid);	

	return true;
}


Player_CanUseCar(playerid, vehicleid)
{
	if(IsAScripter(playerid) || IsAHeadAdmin(playerid)) return 1;
	
	new string[128];
	if(GetVehicleModel(vehicleid) == 577 && !IsPlayerInFraction(playerid, FRAC_KT, 5000))
    {
		return 0;
	}
	if (IsAnAmbulance(vehicleid))
	{
		if(!IsAMedyk(playerid))
		{
			sendTipMessageEx(playerid, COLOR_GRAD1, "Nie jeste� medykiem!");
			return 0;
		}
	}

	if(VehicleUID[vehicleid][vUID] != 0)
    {
        new lcarid = VehicleUID[vehicleid][vUID];
	    if(CarData[lcarid][c_OwnerType] == CAR_OWNER_FRACTION)// wszystkie auta grup
	    {
            if(!IsPlayerInGroup(playerid, CarData[lcarid][c_Owner]) && CarData[lcarid][c_Owner] != 11)
            {
                sendTipMessageEx(playerid,COLOR_GREY, "Nie jeste� uprawniony do kierownia tym pojazdem.");
                return 0;
            }
            if(CarData[lcarid][c_Owner] == 11)
            {
                if(IsPlayerInGroup(playerid, 11) && GroupRank(playerid, 11) >= CarData[lcarid][c_Rang]) return 1;
                if(IsPlayerInGroup(playerid, 11) && GroupRank(playerid, 11) < CarData[lcarid][c_Rang])
	        	{
                	format(string, sizeof(string), "Aby kierowa� tym pojazdem potrzebujesz %d rangi!", CarData[lcarid][c_Rang]);
		        	sendTipMessageEx(playerid,COLOR_GREY,string);
		        	return 0;
	        	}
                if(TakingLesson[playerid] == 1) return 1;
                sendTipMessageEx(playerid,COLOR_GREY, "Nie jeste� uprawniony do kierownia tym pojazdem.");
                return 0;
            }
	        if(GroupRank(playerid, CarData[lcarid][c_Owner]) < CarData[lcarid][c_Rang])
	        {
                format(string, sizeof(string), "Aby kierowa� tym pojazdem potrzebujesz %d rangi!", CarData[lcarid][c_Rang]);
		        sendTipMessageEx(playerid,COLOR_GREY,string);
		        return 0;
	        }
	    }
        else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_SPECIAL) //specjalne
        {
            if(CarData[lcarid][c_Owner] == CAR_ZUZEL)
            {
                if(zawodnik[playerid] != 1)
    		    {
    				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Nie jeste� zawodnikiem �u�lowym, zg�o� si� do administracji je�li chcesz nim zosta�.");
    				return 0;
    			}
            }
        }
        else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_JOB) //reszta do pracy
        {
            if(CarData[lcarid][c_Owner] == PlayerInfo[playerid][pJob])
            {
                new bool:wywal;
                switch(PlayerInfo[playerid][pJob])
                {
                    case JOB_LOWCA: if(PlayerInfo[playerid][pDetSkill] < CarData[lcarid][c_Rang]) wywal=true;
                    case JOB_LAWYER: if(PlayerInfo[playerid][pLawSkill] < CarData[lcarid][c_Rang]) wywal=true;
                    case JOB_MECHANIC: if(PlayerInfo[playerid][pMechSkill] < CarData[lcarid][c_Rang]) wywal=true;
                    case JOB_BUSDRIVER: if(PlayerInfo[playerid][pCarSkill] < CarData[lcarid][c_Rang]) wywal=true;
                    case JOB_TRUCKER: if(PlayerInfo[playerid][pTruckSkill] < CarData[lcarid][c_Rang]) wywal=true;
                    default: wywal=false;
                }
                if(wywal)
                {
					new skill = 0;
					switch(PlayerInfo[playerid][pJob])
					{
						case JOB_LOWCA: skill = PlayerInfo[playerid][pDetSkill];
						case JOB_LAWYER: skill = PlayerInfo[playerid][pLawSkill];
						case JOB_MECHANIC: skill = PlayerInfo[playerid][pMechSkill];
						case JOB_BUSDRIVER: skill = PlayerInfo[playerid][pCarSkill];
						case JOB_TRUCKER: skill = PlayerInfo[playerid][pTruckSkill];
						default: wywal=false;
					}
                    sendTipMessageEx(playerid,COLOR_GREY,sprintf("Aby prowadzi� ten pojazd potrzebujesz %d skilla w zawodzie %s.", CarData[lcarid][c_Rang], JobNames[CarData[lcarid][c_Owner]]));
					sendTipMessageEx(playerid,COLOR_GREY,sprintf("Twoje punkty skilla w zawodzie %s wynosz�: %d pkt", JobNames[CarData[lcarid][c_Owner]], skill));
                    return 0;
                }
				if(GetVehicleModel(vehicleid) == 578 && PlayerInfo[playerid][pLevel] == 1)
				{
					format(string, sizeof(string), "Musisz mie� 2 level aby prowadzi� tym pojazdem.");
                    sendTipMessageEx(playerid,COLOR_GREY,string);
					return 0;
				}
            }
            else
            {
                if(CarData[lcarid][c_Owner] == JOB_BUSDRIVER)
                {
                    if(IsPlayerInGroup(playerid, FRAC_KT)) return 1;
                }
                if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                format(string, sizeof(string), "Aby prowadzi� ten pojazd musisz by� w zawodzie %s.", JobNames[CarData[lcarid][c_Owner]]);
                sendTipMessageEx(playerid,COLOR_GREY,string);
				return 0;
            }
            if(CarData[lcarid][c_Owner] == JOB_BUSDRIVER) sendTipMessageEx(playerid, COLOR_YELLOW, "SERVER: Wpisz /trasa aby rozpocz�� prac�");
        }
        else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_PLAYER) //Pojazdy graczy
        { 
            if(IsCarOwner(playerid, vehicleid, true))
	        {
                if(CarData[lcarid][c_Keys] != 0 && CarData[lcarid][c_Owner] != PlayerInfo[playerid][pUID])
                {
                    if(CarData[lcarid][c_Keys] != PlayerInfo[playerid][pUID])
    	       	    {
                        sendTipMessageEx(playerid, COLOR_NEWS, "Kluczyki od tego pojazdu zosta�y zabrane przez w�a�ciciela.");
                        PlayerInfo[playerid][pKluczeAuta] = 0;
    				   	return 0;
    	       	    }
                }
	       	}
	       	else
	       	{
	       	    sendTipMessageEx(playerid, COLOR_NEWS, "Nie masz kluczy do tego pojazdu, a zabezpieczenia s� zbyt dobre aby� m�g� go ukra��.");
	       		return 0;
	       	}
        }
    }
	if(IsACopCar(vehicleid))
	{
	    if(IsAPolicja(playerid))
	    {
	        if(OnDuty[playerid] == 0)
	        {
	            if(GetVehicleModel(vehicleid) != 445)
	            {
	            	sendTipMessageEx(playerid, COLOR_GREY, "Musisz by� na s�u�bie aby je�dzi� autem policyjnym !");
                    return 0;
	            }
	        }
	    }
	}

	if(IsABoat(vehicleid))
	{
	    if(PlayerInfo[playerid][pBoatLic] < 1)
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie wiesz w jaki spos�b p�ywa� �odzi�, wi�c decydujesz si� j� opu�ci� !");
		    return 0;
		}
	}
	else if(IsAPlane(vehicleid))
	{
	    antyczolg[playerid] ++;
	    if(PlayerInfo[playerid][pFlyLic] < 1)
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie wiesz w jaki spos�b lata� samolotem, wi�c decydujesz si� go opu�ci� !");
			return 0;
		}
	}

	return 1;
}
