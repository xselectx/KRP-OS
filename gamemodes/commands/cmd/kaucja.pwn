//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ kaucja ]------------------------------------------------//
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

YCMD:kaucja(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if(PlayerInfo[playerid][pJailed]==1)
		{
		    if(JailPrice[playerid] > 0)
		    {
		        if(kaska[playerid] > JailPrice[playerid])
		        {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
		            format(string, sizeof(string), "Wp�aci�e� za siebie kaucje $%d", JailPrice[playerid]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "%s wp�aci� za siebie kaucj� %d", sendername, JailPrice[playerid]);
					SendTeamMessage(0, COLOR_ALLDEPT, string, 1, PERM_POLICE);
					ZabierzKaseDone(playerid, JailPrice[playerid]);
                    new komuPlaci = GetPVarInt(playerid, "kaucja-dlaKogo");
                    Sejf_Add(komuPlaci, JailPrice[playerid]);
					JailPrice[playerid] = 0;
					WantLawyer[playerid] = 0; CallLawyer[playerid] = 0;
					PlayerInfo[playerid][pJailTime] = 1;
		        }
		        else
		        {
		            sendTipMessageEx(playerid, COLOR_GRAD1, "Kaucja jest zbyt wysoka, nie sta� ci� !");
		        }
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GRAD1, "Nie dano ci mo�liwo�ci wp�acenia kaucji !");
		    }
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GRAD1, "Nie jeste� w wi�zieniu !");
		}
	}//not connected
	return 1;
}
