//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  maseczka                                                 //
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
// Autor: Mrucznik
// Data utworzenia: 1.03.2020


//

//------------------<[ Implementacja: ]>-------------------
maseczka_akceptuj(playerid)
{
    new giveplayerid = GetPVarInt(playerid, "maseczka-doctorid");
    new uid = GetPVarInt(playerid, "maseczka-uid");
    new price = GetPVarInt(playerid, "maseczka-price");

    if(GetPVarInt(playerid, "maseczka-akceptuj") == 0)
    {
        sendErrorMessage(playerid, "Nikt nie oferowa� Ci maseczki.");
        return 1;
    }

    if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, kt�ry oferowa� Ci maseczk�, wyszed� z gry.");
        return 1;
    }

    if(uid != PlayerInfo[giveplayerid][pUID]) 
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, kt�ry oferowa� Ci maseczk�, wyszed� z gry.");
        SetPVarInt(playerid, "maseczka-doctorid", INVALID_PLAYER_ID);
        return 1;
    }

    if (!ProxDetectorS(10.0, playerid, giveplayerid))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Jeste� za daleko !");
        return 1;
    }

    if(kaska[playerid] < price)
    {
        sendErrorMessage(playerid, "Nie sta� Ci� na maseczk�!");
        return 1;
    }

    //body
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Akceptowa�e� kupno maseczki od %s za %d$. Aby j� zdj��, wpisz /zdejmij.", GetNick(giveplayerid), price));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* Gracz %s kupi� od Ciebie maseczk� za %d$.", GetNick(playerid), price));

    ZabierzKaseDone(playerid, price);
    DajKaseDone(giveplayerid, price);
    Log(payLog, WARNING, "%s zap�aci� %s $%d za maseczke", 
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), price
    );
    SetPlayerImmunity(giveplayerid, MAX_PLAYER_IMMUNITY);
    SetPVarInt(playerid, "maseczka", 1);
    new index = AttachPlayerItem(playerid, 18919, 2, -0.07, 0.0, 0.0, 85.0, 170.0, 86.0, 1.000000, 1.000000, 1.000000 );//bandana
    EditAttachedObject(playerid, index);

    SetPVarInt(playerid, "maseczka-akceptuj", 0);
    return 1;
}

command_maseczka_Impl(playerid, giveplayerid, price)
{
	if ( !(IsAMedyk(playerid) && GroupPlayerDutyRank(playerid) >= 1))
	{
		sendErrorMessage(playerid, "Nie masz 1 rangi lub nie jeste� medykiem!");
        return 1;
	}
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jeste� zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    if(!IsPlayerHealthy(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie mo�esz sprzeda� maseczki choremu graczowi.");
        return 1;
    }

    if(price < PRICE_MASECZKA_MIN) 
    {
        sendErrorMessage(playerid, "Cena musi by� wi�ksza ni� "#PRICE_MASECZKA_MIN"$.");
        return 1;
    }
    if(price > PRICE_MASECZKA_MAX)
    {
        sendErrorMessage(playerid, "Cena musi by� mniejsza ni� "#PRICE_MASECZKA_MAX"$.");
        return 1;
    }

    //body
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Oferujesz %s kupno maseczki ochronnej za %d$.", GetNick(giveplayerid), price));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* %s oferuje Ci kupno maseczki ochronnej za %d$. Wpisz /akceptuj maseczka aby si� zgodzi�.", GetNick(playerid), price));


    SetPVarInt(giveplayerid, "maseczka-akceptuj", 1);
    SetPVarInt(giveplayerid, "maseczka-doctorid", playerid);
    SetPVarInt(giveplayerid, "maseczka-uid", PlayerInfo[playerid][pUID]);
    SetPVarInt(giveplayerid, "maseczka-price", price);
    return 1;
}

//end