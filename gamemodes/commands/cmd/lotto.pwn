//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ lotto ]-------------------------------------------------//
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

YCMD:lotto(playerid, params[], help)
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pLottoNr] > 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Posiadasz ju� los loteryjny !");
            return 1;
        }
        if(kaska[playerid] < PRICE_LOTTO)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz "#PRICE_LOTTO"$ aby kupi� los lotto !");
            return 1;
        }
        new lottonr;
		if( sscanf(params, "d", lottonr))
		{
			sendTipMessage(playerid,"U�yj /lotto [number]");
			return 1;
		}

		if(lottonr < 1 || lottonr > 80) { sendTipMessageEx(playerid, COLOR_GREY, "Numer lotto od 1 do 80 !"); return 1; }
		format(string, sizeof(string), "* Kupi�e� los lotto z numerem: %d.", lottonr);
		sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
		ZabierzKaseDone(playerid, PRICE_LOTTO);
		PlayerInfo[playerid][pLottoNr] = lottonr;
        Jackpot = Jackpot+PRICE_LOTTO;
    }
    return 1;
}
