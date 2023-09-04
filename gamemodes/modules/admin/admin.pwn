//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   admin                                                   //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System administracji.

	Zawiera komendy administratora, wywo�ywania listy administrator�w, funkcje administrator�w, 
	przydzielanie administratora, zabezpieczenia. Cz�� komend zosta�a przepisana na nowo, natomiast cz�� 
	oczekuje dalej na przepisanie. P�ki co zosta�a oddzielona od komendy.pwn i otrzyma�a sw�j w�asny plik.
	
	Funkcje:
		> AJPlayerTXD - TXD show za AJ
		> BanPlayerTXD - TXD show za Bana
		> KickPlayerTXD - TXD show za kica
		> WarnPlayerTXD - TXD show za warna
		> BlockPlayerTXD - TXD show za blocka
		>
	
	Komendy:
		> Admins - lista administrator�w na s�u�bie
		> Kary[i] txd - Kary[i]  w txd
		> check - sprawdza statystyki gracza (showstats) 
		> nonewbie - odpala/gasi chat newbie
		> dn & up - teleportuje gracza w g�r�/d�
		> usunpozar - usuwa po�ar z mapy
		> losowypozar - losowo startuje po�ar
		> unblock - unblokowuje gracza o nicku (%s)
		> gotobiz - teleportuje do biznesu o ID
		> resetsejfhasla - resetuje has�a w domach (sejfy)
		> zapiszdomy - zapisuje domy
		> zapiszkonta - zapisuje konta graczy 
		> ann - gametex for all (3) 
		> setname - ustawia graczowi o ID name (%s) 
		> spec & unspec - podgl�da gracza (kamera)
		> block - nadaje blocka dla gracza 
		> pblock - nadaje blocka offline
		> pban - nadaje bana offline
		> pwarn - nadaje warna offline
		> paj - nadaje AdminJail'a offline
		> sblock - cichy block
		> ip - sprawdza ip gracza o ID
		> czyjtonumer - sprawdza czyj to numer
		> flip - obraca pojazd do g�ry ko�ami :) 
		> snn  - text for all
		> cca & cc - czy�ci chat dla wszystkich 
		> hpall - nadaje HP dla ka�dego
		> killall - zabija ka�dego
		> podglad - ustala podgl�d dla gracza o ID
		> antybh - ustawienia antyBH
		> undemorgan - uwalnia gracza o ID z wi�zeienia
		> zaraz  zara�a gracza chorob�
		> kill - zabija gracza o ID
		> setwiek - ustala wiek dla gracza o ID
		> setjob -  ustala graczowi o ID prac� X
		> setslot - ustala liczb� slot�w dla gracza o ID
		> pojazdygracza - sprawdza pojazdy gracza o ID
		> checkcar - sprawdza do kogo nale�y pojazd X
		> checkcars - sprawdza auta gracza (GUI)
		> setcar - ustawia auto Y na slot X
		> setwl - ustawia graczowi o ID WL X
		> setskin - ustawia graczowi o ID skin X
		> naprawskin - naprawia graczowi o ID skin X
		> rozwiedz - rozwodzi gracza o ID
		> dskill - ustala skill dla broni
		> dnobiekt - obni�a obiekt (?)
		> dsus - ustawia graczowi o ID WL X
		> jump - podrzuca gracza
		> sh
		> carjump - podrzuca auto
		> ksam - w��cza podgl�d miejsca (jako kamera) 
		> fdaj - ustala styl dla gracza o ID
		> dajdowozu - teleportuje gracza o ID do wozu X
		> sprawdzinv - nwm
		> sprawdzin - sprawdza pozycje gracza (on foot, in car [..]) 
		> getposp - pobiera koordynaty gracza o ID
		> zniszczobiekty - usuwa wszystkie obiekty z serwera
		> stworzobiekty - tworzy obiekty
		> respawn - powoduje odliczanie do respawnu pojaz�w (20s)
		> dajdzwiek - odpala d�wi�k dla gracza o ID
		> crimereport - report crime's
		> respp - respawnuje gracza o ID
		> respcar - respawnuje pojazd o ID
		> unbp - zdejmuje blokad� pisania na chaty frakcyjne dla gracza o ID
		> dpa - degraduje p� admina
		> BP - nadaje blokad� pisania dla gracza o ID na czas X
		> kickallex - kickuje wszystkich graczy
		> setmats - ustawia materia�y dla gracza o ID
		> reloadbans - prze�adowuje plik z banami
		> koxubankot - nadaje administratora X dla gracza o ID
		> setcarint - ustawia pojazdowi interior (taki jaki ma obecnie gracz)
		> setcarvw - ustawia pojazdowi VirtualWorld (taki jaki ma obecnie gracz)
		> panel - panel KS
		> msgbox - wy�wietla MSG box
		> gotoczit - teleportuje na miejsce zbrodni 
		> anulujzp - anuluje zabranie prawa jazdy dla gracza o ID
		> addcar - dodaje pojazd na map� o podanym ID
		> removecar - usuwa pojazd z mapy o podanym ID
		> setac - ustawia anty-cheat'a
		> support - teleportuje do /supporty
		> supportend - przywraca star� pozycj�
		> stworz - tworzy organizacje, pojazd, rang� (wymaga uprawnie�)
		> edytuj - edytuje pojazd, organizacje, rang� (wymaga uprawnie�)
		> delete3dtext - usuwa 3dtext (nie sprawdzone)
		> deleteobject - usuwa obiekt (nie sprawdzone) 
		> scena - stawia scen�
		> scenaallow - pozwala stawia� scen� graczowi o ID
		> scenadisallow - zabiera pozwolenie dla gracza o ID do stawiania sceny
		> zrobkolejke - tworzy kolejk� 
		> gotoadmin - teleportuje na wysp� admin�w
		> gotomechy - teleportuje do mechanik�w
		> gotostacja - teleportuje na stacje paliw idle
		> rapidfly - w��cza tryb latania dla gracza
		> removeganglimit
		> removezoneprotect
		> gangzone
		> zonedelay - usuwa strefe
		> clearzone - czy�ci stref�
		> setzonecontrol - ustawia kontrol� nad stref� dla... 
		> unbw - zdejmuje BW graczowi o ID
		> bw - nadaje BW graczowi o ID
		> checkbw - informacja o czasie BW gracza
		> cziterzy - pokazuje liste os�b, kt�re AC uzna� za cziter�w 
		> restart - restartuje serwera
		> wczytajskrypt - wczytuje FS'a 
		> setmistrz - mianuje gracza o ID mistrzem bokserskim 
		> togadminmess - wy��cza wszelkie komunikaty admina
		> mole - wysy�a smsa jako marcepan
		> zg - wysy�a wiadomo�� na chacie zaufanych
		> logout - wylogowuje gracza
		> logoutpl - wylogowuje gracza o ID
		> logoutall - wylogowuje wszystkich graczy
		> cnn - wysy�a wszystkim gametext
		> cnnn - wysy�a wszystkim gametext (2)
		> demorgan - wi�zi gracza o ID
		> unaj - usuwa adminjail dla gracza o ID
		> AJ - nadaje adminjaila dla gracza o ID
		> jail - nadaje jaila dla gracza o ID (UWAGA CZAS NIELIMITOWANY!) 
		> tod - ustawia dla wszystkich godzin� X
		> startlotto - startuje lotto 
		> setstat - ustawia graczowi o ID statystyki 
		> clearwlall - czy�ci wszystkim wanted level
		> setint - nadaje graczowi o ID interior X
		> setvw - nadaje graczowi o ID virtualworld X
		> getvw - pobiera od gracza o ID virtualworld i wy�wietla adminowi
		> getint - pobiera od gracza o ID interior i wy�wietla adminowi
		> skydive - teleportuje gracza o ID w kosmos (XD)
		> dajpomocnika - nadaje p� administratora (1-3) dla gracza o ID
		> dajskryptera - nadaje skryptera dla gracza o ID
		> dajzaufanego - nadaje zaufanego dla gracza o ID
		> makeircadmin - nadaje administratora chatu IRC dla gracza o ID
		> forceskin - wymusza otworzenie wybiera�ki, gdy gracz o ID jest we frakcji
		> dajlideraorg - nadaje lidera organizacji (rodziny) dla gracza o ID X
		> makemember - nadaje stopie� [0] graczowi o ID we frakcji X
		> zabierzlideraorg - zabiera lidera organizacji (rodziny) dla gracza o ID
		> makeleader - daje graczowi o ID lidera frakcji o ID X
		> setteam - ustala "team" graczowi (raczej ju� nie u�ywane) - s� dwa cop, civilian. 
		> gotopos - teleportuje nas do pozycji X,Y,Z
		> gotols - teleportuje pod komisariat LS
		> gotolv - teleportuje pod lotnisko LV
		> gotosf - teleportuje pod dworzec san fierro
		> gotoszpital - teleportuje pod szpital w LS
		> gotosalon - teleportuje pod salon aut w LS
		> entercar - wsadza nas do wozu o ID
		> gotocar - teleportuje do auta o ID
		> mark - ustawia markera
		> gotomark - teleportuje do markera (kt�rego wcze�niej ustawili�my poprzez CMD:mark) 
		> gotojet - teleportuje na odrzutowiec
		> gotostad - teleportuje na stadion
		> gotoin - teleportuje w .. co�
		> goto - teleportuje nas do gracza X
		> gotoint - teleportuje nas do interioru X
		> tp - teleportuje gracza X do gracza Y
		> GetHere - teleportuje gracza o ID do nas
		> Getcar - teleportuje auto o ID do nas
		> tankujauto - tankuje pojedy�czy samoch�d (w kt�rym siedzimy)
		> tankujauta - tankuje samochody
		> givegun - daje graczowi o ID bro� o ID z amunicj� o warto�ci X
		> sethp - ustawia graczowi o ID podan� warto�� HP
		> setarmor - ustawia graczowi o ID podan� warto�� armour 
		> fixveh - naprawia auto
		> fixallveh - naprawia wszystkim graczom auto
		> pogodaall - ustawia podan� pogod� dla wszystkich graczy
		> money - resetuje graczowi o ID kas� do 0 i ustawia podan� warto��
		> dajkase - daje graczowi o ID kas� X
		> carslots - resetuje graczu sloty na [4] domy�lne
		> slap - daje klapsa w dupsko dla gracza o ID 
		> mute - ucisza gracza o ID
		> setplocal - ustawia pLOCAL dla gracza o ID
		> glosowanie - tworzy g�osowanie na X temat na Y czas
		> freeze - zamra�a gracza o ID
		> unfreeze - odmra�a gracza o ID
		> warn - nadaje ostrze�enie graczowi o ID
		> unwarn - zdejmuje ostrze�enie graczowi o ID
		> skick - kickuje (cichy kick) gracza o ID
		> sban - banuje (ukryty ban) gracza o ID
		> ban - banuje gracza o ID
		> kick - kickuje gracza o ID
		> banip - banuje gracza o ID
	Timery:
		> Brak
		
	Funkcje
		>IsAHeadAdmin
		>IsAScripter
		>IsAGameMaster
		>AdminCommandAcces
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
IsAHeadAdmin(playerid)
{
	if(PlayerInfo[playerid][pAdmin] == 5000)
	{
		return 1;
	}
	return 0;
}

