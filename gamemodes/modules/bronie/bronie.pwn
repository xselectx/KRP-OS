//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 bronie                                                //
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
//Opis:
/*

*/
// Autor: Creative
// Data utworzenia: 22.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock GetWeaponChangeDelay(currentWeapon, changedWeapon)
{
	return WeaponsDelay[currentWeapon]/4 + WeaponsDelay[changedWeapon];
}

public PlayerChangeWeapon(playerid, newweaponid)
{
	MyWeapon[playerid] = newweaponid;
	SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	AntySpam[playerid] = 0;
	return 1;
}
PrzedmiotyZmienBron(playerid, weaponid, weapondata = 0)
{
	/*
	SPECJALNE (weapondata):
		1 - paralizator
	*/
	if(AntySpam[playerid] == 1)
	{
		return sendTipMessageEx(playerid, COLOR_GRAD3, "Wyci�gasz ju� bro�...");
	}

	new string[144], specNAME[144], i, gname[54];
	i = playerid;
	GetPlayerName(playerid, specNAME, sizeof(specNAME));
	
	if(weaponid > 1)
	{
		if(MyWeapon[playerid] == 24 && MaTazer[playerid] == 1)
		{
			format(gname, sizeof(gname), "Paralizator");
		}
		else
		{
			format(gname, sizeof(gname), "%s", GunNames[MyWeapon[playerid]]);
		}
		if(weaponid == MyWeapon[playerid])
		{
			weaponid = PlayerInfo[playerid][pGun0];
		}
		else if(MyWeapon[playerid] > 1)
		{
			format(specNAME, sizeof(specNAME), "%s chowa %s i", specNAME, gname);
		}
	}

	MaTazer[playerid] = 0;
	SetPVarInt(playerid, "MaDetonator", 0);

	switch(weaponid)
	{
		case 0:
		{
			format(string, sizeof(string), "* %s chowa Bro�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 1:
		{
			format(string, sizeof(string), "* %s chowa Bro�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 2:
		{
			format(string, sizeof(string), "* %s wyci�ga Kij Golfowy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 3:
		{
			format(string, sizeof(string), "* %s wyci�ga Pa�k� Policyjn�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 4:
		{
			format(string, sizeof(string), "* %s wyci�ga N�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 5:
		{
			format(string, sizeof(string), "* %s wyci�ga Bejzbol.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 6:
		{
			format(string, sizeof(string), "* %s wyci�ga �opat�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 7:
		{
			format(string, sizeof(string), "* %s wyci�ga Kij Bilardowy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 8:
		{
			format(string, sizeof(string), "* %s wyci�ga Katane.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 9:
		{
			format(string, sizeof(string), "* %s wyci�ga Pi�� Mechaniczn�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 14:
		{
			format(string, sizeof(string), "* %s wyci�ga Kwiaty.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 15:
		{
			format(string, sizeof(string), "* %s wyci�ga D�bow� Lask�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 16:
		{
			format(string, sizeof(string), "* %s wyci�ga Granat.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 17:
		{
			format(string, sizeof(string), "* %s wyci�ga Gaz �zawi�cy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 18:
		{
			format(string, sizeof(string), "* %s wyci�ga Koktajl Mo�otova.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		//bron 19 20 i 21 nie istnieje

		case 22:
		{
			format(string, sizeof(string), "* %s wyci�ga z kieszeni Pistolety 9mm.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 23:
		{
			format(string, sizeof(string), "* %s wyci�ga Pistolet z T�umikiem.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 24:
		{
			if(weapondata == 1)
			{
				MaTazer[playerid] = 1;
				format(string, sizeof(string), "* %s wyci�ga Paralizator.", specNAME);
			}
			else
			{
				format(string, sizeof(string), "* %s wyci�ga Pistolet Deagle.", specNAME);
			}
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 25:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli Shotgun'a.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 26:
		{
			format(string, sizeof(string), "* %s wyci�ga z rze�ni Obrzyny.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 27:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli Spas-12.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 28:
		{
			format(string, sizeof(string), "* %s wyci�ga z kabury UZI.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 29:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli MP5.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 30:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli AK47.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 31:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli M4.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 32:
		{
			format(string, sizeof(string), "* %s wyci�ga z kabury TEC-9.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 33:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli Strzelb�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 34:
		{
			format(string, sizeof(string), "* %s wyci�ga zza koszuli Snajperk�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 35:
		{
			format(string, sizeof(string), "* %s wyci�ga zza ucha RPG.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 36:
		{
			format(string, sizeof(string), "* %s wyczarowuje Rakietnice.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 37:
		{
			format(string, sizeof(string), "* %s wyci�ga z ognia Miotacz Ognia.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 38:
		{
			format(string, sizeof(string), "* %s wysrywa miniguna.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 39:
		{
			format(string, sizeof(string), "* %s wyci�ga z torby C4.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 40:
		{
			SetPVarInt(playerid, "MaDetonator", 1);
			format(string, sizeof(string), "* %s wyci�ga detonator.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 41:
		{
			format(string, sizeof(string), "* %s wyci�ga Gaz Pieprzowy / Spray.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 42:
		{
			format(string, sizeof(string), "* %s wyci�ga Ga�nic�.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 43:
		{
			format(string, sizeof(string), "* %s wyci�ga Aparat Fotograficzny.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 44:
		{
			format(string, sizeof(string), "* %s wyci�ga noktowizor", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			ResetPlayerWeapons(i);
		}

		case 45:
		{
			format(string, sizeof(string), "* %s wyci�ga termowizor.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			ResetPlayerWeapons(i);
		}

		case 46:
		{
			format(string, sizeof(string), "* %s zak�ada Spadochron na plecy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}

	AntySpam[playerid] = 1;
	//new timerid = SetTimerEx("PlayerChangeWeapon", GetWeaponChangeDelay(MyWeapon[playerid], weaponid), false, "dd", playerid, weaponid);
	new timerid = 1;
	SetPVarInt(playerid, "Timer_OnChangingWeapon", timerid);
	PlayerChangeWeapon(playerid, weaponid);
	//MyWeapon[playerid] = weaponid;
	//SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	return 1;
}
PokazDialogBronie(playerid)
{
	if(AntySpam[playerid] == 1) return SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	if(GUIExit[playerid] != 0) return SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	GUIExit[playerid] = 1;
	new wps[13][2], dialogstring[2048], weaponexist = 0;
    for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, wps[i][0], wps[i][1]);
		if(wps[i][0] > 0)
		{
			weaponexist = 1;
		}
	}

	if(weaponexist)
	{
		DynamicGui_Init(playerid);
		SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
		new active[144];
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun0], PlayerInfo[playerid][pGun0]);
		if(PlayerInfo[playerid][pGun0] == MyWeapon[playerid])
		{
			format(active, sizeof(active), "{FAD82D}� {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s%s", active, GunNames[PlayerInfo[playerid][pGun0]]);
		if(PlayerInfo[playerid][pGun1] >= 2)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pGun1]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun1] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun1]]);
		}
		if(PlayerInfo[playerid][pGun2] >= 2 && PlayerInfo[playerid][pAmmo2] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pGun2]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun2] == MyWeapon[playerid] && MaTazer[playerid] != 1)
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun2]]);
		}
		if(PlayerInfo[playerid][pGun3] >= 2 && PlayerInfo[playerid][pAmmo3] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pGun3]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun3] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun3]]);
		}
		if(PlayerInfo[playerid][pGun4] >= 2 && PlayerInfo[playerid][pAmmo4] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pGun4]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun4] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun4]]);
		}
		if(PlayerInfo[playerid][pGun5] >= 2 && PlayerInfo[playerid][pAmmo5] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun5], PlayerInfo[playerid][pGun5]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun5] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun5]]);
		}
		if(PlayerInfo[playerid][pGun6] >= 2 && PlayerInfo[playerid][pAmmo6] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun6], PlayerInfo[playerid][pGun6]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun6] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun6]]);
		}
		if(PlayerInfo[playerid][pGun7] >= 2 && PlayerInfo[playerid][pAmmo7] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun7], PlayerInfo[playerid][pGun7]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun7] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun7]]);
		}
		if(PlayerInfo[playerid][pGun8] >= 2 && PlayerInfo[playerid][pAmmo8] >= 1)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun8], PlayerInfo[playerid][pGun8]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun8] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun8]]);
		}
		if(PlayerInfo[playerid][pGun9] >= 2  && PlayerInfo[playerid][pAmmo9] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun9], PlayerInfo[playerid][pGun9]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun9] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun9]]);
		}
		if(PlayerInfo[playerid][pGun10] >= 2)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun10], PlayerInfo[playerid][pGun10]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun10] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun10]]);
		}
		if(PlayerInfo[playerid][pGun11] >= 2  && PlayerInfo[playerid][pAmmo11] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun11], PlayerInfo[playerid][pGun11]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun11] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun11]]);
		}
		if(PlayerInfo[playerid][pGun12] >= 2  && PlayerInfo[playerid][pAmmo12] >= 10)
		{
			DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun12], PlayerInfo[playerid][pGun12]);
			weaponexist = 1;
			if(PlayerInfo[playerid][pGun12] == MyWeapon[playerid])
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun12]]);
		}
		if(MyWeapon[playerid] == 39 && PlayerInfo[playerid][pGun8] >= 2 && PlayerInfo[playerid][pAmmo8] >= 1)
		{
			DynamicGui_AddRow(playerid, 40); //detonator
			weaponexist = 1;
			if(GetPVarInt(playerid, "MaDetonator") == 1)
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, "Detonator");
		}
		if((IsAPolicja(playerid) || IsABOR(playerid)) && (OnDuty[playerid] > 0 || OnDutyCD[playerid] == 1))
		{
			DynamicGui_AddRow(playerid, 24, 1); //paralizator
			weaponexist = 1;
			if(24 == MyWeapon[playerid] && MaTazer[playerid] == 1)
			{
				format(active, sizeof(active), "{FAD82D}� {FAD82D}");
			}
			else
			{
				format(active, sizeof(active), "{FFFFFF}");
			}
			format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, "Paralizator");
		}
	}
	else
	{
		SetPlayerArmedWeapon(playerid, 0);
		MyWeapon[playerid] = 0;
	}

	if(!weaponexist)
	{
		GUIExit[playerid] = 0;
		sendErrorMessage(playerid, "Nie posiadasz przy sobie �adnej broni.");
		return 0;
	}
	return ShowPlayerDialogEx(playerid, D_PRZEDMIOTY_BRONIE, DIALOG_STYLE_LIST, "{FFFFFF}Wyci�gnij bro� (/togscroll) (/p [nazwa])", dialogstring, "Wyci�gnij", "Wyjd�");
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end