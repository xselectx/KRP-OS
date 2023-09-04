//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pizzaman                                                 //
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
// Data utworzenia: 09.05.2021
//Opis:
/*
	Praca dorywcza Pizzaboya
*/

//

//-----------------<[ Funkcje: ]>-------------------
public Float:GetDistanceBetweenXYZ(playerid,Float:x2,Float:y2,Float:z2)
{
    new Float:x1,Float:y1,Float:z1;
    if(!IsPlayerConnected(playerid)) {
        return -1.00;
    }
    GetPlayerPos(playerid,x1,y1,z1);
    return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

public PizzaboyTimer(playerid)
{
	new str[128];
	new Time_Formatted[64];
	
	if(Pizzaboy_Time[playerid] < 60) format(Time_Formatted, sizeof(Time_Formatted), "%ds", Pizzaboy_Time[playerid]);
	else format(Time_Formatted, sizeof(Time_Formatted), "%dm %02ds", Pizzaboy_Time[playerid]/60, Pizzaboy_Time[playerid]%60);

	if(Pizzaboy_Time[playerid] <= 500)
	{
		PlayerTextDrawSetString(playerid, pizza_td[playerid], 
		sprintf("%s~n~Czas: %s~n~Pizze: %d~n~Dostarczone: %d~n~Zarobione: $%d", 
		Pizzaboy_State_Text[Pizzaboy_State[playerid]],
		Time_Formatted,
		Pizzaboy_Pizza_Quant[playerid],
		Pizzaboy_Delivered[playerid],
		Pizzaboy_Earned[playerid]));
	} 
	else
	{
		PlayerTextDrawSetString(playerid, pizza_td[playerid], 
		sprintf("%s~n~Pizze: %d~n~Dostarczone: %d~n~Zarobione: $%d", 
		Pizzaboy_State_Text[Pizzaboy_State[playerid]],
		Pizzaboy_Pizza_Quant[playerid],
		Pizzaboy_Delivered[playerid],
		Pizzaboy_Earned[playerid]));
	}

	Pizzaboy_Time[playerid]--;

	if(Pizzaboy_Time[playerid] > 9990 && Pizzaboy_Time[playerid] < 9999) // anty bug
	{
		Pizzaboy_Delete_Customer(playerid);
		Pizzaboy_Add_Customer(playerid);
		Pizzaboy_Pizza_Quant[playerid]--;
	}

	if(Pizzaboy_State[playerid] == PIZZABOY_STATE_GETPIZZA || Pizzaboy_State[playerid] == PIZZABOY_STATE_GOTOCAR || Pizzaboy_State[playerid] == PIZZABOY_STATE_GOBACK)
	{
		if(Pizzaboy_Time[playerid] >= 0)
		{
			if(Pizzaboy_State[playerid] == PIZZABOY_STATE_GETPIZZA || Pizzaboy_State[playerid] == PIZZABOY_STATE_GOBACK)
			{
				if(GetPlayerVirtualWorld(playerid) == PIZZABOY_PIZZERIA_VW && GetPlayerInterior(playerid) == PIZZABOY_PIZZERIA_INT)
					SetPlayerCheckpoint(playerid, Pizzaboy_Main_Locations[1][0], Pizzaboy_Main_Locations[1][1], Pizzaboy_Main_Locations[1][2], 2);
			} 
			else if(Pizzaboy_State[playerid] == PIZZABOY_STATE_GOTOCAR)
			{
				if(((Pizzaboy_Only == 1 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 448) || Pizzaboy_Only == 0) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					Pizzaboy_Add_Customer(playerid);
			}
		} 
		else
		{
			Pizzaboy_End(playerid);
			GameTextForPlayer(playerid, "~r~Anulowano prace!", 2500, 4);
		}
	}
	else if(Pizzaboy_State[playerid] == PIZZABOY_STATE_PACKING)
	{
		if(Pizzaboy_Time[playerid] >= 0)
		{
			if(GetPlayerVirtualWorld(playerid) == PIZZABOY_PIZZERIA_VW && GetPlayerInterior(playerid) == PIZZABOY_PIZZERIA_INT && 
			   IsPlayerInRangeOfPoint(playerid, 3, Pizzaboy_Main_Locations[1][0], Pizzaboy_Main_Locations[1][1], Pizzaboy_Main_Locations[1][2]))	
			{
				ApplyAnimation(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
				if(PlayerInfo[playerid][pPizzaboySkill] < 50) 														Pizzaboy_Pizza_Quant[playerid]++;
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 50  && PlayerInfo[playerid][pPizzaboySkill] < 100)  Pizzaboy_Pizza_Quant[playerid]++;
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 100 && PlayerInfo[playerid][pPizzaboySkill] < 200) 	Pizzaboy_Pizza_Quant[playerid]+=2;
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 200 && PlayerInfo[playerid][pPizzaboySkill] < 400) 	Pizzaboy_Pizza_Quant[playerid]+=2;
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 400)											   	Pizzaboy_Pizza_Quant[playerid]+=3;
			} else {
				if(GetPlayerVirtualWorld(playerid) == PIZZABOY_PIZZERIA_VW && GetPlayerInterior(playerid) == PIZZABOY_PIZZERIA_INT) {
					SetPlayerCheckpoint(playerid, Pizzaboy_Main_Locations[1][0], Pizzaboy_Main_Locations[1][1], Pizzaboy_Main_Locations[1][2], 2); 
				}
				GameTextForPlayer(playerid, "Wroc po pizze!", 2500, 4);
			}
		} else
		{
			ClearAnimations(playerid, 1);
			SendClientMessage(playerid, COLOR_GREEN, "-------------- {FFFFFF}PIZZABOY {33AA33}--------------");
			if(Pizzaboy_Only == 1) {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Zapakowa³eœ pizzê! Udaj siê teraz do skutera pizzerii i zawieŸ pizzê klientom!");
			}
			else {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Zapakowa³eœ pizzê! Udaj siê teraz do pojazdu i zawieŸ pizzê klientom!");
			}
			Pizzaboy_State[playerid] = PIZZABOY_STATE_GOTOCAR;
			Pizzaboy_Time[playerid] = PIZZABOY_TIME_GOTOCAR;
		}
	}
	else if(Pizzaboy_State[playerid] == PIZZABOY_STATE_DELIVER)
	{
		if(Pizzaboy_Time[playerid] >= 0)
		{
			new r = Pizzaboy_Random[playerid];
			new Float:a = Pizzaboy_Order_Locations[r][3];
			if(((Pizzaboy_Only == 1 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 448) || Pizzaboy_Only == 0) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				if(Pizzaboy_Time[playerid] == Pizzaboy_Travel_Time[playerid]/2) {
					GameTextForPlayer(playerid, "~g~ Pospiesz sie!", 3000, 4);
				}
				SetPlayerCheckpoint(playerid, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2], 1);
			} else {
				if(GetPlayerState(playerid) != PLAYER_STATE_ENTER_VEHICLE_DRIVER || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					if(!IsPlayerInRangeOfPoint(playerid, 30, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2]))
					{
						GameTextForPlayer(playerid, "Wroc do pojazdu!", 2500, 4);
					}
				}
				
			}
		} else
		{
			Pizzaboy_Time[playerid] = PIZZABOY_TIME_RESTART;
			Pizzaboy_Pizza_Quant[playerid]--;

			if(Pizzaboy_Pizza_Quant[playerid] <= 0)
			{
				Pizzaboy_Time[playerid] = 0;
				Pizzaboy_State[playerid] = PIZZABOY_STATE_PICKUP;
				Pizzaboy_Delete_Customer(playerid);
				return 1;
			}

			Pizzaboy_Delete_Customer(playerid);
			Pizzaboy_Add_Customer(playerid);
			GameTextForPlayer(playerid, "~r~Spozniles sie! Klient zrezygnowal!", 2500, 4);
			SetTimerEx("GameTextForPlayer", 2400, false, "dsdd", playerid, "~g~Dostarcz pizze!", 2500, 4);
		}
	}
	else if(Pizzaboy_State[playerid] == PIZZABOY_STATE_PICKUP)
	{
		if(Pizzaboy_Time[playerid] >= 0)
		{
			new r = Pizzaboy_Random[playerid];
			new Float:a = Pizzaboy_Order_Locations[r][3];
			if(IsPlayerInRangeOfPoint(playerid, 2, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2]))
			{
				if((((Pizzaboy_Only == 1 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 448) || Pizzaboy_Only == 0) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER))
				{ 
					if(GetPlayerState(playerid) != PLAYER_STATE_ENTER_VEHICLE_DRIVER || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					{
						if(!IsPlayerInRangeOfPoint(playerid, 30, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2]))
						{
							GameTextForPlayer(playerid, "Wroc do pojazdu!", 2500, 4);
						}
					}
				}
			}
			else 
			{
				SetPlayerCheckpoint(playerid, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2], 1);
				GameTextForPlayer(playerid, "Wroc do klienta!", 2500, 4);
			}
		} 
		else
		{
			Pizzaboy_Time[playerid] = PIZZABOY_TIME_RESTART;
			
			if(Pizzaboy_Pizza_Quant[playerid] > 0)
			{
				GameTextForPlayer(playerid, "~g~Dostarczono!", 2500, 4);

				Pizzaboy_Delivered[playerid]++;
				Pizzaboy_State[playerid] = 99;

				new name[24], text[128], moneyEvent, moneyToTip;
				new rarerand, rand;
				format(name, sizeof(name), "%s", Pizzaboy_Actor_Name_String[playerid]);
				name[strfind(name, "_", false)] = ' ';

				new TimePassed = Pizzaboy_Travel_Time[playerid] - Pizzaboy_Taveled_Time[playerid];
				if(TimePassed <= 15)
				{
					//format(str, sizeof(str), "AdmWarning: %s [%d] dostarczy³ pizzê w mniej ni¿ 15 sekund.", GetNick(playerid), playerid);
					//SendAdminMessage(COLOR_YELLOW, str);
					// cziter 60%
				}
				new math = floatround(((float(TimePassed)/float(Pizzaboy_Travel_Time[playerid]))) * 100);
				if(math <= 10)
				{
					new kick, liczba_adminow;
					format(str, sizeof(str), "AdmWarning: %s [%d] najprawdopodobniej teleportuje siê na Pizzaboyu.", GetNick(playerid), playerid);
					SendAdminMessage(COLOR_YELLOW, str);
					kick = 1;
					liczba_adminow = 0;
					foreach(new i : Player)
    				{
    				    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1)
    				    {
    				    	kick = 0;
    				    	liczba_adminow++;
    				    }
    				}
    				if(kick == 1 || (liczba_adminow == 1 && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)))
    				{
    					format(str, sizeof(str), "Zosta³eœ skickowany z podejrzeniem o TPHack");
    					SendClientMessage(playerid, COLOR_LIGHTRED, str);
    					KickEx(playerid);
    				}
					//cziter 90%
				}
				if(math <= 50)
				{
					rarerand = random(PIZZABOY_RARE_CHANCE);
					if(rarerand != 1)
					{
						rand = random(sizeof(Pizzaboy_Lines_Good));
						format(text, sizeof(text), "%s mówi: %s", name, Pizzaboy_Lines_Good[rand]);
					} else {
						rand = random(sizeof(Pizzaboy_Lines_Rare));
						format(text, sizeof(text), "%s mówi: %s", name, Pizzaboy_Lines_Rare[rand]);
						if(rand == 0)
						{
							moneyEvent = 0;
						} 
						else if(rand > sizeof(Pizzaboy_Lines_Rare)-3 && rand < sizeof(Pizzaboy_Lines_Rare))
						{
							moneyEvent = 3;				
						}

					}
				} else if(math > 50 && math < 80)
				{
					rand = random(sizeof(Pizzaboy_Lines_Avg));
					format(text, sizeof(text), "%s mówi: %s", name, Pizzaboy_Lines_Avg[rand]);
					if(rand == 0)
					{
						moneyEvent = 1;
					} 
				} else {
					rand = random(sizeof(Pizzaboy_Lines_Bad));
					format(text, sizeof(text), "%s mówi: %s", name, Pizzaboy_Lines_Bad[rand]);
					if(rand == 0 || rand == 1)
					{
						moneyEvent = 1;
					} 
				}

				ProxDetector(20.0, playerid, text,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

				moneyToTip = floatround((1.0 - ((float(TimePassed)/float(Pizzaboy_Travel_Time[playerid])))) * PIZZABOY_TIP);
				if(moneyToTip <= 0) // anty minus kasy
				{
					moneyToTip = 0;
				}
				if(moneyToTip >= PIZZABOY_TIP) // anty EWENTUALNY bug na kase
				{
					moneyToTip = PIZZABOY_TIP;
				}
				if(moneyEvent == 1)
				{
					moneyToTip = 0;
				} 
				else if (moneyEvent == 3)
				{
					moneyToTip+=PIZZABOY_RARE_TIP;
					if(moneyToTip >= PIZZABOY_RARE_TIP+PIZZABOY_TIP) // anty EWENTUALNY bug na kase
					{
						moneyToTip = PIZZABOY_RARE_TIP+PIZZABOY_TIP;
					}
				}

				Pizzaboy_Earned[playerid]+=moneyToTip;
				Pizzaboy_Pizza_Quant[playerid]--;

				if(Pizzaboy_Pizza_Quant[playerid] == 0)
				{
					Pizzaboy_Time[playerid] = 0;
					Pizzaboy_State[playerid] = 5;
				} else 
				{
					Pizzaboy_Delete_Customer(playerid);
					Pizzaboy_Add_Customer(playerid);
				}
			} else {

				Pizzaboy_Delete_Customer(playerid);
				new bonus;
				bonus = PIZZABOY_END_MONEY*Pizzaboy_Delivered[playerid];

				if(PlayerInfo[playerid][pPizzaboySkill] >= 50 && PlayerInfo[playerid][pPizzaboySkill] < 100) bonus = floatround(bonus*1.25);
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 100 && PlayerInfo[playerid][pPizzaboySkill] < 200) bonus = floatround(bonus*1.6);
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 200 && PlayerInfo[playerid][pPizzaboySkill] < 400) bonus = floatround(bonus*2);
				else if(PlayerInfo[playerid][pPizzaboySkill] >= 400) bonus = floatround(bonus*2.25);

				SendClientMessage(playerid, COLOR_GREEN, "-------------- {FFFFFF}PIZZABOY {33AA33}--------------");
				format(str, sizeof(str), "Zarobi³eœ $%d i bonusowe $%d. £¹cznie dostajesz $%d!.",Pizzaboy_Earned[playerid], bonus, bonus + Pizzaboy_Earned[playerid]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
				format(str, sizeof(str), "Aby kontynuowaæ jedŸ po kolejn¹ pizzê. Lub wpisz{FFFFFF} /pizzaboy{00C2EC} by zakoñczyæ pracê.");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, str);

				DajKaseDone(playerid, bonus + Pizzaboy_Earned[playerid]);

				Pizzaboy_State[playerid] = PIZZABOY_STATE_GOBACK;
				Pizzaboy_Time[playerid] = 999;
				Pizzaboy_Travel_Time[playerid] = 0;
				Pizzaboy_Taveled_Time[playerid] = 0;
				Pizzaboy_Earned[playerid] = 0;
				Pizzaboy_Travel_Distance[playerid] = 0;
				Pizzaboy_Pizza_Quant[playerid] = 0;
				Pizzaboy_Random[playerid] = 0;
				Pizzaboy_Actor[playerid] = 0;
				Pizzaboy_Actor_Name[playerid] = Text3D:-1;
				Pizzaboy_Anti_Loop[playerid] = 0;
				
				if(PlayerInfo[playerid][pPizzaboySkill] <= 400)
				{
					SendClientMessage(playerid, COLOR_GRAD2, sprintf("Skill Pizzaboya +%d", Pizzaboy_Delivered[playerid]));
					PlayerInfo[playerid][pPizzaboySkill]+=Pizzaboy_Delivered[playerid];
				}
				Pizzaboy_Delivered[playerid] = 0;

			}
		}
	}
	return 1;
}

