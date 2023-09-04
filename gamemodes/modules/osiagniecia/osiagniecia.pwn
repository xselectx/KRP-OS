//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  osiagniecia                                              //
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
// Data utworzenia: 18.07.2022
//Opis:
/*
	osiagniecia
*/

//

stock FirstRP(playerid)
{
	if(PlayerInfo[playerid][pOsiagniecia1] == 0)
	{
		new String[258];
		PlayerInfo[playerid][pOsiagniecia1] = 1;
		format(String, sizeof(String), "~y~OSIAGNIECIE!~w~~n~Otrzymujesz +5~g~KotnikCoins~w~ za~n~~y~Pierwsza odegrana akcje RP");
		TextDrawInfoOn(playerid, String, 8000);
		PremiumInfo[playerid][pMC] += 5;
		mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+5 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 10.0);
	}
	return 1;
}

stock FirstCar(playerid)
{
	if(PlayerInfo[playerid][pOsiagniecia2] == 0)
	{
		new String[258];
		PlayerInfo[playerid][pOsiagniecia2] = 1;
		format(String, sizeof(String), "~y~OSIAGNIECIE!~w~~n~Otrzymujesz +10~g~KotnikCoins~w~ za~n~~y~Pierwsze zakupione auto");
		TextDrawInfoOn(playerid, String, 8000);
		PremiumInfo[playerid][pMC] += 10;
		mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+10 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 10.0);
	}
	return 1;
}

stock FirstHouse(playerid)
{
	if(PlayerInfo[playerid][pOsiagniecia3] == 0)
	{
		new String[258];
		PlayerInfo[playerid][pOsiagniecia3] = 1;
		format(String, sizeof(String), "~y~OSIAGNIECIE!~w~~n~Otrzymujesz 25~g~KotnikCoins~w~ za~n~~y~Pierwsza zakupiona nieruchomosc");
		TextDrawInfoOn(playerid, String, 8000);
		PremiumInfo[playerid][pMC] += 25;
		mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+25 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 10.0);
	}
	return 1;
}

stock FirstDrugs(playerid)
{
	if(PlayerInfo[playerid][pOsiagniecia4] == 0)
	{
		new String[258];
		PlayerInfo[playerid][pOsiagniecia4] = 1;
		format(String, sizeof(String), "~y~OSIAGNIECIE!~w~~n~Otrzymujesz 15~g~KotnikCoins~w~ za~n~~y~Pierwsza sadzonka");
		TextDrawInfoOn(playerid, String, 8000);
		PremiumInfo[playerid][pMC] += 15;
		mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+15 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 10.0);
	}
	return 1;
}

stock FirstBigFish(playerid)
{
	if(PlayerInfo[playerid][pOsiagniecia5] == 0)
	{
		new String[258];
		PlayerInfo[playerid][pOsiagniecia5] = 1;
		format(String, sizeof(String), "~y~OSIAGNIECIE!~w~~n~Otrzymujesz 10~g~KotnikCoins~w~ za~n~~y~Gruba ryba");
		TextDrawInfoOn(playerid, String, 8000);
		PremiumInfo[playerid][pMC] += 10;
		mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+10 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 10.0);
	}
	return 1;
}