//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zaliczegz ]-----------------------------------------------//
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

YCMD:zaliczegz(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAnInstructor(playerid))
        {
            new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
			    sendTipMessage(playerid, "U�yj /zaliczegz [playerid/Cz��Nicku]");
			    return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(TakingLesson[giveplayerid] != 1)
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie zacz�� lekcji !");
			            return 1;
			        }
			        GetPlayerName(playerid, sendername, sizeof(sendername));
			        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			        format(string, sizeof(string), "* %s otrzyma� zaliczenie egzaminu praktycznego.",giveplayer);
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			        format(string, sizeof(string), "* Gratulacje! Urz�dnik %s wystawi� ci ocen� poztywna z egzaminu! Id� do okienka odebra� prawo jazdy!",sendername);
			        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			        TakingLesson[giveplayerid] = 0;
			        PlayerInfo[giveplayerid][pCarLic] = 3;
			    }
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jeste� urz�dnikiem !");
            return 1;
        }
    }
    return 1;
}
