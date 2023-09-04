//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[pancerz]--------------------------------------------------//
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

// Opis:  zrobione by metinek
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:pancerz(playerid, params[], help)
{
    new string[128];
    new Float:pancerz;
	GetPlayerArmour(playerid, pancerz);
	if(PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pDom] || PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pWynajem] && Dom[PlayerInfo[playerid][pDom]][hUL_D] != 0)
	{
		new dom = PlayerInfo[playerid][pDom];
		if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]))
		{
			if(Dom[dom][hKami] == 1)
			{
                if(pancerz >= 50.0)
				{
					sendTipMessageEx(playerid, COLOR_GRAD2, "Posiadasz ju¿ pancerz.");
					return 1;
				}
				SetPlayerArmour(playerid, 50);
				format(string, sizeof(string), "%s wyci¹ga kamizelkê kuloodporn¹ i zak³ada j¹ na siebie.", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				//format(string, sizeof(string), "---[%s u¿y³ kamizelki domowej]---", GetNick(playerid));
				//SendAdminMessage(COLOR_GREEN, string);	
				return 1;
            }
            else
            {
                sendTipMessage(playerid, "Musisz kupiæ pancerz jako dodatek w domu!");
            }
        }
        else
        {
            sendTipMessage(playerid, "Musisz byæ w domu!");
        }
    }
    return 1;
}          