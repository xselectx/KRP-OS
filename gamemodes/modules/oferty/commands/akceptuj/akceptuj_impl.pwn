//-----------------------------------------------<< Source >>------------------------------------------------//
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020


//
//TODO: przerobi� ca�kowicie
//------------------<[ Implementacja: ]>-------------------
command_akceptuj_Impl(playerid, x_job[32])
{
    new string[256];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];
    if(strcmp(x_job, "biznes", false) == 0)
    {
        Business_AkceptujBiznes(playerid);
    }
    else if(strcmp(x_job, "mandat", true) == 0)
    {
        new policjant = GetPVarInt(playerid, "IdPolicjanta");
        if(GetPVarInt(playerid, "HaveMandat") == 0) return SendClientMessage(playerid, COLOR_GREY, "   Nikt nie da� ci mandatu !");
        if(IsPlayerConnected(policjant))
        {
            if(IsAPolicja(policjant))
            {
                new amount = GetPVarInt(playerid, "KwotaMandatu");
                if(kaska[playerid] < amount) return sendErrorMessage(playerid, "Nie sta� Cie na zaplacenie mandatu");
                ZabierzKaseDone(playerid, amount);
			    DajKaseDone(policjant, amount);
                new str[128];
                format(str, sizeof(str), "Akceptowa�e� mandat od %s o kwocie $%i!", GetNickEx(policjant), amount);
                SendClientMessage(playerid, COLOR_BLUE, str);
                format(str, sizeof(str), "%s akceptowa� mnandat o kwocie $%i!", GetNickEx(playerid), amount);
                SendClientMessage(policjant, COLOR_BLUE, str);
            } else sendTipMessage(playerid, "Tw�j mandat wygas�!");
        } else sendTipMessage(playerid, "Tw�j mandat wygas�!");

        SetPVarInt(playerid, "IdPolicjanta", 0);
        SetPVarInt(playerid, "KwotaMandatu", 0);
        SetPVarInt(playerid, "HaveMandat", 0);
        return 1;
    }
    else if(strcmp(x_job,"wizytowka",true) == 0 || strcmp(x_job,"wizytowke",true) == 0 || strcmp(x_job,"wizyt�wka",true) == 0 || strcmp(x_job,"wizyt�wk�",true) == 0 || strcmp(x_job,"wizyt�wke",true) == 0)
    {
        new dawacz = GetPVarInt(playerid, "wizytowka");
        new nazwa[32];
        if(dawacz == -1)
        {
            sendErrorMessage(playerid, "Nikt nie oferowa� Ci wizyt�wki.");
            return 1;
        }
        
        if(!IsPlayerConnected(dawacz))
        {
            sendErrorMessage(playerid, "Gracz, kt�ry oferowa� Ci wizyt�wk� wyszed�.");
            return 1;
        }
        
        if(!CzyMaWolnySlotNaKontakt(playerid))
        {
            sendErrorMessage(playerid, "Osi�gn��e� maksymaln� liczb� kontakt�w.");
            return 1;
        }
		
        if(CzyKontaktIstnieje(playerid, GetPhoneNumber(dawacz)))
        {
            sendErrorMessage(playerid, "Ten numer ju� istnieje w Twoich kontaktach.");
            return 1;
        }
        
        if(!ProxDetectorS(10.0, playerid, dawacz))
        {
            sendErrorMessage(playerid, "Jeste� za daleko od gracza, kt�ry oferowa� Ci wizyt�wk�.");
            return 1;
        }
        
        format(string, sizeof(string), "* Akceptowa�e� wizyt�wk� od %s, dodano nowy kontakt.", GetNick(dawacz));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), "* %s przyj�� Twoj� wizyt�wk�.", GetNick(playerid));
        
        format(string, sizeof(string), "* %s wr�cza z u�miechem wizyt�wk� %s, kt�ry chowa j� do kieszeni.", GetNick(dawacz), GetNick(playerid));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
        
        GetPVarString(playerid, "wizytowka-nazwa", nazwa, sizeof(nazwa));
        format(string, sizeof(string), "dodaj %d %s", GetPhoneNumber(dawacz), nazwa);
        SetPVarInt(playerid, "wizytowka", -1);
        RunCommand(playerid, "/kontakty",  string);
    }
    if(strcmp(x_job,"pojazd",true) == 0 || strcmp(x_job,"auto",true) == 0)
    {
        if(GraczDajacy[playerid] < 999)
        {
            if(IsPlayerConnected(GraczDajacy[playerid]))
            {
                if(kaska[playerid] > CenaDawanegoAuta[playerid] && CenaDawanegoAuta[playerid] > 0 && kaska[playerid] >= 1)
                {
                    new vehicle = GetPlayerVehicleID(GraczDajacy[playerid]);
                    if(vehicle == CarData[IDAuta[playerid]][c_ID])
                    {
                        if(CarData[IDAuta[playerid]][c_Owner] != PlayerInfo[GraczDajacy[playerid]][pUID])
                        {
                            GraczDajacy[playerid] = 0;
                            CenaDawanegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci sprzeda�y !");
                            return 1;
                        }
                        GetPlayerName(playerid, sendername, sizeof(sendername));

                        if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots])
                        {
                            SendClientMessage(GraczDajacy[playerid], COLOR_GREY, " Gracz nie posiada wolnego slota.");
                            GraczDajacy[playerid] = 0;
                            CenaDawanegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, " Nie posiadasz wolnego slota.");
                            return 1;
                        }
            
                        foreach(new i : Player)
                        {
                           if(PlayerInfo[i][pKluczeAuta] == IDAuta[playerid])
                            {
                                PlayerInfo[i][pKluczeAuta] = 0;
                            }
                        }
                        Car_MakePlayerOwner(playerid, IDAuta[playerid]);
                        Car_RemovePlayerOwner(GraczDajacy[playerid], IDAuta[playerid]);

                        new cena = CenaDawanegoAuta[playerid];
                        GetPlayerName(GraczDajacy[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Akceptowa�e� sprzeda� %s od %s za %d. Wpisz /autopomoc aby zobaczy� nowe komendy!", VehicleNames[GetVehicleModel(vehicle)-400], giveplayer, cena);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s akceptowa� sprzeda� twojego %s, zarabiasz %d.", sendername, VehicleNames[GetVehicleModel(vehicle)-400], cena);
                        SendClientMessage(GraczDajacy[playerid], COLOR_LIGHTBLUE, string);
                        Log(payLog, WARNING, "%s kupi� od %s auto %s za %d$", GetPlayerLogName(playerid), GetPlayerLogName(GraczDajacy[playerid]), GetVehicleLogName(vehicle), cena);
                        
                        ZabierzKaseDone(playerid, cena);
                        DajKaseDone(GraczDajacy[playerid], cena);
                        RemovePlayerFromVehicleEx(GraczDajacy[playerid]);
                        GraczDajacy[playerid] = 999;
                        CenaDawanegoAuta[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa� ci auta!");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie sta� ci�!");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci sprzeda�y!");
            return 1;
        }
    }
    if(strcmp(x_job,"wymiana",true) == 0)
    {
        if(GraczWymieniajacy[playerid] < 999)
        {
            if(IsPlayerConnected(GraczWymieniajacy[playerid]))
            {
                if(kaska[playerid] > CenaWymienianegoAuta[playerid] && CenaWymienianegoAuta[playerid] > 0 && kaska[playerid] >= 1)
                {
                    if(GetPlayerVehicleID(GraczWymieniajacy[playerid]) == CarData[IDAuta[playerid]][c_ID])
                    {
                        if(CarData[IDAuta[playerid]][c_Owner] != PlayerInfo[GraczWymieniajacy[playerid]][pUID])
                        {
                            GraczWymieniajacy[playerid] = 0;
                            CenaWymienianegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci wymiany !");
                            return 1;
                        }
                        GetPlayerName(playerid, sendername, sizeof(sendername));

                        
                        if(!ProxDetectorS(10.0, playerid, GraczWymieniajacy[playerid])) return SendClientMessage(playerid, 0xFFC0CB, "Ten gracz jest za daleko !");
                        if(!IsPlayerInAnyVehicle(playerid))
                        {
                            SendClientMessage(playerid, COLOR_GREY, " Musisz by� w poje�dzie.");
                            return 1;
                        }
                        if(IDWymienianegoAuta[playerid] == 0)
                        {
                            SendClientMessage(playerid, COLOR_GREY, " Wyszed�e� z auta wymienianego.");
                            GraczWymieniajacy[playerid] = 999;
                            CenaWymienianegoAuta[playerid] = 0;
                            return 1;
                        }
                        
                        Car_RemovePlayerOwner(GraczWymieniajacy[playerid], IDAuta[playerid]);
                        Car_RemovePlayerOwner(playerid, VehicleUID[GetPlayerVehicleID(playerid)][vUID]);
                        
                        Car_MakePlayerOwner(playerid, IDAuta[playerid]);
                        Car_MakePlayerOwner(GraczWymieniajacy[playerid], VehicleUID[GetPlayerVehicleID(playerid)][vUID]);

                        GetPlayerName(GraczWymieniajacy[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Akceptowa�e� wymian� %s od %s za %d. Wpisz /autopomoc aby zobaczy� nowe komendy!", VehicleNames[GetVehicleModel(GetPlayerVehicleID(GraczWymieniajacy[playerid]))-400], giveplayer, CenaWymienianegoAuta[playerid]);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s akceptowa� wymian� twojego %s, zarabiasz %d.", sendername, VehicleNames[GetVehicleModel(GetPlayerVehicleID(GraczWymieniajacy[playerid]))-400], CenaWymienianegoAuta[playerid]);
                        SendClientMessage(GraczWymieniajacy[playerid], COLOR_LIGHTBLUE, string);

                        Log(payLog, WARNING, "%s auto %s wymiana aut z %s auto %s z dop�at� %d$", \
                            GetPlayerLogName(playerid), GetVehicleLogName(GetPlayerVehicleID(playerid)), \
                            GetPlayerLogName(GraczWymieniajacy[playerid]), GetVehicleLogName(GetPlayerVehicleID(GraczWymieniajacy[playerid])), \
                            CenaWymienianegoAuta[playerid]
                        );
                        ZabierzKaseDone(playerid, CenaWymienianegoAuta[playerid]);
                        DajKaseDone(GraczWymieniajacy[playerid], CenaWymienianegoAuta[playerid]);
                        RemovePlayerFromVehicleEx(GraczWymieniajacy[playerid]);
                        RemovePlayerFromVehicleEx(playerid);
                        GraczWymieniajacy[playerid] = 999;
                        CenaWymienianegoAuta[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa� ci wymiany !");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie sta� ci� na wymian� !");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci wymiany !");
            return 1;
        }
    }
    else if(strcmp(x_job,"rozwod",true) == 0)
    {
        if(DivorceOffer[playerid] < 999)
        {
            if(IsPlayerConnected(DivorceOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, DivorceOffer[playerid]))
                {
                    GetPlayerName(DivorceOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa�e� wniosek %s do rozwodu.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s akceptowa� tw�j wniosek o rozw�d.", sendername);
                    SendClientMessage(DivorceOffer[playerid], COLOR_LIGHTBLUE, string);
                    ClearMarriage(playerid);
                    ClearMarriage(DivorceOffer[playerid]);
                    PlayerInfo[playerid][pPbiskey] = 255;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz kt�ry wys�a� ci papiery rozwodowe nie jest blisko ciebie !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie wys�a� ci papier�w rozwodowych !");
            return 1;
        }
    }
    else if(strcmp(x_job,"swiadek",true) == 0)
    {
        if(MarryWitnessOffer[playerid] < 999)
        {
            if(IsPlayerConnected(MarryWitnessOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, MarryWitnessOffer[playerid]))
                {
                    GetPlayerName(MarryWitnessOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa�e� pro�b� %s aby by� �wiadkiem.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s zaakceptowa� twoj� pro�b� aby by� �wiadkiem.", sendername);
                    SendClientMessage(MarryWitnessOffer[playerid], COLOR_LIGHTBLUE, string);
                    MarryWitness[MarryWitnessOffer[playerid]] = playerid;
                    MarryWitnessOffer[playerid] = 999;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz kt�ry prosi ci� o bycie �wiadkiem jest za daleko !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie poprosi� ci� o bycie �wiadkiem !");
            return 1;
        }
    }
    else if(strcmp(x_job,"slub",true) == 0)
    {
        if(ProposeOffer[playerid] < 999)
        {
            if(!PlayerToPoint(10.0, playerid, 1964.2332,-369.1353,1093.7289) && !PlayerToPoint(10.0, playerid, -2482.6416,2406.8088,17.1094) && !PlayerToPoint(10.0, playerid, 2256.8000488281,-43.900001525879,26.5))
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� w kosciele LS / Bay Side / Palomino Creek!");
                return 1;
            }
            if(IsPlayerConnected(ProposeOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, ProposeOffer[playerid]))
                {
                    if(MarryWitness[ProposeOffer[playerid]] == 999)
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Do �lubu potrzebny jest �wiadek !");
                        return 1;
                    }
                    if(IsPlayerConnected(MarryWitness[ProposeOffer[playerid]]))
                    {
                        if(ProxDetectorS(12.0, ProposeOffer[playerid], MarryWitness[ProposeOffer[playerid]]))
                        {
                            GetPlayerName(ProposeOffer[playerid], giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            format(string, sizeof(string), "* Akceptowa�e� �lub z %s.", giveplayer);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "* %s Akceptowa�a �lub z tob�.", sendername);
                            SendClientMessage(ProposeOffer[playerid], COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "Ksi�dz: %s czy chcesz aby %s zosta� twoim m�em? (wpisz 'tak', cokolwiek innego anuluje �lub)", sendername, giveplayer);
                            SendClientMessage(playerid, COLOR_WHITE, string);
                            MarriageCeremoney[playerid] = 1;
                            ProposedTo[ProposeOffer[playerid]] = playerid;
                            GotProposedBy[playerid] = ProposeOffer[playerid];
                            MarryWitness[ProposeOffer[playerid]] = 999;
                            ProposeOffer[playerid] = 999;
                            return 1;
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "   �wiadek jest za daleko !");
                            return 1;
                        }
                    }
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz z kt�rym bierzesz �lub jest za daleko !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie chce si� z tob� o�eni� !");
            return 1;
        }
    }
    else if(strcmp(x_job,"ticket",true) == 0 || strcmp(x_job,"mandat",true) == 0)
    {
        if(TicketOffer[playerid] < 999)
        {
            if(IsPlayerConnected(TicketOffer[playerid]))
            {
                if (ProxDetectorS(5.0, playerid, TicketOffer[playerid]))
                {
                    if(TicketMoney[playerid] < kaska[playerid] && TicketMoney[playerid] > 0)
                    {
                        GetPlayerName(TicketOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        new karne = GetPVarInt(playerid, "mandat_punkty");
                        format(string, sizeof(string), "* Zap�aci�e� mandat w wysoko�ci $%d Policjantowi %s.", TicketMoney[playerid], giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        if(karne>0) {
                            format(string, sizeof(string), "* Dosta�e� te� %d PK", karne);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            PlayerInfo[playerid][pPK] += karne;
                            if(PlayerInfo[playerid][pPK] > 24) 
                            {
                                format(string, sizeof(string), "* Przekroczy�e� limit 24 PK. Tracisz prawo jazdy");
                                SendClientMessage(playerid, COLOR_RED, string);
                                //86400 - jeden dzien
                                PlayerInfo[playerid][pPK] = 0;
                                PlayerInfo[playerid][pCarLic] = 0;
                                format(string, sizeof(string), "* %s straci� prawo jazdy z powodu przekroczenia limitu 24 PK", sendername);
                                SendClientMessage(TicketOffer[playerid], COLOR_RED, string);
                            }
                        }

                        //format(string, sizeof(string), "* %s zap�aci� mandat $%d. Otrzymujesz po�ow� tej kwoty.", sendername, TicketMoney[playerid]);
                        SetPVarInt(playerid, "mandat_punkty", 0);
                        ZabierzKaseDone(playerid, TicketMoney[playerid]);
                        new depo2 = floatround(((TicketMoney[playerid]/100) * 80), floatround_round); //sejf
                        new depo3 = floatround(((TicketMoney[playerid]/100) * 20), floatround_round); //pd
                        format(string, sizeof(string), "* %s zap�aci� mandat $%d. Otrzymujesz $%d", sendername, TicketMoney[playerid], depo3);
                        SendClientMessage(TicketOffer[playerid], COLOR_LIGHTBLUE, string);
                        DajKaseDone(TicketOffer[playerid], depo3);
                        Sejf_Add(1, depo2);
                        TicketOffer[playerid] = 999;
                        TicketMoney[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Nie sta� ci�!");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Policjant nie jest przy tobie !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie da� ci mandatu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"boxing",true) == 0 || strcmp(x_job,"box",true) == 0 || strcmp(x_job,"boks",true) == 0)
    {
        if(BoxOffer[playerid] < 999)
        {
            if(IsPlayerConnected(BoxOffer[playerid]))
            {
                new points;
                new mypoints;
                GetPlayerName(BoxOffer[playerid], giveplayer, sizeof(giveplayer));
                GetPlayerName(playerid, sendername, sizeof(sendername));
                new level = PlayerInfo[BoxOffer[playerid]][pBoxSkill];
                if(level >= 0 && level <= 50) { points = 40; }
                else if(level >= 51 && level <= 100) { points = 50; }
                else if(level >= 101 && level <= 200) { points = 60; }
                else if(level >= 201 && level <= 400) { points = 70; }
                else if(level >= 401) { points = 80; }
                if(PlayerInfo[playerid][pJob] == 12)
                {
                    new clevel = PlayerInfo[playerid][pBoxSkill];
                    if(clevel >= 0 && clevel <= 50) { mypoints = 40; }
                    else if(clevel >= 51 && clevel <= 100) { mypoints = 50; }
                    else if(clevel >= 101 && clevel <= 200) { mypoints = 60; }
                    else if(clevel >= 201 && clevel <= 400) { mypoints = 70; }
                    else if(clevel >= 401) { mypoints = 80; }
                }
                else
                {
                    mypoints = 30;
                }
                format(string, sizeof(string), "* Akceptowa�e� walk� boksersk� z %s, zaczynasz z %d Punktami �ycia.",giveplayer,mypoints);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* %s akceptowa� walk� boksersk� z tob�, zaczynasz z %d Punktami �ycia.",sendername,points);
                SendClientMessage(BoxOffer[playerid], COLOR_LIGHTBLUE, string);
                SetPlayerHealth(playerid, mypoints);
                SetPlayerHealth(BoxOffer[playerid], points);
                SetPlayerInterior(playerid, 5); SetPlayerInterior(BoxOffer[playerid], 5);
                SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                SetPlayerPos(BoxOffer[playerid], 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(BoxOffer[playerid], 313.1165);
                TogglePlayerControllable(playerid, 0); TogglePlayerControllable(BoxOffer[playerid], 0);
                GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(BoxOffer[playerid], "~r~Czekaj", 3000, 1);
                new name[MAX_PLAYER_NAME];
                new dstring[MAX_PLAYER_NAME];
                new wstring[MAX_PLAYER_NAME];
                GetPlayerName(playerid, name, sizeof(name));
                format(dstring, sizeof(dstring), "%s", name);
                strmid(wstring, dstring, 0, strlen(dstring), 255);
                if(strcmp(Titel[TitelName] ,wstring, true ) == 0 )
                {
                    format(string, sizeof(string), "Boks News: Mistrz Bokserski %s walczy z %s, za 60 sekund (w Si�owni Grove Street).",  sendername, giveplayer);
                    OOCOff(COLOR_WHITE,string);
                    TBoxer = playerid;
                    BoxDelay = 60;
                }
                GetPlayerName(BoxOffer[playerid], name, sizeof(name));
                format(dstring, sizeof(dstring), "%s", name);
                strmid(wstring, dstring, 0, strlen(dstring), 255);
                if(strcmp(Titel[TitelName] ,wstring, true ) == 0 )
                {
                    format(string, sizeof(string), "Boks News: Mistrz Bokserski %s walczy z %s, za 60 sekund (w Si�owni Grove Street).",  giveplayer, sendername);
                    OOCOff(COLOR_WHITE,string);
                    TBoxer = BoxOffer[playerid];
                    BoxDelay = 60;
                }
                BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                if(BoxDelay < 1) { BoxDelay = 20; }
                InRing = 1;
                Boxer1 = BoxOffer[playerid];
                Boxer2 = playerid;
                PlayerBoxing[playerid] = 1;
                PlayerBoxing[BoxOffer[playerid]] = 1;
                BoxOffer[playerid] = 999;
                return 1;
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferuje ci walki bokserskiej !");
            return 1;
        }
    }
    else if(strcmp(x_job,"taxi",true) == 0)
    {
        if(TransportDuty[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� taks�wkrzem !");
            return 1;
        }
        if(TaxiCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jeste� na misji, nie mo�esz u�ywa� tej komendy !");
            return 1;
        }
        if(TaxiCall < 999)
        {
            if(IsPlayerConnected(TaxiCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(TaxiCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, jed� do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Taks�wkarz %s akceptowa� twoje zlecenie, czekaj na niego i nie ruszaj si� z miejsca.",sendername);
                SendClientMessage(TaxiCall, COLOR_LIGHTBLUE, string);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
                TaxiCallTime[playerid] = 1;
                TaxiAccepted[playerid] = TaxiCall;
                TaxiCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia� taks�wki !");
            return 1;
        }
    }
    else if(strcmp(x_job,"heli",true) == 0)
    {
        if(TransportDuty[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� pilotem !");
            return 1;
        }
        new newcar = GetPlayerVehicleID(playerid);
        if(!IsAPlane(newcar))
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie pilotujesz helikoptera !");
            return 1;
        }
        if(TaxiCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jeste� na misji, nie mo�esz u�ywa� tej komendy !");
            return 1;
        }
        if(HeliCall < 999)
        {
            if(IsPlayerConnected(HeliCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(HeliCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, le� do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Pilot %s akceptowa� twoje zlecenie, czekaj na niego i nie ruszaj si� z miejsca.",sendername);
                SendClientMessage(HeliCall, COLOR_LIGHTBLUE, string);
                GameTextForPlayer(playerid, "~w~Lec do~n~~r~czerwonego punktu", 5000, 1);
                TaxiCallTime[playerid] = 1;
                TaxiAccepted[playerid] = HeliCall;
                HeliCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia� helikoptera !");
            return 1;
        }
    }
    else if(strcmp(x_job,"bus",true) == 0)
    {
        if(TransportDuty[playerid] != 2)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� kierowc� autobusu na s�u�bie !");
            return 1;
        }
        if(BusCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jeste� na misji, nie mo�esz u�ywa� tej komendy !");
            return 1;
        }
        if(PlayerInfo[playerid][pJob] == 10 && PlayerInfo[playerid][pCarSkill] < 400)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Potrzebujesz 5 skilla kierowcy autobusu aby m�c odbiera� wezwania !");
            return 1;
        }
        if(BusCall < 999)
        {
            if(IsPlayerConnected(BusCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(BusCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, jed� do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Kierowca Autobusu %s akceptowa� twoje wezwanie, czekaj na niego i nie ruszaj si� z miejsca.",sendername);
                SendClientMessage(BusCall, COLOR_LIGHTBLUE, string);
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(BusCall, X, Y, Z);
                SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
                BusCallTime[playerid] = 1;
                BusAccepted[playerid] = BusCall;
                BusCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie dzwoni� po autobus !");
            return 1;
        }
    }
    else if(strcmp(x_job,"medic",true) == 0 || strcmp(x_job,"medyk",true) == 0)
    {
        if(IsPlayerInGroup(playerid, 4) || PlayerInfo[playerid][pLider] == 4)
        {
            if(MedicCallTime[playerid] > 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
                return 1;
            }
            if(PlayerOnMission[playerid] > 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "   Jeste� na misji, nie mo�esz u�ywa� tej koemndy !");
                return 1;
            }
            if(MedicCall < 999)
            {
                if(IsPlayerConnected(MedicCall))
                {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    GetPlayerName(MedicCall, giveplayer, sizeof(giveplayer));
                    format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, masz 30 sekund na dojechanie tam.",giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Po 30 sekundach marker zniknie.");
                    format(string, sizeof(string), "* Medyk %s akceptowa� twoje zlecenie, NIE RUSZAJ SI� z miejsca.",sendername);
                    SendClientMessage(MedicCall, COLOR_LIGHTBLUE, string);
                    new Float:X,Float:Y,Float:Z;
                    GetPlayerPos(MedicCall, X, Y, Z);
                    SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                    GameTextForPlayer(playerid, "~w~Medyku~n~~r~Jedz do celu", 5000, 1);
                    MedicCallTime[playerid] = 1;
                    MedicCall = 999;
                    return 1;
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nikt nie potrzebuje medyka !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� lekarzem !");
            return 1;
        }
    }
    else if(strcmp(x_job,"mechanic",true) == 0 || strcmp(x_job,"mechanik",true) == 0)
    {
        if(PlayerInfo[playerid][pJob] == 7 || IsAMechazordWarsztatowy(playerid))
        {
            
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� mechanikiem !");
            return 1;
        }
        if(MechanicCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jeste� na misji, nie mo�esz u�ywa� tej komendy !");
            return 1;
        }
        if(MechanicCall < 999)
        {
            if(IsPlayerConnected(MechanicCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(MechanicCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, masz 60 sekund aby tam dojecha�.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Po 60 sekundach marker zniknie.");
                format(string, sizeof(string), "* Mechanik %s akceptowa� twoje zlecenie, czekaj i nie ruszaj si� z miejsca.",sendername);
                SendClientMessage(MechanicCall, COLOR_LIGHTBLUE, string);
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(MechanicCall, X, Y, Z);
                SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerownego markera", 5000, 1);
                MechanicCallTime[playerid] = 1;
                MechanicCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zadzwoni� po mechanika !");
            return 1;
        }
    }
    else if(strcmp(x_job,"job",true) == 0 || strcmp(x_job,"praca",true) == 0)//prace dorywcze
    {
        if(GettingJob[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Podpisa�e� umowe na 2,5 godziny, zaczynasz now� prac�.");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Gratulujemy nowej pracy, wpisz /pomoc aby zobaczy� nowe komendy.");
            PlayerInfo[playerid][pJob] = GettingJob[playerid];
            Log(serverLog, WARNING, "Gracz %s do��czy� do pracy %d.", GetPlayerLogName(playerid), PlayerInfo[playerid][pJob]);
            GettingJob[playerid] = 0;
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   W tym miejscu nie mo�na wzi�� pracy!");
            return 1;
        }
    }
    else if(strcmp(x_job,"refill",true) == 0 || strcmp(x_job,"tankowanie",true) == 0)
    {
        if(RefillOffer[playerid] < 999)
        {
            if(IsPlayerConnected(RefillOffer[playerid]) && IsPlayerInAnyVehicle(playerid))
            {
                if(kaska[playerid] > RefillPrice[playerid] && RefillPrice[playerid] > 0)
                {
                    GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    new fuel;
                    new vehicleid = GetPlayerVehicleID(playerid);
                    if(RefillOffer[playerid] != playerid)
                    {
                        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
                        PlayerPlaySound(RefillOffer[playerid], 1085, 0.0, 0.0, 0.0);
                        PlayerInfo[RefillOffer[playerid]][pMechSkill] ++;
                        SendClientMessage(RefillOffer[playerid], COLOR_GREY, "Skill +1");
                        if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 50)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 2, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 100)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 3, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 200)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 4, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 400)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 5, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                    }
                    new level = PlayerInfo[RefillOffer[playerid]][pMechSkill];
                    if(level >= 0 && level <= 50)
                    { fuel = 15; }
                    else if(level >= 51 && level <= 100)
                    { fuel = 40; }
                    else if(level >= 101 && level <= 200)
                    { fuel = 60; }
                    else if(level >= 201 && level <= 400)
                    { fuel = 80; }
                    else if(level >= 401)
                    { fuel = 100; }
                    format(string, sizeof(string), "* Tw�j pojazd zosta� dotankowany o %d% przez mechanika %s, koszt $%d.",fuel,giveplayer,RefillPrice[playerid]);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* Zatankowa�e� pojazd %s o %d% paliwa, doliczono ci $%d do wyp�aty.",sendername,fuel,RefillPrice[playerid]);
                    SendClientMessage(RefillOffer[playerid], COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string),"* Mechanik %s wyci�ga kanister i dotankowuje auto %s.",giveplayer,VehicleNames[GetVehicleModel(vehicleid)-400]);
                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    format(string, sizeof(string), "* Bak nape�niony o %d jednostek paliwa (( %s ))", fuel, giveplayer);
                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    ZabierzKaseDone(playerid, RefillPrice[playerid]);
                    DajKaseDone(RefillOffer[playerid], RefillPrice[playerid]);
                    if(Gas[vehicleid] < 110)
                    {
                        Gas[vehicleid] += fuel;
                    }
                    RefillOffer[playerid] = 999;
                    RefillPrice[playerid] = 0;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie mo�esz akceptowa� tankowania !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci tankowania !");
            return 1;
        }
    }
    else if(strcmp(x_job,"live",true) == 0 || strcmp(x_job,"wywiad",true) == 0)
    {
        if(LiveOffer[playerid] < 999)
        {
            if(IsPlayerConnected(LiveOffer[playerid]))
            {
                if (ProxDetectorS(5.0, playerid, LiveOffer[playerid]) || (Mobile[playerid] == LiveOffer[playerid] && Callin[playerid] == CALL_PLAYER))
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wywiad rozpocz�ty, wszystko co teraz powiesz b�dzie na antenie.");
                    SendClientMessage(LiveOffer[playerid], COLOR_LIGHTBLUE, "* Rozpocz��e� wywiad. Aby go zako�czy� ponownie wpisz /wywiad.");
                    TalkingLive[playerid] = LiveOffer[playerid];
                    TalkingLive[LiveOffer[playerid]] = playerid;
                    LiveOffer[playerid] = 999;
                    
                    if(Mobile[playerid] == LiveOffer[playerid] && Callin[playerid] == CALL_PLAYER)
                    {
                        Callin[Mobile[playerid]] = CALL_LIVE;
                        Callin[playerid] = CALL_LIVE;
                    }
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Jeste� za daleko od reportera !");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa� ci wywiadu !");
            return 1;
        }
    }
    else if(strcmp(x_job, "uwolnienie", true) == 0 || strcmp(x_job, "wolnosc", true) == 0)
    {
        new money = OfferPrice[playerid];
        //SetPVarInt(playerid, "idPrawnika", playerid);
        if(kaska[playerid] >= money)
        {
            if(OfferPlayer[playerid] == -1)
            {
                sendErrorMessage(playerid, "Nikt nie oferowa� Ci uwolnienia z wi�zienia!"); 
                return 1;
            }
            format(string, sizeof(string), "* Uwolni�e� %s z wi�zienia za kwot� %d$", GetNick(playerid), money);
            SendClientMessage(OfferPlayer[playerid], COLOR_LIGHTBLUE, string);
            
            format(string, sizeof(string), "* Zosta�e� uwolniony przez prawnika %s za kwot� %d$", GetNick(OfferPlayer[playerid]), money);
            SendClientMessage(playerid , COLOR_LIGHTBLUE, string);
            
            //Czynno�ci
            PlayerInfo[playerid][pJailTime] = 1;
            ZabierzKaseDone(playerid, money);
            DajKaseDone(OfferPlayer[playerid], money);
            
            //skill
            PlayerInfo[OfferPlayer[playerid]][pLawSkill] +=2;
            SendClientMessage(OfferPlayer[playerid], COLOR_GRAD2, "Skill +2");
            if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 50)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prawnika wynosz� teraz 2, Mo�esz taniej zbija� WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 100)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prawnika wynosz� teraz 3, Mo�esz taniej zbija� WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 200)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prawnika wynosz� teraz 4, Mo�esz taniej zbija� WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 400)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prawnika wynosz� teraz 5, Mo�esz taniej zbija� WL."); }
            
            //zerowanie zmiennych 2
            ApprovedLawyer[OfferPlayer[playerid]] = 0;
            WantLawyer[playerid] = 0;
            CallLawyer[playerid] = 0;
            JailPrice[playerid] = 0;
            OfferPrice[playerid] = 0;
            LawyerOffer[playerid] = 0;
            OfferPlayer[playerid] = -1;
        }
        else
        {
            sendErrorMessage(playerid, "Nie masz takiej kwoty!"); 
            return 1;
        }
        
    }
    else if(strcmp(x_job,"bodyguard",true) == 0 || strcmp(x_job,"ochrona",true) == 0)
    {
        if(GuardOffer[playerid] < 999)
        {
            if(kaska[playerid] > GuardPrice[playerid] && GuardPrice[playerid] > 0)
            {
                if(IsPlayerConnected(GuardOffer[playerid]))
                {
                    new giveplayerid;
                    giveplayerid = GuardOffer[playerid];
                    GetPlayerName(GuardOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa�e� ochron�, zap�aci�e� $%d ochroniarzowi %s.",GuardPrice[playerid],giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s akceptowa� twoj� oferte ochrony, $%d zostanie doliczone do twojej wyp�aty.",sendername,GuardPrice[playerid]);
                    SendClientMessage(GuardOffer[playerid], COLOR_LIGHTBLUE, string);
                    //PlayerInfo[GuardOffer[playerid]][pPayCheck] += GuardPrice[playerid];
                    DajKaseDone(giveplayerid, GuardPrice[playerid]);
                    ZabierzKaseDone(playerid, GuardPrice[playerid]);
                    SetPlayerArmour(playerid, 100);
                    sendTipMessage(playerid, "Dosta�e� kamizelk� kuloodporn� od ochroniarza.");
                    Log(payLog, WARNING, "%s kupi� kamizelk� od %s za $%d", GetPlayerLogName(playerid), GetPlayerLogName(GuardOffer[playerid]), GuardPrice[playerid]);
                    SendMessageToAdmin(sprintf("%s kupi� kamizelk� od %s za $%d", GetNickEx(playerid), GetNickEx(GuardOffer[playerid]), GuardPrice[playerid]), COLOR_RED);
                    GuardOffer[playerid] = 999;
                    GuardPrice[playerid] = 0;
                    return 1;
                }
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie mo�esz zaakceptowa� ochrony !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa� ci ochrony !");
            return 1;
        }
    }
    else if(strcmp(x_job,"drugs",true) == 0 || strcmp(x_job,"dragi",true) == 0)
    {
        if(DrugOffer[playerid] < 999)
        {
            if(kaska[playerid] > DrugPrice[playerid] && DrugPrice[playerid] > 0)
            {
                if(PlayerInfo[playerid][pDrugs] < 7)
                {
                    if(IsPlayerConnected(DrugOffer[playerid]))
                    {
                        GetPlayerName(DrugOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Kupi�e� %d gram za $%d od Dilera Drag�w %s. Aby je wzi�� wpisz /wezdragi.",DrugGram[playerid],DrugPrice[playerid],giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s kupi� od ciebie %d gram, $%d zostanie dodane do twojej wyp�aty.",sendername,DrugGram[playerid],DrugPrice[playerid]);
                        SetPVarInt(DrugOffer[playerid], "wydragowany", 60);
                        SendClientMessage(DrugOffer[playerid], COLOR_LIGHTBLUE, string);
                        //
                        format(string, sizeof(string), "%s kupi� dragi za $%d od %s", sendername, DrugPrice[playerid], giveplayer);
                        ABroadCast(COLOR_YELLOW,string,1);
                        Log(payLog, WARNING, "%s kupi� od %s paczk� %d narkotyk�w za %d$", GetPlayerLogName(playerid), GetPlayerLogName(DrugOffer[playerid]), DrugGram[playerid], DrugPrice[playerid]);
                        //
                        PlayerInfo[DrugOffer[playerid]][pPayCheck] += DrugPrice[playerid];
                        PlayerInfo[DrugOffer[playerid]][pDrugsSkill] ++;
                        ZabierzKaseDone(playerid, DrugPrice[playerid]);
                        PlayerInfo[playerid][pDrugs] += DrugGram[playerid];
                        PlayerInfo[DrugOffer[playerid]][pDrugs] -= DrugGram[playerid];
                        if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 50)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci dilera drag�w wynosz� teraz 2, mo�esz kupowac wi�cej drag�w w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 100)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci dilera drag�w wynosz� teraz 3, mo�esz kupowac wi�cej drag�w w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 200)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci dilera drag�w wynosz� teraz 4, mo�esz kupowac wi�cej drag�w w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 400)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci dilera drag�w wynosz� teraz 5, mo�esz kupowac wi�cej drag�w w melinie."); }
                        DrugOffer[playerid] = 999;
                        DrugPrice[playerid] = 0;
                        DrugGram[playerid] = 0;
                        return 1;
                    }
                    return 1;
                }
                else
                {
                    sendTipMessageEx(playerid, COLOR_GREY, "Masz ju� za du�o narkotyk�w, u�yj ich najpierw !");
                    return 1;
                }
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz zakupi� narkotyk�w !");
                return 1;
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie oferowa� ci sprzeda�y narkotyk�w !");
            return 1;
        }
    }
    else if(strcmp(x_job,"sex",true) == 0)
    {
        if(SexOffer[playerid] < 999)
        {
            if(kaska[playerid] > SexPrice[playerid] && SexPrice[playerid] > 0)
            {
                if (IsPlayerConnected(SexOffer[playerid]))
                {
                    new Car = GetPlayerVehicleID(playerid);
                    if(IsPlayerInAnyVehicle(playerid) && IsPlayerInVehicle(SexOffer[playerid], Car))
                    {
                        GetPlayerName(SexOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Uprawiasz ostry sex z dziwk� %s, za $%d.", giveplayer, SexPrice[playerid]);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        SetPVarInt(SexOffer[playerid], "wysekszony", 120);
                        format(string, sizeof(string), "* %s uprawia z tob� sex. $%d zostanie dodane do twojej wyp�aty.", sendername, SexPrice[playerid]);
                        SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, string);
                        PlayerInfo[SexOffer[playerid]][pPayCheck] += SexPrice[playerid];
                        PlayerInfo[SexOffer[playerid]][pSexSkill] ++;
                        //
                        Log(payLog, WARNING, "%s uprawia� sex z %s za $%d", GetPlayerLogName(playerid), GetPlayerLogName(SexOffer[playerid]), SexPrice[playerid]);
                        //
                        ZabierzKaseDone(playerid, SexPrice[playerid]);
                        if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 50)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prostytutki wynosz� teraz 2, Mo�esz oferowa� teraz lepszy sex (wi�cej �ycia) i trudniej sie zarazi�."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 100)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prostytutki wynosz� teraz 3, Mo�esz oferowa� teraz lepszy sex (wi�cej �ycia) i trudniej sie zarazi�."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 200)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prostytutki wynosz� teraz 4, Mo�esz oferowa� teraz lepszy sex (wi�cej �ycia) i trudniej sie zarazi�."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 400)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci prostytutki wynosz� teraz 5, Mo�esz oferowa� teraz lepszy sex (wi�cej �ycia) i trudniej sie zarazi�."); }
                        
                        if(HasItemType(playerid, ITEM_TYPE_CONDOM) == -1)
                        {
                            new Float:health, Float:Ahealth, Float:hp;
                            new level = PlayerInfo[SexOffer[playerid]][pSexSkill];
                            if(level >= 0 && level <= 50) hp = 20;
                            else if(level >= 51 && level <= 100) hp = 40;
                            else if(level >= 101 && level <= 200) hp = 60;
                            else if(level >= 201 && level <= 400) hp = 80;
                            else if(level >= 401)
                            {
                                hp = 100;
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Twoje umiej�tno�ci prostytutki s� tak wysokie �e dajesz wysokie HP i nie dajesz chor�b.");
                                SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, "* Umiej�tno�� dziwki s� tak wysokie �e dostajesz du�e HP i zero chor�b.");
                                return 1;
                            }
                            GetPlayerHealth(playerid, health);
                            GetPlayerArmour(playerid, Ahealth);
                            new actualhp = floatround(health, floatround_tozero);
                            new actualap = floatround(Ahealth, floatround_tozero);
                            if((actualhp + hp) < 100) 
                            {
                                SetPlayerHealth(playerid, actualhp + hp); 
                            }
                            else
                            {
                                SetPlayerArmour(playerid, actualap + hp);  
                            }
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Dodano ci %d HP/Pancerza z powodu sexu.", hp));
                            if(random(20) == 1)//5% szans na zara�enie
                            {
                                InfectOrDecreaseImmunity(playerid, HIV);
                            }

                            //TODO: przenoszenie chor�b drog� p�ciow�
                        }
                        else
                        {
                            new condom = HasItemType(playerid, ITEM_TYPE_CONDOM);
                            SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, "* Ten gracz u�ywa kondom.");
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* U�y�e� kondom.");
                            Item_Delete(condom);
                        }
                        SexOffer[playerid] = 999;
                        return 1;
                    }
                    else
                    {
                        sendTipMessageEx(playerid, COLOR_GREY, "Ty i dziwka nie jeste�cie w samochodzie !");
                        return 1;
                    }
                }//Connected or not
                return 1;
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie sta� ci� !");
                return 1;
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie oferowa� ci sexu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"naprawe",true) == 0 || strcmp(x_job,"naprawa",true) == 0)
    {
        if(RepairOffer[playerid] < 999)
        {
            if(kaska[playerid] > RepairPrice[playerid] && RepairPrice[playerid] > 0)
            {
                if(IsPlayerInAnyVehicle(playerid))
                {
                    if(IsPlayerConnected(RepairOffer[playerid]))
                    {
                        if(ProxDetectorS(10.5, playerid, RepairOffer[playerid]))
                        {
                            GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            RepairCar[playerid] = GetPlayerVehicleID(playerid);
                            SetVehicleHealth(RepairCar[playerid], 1000.0);
                            RepairVehicle(RepairCar[playerid]);

                            CarData[VehicleUID[RepairCar[playerid]][vUID]][c_Tires] = 0;
                            CarData[VehicleUID[RepairCar[playerid]][vUID]][c_HP] = 1000.0;

                            PlayerPlaySound(RepairCar[playerid], 1140, 0.0, 0.0, 0.0);
                            PlayerPlaySound(playerid, 1140, 0.0, 0.0, 0.0);
                            format(string, sizeof(string), "* Tw�j samoch�d zosta� naprawiony za $%d przez mechanika %s.",RepairPrice[playerid],giveplayer);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "* Naprawi�e� pojazd %s, $%d zostanie dodane do twojej wyp�aty.",sendername,RepairPrice[playerid]);
                            SendClientMessage(RepairOffer[playerid], COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia oraz naprawia %s.",giveplayer,VehicleNames[GetVehicleModel(RepairCar[playerid])-400]);
                            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            format(string, sizeof(string), "* Silnik pojazdu zn�w dzia�a jak nale�y (( %s ))", giveplayer);
                            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            PlayerInfo[RepairOffer[playerid]][pMechSkill] ++;
                            if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 50)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 2, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 100)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 3, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 200)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 4, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 400)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiej�tno�ci Mechanika wynosz� 5, Mo�esz teraz tankowa� graczom wi�cej paliwa za jednym razem."); }
                            ZabierzKaseDone(playerid, RepairPrice[playerid]);
                            DajKaseDone(RepairOffer[playerid], RepairPrice[playerid]);
                            Log(payLog, WARNING, "%s naprawi� pojazd %s graczowi %s", GetPlayerLogName(RepairOffer[playerid]), GetVehicleLogName(RepairCar[playerid]), GetPlayerLogName(playerid));
                            RepairOffer[playerid] = 999;
                            RepairPrice[playerid] = 0;
                        }
                        else
                        {
                            sendErrorMessage(playerid, "Mechanik musi by� obok Ciebie!");
                            return 1;
                        }
                        return 1;
                    }
                    return 1;
                }
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie sta� ci� na naprawe !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci naprawy !");
            return 1;
        }
    }
    else if(strcmp(x_job,"wynajem",true) == 0 || strcmp(x_job,"wynajmij",true) == 0)
    {
        if(WynajemOffer[playerid] < 999)
        {
            new dom = PlayerInfo[WynajemOffer[playerid]][pDom];
            if(kaska[playerid] > Dom[dom][hCenaWynajmu] && Dom[dom][hCenaWynajmu] > 0)
            {
                GetPlayerName(WynajemOffer[playerid], giveplayer, sizeof(giveplayer));
                sendername = GetNickEx(playerid);
                if(Dom[dom][hPW] == 0)
                {
                    Dom[dom][hL1] = sendername;
                }
                else if(Dom[dom][hPW] == 1)
                {
                    Dom[dom][hL2] = sendername;
                }
                else if(Dom[dom][hPW] == 2)
                {
                    Dom[dom][hL3] = sendername;
                }
                else if(Dom[dom][hPW] == 3)
                {
                    Dom[dom][hL4] = sendername;
                }
                else if(Dom[dom][hPW] == 4)
                {
                    Dom[dom][hL5] = sendername;
                }
                else if(Dom[dom][hPW] == 5)
                {
                    Dom[dom][hL6] = sendername;
                }
                else if(Dom[dom][hPW] == 6)
                {
                    Dom[dom][hL7] = sendername;
                }
                else if(Dom[dom][hPW] == 7)
                {
                    Dom[dom][hL8] = sendername;
                }
                else if(Dom[dom][hPW] == 8)
                {
                    Dom[dom][hL9] = sendername;
                }
                else if(Dom[dom][hPW] == 9)
                {
                    Dom[dom][hL10] = sendername;
                }
                Dom[dom][hPDW] --;
                Dom[dom][hPW] ++;
                PlayerInfo[playerid][pWynajem] = dom;
                format(string, sizeof(string), "Wynaj��e� pok�j w tym domu. Aby uzyska� wi�cej opcji i mo�liwo�ci wpisz /dom");
                SendClientMessage(playerid, COLOR_NEWS, string);
                format(string, sizeof(string), "%s wynaj�� pok�j w twoim domu!", sendername);
                SendClientMessage(WynajemOffer[playerid], COLOR_NEWS, string);
                WynajemOffer[playerid] = 999;
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie sta� ci� na wynajem tego pokoju !");
                WynajemOffer[playerid] = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� ci wynajmu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"dom",true) == 0 || strcmp(x_job,"house",true) == 0)
    {
        if(DomOffer[playerid] < 999)
        {
            if(kaska[playerid] > DomCena[playerid] && DomCena[playerid] > 0)
            {
                if (ProxDetectorS(10.0, playerid, DomOffer[playerid]))
                {
                    if(PlayerInfo[DomOffer[playerid]][pDom] != 0 && PlayerInfo[DomOffer[playerid]][pDom] == GetPVarInt(DomOffer[playerid], "DomOfferID"))
                    {
                        GetPlayerName(DomOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "Sprzeda�e� dom graczowi %s za %d$.", sendername, DomCena[playerid]);
                        SendClientMessage(DomOffer[playerid], COLOR_NEWS, string);
                        format(string, sizeof(string), "Kupi�e� dom od %s za %d$. Aby uzyska� wi�cej opcji i mo�liwo�ci wpisz /dom", giveplayer, DomCena[playerid]);
                        SendClientMessage(playerid, COLOR_NEWS, string);
                        SendClientMessage(playerid, COLOR_PANICRED, "UWAGA! Pami�taj aby zmieni� kod do sejfu !!!!!!");
                        Dom[PlayerInfo[DomOffer[playerid]][pDom]][hWlasciciel] = GetNickEx(playerid);
                        PlayerInfo[playerid][pDom] = PlayerInfo[DomOffer[playerid]][pDom];
                        PlayerInfo[DomOffer[playerid]][pDom] = 0;
                        ZabierzKaseDone(playerid, DomCena[playerid]);
                        DajKaseDone(DomOffer[playerid], DomCena[playerid]);
                        ZapiszDom(PlayerInfo[playerid][pDom]);
                        Log(payLog, WARNING, "%s kupi� od %s dom %s za %d$. ", \
                            GetPlayerLogName(playerid), \
                            GetPlayerLogName(DomOffer[playerid]), \
                            GetHouseLogName(PlayerInfo[playerid][pDom]), \
                            DomCena[playerid] \
                        );
                    }
                    else
                    {
                        format(string, sizeof(string), "Napotkano b��d. Dom zosta� kupiony przez kogo� innego.");
                        SendClientMessage(playerid, COLOR_NEWS, string);
                    }
                    DeletePVar(DomOffer[playerid], "DomOfferID");
                    DomCena[playerid] = 0;
                    DomOffer[playerid] = 999;
                    return 1;
                }
                else
                {
                    DomOffer[playerid] = 0;
                    SendClientMessage(playerid, COLOR_GREY, "   Jeste� za daleko !");
                    return 1;
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie sta� ci� na kupno tego domu !");
                return 1;
            }
        }
    }
    else if(strcmp(x_job,"kuracje",true) == 0 || strcmp(x_job,"kuracja",true) == 0)
    {
        kuracja_akceptuj(playerid);
    }
    else if(strcmp(x_job,"maseczke",true) == 0 || strcmp(x_job,"maseczka",true) == 0)
    {
        maseczka_akceptuj(playerid);
    }
    else if(strcmp(x_job,"neony",true) == 0 || strcmp(x_job,"neon",true) == 0)
    {
        sprzedajneon_akceptuj(playerid);
    }
    else if(strcmp(x_job,"produkt",true) == 0)
    {
        produkt_akceptuj(playerid);
    }
    else if(strcmp(x_job,"zaproszenie", true) == 0 || strcmp(x_job,"zapro", true) == 0)
    {
        if(GetPVarInt(playerid, "MotelPendingInviteToRoom") != 0)
        {
            new fromID = GetPVarInt(playerid, "MotelPendingInviteFrom");
            new toRoom = GetPVarInt(playerid, "MotelPendingInviteToRoom");
            new fromName[32];
            new str[128];
            GetPVarString(playerid, "MotelPendingInviteFromName", fromName, sizeof(fromName));

            new nick[32], nick2[32];
			format(nick, sizeof(nick), "%s", GetNick(playerid));
			strreplace(nick, "_", " ");
			format(nick2, sizeof(nick2), "%s", fromName);
			strreplace(nick2, "_", " ");

            SetPVarInt(playerid, "MotelPendingInviteFrom", 0);
            SetPVarInt(playerid, "MotelPendingInviteToRoom", 0);
            SetPVarString(playerid, "MotelPendingInviteFromName", " ");

            if(MotelRooms[toRoom][mtrAccessCount] >= MOTEL_MAX_ACCESS) return sendErrorMessage(playerid, "Akceptacja zaproszenia nie powiod�a si�, poniewa� pok�j jest ju� pe�ny!");
            if(strcmp(fromName, GetNick(fromID), true) != 0) return sendErrorMessage(playerid, "Akceptacja zaproszenia nie powiod�a si�, poniewa� gracz wyszed� z gry!");

            Motel_AddUIDToAccess(toRoom, PlayerInfo[playerid][pUID], GetNick(playerid));
            format(str, sizeof(str), "Zaakceptowa�e� zaproszenie %s i masz teraz dost�p do pokoju.",  nick2);
            sendTipMessage(playerid, str);
            format(str, sizeof(str), "%s zaakceptowa� twoje zaproszenie i ma teraz dost�p do pokoju.", nick);
            sendTipMessage(fromID, str);
        } else return SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� Ci zaproszenia do pokoju !");
    }
    else if(strcmp(x_job,"zastrzyk",true) == 0)
    {
        if(GetPVarInt(playerid, "ZastrzykHave") == 1)
        {
            new giveplayerid;
            giveplayerid = GetPVarInt(playerid, "ZastrzykID");
            if(kaska[playerid] >= 1)
            {
                if(!IsPlayerConnected(giveplayerid))
                {
                    SetPVarInt(playerid, "ZastrzykID", INVALID_PLAYER_ID);
                    SetPVarInt(playerid, "ZastrzykHave", 0);
                    sendErrorMessage(playerid, "Gracz kt�ry oferowa� Ci zastrzyk wyszed� z gry!");
                    return 1;
                }
                if ( !(IsAMedyk(giveplayerid)))
                {
                    SetPVarInt(playerid, "ZastrzykID", INVALID_PLAYER_ID);
                    SetPVarInt(playerid, "ZastrzykHave", 0);
                    sendErrorMessage(playerid, "Gracz kt�ry oferowa� Ci zastrzyk wyszed� z gry!");
                    return 1;
                }
                if(!IsPlayerNear(playerid, giveplayerid))
                {
                    sendErrorMessage(playerid, sprintf("Jeste� zbyt daleko od gracza %s", GetNick(giveplayerid)));
                    return 1;
                }
                ProxDetector(20.0, playerid, sprintf("* Lekarz %s wyci�ga strzykawk� i wstrzykuje leki %s.", GetNick(giveplayerid), GetNick(playerid)), 
                COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
                );
                if(IsPlayerHealthy(playerid)) 
                {
                    SendClientMessage(playerid, COLOR_WHITE, "Lekarz da� ci zastrzyk i pooprawi� Twoj� odporno��.");
                    ProxDetector(20.0, playerid, sprintf("* %s czuje si� lepiej oraz jego organizm sta� si� bardziej odporny na choroby.", GetNick(playerid)), 
                        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
                    );
                }
                else
                {
                    SendClientMessage(playerid, COLOR_WHITE, "Lekarz da� ci zastrzyk i za�agodzi� objawy choroby.");
                    ProxDetector(20.0, playerid, sprintf("* %s czuje si� lepiej oraz jego organizm lepiej radzi sobie z objawami choroby.", GetNick(playerid)), 
                        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
                    );
                }
                SetPlayerImmunity(playerid, MAX_PLAYER_IMMUNITY);
                SetPlayerHealth(playerid, 100);
                TogglePlayerControllable(playerid, 1);
                SendClientMessage(playerid, COLOR_GREY, "Koszt zastrzyku: "INCOLOR_RED"-1$");
                ZabierzKaseDone(playerid, 1);
                DajKaseDone(giveplayerid, 1);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Nie sta� Ci� na zastrzyk. ($1)");
            }
            SetPVarInt(playerid, "ZastrzykID", INVALID_PLAYER_ID);
            SetPVarInt(playerid, "ZastrzykHave", 0);
        } else return SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� Ci zastrzyku !");
    }
    else if(strcmp(x_job, "tuning", true) == 0)
    {
        if(GetPVarInt(playerid, "Tune_PendingInvite") != 0)
        {
            if(GetPVarInt(playerid, "Tune_PendingInvite") == 1)
                return AcceptTuneOffer(GetPVarInt(playerid, "Tune_mechanik"), playerid);
            else if(GetPVarInt(playerid, "Tune_PendingInvite") == 2)
                return FinishTune(GetPVarInt(playerid, "Tune_mechanik"));
            else
                return sendErrorMessage(playerid, "Wyst�pi� krytyczny b��d!");
        } else return SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa� Ci tuningu !");
    }
    else if(strcmp(x_job, "smierc", true) == 0)
    {
        if(PlayerInfo[playerid][pInjury] <= 0) return sendErrorMessage(playerid, "Nie jeste� ranny!");
        if(!GetPVarInt(playerid, "acceptdeath-allow")) return va_SendClientMessage(playerid, COLOR_GREY, "Musisz odczeka� jeszcze %d sekund!", (PlayerInfo[playerid][pInjury]));

        ZdejmijBW(playerid);
        //rozkuwanie
        if(PlayerCuffed[playerid] == 1){
            TogglePlayerControllable(playerid, 1);
            PlayerCuffed[playerid] = 0;
            Kajdanki_JestemSkuty[playerid] = 0;
            Kajdanki_SkutyGracz[playerid] = 0;
            Kajdanki_Uzyte[playerid] = 0;
            Kajdanki_PDkuje[playerid] = 0;
            PlayerInfo[playerid][pMuted] = 0;
            ClearAnimations(playerid);
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
            RemovePlayerAttachedObject(playerid, 5);
        }
        
        SetPlayerSpawn(playerid);
        //Zabierz itemy, bronie, wl
        RemovePlayerWeaponsTemporarity(playerid);
        UsunBron(playerid);
        PlayerInfo[playerid][pWL] = 0;
        PoziomPoszukiwania[playerid] = 0;
        SetPlayerWantedLevel(playerid, 0);
        sendTipMessage(playerid, "Twoje bronie oraz poziom poszukiwania zosta�y usuni�te!");
        PlayerInfo[playerid][pWeaponBlock] = gettime()+300; //5 minut
		SendClientMessage(playerid, COLOR_LIGHTRED, "> Zosta�a Ci nadana blokada broni na okres 5 minut.");
    }
    else if(strcmp(x_job, "tatuaz", true) == 0) //System tatua�y 4.1
    {
        new offer = GetPVarInt(playerid, "Tattoo-Offer"), price = GetPVarInt(playerid, "Tattoo-Price");
        if(offer == INVALID_PLAYER_ID || !IsPlayerConnected(offer)) return sendErrorMessage(playerid, "Nie masz aktywnej oferty!");
        if(!GetPVarInt(playerid, "Tattoo-Active")) return sendErrorMessage(playerid, "Nie masz aktywnej oferty!");
        if(price < 50 || price > 400) return sendErrorMessage(playerid, "Cena jest nieprawid�owa!");
        if(kaska[playerid] < price) return sendErrorMessage(playerid, "Nie masz tylu pieni�dzy przy sobie!");
        if(!GroupPlayerDutyPerm(offer, PERM_TATTOO)) return sendErrorMessage(playerid, "Gracz sk�adaj�cy ofert� zszed� z duty!");
        if(!IsPlayerNear(playerid, offer)) return sendErrorMessage(playerid, "Nie znajdujesz si� w pobli�u gracza, kt�ry sk�ada� Ci ofert�!");

        new strring[sizeof Tattoo_Models * 68];
        for(new i = 0; i < sizeof(Tattoo_Models); i++)
        {
            format(strring, sizeof(strring), "%s\n%d\t%s", strring, Tattoo_Models[i][dModel], Tattoo_Models[i][d_Name]);
        }
        ShowPlayerDialogEx(playerid, D_TATTOO, DIALOG_STYLE_PREVIEW_MODEL, "Lista tatuazy", strring, "Wybierz", "Zamknij");
        va_SendClientMessage(offer, COLOR_LIGHTBLUE, "* Gracz %s akceptowa� twoj� ofert�, poczekaj a� wybierze wz�r.", GetNick(playerid));
        SetPVarInt(playerid, "Tattoo-Active", 0);
    }
    return 1;
}

//end