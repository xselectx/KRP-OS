//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ glosnik ]------------------------------------------------//
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

YCMD:glosnik(playerid, params[], help)
{
    if(((GroupPlayerDutyPerm(playerid, PERM_NEWS) && GroupPlayerDutyRank(playerid) >= 3)) || (GroupPlayerDutyPerm(playerid, PERM_CLUB) && IsPlayerInRangeOfPoint(playerid, 100.0 , 425.01,-1864.58,-20.6288) && GroupPlayerDutyRank(playerid) >= 3))
    {
        if(SanDuty[playerid] == 0 && GroupPlayerDutyPerm(playerid, PERM_NEWS)) return sendErrorMessage(playerid, "Musisz byæ na s³u¿bie San News");
		if(GroupPlayerDutyPerm(playerid, PERM_NEWS))
		{
			if(SANradio == 0)
			{
				new bool:inpos=true;
				if(inpos)
				{
					ShowPlayerDialogEx(playerid, 765, DIALOG_STYLE_LIST, "Wybierz muzykê", "Kotnik Radio 1\nKotnik Radio 2\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW³asna", "Wybierz", "Anuluj");
				}
			}
			else
			{
				DestroyDynamicObject(SANradio);
				DestroyDynamic3DTextLabel(SAN3d);
				SANradio = 0;
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(playerid, 75.0, SANx, SANy, SANz))
						{
							if(GetPVarInt(i, "sanaudio") == 1)
							{
								StopAudioStreamForPlayer(i);
								SetPVarInt(i, "sanaudio", 0);
							}
						}
					}
				}
				sendTipMessageEx(playerid, COLOR_GREY, "G³oœnik wy³¹czony!");
				StopAudioStreamForPlayer(playerid);
				return 1;
			}
		}
		else if(CheckPlayerPerm(playerid, PERM_CLUB))
		{
			if(KLUBOWEradio == 0)
			{
				new bool:inpos=true;
				if(inpos)
				{
					ShowPlayerDialogEx(playerid, 768, DIALOG_STYLE_LIST, "Wybierz muzykê", "Kotnik Radio 1\nKotnik Radio 2\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW³asna", "Wybierz", "Anuluj");
				}
			}
			else
			{
				DestroyDynamicObject(KLUBOWEradio);
				DestroyDynamic3DTextLabel(KLUBOWE3d);
				KLUBOWEradio = 0;
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(playerid, 75.0, KLUBOWEx, KLUBOWEy, KLUBOWEz))
						{
							if(GetPVarInt(i, "kluboweaudio") == 1)
							{
								StopAudioStreamForPlayer(i);
								SetPVarInt(i, "kluboweaudio", 0);
							}
						}
					}
				}
				sendTipMessageEx(playerid, COLOR_GREY, "G³oœnik wy³¹czony!");
				StopAudioStreamForPlayer(playerid);
				return 1;
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ z SAN News/Ibizy!");
	    return 1;
	}
    return 1;
}
