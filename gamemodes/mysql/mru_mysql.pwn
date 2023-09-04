//mru_mysql.pwn

new bool:MYSQL_ON = true;
new bool:MYSQL_SAVING = true;

new MYSQL_HOST[32];
new MYSQL_USER[32];
new MYSQL_DATABASE[32];
new MYSQL_PASS[256];

public OnQueryError(errorid, error[], resultid, extraid, callback[], query[], connectionHandle)
{
	Log(mysqlLog, ERROR, "%s | resultid: %d | extraid: %d | callback: %s | query: %s", error, resultid, extraid, callback, query);
	return 1;
}

//Moje funkcje:

//--------------------------------------------------------------<[ Konta ]>--------------------------------------------------------------
LoadConnectionValues()
{
	new file[64];
	format(file, sizeof(file), "MySQL/connect.ini");
	if(dini_Exists(file)) 
	{
		strcat(MYSQL_HOST, dini_Get(file, "Host"));
		strcat(MYSQL_USER, dini_Get(file, "User"));
		strcat(MYSQL_DATABASE, dini_Get(file, "DB"));
		strcat(MYSQL_PASS, dini_Get(file, "Pass"));
		return 1;
	}
	return 0;
}

MruMySQL_Connect()
{
	if(!MYSQL_ON) return 0;
	if(!LoadConnectionValues())
	{
		print("MYSQL: Nieudane pobranie danych z MySQL/connect.ini");
		SendRconCommand("gamemodetext Brak polaczenia MySQL");
		SendRconCommand("exit");
	}

    mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);
	print(" ");
	if(mysql_ping() == 1)
	{
		print("MYSQL: Polaczono sie z baza MySQL");
	}
	else
	{
		print("MYSQL: Nieudane polaczenie z baza MySQL");
		SendRconCommand("gamemodetext Brak polaczenia MySQL");
		SendRconCommand("exit");
		return 0;
	}
	#if DEBUG_MODE == 1
		mysql_debug(1);
	#else
		mysql_debug(0);
	#endif
	
	mysql_query("SET NAMES 'cp1250'");
	return 1;
}
Save_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `mru_liderzy` SET \
	`NICK`='%s', \
	`UID`='%d', \
	`FracID`='%d', \
	`LiderValue`='%d' \
	WHERE `NICK`='%s'",
	GetNickEx(playerid),
	PlayerInfo[playerid][pUID],
	PlayerInfo[playerid][pLider],
	PlayerInfo[playerid][pLiderValue],
	GetNickEx(playerid)); 
	mysql_query(query);
	return 1;
}
Load_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT `FracID`, `LiderValue` FROM `mru_liderzy` WHERE `NICK`='%s'", GetNickEx(playerid));
	mysql_query(query);
	mysql_store_result();
    if (mysql_num_rows())
	{
        mysql_fetch_row_format(query, "|");
		sscanf(query, "p<|>dd", 
		PlayerInfo[playerid][pLider],
		PlayerInfo[playerid][pLiderValue]);
	}
	mysql_free_result();
	return 1;
}
MruMySQL_CreateAccount(playerid, password[])
{
	if(!MYSQL_ON) return 0;
	
	new query[256+WHIRLPOOL_LEN+SALT_LENGTH];
    new hash[WHIRLPOOL_LEN], salt[SALT_LENGTH];
	randomString(salt, sizeof(salt));
	WP_Hash(hash, sizeof(hash), sprintf("%s%s%s", ServerSecret, password, salt));
	format(query, sizeof(query), "INSERT INTO `mru_konta` (`Nick`, `Key`, `Salt`) VALUES ('%s', '%s', '%s')", GetNickEx(playerid), hash, salt);
	mysql_query(query);
	return 1;
}

