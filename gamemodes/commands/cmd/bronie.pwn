//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ przedmioty ]----------------------------------------------//
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
	Zal��ek systemu przedmiot�w, na razie w formie systemu broni
*/

YCMD:bron(playerid, params[], help)
{
    if(gPlayerLogged[playerid] == 1 && IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) return 1;
		new playerState = GetPlayerState(playerid);
		if(playerState == 1)
		{
			new option[128];
			if(!sscanf(params, "s[128]", option)) { //jesli wpisal string (/p [BRON])
				new itemexist = 0, weaponid = 0, ammo, weapondata;
				for (new i = 0; i <= 12; i++)
				{
					GetPlayerWeaponData(playerid, i, weaponid, ammo);
					if(ammo > 0)
					{
						if(weaponid == 24 && (strfind("Paralizator", option, true) != -1 || strfind("Tazer", option, true) != -1))
						{
							if(GroupPlayerDutyPerm(playerid, PERM_POLICE) || GroupPlayerDutyPerm(playerid, PERM_BOR))
							{
								itemexist = 24;
								weapondata = 1;
							}
						}
						else if(strfind(GunNames[weaponid], option, true) != -1) 
						{
							itemexist = weaponid;
							//wyciagniecie broni
						}
					}
				}
				return (itemexist == 0) ? PokazDialogBronie(playerid) : PrzedmiotyZmienBron(playerid, itemexist, weapondata);
			}
			else //domy�lne gui
			{
				return PokazDialogBronie(playerid);
			}
		}
	}
	return 1;
}