Pizzaboy_CreateTextDraws(playerid)
{

	pizza_td[playerid] = CreatePlayerTextDraw(playerid, 527.000000, 238.000000, "Status~n~Czas: 0s~n~Pizze: 0~n~Dostarczone: 0~n~Zarobione: $0");
	PlayerTextDrawFont(playerid, pizza_td[playerid], 1);
	PlayerTextDrawLetterSize(playerid, pizza_td[playerid], 0.270833, 1.050000);
	PlayerTextDrawTextSize(playerid, pizza_td[playerid], 630.000000, 0);
	PlayerTextDrawSetOutline(playerid, pizza_td[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pizza_td[playerid], 0);
	PlayerTextDrawAlignment(playerid, pizza_td[playerid], 1);
	PlayerTextDrawColor(playerid, pizza_td[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pizza_td[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pizza_td[playerid], 120);
	PlayerTextDrawUseBox(playerid, pizza_td[playerid], 1);
	PlayerTextDrawSetProportional(playerid, pizza_td[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pizza_td[playerid], 0);
}

Pizzaboy_DestroyTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, pizza_td[playerid]);
}

Pizzaboy_Start(playerid)
{
	SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}PIZZABOY {33AA33}--------------");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Witaj w pracy dostawcy pizzy! IdŸ do pizzerii i {FFFFFF}wez pizze {00C2EC}z kuchni.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Aby anulowaæ wpisz jeszcze raz{FFFFFF} /pizzaboy");
	
	Pizzaboy_CreateTextDraws(playerid);
	PlayerTextDrawSetString(playerid, pizza_td[playerid], "Wez pizze~n~Czas: 2m 00s~n~Pizze: 0~n~Dostarczone: 0~n~Zarobione: $0");
	PlayerTextDrawShow(playerid, pizza_td[playerid]);

	Pizzaboy_Timer[playerid] = SetTimerEx("PizzaboyTimer", 1000, true, "d", playerid);
}

