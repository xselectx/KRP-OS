//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 agraffiti                                                 //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------

//-------<[ initialize ]>-------
command_r1()
{
    new command = Command_GetID("r1");

    //aliases
    Command_AddAlt(command, "r1");
    Command_AddAlt(command, "radio1");

    command = Command_GetID("r2");

    //aliases
    Command_AddAlt(command, "r2");
    Command_AddAlt(command, "radio2");

    command = Command_GetID("r3");

    //aliases
    Command_AddAlt(command, "r3");
    Command_AddAlt(command, "radio3");
}

//-------<[ command ]>-------
YCMD:r1(playerid, params[])
{
    GroupSendMessageRadio(playerid, 1, params);
    return 1;
}
YCMD:r2(playerid, params[])
{
    GroupSendMessageRadio(playerid, 2, params);
    return 1;
}
YCMD:r3(playerid, params[])
{
    GroupSendMessageRadio(playerid, 3, params);
    return 1;
}
