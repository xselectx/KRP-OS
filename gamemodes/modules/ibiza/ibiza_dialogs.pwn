//------------------------------------------------<< Dialog >>-----------------------------------------------//
//-----------------------------------------------[ ibiza_dialogs ]----------------------------------------------//
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
// Data utworzenia: 1.02.2020

// Opis:
/*

*/

ibiza_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_IBIZA_TICKET){
		if(response){
			switch(listitem){
				case 0:{
					if(kaska[playerid] >= ibiza_priceNormal && ibiza_priceNormal != 0){
						ZabierzKaseDone(playerid, ibiza_priceNormal);
						IbizaTicket[playerid] = IBIZA_NORMAL;
						SetPlayerWeather(playerid, 27);
						SendClientMessage(playerid, -1, "Kasjerka m�wi: Dzi�kujemy za zakup biletu!");
						Sejf_Add(FAMILY_IBIZA, ibiza_priceNormal);
						Log(payLog, WARNING, "%s kupi� bilet normalny (Ibiza) za $ %d", GetPlayerLogName(playerid), ibiza_priceNormal);
					}else{
						if(ibiza_priceNormal == 0) SendClientMessage(playerid, -1, "Klub jest zamkni�ty.");
						else SendClientMessage(playerid, -1, "Nie masz wystarczaj�cej ilo�ci pieni�dzy!");
					}
				}
				case 1:{
					if(kaska[playerid] >= ibiza_priceVIP && ibiza_priceVIP != 0){
						ZabierzKaseDone(playerid, ibiza_priceVIP);
						IbizaTicket[playerid] = IBIZA_VIP;
						SetPlayerWeather(playerid, 27);
						SendClientMessage(playerid, -1, "Kasjerka m�wi: Dzi�kujemy za zakup biletu VIP!");
						Sejf_Add(FAMILY_IBIZA, ibiza_priceVIP);
						Log(payLog, WARNING, "%s kupi� bilet VIP (Ibiza) za $ %d", GetPlayerLogName(playerid), ibiza_priceNormal);
					}else{
						if(ibiza_priceVIP == 0) SendClientMessage(playerid, -1, "Klub jest zamkni�ty.");
						else SendClientMessage(playerid, -1, "Nie masz wystarczaj�cej ilo�ci pieni�dzy!");
					}
				}
				
			}
		}
	}
	if(dialogid == DIALOG_IBIZA_PANEL){
		if(response){
			switch(listitem){
				case 0 :{
					if(ibizaStrobes == false){
						ibizaStrobes = true;
						IbizaStrobesOn();
					}else{
						ibizaStrobes = false;
						IbizaStrobesOff();
					}
				}
				case 1 :{
					if(ibizaNeons == false){
						ibizaNeons = true;
						IbizaNeonsOn();
					}else{
						ibizaNeons = false;
						IbizaNeonsOff();
					}
				}
				case 2 :{
					if(ibizaLights == false){
						ibizaLights = true;
						IbizaLightsOn();
					}else{
						ibizaLights = false;
						IbizaLightsOff();
					}
				}
				case 3 :{
					if(ibizaSmokes == false){
						ibizaSmokes = true;
						IbizaSmokesOn();
					}else{
						ibizaSmokes = false;
						IbizaSmokesOff();
					}
				}
				case 4:{
					if(ibizaTextOne == false){
						ibizaTextOne = true;
						ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TEXT_ONE, DIALOG_STYLE_INPUT, "IbizaClub - Ustaw tekst #1", "Wpisz tekst", "Zatwierd�", "Anuluj");
					}else{
						ibizaTextOne = false;
						ibizaTextOneOff();
					}
				}
				case 5:{
					if(ibizaTextTwo == false){
						ibizaTextTwo = true;
						ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TEXT_TWO, DIALOG_STYLE_INPUT, "IbizaClub - Ustaw tekst #2", "Wpisz tekst", "Zatwierd�", "Anuluj");
					}else{
						ibizaTextTwo = false;
						ibizaTextTwoOff();
					}
				}
				case 6:{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_NORMAL_TICKET, DIALOG_STYLE_INPUT, "IbizaClub - Normalny bilet", "Wpisz cen� biletu normalnego\nMax 80 $", "Zatwierd�", "Anuluj");
				}
				case 7:{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_VIP_TICKET, DIALOG_STYLE_INPUT, "IbizaClub - Normalny bilet", "Wpisz cen� biletu VIP\nMax 200 $", "Zatwierd�", "Anuluj");
				}
			}
		}
	}
	if(dialogid == DIALOG_IBIZA_NORMAL_TICKET){
		if(response){
			new price = strval(inputtext);
			if(price < 0) ibiza_priceNormal = 0;
			else if(price > 80) ibiza_priceNormal = 80;
			else ibiza_priceNormal = price;
		}
	}
	if(dialogid == DIALOG_IBIZA_VIP_TICKET){
		if(response){
			new price = strval(inputtext);
			if(price < 0) ibiza_priceVIP = 0;
			else if(price > 200) ibiza_priceVIP = 200;
			else ibiza_priceVIP = price;
		}
	}
	if(dialogid == DIALOG_IBIZA_TEXT_ONE){
		if(response){
			ibizaTextOneText = CreateDynamicObject(19328, 410.189453, -1830.978637, -64.220527, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
			SetDynamicObjectMaterialText(ibizaTextOneText, 0, inputtext, 140, "Ariel", 60, 0, 0xFF000000, 0x00000000, 1);
		}
	}
	if(dialogid == DIALOG_IBIZA_TEXT_TWO){
		if(response){
			ibizaTextTwoText = CreateDynamicObject(4731, 430.835357, -1845.524658, -62.950248, 0.000000, 0.000000, -59.699989, -1, -1, -1, 300.00, 300.00); 
			SetDynamicObjectMaterialText(ibizaTextTwoText, 0, inputtext, 120, "Fixedsys", 20, 0, 0xFFFFFFFF, 0x00000000, 1);
		}
	}
    if(dialogid == DIALOG_KONSOLA_IBIZA)
    {
        if(!response) return 1;
        if(strlen(inputtext) < 10) return 1;

        foreach(new i : Player)
        {
            if(IsPlayerInRangeOfPoint(i, IbizaAudioPos[3],IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && (GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                PlayAudioStreamForPlayer(i, inputtext,IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2], IbizaAudioPos[3], 1);
            }
        }
        format(IBIZA_Stream, 128, "%s",inputtext);
    }
    return 1;
}