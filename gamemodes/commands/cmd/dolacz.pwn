//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dolacz ]------------------------------------------------//
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
	dodano rynek pracy :)
*/

YCMD:praca(playerid, params[])
{
    new string[256];
    if(PlayerInfo[playerid][pJob] != 0) return sendTipMessage(playerid, "Posiadasz ju� prac�!");
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1498.4562,-1582.0427,13.5498))
    {
        format(string, sizeof(string), "Mechanik\nOchroniarz\nPizzaboy\nTrener boksu\nKurier\nTaks�wkarz");
        ShowPlayerDialogEx(playerid, D_JOB_CENTER_DIALOG, DIALOG_STYLE_LIST, "Kotnik-RP �� Rynek pracy", string, "Wybierz", "Anuluj");
    }
    return 1;
}

YCMD:dolacz(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 0 )
		{
		    if(PlayerInfo[playerid][pJob] == 0 )
			{
				if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1215.1304,-11.8431,1000.9219))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zosta� Prostytutk�, lecz najpierw musisz podpisa� kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowa� z tej pracy musi min�� czas kontraktu, dopiero wtedy b�dziesz m�g� si� zwolni�.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zaspokajaniu potrzeb seksualnych mieszka�c�w.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jeden z kilku wymagaj�cyh zawod�w. Nie sprowadza si� on tylko do wpisania komendy.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tutaj najwa�niejsze jest dobre odgrywanie na /me i /do, im b�dzie ono lepsze tym wy�szy zarobek.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Mimo, ze praca posiada skill nie ma on tak du�ego znaczenia. Gdy� nikt nie wynajmuje prostytutki aby doda� sobie HP.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Je�eli potrafisz dobrze odgrywa� akcje mo�esz zarobi� nawet 500k za godzin�, jednak zazwyczaj jest to 40k-70k. Pieni�dze dostajesz od klient�w.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Je�li akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 3;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,2166.3772,-1675.3829,15.0859) && IsAPrzestepca(playerid))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zosta� Dilerem Drag�w, lecz najpierw musisz podpisa� kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowa� z tej pracy musi min�� czas kontraktu, dopiero wtedy b�dziesz m�g� si� zwolni�.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Masz za zadanie odbiera� dragi z meliny i rozprowadza� je po ca�ym Los Santos, ty dyktujesz cen�.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedaj�c narkotyki nie daj sie z�apac policji kt�ra tylko czeka na okazj� by przyskrzyni� dilera.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Niestety popularno�� narkotyk�w maleje i nowy diler przy du�ym szcz�ciu zarabia ok. 7k za godzin�.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy�szy skill tym wi�cej narkotyk�w mo�esz miec przy sobie, spada te� ich cena w melinie.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Ta praca jest najlepsza dla os�b kt�re ju� s� albo aspiruj� do bycia gangsterem. To co zarobisz wyp�acamy co godzin� (w Pay Day)");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Je�li akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 4;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1109.3318,-1796.3042,16.5938))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zosta� Z�odziejem Aut, lecz najpierw musisz podpisa� kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowa� z tej pracy musi min�� czas kontraktu, dopiero wtedy b�dziesz m�g� si� zwolni�.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Twoje zadanie jest bardzo proste. Ukra�� w�z i przewie�� go w stanie nienaruszonym na statek przemytnik�w w San Fierro.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tylko niekt�re pojazdy w Los Santos mo�na ukra��. Dodatkowo przemytnicy przyjmuj� twoje �upy co 15 minut.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy�szy skill tym wi�cej dostaniesz od przemytnik�w za pojazd oraz �atwiej b�dzie ci co� zw�dzi�.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Warto r�wnie� zaparkowa� sw�j w�asny pojazd pod statkiem przemytnik�w �eby mie� czym wr�ci� do Los Santos.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Zarobki to �rednio 200k za godzin�. To co zarobisz wyp�acamy natychmiastowo.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Je�li akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 5;
				}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1366.7279,-1275.4633,13.5469) && IsADilerBroni(playerid, 0))
		  		{
		  		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zosta� Dilerem Broni, lecz najpierw musisz podpisa� kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowa� z tej pracy musi min�� czas kontraktu, dopiero wtedy b�dziesz m�g� si� zwolni�.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedajesz nielegaln� bro� tym, kt�rzy nie s� w stanie naby� jej w legalny spos�b. Praca jest nielaglna.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jednak zanim przyst�pisz do sprzeda�y musisz zdoby� zabronione w LS materia�y. To do�� skomplikowany proces.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Pakiet max. 10paczek odbierzesz w budynku ko�o wypo�yczalni aut. Fabryka w Ocean Docks przerobi je na 500 materia��w.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dopiero z materia��w mo�esz wyrabia� bro�. Im wy�szy skill tym lepsze broni znajd� sie w twojej ofercie. ");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dobry diler potrafi zarobic nawet 150k w godzin�. Jednak pocz�tkuj�cy cz�sto musz� dok�ada� do interesu. Ty pobierasz pieni�dze od klient�w.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Je�li akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 9;
		  		}
				else if(GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid, 0.0, 0.0, 0.0))
				{
					if(PlayerInfo[playerid][pCarLic] != 1)
					{
						sendTipMessage(playerid, "Do tej pracy wymagane jest prawo jazdy - Kategoria B!"); 
						return 1;
					}
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zbieraniu �mieci z teren�w Los Santos");
                    SendClientMessage(playerid, COLOR_WHITE, "   Transporcie �mieci w wyznaczone miejsca");
                    SendClientMessage(playerid, COLOR_WHITE, "   Praca jest optymalna, przynosi w miar� dobre zyski - do 3.000$ za jeden �mietnik.");
                    SendClientMessage(playerid, COLOR_WHITE, "   Atutem jest zarabianie kasy do r�ki, za odwiezienie zebranych �mieci ze �mietnik�w. ");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Je�li akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 17;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz dowodu osobistego, wyr�b go w Urz�dzie Miasta!");
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Masz ju� prac�, wpisz /quitjob aby z niej zrezygnowa� !");
		}
	}//not connected
    return 1;
}