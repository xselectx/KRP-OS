//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ cp ]--------------------------------------------------//
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

YCMD:cp(playerid, params[], help)
{
	new string[128];

	if(IsANoA(playerid) || IsAKt(playerid) || HasPerm(playerid, PERM_RACING))
	{
		if(GroupPlayerDutyRank(playerid) >= 5)
		{
		    if(tworzenietrasy[playerid] != 666)
		    {
		        new Float:gx, Float:gy, Float:gz;
				GetPlayerPos(playerid, gx, gy, gz);
				//
		        if(Wyscig[tworzenietrasy[playerid]][wCheckpointy] == MAX_CHECKPOINTS)
		        {
		            SendClientMessage(playerid, COLOR_GREY, "Postawiono met�. Wszystkich checkpoint�w: 51. Wy�cig pomy�lnie utworzony!");
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][0] = gx;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][1] = gy;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][2] = gz;
		            DisablePlayerRaceCheckpoint(playerid);
		           	Wyscig[tworzenietrasy[playerid]][wStworzony] = 1;
		           	ZapiszTrase(tworzenietrasy[playerid]);
		           	new komunikat[1024];
					new wklej[128];
					if(Wyscig[tworzenietrasy[playerid]][wTypCH] == 0)
					{
						strcat(wklej, "{7CFC00}Typ checkpoint�w:{FFFFFF} Normalne\n");
					}
					else
					{
					    strcat(wklej, "{7CFC00}Typ checkpoint�w:{FFFFFF} Ko�a\n");
					}
					if(Wyscig[tworzenietrasy[playerid]][wRozmiarCH] == 10.0)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Ogromne\n");
					}
					else if(Wyscig[tworzenietrasy[playerid]][wRozmiarCH] == 7.5)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Du�e\n");
					}
					else if(Wyscig[tworzenietrasy[playerid]][wRozmiarCH] == 5)
					{
					    strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} �rednie\n");
					}
					else if(Wyscig[tworzenietrasy[playerid]][wRozmiarCH] == 2.5)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Ma�e\n");
					}
					else if(Wyscig[tworzenietrasy[playerid]][wRozmiarCH] == 1)
					{
					    strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Mini\n");
					}
		           	format(komunikat, sizeof(komunikat), "{FF0000}Informacje o wy�cigu:{FFFFFF}\n\n{7CFC00}Nazwa:{FFFFFF} %s\n{7CFC00}Opis:{FFFFFF} %s\n{7CFC00}Nagroda:{FFFFFF} %d$\n%s\n{7CFC00}Ilo�� checkpoint�w:{FFFFFF} %d", Wyscig[tworzenietrasy[playerid]][wNazwa], Wyscig[tworzenietrasy[playerid]][wOpis], Wyscig[tworzenietrasy[playerid]][wNagroda], wklej, Wyscig[tworzenietrasy[playerid]][wCheckpointy]+1);
		            ShowPlayerDialogEx(playerid, 1428, DIALOG_STYLE_MSGBOX, "Kreator wy�cig�w: Koniec tworzenia", komunikat, "Koniec", "");
		            tworzenietrasy[playerid] = 666;
		        }
		        else
		        {
		            new Float:px, Float:py, Float:pz, Float:pa;
					if(IsPlayerInAnyVehicle(playerid)) { GetVehicleZAngle(GetPlayerVehicleID(playerid), pa); } else { GetPlayerFacingAngle(playerid,pa); }
					if(pa >= 0.0 && pa <= 22.5)
					{ py = gx+30; px = gx; }
					else if(pa >= 22.5 && pa <= 67.5) //nw
					{ px = gx-15; py = gy+15; }
					else if(pa >= 67.5 && pa <= 112.5) //w
					{ px = gx-30; py = gy; }
					else if(pa >= 112.5 && pa <= 157.5) //sw
					{ px = gx-15; py = gy-15; }
					else if(pa >= 157.5 && pa <= 202.5) //s
					{ px = gx; py = gy-30; }
					else if(pa >= 202.5 && pa <= 247.5)//se
					{ px = gx+15; py = gy-15; }
					else if(pa >= 247.5 && pa <= 292.5)//e
					{ px = gx+30; py = gy; }
					else if(pa >= 292.5 && pa <= 332.5)//e
					{ px = gx+15; py = gy+15; }
					else if(pa >= 332.5 && pa < 0.0) //n2
					{ px = gx; py = gy+30; }
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][0] = gx;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][1] = gy;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][2] = gz;
		            Wyscig[tworzenietrasy[playerid]][wCheckpointy] ++;
		            SetPlayerRaceCheckpoint(playerid,Wyscig[tworzenietrasy[playerid]][wTypCH],gx, gy, gz, px, py, pz, Wyscig[tworzenietrasy[playerid]][wRozmiarCH]);
		           	format(string, sizeof(string), "Postawiono checkpoint numer %d (max 50). Aby usun�� = /cp-usun", Wyscig[tworzenietrasy[playerid]][wCheckpointy]);
					SendClientMessage(playerid, COLOR_GREY, string);
		        }
		    }
		    else
 			{
 			    sendErrorMessage(playerid, "Nie jeste� w trakcie tworzenia wy�cigu!");
 			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnie� (wymagana 5 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jeste� z NoA lub Korporacji Transportowej!");
	}
	return 1;
}
