//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ blokujnoba ]----------------------------------------------//
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

YCMD:blokujnoba(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if (!gNewbie[playerid])
		{
			gNewbie[playerid] = 1;
            MSGBOX_Show(playerid, "Newbie ~r~OFF", MSGBOX_ICON_TYPE_OK);
		}
		else if (gNewbie[playerid])
		{
			gNewbie[playerid] = 0;
            MSGBOX_Show(playerid, "Newbie ~g~ON", MSGBOX_ICON_TYPE_OK);
		}
	}
	return 1;
}
