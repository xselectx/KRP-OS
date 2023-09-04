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
    if(PlayerInfo[playerid][pJob] != 0) return sendTipMessage(playerid, "Posiadasz ju¿ pracê!");
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1498.4562,-1582.0427,13.5498))
    {
        format(string, sizeof(string), "Mechanik\nOchroniarz\nPizzaboy\nTrener boksu\nKurier\nTaksówkarz");
        ShowPlayerDialogEx(playerid, D_JOB_CENTER_DIALOG, DIALOG_STYLE_LIST, "Kotnik-RP »» Rynek pracy", string, "Wybierz", "Anuluj");
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
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Prostytutk¹, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zaspokajaniu potrzeb seksualnych mieszkañców.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jeden z kilku wymagaj¹cyh zawodów. Nie sprowadza siê on tylko do wpisania komendy.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tutaj najwa¿niejsze jest dobre odgrywanie na /me i /do, im bêdzie ono lepsze tym wy¿szy zarobek.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Mimo, ze praca posiada skill nie ma on tak du¿ego znaczenia. Gdy¿ nikt nie wynajmuje prostytutki aby dodaæ sobie HP.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Je¿eli potrafisz dobrze odgrywaæ akcje mo¿esz zarobiæ nawet 500k za godzinê, jednak zazwyczaj jest to 40k-70k. Pieni¹dze dostajesz od klientów.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 3;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,2166.3772,-1675.3829,15.0859) && IsAPrzestepca(playerid))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Dilerem Dragów, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Masz za zadanie odbieraæ dragi z meliny i rozprowadzaæ je po ca³ym Los Santos, ty dyktujesz cenê.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedaj¹c narkotyki nie daj sie z³apac policji która tylko czeka na okazjê by przyskrzyniæ dilera.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Niestety popularnoœæ narkotyków maleje i nowy diler przy du¿ym szczêœciu zarabia ok. 7k za godzinê.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy¿szy skill tym wiêcej narkotyków mo¿esz miec przy sobie, spada te¿ ich cena w melinie.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Ta praca jest najlepsza dla osób które ju¿ s¹ albo aspiruj¹ do bycia gangsterem. To co zarobisz wyp³acamy co godzinê (w Pay Day)");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 4;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1109.3318,-1796.3042,16.5938))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Z³odziejem Aut, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Twoje zadanie jest bardzo proste. Ukraœæ wóz i przewieœæ go w stanie nienaruszonym na statek przemytników w San Fierro.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tylko niektóre pojazdy w Los Santos mo¿na ukraœæ. Dodatkowo przemytnicy przyjmuj¹ twoje ³upy co 15 minut.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy¿szy skill tym wiêcej dostaniesz od przemytników za pojazd oraz ³atwiej bêdzie ci coœ zwêdziæ.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Warto równie¿ zaparkowaæ swój w³asny pojazd pod statkiem przemytników ¿eby mieæ czym wróciæ do Los Santos.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Zarobki to œrednio 200k za godzinê. To co zarobisz wyp³acamy natychmiastowo.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 5;
				}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1366.7279,-1275.4633,13.5469) && IsADilerBroni(playerid, 0))
		  		{
		  		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Dilerem Broni, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedajesz nielegaln¹ broñ tym, którzy nie s¹ w stanie nabyæ jej w legalny sposób. Praca jest nielaglna.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jednak zanim przyst¹pisz do sprzeda¿y musisz zdobyæ zabronione w LS materia³y. To doœæ skomplikowany proces.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Pakiet max. 10paczek odbierzesz w budynku ko³o wypo¿yczalni aut. Fabryka w Ocean Docks przerobi je na 500 materia³ów.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dopiero z materia³ów mo¿esz wyrabiaæ broñ. Im wy¿szy skill tym lepsze broni znajd¹ sie w twojej ofercie. ");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dobry diler potrafi zarobic nawet 150k w godzinê. Jednak pocz¹tkuj¹cy czêsto musz¹ dok³adaæ do interesu. Ty pobierasz pieni¹dze od klientów.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
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
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zbieraniu œmieci z terenów Los Santos");
                    SendClientMessage(playerid, COLOR_WHITE, "   Transporcie œmieci w wyznaczone miejsca");
                    SendClientMessage(playerid, COLOR_WHITE, "   Praca jest optymalna, przynosi w miarê dobre zyski - do 3.000$ za jeden œmietnik.");
                    SendClientMessage(playerid, COLOR_WHITE, "   Atutem jest zarabianie kasy do rêki, za odwiezienie zebranych œmieci ze œmietników. ");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 17;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz dowodu osobistego, wyrób go w Urzêdzie Miasta!");
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Masz ju¿ pracê, wpisz /quitjob aby z niej zrezygnowaæ !");
		}
	}//not connected
    return 1;
}