IsAKox(playerid)
{
	if(DEVELOPMENT) return true;
	return IsAHeadAdmin(playerid);
}

IsAScripter(playerid)
{
	return Uprawnienia(playerid, ACCESS_SKRYPTER);
}

IsAGameMaster(playerid)
{
	return Uprawnienia(playerid, ACCESS_GAMEMASTER);
}

SendMessageToAdmin(text[], mColor)//Wysy�a wiadomo�� do administratora na s�u�bie
{
	foreach(new i : Player)
	{
		if(GetPlayerAdminDutyStatus(i) == 1 && (PlayerInfo[i][pAdmin] > 0 || PlayerInfo[i][pNewAP] > 0))
		{
			new stradm[256];
			format(stradm, sizeof(stradm), "%s", text);
			SendClientMessage(i, mColor, stradm);
		}
	}
	return 1;
}
SendMessageToAdminEx(text[], mColor, condition)//Wysy�a wiadomo�� do administratora za spe�nieniem warunku
{
	new stradm[256];
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pAdmin] > 0 || PlayerInfo[i][pNewAP] > 0 || IsAScripter(i) || PlayerInfo[i][pZG] >= 3)
		{
			if(condition == 1)//Warunek w��czonej widoczno�ci report�w
			{
				if(PlayerPersonalization[i][PERS_REPORT] == 0)
				{
					format(stradm, sizeof(stradm), "%s", text);
					SendClientMessage(i, mColor, stradm);
				}
			}
			else if(condition == 2)//Warunek w��czonej widoczno�ci DEATH_WARNING
			{
				if(PlayerPersonalization[i][WARNDEATH] == 0)
				{
					format(stradm, sizeof(stradm), "%s", text);
					SendClientMessage(i, mColor, stradm);
				}
			}
		}	
	}
	return 1;
}


//-----------------<[ Timery: ]>-------------------

forward StopDraw();
public StopDraw()
{
	foreach(new i : Player)
	{
		PlayerTextDrawHide(i, Kary[i]); 
	}
	KillTimer(karaTimer);
	return 1;
}


//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end