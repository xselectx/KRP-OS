//------------------------------------------<< Generated source >>-------------------------------------------//
//-----------------------------------------------[ Commands ]------------------------------------------------//
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


#include <YSI_Coding\y_hooks>

//-------<[ include ]>-------
#include "zastrzyk\zastrzyk.pwn"
#include "maseczka\maseczka.pwn"
#include "kuracja\kuracja.pwn"
#include "odpornosc\odpornosc.pwn"
#include "diagnozuj\diagnozuj.pwn"
#include "getimmunity\getimmunity.pwn"
#include "uleczall\uleczall.pwn"
#include "setimmunity\setimmunity.pwn"
#include "ulecz\ulecz.pwn"
#include "zaraz\zaraz.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_zastrzyk();
    command_maseczka();
    command_kuracja();
    command_odpornosc();
    command_diagnozuj();
    command_getimmunity();
    command_uleczall();
    command_setimmunity();
    command_ulecz();
    command_zaraz();
    
}