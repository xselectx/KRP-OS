//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ wez ]--------------------------------------------------//
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

YCMD:wez(playerid, params[], help)
{
	new string[144];

    if(IsPlayerConnected(playerid))
    {
		new x_job[16];
		new ammount=0;
		if( sscanf(params, "s[16]D", x_job, ammount))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ We� __________________|");
			SendClientMessage(playerid, COLOR_WHITE, "U�yj /wez [nazwa]");
	  		SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Dragi, Kanister, Gasnice, Mundur");
			SendClientMessage(playerid, COLOR_GREEN, "|_________________________________________|");
			return 1;
		}

	    if(strcmp(x_job,"drugs",true) == 0 || strcmp(x_job,"dragi",true) == 0)
		{
			if(ammount == 0)
			{
				sendTipMessage(playerid, "U�yj /wez dragi [ilosc]");
			}
	        if(PlayerInfo[playerid][pDrugs] > 15)
	        {
	            format(string, sizeof(string), "Posiadasz %d gram�w przy sobie, najpierw je sprzedaj !", PlayerInfo[playerid][pDrugs]);
				sendTipMessageEx(playerid, COLOR_GREY, string);
	            return 1;
	        }
	        new tel;
		    new price;
			new level = PlayerInfo[playerid][pDrugsSkill];

			if(level >= 0 && level <= 50)
			{ tel = 5; if(ammount < 1 || ammount > 6) { sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz bra� od 1 do 6g przy tym poziomie Dilera Drag�w!"); return 1; } }
			else if(level >= 51 && level <= 100)
			{ tel = 4; if(ammount < 1 || ammount > 12) { sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz bra� od 1 do 12g przy tym poziomie Dilera Drag�w!"); return 1; } }
			else if(level >= 101 && level <= 200)
			{ tel = 3; if(ammount < 1 || ammount > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz bra� od 1 do 20g przy tym poziomie Dilera Drag�w!"); return 1; } }
			else if(level >= 201 && level <= 400)
			{ tel = 2; if(ammount < 1 || ammount > 30) { sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz bra� od 1 do 30g przy tym poziomie Dilera Drag�w!"); return 1; } }
			else if(level >= 401)
			{ tel = 1; if(ammount < 1 || ammount > 99) { sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz bra� od 1 do 99g przy tym poziomie Dilera Drag�w!"); return 1; } }
		    if (PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, 322.6724,1117.9385,1083.8828) || PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, -1022.34930420,-2158.46484375,33.91813278))
			{
			    price = ammount * tel;
			    if(kaska[playerid] > price)
			    {
			        format(string, sizeof(string), "* Kupi�e� %d gram drag�w za $%d.", ammount, price);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			        ZabierzKaseDone(playerid, price);
					PlayerInfo[playerid][pDrugs] += ammount;
			    }
			    else
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz kupi� drag�w !");
			        return 1;
			    }
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� Dilerem Drag�w albo nie jeste� w melinie !");
			    return 1;
			}
		}
		else if(strcmp(x_job,"fuel",true) == 0 || strcmp(x_job,"kanister",true) == 0 || strcmp(x_job,"paliwo",true) == 0)
		{
		    if(IsAtGasStation(playerid))
			{
			    new price = 20 * MULT_TANKOWANIE;
			    format(string, sizeof(string), "* Wzi��e� kanister z 20L paliwa za $%d",price);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			    PlayerInfo[playerid][pFuel] = 20;
				ZabierzKaseDone(playerid, price);
				return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY," Nie jeste� na stacji benzynowej!");
				return 1;
			}
		}
		else if(strcmp(x_job,"gasnice",true) == 0 || strcmp(x_job,"gasnica",true) == 0)
		{
			if (CheckPlayerPerm(playerid, PERM_MEDIC))
			{
				new vehicleid = GetClosestCar(playerid, 3.5);
				if(vehicleid != -1)
    			{
					if(Car_GetOwnerType(vehicleid) == CAR_OWNER_GROUP && (GetVehicleModel(vehicleid) == 407 || GetVehicleModel(vehicleid) == 544))// wszystkie auta frakcji
					{
						if(IsPlayerInGroup(playerid, Car_GetOwner(vehicleid)))
						{
							format(string, sizeof(string), "*** %s chwyta za now� ga�nic� z wozu stra�ackiego. ***", GetNick(playerid));
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GivePlayerWeapon(playerid, 42, 9999);
	                     	PlayerInfo[playerid][pGun9] = 42;
	                     	PlayerInfo[playerid][pAmmo9] = 9999;
							return 1;
						}
						else
						{
							sendTipMessage(playerid, "Ten w�z stra�acki nie nale�y do LSRC.");
							return 1;
						}
					}
					else
					{
						format(string, sizeof(string), "Ten pojazd nie jest wozem stra�ackim LSRC. (%s)", VehicleNames[GetVehicleModel(vehicleid)-400]);
						sendTipMessage(playerid, string);
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Brak aut w pobli�u.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY, "Komenda dost�pna tylko dla LSRC.");
				return 1;
			}
		}
		else if(strcmp(x_job,"mundur",true) == 0)
		{
			if (CheckPlayerPerm(playerid, PERM_MEDIC))
			{
				new vehicleid = GetClosestCar(playerid, 3.5);
				if(vehicleid != -1)
    			{
					if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && (GetVehicleModel(vehicleid) == 407 || GetVehicleModel(vehicleid) == 544))// wszystkie auta frakcji
					{
						if(IsPlayerInGroup(playerid, Car_GetOwner(vehicleid)))
						{
							if(ERS_mundur[playerid] == 1)
							{
								format(string, sizeof(string), "*** %s zdejmuje z siebie specjalistyczny mundur ***", GetNick(playerid));
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								if(OnDuty[playerid]==0) SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
								else if(PlayerInfo[playerid][pUniform] > 0)  SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
								ERS_mundur[playerid] = 0;
								return 1;
							}
							else
							{
								format(string, sizeof(string), "*** %s przebiera si� w specjalistyczny mundur ***", GetNick(playerid));
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								SetPlayerSkinEx(playerid, 277);
								ERS_mundur[playerid] = 1;
								return 1;
							}
						}
						else
						{
							sendTipMessage(playerid, "Ten w�z stra�acki nie nale�y do LSRC.");
							return 1;
						}
					}
					else
					{
						format(string, sizeof(string), "Ten pojazd nie jest wozem stra�ackim LSRC. (%s)", VehicleNames[GetVehicleModel(vehicleid)-400]);
						sendTipMessage(playerid, string);
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Brak aut w pobli�u.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY, "Komenda dost�pna tylko dla LSRC.");
				return 1;
			}
		}
		else { return 1; }
	}//not connected
	return 1;
}
