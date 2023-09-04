//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                biznespomoc                                                //
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
// Data utworzenia: 20.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_biznespomoc_Impl(playerid)
{
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_WHITE,"*** BIZNES POMOC *** wpisz komende aby uzyska� wi�cej pomocy");
	SendClientMessage(playerid, COLOR_GRAD3,"*** BIZNES *** /bizinfo /wejdz /wyjdz /kupbiznes /sprzedajbiznes");
	SendClientMessage(playerid, COLOR_GRAD3, "*** BIZNES *** /bizlock /biz /obiz /bizpanel /bizog");
	SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /telefonpomoc /dompomoc /wynajempomoc /pomoc /rybypomoc /ircpomoc");
	return 1;
}

YCMD:bizog(playerid, params[], help)
{
	new string[256];
	new content[256];
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pBusinessMember] <= 0 || PlayerInfo[playerid][pBusinessMember] == INVALID_BIZ_ID)
		{
			noAccessMessage(playerid);
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz tego u�y� podczas @duty"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /biznesog [tekst]"); 
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo�esz napisa� na tym czacie, gdy� masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPVarString(playerid, "trescOgloszenia", content, sizeof(content));
		if(PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] >= 1)
		{
			PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15-komunikatMinuty[playerid];
			format(string, sizeof(string), "Wys�a�e� og�oszenie o tej samej tre�ci, odczekaj jeszcze %d minut", PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas]);
			sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string); 
			format(string, sizeof(string), "{A0522D}Ostatnie og�oszenie: {FFFFFF}%s", content);
			sendTipMessage(playerid, string);
			return 1;
		}
		if(strfind(params, content, false) == -1)
		{
			if(strlen(params) > 105)
			{
				sendErrorMessage(playerid, "Twoja wiadomo�� by�a zbyt d�uga, skr�� j�!"); 
				return 1;
			}
			SetPVarString(playerid, "trescOgloszenia", params);
			sendBiznesMessageToAll(playerid, params); 
			komunikatTimeZerowanie[playerid] = SetTimerEx("KomunikatCzasZerowaie", 60000, true, "i", playerid);
			sendTipMessage(playerid, "Odczekaj 5 minut przed wys�aniem ponownego komunikatu o {AC3737}tej samej tre�ci"); 
			return 1;
		}
		SendClientMessage(playerid, -1, " "); 
		sendTipMessageEx(playerid, COLOR_WHITE, "Wys�a�e� og�oszenie o tej samej tre�ci w czasie mniejszym jak {AC3737}5 minut!");
		sendTipMessageEx(playerid, COLOR_WHITE, "{C0C0C0}Zostajesz ukarany kar� Anty-Spam na {AC3737}15 minut");
		komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);		
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15;
		format(string, sizeof(string), "[ANTY_SPAM] %s otrzyma� blokad� na 15 minut za wys�anie 2x tego samego komunikatu!", GetNickEx(playerid));
		SendAdminMessage(COLOR_BLUE, string);
	}
	return 1;
}


//end