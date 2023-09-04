//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  antyspam                                                 //
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
// Autor: Simeone
// Data utworzenia: 25.09.2019
//Opis:
/*
	Timery i funkcje dotycz�ce anty-spamu
*/

//B�d� to rozwija� g��wnie pod uniwersalizm, aby antyspam nie nak�ada� si� na siebie i nie tworzy� milion�w zmiennych.
//P�ki co podstawowe za�o�enie si� sprawdza - wi�c na jaki� czas pozostaje to w takim stadium :) 

//-----------------<[ Funkcje: ]>-------------------
SetAntySpamForPlayer(playerid, ANTY_SPAM_TYPE)
{
	if(ANTY_SPAM_TYPE == 30)
	{
		SetTimerEx("AntySpam30", 10000, 0, "d", playerid);
	}
	return 1;
}
CheckAntySpamForPlayer(playerid, ANTY_SPAM_TYPE)
{
	if(ANTY_SPAM_TYPE == 30)
	{
		if(antySpam30[playerid] == 1)
		{
			return true;
		}
	}
	return false;
}

//end