//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  sannews                                                  //
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
// Autor: Simeone
// Data utworzenia: 13.09.2019
//Opis:
/*
	Komendy, funkcje i wykorzystania frakcji San News i powi�zanych z nimi podfrakcji (telewizja, kluby)
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock IsASN(playerid)
{
	if(CheckPlayerPerm(playerid, PERM_NEWS))
	{
		return true;
	}
	return false; 
}
stock InTheFractionCar(playerid, frac)
{
	new carID = GetPlayerVehicleID(playerid);
	new bool:inPos=false;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(Car_GetOwner(i) == frac && Car_GetOwnerType(i) == CAR_OWNER_FRACTION)
		{
			if(carID == i)
			{
				inPos = true;
				break;
			}
		}
	}
	if(inPos)
	{
		return true; 
	}
	return false; 
}
stock PlayerConditionToNews(playerid)
{
	if(PlayerInfo[playerid][pMuted] == 1)
    {
        sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo�esz m�wi� poniewa� zosta�e� wyciszony");
        return false;
    }
    if(GetPlayerAdminDutyStatus(playerid) == 1)
    {
        sendErrorMessage(playerid, "Nie mo�esz u�ywa� /news podczas s�u�by administratora!"); 
        return false;
    }
	if(InTheFractionCar(playerid, FRAC_SN))
	{
		return true; 
	}
	if(GetPLocal(playerid) == PLOCAL_ORG_SN)
	{
		return true; 
	}
	return false; 
}

TalkOnNews(playerid, const text[])
{
	new string[256]; 
	format(string, sizeof(string), "NR %s: %s", GetNick(playerid), text); 
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)//TODO: Zmieni� po stworzeniu modu�u TOGOWANIA
		    {
				SendClientMessage(i, COLOR_NEWS, string);
			}
		}
	}
	//Anty Spam
	SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	AntySpam[playerid] = 1;
	//Wiadomo�� na discorda MRP
	SendDiscordMessage(DISCORD_SAN_NEWS, string);
	return 1;
}
//end