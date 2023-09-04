/*
GetHealthDots(playerid)
{
    new
        dots[64], Float: HP;
 
    GetPlayerHealth(playerid, HP);
 
    if(HP >= 100)
        dots = "••••••••••";
    else if(HP >= 90)
        dots = "•••••••••{660000}•";
    else if(HP >= 80)
        dots = "••••••••{660000}••";
    else if(HP >= 70)
        dots = "•••••••{660000}•••";
    else if(HP >= 60)
        dots = "••••••{660000}••••";
    else if(HP >= 50)
        dots = "•••••{660000}•••••";
    else if(HP >= 40)
        dots = "••••{660000}••••••";
    else if(HP >= 30)
        dots = "•••{660000}•••••••";
    else if(HP >= 20)
        dots = "••{660000}••••••••";
    else if(HP >= 10)
        dots = "•{660000}•••••••••";
    else if(HP >= 0)
        dots = "{660000}••••••••••";
 
    return dots;
}
 
GetArmorDots(playerid)
{
	new string[1024], nick[512], gracz[128], bw[128], pasyz[128], afk[512], Duty[512];
	GetPlayerName(playerid, nick, sizeof(nick));
	UnderscoreToSpace(nick);

	if(PremiumInfo[playerid][pKP] == 1)
	{
		gracz="premium";
		//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 1 (PLAYER: %d)", playerid);
		//print(stringdebug);
	}
	else
	{
		if(PlayerInfo[playerid][pConnectTime] < 5)
		{
			gracz="nowy gracz";
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 2 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
		else
		{
			gracz="gracz";
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 3 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
	}
	if(PlayerInfo[playerid][pBW] > 0)
	{
		bw=", nieprzytomny";
		//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 4 (PLAYER: %d)", playerid);
		//print(stringdebug);
	}
	if(PlayerInfo[playerid][pInjury] > 0)
	{
		bw=", ranny";
		//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 5 (PLAYER: %d)", playerid);
		//print(stringdebug);
	}
	if(pasy[playerid] == 1)
	{
		pasyz=", pasy";
		//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 6 (PLAYER: %d)", playerid);
		//print(stringdebug);
	}
	if(IsPlayerPaused(playerid) || IdleCount[playerid] >= MAX_IDLE_COUNT)
	{
		if(AFKTime[playerid] < 60)
		{
			format(afk, sizeof(afk), ", AFK: %d sekund", AFKTime[playerid]);
		}
		else
		{
			format(afk, sizeof(afk), ", AFK: %d min. %d sekund", AFKTime[playerid]/60, AFKTime[playerid]%60);
		}
	}
	//-------------- DUTY --------------//
	//if(IsAPolicja(playerid) && OnDuty[playerid] > 0)
	if(OnDuty[playerid] > 0)
	{
		new grupaid = PlayerInfo[playerid][pGrupa][OnDuty[playerid]-1];
		Duty=sprintf("{%06x}%s",GroupInfo[grupaid][g_Color], GroupInfo[grupaid][g_ShortName]);
	}
	if((IsPlayerInGroup(playerid, 1) || PlayerInfo[playerid][pLider] == 1) && OnDuty[playerid] > 0)
	{
		Duty="{0000ff}SASD";
		format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 7 (PLAYER: %d)", playerid);
		print(stringdebug);
	}
	else if((IsPlayerInGroup(playerid, 4) || PlayerInfo[playerid][pLider] == 4) && (OnDuty[playerid] > 0 || JobDuty[playerid] == 1))
	{
		Duty="{ff0000}LSMC";
		format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 8 (PLAYER: %d)", playerid);
		print(stringdebug);
	}
	else if(TransportDuty[playerid] == 1)
	{
		Duty="{ffff00}TAXI";
		format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 9 (PLAYER: %d)", playerid);
		print(stringdebug);
	}

	if(PremiumInfo[playerid][pKP] == 1)
	{
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			format(string, sizeof(string), "{ffffff}%s • %d\n({ff2828}Administrator{ffffff})", nick, playerid);
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 10 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
		else
		{
			if(PlayerInfo[playerid][pBW] <= 0 && PlayerInfo[playerid][pInjury] <= 0 && pasyz[playerid] == 0 && AFKTime[playerid] == 0)
			{
				format(string, sizeof(string), "{E6D265}(( %d. %s ))\n%s", playerid, nick, Duty);
			}
			else
			{
				format(string, sizeof(string), "{E6D265}(( %d. %s ))\n(%s%s%s)\n%s", playerid, nick, bw, pasyz, afk, Duty);
			}

			format(string, sizeof(string), "{E6D265}%s • %d\n(%s%s%s%s)\n%s", nick, playerid, gracz, bw, pasyz, afk, Duty);
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 11 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
	}
	else
	{
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			format(string, sizeof(string), "{ffffff}%s • %d\n({ff2828}Administrator{ffffff})", nick, playerid);
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 12 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
		else
		{
			if(PlayerInfo[playerid][pBW] <= 0 && PlayerInfo[playerid][pInjury] <= 0 && pasyz[playerid] == 0 && AFKTime[playerid] == 0)
			{
				format(string, sizeof(string), "(( %d. %s ))\n%s", playerid, nick, Duty);
			}
			else
			{
				format(string, sizeof(string), "(( %d. %s ))\n(%s%s%s)\n%s",  playerid, nick, bw, pasyz, afk, Duty);
			}

			format(string, sizeof(string), "%s • %d\n(%s%s%s%s)\n%s", nick, playerid, gracz, bw, pasyz, afk, Duty);
			//format(stringdebug, sizeof(stringdebug), "DEBUG NICKI: 13 (PLAYER: %d)", playerid);
			//print(stringdebug);
		}
	}
	return string;

	
}*/

/*stock AttachDyn3DTextLabelToPlayer(Text3D:labelid, playerid, Float:offsetx, Float:offsety, Float:offsetz)
{
    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACHED_PLAYER, playerid);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_X, offsetx);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Y, offsety);
    return Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Z, offsetz);
}

stock AttachDyn3DTextLabelToVehicle(Text3D:labelid, vehicleid, Float:offsetx, Float:offsety, Float:offsetz)
{
    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACHED_VEHICLE, vehicleid);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_X, offsetx);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Y, offsety);
    return Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Z, offsetz);
}*/
