//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ sluzba ]------------------------------------------------//
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

YCMD:sluzba(playerid, params[], help)
{

    if(IsPlayerConnected(playerid))
    {
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz tego u�y�  podczas @Duty! Zejd� ze s�u�by u�ywaj�c /adminduty");
			return 1;
		}
		
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wzi�� s�u�be musisz by� pieszo!");

        if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
        {
            sendErrorMessage(playerid, "Jeste� podczas wsiadania - odczekaj chwile. Nie mo�esz znajdowa� si� w poje�dzie.");
            return 1;
        }

        if(gettime() - GetPVarInt(playerid, "lastDamage") < 60)
			return sendErrorMessage(playerid, "Nie mo�esz tego u�y� podczas walki!");
        if(PlayerInfo[playerid][pJob] == 7)
        {
            if(AntySpam[playerid] == 0)
            {
                if(JobDuty[playerid] == 1)
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie mechanika, nie b�d� ci si� wy�wietla� zg�oszenia.");
                    JobDuty[playerid] = 0;
                    PrintDutyTime(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� na s�u�bie mechanika, kiedy kto� b�dzie ci� potrzebowa� zostanie wy�wietlony komunikat.");
                    JobDuty[playerid] = 1;
                }
                AntySpam[playerid] = 1;
                SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Odczekaj 10 sekund");
            }
        }
        else return sendTipMessage(playerid, "U�yj: /g [slot] duty");
    }
    return 1;
}
