//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   otworz                                                  //
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
// Autor: Sanda�
// Data utworzenia: 18.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_otworz_Impl(playerid)
{
    if(!IsPlayerInGroup(playerid, 21))
    {
        sendTipMessage(playerid, "Komenda dost�pna tylko dla Gunshop Los Santos.");
        return 1;
    }
    if(GroupRank(playerid, 21) <= 3)
    {
        sendTipMessage(playerid, "Komenda dost�pna od [4].");
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1791.6248,-1164.4028,23.8281) || (IsPlayerInRangeOfPoint(playerid, 200.0, 1815.6812,-1172.1915,61.5103) && GetPlayerVirtualWorld(playerid) == 5))
    {
        if(GunshopLSLock == 1)
        {
            GunshopLSLock = 0;
            new string[128];
            format(string, sizeof(string), "* %s przyk�ada kart� do drzwi i otwiera magnetyczne zamki.", GetNick(playerid));
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            format(string, sizeof(string), "* Unosz� si� stalowe rolety przy drzwiach i oknach...");
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            return 1;
        }
        else
        {
            sendTipMessage(playerid, "Biznes jest ju� otwarty.");
            return 1;
        }
    }
    else
    {
        sendTipMessage(playerid, "Nie znajdujesz si� w �rodku/przy drzwiach wej�ciowych!");
        return 1;
    }
}

//end