Pizzaboy_End(playerid) // warto dodaæ do OnPlayerDisconnect, OnPlayerDeath itd. po sprawdzeniu if(Pizzaboy_Active[playerid])
{
	KillTimer(Pizzaboy_Timer[playerid]);
	Pizzaboy_Delete_Customer(playerid);
	DisablePlayerCheckpoint(playerid);

	Pizzaboy_State[playerid] = 0;
	Pizzaboy_Timer[playerid] = 0;
	Pizzaboy_Time[playerid] = 0;
	Pizzaboy_Travel_Time[playerid] = 0;
	Pizzaboy_Taveled_Time[playerid] = 0;
	Pizzaboy_Earned[playerid] = 0;
	Pizzaboy_Travel_Distance[playerid] = 0;
	Pizzaboy_Pizza_Quant[playerid] = 0;
	Pizzaboy_Random[playerid] = 0;
	Pizzaboy_Actor[playerid] = 0;
	Pizzaboy_Actor_Name[playerid] = Text3D:-1;
	Pizzaboy_Anti_Loop[playerid] = 0;
	Pizzaboy_Delivered[playerid] = 0;
	Pizzaboy_Active[playerid] = false;

	PlayerTextDrawHide(playerid, pizza_td[playerid]);
	Pizzaboy_DestroyTextDraws(playerid);
}


