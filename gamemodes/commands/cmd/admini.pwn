//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ admini ]------------------------------------------------//
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

YCMD:zaufani(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[128];
		SendClientMessage(playerid, -1, "Lista zaufanych graczy:"); 
		foreach(new i : Player)
		{
			if(HiddenAdmin[i]) continue; 
			if(PlayerInfo[i][pZG] > 0)
			{
				format(string, sizeof(string), "{FFFFFF}Zaufany Gracz: {741b47}%s {FFFFFF}({741b47}%s{FFFFFF}) {FFFFFF}[ID: %d] [ZGLVL: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i, PlayerInfo[i][pZG]); 
				sendTipMessage(playerid, string);			
			}
		}
	}
	return 1;
}

YCMD:admini(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[128], activeAdmins;
		SendClientMessage(playerid, -1, "Lista administratorów na s³u¿bie:"); 
		foreach(new i : Player)
		{
			if(HiddenAdmin[i]) continue; 
			if(GetPlayerAdminDutyStatus(i) == 1)
			{
				//GetPVarString(i, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname));
				if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{FFFFFF}H@: {FF6A6A}%s {FFFFFF}({FF6A6A}%s{FFFFFF}) {FFFFFF}[ID: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i);
				}
				else if(IsAScripter(i)) 
				{
					format(string, sizeof(string), "{FFFFFF}Skrypter: {747b41}%s {FFFFFF}({747b41}%s{FFFFFF}) {FFFFFF}[ID: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i);
				} 
				else if(PlayerInfo[i][pAdmin] >= 1)
				{
					format(string, sizeof(string), "{FFFFFF}Administrator: {FF6A6A}%s {FFFFFF}({FF6A6A}%s{FFFFFF}) {FFFFFF}[ID: %d] [@LVL: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i, PlayerInfo[i][pAdmin]); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] <= 4)
				{
					format(string, sizeof(string), "{FFFFFF}Pó³-Admin: {00C0FF}%s {FFFFFF}({00C0FF}%s{FFFFFF}) {FFFFFF}[ID: %d] [P@LVL: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i, PlayerInfo[i][pNewAP]); 
				}
				else if(PlayerInfo[i][pZG] > 0)
				{
					switch (PlayerInfo[i][pZG]) {
						case 1:  format(string, sizeof(string), "{FFFFFF}Opiekun IC: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 2:  format(string, sizeof(string), "{FFFFFF}Prawie ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 3:  format(string, sizeof(string), "{FFFFFF}Nowy ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 4:  format(string, sizeof(string), "{FFFFFF}Zaufany Gracz: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 5:  format(string, sizeof(string), "{FFFFFF}Przyzwoity ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 6:  format(string, sizeof(string), "{FFFFFF}Dobry ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 7:  format(string, sizeof(string), "{FFFFFF}Bardzo Dobry: ZG {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 8:  format(string, sizeof(string), "{FFFFFF}Œwietny ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 9:  format(string, sizeof(string), "{FFFFFF}Znakomity ZG: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 10: format(string, sizeof(string), "{FFFFFF}Æwieræ admin: {7AA1C9}%s {FFFFFF}({7AA1C9}%s{FFFFFF}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
					}
				}
				sendTipMessage(playerid, string); 
				activeAdmins = true;
			}
		}
		if(!activeAdmins) 
		{
			SendClientMessage(playerid, -1, "--- Brak ---"); 
			SendClientMessage(playerid, -1, "Lista administratorów na serwerze:"); 
			foreach(new i : Player)
			{
				if(HiddenAdmin[i]) continue;
				if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{888888}H@: {FF6A6A}%s {888888}({FF6A6A}%s{888888}) {888888}[ID: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i);
					sendTipMessage(playerid, string); 
				}
				else if(IsAScripter(i)) 
				{
					format(string, sizeof(string), "{888888}Skrypter: {747b41}%s {888888}({747b41}%s{888888}) {888888}[ID: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i);
					sendTipMessage(playerid, string); 
				} 
				else if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] < 5555)
				{
					format(string, sizeof(string), "{888888}Administrator: {FF6A6A}%s {888888}({FF6A6A}%s{888888}) {888888}[ID: %d] [@LVL: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i, PlayerInfo[i][pAdmin]); 
					sendTipMessage(playerid, string); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] <= 4)
				{
					format(string, sizeof(string), "{888888}Pó³-Admin: {00C0FF}%s {888888}({00C0FF}%s{888888}) {888888}[ID: %d] [P@LVL: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i, PlayerInfo[i][pNewAP]); 
					sendTipMessage(playerid, string); 
				}
				else if(IsAGameMaster(i))
				{
					format(string, sizeof(string), "{888888}GameMaster: {FFD700}%s {888888}({FFD700}%s{888888}) {888888}[ID: %d]", GetNickEx(i), PlayerInfo[i][pNickOOC], i); 
					sendTipMessage(playerid, string); 
				}
				else if(PlayerInfo[i][pZG] > 0)
				{
					switch (PlayerInfo[i][pZG]) {
						case 1:  format(string, sizeof(string), "{888888}Opiekun IC: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 2:  format(string, sizeof(string), "{888888}Prawie ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 3:  format(string, sizeof(string), "{888888}Nowy ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 4:  format(string, sizeof(string), "{888888}Zaufany Gracz: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 5:  format(string, sizeof(string), "{888888}Przyzwoity ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 6:  format(string, sizeof(string), "{888888}Dobry ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 7:  format(string, sizeof(string), "{888888}Bardzo Dobry: ZG {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 8:  format(string, sizeof(string), "{888888}Œwietny ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",		GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 9:  format(string, sizeof(string), "{888888}Znakomity ZG: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
						case 10: format(string, sizeof(string), "{888888}Æwieræ admin: {7AA1C9}%s {888888}({7AA1C9}%s{888888}) [ID: %d]",	GetNickEx(i), PlayerInfo[i][pNickOOC], i);
					}
					sendTipMessage(playerid, string); 
				}
			}
		}
	}
	return 1;
}
