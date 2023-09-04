#define DLG_NO_ACTION		1
#define DG_DESC_DELETE 		2
#define DG_DESC_ADD 		3
#define DG_DESC_USEOLD		4

opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid==4192)
	{
		if( response == 0 ) return 1;
		new dg_value = DynamicGui_GetValue(playerid, listitem);

		if( dg_value == DG_DESC_DELETE )
		{
			Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, "");
			PlayerInfo[playerid][pDesc][0] = EOS;
			sendTipMessage(playerid, "Usun��e� sw�j opis");
		}
		else if( dg_value == DG_DESC_ADD)
		{
			ShowPlayerDialogEx(playerid, 4193, DIALOG_STYLE_INPUT, "Ustaw opis postaci", "Wpisz nowy opis postaci\t", "Ok", "Wyjd�");
		}
		else if( dg_value == DG_DESC_USEOLD )
		{
			new DBResult:db_result;
			db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `uid`=%d", DynamicGui_GetDataInt(playerid, listitem)));

			new oldDesc[128];
			db_get_field_assoc(db_result, "text", oldDesc, 128);

			db_result = db_query(db_handle, sprintf("UPDATE * FROM `mru_opisy` SET `last_used`=%d WHERE `uid`=%d", gettime(), DynamicGui_GetDataInt(playerid, listitem)));

			strcopy(PlayerInfo[playerid][pDesc], oldDesc);
			
			ReColor(oldDesc);
			Attach3DTextLabelToPlayer(PlayerInfo[playerid][pDescLabel], playerid, 0.0, 0.0, -0.7);
			Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, wordwrapEx(oldDesc));
			sendTipMessage(playerid, "Ustawiono nowy opis:");
			new stropis[126];
			format(stropis, sizeof(stropis), "%s", oldDesc);
			SendClientMessage(playerid, 0xBBACCFFF, stropis);
		}
	}
	return 0;
}

#define FPANEL_MAIN			1
#define FPANEL_MANAGEP		2
#define FPANEL_MANAGEV		3
#define FPANEL_MANAGES		4
#define FPANEL_SEJF			5

#define FPANEL_PER_PAGE 	20 // ilo�� os� na stron�

#define FPANEL_DG_OSOBA		1
#define FPANEL_DG_PREV		2
#define FPANEL_DG_NEXT		3

fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	if(dialogid == 1958)
	{
		if(!response) return 1;

		switch(listitem)
		{
			case 0: factionLeaderPanel(playerid, FPANEL_MANAGEP);
			case 1: factionLeaderPanel(playerid, FPANEL_MANAGEV);
			case 2: factionLeaderPanel(playerid, FPANEL_MANAGES);
			case 3: factionLeaderPanel(playerid, FPANEL_SEJF);
		}

		return 1;
	}
	if(dialogid == 1959)
	{
		if( !response ) return factionLeaderPanel(playerid);

		switch( DynamicGui_GetValue(playerid, listitem) )
		{
			case FPANEL_DG_NEXT: showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page")+1);
			case FPANEL_DG_PREV: showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page")-1);
			case FPANEL_DG_OSOBA: 
			{
				new pracownik_uid = DynamicGui_GetDataInt(playerid, listitem);

				showEmployeeInfo(playerid, pracownik_uid);
			}
		}
	}
	if(dialogid == 1960)
	{
		if ( !response ) {
			showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
			DeletePVar(playerid, "fpanel_uid");
			return 1;
		}

    	if(listitem == 3)
    	{
    		new pracownik_nick[26];
    		strmid(pracownik_nick, MruMySQL_GetNameFromUID(GetPVarInt(playerid, "fpanel_uid")), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			if(ReturnUser(pracownik_nick) != INVALID_PLAYER_ID) {
                sendTipMessage(playerid, "Gracz jest online, u�yj /zwolnij");
                return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
            }
            if(MruMySQL_GetAccInt("Member", pracownik_nick) != PlayerInfo[playerid][pLider] ) return sendErrorMessage(playerid, "No �adne hakowanie!");
            MruMySQL_SetAccInt("Rank", pracownik_nick, 99);
            MruMySQL_SetAccInt("Member", pracownik_nick, 99);
            MruMySQL_SetAccInt("PodszywanieSie", pracownik_nick, 0);
            MruMySQL_SetAccInt("Uniform", pracownik_nick, 0);
            MruMySQL_SetAccInt("Team", pracownik_nick, 3);
            new msg[75];
            //format(msg, sizeof(msg), "Zwolni�e� %s ze swojej frakcji", pracownik_nick, FractionNames[PlayerInfo[playerid][pLider]]);
            sendTipMessage(playerid, msg, COLOR_LIGHTBLUE);
            DeletePVar(playerid, "fpanel_uid");

            return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
    	} 
    	else if(listitem == 4)
    	{

    		new fracid = PlayerInfo[playerid][pLider];
    		new typ = 0;
    		new str[512];
		    for(new i=0;i<11;i++)
		    {
		        if(strlen((typ == 0) ? (FracRang[fracid][i]) : (FamRang[fracid][i])) < 2)
		            format(str, 512, "%s[%d] -\n", str, i);
		        else
		            format(str, 512, "%s[%d] %s\n", str, i, (typ == 0) ? (FracRang[fracid][i]) : (FamRang[fracid][i]));
		    }

		    return ShowPlayerDialogEx(playerid, 1966, DIALOG_STYLE_LIST, "Wybierz rang�, kt�r� chcesz nada� graczowi", str, "Nadaj", "Anuluj");
    	}
    	else
    	{
    		new uid = GetPVarInt(playerid, "fpanel_uid");
			DeletePVar(playerid, "fpanel_uid");    		
    		return showEmployeeInfo(playerid, uid);
    	}
	}
	if(dialogid == 1966)
	{
		if( !response )
		{
			showEmployeeInfo(playerid, GetPVarInt(playerid, "fpanel_uid"));
			DeletePVar(playerid, "fpanel_uid");
			return 1;
		}
		if(strlen(FracRang[GetPlayerFraction(playerid)][listitem]) < 1) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Ta ranga nie jest stworzona!");

		new pracownik_nick[26];
    	strmid(pracownik_nick, MruMySQL_GetNameFromUID(GetPVarInt(playerid, "fpanel_uid")), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
		if(ReturnUser(pracownik_nick) != INVALID_PLAYER_ID) {
            sendTipMessage(playerid, "Gracz jest online, u�yj /dajrange");
            return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
        }
        if(MruMySQL_GetAccInt("Member", pracownik_nick) != PlayerInfo[playerid][pLider] ) return sendErrorMessage(playerid, "No �adne hakowanie!");

		new upordown[58];
		upordown = (MruMySQL_GetAccInt("Rank", pracownik_nick) <= listitem) ? "Awansowa�e�" : "Zdegradowa�e�";
		MruMySQL_SetAccInt("Rank", pracownik_nick, listitem);

		new msg[144];

		format(msg, sizeof(msg), "%s %s na rang� %s", upordown, pracownik_nick, FracRang[PlayerInfo[playerid][pLider]][listitem]);
        sendTipMessage(playerid, msg, COLOR_LIGHTBLUE);

        new uid = GetPVarInt(playerid, "fpanel_uid");
		DeletePVar(playerid, "fpanel_uid");    		
    	return showEmployeeInfo(playerid, uid);
	}
	return 0;
}

showEmployeeInfo(playerid, employeeUid)
{
	new pracownik_nick[26], rankname[26], ranga, employeestring[1100];
    new isLider;
               
    strmid(pracownik_nick, MruMySQL_GetNameFromUID(employeeUid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
    ranga = MruMySQL_GetAccInt("Rank", pracownik_nick);
    isLider = MruMySQL_GetAccInt("Lider", pracownik_nick);
    new dorangi = MruMySQL_GetAccInt("Member", pracownik_nick);

    if(isLider > 0) {
        sendTipMessage(playerid, "Dost�p do danych na temat os�b z panelem zabroniony", COLOR_LIGHTBLUE);
        return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
    }
    strmid(rankname, FracRang[dorangi][ranga], 0, 25, 26);
    format(employeestring, sizeof(employeestring), ""#KARA_STRZALKA"    �� "#KARA_TEKST"Nick: "#KARA_TEKST"%s", pracownik_nick);
    format(employeestring, sizeof(employeestring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST"Ranga: "#KARA_TEKST"%s", employeestring, rankname);
    format(employeestring, sizeof(employeestring), "%s\n ", employeestring);
    format(employeestring, sizeof(employeestring), "%s\n"#HQ_COLOR_STRZALKA"    �� {dafc10}Wyrzu� Pracownika", employeestring);  
    format(employeestring, sizeof(employeestring), "%s\n"#HQ_COLOR_STRZALKA"    �� {dafc10}Zmie� rang�", employeestring);  
    SetPVarInt(playerid, "fpanel_uid", employeeUid);
    ShowPlayerDialogEx(playerid, 1960, DIALOG_STYLE_LIST, "Panel Lidera � Zarz�dzanie Pracownikiem", employeestring, "Ok", "Wstecz");
    return 1;
}

factionLeaderPanel(playerid, page = FPANEL_MAIN)
{
	if(page == FPANEL_MAIN)
	{
		new mainstring[350];
		new ftitle[130];
		//new id = PlayerInfo[playerid][pLider];
    	format(mainstring, sizeof(mainstring), ""#KARA_TEKST"�� Zarz�dzanie pracownikami");
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"�� Zarz�dzanie pojazdami", mainstring);
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"�� Zarz�dzanie skinami", mainstring);
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"�� Zarz�dzanie sejfem", mainstring);
    	//format(ftitle, sizeof(ftitle), "%s", FractionNames[id]);
    	ShowPlayerDialogEx(playerid, 1958, DIALOG_STYLE_LIST, ftitle, mainstring, "Ok", "Wyjd�");
	}
	if(page == FPANEL_MANAGEP)
	{
		return showFactionWorkers(playerid, 1);
	}
	if(page == FPANEL_MANAGES)
	{
		sendTipMessage(playerid, "Ta opcja b�dzie dost�pna wkr�tce");
		return factionLeaderPanel(playerid);
	}
	if(page == FPANEL_MANAGEV)
	{
		sendTipMessage(playerid, "Ta opcja b�dzie dost�pna wkr�tce");
		return factionLeaderPanel(playerid);
	}
	return 1;
}


#define HELP_MAIN			0
#define HELP_TYPY_KAR 		1
#define HELP_PRZEWINIENIA	2
#define HELP_ZASADYKAR 		3
#define HELP_WHATISRP 		4
#define HELP_PROFITYFORO 	5
#define HELP_MOREHELP 		6
#define HELP_CMD			7

new opis_przewinienia[50][600];
new przewinienia[3000];

LoadPrzewinienia()
{
	new File:file = fopen("kary.mrp", io_read), line[700];
    format(przewinienia, sizeof(przewinienia), "Przewinienie\t\t\tTyp kary");
    new counter = 0;
    while(fread(file, line))
    {
        new typKary;
        new przewinienie[70];
        new typKaryStr[45];
        new opisp[600];
        sscanf(line, "p<|>s[70]ds[600]", przewinienie, typKary, opisp);
        switch(typKary) {
            case 0: typKaryStr = ""#KARA_NIEZNACZNA"Kara nieznaczna";
            case 1: typKaryStr = ""#KARA_LEKKA"Kara lekka";
            case 2: typKaryStr = ""#KARA_SREDNIA"Kara �rednia";
            case 3: typKaryStr = ""#KARA_CIEZKA"Kara ci�ka";
            case 4: typKaryStr = ""#KARA_BARDZOCIEZKA"Kara bardzo ci�ka";
            case 5: typKaryStr = ""#KARA_BANICJI"Kara banicji";
            case 6: typKaryStr = ""#KARA_SPECJALNA"Kara specjalna";
        }
        format(przewinienia, sizeof(przewinienia), "%s\n"#KARA_TEKST2"%s\t\t\t%s", przewinienia, przewinienie, typKaryStr);
        for(new i = strlen(opisp) - 1; i > -1; i--) {
            if(opisp[i] == '*') {
                opisp[i] = '\n';
            }
        }
        format(opis_przewinienia[counter], sizeof(opisp), "%s", opisp);
        counter++;
	}
}

noYsi_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 1590)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 1: ShowPodrecznik(playerid, HELP_TYPY_KAR);
			case 2: ShowPodrecznik(playerid, HELP_PRZEWINIENIA);
			case 3: ShowPodrecznik(playerid, HELP_ZASADYKAR);
			case 5: ShowPodrecznik(playerid, HELP_WHATISRP);
			case 6: ShowPodrecznik(playerid, HELP_MOREHELP);
			case 7: RunCommand(playerid, "/pomoc2", "");
			default: ShowPodrecznik(playerid);
		}
	}
	else if(dialogid == 1591)
	{
		if(!response) return ShowPodrecznik(playerid);
		ShowPodrecznik(playerid, HELP_TYPY_KAR);
	}
	else if(dialogid == 1592)
	{
		if(!response) return ShowPodrecznik(playerid);
		ShowPlayerDialogEx(playerid, 1593, DIALOG_STYLE_MSGBOX, "Opis Przewinienia", opis_przewinienia[listitem], "Ok", "");
	}
	else if(dialogid == 1593)
	{
		if(response) return ShowPodrecznik(playerid);
		else return 1;
	}
	else if(dialogid == 1594)
	{
		if(response) return ShowPodrecznik(playerid);
	}
	return 0;
}

ShowPodrecznik(playerid, page=HELP_MAIN)
{
	new mainstring[2000];
	if( page == HELP_MAIN )
	{
		format(mainstring, sizeof(mainstring), ""#KARA_TEKST"Zasady panuj�ce na serwerze");
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Typy Kar", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Przewinienia", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Zasady Nadawania Kar", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"Dla nowicjuszy", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Czym jest Role Play", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Jak uzyska� dodatkow� pomoc", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"Inne", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    �� "#KARA_TEKST2"Komendy dost�pne na serwerze", mainstring);

	    ShowPlayerDialogEx(playerid, 1590, DIALOG_STYLE_LIST, "Podr�cznik", mainstring, "Dalej", "Wyjd�");
	}	
	if( page == HELP_TYPY_KAR )
	{
		new typy_kar[500];
        format(typy_kar, sizeof(typy_kar), "Stopie�\t\t\tKara");
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_NIEZNACZNA"Kara Nieznaczna (I stopie�)\t\t\t"#KARA_TEKST2"Do 5 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_LEKKA"Kara Lekka (II stopie�)\t\t\t"#KARA_TEKST2"Do 10 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_SREDNIA"Kara �rednia (III stopie�)\t\t\t"#KARA_TEKST2"Do 20 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_CIEZKA"Kara Ci�ka (IV stopie�)\t\t\t"#KARA_TEKST2"Do 30 minut AJ, Warn", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_BARDZOCIEZKA"Kara Bardzo Ci�ka (V stopie�)\t\t\t"#KARA_TEKST2"Warn, Ban", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_SPECJALNA"Kara Specjalna\t\t\t"#KARA_TEKST2"Opisana przy przypadku", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_BANICJI"Kara Banicji\t\t\t"#KARA_TEKST2"Ban", typy_kar);
        ShowPlayerDialogEx(playerid, 1591, DIALOG_STYLE_TABLIST_HEADERS, "Typy Kar", typy_kar, "Ok", "Wr��");
	}

	if( page == HELP_PRZEWINIENIA ) 
	{
		ShowPlayerDialogEx(playerid, 1592, DIALOG_STYLE_TABLIST_HEADERS, "Przewinienia", przewinienia, "Ok", "Wr��");
	}

	if( page == HELP_ZASADYKAR )
	{
		new zasady[2000];
		format(zasady, sizeof(zasady), "1. Admin ma prawo nada� kar� tylko i wy��cznie za czynno�ci przewidziane w LKiZ oraz o wysoko�ci przewidzianej w LKiZ. \n\tZa jedn� czynno�� niezgodn� z LKiZ gracz mo�e otrzyma� tylko 1 kar�.");
        format(zasady, sizeof(zasady), "%s\n \n2. Je�eli czynno�� jest zabroniona w LKiZ, ale wykonywanie tej czynno�ci przez gracza nikomu nie przeszkadza oraz jest \n\takceptowana przez wszystkich obecnych graczy, admin mo�e si� powstrzyma� od ukarania (tylko gdy jest pewien, �e akcja nie przeszkadza �adnemu graczowi kt�ry j� widzi/s�yszy).", zasady);
        format(zasady, sizeof(zasady), "%s\n \n3. Staramy si� nadawa� kar� adekwatnie do sytuacji oraz postawy gracza", zasady);
        format(zasady, sizeof(zasady), "%s\n \n4. Obowi�zuje zakaz ��czenia warto�ci kar. Je�eli gracz pope�ni� 2 czyny do 15minut AJ oraz 1 do 30minut AJ to dajemy mu kar� maksymalnie 30 minut AJ \n\ti reszt� jego przewinie� mo�emy umie�ci� w nawiasie.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n5. Podawany pow�d musi by� czytelny i jednoznaczny, powinien wyra�nie informowa� co gracz zrobi� �le.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n6. Je�eli gracz z�o�y� skarg� na forum, stopie� kary mo�e zosta� podniesiony o 1 poziom (lub warto�� mo�e by� zwi�kszona x2 w przypadku kar specjalnych)", zasady);
        format(zasady, sizeof(zasady), "%s\n \n7. Je�eli jaka� czynno�� jest wykonywana nagminnie, pomimo upomnie� i kar, mo�na nada� warna \n\t(nawet je�eli stopie� przewinienia tego nie przewiduje) lub zwi�kszy� warto�� kary x2 lub stopie� kary o 1.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n8. Je�eli czynno�� dotyczy wielu graczy, jest wykonywana na wi�cej ni� 3 osobach, mamy prawo podnie�� stopie� kary o 1. \n\t(np. HK dla 10 = Masowe HK i kara stopnia 5)\n\tUwaga! Przy nadawaniu takiej kary administrator musi wpisa� w powodzie s�owo \"Masowe\".\n\tUwaga! Zasada dzia�a jedynie dla nast�puj�cych przewinie�: DM(i jego odmiany), DB, HK, CK, DD/CZ", zasady);
        ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Zasady", zasady, "Ok", "");
	}

	if( page == HELP_WHATISRP )
	{
		new zasady[2350];
		format(zasady, sizeof(zasady), "To odgrywanie prawdziwego �ycia w �wiecie wirtualnym. Role Play na naszym serwerze polega na kreowaniu swojej postaci i odgrywaniu prawdziwego �ycia w grze. \nOznacza to �e mo�emy pracowa� (jako policjant, mechanik czy te� p�atny morderca), kupowa� domy, samochody oraz wiele innych rzeczy.");
        format(zasady, sizeof(zasady), "%s\nOdgrywamy tak�e r�ne sytuacje, np. napady na bank, wy�cigi uliczne, sprzeda� narkotyk�w. Nasze postacie zarabiaj� pieni�dze oraz zdobywaj� umiej�tno�ci i znajomo�ci.\n\tAby gra� zgodnie z zasadami RP - po prostu wczuj si� w posta� tak, jakby� to ty ni� by�.", zasady);
        format(zasady, sizeof(zasady), "%s\nJednak na naszym podej�ciu panuje tak�e tak zwane \"Lu�ne RP\". Oznacza to, �e na naszym serwerze odgrywanie prawdziwego �ycia\n\tprzystosowuje si� do warunk�w jakie daje GTA SA i to, �e nie musimy szanowa� �ycia swojej postaci jak w�asnego.", zasady);
        format(zasady, sizeof(zasady), "%s\nW ten spos�b aby odegrywa� prawid�owo nie pytamy si� siebie w my�li - \"co bym zrobi� gdybym by� \n\tw prawdziwym �yciu\" - tylko - \"co bym zrobi� w prawdziwym �yciu gdyby prawdziwe �ycie wygl�da�o tak jak sytuacja og�lna w grze\".", zasady);
        format(zasady, sizeof(zasady), "%s\n \nAby wczu� si� w Role Play panuj�cy na serwerze, prezentujemy kr�tki rys fabularny serwera: \n ", zasady);           
        format(zasady, sizeof(zasady), "%s\nLos Santos jest miastem opanowanym przez przest�pc�w, nawet cywile chodz� po mie�cie uzbrojeni. Ka�dy walczy o swoje miejsce si�� a tych,\n\t\tkt�rzy stoj� na drodze do ich celu traktuj� seri� z ka�acha.", zasady);
        format(zasady, sizeof(zasady), "%s\nSantos to nie el dorado pokoju gdzie ludzie �yj� w zgodzie z Policj� i wszyscy po�wi�caj� si� radosnej i owocnej wsp�pracy.\n\tTo miasto, w kt�rym co drugi obywatel jest kryminalist� a na ka�dym zakr�cie mo�e czeka� ci� �mier�.", zasady);
        format(zasady, sizeof(zasady), "%s\nWi�c nie czekaj, we� sprawy w swoje r�c� i do��cz do ludzi siej�cych zam�t w Los Santos lub grup, kt�re maj� na celu uspokojenie mot�ochu i sprawienie by sprawiedliwo�� zatriumfowa�a.\n\tB�d� zosta� (nie)uczciwym pracownikiem i sta� si� najbogatszym cz�owiekiem w LS.", zasady);
        format(zasady, sizeof(zasady), "%s\n \nJak �ycie twojej postaci potoczy si� dalej, zale�y tylko i wy��cznie od ciebie! Powodzenia!", zasady);
		ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Czym jest Role Play", zasady, "Ok", ""); 
	}

	if( page == HELP_PROFITYFORO )
	{
		new zasady[900];
		format(zasady, sizeof(zasady), ""#KARA_TEKST2"Opcja\t"#KARA_BANICJI"Bez forum\t"#KARA_NIEZNACZNA"Z forum");
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Swobodna gra na serwerze\t"#KARA_NIEZNACZNA"Tak\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Branie udzia�u w �yciu spo�eczno�ci\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Do��czanie do frakcji\t"#KARA_SREDNIA"Zazwyczaj nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Dost�p do poradnik�w\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Dost�p do informacji o aktualizacjach\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n \n \n"#KARA_TEKST2"Nie czekaj! Zarejestruj si� na {FFFFFF}Kotnik-RP.pl", zasady);

        ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_TABLIST_HEADERS, "Profity posiadania konta na Forum", zasady, "Ok", ""); 
	}

	if ( page == HELP_MOREHELP )
	{
		ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Profity posiadania konta na Forum", "W celu uzyskania dodatkowej pomocy, skorzystaj z komendy /support", "Ok", ""); 	
	}

	return 1;
}




#define HQ_MAIN 	1
#define HQ_WL		2
#define HQ_ZGL		3

#define DG_SELECT_ZGL	1


hq_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	noYsi_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	if(dialogid == 1595)
	{
		if(!response) return 1;
		if(listitem == 0)
			ShowHeadquarters(playerid, HQ_WL);
		if(listitem == 1)
			ShowHeadquarters(playerid, HQ_ZGL);
	}
	if(dialogid == 1596)
	{
		if(!response) return ShowHeadquarters(playerid);
		if(IsPlayerInGroup(playerid, 1) || PlayerInfo[playerid][pLider] == 1)
		{
			new string[2500];
			if(!response) return ShowHeadquarters(playerid);

			//new szczegol;
			new dg_value = DynamicGui_GetValue(playerid, listitem), dg_data = DynamicGui_GetDataInt(playerid, listitem);

			if(response && dg_value != DG_SELECT_ZGL) return 1;

	        format(string, sizeof(string), ""#HQ_COLOR_TEKST2"Informacja o zg�oszeniu");
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_PLACEHOLDER"====================================================", string);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Tre��: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_tresc]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Godzina: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_kiedy]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Zg�osi�: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_nadal]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Obszar: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_lokacja]);
	        new statusTxt[30];
	        switch(Zgloszenie[dg_data][zgloszenie_status]) {
	            case 0: statusTxt = "Nie podj�to jeszcze decyzji";
	            case 1: statusTxt = "Akceptowane";
	            case 2: statusTxt = "Odrzucone";
	            case 3: statusTxt = "Fa�szywe";
	            case 4: statusTxt = "Wykonane";
	            case 5: statusTxt = "Anulowane";
	        }
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Status: "#HQ_COLOR_TEKST2"%s", string, statusTxt);
	        format(string, sizeof(string), "%s\n ", string);
	        if(Zgloszenie[dg_data][zgloszenie_status] == 1) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Przyj��: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
	            if(!strcmp(Zgloszenie[dg_data][zgloszenie_przyjal], GetNick(playerid))) {
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"Oznacz jako: WYKONANE", string);
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"Oznacz jako: FA�SZYWE", string);    
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ANULOWANE"Oznacz jako: ANULOWANE", string);
	            }
	        } else if(Zgloszenie[dg_data][zgloszenie_status] == 0) {
	            format(string, sizeof(string), "%s\n ", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"Akceptuj zg�oszenie", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"Odrzu� zg�oszenie", string);    
	        } else if(Zgloszenie[dg_data][zgloszenie_status] == 2) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Odrzuci�: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
	        } else {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Wyda� decyzj�: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
			}

			SetPVarInt(playerid, "zarzadzajZgl", dg_data);

			ShowPlayerDialogEx(playerid, 1597, DIALOG_STYLE_LIST, "Szczeg�y Zgloszenia", string, "Wybierz", "Wr��");
		}
		if(IsPlayerInGroup(playerid, 3) || PlayerInfo[playerid][pLider] == 3)
		{
			new string[2500];
			if(!response) return ShowHeadquarters(playerid);

			//new szczegol;
			new dg_value = DynamicGui_GetValue(playerid, listitem), dg_data = DynamicGui_GetDataInt(playerid, listitem);

			if(response && dg_value != DG_SELECT_ZGL) return 1;

	        format(string, sizeof(string), ""#HQ_COLOR_TEKST2"Informacja o zg�oszeniu");
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_PLACEHOLDER"====================================================", string);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Tre��: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_tresc]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Godzina: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_kiedy]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Zg�osi�: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_nadal]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Obszar: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_lokacja]);
	        new statusTxt[30];
	        switch(ZgloszenieSasp[dg_data][zgloszenie_status]) {
	            case 0: statusTxt = "Nie podj�to jeszcze decyzji";
	            case 1: statusTxt = "Akceptowane";
	            case 2: statusTxt = "Odrzucone";
	            case 3: statusTxt = "Fa�szywe";
	            case 4: statusTxt = "Wykonane";
	            case 5: statusTxt = "Anulowane";
	        }
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Status: "#HQ_COLOR_TEKST2"%s", string, statusTxt);
	        format(string, sizeof(string), "%s\n ", string);
	        if(ZgloszenieSasp[dg_data][zgloszenie_status] == 1) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Przyj��: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
	            if(!strcmp(ZgloszenieSasp[dg_data][zgloszenie_przyjal], GetNick(playerid))) {
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"Oznacz jako: WYKONANE", string);
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"Oznacz jako: FA�SZYWE", string);    
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ANULOWANE"Oznacz jako: ANULOWANE", string);
	            }
	        } else if(ZgloszenieSasp[dg_data][zgloszenie_status] == 0) {
	            format(string, sizeof(string), "%s\n ", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"Akceptuj zg�oszenie", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"Odrzu� zg�oszenie", string);    
	        } else if(ZgloszenieSasp[dg_data][zgloszenie_status] == 2) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Odrzuci�: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
	        } else {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Wyda� decyzj�: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
			}

			SetPVarInt(playerid, "zarzadzajZgl", dg_data);

			ShowPlayerDialogEx(playerid, 1597, DIALOG_STYLE_LIST, "Szczeg�y Zgloszenia", string, "Wybierz", "Wr��");
		}
	}
	if(dialogid == 1597)
	{
		if(!response) return ShowHeadquarters(playerid);
		if(IsPlayerInGroup(playerid, 1) || PlayerInfo[playerid][pLider] == 1)
		{
			new szczegol = GetPVarInt(playerid, "zarzadzajZgl");
	        if(listitem == 9)
	        {
	            new zglstatus = Zgloszenie[szczegol][zgloszenie_status];
	            if(zglstatus == 0)
	            {
	                if(!strcmp(Zgloszenie[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg�osze� nie mo�na akceptowa�!");
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                Zgloszenie[szczegol][zgloszenie_status] = 1;
	            }
	            else
	            { 
	                Zgloszenie[szczegol][zgloszenie_status] = 4;
	            }
	        } else if (listitem == 10) {
	            new zglstatus = Zgloszenie[szczegol][zgloszenie_status];
	            if(zglstatus == 0) {
	                if(!strcmp(Zgloszenie[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg�osze� nie mo�na odrzuca�!");
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                Zgloszenie[szczegol][zgloszenie_status] = 2;
	            } else {
	                Zgloszenie[szczegol][zgloszenie_status] = 3;
	            }
	        } else if(listitem == 11) {
	            Zgloszenie[szczegol][zgloszenie_status] = 5;
	        }
	        ShowHeadquarters(playerid, HQ_ZGL);
    	}
    	if(IsPlayerInGroup(playerid, 3) || PlayerInfo[playerid][pLider] == 3)
		{
			new szczegol = GetPVarInt(playerid, "zarzadzajZgl");
	        if(listitem == 9)
	        {
	            new zglstatus = ZgloszenieSasp[szczegol][zgloszenie_status];
	            if(zglstatus == 0)
	            {
	                if(!strcmp(ZgloszenieSasp[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg�osze� nie mo�na akceptowa�!");
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 1;
	            }
	            else
	            { 
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 4;
	            }
	        } else if (listitem == 10) {
	            new zglstatus = ZgloszenieSasp[szczegol][zgloszenie_status];
	            if(zglstatus == 0) {
	                if(!strcmp(ZgloszenieSasp[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg�osze� nie mo�na odrzuca�!");
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 2;
	            } else {
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 3;
	            }
	        } else if(listitem == 11) {
	            ZgloszenieSasp[szczegol][zgloszenie_status] = 5;
	        }
	        ShowHeadquarters(playerid, HQ_ZGL);
    	}
	}
	return 0;
}


ShowHeadquarters(playerid, page=HQ_MAIN)
{
	if(page == HQ_MAIN)
	{
		new string[256];
		format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Lista poszukiwanych", string);
        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"Ostatnie zg�oszenia", string);

  		ShowPlayerDialogEx(playerid, 1595, DIALOG_STYLE_LIST, "HeadQuarters/MDC", string, "Ok", "Wyjd�");
	}
	if(page == HQ_WL)
	{
		RunCommand(playerid, "/wanted", "");
		return ShowHeadquarters(playerid);
	}
	if(page == HQ_ZGL)
	{
		DynamicGui_Init(playerid);
		new string[1200] = "";
		format(string, sizeof(string), "");
		if(IsPlayerInGroup(playerid, 1) || PlayerInfo[playerid][pLider] == 1)
		{
			for(new i = 0, j=OSTATNIE_ZGLOSZENIA; i<j; i++) {
		        if(Zgloszenie[i][zgloszenie_status] == 0) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"%s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 1) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"%s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 2) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"[Odrzucone] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 3) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_FALSZYWE"[Fa�szywe] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 4) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_WYKONANE"[Wykonane] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 5) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ANULOWANE"[Anulowane] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
		        }
	        	DynamicGui_AddRow(playerid, DG_SELECT_ZGL, i);
        	}
        	ShowPlayerDialogEx(playerid, 1596, DIALOG_STYLE_LIST, ("Ostatnie zg�oszenia"), string, "Ok", "Wstecz");
		}
		if(IsPlayerInGroup(playerid, 3) || PlayerInfo[playerid][pLider] == 3)
		{
	        for(new i = 0, j=OSTATNIE_ZGLOSZENIASASP; i<j; i++) {
		        if(ZgloszenieSasp[i][zgloszenie_status] == 0) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_TEKST"%s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 1) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_AKCEPTOWANE"%s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 2) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ODRZUCONE"[Odrzucone] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 3) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_FALSZYWE"[Fa�szywe] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 4) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_WYKONANE"[Wykonane] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 5) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    �� "#HQ_COLOR_ANULOWANE"[Anulowane] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
		        }
		        DynamicGui_AddRow(playerid, DG_SELECT_ZGL, i);
	        }
	        ShowPlayerDialogEx(playerid, 1596, DIALOG_STYLE_LIST, ("Ostatnie zg�oszenia"), string, "Ok", "Wstecz");
    	}
	}
	return 1;
}
