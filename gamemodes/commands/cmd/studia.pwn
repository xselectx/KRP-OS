//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ studia ]------------------------------------------------//
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

YCMD:studia(playerid, params[], help)
{
	new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
        if(CheckPlayerPerm(playerid, PERM_NEWS) && GroupPlayerDutyRank(playerid) >= 2)
        {
            new drukarniatxt[32];
			new studiovictxt[32];
			new studiogtxt[32];
			new studiontxt[32];
			new biurosantxt[32];
			if(drukarnia == 1)
			{
			    drukarniatxt = "Zamkni�te";
			}
			else
			{
			    drukarniatxt = "Otwarte";
			}
			if(studiovic == 1)
			{
			    studiovictxt = "Zamkni�te";
			}
			else
			{
			    studiovictxt = "Otwarte";
			}
			if(studiog == 1)
			{
			    studiogtxt = "Zamkni�te";
			}
			else
			{
			    studiogtxt = "Otwarte";
			}
			if(studion == 1)
			{
			    studiontxt = "Zamkni�te";
			}
			else
			{
			    studiontxt = "Otwarte";
			}
			if(biurosan == 1)
			{
			    biurosantxt = "Zamkni�te";
			}
			else
			{
			    biurosantxt = "Otwarte";
			}
			if(GUIExit[playerid] == 0)
			{
				format(string, sizeof(string), "Drukarnia (%s)\nStudio Victim (%s)\nStudio g��wne (%s)\nStudio nagra� (%s)\nGabinet red. naczelnego (%s)", drukarniatxt, studiovictxt, studiogtxt, studiontxt, biurosantxt);
	            ShowPlayerDialogEx(playerid, 322, DIALOG_STYLE_LIST, "Zamykanie i otwieranie studi�w", string, "Close/Open", "Wyjd�");
			}
		}
        else
        {
            sendTipMessageEx(playerid, COLOR_NEWS, "Nie jeste� z SAN/nie masz 2 rangi.");
        }
    }
	return 1;
}