MruMySQL_SaveAccount(playerid, bool:forcegmx = false, bool:forcequit = false)
{
	if(!MYSQL_ON) return 0;
    if(GLOBAL_EXIT) return 0;
    if(gPlayerLogged[playerid] != 1) return 0;

    if(forcequit)
    {
        //Punkty karne
        if(PlayerInfo[playerid][pPK] > 0) PoziomPoszukiwania[playerid] += 10000+(PlayerInfo[playerid][pPK]*100);
        
    }

	new query[2048], bool:fault=true;

	if(forcegmx == false) GetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);

	PlayerInfo[playerid][pCash] = kaska[playerid];

    if(PlayerInfo[playerid][pLevel] == 0)
    {
        Log(mysqlLog, ERROR, "MySQL:: %s - b³¹d zapisu konta (zerowy level)!!!", GetPlayerLogName(playerid));
        return 0;
    }

	//wy³¹cz na chwilkê maskowanie nicku (pNick)
	new maska_nick[24];
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		format(PlayerInfo[playerid][pNick], 24, "%s", maska_nick);
	}
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`Nick`='%s',\
	`Level`='%d',\
	`Admin`='%d',\
	`DonateRank`='%d',\
	`UpgradePoints`='%d',\
	`ConnectedTime`='%d',\
	`Registered`='%d',\
	`Sex`='%d',\
	`Age`='%d',\
	`Origin`='%d',\
	`CK`='%d',\
	`Muted`='%d',\
	`Respect`='%d',\
	`Money`='%d',\
	`Bank`='%d',\
	`Crimes`='%d',\
	`Kills`='%d',\
	`Deaths`='%d',\
	`Arrested`='%d',\
	`WantedDeaths`='%d',\
	`Phonebook`='%d',\
	`LottoNr`='%d',\
	`Fishes`='%d',\
	`fishCooldown`='%d',",
	PlayerInfo[playerid][pNick],
	PlayerInfo[playerid][pLevel],
	PlayerInfo[playerid][pAdmin],
	PlayerInfo[playerid][pDonateRank],
	PlayerInfo[playerid][gPupgrade],
	PlayerInfo[playerid][pConnectTime],
	PlayerInfo[playerid][pReg],
	PlayerInfo[playerid][pSex],
	PlayerInfo[playerid][pAge],
	PlayerInfo[playerid][pOrigin],
	PlayerInfo[playerid][pCK],
	PlayerInfo[playerid][pMuted],
	PlayerInfo[playerid][pExp],
	PlayerInfo[playerid][pCash],
	PlayerInfo[playerid][pAccount],
	PlayerInfo[playerid][pCrimes],
	PlayerInfo[playerid][pKills],
	PlayerInfo[playerid][pDeaths],
	PlayerInfo[playerid][pArrested],
	PlayerInfo[playerid][pWantedDeaths],
	PlayerInfo[playerid][pPhoneBook],
	PlayerInfo[playerid][pLottoNr],
	PlayerInfo[playerid][pFishes],
	FishCount[playerid]);

    format(query, sizeof(query), "%s\
	`BiggestFish`='%d',\
	`Job`='%d',\
	`Paycheck`='%d',\
	`HeadValue`='%d',\
	`BlokadaPisania`='%d',\
	`Jailed`='%d',\
	`AJreason`='%s',\
	`JailTime`='%d',\
	`Materials`='%d',\
	`Drugs`='%d',\
	`Member`='%d',\
	`FMember`='%d',\
	`Rank`='%d',\
	`Char`='%d',\
	`Skin`='%d',\
	`ContractTime`='%d',\
    `Auto1`='%d',\
	`Auto2`='%d',\
	`Auto3`='%d',\
	`Auto4`='%d',\
	`Lodz`='%d',\
	`Samolot`='%d',\
	`Garaz`='%d',\
	`KluczykiDoAuta`='%d',\
	`Spawn`='%d',\
	`BW`='%d',\
	`Injury`='%d',\
	`HealthPacks`='%d',\
	`Czystka`='%d',\
    `CarSlots`='%d'\
	WHERE `UID`='%d'", query,
	PlayerInfo[playerid][pBiggestFish],
	PlayerInfo[playerid][pJob],
	PlayerInfo[playerid][pPayCheck],
	PlayerInfo[playerid][pHeadValue],
	PlayerInfo[playerid][pBP],
	PlayerInfo[playerid][pJailed],
	PlayerInfo[playerid][pAJreason],
	PlayerInfo[playerid][pJailTime],
	PlayerInfo[playerid][pMats],
	PlayerInfo[playerid][pDrugs],
	PlayerInfo[playerid][pMember],
	PlayerInfo[playerid][pOrg],
	PlayerInfo[playerid][pRank],
	PlayerInfo[playerid][pChar],
	PlayerInfo[playerid][pSkin],
	PlayerInfo[playerid][pContractTime],
    PlayerInfo[playerid][pAuto1],
	PlayerInfo[playerid][pAuto2],
	PlayerInfo[playerid][pAuto3],
	PlayerInfo[playerid][pAuto4],
	PlayerInfo[playerid][pLodz],
	PlayerInfo[playerid][pSamolot],
	PlayerInfo[playerid][pGaraz],
	PlayerInfo[playerid][pKluczeAuta],
	PlayerInfo[playerid][pSpawn],
	PlayerInfo[playerid][pBW],
	PlayerInfo[playerid][pInjury],
	PlayerInfo[playerid][pHealthPacks],
	PlayerInfo[playerid][pCzystka],
    PlayerInfo[playerid][pCarSlots],
	PlayerInfo[playerid][pUID]);
    if(!mysql_query(query)) fault=false;
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
    `DetSkill`='%d', \
	`SexSkill`='%d', \
	`BoxSkill`='%d', \
	`LawSkill`='%d', \
	`MechSkill`='%d', \
	`JackSkill`='%d', \
	`CarSkill`='%d', \
	`NewsSkill`='%d', \
	`DrugsSkill`='%d', \
	`CookSkill`='%d', \
	`FishSkill`='%d', \
	`GunSkill`='%d', \
    `TruckSkill`='%d', \
	`PizzaboySkill`='%d', \
	`pSHealth`='%f', \
	`pHealth`='%f', \
	`VW`='%d', \
	`Int`='%d', \
	`LastHP`='%f', \
	`LastArmour`='%f'", PlayerInfo[playerid][pDetSkill],
	PlayerInfo[playerid][pSexSkill],
	PlayerInfo[playerid][pBoxSkill],
	PlayerInfo[playerid][pLawSkill],
	PlayerInfo[playerid][pMechSkill],
	PlayerInfo[playerid][pJackSkill],
	PlayerInfo[playerid][pCarSkill],
	PlayerInfo[playerid][pNewsSkill],
	PlayerInfo[playerid][pDrugsSkill],
	PlayerInfo[playerid][pCookSkill],
	PlayerInfo[playerid][pFishSkill],
	PlayerInfo[playerid][pGunSkill],
    PlayerInfo[playerid][pTruckSkill],
	PlayerInfo[playerid][pPizzaboySkill],
	PlayerInfo[playerid][pSHealth],
	PlayerInfo[playerid][pHealth],
	PlayerInfo[playerid][pVW],
	PlayerInfo[playerid][pInt],
	PlayerInfo[playerid][pLastHP],
	PlayerInfo[playerid][pLastArmour]);

    format(query, sizeof(query), "%s, \
    `Local`='%d', \
	`Team`='%d', \
	`JobSkin`='%d', \
	`Dom`='%d', \
	`Bizz`='%d', \
	`BizzMember`='%d', \
	`Wynajem`='%d', \
	`Pos_x`='%f', \
	`Pos_y`='%f', \
	`Pos_z`='%f', \
	`CarLic`='%d', \
	`FlyLic`='%d', \
	`BoatLic`='%d', \
	`FishLic`='%d', \
	`GunLic`='%d', \
	`Mikolaj`='%d', \
	`pPlayerEXP`='%d', \
	`pOsiagniecia1`='%d', \
	`pOsiagniecia2`='%d', \
	`pOsiagniecia3`='%d', \
	`pOsiagniecia4`='%d', \
	`pOsiagniecia5`='%d', \
    `Hat`='%d' WHERE `UID`='%d'", query,
    PlayerInfo[playerid][pLocal],
	PlayerInfo[playerid][pTeam],
	PlayerInfo[playerid][pJobSkin],
	PlayerInfo[playerid][pDom],
	PlayerInfo[playerid][pBusinessOwner],
	PlayerInfo[playerid][pBusinessMember],
	PlayerInfo[playerid][pWynajem],
	PlayerInfo[playerid][pPos_x],
	PlayerInfo[playerid][pPos_y],
	PlayerInfo[playerid][pPos_z],
	PlayerInfo[playerid][pCarLic],
	PlayerInfo[playerid][pFlyLic],
	PlayerInfo[playerid][pBoatLic],
	PlayerInfo[playerid][pFishLic],
	PlayerInfo[playerid][pGunLic],
	PlayerInfo[playerid][pMikolaj],
	PlayerInfo[playerid][pPlayerEXP],
	PlayerInfo[playerid][pOsiagniecia1],
	PlayerInfo[playerid][pOsiagniecia2],
	PlayerInfo[playerid][pOsiagniecia3],
	PlayerInfo[playerid][pOsiagniecia4],
	PlayerInfo[playerid][pOsiagniecia5],
    PlayerInfo[playerid][pHat], PlayerInfo[playerid][pUID]);

    if(!mysql_query(query)) fault=false;
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`Gun0`='%d', \
	`Gun1`='%d', \
	`Gun2`='%d', \
	`Gun3`='%d', \
	`Gun4`='%d', \
	`Gun5`='%d', \
	`Gun6`='%d', \
	`Gun7`='%d', \
	`Gun8`='%d', \
	`Gun9`='%d', \
	`Gun10`='%d', \
	`Gun11`='%d', \
	`Gun12`='%d', \
	`Ammo0`='%d', \
	`Ammo1`='%d', \
	`Ammo2`='%d', \
	`Ammo3`='%d', \
	`Ammo4`='%d', \
	`Ammo5`='%d', \
	`Ammo6`='%d', \
	`Ammo7`='%d', \
	`Ammo8`='%d', \
	`Ammo9`='%d', \
	`Ammo10`='%d', \
	`Ammo11`='%d', \
	`Ammo12`='%d', ",
	PlayerInfo[playerid][pGun0],
	PlayerInfo[playerid][pGun1],
	PlayerInfo[playerid][pGun2],
	PlayerInfo[playerid][pGun3],
	PlayerInfo[playerid][pGun4],
	PlayerInfo[playerid][pGun5],
	PlayerInfo[playerid][pGun6],
	PlayerInfo[playerid][pGun7],
	PlayerInfo[playerid][pGun8],
	PlayerInfo[playerid][pGun9],
	PlayerInfo[playerid][pGun10],
	PlayerInfo[playerid][pGun11],
	PlayerInfo[playerid][pGun12],
	PlayerInfo[playerid][pAmmo0],
	PlayerInfo[playerid][pAmmo1],
	PlayerInfo[playerid][pAmmo2],
	PlayerInfo[playerid][pAmmo3],
	PlayerInfo[playerid][pAmmo4],
	PlayerInfo[playerid][pAmmo5],
	PlayerInfo[playerid][pAmmo6],
	PlayerInfo[playerid][pAmmo7],
	PlayerInfo[playerid][pAmmo8],
	PlayerInfo[playerid][pAmmo9],
	PlayerInfo[playerid][pAmmo10],
	PlayerInfo[playerid][pAmmo11],
	PlayerInfo[playerid][pAmmo12]);
	
	format(query, sizeof(query), "%s \
	`CarTime`='%d', \
	`PayDay`='%d', \
	`PayDayHad`='%d', \
	`CDPlayer`='%d', \
	`Wins`='%d', \
	`Loses`='%d', \
	`AlcoholPerk`='%d', \
	`DrugPerk`='%d', \
	`MiserPerk`='%d', \
	`PainPerk`='%d', \
	`TraderPerk`='%d', \
	`Tutorial`='%d', \
	`Mission`='%d', \
    `Block`='%d', \
	`Fuel`='%d', \
	`Married`='%d', \
	`MarriedTo`='%s', ", query,
	PlayerInfo[playerid][pCarTime],
	PlayerInfo[playerid][pPayDay],
	PlayerInfo[playerid][pPayDayHad],
	PlayerInfo[playerid][pCDPlayer],
	PlayerInfo[playerid][pWins],
	PlayerInfo[playerid][pLoses],
	PlayerInfo[playerid][pAlcoholPerk],
	PlayerInfo[playerid][pDrugPerk],
	PlayerInfo[playerid][pMiserPerk],
	PlayerInfo[playerid][pPainPerk],
	PlayerInfo[playerid][pTraderPerk],
	PlayerInfo[playerid][pTut],
	PlayerInfo[playerid][pMissionNr],
    PlayerInfo[playerid][pBlock],
	PlayerInfo[playerid][pFuel],
	PlayerInfo[playerid][pMarried],
	PlayerInfo[playerid][pMarriedTo]);

    format(query, sizeof(query), "%s \
    `CBRADIO`='%d', \
    `PoziomPoszukiwania`='%d', \
    `Dowod`='%d', \
    `PodszywanieSie`='%d', \
    `ZmienilNick`='%d', \
    `PodgladWiadomosci`='%d', \
    `StylWalki`='%d', \
    `PAdmin`='%d', \
    `ZaufanyGracz`='%d', \
    `CruiseController`='%d', \
    `FixKit`='%d', \
    `Immunity`='%.0f', \
    `motelEvict`='%d', \
    `Hunger`='%f', \
	`Thirst`='%f', \
    `connected`='%d', \
    `online`='0', ", query,
    PlayerInfo[playerid][pCB],
    PoziomPoszukiwania[playerid],
    PlayerInfo[playerid][pDowod],
    PlayerInfo[playerid][pTajniak],
       PlayerInfo[playerid][pZmienilNick],
    PlayerInfo[playerid][pPodPW],
    PlayerInfo[playerid][pStylWalki],
    PlayerInfo[playerid][pNewAP],
    PlayerInfo[playerid][pZG],
    PlayerInfo[playerid][pCruiseController],
    PlayerInfo[playerid][pFixKit],
    GetPlayerImmunity(playerid),
      PlayerInfo[playerid][pMotEvict],
    PlayerInfo[playerid][pHunger],
	PlayerInfo[playerid][pThirst],
    forcequit ? 0 : 2); // connected TODO

	format(query, sizeof(query), "%s \
	`Grupa1` = '%d', `Grupa2` = '%d', `Grupa3` = '%d', \
	`Grupa1Rank` = '%d', `Grupa2Rank` = '%d', `Grupa3Rank` = '%d',  \
	`Grupa1Skin` = '%d', `Grupa2Skin` = '%d', `Grupa3Skin` = '%d', \
	`GrupaSpawn` = '%d', ",
	query,
	PlayerInfo[playerid][pGrupa][0], PlayerInfo[playerid][pGrupa][1], PlayerInfo[playerid][pGrupa][2],
	PlayerInfo[playerid][pGrupaRank][0], PlayerInfo[playerid][pGrupaRank][1], PlayerInfo[playerid][pGrupaRank][2],
	PlayerInfo[playerid][pGrupaSkin][0], PlayerInfo[playerid][pGrupaSkin][1], PlayerInfo[playerid][pGrupaSkin][2],
	PlayerInfo[playerid][pGrupaSpawn]);

	format(query, sizeof(query), "%s \
	`DutyTime` = '%d', \
	`DutyCheck` = '%d', \
	`BlokadaBroni` = '%d', \
	`lastver` = '%s', \
	`DeagleSkill` = '%d', `ColtSkill` = '%d', `SilencedSkill` = '%d', `ShotgunSkill` = '%d', `M4Skill` = '%d', `AKSkill` = '%d' \
	WHERE `UID` = '%d'", query,
	PlayerInfo[playerid][pDutyTime],
	gettime(),
	PlayerInfo[playerid][pWeaponBlock],
	VERSION,
	PlayerInfo[playerid][pWeaponSkill][0], PlayerInfo[playerid][pWeaponSkill][1], PlayerInfo[playerid][pWeaponSkill][2], PlayerInfo[playerid][pWeaponSkill][3], PlayerInfo[playerid][pWeaponSkill][4], PlayerInfo[playerid][pWeaponSkill][5],
	PlayerInfo[playerid][pUID]);

  	if(!mysql_query(query)) fault=false;

	format(query, sizeof(query), "INSERT IGNORE INTO `mru_personalization` (`UID`) VALUES ('%d')", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	format(query, sizeof(query), "UPDATE `mru_personalization` SET \
	`KontoBankowe` = '%d', \
	`Ogloszenia` = '%d', \
	`LicznikPojazdu` = '%d', \
	`OgloszeniaRodzin` = '%d', \
	`OldNick` = '%d', \
	`CBRadio` = '%d', \
	`Report` = '%d', \
	`DeathWarning` = '%d', \
	`KaryTXD` = '%d', \
	`NewNick` = '%d', \
	`newbie` = '%d',	\
	`BronieScroll` = '%d', \
	`AnimacjaMowienia` = '%d',	\
	`JoinLeave` = '%d'	\
	WHERE `UID`= '%d'",
	PlayerPersonalization[playerid][PERS_KB],
	PlayerPersonalization[playerid][PERS_AD],
	PlayerPersonalization[playerid][PERS_LICZNIK],
	PlayerPersonalization[playerid][PERS_FAMINFO],
	PlayerPersonalization[playerid][PERS_NICKNAMES],
	PlayerPersonalization[playerid][PERS_CB],
	PlayerPersonalization[playerid][PERS_REPORT],
	PlayerPersonalization[playerid][WARNDEATH],
	PlayerPersonalization[playerid][PERS_KARYTXD],
	PlayerPersonalization[playerid][PERS_NEWNICK],
	PlayerPersonalization[playerid][PERS_NEWBIE],
	PlayerPersonalization[playerid][PERS_GUNSCROLL],
	PlayerPersonalization[playerid][PERS_TALKANIM],
	PlayerPersonalization[playerid][PERS_JOINLEAVE],
	PlayerInfo[playerid][pUID]); 

	//przywróæ maskowanie nicku (pNick)
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		new playernickname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playernickname, sizeof(playernickname));
		format(PlayerInfo[playerid][pNick], 24, "%s", playernickname);
	}

	if(!mysql_query(query)) fault=false;
	
    //Zapis MruCoinow
    MruMySQL_SaveMc(playerid);

    saveLegale(playerid);

    saveKevlarPos(playerid);

	/*if(rgRakNet_SaveWeapons[playerid] == 1)
    {
    	RestoreOldWeapons(playerid, PlayerInfo[playerid][pUID]);
    }*/

	return fault;
}

