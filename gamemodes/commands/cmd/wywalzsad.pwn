//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wywalzsad ]-----------------------------------------------//
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

YCMD:wywalzsad(playerid,params[], help) //GSA
{
    if(GroupPlayerDutyPerm(playerid, PERM_BOR) || (IsPlayerInGroup(playerid, FAMILY_SAD)))
	{
	   if(IsPlayerInRangeOfPoint(playerid,5,1321.1561, -1322.0787, 40.2077)
	   || IsPlayerInRangeOfPoint(playerid,20,1309.6487, -1299.8835, 36.5567)
	   || IsPlayerInRangeOfPoint(playerid,10,1310.2283, -1343.9265, 38.5291))
	   {
		    new odbiorca;
		    if(sscanf(params,"k<fix>",odbiorca)) return sendTipMessage(playerid,"U�yj /wywalzsad [ID-Gracza]");
            new str[128];
            format(str, 128, "Zostales wyrzucony z s�du przez %s", GetNick(playerid));
            SetPlayerVirtualWorld(odbiorca, 0);
			SendClientMessage(odbiorca,0xFFFFFFFF,str);
            format(str, 128, "* %s wyrzuca z s�du %s", GetNick(playerid), GetNick(odbiorca));
            ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            SetPlayerPos(odbiorca,1309.9658, -1367.2878, 13.7324);
        }
        else
        {
        	sendTipMessageEx(playerid,0xFFFFFFFF,"Nie jestes w s�dzie!");
        }
    }
	return 1;
}
