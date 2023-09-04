//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ wezdragi ]-----------------------------------------------//
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

YCMD:wezdragi(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
   	{
   	    if(PlayerBoxing[playerid] > 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz u�ywa� drag�w podczas walki !");
            return 1;
        }
		if(PlayerInfo[playerid][pDrugs] > 1)
		{
		    PlayerStoned[playerid] += 1;
		    if(PlayerStoned[playerid] >= 4) { GameTextForPlayer(playerid, "~w~Jestes~n~~p~Nacpany", 4000, 1); }
		    new Float:health;
		    GetPlayerHealth(playerid, health);
		    if(PlayerInfo[playerid][pDrugPerk] > 0)
		    {
		        new hp = 2 * PlayerInfo[playerid][pDrugPerk]; hp += 20;
				SetPlayerHealth(playerid, health + hp);
		    }
		    else
		    {
		        SetPlayerHealth(playerid, health + 20.0);
		    }
		    new nick[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, nick, sizeof(nick));
		    SendClientMessage(playerid, COLOR_GREY, "   2 gramy narkotyk�w za�yte !");
		    format(string, sizeof(string), "* %s wyci�ga skr�ta i zaci�ga si�", nick);
			ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		    PlayerInfo[playerid][pDrugs] -= 2;
		    //SetPlayerDrunkLevel(playerid, 8000);
		    //SetPlayerWeather(playerid, -66);

			//choroba
			if(random(50) == 1)//2%
			{
				InfectOrDecreaseImmunity(playerid, SCHIZOFRENIA);
			}
			
			//System si�y
			if(GetPVarInt(playerid, "ZjadlDragi") == 0)
			{
				if(PlayerInfo[playerid][pStrong] < MAX_STRONG_VALUE/2)
				{
					SetPVarInt(playerid, "ZjadlDragi", 1);
					sendTipMessageEx(playerid, COLOR_P@, "Za�y�e� narkotyki, twoja si�a wzros�a dwukrotnie na jaki� czas"); 
					format(string, sizeof(string), "Mia�e� %d , po za�yciu 2 gram masz %d si�y.", PlayerInfo[playerid][pStrong], PlayerInfo[playerid][pStrong]*2);
					sendTipMessage(playerid, string);
					SetPVarInt(playerid, "FirstValueStrong", PlayerInfo[playerid][pStrong]);
					SetStrong(playerid, PlayerInfo[playerid][pStrong]*2);
					TimerEfektNarkotyku[playerid] = SetTimerEx("EfektNarkotyku", 60000, false, "i", playerid);
				}
				else
				{
					sendTipMessage(playerid, "Masz zbyt du�� warto�� si�y, aby dragi Ci co� da�y!"); 
				}
			
			}
			else
			{
				if(PlayerInfo[playerid][pStrong] >= 15)
				{
					sendTipMessage(playerid, "�pun, przez tw�j na��g spada Ci warto�� si�y!");
					MSGBOX_Show(playerid, "Sila -15", MSGBOX_ICON_TYPE_EXPLODE, 3);
					TakeStrong(playerid, 15);
					new StrongValue = GetPVarInt(playerid, "FirstValueStrong"); 
					SetPVarInt(playerid, "FirstValueStrong", StrongValue-15);
				}
				else
				{
					sendTipMessage(playerid, "�pun, przez tw�j na��g spada Ci warto�� si�y!");
					MSGBOX_Show(playerid, "Sila -15", MSGBOX_ICON_TYPE_EXPLODE, 3);
				}
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju� wi�cej narkotyk�w !");
		}
	}//not connected
	return 1;
}