public MruMySQL_LoadAccount(playerid)
{
	if(!MYSQL_ON) return false;

	new lStr[2024], id=0;

    lStr = "`UID`, `Nick`, `Level`, `Admin`, `DonateRank`, `UpgradePoints`, `ConnectedTime`, `Registered`, `Sex`, `Age`, `Origin`, `CK`, `Muted`, `Respect`, `Money`, `Bank`, `Crimes`, `Kills`, `Deaths`, `Arrested`, `WantedDeaths`, `Phonebook`, `LottoNr`, `Fishes`, `BiggestFish`, `Job`, `Paycheck`, `HeadValue`, `BlokadaPisania`, `Jailed`, `AJreason`, `JailTime`, `Materials`,`Drugs`, `Member`, `FMember`, `Rank`, `Char`, `Skin`, `ContractTime`, `fishCooldown`";

    format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
	mysql_query(lStr);
	mysql_store_result();
    if (mysql_num_rows())
	{
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();
        id++;
		sscanf(lStr, "p<|>ds[24]dddddddddddddddddddddddddddds[64]dddddddddd",
		PlayerInfo[playerid][pUID],
		PlayerInfo[playerid][pNick],
		PlayerInfo[playerid][pLevel], 
		PlayerInfo[playerid][pAdmin], 
		PlayerInfo[playerid][pDonateRank], 
		PlayerInfo[playerid][gPupgrade], 
		PlayerInfo[playerid][pConnectTime], 
		PlayerInfo[playerid][pReg], 
		PlayerInfo[playerid][pSex], 
		PlayerInfo[playerid][pAge], 
		PlayerInfo[playerid][pOrigin], 
		PlayerInfo[playerid][pCK], 
		PlayerInfo[playerid][pMuted], 
		PlayerInfo[playerid][pExp], 
		PlayerInfo[playerid][pCash], 
		PlayerInfo[playerid][pAccount], 
		PlayerInfo[playerid][pCrimes], 
		PlayerInfo[playerid][pKills], 
		PlayerInfo[playerid][pDeaths], 
		PlayerInfo[playerid][pArrested], 
		PlayerInfo[playerid][pWantedDeaths], 
		PlayerInfo[playerid][pPhoneBook], 
		PlayerInfo[playerid][pLottoNr], 
		PlayerInfo[playerid][pFishes], 
		PlayerInfo[playerid][pBiggestFish], 
		PlayerInfo[playerid][pJob], 
		PlayerInfo[playerid][pPayCheck], 
		PlayerInfo[playerid][pHeadValue], 
		PlayerInfo[playerid][pBP], 
		PlayerInfo[playerid][pJailed], 
		PlayerInfo[playerid][pAJreason],
		PlayerInfo[playerid][pJailTime], 
		PlayerInfo[playerid][pMats], 
		PlayerInfo[playerid][pDrugs], 
		PlayerInfo[playerid][pMember], 
		PlayerInfo[playerid][pOrg],
		PlayerInfo[playerid][pRank], 
		PlayerInfo[playerid][pChar], 
		PlayerInfo[playerid][pSkin], 
		PlayerInfo[playerid][pContractTime],
		FishCount[playerid]);

        lStr = "`DetSkill`, `SexSkill`, `BoxSkill`, `LawSkill`, `MechSkill`, `JackSkill`, `CarSkill`, `NewsSkill`, `DrugsSkill`, `CookSkill`, `FishSkill`, `GunSkill`, `TruckSkill`, `PizzaboySkill`, `pSHealth`, `pHealth`, `VW`, `Int`, `Local`, `Team`, `JobSkin`, `Dom`, `Bizz`, `BizzMember`, `Wynajem`, `Pos_x`, `Pos_y`, `Pos_z`, `CarLic`, `FlyLic`, `BoatLic`, `FishLic`, `GunLic`, `Mikolaj`, `pPlayerEXP`, `pOsiagniecia1`, `pOsiagniecia2`, `pOsiagniecia3`, `pOsiagniecia4`, `pOsiagniecia5`, `DeagleSkill`, `ColtSkill`, `SilencedSkill`, `M4Skill`, `AKSkill`";
        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        sscanf(lStr, "p<|>ddddddddddddddffdddddddddfffdddddddddddddddddd",
        PlayerInfo[playerid][pDetSkill],
		PlayerInfo[playerid][pSexSkill],
		PlayerInfo[playerid][pBoxSkill],
		PlayerInfo[playerid][pLawSkill],
		PlayerInfo[playerid][pMechSkill],
		PlayerInfo[playerid][pJackSkill],
		PlayerInfo[playerid][pCarSkill],
		PlayerInfo[playerid][pNewsSkill],
		PlayerInfo[playerid][pDrugsSkill],
		PlayerInfo[playerid][pCookSkill],
		PlayerInfo[playerid][pFishSkill],
		PlayerInfo[playerid][pGunSkill],
        PlayerInfo[playerid][pTruckSkill],
		PlayerInfo[playerid][pPizzaboySkill],
		PlayerInfo[playerid][pSHealth],
		PlayerInfo[playerid][pHealth],
		PlayerInfo[playerid][pVW],
		PlayerInfo[playerid][pInt],
		PlayerInfo[playerid][pLocal],
		PlayerInfo[playerid][pTeam],
		PlayerInfo[playerid][pJobSkin],
		PlayerInfo[playerid][pDom],
		PlayerInfo[playerid][pBusinessOwner],
		PlayerInfo[playerid][pBusinessMember],
		PlayerInfo[playerid][pWynajem],
		PlayerInfo[playerid][pPos_x],
		PlayerInfo[playerid][pPos_y],
		PlayerInfo[playerid][pPos_z],
		PlayerInfo[playerid][pCarLic],
		PlayerInfo[playerid][pFlyLic],
		PlayerInfo[playerid][pBoatLic],
		PlayerInfo[playerid][pFishLic],
		PlayerInfo[playerid][pGunLic],
		PlayerInfo[playerid][pMikolaj],
		PlayerInfo[playerid][pPlayerEXP],
		PlayerInfo[playerid][pOsiagniecia1],
		PlayerInfo[playerid][pOsiagniecia2],
		PlayerInfo[playerid][pOsiagniecia3],
		PlayerInfo[playerid][pOsiagniecia4],
		PlayerInfo[playerid][pOsiagniecia5],
		PlayerInfo[playerid][pWeaponSkill][0],
		PlayerInfo[playerid][pWeaponSkill][1],
		PlayerInfo[playerid][pWeaponSkill][2],
		PlayerInfo[playerid][pWeaponSkill][3],
		PlayerInfo[playerid][pWeaponSkill][4],
		PlayerInfo[playerid][pWeaponSkill][5]);
		/*
		zmiany w strukturze mysql
		ALTER TABLE `mru_konta` ADD `DeagleSkill` INT, ADD `ColtSkill` INT, ADD `SilencedSkill` INT, ADD `ShotgunSkill` INT, ADD `M4Skill` INT, ADD `AKSkill` INT;
		ALTER TABLE `mru_konta` ADD `Thirst` FLOAT;
		*/

		PlayerInfo[playerid][pIntSpawn] = PlayerInfo[playerid][pInt];

        lStr = "`Gun0`, `Gun1`, `Gun2`, `Gun3`, `Gun4`, `Gun5`, `Gun6`, `Gun7`, `Gun8`, `Gun9`, `Gun10`, `Gun11`, `Gun12`, `Ammo0`, `Ammo1`, `Ammo2`, `Ammo3`, `Ammo4`, `Ammo5`, `Ammo6`, `Ammo7`, `Ammo8`, `Ammo9`, `Ammo10`, `Ammo11`, `Ammo12`, `CarTime`, `PayDay`, `PayDayHad`, `CDPlayer`, `Wins`, `Loses`, `AlcoholPerk`, `DrugPerk`, `MiserPerk`, `PainPerk`, `TraderPerk`, `Tutorial`, `Mission`, `Block`, `Fuel`, `Married`";

        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

		sscanf(lStr, "p<|>dddddddddddddddddddddddddddddddddddddddddd",
		PlayerInfo[playerid][pGun0], 
		PlayerInfo[playerid][pGun1], 
		PlayerInfo[playerid][pGun2], 
		PlayerInfo[playerid][pGun3], 
		PlayerInfo[playerid][pGun4], 
		PlayerInfo[playerid][pGun5], 
		PlayerInfo[playerid][pGun6], 
		PlayerInfo[playerid][pGun7], 
		PlayerInfo[playerid][pGun8], 
		PlayerInfo[playerid][pGun9], 
		PlayerInfo[playerid][pGun10], 
		PlayerInfo[playerid][pGun11], 
		PlayerInfo[playerid][pGun12], 
		PlayerInfo[playerid][pAmmo0], 
		PlayerInfo[playerid][pAmmo1], 
		PlayerInfo[playerid][pAmmo2], 
		PlayerInfo[playerid][pAmmo3], 
		PlayerInfo[playerid][pAmmo4], 
		PlayerInfo[playerid][pAmmo5], 
		PlayerInfo[playerid][pAmmo6], 
		PlayerInfo[playerid][pAmmo7], 
		PlayerInfo[playerid][pAmmo8], 
		PlayerInfo[playerid][pAmmo9], 
		PlayerInfo[playerid][pAmmo10], 
		PlayerInfo[playerid][pAmmo11], 
		PlayerInfo[playerid][pAmmo12], 
		PlayerInfo[playerid][pCarTime], 
		PlayerInfo[playerid][pPayDay], 
		PlayerInfo[playerid][pPayDayHad], 
		PlayerInfo[playerid][pCDPlayer], 
		PlayerInfo[playerid][pWins], 
		PlayerInfo[playerid][pLoses], 
		PlayerInfo[playerid][pAlcoholPerk], 
		PlayerInfo[playerid][pDrugPerk], 
		PlayerInfo[playerid][pMiserPerk], 
		PlayerInfo[playerid][pPainPerk], 
		PlayerInfo[playerid][pTraderPerk], 
		PlayerInfo[playerid][pTut], 
		PlayerInfo[playerid][pMissionNr], 
		PlayerInfo[playerid][pBlock], 
		PlayerInfo[playerid][pFuel], 
		PlayerInfo[playerid][pMarried]);

		MyWeapon[playerid] = PlayerInfo[playerid][pGun0];
		SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);


    	lStr = "`MarriedTo`, `CBRADIO`, `PoziomPoszukiwania`, `Dowod`, `PodszywanieSie`, `ZmienilNick`, `PodgladWiadomosci`, `StylWalki`, `PAdmin`, `ZaufanyGracz`, `CruiseController`, `FixKit`, `Auto1`, `Auto2`, `Auto3`, `Auto4`, `Lodz`, `Samolot`, `Garaz`, `KluczykiDoAuta`, `Spawn`, `BW`, `Injury`, `HealthPacks`, `Czystka`, `CarSlots`, `Immunity`, `Hunger`, `motelEvict`, `lastver`, `hidden`, `Thirst`, `LastHP`, `LastArmour`";

        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
        mysql_query(lStr);
        mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        new immunity, lastver[64];
        sscanf(lStr, "p<|>s[24]ddddddddddddddddddddddddddfds[64]dfff",
        PlayerInfo[playerid][pMarriedTo],
        PlayerInfo[playerid][pCB],
        PlayerInfo[playerid][pWL],
        PlayerInfo[playerid][pDowod],
        PlayerInfo[playerid][pTajniak],
        PlayerInfo[playerid][pZmienilNick],
        PlayerInfo[playerid][pPodPW],
        PlayerInfo[playerid][pStylWalki],
        PlayerInfo[playerid][pNewAP],
        PlayerInfo[playerid][pZG],
        PlayerInfo[playerid][pCruiseController],
        PlayerInfo[playerid][pFixKit],
        PlayerInfo[playerid][pAuto1],
        PlayerInfo[playerid][pAuto2],
        PlayerInfo[playerid][pAuto3],
        PlayerInfo[playerid][pAuto4],
        PlayerInfo[playerid][pLodz],
        PlayerInfo[playerid][pSamolot],
        PlayerInfo[playerid][pGaraz],
        PlayerInfo[playerid][pKluczeAuta],
        PlayerInfo[playerid][pSpawn],
        PlayerInfo[playerid][pBW],
        PlayerInfo[playerid][pInjury],
        PlayerInfo[playerid][pHealthPacks],
        PlayerInfo[playerid][pCzystka],
        PlayerInfo[playerid][pCarSlots],
        immunity,
        PlayerInfo[playerid][pHunger],
        PlayerInfo[playerid][pMotEvict],
        lastver,
		PlayerInfo[playerid][pHidden],
		PlayerInfo[playerid][pThirst],
		PlayerInfo[playerid][pLastHP],
		PlayerInfo[playerid][pLastArmour]);
		
		SetPlayerImmunity(playerid, immunity);
		if(strcmp(lastver, VERSION, true) != 0) SetPVarInt(playerid, "showchangelog", 1);

		// Grupy
		lStr = "`Grupa1`, `Grupa2`, `Grupa3`, `Grupa1Rank`, `Grupa2Rank`, `Grupa3Rank`, `Grupa1Skin`, `Grupa2Skin`, `Grupa3Skin`, `GrupaSpawn`";
    	format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
    	if(mysql_num_rows()) id++;
    	mysql_fetch_row_format(lStr, "|");
    	mysql_free_result();

    	sscanf(lStr, "p<|>dddddddddd",
    	PlayerInfo[playerid][pGrupa][0],
		PlayerInfo[playerid][pGrupa][1],
		PlayerInfo[playerid][pGrupa][2],
		PlayerInfo[playerid][pGrupaRank][0],
		PlayerInfo[playerid][pGrupaRank][1],
		PlayerInfo[playerid][pGrupaRank][2],
		PlayerInfo[playerid][pGrupaSkin][0],
		PlayerInfo[playerid][pGrupaSkin][1],
		PlayerInfo[playerid][pGrupaSkin][2],
		PlayerInfo[playerid][pGrupaSpawn]);

		//Czas na /duty
		lStr = "`DutyTime`, `DutyCheck`";
		format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
    	if(mysql_num_rows()) id++;
    	mysql_fetch_row_format(lStr, "|");
    	mysql_free_result();

		new dutytime, dutycheck;
		sscanf(lStr, "p<|>dd", dutytime, dutycheck);
		if(dutytime >= 60)
		{
			if(dutycheck+900 > gettime()) //czas na powrót: 15 minut
			{
				SetPVarInt(playerid, "reset-dutytime", gettime()+900);
				PlayerInfo[playerid][pDutyTime] = dutytime;
				sendTipMessage(playerid, "Twój spêdzony czas na s³u¿bie zosta³ przywrócony!");
				PrintDutyTime(playerid, 0);
			}
			else
			{
				sendTipMessage(playerid, "Twój spêdzony czas na s³u¿bie zosta³ wyzerowany!");
				mysql_query_format("UPDATE `mru_konta` SET `DutyTime` = '0', `DutyCheck` = '0' WHERE `UID` = '%d'", PlayerInfo[playerid][pUID]);
				PlayerInfo[playerid][pDutyTime] = 0;
			}
		}

		//Blokady
		lStr = "`BlokadaBroni`";
		format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
    	if(mysql_num_rows()) id++;
    	mysql_fetch_row_format(lStr, "|");
    	mysql_free_result();

		sscanf(lStr, "p<|>d", PlayerInfo[playerid][pWeaponBlock]);

		lStr = "`LastHP`, `LastArmour`";

		format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
		mysql_query(lStr);
		mysql_store_result();
		if(mysql_num_rows()) id++;
		mysql_fetch_row_format(lStr, "|");
		mysql_free_result();

		sscanf(lStr, "p<|>ff",
		PlayerInfo[playerid][pLastHP],
		PlayerInfo[playerid][pLastArmour]);

		//format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `connected`='1', `online`='1' WHERE `UID`='%d'", PlayerInfo[playerid][pUID]);
		//mysql_query(lStr);

		lStr = "`ChangeNumber`, `Convert`";
		format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
    	if(mysql_num_rows()) id++;
    	mysql_fetch_row_format(lStr, "|");
    	mysql_free_result();

		new ChangeNumber, Convert;
		sscanf(lStr, "p<|>dd", ChangeNumber, Convert);

		if(Convert > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			SendClientMessage(playerid, COLOR_RED, "TWOJA POSTAÆ WYMAGA DZIA£ANIA - SPRAWD PANEL GRACZA NA FORUM");
			KickEx(playerid);
			return 1;
		}
		if(ChangeNumber > 0)
		{
			MRP_SetPlayerPhone(playerid, ChangeNumber);
			SendClientMessage(playerid, COLOR_BLUE, sprintf("Twój numer telefonu zosta³ zmieniony na %d", ChangeNumber));
			format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `ChangeNumber` = 0 WHERE `Nick`='%s'", GetNickEx(playerid));
			mysql_query(lStr); 
		}
		//ALTER TABLE `mru_konta` ADD `Compensation` INT DEFAULT '0';
		lStr = "`Compensation`, `NocOczyszczeniaKit`";
		format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick` = '%s'", lStr, GetNickEx(playerid));
		mysql_query(lStr);
		mysql_store_result();
		if(mysql_num_rows()) id++;
		mysql_fetch_row_format(lStr, "|");
    	mysql_free_result();

		new Compensation, NocOczyszczeniaKit;
		sscanf(lStr, "p<|>dd", Compensation, NocOczyszczeniaKit);
		SetPVarInt(playerid, "got-compensation", Compensation);
		SetPVarInt(playerid, "kit-cooldown", NocOczyszczeniaKit);
	}

	

	//Wczytaj nick OOC z forum

	mysql_query_format("SELECT mybb_users.username, mybb_users.uid, mybb_users.samp_warns, mybb_users.samp_kc FROM mru_konta JOIN mybb_users on mybb_users.uid = mru_konta.uid_forum WHERE mru_konta.UID = '%d'", PlayerInfo[playerid][pUID]);

	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		new result[148];
        mysql_fetch_row_format(result, "|");
		sscanf(result, "p<|>s[32]ddd", 
		PlayerInfo[playerid][pNickOOC],
		PlayerInfo[playerid][pGID],
		PlayerInfo[playerid][pWarns],
		PremiumInfo[playerid][pMC]);
	}

	mysql_free_result();

	// Pozycje kamizelki

	loadKamiPos(playerid);

	//Wczytaj liderów
	lStr = "`NICK`, `UID`, `FracID`, `LiderValue`";
	format(lStr, 1024, "SELECT %s FROM `mru_liderzy` WHERE `NICK`='%s'", lStr, GetNickEx(playerid));
	mysql_query(lStr);
	mysql_store_result(); 
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(lStr, "|"); 
		sscanf(lStr, "p<|>s[24]ddd",
		GetNickEx(playerid),
		PlayerInfo[playerid][pUID],
		PlayerInfo[playerid][pLider],
		PlayerInfo[playerid][pLiderValue]); 
	} 
	mysql_free_result();
	//Wczytaj personalizacje
	lStr = "`KontoBankowe`, `Ogloszenia`, `LicznikPojazdu`, `OgloszeniaRodzin`, `OldNick`, `CBRadio`, `Report`, `DeathWarning`, `KaryTXD`, `NewNick`, `newbie`, `BronieScroll`, `AnimacjaMowienia`, `JoinLeave`";
	format(lStr, 1024, "SELECT %s FROM `mru_personalization` WHERE `UID`=%d", lStr, PlayerInfo[playerid][pUID]);
	mysql_query(lStr); 
	mysql_store_result(); 
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(lStr, "|"); 
		sscanf(lStr, "p<|>dddddddddddddd", 
		PlayerPersonalization[playerid][PERS_KB],
		PlayerPersonalization[playerid][PERS_AD],
		PlayerPersonalization[playerid][PERS_LICZNIK],
		PlayerPersonalization[playerid][PERS_FAMINFO],
		PlayerPersonalization[playerid][PERS_NICKNAMES],
		PlayerPersonalization[playerid][PERS_CB],
		PlayerPersonalization[playerid][PERS_REPORT],
		PlayerPersonalization[playerid][WARNDEATH],
		PlayerPersonalization[playerid][PERS_KARYTXD],
		PlayerPersonalization[playerid][PERS_NEWNICK],
		PlayerPersonalization[playerid][PERS_NEWBIE],
		PlayerPersonalization[playerid][PERS_GUNSCROLL],
		PlayerPersonalization[playerid][PERS_TALKANIM],
		PlayerPersonalization[playerid][PERS_JOINLEAVE]); 
	}
	mysql_free_result();

	//Wczytaj ryby
	lStr = "`Fish1`, `Fish2`, `Fish3`, `Fish4`, `Fish5`, `Weight1`, `Weight2`, `Weight3`, `Weight4`, `Weight5`, `Fid1`, `Fid2`, `Fid3`, `Fid4`, `Fid5`";
	format(lStr, 1024, "SELECT %s FROM `mru_ryby` WHERE `Player` = '%d'", lStr, PlayerInfo[playerid][pUID]);
	mysql_query(lStr);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(lStr, "|");
		sscanf(lStr, "p<|>s[20]s[20]s[20]s[20]s[20]dddddddddd",
		Fishes[playerid][pFish1],
		Fishes[playerid][pFish2],
		Fishes[playerid][pFish3],
		Fishes[playerid][pFish4],
		Fishes[playerid][pFish5],
		Fishes[playerid][pWeight1],
		Fishes[playerid][pWeight2],
		Fishes[playerid][pWeight3],
		Fishes[playerid][pWeight4],
		Fishes[playerid][pWeight5],
		Fishes[playerid][pFid1],
		Fishes[playerid][pFid2],
		Fishes[playerid][pFid3],
		Fishes[playerid][pFid4],
		Fishes[playerid][pFid5]);
	}
	else
		mysql_query_format("INSERT INTO `mru_ryby` (`Player`) VALUES ('%d')", PlayerInfo[playerid][pUID]);
	mysql_free_result();
	
	//legal
	format(lStr, sizeof lStr, "SELECT * FROM `mru_legal` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

	playerWeapons[playerid][weaponLegal1] 	= 1;
	playerWeapons[playerid][weaponLegal2] 	= 1;
	playerWeapons[playerid][weaponLegal3] 	= 1;
	playerWeapons[playerid][weaponLegal4] 	= 1;
	playerWeapons[playerid][weaponLegal5] 	= 1;
	playerWeapons[playerid][weaponLegal6] 	= 1;
	playerWeapons[playerid][weaponLegal7] 	= 1;
	playerWeapons[playerid][weaponLegal8] 	= 1;
	playerWeapons[playerid][weaponLegal9] 	= 1;
	playerWeapons[playerid][weaponLegal10] 	= 1;
	playerWeapons[playerid][weaponLegal11] 	= 1;
	playerWeapons[playerid][weaponLegal12] 	= 1;
	playerWeapons[playerid][weaponLegal13] 	= 1;

	if(db_num_rows(db_result)) {
		playerWeapons[playerid][weaponLegal1] = db_get_field_assoc_int(db_result, "weapon1");
		playerWeapons[playerid][weaponLegal2] = db_get_field_assoc_int(db_result, "weapon2");
		playerWeapons[playerid][weaponLegal3] = db_get_field_assoc_int(db_result, "weapon3");
		playerWeapons[playerid][weaponLegal4] = db_get_field_assoc_int(db_result, "weapon4");
		playerWeapons[playerid][weaponLegal5] = db_get_field_assoc_int(db_result, "weapon5");
		playerWeapons[playerid][weaponLegal6] = db_get_field_assoc_int(db_result, "weapon6");
		playerWeapons[playerid][weaponLegal7] = db_get_field_assoc_int(db_result, "weapon7");
		playerWeapons[playerid][weaponLegal8] = db_get_field_assoc_int(db_result, "weapon8");
		playerWeapons[playerid][weaponLegal9] = db_get_field_assoc_int(db_result, "weapon9");
		playerWeapons[playerid][weaponLegal10] = db_get_field_assoc_int(db_result, "weapon10");
		playerWeapons[playerid][weaponLegal11] = db_get_field_assoc_int(db_result, "weapon11");
		playerWeapons[playerid][weaponLegal12] = db_get_field_assoc_int(db_result, "weapon12");
		playerWeapons[playerid][weaponLegal13] = db_get_field_assoc_int(db_result, "weapon13");
	} else {
		format(lStr, sizeof lStr, "INSERT INTO `mru_legal` (`pID`,`weapon1`, `weapon2`, `weapon3`, `weapon4`, `weapon5`, `weapon6`, `weapon7`, `weapon8`, `weapon9`, `weapon10`, `weapon11`, `weapon12`, `weapon13`) VALUES (%d, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)", PlayerInfo[playerid][pUID]);
		db_free_result(db_query(db_handle, lStr));
	}

	//bw
	if(PlayerInfo[playerid][pInjury] >= 988 && PlayerInfo[playerid][pInjury] <= 999)
	{
		SetPVarInt(playerid, "acceptdeath-allow", 1);
		PlayerInfo[playerid][pInjury] = 999;
		TextDrawSetString(TextDrawInfo[playerid], "mozesz uzyc komendy ~g~/akceptuj smierc");
		TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
	}

    MruMySQL_LoadAccess(playerid);
	ConvertMatsToItems(playerid);
	ValidateGroups(playerid);
    //MruMySQL_WczytajOpis(playerid, PlayerInfo[playerid][pUID], 1);

	// Load motel room
	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrOwnerUID] == PlayerInfo[playerid][pUID])
		{
			PlayerInfo[playerid][pMotRoom] = i;
		}
	}
	if(id != 10) return false;
	return true;
}

MruMySQL_WczytajOpis(handle, uid, typ)
{
    new lStr[128], lText[128];
    format(lStr, 128, "SELECT `desc` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        if(typ == 1)
        {
            mysql_fetch_row_format(lText, "|");
            strpack(PlayerDesc[handle], lText);
        }
        else
        {
            mysql_fetch_row_format(lText, "|");
            strcat(CarDesc[handle], lText);
        }
    }
	mysql_free_result();
    return 1;
}

MruMySQL_UpdateOpis(handle, uid, typ)
{
    new lStr[256], packed[128], opis[128];
	if(typ == 1)
	{
		strunpack(packed, PlayerDesc[handle]);
    	mysql_real_escape_string(packed, opis);
	}
	else
	{
    	mysql_real_escape_string(CarDesc[handle], opis);
	}
    if(MruMySQL_CheckOpis(uid, typ))
        format(lStr, 256, "UPDATE `mru_opisy` SET `desc`='%s' WHERE `owner`='%d' AND `typ`=%d", opis, uid, typ);
    else
        format(lStr, 256, "INSERT INTO `mru_opisy` (`desc`, `owner`, `typ`) VALUES ('%s', %d, %d)", opis, uid, typ);
    mysql_query(lStr);
}

MruMySQL_CheckOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "SELECT `UID` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
        return 1;
    }
	mysql_free_result();
    return 0;
}

MruMySQL_DeleteOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "DELETE FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    return 0;
}

MruMySQL_LoadAccess(playerid)
{
    if(!MYSQL_ON) return false;

	new query[128];
	format(query, sizeof(query), "SELECT CAST(`FLAGS` AS UNSIGNED) AS `FLAGS` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);

	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        ACCESS[playerid] = mysql_fetch_int();
        OLD_ACCESS[playerid] = ACCESS[playerid];
    }
    mysql_free_result();
    return 1;
}

MruMySQL_DoesAccountExistByUID(uid)
{
	mysql_query_format("SELECT `UID` FROM `mru_konta` WHERE `UID` = '%d'", uid);
	mysql_store_result();
	new result = mysql_num_rows();
	mysql_free_result();
	if(result > 0)
		return 1;
	return 0;
}

MruMySQL_DoesAccountExist(nick[])
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `Nick` = BINARY '%s'", nick);
	mysql_query(string);
	mysql_store_result();
	new result = mysql_num_rows();
	mysql_free_result();

	if(result > 0)
	{
		return -1;
	}
    else
    {
        format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `Nick` = '%s'", nick);
    	mysql_query(string);
    	mysql_store_result();
    	result = mysql_num_rows();
    	mysql_free_result();
        if(result > 0) return -999;
    }
    format(string, 128, "%s.ini", nick);

	if(dini_Exists(string)) return 1;
	return 0;
}

MruMySQL_ReturnPassword(nick[], key[], salt[])
{
	new string[256];
	new result[8+WHIRLPOOL_LEN+SALT_LENGTH];
	
	mysql_real_escape_string(nick, nick);
	//`members_pass_hash`
	//`members_pass_salt`
	//format(string, sizeof(string), "SELECT `Key`, `Salt` FROM `mru_konta` WHERE `Nick` = '%s'", nick);
	format(string, sizeof(string),
	"SELECT mybb_users.password, mybb_users.salt FROM mru_konta JOIN mybb_users on mybb_users.uid = mru_konta.uid_forum WHERE mru_konta.Nick = '%s'",
	nick);

	mysql_query(string);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
        mysql_fetch_row_format(result, "|");
		sscanf(result, "p<|>s[129]s[" #SALT_LENGTH "]", key, salt);
	}

	
	mysql_free_result();
	return 1;
}


//--------------------------------------------------------------<[ Kary ]>--------------------------------------------------------------

//Pobieranie i zwracanie pojedynczych zmiennych:

stock MruMySQL_GetWarnsFromName(name[])
{
	new wartosc;
	mysql_query_format("SELECT mybb_users.samp_warns FROM mru_konta JOIN mybb_users on mybb_users.uid = mru_konta.uid_forum WHERE mru_konta.Nick = '%s'", name);
	mysql_store_result();
    if(mysql_num_rows())
    {
	   wartosc = mysql_fetch_int();
    }
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetNameFromUID(uid) {
	new wartosc[MAX_PLAYER_NAME], string[128];
	format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `UID` = '%d'", uid);
	mysql_query(string);
	mysql_store_result();
		
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, "Nick");
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetUIDFromName(name[])
{
	new wartosc;
	mysql_query_format("SELECT UID FROM mru_konta WHERE Nick = '%s'", name);
	mysql_store_result();
    if(mysql_num_rows())
    {
	   wartosc = mysql_fetch_int();
    }
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetNickOOCFromName(name[])
{
	new wartosc[MAX_PLAYER_NAME];
	mysql_query_format("SELECT mybb_users.username FROM mru_konta JOIN mybb_users on mybb_users.uid = mru_konta.uid_forum WHERE mru_konta.Nick = '%s'", name);
	mysql_store_result();
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, "username");
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetNickOOCFromGID(t_gid)
{
	new wartosc[MAX_PLAYER_NAME];
	mysql_query_format("SELECT username FROM mybb_users WHERE uid = '%d'", t_gid);
	mysql_store_result();
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, "username");
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccString(kolumna[], nick[])
{
	new string[128], wartosc[256];
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
		
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, kolumna);
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccInt(kolumna[], nick[])
{
	new string[128], wartosc;
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
    if(mysql_num_rows())
    {
	   wartosc = mysql_fetch_int();
    }
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccFloat(kolumna[], nick[])
{
	new string[128], Float:wartosc;
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
	wartosc = mysql_fetch_float();	
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_SetAccString(kolumna[], nick[], wartosc[])
{
	new string[128];
	mysql_real_escape_string(wartosc, wartosc);
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%s' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccInt(kolumna[], nick[], wartosc)
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%d' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccFloat(kolumna[], nick[], Float:wartosc)
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%f' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 0;
}

stock MruMySQL_LoadPhoneContacts(playerid)
{
	new string[128];
	format(string, sizeof(string), "SELECT UID, Number, Name FROM mru_kontakty WHERE Owner='%d' LIMIT 10", PlayerInfo[playerid][pUID]); //MAX_KONTAKTY
	mysql_query(string);
	mysql_store_result();
	if(mysql_num_rows()>0)
	{
		new i;
		while(mysql_fetch_row_format(string, "|"))
		{
			sscanf(string, "p<|>dds[32]", 
				Kontakty[playerid][i][eUID], 
				Kontakty[playerid][i][eNumer], 
				Kontakty[playerid][i][eNazwa]
			);
			i++;
			if(i == MAX_KONTAKTY) 
				break;
		}
	}
	mysql_free_result();
	return 1;
}

stock MruMySQL_AddPhoneContact(playerid, nazwa[], numer)
{
	new string[128], escapedName[32];
	mysql_real_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "INSERT INTO mru_kontakty (Owner, Number, Name) VALUES ('%d', '%d', '%s')", PlayerInfo[playerid][pUID], numer, escapedName);
	mysql_query(string);
	
	new uid = mysql_insert_id();
	return uid;
}

stock MruMySQL_EditPhoneContact(uid, nazwa[])
{
	new string[128], escapedName[32];
	mysql_real_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "UPDATE mru_kontakty SET Name='%s' WHERE UID='%d'", escapedName, uid);
	mysql_query(string);
	return 1;
}

stock MruMySQL_DeletePhoneContact(uid)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM mru_kontakty WHERE UID='%d'", uid);
	mysql_query(string);
	return 1;
}

new bool:MySQL_timeout=false;
public MySQL_Refresh()
{
    if(mysql_ping() == 1)
    {
        if(MySQL_timeout)
        {
            new str[64];
            format(str, 64, "gamemodetext Kotnik-RP %s", VERSION);
            SendRconCommand(str);
            MySQL_timeout = false;
        }
    }
    else
	{
		print("MySQL: Connection time-out");
        mysql_reconnect();
        MySQL_timeout= true;
		SendRconCommand("gamemodetext M-RP: MySQL timeout");
	}
}

stock mysql_query_format(const query[], va_args<>)
{
	new str[528];
	va_format(str, sizeof str, query, va_start<1>);
	return mysql_query(str);
}

//EOF
