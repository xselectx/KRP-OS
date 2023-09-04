//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ materialy ]-----------------------------------------------//
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

YCMD:materialy(playerid, params[], help)
{
	//return 0;
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if (PlayerInfo[playerid][pJob] != 9)
		{
		    sendTipMessageEx(playerid,COLOR_GREY,"Nie jeste� dilerem broni !");
		    return 1;
		}
		new x_nr[16];
		new moneys=0;
		if( sscanf(params, "s[16]D(10)", x_nr, moneys))
		{
			sendTipMessage(playerid, "U�yj /mats [nazwa]");
			sendTipMessage(playerid, "Dost�pne nazwy: Wez, Dostarcz.");
			return 1;
		}
		if(strcmp(x_nr,"get",true) == 0 || strcmp(x_nr,"wez",true) == 0)
		{
		    if(PlayerToPoint(4.0,playerid,597.1277,-1248.6479,18.2734))
		    {
		        if(MatsHolding[playerid] >= 10)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz miejsca na wi�cej paczek !");
			        return 1;
		        }

		        if(moneys == 0)
				{
					sendTipMessage(playerid, "U�yj /mats get [ammount]");
					return 1;
				}

				if(moneys < 1 || moneys > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Ilo�� paczek od 1 do 10 !"); return 1; }
				new price = moneys * MULT_MATS;
				if(kaska[playerid] > price)
				{
				    format(string, sizeof(string), "* Kupi�e� %d paczek materia��w za $%d jed� do nowej przetw�rni materia��w. Dok�adn� lokalizacj� musisz ustali� sam.", moneys, price);
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				    ZabierzKaseDone(playerid, price);
				    MatsHolding[playerid] = moneys;
					SetPlayerCheckpoint(playerid, 2185, -2261, 13.42, 15);
				    SetTimerEx("Matsowanie", 70000 ,0,"d",playerid);
				    MatsGood[playerid] = 1;
				}
				else
				{
				    format(string, sizeof(string), "Nie masz $%d !", price);
				    sendTipMessageEx(playerid, COLOR_GREY, string);
				}
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w fabryce materia��w w Los Santos !");
		        return 1;
		    }
		}
		else if(strcmp(x_nr,"deliver",true) == 0 || strcmp(x_nr,"dostarcz",true) == 0)
		{
											// 1.5
            if(IsPlayerInRangeOfPoint(playerid, 3, MatsPoint[0], MatsPoint[1], MatsPoint[2]) && GetPlayerVirtualWorld(playerid) == 0) 
		    {
		        if(MatsHolding[playerid] > 0)
		        {
		            if(MatsGood[playerid] != 1)
		            {
						if(Item_Count(playerid)+1>GetPlayerItemLimit(playerid))
							return sendErrorMessage(playerid, "Przekroczy�e� limit przedmiot�w. Zniszcz co� z twojego ekwipunku, aby m�c dostarczy� matsy!");
			            new mnoznik = 40;
						new payout = (mnoznik)*(MatsHolding[playerid]);
			            format(string, sizeof(string), "Dosta�e� od handlarza %d materia��w z twoich %d paczek mats", payout, MatsHolding[playerid]);
					    sendTipMessage(playerid, string);
                        if(PlayerInfo[playerid][pMiserPerk] > 0) {
                            new poziom = PlayerInfo[playerid][pMiserPerk];
                            //PlayerInfo[playerid][pMats] += poziom*30;
							payout += poziom*30;
                            format(string, sizeof(string), "Dzi�ki ulepszeniu MATSIARZ otrzymujesz dodatkowo %d mats", poziom*30);
                            sendTipMessage(playerid, string);
                        }
			            //PlayerInfo[playerid][pMats] += payout;
						Item_Add("Materia�y", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, payout, ITEM_NOT_COUNT);
						LVLAddMats(playerid);
			            MatsHolding[playerid] = 0;
			            DisablePlayerCheckpoint(playerid);
			        }
			        else
			        {
			            GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, pow�d: teleport", sendername);
                        SendPunishMessage(string, playerid);
						Log(punishmentLog, WARNING, "%s dosta� kicka od antycheata, pow�d: teleport do mats�w", GetPlayerLogName(playerid));
			        	KickEx(playerid);
			        	return 1;
		        	}
		        }
		        else
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz paczek z materia�ami !");
			        return 1;
		        }
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� przy odbiorze paczek materia��w!");
		        return 1;
		    }
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Z�a nazwa !");
		    return 1;
		}
	}
	return 1;
}
