//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zasady ]------------------------------------------------//
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

YCMD:zasady(playerid, params[], help)
{
    SendClientMessage(playerid,COLOR_P@,"|_________________Zasady ruletki i Black Jack'a_________________|");
	SendClientMessage(playerid,COLOR_WHITE,"Black Jack - gracz stara si� pokonac krupiera poprzez uzyskanie sumy najbli�szej 21pkt.");
	SendClientMessage(playerid,COLOR_WHITE,"Jednak nie nale�y przekroczy� 21pkt gdy� jest to r�wnoznaczne z przegran�.");
	SendClientMessage(playerid,COLOR_WHITE,"W przypadku uzyskania 21 pkt gracz ma tzw. 'Oczko' i automatycznie wygrywa gr�. Wszycy uczestnicy zabawy graj� przeciw krupierowi.");
	SendClientMessage(playerid,COLOR_WHITE,"Je�eli gracz ma mneij ni� 21 pkt mo�e w dowolnym momencie przesta� dobierac karty (pas) i czekac na ruch krupiera.");
	SendClientMessage(playerid,COLOR_WHITE,"Za Dam� (Q) Waleta (J) i Kr�la (K) liczymy 10pkt. As to 1pkt lub 11pkt- do wyboru. Reszta wed�ug figur.");
	SendClientMessage(playerid,COLOR_WHITE,"Ruletka- w tej grze mozna wygra� zdecydowanie naji�ksze pieni�dze. Na ruletce mozna obstawiac wiele kombinacji, im wi�ksze ryzyko tym wy�sza wygrana:");
	SendClientMessage(playerid,COLOR_WHITE,"Zak�ady niskiego ryzka (szansa 1:2): kolory, parzyste, nieparzyste, po��wki");
	SendClientMessage(playerid,COLOR_WHITE,"�rednie ryzyko: tuziny, rz�dy (szansa 1:3), cztery numery (szansa 1:9), dwie linie (sznasa 1:6), pierwsze pi�c numer�w (sznasa 1:7)");
	SendClientMessage(playerid,COLOR_WHITE,"Wysokie ryzyko: jeden numer (szansa 1:35), dwa numery (szansa 1:17), trzy numery (szansa 1:11)");
	SendClientMessage(playerid,COLOR_P@,"|_______________________>>> $Bymber Casino$ <<<_______________________|");
	return 1;
}
