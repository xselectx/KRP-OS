//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ ah ]--------------------------------------------------//
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

YCMD:ah(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pZG] < 1 && PlayerInfo[playerid][pNewAP] < 1 && !IsAScripter(playerid) && !IsAGameMaster(playerid))
		return noAccessMessage(playerid);
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
    if(PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "* WSZYSCY *** /supporty /reporty");
		SendClientMessage(playerid, COLOR_GRAD1, "{FF6A6A}* System @DUTY *** {C0C0C0}/adminduty [NICK OOC] || /adminstats");
		
	}
	if(PlayerInfo[playerid][pZG] > 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "*1* ZG *** /goto /togpodglad /zg");
        SendClientMessage(playerid, COLOR_GRAD1, "*2* ZG *** /kick /slap");
        SendClientMessage(playerid, COLOR_GRAD1, "*3* ZG *** /spec /aj");
        SendClientMessage(playerid, COLOR_GRAD1, "*4* ZG *** /ban /block");
        SendClientMessage(playerid, COLOR_GRAD1, "*6* ZG *** /unfreeze");
        SendClientMessage(playerid, COLOR_GRAD1, "*7* ZG *** /pogodaall /freeze");
    }
	if (PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PӣADMIN *** /slap /aj /wybieralka /check /freeze /unfreeze /ucisz /kick");
        SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PӣADMIN *** /ban /to /spec /respawn /a(dmin) chat /cmdinfo /czyjtonumer");
		SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PӣADMIN *** /unbp /unbw /checkbw /setvw /checktank /obrazenia /pwarn /paj");
		SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PӣADMIN *** /unaj /respp /usunopis /setint /rapidfly /fixveh /sethp");
    }
	if (PlayerInfo[playerid][pNewAP] == 4)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*4* PӣADMIN *** /check /sban /sblock /to /spec /a(dmin) chat");
		SendClientMessage(playerid, COLOR_GRAD1, "*4* PӣADMIN *** /unbp /checktank");
	}
    if (IsAScripter(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /respawn /(a) dmin chat /setint /getint /setvw /getvw");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /to /gotopos /tm/respawnplayer");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /mark /gotomark /gotocar /getcar /getposp");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /gotols /gotoszpital /gotolv /gotosf /gotoin /gotostad /gotojet");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /gotomechy /gotobank /gotostacja /gotomarket /checktank");
		SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /unbp /dajdowozu /specshow /setdrunk");
    }
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /slap /kick /aj /bp /warn /block /ban /pblock /pban /pwarn /paj");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /freeze /unfreeze /mute /kill /dpa /mark /gotomark");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /setint /getint /setvw /getvw /setglod /setpragnienie");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /mordinfo /gotomechy /podglad /gotocar /ip /wybieralka");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /check /pojazdygracza /sb /pokazcb /checktank");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /respawn /carjump /to /up /getcar /gethere");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /cnn /cc /spec /unblock /unwarn /forum /pogodaall");
        SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /usunopis /respawnplayer /respawncar /unbw");
        SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /setcarint /czyjtonumer /checkbw /diagnoza");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /unbp /tod /agraffiti /banip /uid /cziterzy /unmark");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /ndo /sethp /fixveh /gotoplantacja");
	}
	if (PlayerInfo[playerid][pAdmin] >= 5)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /zawodnik /dajkm /zuzel_start /zuzel_stop /rapidfly /fuelcar");
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /getposp /gotopos /gotols /gotoszpital /gotolv /gotosf /gotoin /gotostad /gotojet");
        SendClientMessage(playerid, COLOR_GRAD4, "*5* ADMIN *** /gotobank /gotostacja /gotomarket /bw");
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /cca /ann /nonewbie /checkdom /anulujzp");
	}
	if (PlayerInfo[playerid][pAdmin] == 7)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*4* ZAS�U�ONY *** /sban /sblock /skick /fixveh /sethp");
	}
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*10* ADMIN *** /fdaj /ksam /rozwiedz /setteam /entercar /sethp /setcarhp /dmvon /dmvoff");
	}
	if (PlayerInfo[playerid][pAdmin] >= 15)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*15* ADMIN *** /jump /dn /fly");
	}
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*20* ADMIN *** /noooc /demorgan /jail /gotoint");
	}
	if (PlayerInfo[playerid][pAdmin] >= 25)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*25* ADMIN *** /flip /snn /unaj /forceskin /skydive");
	}
	if (PlayerInfo[playerid][pAdmin] >= 35)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*35* ADMIN *** /undemorgan /fuelcars /setchamp /logout /setdrunk");
	}
	if (PlayerInfo[playerid][pAdmin] >= 100)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*100* ADMIN *** /reloadbans /dajdzwiek /checkteam /bw /dajapteczke /zmienwiek");
		SendClientMessage(playerid, COLOR_GRAD4,"*100* ADMIN *** /dskill /dsus /setwl /zaraz /obrazenia /blokadabroni");
	}
	if (PlayerInfo[playerid][pAdmin] >= 150)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*150* ADMIN *** /sprawdzneon");
	}
	if (PlayerInfo[playerid][pAdmin] >= 200)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*200* ADMIN *** /mole {FF0000}/scena /scenaallow /scenadisallow");
	}
	if (PlayerInfo[playerid][pAdmin] >= 1000)
	{
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /weatherall /dajdowozu /clearwlall");
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /sprzedaja /setarmor /antycheat /kickduty");
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /checkcars /refreshsalon /usunplantacje");
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /setimmunity /getimmunity /uleczall /logoutpl /zarazanie /healall /unbwall");
		SendClientMessage(playerid, COLOR_GRAD1, "{FF6A6A}* System @DUTY *** {C0C0C0}/checkadminstats [ID]");
	}
	if (PlayerInfo[playerid][pAdmin] >= 2000)
	{
		SendClientMessage(playerid, COLOR_GRAD5,"*** 2000 *** /hpall /killall /startlotto /skick /setcar");
	}
	if (PlayerInfo[playerid][pAdmin] >= 5000)
	{
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /sblock /sban /dodajweryfikacje /dajlicencje /givegun /cnnn");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /KickEx_all /bdaj /starttimer /startalltimer /killtimer /killalltimer /zniszczobiekty /stworzobiekty");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /setmats /setskin /setjob /setdom /setdomk /setwiek /setname /setstat /money /givemoney");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zrobdom /lzrobdom /usundom /blokujdom /resetsejfhasla /zapiszdomy /zapiszkonta");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /rodzinalider /scena /houseowner /domint /dajskryptera");
	}
	if (IsAHeadAdmin(playerid) || IsAScripter(playerid))
	{
		SendClientMessage(playerid, COLOR_WHITE,"*** Jeste� koxem przez X ***");
        SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zonedelay /gangzone /removezoneprotect /removeganglimit /clearzone /setzonecontrol");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /agraffiti /adajrange /antybh /dajlicencje /glosowanie /gotodom");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 **  /msgbox /restart /setarmor /setserverpass");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /showkary /startskinevent(!) /stworzobiekty /wczytajskrypt /wlsett");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zmiendom /zmienprace /zniszczobiekt /setvregistration /dnobiekt /bwset /glodset");
	}
    if(Uprawnienia(playerid, ACCESS_PANEL)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /edytuj /panel [unwarn]");
    if(Uprawnienia(playerid, ACCESS_ZG)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /dajzaufanego");
	if(Uprawnienia(playerid, ACCESS_MAKELEADER)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /agrupa lider");
    if(Uprawnienia(playerid, ACCESS_MAKEFAMILY)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /agrupa");
	if(Uprawnienia(playerid, ACCESS_MAPPER)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /mc /msel /mdel /mmat /rx /ry /rz /mcopy");
	if(IsAGameMaster(playerid)) SendClientMessage(playerid, COLOR_GRAD1, "*** GameMaster *** /spec /gm /goto /tp /globaldo /ndo");
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	return 1;
}