Pizzaboy_Add_Customer(playerid)
{
	new rloc = random(sizeof(Pizzaboy_Order_Locations));
	while((rloc == Pizzaboy_Random[playerid] || Pizzaboy_Customers_In_Use[rloc] == 1) && Pizzaboy_Anti_Loop[playerid] < 50)
	{
		Pizzaboy_Time[playerid] = 9999;
		rloc = random(sizeof(Pizzaboy_Order_Locations));
		Pizzaboy_Anti_Loop[playerid]++;
	}
	if(Pizzaboy_Anti_Loop[playerid] >= 50)
	{
		GameTextForPlayer(playerid, "~r~Anulowano prace! Brak klientow!", 2500, 4);
		Pizzaboy_End(playerid);
		return 1;
	}
	new rsex = random(2); // 0 - male // 1 - female
	new rname[26], rskin;
	if(rsex == 0)
	{
		rskin = random(sizeof(Pizzaboy_Skins_Male));
		rskin = Pizzaboy_Skins_Male[rskin];
	} else {
		rskin = random(sizeof(Pizzaboy_Skins_Female));
		rskin = Pizzaboy_Skins_Female[rskin];
	}
	if(rsex == 0)
	{
		new randname = random(sizeof(Pizzaboy_Names_Male));
		format(rname, sizeof(rname), "%s", Pizzaboy_Names_Male[randname]);
	} else {
		new randname = random(sizeof(Pizzaboy_Names_Female));
		format(rname, sizeof(rname), "%s", Pizzaboy_Names_Female[randname]);
	}
	
	Pizzaboy_Random[playerid] = rloc;
	Pizzaboy_Anti_Loop[playerid] = 0;
	// x += (distance * floatsin(-a, degrees));
	// y += (distance * floatcos(-a, degrees));
	Pizzaboy_Actor[playerid] = CreateDynamicActor(rskin, Pizzaboy_Order_Locations[rloc][0], Pizzaboy_Order_Locations[rloc][1], Pizzaboy_Order_Locations[rloc][2], Pizzaboy_Order_Locations[rloc][3], 1, 90, 0, 0, -1);
	Pizzaboy_Actor_Name[playerid] = CreateDynamic3DTextLabel(rname, COLOR_WHITE, Pizzaboy_Order_Locations[rloc][0], Pizzaboy_Order_Locations[rloc][1], Pizzaboy_Order_Locations[rloc][2]+1.3, 25, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1);
	format(Pizzaboy_Actor_Name_String[playerid], 26, "%s", rname);
	Pizzaboy_Travel_Distance[playerid] = GetDistanceBetweenXYZ(playerid, Pizzaboy_Order_Locations[rloc][0], Pizzaboy_Order_Locations[rloc][1], Pizzaboy_Order_Locations[rloc][2]);
	new dist = floatround(Pizzaboy_Travel_Distance[playerid]);
	Pizzaboy_Travel_Time[playerid] = dist/PIZZABOY_TIME_RATE;
	
	if(Pizzaboy_Travel_Time[playerid] < 60) Pizzaboy_Travel_Time[playerid] = 60;
	Pizzaboy_Time[playerid] = Pizzaboy_Travel_Time[playerid];
	if(Pizzaboy_Pizza_Quant[playerid] != 1)
	{
		GameTextForPlayer(playerid, "~g~Dostarcz pizze!", 2500, 4);
	}
	Pizzaboy_State[playerid] = 4;

	Pizzaboy_Customers_In_Use[rloc] = 1;
	return 1;
}

Pizzaboy_Delete_Customer(playerid)
{
	if(Pizzaboy_Actor[playerid] != 0) // byæ mo¿e nie potrzebny if
	{
		DestroyDynamicActor(Pizzaboy_Actor[playerid]);
		DestroyDynamic3DTextLabel(Pizzaboy_Actor_Name[playerid]);
		DisablePlayerCheckpoint(playerid);
		Pizzaboy_Customers_In_Use[Pizzaboy_Random[playerid]] = 0;
	}
	return 1;
}
//end