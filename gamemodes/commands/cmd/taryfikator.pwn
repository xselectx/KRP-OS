//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ taryfikator ]----------------------------------------------//
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

YCMD:taryfikator(playerid, params[], help)
{
    ShowPlayerDialogEx(playerid,68,DIALOG_STYLE_LIST,"Kodeks wykrocze�: wybierz dzia�","Wykroczenia przeciwko porz�dkowi i bezpiecze�stwu publicznemu\nPosiadanie nielegalnych przedmiot�w\nWykroczenia przeciwko mieniu i zdrowiu\nWykroczenia przeciwko godno�ci osobistej\nUtrudnianie dzia�a� policji\nWykroczenia przeciwko bezpiecze�stwu w ruchu drogowym\nNiew�a�ciwe korzystanie z drogi\nInformacje","Wybierz","Wyjd�");
	return 1;
}
