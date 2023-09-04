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
			sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ  podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
			return 1;
		}
		
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wzi¹æ s³u¿be musisz byæ pieszo!");

        if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
        {
            sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");
            return 1;
        }

        if(gettime() - GetPVarInt(playerid, "lastDamage") < 60)
			return sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ podczas walki!");
        if(PlayerInfo[playerid][pJob] == 7)
        {
            if(AntySpam[playerid] == 0)
            {
                if(JobDuty[playerid] == 1)
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie mechanika, nie bêd¹ ci siê wyœwietlaæ zg³oszenia.");
                    JobDuty[playerid] = 0;
                    PrintDutyTime(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ na s³u¿bie mechanika, kiedy ktoœ bêdzie ciê potrzebowa³ zostanie wyœwietlony komunikat.");
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
        else return sendTipMessage(playerid, "U¿yj: /g [slot] duty");
    }
    return 1;
}
