//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wybieralka ]----------------------------------------------//
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

YCMD:wybieralka(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U�yj /wybieralka [playerid/Cz��Nicku]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wrzuci� gracza do wybiera�ki gracz musi by� pieszo!");

					NowaWybieralka_Setup(para1);

					_MruAdmin(playerid, sprintf("Wys�a�e� gracza %s [%d] do wybiera�ki skin�w.", GetNick(para1), para1));
                    _MruAdmin(para1, sprintf("Zosta�e� wys�any do wybiera�ki skin�w przez Admina %s [%d].", GetNickEx(playerid), playerid));
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
