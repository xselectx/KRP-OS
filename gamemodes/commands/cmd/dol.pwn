//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ dol ]------------------------------------------------//
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
	https://Kotnik-rp.pl/index.php?/topic/55-propozycja-dodanie-losowanej-funkcji-narracyjnej/
    
*/


// Notatki skryptera:
/*
	/dol znajduje w szafie | top | t-shirt | bezrêkawnik
*/

YCMD:dol(playerid, params[], help)
{
	if(isnull(params)) 
    {
        sendTipMessage(playerid, "U¿yj /dol [akcja | wybór | wybór | ...]");
        sendTipMessage(playerid, "Przyk³ad: /dol znajduje w szafie | top | t-shirt | bezrêkawnik");
        return 1;
    }

    if(GetPVarInt(playerid, "dutyadmin") == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tego podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
		return 1;
	}

    new akcje[20][32], count;
    count = strexplode(akcje, params, "|");
    if(count < 3) return sendTipMessage(playerid, "Podaj przynajmniej 2 wybory do wylosowania.");

    new string[256], r;

    r = random(count-1)+1;
    strtrim(akcje[0]);
    strtrim(akcje[r]);
    akcje[0][0] = toupper(akcje[0][0]);

    format(string, sizeof(string), "* %s %s (( %s ))", akcje[0], akcje[r], GetNick(playerid));
    ProxDetector(10.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
    return 1;
}