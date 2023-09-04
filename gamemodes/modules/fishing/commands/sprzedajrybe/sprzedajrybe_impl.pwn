//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                sprzedajrybe                                               //
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
// Autor: mrucznik
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_sprzedajrybe_Impl(playerid, fishid)
{
    if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
    {
        SendClientMessage(playerid, COLOR_WHITE, "Ryb� mo�esz sprzeda� tylko w 24/7!");
        return 1;
    } 
    if(FishGood[playerid] == 1)
    {
        SendPunishMessage(sprintf("AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, pow�d: teleport (ryby)", GetNickEx(playerid)), playerid);
        Log(punishmentLog, WARNING, "%s dosta� kicka od antycheata, pow�d: teleport (ryby)");
        KickEx(playerid);
        return 1;
    }

    switch(fishid)
    {
        case 1..5:
        {
            SprzedajeRybe(playerid, fishid);
        }
        default:
        {
            return sendTipMessageEx(playerid, COLOR_GREY, "Numer ryby od 1 do 5 !"); 
        }
    }
    return 1;
}

SprzedajeRybe(playerid, fishid = 0)
{
	if(!fishid) return 0;
	new FishWeight, FishName[20];
	if(fishid == 1)
	{
		FishWeight = Fishes[playerid][pWeight1];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish1]);
	}
	else if(fishid == 2)
	{
		FishWeight = Fishes[playerid][pWeight2];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish2]);
	}
	else if(fishid == 3)
	{
		FishWeight = Fishes[playerid][pWeight3];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish3]);
	}
	else if(fishid == 4)
	{
		FishWeight = Fishes[playerid][pWeight4];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish4]);
	}
	else if(fishid == 5)
	{
		FishWeight = Fishes[playerid][pWeight5];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish5]);
	}

	if(FishWeight < 1) {
		return SendClientMessage(playerid, COLOR_GREY, sprintf("** Nie z�owi�e� �adnej ryby pod numerem [%d] !", fishid)); 
	}
	const Float:moneyPerKg = MULT_RYBA_KG;
	SendClientMessage(playerid, COLOR_GREY, sprintf("** Sprzeda�e� ryb� numer [%d]!", fishid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
	DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
	ClearFishID(playerid, fishid);
	Fishes[playerid][pLastFish] = 0;
	Fishes[playerid][pFishID] = 0;
	FishGood[playerid] = 0;
	return 1;
}

SprzedajRyby(playerid)
{
	const Float:moneyPerKg = MULT_RYBA_KG;
	new FishWeight, FishName[20];
	if(Fishes[playerid][pWeight1] > 0)
	{
		FishWeight = Fishes[playerid][pWeight1];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish1]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
		DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
		ClearFishID(playerid, 1);
	}
	if(Fishes[playerid][pWeight2] > 0)
	{
		FishWeight = Fishes[playerid][pWeight2];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish2]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
		DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
		ClearFishID(playerid, 2);
	}
	if(Fishes[playerid][pWeight3] > 0)
	{
		FishWeight = Fishes[playerid][pWeight3];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish3]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
		DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
		ClearFishID(playerid, 3);
	}
	if(Fishes[playerid][pWeight4] > 0)
	{
		FishWeight = Fishes[playerid][pWeight4];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish4]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
		DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
		ClearFishID(playerid, 4);
	}
	if(Fishes[playerid][pWeight5] > 0)
	{
		FishWeight = Fishes[playerid][pWeight5];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish5]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda�e� ryb�: %s, wa��c� %d g. Otrzymujesz %d$.", FishName, FishWeight, floatround(FishWeight * moneyPerKg,  floatround_ceil)));
		DajKaseDone(playerid, floatround(FishWeight * moneyPerKg,  floatround_ceil));
		ClearFishID(playerid, 5);
	}
	Fishes[playerid][pLastFish] = 0;
	Fishes[playerid][pFishID] = 0;
	FishGood[playerid] = 0;
	return 1;
}

//end