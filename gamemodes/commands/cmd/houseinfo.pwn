//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ houseinfo ]-----------------------------------------------//
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

YCMD:houseinfo(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        new koxu = dini_Int("Domy/NRD.ini", "NrDomow");
	        for(new h = 0; h <= koxu; h++)
			{
                if(IsPlayerInRangeOfPoint(playerid, 2.0, Dom[h][hWej_X], Dom[h][hWej_Y], Dom[h][hWej_Z]))
				{
				    new dom=h;
				    new string2[512];
					new wynajem[4];
					if(Dom[dom][hWynajem] == 0)
					{
                        wynajem = "nie";
					}
					else
					{
                        wynajem = "tak";
					}
					new drzwi[30];
					if(Dom[dom][hZamek] == 0)
					{
                        drzwi = "Zamkni�te";
					}
					else
					{
                        drzwi = "Otwarte";
					}
					if(Dom[dom][hDomNr] == -1)
						format(string2, sizeof(string2), "W�a�ciciel:\t%s\nID domu:\t%d\nWn�trze:\tW�asne\nCena domu:\t%d$\nO�wietlenie:\t%d\nDrzwi:\t\t%s", Dom[dom][hWlasciciel], dom, Dom[dom][hCena], Dom[dom][hSwiatlo], drzwi);
					else
	               		format(string2, sizeof(string2), "W�a�ciciel:\t%s\nStandard:\t%d gwiazdki\nID domu:\t%d\nID wn�trza:\t%d\nCena domu:\t%d$\nWynajem:\t%s\nIlosc pokoi:\t%d\nPokoi wynajmowanych\t%d\nCena wynajmu:\t%d$\nO�wietlenie:\t%d\nDrzwi:\t\t%s", Dom[dom][hWlasciciel], IntInfo[Dom[dom][hDomNr]][Kategoria], dom, Dom[dom][hDomNr], Dom[dom][hCena], wynajem, Dom[dom][hPokoje], Dom[dom][hPW], Dom[dom][hCenaWynajmu], Dom[dom][hSwiatlo], drzwi);
	                
					ShowPlayerDialogEx(playerid, 123, DIALOG_STYLE_MSGBOX, "G��wne informacje domu", string2, "Ogl�daj", "Wyjd�");
				}
			}
	    }
	}
	return 1;
}
