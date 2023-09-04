//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  akceptuj                                                 //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "akceptuj_impl.pwn"

//-------<[ initialize ]>-------
command_akceptuj()
{
    new command = Command_GetID("akceptuj");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:akceptuj(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Akceptuje ofert� od gracza.");
        return 1;
    }
    //fetching params
    new nazwa[32];
    if(sscanf(params, "s[32]", nazwa))
    {
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Accept __________________|");
        SendClientMessage(playerid, COLOR_WHITE, "U�yj: /akceptuj [nazwa]");
        SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Sex, Dragi, Naprawa, Prawnik, Ochrona, Praca, Wywiad, Tankowanie");
        SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Auto, Taxi, Bus, Heli, Boks, Medyk, Mechanik, Gazeta, Mandat, kuracje");
        SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Rozwod, Swiadek, Slub, Pojazd, Wynajem, Wizytowka, Uwolnienie, biznes");
        SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Produkt, Zaproszenie, Zastrzyk, Mandat, Tuning");
        SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Smierc, Tatuaz");
        SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
        return 1;
    }
    
    //command body
    return command_akceptuj_Impl(playerid, nazwa);
}