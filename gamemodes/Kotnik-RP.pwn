
//-----------------------------------------[Mapa Kotnik Role Play]-----------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//---------------------------------(Stworzona na podstawie mapy The Godfather)-------------------------------//
//-------------------------------------------------(v2.6)----------------------------------------------------//
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
/*
 / dupa / kupa
Kotnik Role Play ----> stworzy³ Mrucznik
	Inni developerzy:
		Kubi - zwyk³y skurwysyn
		Akil - chyba nic nie zrobi³ koniec koñców
		Veroon - porobi³ porobi³ i uciek³ :(
		Niceczlowiek - okry³ siê hañb¹ publikuj¹c mapê
		PECET - dobry skrypter
		LukeSqly - Niby coœ zacz¹³, ale wysz³o jak zwykle
		Simeone - Kox przez x
		Creative - mo¿liwe ¿e coœ potrafi
		Sanda³ - skleci³ modu³ animacji
		xSeLeCTx - odpali³ skrypt
		Dawidoskyy - chuja zrobil
		AnakinEU - kox przez duze X

*/
//----------------------------------------------------*------------------------------------------------------//

#pragma compress 0

//const correctness off - how to fix: https://github.com/pawn-lang/YSI-Includes/commit/ab75ea38987e6a7935aa3100eba5284cb3d706e1
#pragma warning disable 239
#pragma warning disable 214
#pragma warning disable 213

#define AMX_OLD_CALL

//-------------------------------------------<[ Biblioteki ]>------------------------------------------------//
//-						                                                                                    -//
#include <a_samp>
#define FIX_ispacked 0 
#define FIX_OnPlayerEnterVehicle 0
#define FIX_OnPlayerEnterVehicle_2 0
#define FIX_OnPlayerEnterVehicle_3 0
#define FIX_BypassDialog 0
#define FIX_TogglePlayerControllable 0


#include <fixes>


//-------<[ Pluginy ]>-------
#include <windosi>
#include <crashdetect>
#include <log-plugin>
#include <sscanf2>
#include <libRegEx>
#include <streamer>
#include <mysql_R5>
//#include <a_mysql>
#include <whirlpool>
#include <samp_bcrypt>
#include <timestamptodate>
#include <discord-connector>
#include <memory>
//#include <profiler>
// actors https://github.com/Dayrion/actor_plus
// #include <PawnPlus>
// #include <requests>
#include <colandreas>

//-------<[ Include ]>-------
#include <a_http>
#include <strlib_fix>
#include <callbacks>
#include <utils>
#define YSI_NO_MASTER
#include <YSI_Data\y_iterate>
#include <YSI_Coding\y_va>
#define Y_COMMANDS_USE_CHARS
#define MAX_COMMANDS 2400
#include <YSI_Visual\y_commands>
#include <YSI_Players\y_groups>
#include <YSI_Coding\y_hooks>
#include <YSI_Data\y_bintree>
#include <YSI_Core\y_master>
#include <YSI_Core\y_als>
#include <YSI_Coding\y_timers>
//#include <indirection>
#include <amx_assembly\addressof>

//#include <zmeczenie>

//redefinition from y_playerarray.inc
#undef PlayerArray 
#include <sort-inline>
#include <fakekill>

//nex-ac settings
#define AC_MAX_CONNECTS_FROM_IP		3
#define AUTOSAVE_SETTINGS_IN_CONFIG true
#define AC_USE_TUNING_GARAGES false
#define AC_USE_PICKUP_WEAPONS false
#define AC_USE_AMMUNATIONS false
#define AC_USE_RESTAURANTS false
#define AC_USE_CASINOS false
#define AC_USE_NPC true

#include <Pawn.RakNet.inc>
#include <nex-ac>
#include <SKY>
#include <weapon-config>	
#include <md5>
#include <progress2>
#include <double-o-files2>
#include <dialogs>
#include <fadescreen>
#include <timestamp>
#include <systempozarow>   //System Po¿arów v0.1 by PECET
#include <true_random>
#include <PreviewModelDialog>
#include <vector>
#include <map>
#include <mapfix>
#include <chrono>
#include <filemanager>
#include <VehiclePartPosition>


//--------------------------------------<[ G³ówne ustawienia ]>----------------------------------------------//
//-                                                                                                         -//
#include "VERSION.pwn"
#define DEBUG_MODE 0 //1- DEBUG_MODE ON | 0- DEBUG_MODE OFF
#define RESOURCES_LINK "LINK DO MODELI"
//#define RESOURCES_LINK "http://kotnik-rp.pl/downloads/"
#if !defined gpci
native gpci (playerid, serial [], len);
#endif

//-----------------------------------------<[ Modu³y mapy ]>-------------------------------------------------//
//-                                                                                                         -//
// #include "26modules\modules.pwn"

//-------<[ System ]>-------
#include "system\definicje.pwn"
#include "system\ceny.pwn"
#include "system\kolory.pwn"
#include "system\forward.pwn"
#include "system\textdraw.pwn"
#include "system\enum.pwn"
#include "system\zmienne.pwn"

//do implementacji w g³ówny kod (mo¿liwie w modu³y)
#include "system\doimplementacji\vinylscript.pwn"

//-------<[ Niceczlowiek ]>-------
#include "old_modules\niceczlowiek\general.pwn"
#include "old_modules\niceczlowiek\dynamicgui.pwn"
#include "old_modules\niceczlowiek\noysi.pwn"
#include "old_modules\niceczlowiek\wybieralka.pwn"

//-------<[ mrpac ]>-------
//#include "modules\mrpac\mrpac.def"
//#include "modules\mrpac\mrpac.hwn"
//#include "modules\mrpac\mrpac_callbacks.pwn"
//#include "modules\mrpac\mrpac.pwn"
//#include "modules\mrpac\commands\mrpac_commands.pwn"
//#include "modules\mrpac\mrpac_timers.pwn"

//-------<[ TEXTDRAW ]>-------
new InfoWyswietla[MAX_PLAYERS], Text:TextDrawInfo[MAX_PLAYERS];
new Text:TextDrawEXP[MAX_PLAYERS];

//-------<[ 3.0 style ]>-------
#include "modules\modules.pwn"

//-------<[ MySQL ]>-------
#include "mysql\mru_mysql.pwn"
#include "mysql\mysql_komendy.pwn"
#include "mysql\mysql_noysi.pwn"
#include "mysql\mysql_OnDialogResponse.pwn"


/*
#include "modules\ActorSystem\actors.pwn"
#include "modules\ActorSystem\actors.hwn"
#include "modules\ActorSystem\actors.def"
*/
//-------<[ Inne ]>-------
#include "old_modules\inne\ibiza.inc"
#include "old_modules\inne\external.pwn"
//-------<[ Funkcje ]>-------
#include "system\funkcje.pwn"

//-------<[ Timery ]>-------
#include "system\timery.pwn"

//-------<[ Obiekty ]>-------
#include "obiekty\obiekty.pwn"
#include "obiekty\pickupy.pwn"
#include "obiekty\3dtexty.pwn"
#include "obiekty\ikony.pwn"
#include "obiekty\actorsOnWorld.pwn"


//-------<[ Komendy ]>-------
#include "commands\commands.pwn"

//-------<[ Dialogi ]>-------
#include "dialogs\OnDialogResponse.pwn"

new Iterator:KilledBy[MAX_PLAYERS]<100>;

//------------------------------------------------------------------------------------------------------
main()
{
	print("\n----------------------------------");
	print("K | ---  Kotnik Role Play  --- | K");
	print("O | ---        ****        --- | O");
	print("T | ---        v4.0        --- | T");
	print("N | ---        ****        --- | N");
	print("I | ---    by Mrucznik     --- | I");
	print("K | ---                    --- | K");
	print("  | ---       /\\_/\\      --- | ");
	print("R | ---   ===( *.* )===    --- | R");
	print("P | ---       \\_^_/       --- | P");
	print("  | ---         |          --- | ");
	print("  | ---         O          --- | ");
	print("----------------------------------\n");
	
	AntiDeAMX(); // Can't touch this

}
//------------------------------------------------------------------------------------------------------

//---------------------------<[  Callbacks   ]>--------------------------------------------------

public OnGameModeInit()
{
	Iter_Init(KilledBy);
	//-------<[ Debug check ]>-------
	if(IsAProductionServer())
	{
		strcat(ServerSecret, dini_Get("production.info", "secret"));
		if(isnull(ServerSecret)) {
			strcat(ServerSecret, "0vw954jtw598t9d");
		}
		#if DEBUG_MODE == 1
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		SendRconCommand("exit");
		return 0;
		#endif
	}
	else
	{
		DEVELOPMENT = true;
		strcat(ServerSecret, "0tw954jtw598t9d");
	}

	//-------<[ Anty DeAMX ]>-------
	AntiDeAMX(); // Hammer time

	//-------<[ SAMP config ]>-------
	SetGameModeText("Kotnik Role Play "VERSION);

	//-------<[ Gameplay config ]>-------
	SetTimer("UpdateNametag", 500, true); // So we're using a timer, change the interval to what you want
    SetWeatherEx(3);
	AllowInteriorWeapons(1); //broñ w intkach
	ShowPlayerMarkers(0); //wy³¹czenie markerów graczy
	DisableInteriorEnterExits(); //wy³¹czenie wejœæ do intków z GTA
	EnableStuntBonusForAll(0); //brak hajsu za stunty
	ManualVehicleEngineAndLights(); //brak automatycznego w³¹czania silnika i œwiate³
	ShowNameTags(1); //Pokazywanie nicków graczy
	SetNameTagDrawDistance(50.0); //Wyœwietlanie nicków od 45 metrów
	//UsePlayerPedAnims(); // Animacja CJ 
		// - off (broñ trzymana w obu rêkach jest trzymana jedn¹, skiny chodz¹ swoim chodem)
		// - on  (broñ trzymana jest normalnie, wszystkie skiny chodz¹ jak CJ)

	//-------<[ libRegEx ]>-------
	regex_syntax(SYNTAX_PERL);
	
	//-------<[ sscanf ]>-------
	SSCANF_Option(OLD_DEFAULT_NAME, 1);

	//-------<[ streamer ]>-------
    Streamer_SetVisibleItems(0, 999);
    Streamer_SetTickRate(50);
	
	DisableCrashDetectLongCall();

	//-------<[ MySQL ]>-------
	MruMySQL_Connect();//mysql
    //----------[GUNSHOP]--------
	SetTimer ( "Check2", 300, 1 );
	Textdraw[0] = TextDrawCreate(129.000000, 115.000000, "      ");
	TextDrawBackgroundColor(Textdraw[0], 255);
	TextDrawFont(Textdraw[0], 1);
	TextDrawLetterSize(Textdraw[0], 0.500000, 1.000000);
	TextDrawColor(Textdraw[0], -1);
	TextDrawSetOutline(Textdraw[0], 0);
	TextDrawSetProportional(Textdraw[0], 1);
	TextDrawSetShadow(Textdraw[0], 1);
	TextDrawUseBox(Textdraw[0], 1);
	TextDrawBoxColor(Textdraw[0], 156);
	TextDrawTextSize(Textdraw[0], 0.000000, 0.000000);

	Textdraw[1] = TextDrawCreate(11.000000, 120.000000, "Uzyj ~r~ ENTER~w~~n~aby wyswietlic te bron");
	TextDrawBackgroundColor(Textdraw[1], 255);
	TextDrawFont(Textdraw[1], 2);
	TextDrawLetterSize(Textdraw[1], 0.160000, 1.500000);
	TextDrawColor(Textdraw[1], -1);
	TextDrawSetOutline(Textdraw[1], 0);
	TextDrawSetProportional(Textdraw[1], 1);
	TextDrawSetShadow(Textdraw[1], 1);

	Textdraw[2] = TextDrawCreate(551.000000, 141.000000, "                    ");
	TextDrawBackgroundColor(Textdraw[2], 255);
	TextDrawFont(Textdraw[2], 1);
	TextDrawLetterSize(Textdraw[2], 0.500000, 1.000000);
	TextDrawColor(Textdraw[2], -1);
	TextDrawSetOutline(Textdraw[2], 0);
	TextDrawSetProportional(Textdraw[2], 1);
	TextDrawSetShadow(Textdraw[2], 1);
	TextDrawUseBox(Textdraw[2], 1);
	TextDrawBoxColor(Textdraw[2], 170);
	TextDrawTextSize(Textdraw[2], 441.000000, 0.000000);

	Textdraw[3] = TextDrawCreate(472.000000, 170.000000, "Kupuje");
	TextDrawBackgroundColor(Textdraw[3], 255);
	TextDrawFont(Textdraw[3], 1);
	TextDrawLetterSize(Textdraw[3], 0.390000, 1.400000);
	TextDrawColor(Textdraw[3], -1);
	TextDrawSetOutline(Textdraw[3], 0);
	TextDrawSetProportional(Textdraw[3], 1);
	TextDrawSetShadow(Textdraw[3], 1);
	TextDrawUseBox(Textdraw[3], 1);
	TextDrawBoxColor(Textdraw[3], 255);
	TextDrawTextSize(Textdraw[3], 516.000000, 20.000000);
	TextDrawSetSelectable(Textdraw[3],true);

	Textdraw[4] = TextDrawCreate(462.000000, 253.000000, "Anuluje");
	TextDrawBackgroundColor(Textdraw[4], 255);
	TextDrawFont(Textdraw[4], 1);
	TextDrawLetterSize(Textdraw[4], 0.390000, 1.400000);
	TextDrawColor(Textdraw[4], -1);
	TextDrawSetOutline(Textdraw[4], 0);
	TextDrawSetProportional(Textdraw[4], 1);
	TextDrawSetShadow(Textdraw[4], 1);
	TextDrawUseBox(Textdraw[4], 1);
	TextDrawBoxColor(Textdraw[4], 255);
	TextDrawTextSize(Textdraw[4], 528.000000, 20.000000);
	TextDrawSetSelectable(Textdraw[4],true);

	Textdraw[5] = TextDrawCreate(545.000000, 141.000000, ".");
	TextDrawBackgroundColor(Textdraw[5], 255);
	TextDrawFont(Textdraw[5], 1);
	TextDrawLetterSize(Textdraw[5], -10.000000, 0.599999);
	TextDrawColor(Textdraw[5], 16711935);
	TextDrawSetOutline(Textdraw[5], 1);
	TextDrawSetProportional(Textdraw[5], 1);

	Textdraw[6] = TextDrawCreate(549.000000, 299.000000, ".");
	TextDrawBackgroundColor(Textdraw[6], 255);
	TextDrawFont(Textdraw[6], 1);
	TextDrawLetterSize(Textdraw[6], -10.000000, 0.599999);
	TextDrawColor(Textdraw[6], 16711935);
	TextDrawSetOutline(Textdraw[6], 1);
	TextDrawSetProportional(Textdraw[6], 0);

	Textdraw[7] = TextDrawCreate(476.000000, 212.000000, "");
	TextDrawBackgroundColor(Textdraw[7], 255);
	TextDrawFont(Textdraw[7], 2);
	TextDrawLetterSize(Textdraw[7], 0.129999, 1.000000);
	TextDrawColor(Textdraw[7], 16711935);
	TextDrawSetOutline(Textdraw[7], 1);
	TextDrawSetProportional(Textdraw[7], 1);
	
	Textdraw[8] = TextDrawCreate(565.000000, 315.000000, "    ");
	TextDrawBackgroundColor(Textdraw[8], 255);
	TextDrawFont(Textdraw[8], 1);
	TextDrawLetterSize(Textdraw[8], 0.500000, 1.000000);
	TextDrawColor(Textdraw[8], -1);
	TextDrawSetOutline(Textdraw[8], 0);
	TextDrawSetProportional(Textdraw[8], 1);
	TextDrawSetShadow(Textdraw[8], 1);
	TextDrawUseBox(Textdraw[8], 1);
	TextDrawBoxColor(Textdraw[8], 170);
	TextDrawTextSize(Textdraw[8], 429.000000, 121.000000);

	for(new x = 0; x < MAX_PLAYERS; x++) {
		Preis[x] = TextDrawCreate(444.000000, 323.000000, "~b~Cena:~w~ 1000 $");
		TextDrawBackgroundColor(Preis[x], 255);
		TextDrawFont(Preis[x], 1);
		TextDrawLetterSize(Preis[x], 0.500000, 1.000000);
		TextDrawColor(Preis[x], -1);
		TextDrawSetOutline(Preis[x], 0);
		TextDrawSetProportional(Preis[x], 1);
		TextDrawSetShadow(Preis[x], 1);
	}

	//nowy licznik 4.1
	SpeedometerTD[12] = TextDrawCreate(629.349609, 313.583374, "usebox");
	TextDrawLetterSize(SpeedometerTD[12], 0.000000, 12.430576);
	TextDrawTextSize(SpeedometerTD[12], 493.226806, 0.000000);
	TextDrawAlignment(SpeedometerTD[12], 1);
	TextDrawColor(SpeedometerTD[12], 0);
	TextDrawUseBox(SpeedometerTD[12], true);
	TextDrawBoxColor(SpeedometerTD[12], -1734830070);
	TextDrawSetShadow(SpeedometerTD[12], 0);
	TextDrawSetOutline(SpeedometerTD[12], 0);
	TextDrawFont(SpeedometerTD[12], 0);



	SpeedometerTD[0] = TextDrawCreate(628.466369, 352.420288, "usebox");
	TextDrawLetterSize(SpeedometerTD[0], 0.000000, 7.839833);
	TextDrawTextSize(SpeedometerTD[0], 495.124084, 0.000000);
	TextDrawAlignment(SpeedometerTD[0], 1);
	TextDrawColor(SpeedometerTD[0], 0);
	TextDrawUseBox(SpeedometerTD[0], true);
	TextDrawBoxColor(SpeedometerTD[0], 50);
	TextDrawSetShadow(SpeedometerTD[0], 0);
	TextDrawSetOutline(SpeedometerTD[0], 0);
	TextDrawBackgroundColor(SpeedometerTD[0], 0x00000000);
	TextDrawFont(SpeedometerTD[0], 0);

	SpeedometerTD[1] = TextDrawCreate(628.466369, 333.434844, "usebox");
	TextDrawLetterSize(SpeedometerTD[1], 0.000000, 1.379463);
	TextDrawTextSize(SpeedometerTD[1], 495.124084, 0.000000);
	TextDrawAlignment(SpeedometerTD[1], 1);
	TextDrawColor(SpeedometerTD[1], 0);
	TextDrawUseBox(SpeedometerTD[1], true);
	TextDrawBoxColor(SpeedometerTD[1], 50);
	TextDrawSetShadow(SpeedometerTD[1], 0);
	TextDrawSetOutline(SpeedometerTD[1], 0);
	TextDrawBackgroundColor(SpeedometerTD[1], 0x00000000);
	TextDrawFont(SpeedometerTD[1], 0);

	SpeedometerTD[2] = TextDrawCreate(628.466369, 314.934814, "usebox");
	TextDrawLetterSize(SpeedometerTD[2], 0.000000, 1.379463);
	TextDrawTextSize(SpeedometerTD[2], 495.124084, 0.000000);
	TextDrawAlignment(SpeedometerTD[2], 1);
	TextDrawColor(SpeedometerTD[2], 0);
	TextDrawUseBox(SpeedometerTD[2], true);
	TextDrawBoxColor(SpeedometerTD[2], 50);
	TextDrawSetShadow(SpeedometerTD[2], 0);
	TextDrawSetOutline(SpeedometerTD[2], 0);
	TextDrawBackgroundColor(SpeedometerTD[2], 0x00000000);
	TextDrawFont(SpeedometerTD[2], 0);

	SpeedometerTD[3] = TextDrawCreate(502.736785, 395.892578, "-----------");
	TextDrawLetterSize(SpeedometerTD[3], 0.789331, 4.034962);
	TextDrawAlignment(SpeedometerTD[3], 1);
	TextDrawColor(SpeedometerTD[3], -253);
	TextDrawSetShadow(SpeedometerTD[3], -1);
	TextDrawSetOutline(SpeedometerTD[3], 0);
	TextDrawBackgroundColor(SpeedometerTD[3], 64);
	TextDrawFont(SpeedometerTD[3], 1);
	TextDrawSetProportional(SpeedometerTD[3], 1);

	SpeedometerTD[4] = TextDrawCreate(502.736785, 336.170257, "-----------");
	TextDrawLetterSize(SpeedometerTD[4], 0.789331, 4.034962);
	TextDrawAlignment(SpeedometerTD[4], 1);
	TextDrawColor(SpeedometerTD[4], -253);
	TextDrawSetShadow(SpeedometerTD[4], -1);
	TextDrawSetOutline(SpeedometerTD[4], 0);
	TextDrawBackgroundColor(SpeedometerTD[4], 64);
	TextDrawFont(SpeedometerTD[4], 1);
	TextDrawSetProportional(SpeedometerTD[4], 1);

	SpeedometerTD[5] = TextDrawCreate(570.277282, 385.961151, "km/h");
	TextDrawLetterSize(SpeedometerTD[5], 0.209665, 1.023408);
	TextDrawAlignment(SpeedometerTD[5], 3);
	TextDrawColor(SpeedometerTD[5], -141);
	TextDrawSetShadow(SpeedometerTD[5], 0);
	TextDrawSetOutline(SpeedometerTD[5], 0);
	TextDrawBackgroundColor(SpeedometerTD[5], 51);
	TextDrawFont(SpeedometerTD[5], 1);
	TextDrawSetProportional(SpeedometerTD[5], 1);


	SpeedometerTD[6] = TextDrawCreate(570.638610, 396.916809, "km");
	TextDrawLetterSize(SpeedometerTD[6], 0.209665, 1.023408);
	TextDrawAlignment(SpeedometerTD[6], 3);
	TextDrawColor(SpeedometerTD[6], -141);
	TextDrawSetShadow(SpeedometerTD[6], 0);
	TextDrawSetOutline(SpeedometerTD[6], 0);
	TextDrawBackgroundColor(SpeedometerTD[6], 51);
	TextDrawFont(SpeedometerTD[6], 1);
	TextDrawSetProportional(SpeedometerTD[6], 1);

	SpeedometerTD[7] = TextDrawCreate(566.611267, 338.903747, "PreviewModel");
	TextDrawLetterSize(SpeedometerTD[7], 0.000000, 0.000000);
	TextDrawTextSize(SpeedometerTD[7], 63.666625, 100.799987);
	TextDrawAlignment(SpeedometerTD[7], 1);
	TextDrawColor(SpeedometerTD[7], -1768515841);
	TextDrawSetShadow(SpeedometerTD[7], 0);
	TextDrawSetOutline(SpeedometerTD[7], 0);
	TextDrawBackgroundColor(SpeedometerTD[7], 0x00000000);
	TextDrawFont(SpeedometerTD[7], 5);
	TextDrawSetPreviewModel(SpeedometerTD[7], 19786);
	TextDrawSetPreviewRot(SpeedometerTD[7], 180.000000, 0.000000, 0.000000, 1.000000);

	SpeedometerTD[8] = TextDrawCreate(518.205627, 335.590667, "PALIWO:");
	TextDrawLetterSize(SpeedometerTD[8], 0.135332, 0.824293);
	TextDrawAlignment(SpeedometerTD[8], 3);
	TextDrawColor(SpeedometerTD[8], -141);
	TextDrawSetShadow(SpeedometerTD[8], 0);
	TextDrawSetOutline(SpeedometerTD[8], 0);
	TextDrawBackgroundColor(SpeedometerTD[8], 51);
	TextDrawFont(SpeedometerTD[8], 2);
	TextDrawSetProportional(SpeedometerTD[8], 1);

	SpeedometerTD[9] = TextDrawCreate(527.916503, 303.559234, "---------");
	TextDrawLetterSize(SpeedometerTD[9], 0.671666, 6.362071);
	TextDrawAlignment(SpeedometerTD[9], 1);
	TextDrawColor(SpeedometerTD[9], -253);
	TextDrawSetShadow(SpeedometerTD[9], -1);
	TextDrawSetOutline(SpeedometerTD[9], 0);
	TextDrawBackgroundColor(SpeedometerTD[9], 96);
	TextDrawFont(SpeedometerTD[9], 1);
	TextDrawSetProportional(SpeedometerTD[9], 1);

	SpeedometerTD[10] = TextDrawCreate(527.583312, 286.060913, "---------");
	TextDrawLetterSize(SpeedometerTD[10], 0.671666, 6.362071);
	TextDrawAlignment(SpeedometerTD[10], 1);
	TextDrawColor(SpeedometerTD[10], -253);
	TextDrawSetShadow(SpeedometerTD[10], -1);
	TextDrawSetOutline(SpeedometerTD[10], 0);
	TextDrawBackgroundColor(SpeedometerTD[10], 96);
	TextDrawFont(SpeedometerTD[10], 1);
	TextDrawSetProportional(SpeedometerTD[10], 1);

	SpeedometerTD[11] = TextDrawCreate(525.296569, 317.924041, "stan:");
	TextDrawLetterSize(SpeedometerTD[11], 0.135332, 0.824293);
	TextDrawAlignment(SpeedometerTD[11], 3);
	TextDrawColor(SpeedometerTD[11], -141);
	TextDrawSetShadow(SpeedometerTD[11], 0);
	TextDrawSetOutline(SpeedometerTD[11], 0);
	TextDrawBackgroundColor(SpeedometerTD[11], 51);
	TextDrawFont(SpeedometerTD[11], 2);
	TextDrawSetProportional(SpeedometerTD[11], 1);

	//------------------------------
	DefaultItems_LicenseCost();
	//------- [ forotadar] ------//
	FotoradarOnGameModeInit();
	//-------<[ commands ]>-------
	InitCommands();

	//-------<[ modules ]>-------
    systempozarow_init();
    NowaWybieralka_Init();
	LoadBusiness(); 
	LoadBusinessPickup(); 	
	//-------<[ actors ]>-------
	//PushActors(); 
	LoadAnimations();
	LoadActors();

	//-------<[ doors ]>-------
	LoadDoorsState();

	OnGameModeNapadDomek();

	//Config
	LoadConfig();

    BARIERKA_Init();

	obiekty_OnGameModeInit(); 

    ZaladujDomy();
	GroupsLoad();
    Zone_Load();

    ZaladujTrasy(); //System wyœcigów
	ZaladujPickupy();
	ZaladujSamochody(); //Auta do kradziezy
	Zaladuj3DTexty();
	ZaladujIkony();
	LoadItems();

	//GF:
	LoadBoxer();
	LoadStuff();
	LoadIRC();

	LadujInteriory();

    //Ibiza
    IBIZA_Reszta();

    //Patrol Data
    Patrol_Init();
    LoadServerInfo(); //Informacja dla graczy np. o wylaczeniu czegos

    //13.06
    LoadTXD();
    //30.10
    TJD_Load();
    Car_Load(); //Wszystkie pojazdy MySQL

    //noYsi
    LoadPrzewinienia();
	
	//system obiekow by renosk
	print("Ladowanie obiektow...");
	LoadObjects();

	print("Ladowanie tekstur...");
	LoadMMat();
	
	print("Ladowanie napadow...");
	LoadHeists();

	print("Ladowanie bram...");
	LoadGates();

	//system produktow [2.7.9]
	print("Ladowanie produktow...");
	LoadProducts();
	
	graffiti_LoadMySQL();
	//discordconnect
	DiscordConnectInit();

	MruMySQL_LoadMotels();
	MruMySQL_LoadRooms();
	Iter_Init(StolenVehicles);

	mysql_query("UPDATE `mru_konta` SET `online` = 0"); //reset uzytkownikow online
	mysql_query("UPDATE `mru_konta` SET `connected` = 0"); //reset uzytkownikow online dzialajace
	
	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		afk_timer[i] = -1;
	}
	for(new i; i<MAX_VEHICLES; i++)
    {
        vSigny[i] = 0;
    }

	for(new c=0;c<CAR_AMOUNT;c++)
	{
		Gas[c] = GasMax;
        SetVehicleParamsEx(c, 0, 0, 0, 0, 0, 0, 0);
	}
	IRCInfo[0][iPlayers] = 0; IRCInfo[1][iPlayers] = 0; IRCInfo[2][iPlayers] = 0;
	IRCInfo[3][iPlayers] = 0; IRCInfo[4][iPlayers] = 0; IRCInfo[5][iPlayers] = 0;
	IRCInfo[6][iPlayers] = 0; IRCInfo[7][iPlayers] = 0; IRCInfo[8][iPlayers] = 0;
	IRCInfo[9][iPlayers] = 0;
	News[hTaken1] = 0; News[hTaken2] = 0; News[hTaken3] = 0; News[hTaken4] = 0; News[hTaken5] = 0;

    new string[MAX_PLAYER_NAME];
    new string1[MAX_PLAYER_NAME];
	format(string, sizeof(string), "Nothing");
	strmid(News[hAdd1], string, 0, strlen(string), 255);
	strmid(News[hAdd2], string, 0, strlen(string), 255);
	strmid(News[hAdd3], string, 0, strlen(string), 255);
	strmid(News[hAdd4], string, 0, strlen(string), 255);
	strmid(News[hAdd5], string, 0, strlen(string), 255);
	format(string1, sizeof(string1), "Nie Ma");
	strmid(News[hContact1], string1, 0, strlen(string1), 255);
	strmid(News[hContact2], string1, 0, strlen(string1), 255);
	strmid(News[hContact3], string1, 0, strlen(string1), 255);
	strmid(News[hContact4], string1, 0, strlen(string1), 255);
	strmid(News[hContact5], string1, 0, strlen(string1), 255);
	PlayerHaul[78][pCapasity] = 100;
	PlayerHaul[79][pCapasity] = 100;
	PlayerHaul[80][pCapasity] = 50;
	PlayerHaul[81][pCapasity] = 50;
	PlayerHaul[128][pCapasity] = 300;
	PlayerHaul[129][pCapasity] = 300;
	PlayerHaul[130][pCapasity] = 300;

	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++){
		TextDrawInfo[playerid] = TextDrawCreate(317.5,327.0, " ");
		TextDrawLetterSize(TextDrawInfo[playerid],0.27,1.3);
		TextDrawSetOutline(TextDrawInfo[playerid],0);
		TextDrawSetProportional(TextDrawInfo[playerid],1);
		TextDrawSetShadow(TextDrawInfo[playerid],0);
		TextDrawFont(TextDrawInfo[playerid],1);
		TextDrawAlignment(TextDrawInfo[playerid],2);
		TextDrawBackgroundColor(TextDrawInfo[playerid],-1);
		TextDrawColor(TextDrawInfo[playerid],-1);
		TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
		//////////////////////////////////////////////////////////
		TextDrawEXP[playerid] = TextDrawCreate(554.0, 101.0, " ");
		TextDrawLetterSize(TextDrawEXP[playerid],0.27,1.3);
		TextDrawSetOutline(TextDrawEXP[playerid],0);
		TextDrawSetProportional(TextDrawEXP[playerid],1);
		TextDrawSetShadow(TextDrawEXP[playerid],0);
		TextDrawFont(TextDrawEXP[playerid],1);
		TextDrawAlignment(TextDrawEXP[playerid],2);
		TextDrawBackgroundColor(TextDrawEXP[playerid],-1);
		TextDrawColor(TextDrawEXP[playerid],-1);
		TextDrawShowForPlayer(playerid, TextDrawEXP[playerid]);

		HUDTXDINFO[playerid] = TextDrawCreate(565.000000, 2.000000, "~y~[ID: 1]~w~ Norbert Gierczak.");
        TextDrawFont(HUDTXDINFO[playerid], 1);
        TextDrawLetterSize(HUDTXDINFO[playerid], 0.245829, 1.100000);
        TextDrawTextSize(HUDTXDINFO[playerid], 404.500000, 19.500000);
        TextDrawSetOutline(HUDTXDINFO[playerid], 1);
        TextDrawSetShadow(HUDTXDINFO[playerid], 0);
        TextDrawAlignment(HUDTXDINFO[playerid], 3);
        TextDrawColor(HUDTXDINFO[playerid], -1);
        TextDrawBackgroundColor(HUDTXDINFO[playerid], 255);
        TextDrawBoxColor(HUDTXDINFO[playerid], 50);
        TextDrawUseBox(HUDTXDINFO[playerid], 0);
        TextDrawSetProportional(HUDTXDINFO[playerid], 1);
        TextDrawSetSelectable(HUDTXDINFO[playerid], 0);
	}

	format(motd, sizeof(motd), "Witaj na serwerze Kotnik Role Play - %s.", VERSION);
	gettime(ghour, gminute, gsecond);
    GLOB_LastHour=ghour;
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime)
	{
		SetWorldTime(wtime);
		ServerTime = wtime;
	}
	// CreatedCars check
	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
	    CreatedCars[i] = 0;
	}

	if (realtime)
	{
		new tmphour, tmpminute, tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		SetWorldTime(tmphour);
		ServerTime = tmphour;
	}
	TimeUpdater();
	//timery
	SetTimer("AktywujPozar", 10800000, true);//System Po¿arów v0.1
    SetTimer("MainTimer", 1000, true);
	SetTimer("CheckChangeWeapon", 450, true);
    SetTimer("RPGTimer", 100, true);
	//Ustalanie wartoœci wind
	levelLock[FRAC_SN][5]=1;//Zamkniête
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        Blink[i][0] = -1;
        Blink[i][1] = -1;
        Blink[i][2] = -1;
        Blink[i][3] = -1;
    }
    SetTimer("B_TrailerCheck", 1000, 1);

    for(new v = 0; v < CAR_End+1; v++)
	{
		VehicleUID[v][vDist] = 500.000;
		VehicleUID[v][vUID] = 0;
		SetVehicleNumberPlate(v, "{1F9F06}K-RP");
	}

    if((db_handle = db_open("mru.db")) == DB:0)
    {
        // Error
        print("Failed to open a connection to \"mru.db\".");
        print("Wylaczam serwer.... Powod: brak mru.db");
        SendRconCommand("exit");
    }
    else
    {
        // Success
        print("Successfully created a connection to \"mru.db\".");
    }

    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_legal (pID integer,weapon1 integer not null,weapon2 integer not null,weapon3 integer not null,weapon4 integer not null,weapon5 integer not null,weapon6 integer not null,weapon7 integer not null,weapon8 integer not null,weapon9 integer not null,weapon10 integer not null,weapon11 integer not null,weapon12 integer not null,weapon13 integer not null,unique (pID));"));
    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_opisy(uid INTEGER PRIMARY KEY AUTOINCREMENT, text VARCHAR, owner INT, last_used INT);"));
    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_kevlar(pID integer, offsetX FLOAT, offsetY FLOAT, offsetZ FLOAT, rotX FLOAT, rotY FLOAT, rotZ FLOAT, scaleX FLOAT, scaleY FLOAT, scaleZ FLOAT);"));

    for(new i;i<MAX_PLAYERS;i++)
    {
        PlayerInfo[i][pDescLabel] = Create3DTextLabel(" ", 0xBBACCFFF, 0.0, 0.0, 0.0, 5.0, 0, 1);
    }

    pusteZgloszenia();
	
	if(CA_Init()) 
	{
		printf("ColAndreas initalized!");
		SetSVarInt("CA_Initialized", 1);
	}
	else 
	{
		printf("Can't initialize ColAndreas!");
		SetSVarInt("CA_Initialized", 0);
	}

	//HTTP(0, HTTP_GET, AC_VPN_IP "/vpn/vpn.php?adm&vpnstate", "", "VPNLoadState");
	
	/*CreateGreenZones();
	LoadGreenZonesForAll();*/

	//Create3DTextForPlayers();
	//CreateStaminaForPlayers();
	Gazeciarz3dText();

	// weapon-config
	SetCustomVendingMachines(true);
	SetDamageSounds(false, false);
	SetVehiclePassengerDamage(true);
	SetCbugAllowed(false);

	SetWeaponShootRate(WEAPON_M4, 110);
	SetWeaponShootRate(WEAPON_AK47, 110);
	SetWeaponShootRate(WEAPON_SHOTGUN, 1000);

	UpdateRybyTop();

	Log(serverLog, WARNING, "Serwer zosta³ pomyœlnie uruchomiony.");
    print("----- OnGameModeInit done.");
	
	return 1;
	}

public OnGameModeExit()
{
	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(afk_timer[i] != -1)
			KillTimer(afk_timer[i]);
	}
	for(new i = 0; i < MAX_BIZNES; i++)
	{
		if(Business[i][b_ID] > 0)
			SaveBusiness(Business[i][b_ID]); 
	}
    UnloadTXD();
	new x = 0; for ( ; x < 8; x++ ) { TextDrawDestroy ( Textdraw[x] ); }
    Patrol_Unload();
    TJD_Exit();

	mysql_query("UPDATE `mru_konta` SET `online` = 0"); //reset uzytkownikow online

    for(new i=Zone_Points[0];i<=Zone_Points[1];i++)
    {
        GangZoneDestroy(i);
    }
    for(new i=0;i<MAX_VEHICLES;i++) DisableCarBlinking(i);
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerTextDrawDestroy(i, gCurrentPageTextDrawId[i]);
        PlayerTextDrawDestroy(i, gHeaderTextDrawId[i]);
        PlayerTextDrawDestroy(i, gBackgroundTextDrawId[i]);
        PlayerTextDrawDestroy(i, gNextButtonTextDrawId[i]);
        PlayerTextDrawDestroy(i, gPrevButtonTextDrawId[i]);

        INT_AirTowerLS_Exit(i, true, true);
    }
    foreach(new i : Player)
    {
        if(noclipdata[i][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(i);
        MruMySQL_SaveAccount(i, true, true);
    }

	DOF2_Exit();
    GLOBAL_EXIT = true;
	Log(serverLog, WARNING, "Serwer zosta³ wy³¹czony.");
    print("----- OnGameModeExit done.");
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}


// TODO: FIX ERROR
/*public OnPlayerShootDynamicObject(playerid, weaponid, STREAMER_TAG_OBJECT:objectid, Float:x, Float:y, Float:z)
{
	OnPlayerWeaponShot(playerid, weaponid, BULLET_HIT_TYPE_OBJECT, objectid, x, y, z);
	return 1;
}*/

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype != BULLET_HIT_TYPE_PLAYER)
	{
		if(MaTazer[playerid] == 1 && (GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24))
		{
			GameTextForPlayer(playerid, "~r~PUDLO!~n~~w~PRZELADUJ TAZER!", 3000, 5);
			SetPVarInt(playerid, "wytazerowany", 5);
			MaTazer[playerid] = 0;

			//TODO: fix wytazerowany, ¿eby nie mo¿na by³o wyci¹gn¹æ tazera jak jest wytazerowany
		}
	}
	switch (hittype)
	{
		case BULLET_HIT_TYPE_NONE:
		{
			
		}
		case BULLET_HIT_TYPE_PLAYER:
		{
			if(!IsPlayerConnected(hitid) || hitid == INVALID_PLAYER_ID) return 0;

		}
		case BULLET_HIT_TYPE_VEHICLE:
		{
			//else
		}
		case BULLET_HIT_TYPE_OBJECT:
		{
			//else
		}
		case BULLET_HIT_TYPE_PLAYER_OBJECT:
		{
			//else
		}
	}

    return 1;
}
forward UpdatePlayer3DName(playerid);
public UpdatePlayer3DName(playerid)
{
    new string[258], duty[32];
	if(OnDuty[playerid] > 0)
	{
		new groupid = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
		if(IsValidGroup(groupid))
			format(duty, sizeof(duty), " [%s]", GroupInfo[groupid][g_ShortName]);
	}
    format(string, sizeof(string), "~y~[ID: %d]~w~ %s%s", playerid, GetNick(playerid), (strlen(duty) ? (duty) : ("")));
    TextDrawSetString(HUDTXDINFO[playerid], string);
    TextDrawShowForPlayer(playerid, HUDTXDINFO[playerid]);
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    NowaWybieralka_ClickedTxd(playerid, clickedid);

    new str[128];
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(GetPVarInt(playerid, "gatechose_active") == 1)  //Barierki
        {
            DestroySelectionMenu(playerid);
			SetPVarInt(playerid, "gatechose_active", 0);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        if(GetPVarInt(playerid, "ng-gatekey") == 1) //NG keypad
        {
            SetPVarInt(playerid, "ng-gatekey", 0);
            TextDrawHideForPlayer(playerid,NG_GateTD[0]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[1]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[2]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[3]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[4]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[5]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[6]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[7]);
            VAR_NGKeypad = false;
        }
    }
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        new ngkey[6];

        GetPVarString(playerid, "ng-key", ngkey, 6);
        if(strlen(ngkey) < 4)
        {
            new num[2];
            format(num, 2, "%d", _:clickedid - _:NG_GateTD[1] + 1);
            strcat(ngkey, num);
            TextDrawSetString(NG_GateTD[7], ngkey);
            SetPVarString(playerid, "ng-key", ngkey);

            if(strlen(ngkey) == 4) NG_OpenGateWithKey(playerid); //apply key
        }
        return 1;
    }
    //IBIZA
    if(clickedid==Text:INVALID_TEXT_DRAW && GetPVarInt(playerid, "IbizaKamery")) //ESC
	{
		for(new i=0; i<3; i++)
			TextDrawHideForPlayer(playerid, TDIbiza[i]);
		PlayerTextDrawHide(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		new Float:x, Float:y, Float:z;
		x = GetPVarFloat(playerid, "IbizaKameraX");
		y = GetPVarFloat(playerid, "IbizaKameraY");
		z = GetPVarFloat(playerid, "IbizaKameraZ");
		SetPlayerPos(playerid, x, y, z);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
        Wchodzenie(playerid);
		DeletePVar(playerid, "IbizaKamery");
		PlayerTextDrawDestroy(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		DeletePVar(playerid, "IbizaCam");
		return 1;
	}
	else
	{
		new kam = GetPVarInt(playerid, "IbizaKamery");
		if(clickedid==TDIbiza[1]) //w prawo
		{
			kam = (kam==12 ? 1 : kam+1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}
		if(clickedid==TDIbiza[2]) //w lewo
		{
			kam = (kam==1 ? 12 : kam-1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}

	}
    //Strefy
    if(clickedid == ZoneTXD[3])
    {
        RunCommand(playerid, "/atakuj",  "");
    }

    if(GetPVarInt(playerid, "patrol-map") == 1 && GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            SendClientMessage(playerid, COLOR_PAPAYAWHIP, "Wybierz region.");
            SelectTextDraw(playerid, 0xD2691E55);
            return 1;
        }
        else
        {
            new pat = GetPVarInt(playerid, "patrol-id"), fnick[2][MAX_PLAYER_NAME+1];
            if((clickedid == PatrolAlfa[0] || clickedid == PatrolAlfa[1]) && Patrolujacych[0] < 4)
            {
                PatrolInfo[pat][patstrefa] = 1;
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[0]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Alfa, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolBeta[0] || clickedid == PatrolBeta[1]) && Patrolujacych[1] < 4)
            {
                PatrolInfo[pat][patstrefa] = 2;
                SendClientMessage(playerid, COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[1]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Beta, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolGamma[0] || clickedid == PatrolGamma[1]) && Patrolujacych[2] < 6)
            {
                PatrolInfo[pat][patstrefa] = 3;
                SendClientMessage(playerid, COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[2]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Gamma, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolDelta[0] || clickedid == PatrolDelta[1]) && Patrolujacych[3] < 6)
            {
                PatrolInfo[pat][patstrefa] = 4;
                SendClientMessage(playerid, COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[3]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} 10-30 na strefê Delta, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else SendClientMessage(playerid, COLOR_YELLOW, "Brak wolnego miejsca w tej strefie, spróbuj inn¹.");
            if(PatrolInfo[pat][patstrefa] != 0)
            {
                PatrolInfo[pat][pataktywny] = 1;
                Patrol_HideMap(playerid);
                CancelSelectTextDraw(playerid);
                SetPVarInt(playerid, "patrol-map", 0);
                SendTeamMessage(1, COLOR_ALLDEPT, str);

                Patrol_DisplayZones(playerid);
                if(GetPVarInt(playerid, "patrol-duo") == 1) Patrol_DisplayZones(PatrolInfo[pat][patroluje][1]);
            }
        }
    }
    else if(GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            CancelSelectTextDraw(playerid);
            Patrol_HideMap(playerid);
            return 1;
        }
        new stanp[32], pnick1[24], pnick2[MAX_PLAYER_NAME+1];
        for(new i=0;i<MAX_PATROLS;i++)
        {
            if(clickedid == PatrolMarker[i] && PatrolInfo[i][pataktywny] == 1)
            {
                GetPlayerName(PatrolInfo[i][patroluje][0], pnick1, MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[i][patroluje][1], pnick2, MAX_PLAYER_NAME);
                switch(PatrolInfo[i][patstan])
                {
                    case 1: stanp="Sytuacja pod kontrol¹";
                    case 2: stanp="Potrzebne wsparcie";
                    case 3: stanp="Poœcig za podejrzanym";
                    case 4: stanp="Ranny funkcjonariusz";
                }
                format(str, 128, "Patrol %s - Funkcjonariusze: %s %s. Stan: %s", PatrolInfo[i][patname], pnick1, pnick2, stanp);
                SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
                break;
            }
        }
    }
    if(clickedid == TXD_Info) //Display server info
    {
        if(strlen(ServerInfo) > 1) ShowPlayerDialogEx(playerid, D_SERVERINFO, DIALOG_STYLE_MSGBOX, "Kotnik-RP » Informacja", ServerInfo, "Schowaj", "Zamknij");
    }
   	return 1;
}

public OnDynamicActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new kolid=-1;
        for(new i=0;i<MAX_OILS;i++)
        {
            if(OilData[i][oilArea] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1 && OilData[kolid][oilHP] > 0)
        {
            OnPlayerEnterOilSpot(playerid);
            return 1;
        }
        kolid = -1;
        for(new i=0;i<MAX_KOLCZATEK;i++)
        {
            if(KolArea[i] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1)
        {
            OnPlayerEnterSpikes(playerid);
            return 1;
        }
    }
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "gatechose_active") == 1)   //Barierki
    {
    	new curpage = GetPVarInt(playerid, "gatechose_page");

    	if(playertextid == gNextButtonTextDrawId[playerid]) {
    	    if(curpage < (GetNumberOfPages() - 1)) {
    	        SetPVarInt(playerid, "gatechose_page", curpage + 1);
    	        ShowPlayerModelPreviews(playerid);
             	UpdatePageTextDraw(playerid);
             	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
    		return 1;
    	}
    	if(playertextid == gPrevButtonTextDrawId[playerid]) {
    	    if(curpage > 0) {
    	    	SetPVarInt(playerid, "gatechose_page", curpage - 1);
    	    	ShowPlayerModelPreviews(playerid);
    	    	UpdatePageTextDraw(playerid);
    	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
    		return 1;
    	}
    	new x=0;
    	while(x != SELECTION_ITEMS) {
    	    if(playertextid == gSelectionItems[playerid][x]) {
    	        HandlePlayerItemSelection(playerid, x);
    	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    	        DestroySelectionMenu(playerid);
    	        CancelSelectTextDraw(playerid);
            	SetPVarInt(playerid, "gatechose_active", 0);
            	return 1;
    		}
    		x++;
    	}
    }
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(enterexit == 0)
    {
        if(GetPlayerVehicleID(playerid) != 0)
            CarData[VehicleUID[GetPlayerVehicleID(playerid)][vUID]][c_HP] = 1000.0;
    }
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	SetPVarInt(playerid, "IsAGetInTheCar", 1);
	new Float:pX,Float:pY,Float:pZ;
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
        return 0;
    }
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
        return 0;
    }
    if(gPlayerLogged[playerid] == 0)
	{
        if(!IsPlayerNPC(playerid)) // znow tylko funkcja dla botow
		{
			Kick(playerid);
	    }
        return 0;
 	}		
	if(PlayerInfo[playerid][pJailed] == 2)
	{
		Player_RemoveFromVeh(playerid);
		SendClientMessage(playerid, COLOR_GRAD2, "Stra¿nik zauwa¿y³, ¿e coœ kombinujesz. Wracasz do celi.");
		return JailDeMorgan(playerid);
	}							
	if(!Kajdanki_JestemSkuty[playerid] && (PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)) //inna animacja dla bw
	{
		PlayerEnterVehOnInjury(playerid);
		return FreezePlayerOnInjury(playerid);
	}
	if(TazerAktywny[playerid] == 1)
	{
		Player_RemoveFromVeh(playerid);
		ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "{FF542E}Jesteœ sparali¿owany!\n{FFFFFF}Nie mo¿esz wsi¹œæ do pojazdu.");
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "CRACK","crckdeth2",4.1,0,1,1,1,1,1);
		return 1;
	}
	//Sila
	if(GetPVarInt(playerid, "RozpoczalBieg") == 1)//Zabezpieczenie, jeœli jest podczas biegu
	{
		sendTipMessage(playerid, "Nie mo¿esz wejœæ do pojazdu podczas biegu!"); 
		GetPlayerPos(playerid, pX,pY,pZ);
		SetPlayerPos(playerid, pX,pY,pZ+2);
	}
	if(GetPlayerPing(playerid) >= 800 && !ispassenger)//Zabezpieczenie, jeœli ma za du¿y ping
	{
		sendTipMessage(playerid, "Twój ping jest stanowczo za wysoki! Odczekaj chwilê, zanim wsi¹dziesz do pojazdu"); 
		GetPlayerPos(playerid, pX,pY,pZ);
		SetPlayerPos(playerid, pX,pY,pZ+2);
	}
	if(GetVehicleModel(vehicleid) == 570 && ispassenger)
	{
		if(PlayerInfo[playerid][pBiletpociag] == 0)
		{
			Player_RemoveFromVeh(playerid);
			ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "{FF542E}Nie posiadasz biletu!\n{FFFFFF}Kup go na dworcu za pomoc¹ /kupbiletpoci¹g(/kbpo)");
		}
	}

    new engine, lights, alarm, doors, bonnet, boot, objective;
 	GetVehicleParamsEx(vehicleid, engine, lights ,alarm, doors, bonnet, boot, objective);
    if(!ispassenger)
	{
		if(!Player_CanUseCar(playerid, vehicleid))
				return Player_RemoveFromVeh(playerid);
    }
	// -- customowe parametry dla poszczególnych pojazdów
	if(IsARower(vehicleid))
	{
		SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		engine = 1;
	}
	else if (GetVehicleModel(vehicleid) == 525) sendTipMessageEx(playerid, COLOR_BROWN, "Wsiad³eœ do holownika, naciœnij CTRL alby podholowaæ wóz.");
    if(!ispassenger && !engine)
	{
		if(GetPlayerVehicleID(playerid) >= CAR_End) //do kradziezy
		{
			MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
		}
		else
		{
			MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
		}
		
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		ZerujZmienne(playerid);
		ClearVariableConnect(playerid);
		ZerujKontakty(playerid);
		dialAccess[playerid] = 0; 
		dialTimer[playerid] = 0; 
		gPlayerLogged[playerid] = 1;
		return 1;
	}
	BottomBar(playerid, 0);
	LoadingShow(playerid);

	OnPlayerConnectNapadDomek(playerid);
	EnablePlayerCameraTarget(playerid, 1);
	new GPCI[41];
	gpci(playerid, GPCI, sizeof(GPCI));
	Log(connectLog, WARNING, "Gracz %s[id: %d, ip: %s, gpci: %s] po³¹czy³ siê z serwerem", GetNickEx(playerid), playerid, GetIp(playerid), GPCI);

	SetPlayerVirtualWorld(playerid, 1488);//AC przed omijaniem logowania

	ZerujZmienne(playerid);
	ClearVariableConnect(playerid);
	ZerujKontakty(playerid);
	dialAccess[playerid] = 0; 
	dialTimer[playerid] = 0; 
    ClearChat(playerid);
	Iter_Clear(KilledBy[playerid]);

    // Wy³¹czone na testy
    obiekty_OnPlayerConnect(playerid);//nowe obiekty
	
	LoadTextDraws(playerid);
	
	//Command_SetPlayerDisabled(playerid, true);
	 
	//Poprawny nick:
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
	if(regex_match(nick, "^[A-Z]{1}[a-z]{1,}(_[A-Z]{1}[a-z]{1,}([A-HJ-Z]{1}[a-z]{1,})?){1,2}$") <= 0)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick jest niepoprawny! Nick musi posiadaæ formê: Imiê_Nazwisko!");
		KickEx(playerid);
		return 1;
	}
	//Nick bez wulgaryzmów
	if(CheckVulgarityString(nick) == 1)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick zawiera wulgaryzmy/niedozwolone s³owa - zmieñ go!"); 
		KickEx(playerid);
		return 1;
	}
	SetRPName(playerid);
	
	timeSecWjedz[playerid] = 0;


	//Pocz¹tkowe ustawienia:
    saveMyAccountTimer[playerid] = SetTimerEx("SaveMyAccountTimer", 15*60*1000, 1, "i", playerid);

    //Ikony
    SetPlayerMapIcon(playerid, 1, 1172.0771, -1323.3496, 15.4030, 22, 0); //Szpital
    SetPlayerMapIcon(playerid, 2, 1024.7610, -1025.5515, 38.2944, 63, 0); //Paint & Spray (Temple)
    SetPlayerMapIcon(playerid, 3, 544.3761, -1276.2046, 17.2482, 55, 0); //Grotti (wypo¿yczalnia aut)
    SetPlayerMapIcon(playerid, 4, 501.9365, -1358.5668, 16.1252, 45, 0); //Prolaps (za San News)
    SetPlayerMapIcon(playerid, 5, 1498.39, -1581.62, 13.54, 56, 0); //Urz¹d pracy
    SetPlayerMapIcon(playerid, 6, 459.0327, -1502.2711, 31.0314, 45, 0); //Victim (Rodeo)
    SetPlayerMapIcon(playerid, 7, 487.6090, -1739.3744, 10.8613, 63, 0); //Paint & Spray (Idlewood)
    SetPlayerMapIcon(playerid, 8, 606.5818, -1458.5319, 14.3820, 30, 0); //FBI
    SetPlayerMapIcon(playerid, 9, 648.0233, -1357.3239, 13.5716, 60, 0); //San News
    SetPlayerMapIcon(playerid, 10, 725.6099, -1439.8906, 13.5318, 50, 0); //Jetty Lounge
    SetPlayerMapIcon(playerid, 11, 816.2141, -1386.5956, 13.6068, 48, 0); //Vinyl Club
    SetPlayerMapIcon(playerid, 12, 815.2556, -1616.2010, 13.7077, 10, 0); //Burger Marina
    SetPlayerMapIcon(playerid, 13, 925.6270, -1353.1003, 13.3768, 14, 0); //Kurczak Market
    SetPlayerMapIcon(playerid, 14, 1038.1844, -1339.7595, 13.7266, 17, 0); //P¹czkarnia Allen
    SetPlayerMapIcon(playerid, 15, 1100.9039, -1235.4445, 15.5474, 27, 0); //FDU
    SetPlayerMapIcon(playerid, 16, 1022.4534, -1122.0057, 23.8715, 25, 0); //Kasyno
    SetPlayerMapIcon(playerid, 17, 1459.2233, -1140.6903, 24.0593, 45, 0); //ZIP
    SetPlayerMapIcon(playerid, 18, 1462.3813, -1012.1696, 26.8438, 52, 0); //Bank
    SetPlayerMapIcon(playerid, 19, 1763.3892, -1130.4873, 24.0859, 20, 0); //Remiza
    SetPlayerMapIcon(playerid, 20, 2130.8472, -1144.4091, 24.5245, 55, 0); //Salon Aut
    SetPlayerMapIcon(playerid, 21, 2255.2629, -1333.2920, 23.9816, 12, 0); //Koœció³
    SetPlayerMapIcon(playerid, 22, 2245.2217, -1662.6310, 15.4690, 45, 0); //Binco
    SetPlayerMapIcon(playerid, 23, 2068.5596, -1831.6167, 13.2740, 63, 0); //Paint & Spray Idlewood
    SetPlayerMapIcon(playerid, 24, 2102.2976, -1806.5530, 13.5547, 29, 0); //Pizzeria Idlewood
    SetPlayerMapIcon(playerid, 25, 53.2336, -1531.4541, 5.2757, 57, 0); //Granica LS - SF
	SetPlayerMapIcon(playerid, 26, 2689.88, -2374.44, 13.63, 30, 0); //Baza NG w dokach
    SetPlayerMapIcon(playerid, 27, 655.9221, -564.6913, 16.0630, 42, 0); //Stacja Benzynowa w Dillimore
    SetPlayerMapIcon(playerid, 28, 720.0000, -459.2647, 16.0630, 63, 0); //Paint & Spray Dillimore
    SetPlayerMapIcon(playerid, 29, 713.9889, -498.1104, 16.0630, 18, 0); //AmmuNation Dillimore
    SetPlayerMapIcon(playerid, 30, 1006.5273, -936.9426, 41.8934, 42, 0); //Stacja Benzynowa na Temple
    SetPlayerMapIcon(playerid, 31, 997.5923, -921.3640, 41.9068, 36, 0); //24/7 na Temple
    SetPlayerMapIcon(playerid, 32, 997.2347, -917.5255, 41.9068, 52, 0); //Bankomat na Temple
    SetPlayerMapIcon(playerid, 33, 1199.9893, -923.6624, 42.7465, 10, 0); //Burger Temple
    SetPlayerMapIcon(playerid, 34, 1315.3838, -904.4830, 38.6174, 36, 0); //24/7 na Temple (2)
    SetPlayerMapIcon(playerid, 35, 1310.2568, -1370.4567, 13.3031, 34, 0); //Urz¹d
    SetPlayerMapIcon(playerid, 36, 1481.2053, -1768.3350, 18.5228, 34, 0); //S¹d
    SetPlayerMapIcon(playerid, 37, 913.59, -1003.91, 37.99, 30, 0); //Komisariat G³ówny
    SetPlayerMapIcon(playerid, 38, 1939.0436, -1773.6844, 13.1137, 42, 0); //Stacja Benzynowa na Idlewood
    SetPlayerMapIcon(playerid, 39, 2073.7549, -1827.9742, 13.2739, 52, 0); //Bankomat (1)
    SetPlayerMapIcon(playerid, 40, 2227.1052, -1723.2871, 13.2840, 54, 0); //Si³ownia
    SetPlayerMapIcon(playerid, 41, 2844.5139, -1562.8854, 10.8208, 52, 0); //Bankomat (2)
    SetPlayerMapIcon(playerid, 42, 1699.7645, 411.4212, 30.6384, 57, 0); //Granica LS - LV
    SetPlayerMapIcon(playerid, 43, 2269.7112, -74.8501, 26.7724, 34, 0); //Urz¹d w PC
    SetPlayerMapIcon(playerid, 44, 2302.0964, -16.2240, 26.4844, 52, 0); //Bank w PC
    SetPlayerMapIcon(playerid, 45, 2112.7124, -1213.1012, 23.6923, 45, 0); //Suburban obok Salonu Aut
    SetPlayerMapIcon(playerid, 46, 2421.2805, -1223.2761, 24.9988, 21, 0); //Pig Pen
    SetPlayerMapIcon(playerid, 48, 1961.5001, -2194.4309, 13.2740, 5, 0); //Lotnisko
    SetPlayerMapIcon(playerid, 49, 1941.3965, -2116.1799, 13.3525, 21, 0); //Dziki Tygrys
    SetPlayerMapIcon(playerid, 51, 1352.4242, -1758.4613, 13.5078, 36, 0); //24/7 obok Urzêdu
    SetPlayerMapIcon(playerid, 52, 1109.1722, -1796.2472, 16.5938, 56, 0); //Z³odziej Aut
    SetPlayerMapIcon(playerid, 54, 900.8502, -1101.3074, 23.5000, 12, 0); //Cmentarz
    SetPlayerMapIcon(playerid, 55, 1365.9257, -1275.1326, 13.5469, 56, 0); //Diler Broni
    SetPlayerMapIcon(playerid, 56, 1790.5382,-1164.7021,23.8281, 18, 0); //GunShop obok Remizy
    SetPlayerMapIcon(playerid, 57, 2166.2034, -1675.3135, 15.0859, 56, 0); //Diler Dragów
    SetPlayerMapIcon(playerid, 58, 1787.4432, -1866.6737, 13.5711, 52, 0); //Bankomat obok Dworca G³ównego
    SetPlayerMapIcon(playerid, 59, 1833.0537, -1842.6494, 13.5781, 36, 0); //24/7 na Idlewood
    SetPlayerMapIcon(playerid, 62, 382.8541, -2079.4890, 7.5630, 9, 0); //Miejsce do wêdkowania
    SetPlayerMapIcon(playerid, 63, 342.0005, -1518.7524, 33.2482, 52, 0); //Bankomat obok Mrucznik Tower
    SetPlayerMapIcon(playerid, 64, 660.0374, -575.8544, 16.3359, 52, 0); //Bankomat obok stacji w Dillimore
    SetPlayerMapIcon(playerid, 65, 2273.1931, -77.6219, 26.5704, 52, 0); //Bankomat obok Urzêdu w PC
    SetPlayerMapIcon(playerid, 66, 2115.5796, 920.2349, 10.5474, 42, 0); //Stacja benzynowa w LV
    SetPlayerMapIcon(playerid, 67, 1973.2526, 2162.1948, 10.8001, 63, 0); //Paint & Spray w LV
    SetPlayerMapIcon(playerid, 68, -1675.5817, 414.0347, 6.9068, 42, 0); //Stacja benzynowa w SF
    SetPlayerMapIcon(playerid, 69, -1904.4862, 281.9908, 40.774, 63, 0); //Paint & Spray w SF
    SetPlayerMapIcon(playerid, 71, -2029.1031, 157.1051, 28.5630, 42, 0); //Stacja benzynowa w SF V2
    SetPlayerMapIcon(playerid, 72, -2405.7351, 975.3979, 45.0239, 42, 0); //Stacja benzynowa w SF V3
    SetPlayerMapIcon(playerid, 73, -2425.5703, 1023.0456, 50.1247, 63, 0); //Paint & Spray w SF V2 (Juniper Hollow)
    SetPlayerMapIcon(playerid, 74, -100.5483, 1114.7805, 19.4688, 63, 0); //Paint & Spray w Fort Carson
    SetPlayerMapIcon(playerid, 75, 70.4944, 1219.0317, 18.5391, 42, 0); //Stacja benzynowa w Fort Carson
    SetPlayerMapIcon(playerid, 76, 611.6107, 1694.4340, 6.7193, 42, 0); //Stacja benzynowa w Bone County
    SetPlayerMapIcon(playerid, 77, 2582.2329, 61.6251, 26.2817, 42, 0); //Stacja benzynowa w PC
    SetPlayerMapIcon(playerid, 78, 1383.4578, 461.5694, 19.8450, 42, 0); //Stacja benzynowa w Montgomery
    SetPlayerMapIcon(playerid, 79, 2202.3503, 2474.2419, 10.5474, 42, 0); //Stacja w LV V2
	SetPlayerMapIcon(playerid, 80, 1792.9369,-1698.0756,13.5157, 27, 0); //Pirogov's Motors
	SetPlayerMapIcon(playerid, 81, 1709.2200, -1500.6000, 13.5469, 12, 0); //Ammunation Commerce
	
	//biz
	ResetBizOffer(playerid);
	PreloadAnimLibs(playerid);
	//system barierek by Kubi
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

    for(new x=0; x < SELECTION_ITEMS; x++) {
        gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}
	gItemAt[playerid] = 0;
	return 1;
}

public OnPlayerPause(playerid)
{
	if(afk_timer[playerid] == -1)
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, 1, 0);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
		//printf("NPC %d left, reason: %d", playerid, reason);
	}
	//UpdateNickOnPlayerDisconnect(playerid);
	GazeciarzOnPlayerDisconnect(playerid);
	DestroySalonDialog(playerid);

	TextDrawSetString(TextDrawInfo[playerid], "");
	TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);

	if(playerid == INVALID_PLAYER_ID || playerid > MAX_PLAYERS)
		return 0;

	//Pobieranie starej pozycji:
	Log(connectLog, WARNING, "Gracz %s[id: %d] roz³¹czy³ siê, powód: %d", GetNickEx(playerid), playerid, reason);

	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); //l

//##
	foreach(new i : Player)
	{
		if(Iter_Contains(KilledBy[i], playerid))
			Iter_Remove(KilledBy[i], playerid);
	}

	new reString[128];
    new DisconnectReason[4][] =
    {
        "Timeout/Crash",
        "/q",
        "Kick/Ban",
		"/login"
    };
    if(Spectate[playerid] == INVALID_PLAYER_ID)
    {
		new nick[24];
		if(GetPVarString(playerid, "maska_nick", nick, 24))
			format(reString, sizeof(reString), "SERWER: Gracz znajduj¹cy siê w pobli¿u wyszed³ z serwera (%s, powód: %s [%s]).", GetNick(playerid), DisconnectReason[reason], GetNickEx(playerid));
		else
    		format(reString, sizeof(reString), "SERWER: Gracz znajduj¹cy siê w pobli¿u wyszed³ z serwera (%s, powód: %s).", GetNick(playerid), DisconnectReason[reason]);
		ProxDetector(25.0, playerid, reString, COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
	}

	if(!IsPlayerNPC(playerid)){
		if(gPlayerLogged[playerid] != 0){
			new left[128];
			format(left, sizeof(left), "[Left] %s (%d) wyszed³ z serwera (%s).", GetNickEx(playerid), GetPlayerIDFromName(GetNick(playerid)), DisconnectReason[reason]);
			OOCLeft(left);
		}
	}

	if(GetPVarInt(playerid, "OKupMats") == 1)
    {
        new giveplayerid = GetPVarInt(playerid, "Mats-id");
        SetPVarInt(playerid, "OKupMats", 0);
		SetPVarInt(giveplayerid, "OSprzedajMats", 0);
        SetPVarInt(playerid, "Mats-id", 0);
        SetPVarInt(playerid, "Mats-kasa", 0);
        SetPVarInt(playerid, "Mats-mats", 0);
        sendErrorMessage(giveplayerid, "Sprzeda¿ zosta³a anulowana!");
    }
	if(PlayerInfo[playerid][pLider] > 0)
	{
		Save_MySQL_Leader(playerid); 
	}
	if(GetPVarInt(playerid, "ZjadlDragi") == 1)
	{
		new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
		KillTimer(TimerEfektNarkotyku[playerid]);
		SetStrong(playerid, FirstValue);
	}
	if(GetPVarInt(playerid, "DostalDM2") == 1)
	{
		new string[128];
		format(string, sizeof(string), "[Marcepan Marks] Zabra³em graczowi %s broñ [da³ /q podczas AJ DM2]", GetNickEx(playerid));
		SendAdminMessage(COLOR_PANICRED, string);
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
	}
    if(GetPVarInt(playerid, "kolejka") == 1)
    {
        PlayerInfo[playerid][pPos_x] = GetPVarFloat(playerid, "kolejka-x");
        PlayerInfo[playerid][pPos_y] = GetPVarFloat(playerid, "kolejka-y");
        PlayerInfo[playerid][pPos_z] = GetPVarFloat(playerid, "kolejka-z");
        PlayerInfo[playerid][pInt] = GetPVarInt(playerid, "kolejka-int");
    }

    Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, " ");

	//AFK timer
	if(afk_timer[playerid] != -1)
	{
		KillTimer(afk_timer[playerid]);
		afk_timer[playerid] = -1;
	}
    if(GetPVarInt(playerid, "finding") == 1) {
        GangZoneDestroy(pFindZone[playerid]);
    }
	if(saveMyAccountTimer[playerid] != -1)
	{
		KillTimer(saveMyAccountTimer[playerid]);
	}

    //budki telefoniczne
    if(GetPVarInt(playerid, "budka-Mobile") != 999) {
        new caller = GetPVarInt(playerid, "budka-Mobile");
        if(GetPVarInt(caller, "budka-Mobile") == playerid) {
            sendTipMessage(caller, "**biiip biiip** po³¹czenie zosta³o przerwane ((Wyjœcie z gry))", COLOR_PAPAYAWHIP);
            budki[GetPVarInt(playerid, "budka-used")][isCurrentlyUsed] = 0;
            budki[GetPVarInt(caller, "budka-used")][isCurrentlyUsed] = 0;
            SetPVarInt(caller, "budka-Mobile", 999);
            SetPVarInt(caller, "budka-used", 999);
        }
    }
	//lawyer
	OfferPrice[playerid] = 0;
	LawyerOffer[playerid] = 0;
	ClearVariableDisconnect(playerid); 
	//caluj
	kissPlayerOffer[playerid] = 0;
	//komunikaty frakcyjne
	komunikatMinutyZerowanie[playerid]=0;

    if(TalkingLive[playerid] != INVALID_PLAYER_ID)
    {
		SendPlayerMessageToAll(COLOR_NEWS, "(( Wywiad zakoñczony - gracz wyszed³ z gry ))");
        new talker = TalkingLive[playerid];
        TalkingLive[playerid] = INVALID_PLAYER_ID;
        TalkingLive[talker] = INVALID_PLAYER_ID;
    }
	//koniec rozmowy telefonicznej
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		if(Mobile[playerid] >= 0)
		{
			SendClientMessage(Mobile[playerid], COLOR_YELLOW, "Gracz, z którym prowadzi³eœ rozmowê telefoniczn¹, wyszed³ z gry.");
		}
		StopACall(playerid);
	}
	if(firstDutyAdmin[playerid] == 1 && PlayerInfo[playerid][pAdmin] > 0
	|| firstDutyAdmin[playerid] == 1 && PlayerInfo[playerid][pNewAP] > 0
	|| firstDutyAdmin[playerid] == 1 && IsAScripter(playerid))//Je¿eli admin by³ na duty, wykonuje zapis w logi 
	{
		new exitReason[16];//String do logu
		//LOG
		if(!IsPlayerPaused(playerid))
		{
			format(exitReason, sizeof(exitReason), "DISCONNECT");
		}
		else 
		{
			format(exitReason, sizeof(exitReason), "AFK");
		}
		
		//Log dla 0Verte [Nick][UID] [HH:mm] [Bany] [Warny] [AJ] [Kicki] [Inne] [Reporty+zapytania] [/w] [/w2] [powod zakoñczenia s³u¿by]
		Log(admindutyLog, WARNING, "Admin %s zakonczyl sluzbe - wykonal w czasie %d:%d [B%d/W%d/K%d/I%d/OA%d/Z%d/WI%d/WO%d] - Wyszedl poprzez %s", 
			GetPlayerLogName(playerid), 
			AdminDutyGodziny[playerid], 
			AdminDutyMinuty[playerid],
			iloscBan[playerid],
			iloscWarn[playerid],
			iloscKick[playerid],
			iloscInne[playerid], 
			iloscPozaDuty[playerid],
			iloscZapytaj[playerid], 
			iloscInWiadomosci[playerid], 
			iloscOutWiadomosci[playerid],
			exitReason
		); //Create LOG
		
		//Zerowanie zmiennych 
		iloscKick[playerid] = 0;
		iloscWarn[playerid] = 0;
		iloscBan[playerid] = 0;
		iloscInne[playerid] = 0;
		iloscAJ[playerid] = 0;
		iloscInWiadomosci[playerid] = 0;
		iloscOutWiadomosci[playerid] = 0;
		iloscZapytaj[playerid] = 0;	
		iloscPozaDuty[playerid] = 0; 
		//Kill timer 
		KillTimer(AdminDutyTimer[playerid]);
		AdminDutyGodziny[playerid] = 0;
		AdminDutyMinuty[playerid] = 0;
		firstDutyAdmin[playerid] = 0; 
	}
	if((PlayerInfo[playerid][pAdmin] >= 1 && iloscPozaDuty[playerid] >= 1)
	|| (PlayerInfo[playerid][pNewAP] >= 1 && iloscPozaDuty[playerid] >= 1)
	|| (IsAScripter(playerid) && iloscPozaDuty[playerid] >= 1))//Gdy nie by³ na admin duty, ale wykonywa³ akcje
	{
		if(firstDutyAdmin[playerid] == 0)
		{
			new exitReason[16];//String do logu
			if(!IsPlayerPaused(playerid))
			{
				format(exitReason, sizeof(exitReason), "DISCONNECT");
			}
			else 
			{
				format(exitReason, sizeof(exitReason), "AFK");
			}
			Log(admindutyLog, WARNING, "Admin %s zakonczyl sluzbe - wykonal w czasie %d:%d [B%d/W%d/K%d/I%d/OA%d/Z%d/WI%d/WO%d] - Wyszedl poprzez %s", 
				GetPlayerLogName(playerid), 
				AdminDutyGodziny[playerid], 
				AdminDutyMinuty[playerid],
				iloscBan[playerid],
				iloscWarn[playerid],
				iloscKick[playerid],
				iloscInne[playerid], 
				iloscPozaDuty[playerid],
				iloscZapytaj[playerid], 
				iloscInWiadomosci[playerid], 
				iloscOutWiadomosci[playerid],
				exitReason
			); //Create LOG
			iloscPozaDuty[playerid] = 0; 
		}
	}
	//kajdanki
	if(Kajdanki_JestemSkuty[playerid] != 0) // gdy skuty da /q
	{
		OdkujKajdanki(playerid);
	}
	else if(Kajdanki_Uzyte[playerid] != 0) //gdy skuwaj¹cy da /q
	{
		new aresztant = Kajdanki_SkutyGracz[playerid];
		OdkujKajdanki(aresztant);
	}

	if(Worek_MamWorek[playerid] != 0) // gdy osoba z workiem da /q
	{
		Worek_MamWorek[playerid] = 0;
		Worek_KomuZalozylem[Worek_KtoZalozyl[playerid]] = INVALID_PLAYER_ID;
		Worek_Uzyty[Worek_KtoZalozyl[playerid]] = 0;
		Worek_KtoZalozyl[playerid] = INVALID_PLAYER_ID;
		UnHave_Worek(playerid);
	}
	else if(Worek_Uzyty[playerid] != 0) // gdy osoba nadajaca worek trafi do szpitala
	{
		Worek_MamWorek[Worek_KomuZalozylem[playerid]] = 0;
		Worek_KtoZalozyl[Worek_KomuZalozylem[playerid]] = INVALID_PLAYER_ID;
		UnHave_Worek(Worek_KomuZalozylem[playerid]);
		Worek_Uzyty[playerid] = 0;
		Worek_KomuZalozylem[playerid] = INVALID_PLAYER_ID;
	}

    if(GetPVarInt(playerid, "kostka"))
    {
        new id = GetPVarInt(playerid, "kostka-player");
        Kostka_Wygrana(id, playerid, GetPVarInt(id, "kostka-cash"), true);
        SendClientMessage(id, COLOR_RED, "Wspó³zawodnik opuœci³ serwer, otrzymujesz zwrot wp³aconej kwoty wraz z podatkiem.");
        SetPVarInt(playerid, "kostka",0);
        SetPVarInt(playerid, "kostka-throw", 0);
        SetPVarInt(playerid, "kostka-suma", 0);
        SetPVarInt(playerid, "kostka-cash", 0);
        SetPVarInt(playerid, "kostka-first", 0);
        SetPVarInt(playerid, "kostka-rzut", 0);
        SetPVarInt(playerid, "kostka-wait", 0);
        SetPVarInt(playerid, "kostka-player", 0);
    }
    if(PlayerTied[playerid] >= 1 || (PlayerCuffed[playerid] >= 1 && pobity[playerid] == 0 && PlayerCuffed[playerid] < 3) || Kajdanki_JestemSkuty[playerid] >= 1 || poscig[playerid] == 1)
	{
        //PlayerInfo[playerid][pJailed] = 10;
        new string[130];
        new powod[36];
        if(PlayerTied[playerid] >= 1)
        {
            strcat(powod, "bycie zwiazanym, ");
        }
        if(PlayerCuffed[playerid] >= 1)
        {
            strcat(powod, "kajdanki w aucie, ");
        }
        if(Kajdanki_JestemSkuty[playerid] >= 1)
        {
            strcat(powod, "kajdanki pieszo, ");
        }
        if(poscig[playerid] >= 1)
        {
            strcat(powod, "poœcig, ");
        }
        new codal[16];
        switch(reason)
        {
            case 0: codal = "timeout";
            case 1: codal = "/q";
            case 2: codal = "kick/ban";
        }
        //format(string, 130, "%s dostanie Marcepana za mo¿liwe: %s (%s)", GetNickEx(playerid), powod, codal); marcepan
		format(string, 130, "%s - %s podczas akcji %s", GetNickEx(playerid), codal, powod);
        SendAdminMessage(COLOR_P@, string);
	}

	if(PoziomPoszukiwania[playerid] >= 1)
	{
		new wl = PoziomPoszukiwania[playerid];
		PlayerInfo[playerid][pWL] = wl;
		SetPlayerWantedLevel(playerid, 0);
	}

    if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999)
	{
        Taxi_Pay(playerid);
	}

	GetPlayerHealth(playerid, PlayerInfo[playerid][pLastHP]);
	GetPlayerArmour(playerid, PlayerInfo[playerid][pLastArmour]);

    //System aut
    Car_UnloadForPlayer(playerid);
    // zapisanie PK
    new karne = GetPVarInt(playerid, "mandat_punkty");
    if(karne>0) {
        PlayerInfo[playerid][pPK] += karne;
    }
    //
	//Zapis statystyk:
	MruMySQL_SaveAccount(playerid, false, true);

    if(GetPVarInt(playerid, "active_ticket") != 0){
		SetPVarInt(playerid, "active_ticket", 0);
	}

    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        Oil_UnloadPTXD(playerid);
        TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
        TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    }

    if(GetPVarInt(playerid, "patrol") != 0) {
        new patrol = GetPVarInt(playerid, "patrol-id");
		if(PatrolInfo[patrol][patroluje][0] != INVALID_PLAYER_ID)
        {
        	sendTipMessageEx(PatrolInfo[patrol][patroluje][0], COLOR_PAPAYAWHIP, "Partner opuœci³ patrol. 10-33!");
			RunCommand(PatrolInfo[patrol][patroluje][0], "/patrol", "stop");
		}
		if(PatrolInfo[patrol][patroluje][1] != INVALID_PLAYER_ID)
		{
        	sendTipMessageEx(PatrolInfo[patrol][patroluje][1], COLOR_PAPAYAWHIP, "Partner opuœci³ patrol. 10-33!");
        	RunCommand(PatrolInfo[patrol][patroluje][1], "/patrol", "stop");
		}
    }
    if(GetPVarInt(playerid, "rentTimer") != 0)
    {
        UnhireRentCar(playerid, GetPVarInt(playerid, "rentCar"));
        KillTimer(GetPVarInt(playerid, "rentTimer"));
    }

    //12.06.2014  opis

    if(noclipdata[playerid][fireobject] != 0)
    {
        DestroyDynamicObject(noclipdata[playerid][fireobject]);
        noclipdata[playerid][fireobject] = 0;
    }

    //strefy
    if(ZonePlayerTimer[playerid] != 0) KillTimer(ZonePlayerTimer[playerid]);

	UnLoadTextDraws(playerid);

    INT_AirTowerLS_Exit(playerid, true, true);

    //09.06.2014 wylaczenie ng pad
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        SetPVarInt(playerid, "ng-gatekey", 0);
        VAR_NGKeypad = false;
    }

	if(PDGPS == playerid)
	{
		foreach(new i : Player)
		{
			if(CheckPlayerPerm(i, PERM_POLICE) || CheckPlayerPerm(i, PERM_MEDIC) || (CheckPlayerPerm(i, PERM_RADIO) && SanDuty[i] == 1) || GetPVarInt(playerid, "RozpoczalBieg") == 0)
				DisablePlayerCheckpoint(i);
		}
	}

    if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
	{
	    new string[64];
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    format(string, sizeof(string), "Wyœcig: {FFFFFF}%s wyszed³ z gry", sendername);
    	foreach(new i : Player)
    	{
	    	if(ScigaSie[i] == Scigamy)
 	    	{
    			SendClientMessage(i, COLOR_YELLOW, string);
   			}
	    }
	    IloscZawodnikow --;
	    if(IloscZawodnikow <= Ukonczyl)
	    {
	        KoniecWyscigu(-1);
	    }
    }

    if(HireCar[playerid] != 0)
    {
        CarData[VehicleUID[HireCar[playerid]][vUID]][c_Rang] = 0;
    }

    new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }
	if(BoomBoxData[bbxid][BBD_Gang] == playerid+1)
	{
		if(BoomBoxData[bbxid][BBD_Obj] != 0) DestroyDynamicObject(BoomBoxData[bbxid][BBD_Obj]);
		BoomBoxData[bbxid][BBD_x] = 0;
		BoomBoxData[bbxid][BBD_y] = 0;
		BoomBoxData[bbxid][BBD_z] = 0;
		BoomBoxData[bbxid][BBD_Standby] = false;
		BoomBoxData[bbxid][BBD_Carried] = -1;
		BoomBoxData[bbxid][BBD_ID] = 0;
		BoomBoxData[bbxid][BBD_Gang] = 0;
	}

    TextDrawHideForPlayer(playerid, TXD_Info);

	for(new i = 1; i < MAX_REPORTS; i++){
		if(strcmp(repList[i][reported], GetNickEx(playerid)) == 0)
		{
			repList[i][repSend] = false;
			repList[i][repOwner] = 0;
			repList[i][reported] = 0;
			repList[i][repQuestion] = 0;
			repList[i][repID] = -1;
		}
	}
	for(new i = 1; i < MAX_SUPPORTS; i++){
		if(strcmp(suppList[i][suppOwner], GetNickEx(playerid)) == 0)
		{
			suppList[i][suppSend] = false;
			suppList[i][suppOwner] = 0;
			suppList[i][suppQuestion] = 0;
			suppList[i][suppID] = -1;
		}
	}

	//Komunikaty dla graczy na serwerze:
	foreach(new i : Player)
	{
	    if(IsPlayerConnected(i) && i != playerid)
	    {
	        if(TaxiAccepted[i] < 500)
	        {
		        if(TaxiAccepted[i] == playerid)
		        {
		            TaxiAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient Taxi~n~~r~Wyszedl z gry", 5000, 1);
		            TaxiCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	        else if(BusAccepted[i] < 500)
	        {
		        if(BusAccepted[i] == playerid)
		        {
		            BusAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient autobusu~n~~r~Wyszedl z gry", 5000, 1);
		            BusCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	    }
	}
	if(GotHit[playerid] > 0)
	{
	    if(GetChased[playerid] < 500)
	    {
	        if(IsPlayerConnected(GetChased[playerid]))
	        {
	        	SendClientMessage(GetChased[playerid], COLOR_YELLOW, "Twój cel opuœci³ serwer.");
	            GoChase[GetChased[playerid]] = 999;
			}
	    }
	}
	if(PlayerPaintballing[playerid] != 0)
	{
	    PaintballPlayers --;
	}
	if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
	{
	    KartingPlayers --;
	}
	if(PlayersChannel[playerid] < 500)
	{
		IRCInfo[PlayersChannel[playerid]][iPlayers] --;
	}
	if(PlayerBoxing[playerid] > 0)
	{
	    if(Boxer1 == playerid)
	    {
	        if(IsPlayerConnected(Boxer2))
	        {
	        	PlayerBoxing[Boxer2] = 0;
	        	SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer2, 5);
	        	GameTextForPlayer(Boxer2, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    else if(Boxer2 == playerid)
	    {
	        if(IsPlayerConnected(Boxer1))
	        {
	        	PlayerBoxing[Boxer1] = 0;
	        	SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer1, 5);
	        	GameTextForPlayer(Boxer1, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    InRing = 0;
     	RoundStarted = 0;
		Boxer1 = 255;
		Boxer2 = 255;
		TBoxer = 255;
	}
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
    else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}
	

	TransportDuty[playerid] = 0;
	JobDuty[playerid] = 0;
    gPlayerLogged[playerid] = 0; //wylogowany
    MRP_PremiumHours[playerid] = 0;
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerPrepareDeath(playerid, animlib[32], animname[32], &anim_lock, &respawn_time)
{
	format(PlayerInfo[playerid][pDeathAnimLib], 32, "%s", "BEACH");
	format(PlayerInfo[playerid][pDeathAnimName], 32, "%s", "SitnWait_loop_W");
	if(isequal(animname, "CAR_dead_LHS" , true) || isequal(animname, "CAR_dead_RHS" , true))
	{
		format(PlayerInfo[playerid][pDeathAnimLib], 32, "%s", "PED");
		format(PlayerInfo[playerid][pDeathAnimName], 32, "%s", animname);
	}
	return 1;
}

public OnPlayerDamageDone(playerid, Float:amount, issuerid, weapon, bodypart)
{
	if(!IsPlayerNPC(playerid) && !IsPlayerNPC(issuerid))
	{
		if(issuerid != INVALID_PLAYER_ID)
		{
			SavePlayerDamaged(playerid, issuerid, amount, weapon);
			SavePlayerDamage(issuerid, playerid, amount, weapon);
		}

		SetPVarInt(playerid, "lastDamage", gettime());
		Log(damageLog, INFO, "%s zostal zraniony przez %s o %fhp bronia %d", 
			GetPlayerLogName(playerid),
			IsPlayerConnected(issuerid) ? GetPlayerLogName(issuerid) : sprintf("%d", issuerid),
			amount,
			weapon
		);
	}

	if(weapon == WEAPON_GRENADE || weapon == 51)
	{
	    ShowPlayerFadeScreenToBlank(playerid, 20, 255, 255, 255, 255);
		SetPlayerDrunkLevel(playerid, 3000);
	}

	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if(armour <= 40.0)
	{
		switch(bodypart)
		{
			case BODY_PART_LEFT_LEG:
			{
				if(random(100) < 30) ApplyAnimation(playerid, "ped", "DAM_LegL_frmLT", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_RIGHT_LEG:
			{
				if(random(100) < 30) ApplyAnimation(playerid, "ped", "DAM_LegR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_LEFT_ARM:
			{
				if(random(100) < 10) ApplyAnimation(playerid, "ped", "DAM_armL_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_RIGHT_ARM:
			{
				if(random(100) < 10) ApplyAnimation(playerid, "ped", "DAM_armR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_HEAD:
			{
				if(random(100) < 60) ApplyAnimation(playerid,"PED","SHOT_partial", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	new weaponid = weapon;
	if(amount>=1)
    {
    }
	
	if(weapon == WEAPON_CARPARK)
	{
		return 0;
	}
	if(issuerid != INVALID_PLAYER_ID) // PvP
    {
		if(GetPVarInt(issuerid, "cantdmg") == 1) //strzelnica
		{
			st_stop(issuerid, "Naruszy?e? regulamin strzelnicy.");
			MruDialog(issuerid, "Strzelnica", "Nie mo?esz zadawa? innym DMG b?d?c na strzelnicy!");
			return 0;
		}
		if(GetPVarInt(playerid, "enter-check") == 1)
		{
			return 0;
		}
		if(PlayerInfo[issuerid][pConnectTime] < 2 && weaponid==0)
		{
			TextDrawInfoOn(issuerid,sprintf("~w~Nie zrobisz ~r~krzywdy~w~ ~y~%s~w~, poniewaz nie masz przegranych 2 godzin.", GetNick(playerid)),5000);
			return 0;
		}
		if(Kajdanki_JestemSkuty[issuerid] > 0)
		{
			return 0;
		}

		if(PlayerInfo[issuerid][pWeaponBlock] > gettime() && weaponid > 1)
		{
			new sec = PlayerInfo[issuerid][pWeaponBlock]-gettime();
			MruDialog(issuerid, "Blokada broni", sprintf("Posiadasz aktywn? blokad? broni, nie mo?esz korzysta? z niej przez %d minut.", floatround(sec / 60 % 60)));
			return 0;
		}
		if(MaTazer[issuerid] == 1 && (GetPlayerWeapon(issuerid) == 23 || GetPlayerWeapon(issuerid) == 24) && GetDistanceBetweenPlayers(playerid,issuerid) < 15)
		{
			if(TazerAktywny[playerid] == 0)
			{
				TazerAktywny[playerid] = 1;
				SetTimerEx("DostalTazerem", 30000, false, "i", playerid);
				new string[128];
				GameTextForPlayer(playerid, "DOSTALES TAZEREM! ODCZEKAJ CHWILE!", 3000, 5);
				GameTextForPlayer(issuerid, "~g~TRAFILES W GRACZA!~n~~w~TAZER DEZAKTYWOWANY! PRZELADUJ TAZER!", 3000, 5);
				SetPVarInt(issuerid, "wytazerowany", 15);
				format(string, sizeof(string), "* %s strzela tazerem w %s.", GetNick(issuerid), GetNick(playerid));
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				MaTazer[issuerid] = 0;
				PlayerPlaySound(issuerid, 6300, 0.0, 0.0, 0.0);
				PlayerPlaySound(playerid, 6300, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid, "CRACK","crckdeth2",4.1,0,1,1,1,1,1);
			}
			return 0;
		}	

		if(GetPlayerAdminDutyStatus(playerid) == 1) //zakaz strzelania do admina
		{
			return 0;
		}

		if(PlayerInfo[issuerid][pBW] > 0 || PlayerInfo[issuerid][pInjury] > 0 || GetPVarInt(issuerid, "enter-check") || gPlayerLogged[issuerid] != 1)
		{	
			return 0;
		}

		//damage modify
		if(st_getSkillIDByWeapon(weaponid) != -1)
		{
			amount *= st_getWeaponMultiplier(issuerid, weaponid);
		}
	}
    SetTimerEx("OnPlayerTakeDamageWeaponHack", 500, false, "iii", issuerid, weaponid, playerid);
	return 1;
}

public OnRejectedHit(playerid, hit[E_REJECTED_HIT])
{
	return 1;
}

public StandUp(playerid)
{
    SetPVarInt(playerid, "optd-hs", 0);
    ApplyAnimation(playerid, "ped", "getup", 4.1, 0, 0, 0, 0, 0, 1);
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new string[144];
	if(IsPlayerNPC(playerid)) return 1;
	if((!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) || (IsPlayerConnected(killerid) && !gPlayerLogged[killerid])) return 1;

	if(!IsPlayerNPC(playerid))
	{
		OnPlayerDeathNarko(playerid);
		EXPPlayerDeath(playerid, killerid, reason);

		Log(damageLog, WARNING, "%s zosta³ zabity przez %s, powód: %d", 
			GetPlayerLogName(playerid),
			IsPlayerConnected(killerid) ? GetPlayerLogName(killerid) : sprintf("%d", killerid),
			reason
		);
	}
    if(killerid != INVALID_PLAYER_ID && killerid != playerid)
    {
		if(Iter_Contains(KilledBy[playerid], killerid))
		{
			sendErrorMessage(killerid, "Musisz odczekaæ 10 minut, aby znów otrzymaæ nagrodê za t¹ sam¹ osobê!");
		}
		else
		{
			DajKase(killerid, KILL_REWARD);
			SendClientMessage(killerid, COLOR_GREEN, "Zdoby³eœ $"#KILL_REWARD" za zabójstwo!");
			Iter_Add(KilledBy[playerid], killerid);
			defer resetCounter[600000](playerid, killerid);
		}
    }
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);

	PlayerInfo[playerid][pLastHP] = 50.0;
	PlayerInfo[playerid][pLastArmour] = 0.0;

	new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }
    if(ZoneAttacker[playerid] || ZoneDefender[playerid])
    {
        OnPlayerLeaveGangZone(playerid, GetPVarInt(playerid, "zoneid"));
    }
    if(GetPVarInt(playerid, "IbizaWejdz") || GetPVarInt(playerid, "IbizaBilet") )
	{
		DeletePVar(playerid, "IbizaWejdz");
		DeletePVar(playerid, "IbizaBilet");
		StopAudioStreamForPlayer(playerid); //POWTÓRKA
	}

	if(GetPlayerAdminDutyStatus(playerid) == 1 || GetPlayerAdminDutyStatus(killerid) == 1 || BW == 0)
	{
		SetPVarInt(playerid, "skip_bw", 1);
	}
	DeathAdminWarning(playerid, killerid, reason);

	if(IsPlayerConnected(playerid))
	{
		//-------<[    Zmienne    ]>---------
		StopAudioStreamForPlayer(playerid);
		gPlayerSpawned[playerid] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pDeaths] ++;
		OnPlayerDeathOnede(playerid, killerid);
		
		if(GetPVarInt(playerid, "skip_bw") == 0)
		{
			if(PlayerInfo[playerid][pInjury] > 0) //TRYB BW (GDY ZGINIE JAK MA RANNEGO)
			{
				if (gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
				{
					DisablePlayerCheckpoint(playerid);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				}
				if(TalkingLive[playerid] != INVALID_PLAYER_ID)
				{
					SendPlayerMessageToAll(COLOR_NEWS, "NEWS: Wywiad zakoñczony - nasz rozmówca przerwa³ wywiad.");
					new talker = TalkingLive[playerid];
					TalkingLive[playerid] = INVALID_PLAYER_ID;
					TalkingLive[talker] = INVALID_PLAYER_ID;
				}
				//koniec rozmowy telefonicznej
				if(Mobile[playerid] != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Jesteœ ranny - po³¹czenie zakoñczone.");
					if(Mobile[playerid] >= 0)
					{
						SendClientMessage(Mobile[playerid], COLOR_YELLOW, "S³ychaæ nag³y trzask i po³¹czenie zostaje zakoñczone.");
					}
					StopACall(playerid);
				}

				if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
				{
					format(string, sizeof(string), "Wyœcig: {FFFFFF}%s zgin¹³ jak prawdziwy œcigant [*]", GetNickEx(playerid));
					WyscigMessage(COLOR_YELLOW, string);
					IloscZawodnikow --;
					if(IloscZawodnikow <= Ukonczyl)
					{
						KoniecWyscigu(-1);
					}
				}
				if(lowcaz[playerid] == killerid)
				{
					lowcaz[playerid] = 501;
					SendClientMessage(playerid, COLOR_YELLOW, "Zlecenie zosta³o anulowane - nie mo¿esz wzi¹æ teraz zlecenia na tego samego gracza!");
				}
				if(GetPVarInt(playerid, "ZjadlDragi") == 1)
				{
					new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
					SetPVarInt(playerid, "ZjadlDragi", 0);
					sendTipMessage(playerid, "Z powodu œmierci twój boost (dragów) zosta³ wy³¹czony, za¿yj kolejn¹ dawkê!"); 
					KillTimer(TimerEfektNarkotyku[playerid]);
					SetStrong(playerid, FirstValue);
				}

				if(Worek_MamWorek[playerid] != 0) // gdy osoba z workiem trafi do szpitala
				{
					Worek_MamWorek[playerid] = 0;
					Worek_KomuZalozylem[Worek_KtoZalozyl[playerid]] = INVALID_PLAYER_ID;
					Worek_Uzyty[Worek_KtoZalozyl[playerid]] = 0;
					Worek_KtoZalozyl[playerid] = INVALID_PLAYER_ID;
					UnHave_Worek(playerid);
				}
				else if(Worek_Uzyty[playerid] != 0) // gdy osoba nadajaca worek trafi do szpitala
				{
					Worek_MamWorek[Worek_KomuZalozylem[playerid]] = 0;
					Worek_KtoZalozyl[Worek_KomuZalozylem[playerid]] = INVALID_PLAYER_ID;
					UnHave_Worek(Worek_KomuZalozylem[playerid]);
					Worek_Uzyty[playerid] = 0;
					Worek_KomuZalozylem[playerid] = INVALID_PLAYER_ID;
				}

				if(IsPlayerConnected(killerid))
				{
					PlayerInfo[killerid][pKills] ++;
					if(giveWL)
					{
						if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid )
						{
							NadajWLBW(killerid, playerid, true);
						}
					}
					if(PlayerInfo[playerid][pHeadValue] > 0) //hitmani musz¹ dobiæ, ¿eby zaliczy³o kontrakt
					{
						if(IsPlayerInGroup(killerid, 8) || PlayerInfo[killerid][pLider] == 8)
						{
							if(GoChase[killerid] == playerid)
							{
								//jeœli zabity mia³ kajdanki
								if(Kajdanki_JestemSkuty[playerid] != 0) // gdy skuty da /q
								{
									format(string, sizeof(string), "* Wiêzieñ %s zosta³ zastrzelony przez Hitmana (MK). Nastêpnym razem zadbaj o bezpieczeñstwo swojego wiêŸ¸nia *", GetNick(playerid));
									SendClientMessage(Kajdanki_PDkuje[playerid], COLOR_LIGHTRED, string);
									OdkujKajdanki(playerid);
								}

								SetPVarInt(playerid, "bw-hitmankiller",  1);
								SetPVarInt(playerid, "bw-hitmankillerid",  killerid);
								return NadajBW(playerid, BW_TIME_CRIMINAL);
							}
						}
					}
					if(PoziomPoszukiwania[playerid] >= 1)
					{
						new price2 = PoziomPoszukiwania[playerid] * MULT_POLICE_ARRESTED;
						new count, i = killerid;
						
						if(GroupPlayerDutyPerm(playerid, PERM_POLICE))
						{
							PoziomPoszukiwania[playerid] = 0;
						}
						else if(PlayerInfo[killerid][pJob] == 1)
						{
							if(lowcaz[i] == playerid)
							{
								if(PlayerInfo[i][pDetSkill] <= 50)
								{
									if(PoziomPoszukiwania[playerid] == 2 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 11;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 51 && PlayerInfo[i][pDetSkill] < 100)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 3 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 22;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 101 && PlayerInfo[i][pDetSkill] < 200)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 4 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 33;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 201 && PlayerInfo[i][pDetSkill] < 400)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 5 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 44;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 400)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 10)
									{
										count = 55;
										lowcaz[i] = 501;
									}
								}

								format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
								GameTextForPlayer(i, string, 5000, 1);
								PoziomPoszukiwania[i] = 0;
								ClearCrime(i);
								DajKase(i, price2);//moneycheat
								PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
								PlayerInfo[i][pDetSkill] += 2;
								SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
							}
						}
						if(poscig[playerid] == 1)
						{
							if(PoziomPoszukiwania[playerid] >= 6)
							{
								count = 2;
							}
							else
							{
								count = 1;
							}
						}
						if(count == 1 || count == 11 || count == 22 || count == 33 || count == 44 || count == 55 || count == 2)
						{
							if(!(GroupPlayerDutyPerm(playerid, PERM_POLICE)))
							{
								new CenaZabicia = (MULT_POLICEKILL)*(PoziomPoszukiwania[playerid]);
								ZabierzKase(playerid, CenaZabicia);//moneycheat
								PlayerInfo[playerid][pWantedDeaths] += 1;
								PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(400);
								PoziomPoszukiwania[playerid] = 0;
								SetPlayerWantedLevel(playerid, 0);
								poscig[playerid] = 0;
								UsunBron(playerid);
								if(count == 1 || count == 11 || count == 22 || count == 33 || count == 44 || count == 55)
								{
									PlayerInfo[playerid][pJailed] = 1;
									format(string, sizeof(string), "* Jesteœ w wiêzieniu na %d Sekund i straci³eœ $%d gdy¿ ucieka³eœ lub strzela³eœ do funkcjonariusza policji.", PlayerInfo[playerid][pJailTime], CenaZabicia);
									SendClientMessage(playerid, COLOR_LIGHTRED, string);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, "Je¿eli nie chcesz aby taka sytuacja powtórzy³a siê w przysz³oœci, skorzystaj z us³ug prawnika który zbije twój WL.");
									WantLawyer[playerid] = 1;
								}
								else if(count == 2)
								{
									PlayerInfo[playerid][pJailed] = 2;
									format(string, sizeof(string), "* Jesteœ w DeMorgan na %d Sekund i straci³eœ $%d gdy¿ ucieka³eœ lub strzela³eœ do funkcjonariusza policji", PlayerInfo[playerid][pJailTime], CenaZabicia);
									SendClientMessage(playerid, COLOR_LIGHTRED, string);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, "Je¿eli nie chcesz aby taka sytuacja powtórzy³a siê w przysz³oœci, skorzystaj z us³ug prawnika który zbije twój WL.");
								}
								return 1; //zrespawnuj gracza w wiêzieniu
							}
						}
					}
					if(IsAPrzestepca(killerid)) return NadajBW(playerid, BW_TIME_CRIMINAL);
					if(PlayerInfo[killerid][pLevel] >= 3 || (GroupPlayerDutyPerm(killerid, PERM_POLICE))) return NadajBW(playerid);
				}
				return 1;
			}
			else //TRYB RANNEGO
			{
				if(PlayerInfo[playerid][pBW] > 0)
				{
					return NadajBW(playerid, PlayerInfo[playerid][pBW], false);
				}
				else
				{
					//kajdanki
					if(Kajdanki_Uzyte[playerid] != 0) //gdy skuwaj¹cy dostanie rannego
					{
						OdkujKajdanki(Kajdanki_SkutyGracz[playerid]);
					}

					if(IsPlayerConnected(killerid))
					{
						if(giveWL)
						{
							if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid )
							{
								NadajWLBW(killerid, playerid, false);
							}
						}

						if(PlayerInfo[playerid][pHeadValue] > 0) //hitmani musz¹ dobiæ, ¿eby zaliczy³o kontrakt
						{
							if(IsPlayerInGroup(killerid, 8) || PlayerInfo[killerid][pLider] == 8)
							{
								if(GoChase[killerid] == playerid)
								{
									format(string, sizeof(string), "* Dobij %s, ¿eby wype³niæ kontrakt *", GetNick(playerid));
									SendClientMessage(killerid, COLOR_LIGHTRED, string);
								}
							}
						}

						SetPVarInt(playerid, "bw-reason", reason);
						if(PlayerInfo[killerid][pLevel] >= 3 || IsAPrzestepca(killerid) || (GroupPlayerDutyPerm(killerid, PERM_POLICE)))
						{
							return NadajRanny(playerid, 0, true);
						}
						else
						{
							return NadajRanny(playerid, INJURY_TIME_EXCEPTION, true);
						}
					}
				}
			}
		}
		else
		{
			DeletePVar(playerid, "skip_bw");		
		}
		SetPlayerColor(playerid,COLOR_GRAD2);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) 
	{
		SetPlayerTeam(playerid, NO_TEAM);
		return 1;
	}
	LVLPlayerSpawn(playerid);
	OnPlayerSpawnNarko(playerid);
	UpdatePlayer3DName(playerid);
	LoadGreenZonesForPlayer(playerid);
	SetPlayerTeam(playerid, NO_TEAM);
	//Czyszczenie zmiennych
	if(gPlayerLogged[playerid] != 1)
	{
		sendErrorMessage(playerid, "Zespawnowa³eœ siê, a nie jesteœ zalogowany! Zosta³eœ wyrzucony z serwera.");
		KickEx(playerid);
		return 0;
	}
	else
	{
		SetPlayerVirtualWorld(playerid, 0);
	}
	DeletePVar(playerid, "Vinyl-bilet");
    DeletePVar(playerid, "Vinyl-VIP");
    PlayerInfo[playerid][pMuted] = 0;
	WnetrzeWozu[playerid] = 0;
	spamwl[playerid] = 0;
	if(PlayerInfo[playerid][pFixKit] < 0) PlayerInfo[playerid][pFixKit] = 0;
	if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0)
	{
    	SetPlayerWeatherEx(playerid, ServerWeather);//Pogoda
	}
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
	{
    	SetPlayerWeatherEx(playerid, 3);//Pogoda
	}
    // usuwanie
    SetPVarInt(playerid, "mozeUsunacBronie", 0);
    // zabieranie prawka //
    new string[128];
    if(PlayerInfo[playerid][pPK] > 24) {
        format(string, sizeof(string), "* Przekroczy³eœ limit 24 PK. Tracisz prawo jazdy na 1 DZIEÃ‘");
        SendClientMessage(playerid, COLOR_RED, string);
                                        //86400
        PlayerInfo[playerid][pPK] = 0;
        PlayerInfo[playerid][pCarLic] = gettime()+86400;
    }
	
	new dom = PlayerInfo[playerid][pWynajem];
	if(dom != 0)
	{
		new Nick[MAX_PLAYER_NAME];
		Nick = GetNick(playerid);
		if(
			strcmp(Dom[dom][hL1], Nick, true) != 0 &&
			strcmp(Dom[dom][hL2], Nick, true) != 0 &&
			strcmp(Dom[dom][hL3], Nick, true) != 0 &&
			strcmp(Dom[dom][hL4], Nick, true) != 0 &&
			strcmp(Dom[dom][hL5], Nick, true) != 0 &&
			strcmp(Dom[dom][hL6], Nick, true) != 0 &&
			strcmp(Dom[dom][hL7], Nick, true) != 0 &&
			strcmp(Dom[dom][hL8], Nick, true) != 0 &&
			strcmp(Dom[dom][hL9], Nick, true) != 0 &&
			strcmp(Dom[dom][hL10], Nick, true) != 0
		)
		{
			format(string, sizeof(string), "* Zosta³eœ wykopany z wynajmowanego domu.");
			SendClientMessage(playerid, COLOR_RED, string);
			PlayerInfo[playerid][pWynajem] = 0;
			PlayerInfo[playerid][pSpawn] = 0;
		}
	}
	//Skills'y broni
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);
    //Style walki
    if(PlayerInfo[playerid][pStylWalki] == 1) SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	else if(PlayerInfo[playerid][pStylWalki] == 2) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	else if(PlayerInfo[playerid][pStylWalki] == 3) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
	//WL
	SetPlayerWantedLevel(playerid, (PoziomPoszukiwania[playerid] > 6 ? 6 : PoziomPoszukiwania[playerid]));

	//DŸ¸wiêki
	StopAudioStreamForPlayer(playerid);
	PlayerFixRadio(playerid);

	//Kubi
	INT_AirTowerLS_Exit(playerid, false, true);

	//Inne
	if(PlayerInfo[playerid][pDom] != 0)
	{
		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0; //Zerowanie dni do usuniêcia domu
	}
	SetPlayerToTeamColor(playerid);
	//AdminDuty
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		SetPlayerColor(playerid, 0xFF0000FF);
	}
    if(PlayerInfo[playerid][pLider] == FRAC_SN)
    {
        SetPVarInt(playerid, "scena-allow", 1);
    }
	//SetPlayerSpawn:
	SetPlayerSpawn(playerid);

    //Spawn Pos
	SetTimerEx("SpawnPosInfo", 1000, false, "i", playerid);
	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	SetPlayerSpawnPos(playerid);
	SetPlayerSpawnSkin(playerid);
	SetPlayerSpawnWeapon(playerid);
	return 1;
}

YCMD:changelog(playerid, params[])
{
	ShowPlayerDialogEx(playerid, D_SERVERINFO, DIALOG_STYLE_MSGBOX, MruTitle("Changelog"), Changelog, "OK", "");
	return 1;
}
SetPlayerSpawnPos(playerid)
{
	//Po /spec off
	EnableAntiCheatForPlayer(playerid, 2, 0);
	SetTimerEx("SetACCode", 2000, false, "ddd", playerid, 2, 1);

    if(Unspec[playerid][Coords][0] != 0.0 && Unspec[playerid][Coords][1] != 0.0 && Unspec[playerid][Coords][2] != 0.0)
    {
		if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
		{
			SetPlayerInterior(playerid, Unspec[playerid][sPint]);
			SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
			SetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
			Unspec[playerid][Coords][0] = 0.0, Unspec[playerid][Coords][1] = 0.0, Unspec[playerid][Coords][2] = 0.0;
			Spectate[playerid] = INVALID_PLAYER_ID;
			PhoneOnline[playerid] = 0;
		}
    }
    //Wiêzienie:
	else if(PlayerInfo[playerid][pJailed] == 1)
	{
		if(PlayerInfo[playerid][pInjury] > 0) ZdejmijBW(playerid, 3000);
		SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 29);
	    new losuj= random(sizeof(Cela));
		SetPlayerPos(playerid, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Twój wyrok nie dobieg³ koñca, wracasz do wiêzienia.");
		TogglePlayerControllable(playerid, 0);
		Wchodzenie(playerid);
	}
	else if(PlayerInfo[playerid][pJailed] == 2)//Stanowe
	{
		if(PlayerInfo[playerid][pInjury] > 0) ZdejmijBW(playerid, 3000);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Twój wyrok nie dobieg³ koñca, wracasz do wiêzienia stanowego");
		JailDeMorgan(playerid);
		return 1;
	}
	else if(PlayerInfo[playerid][pJailed] == 3)//AdminJail
	{
		new string[128];
	    SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 1000+playerid);
		SetPlayerPos(playerid,1481.1666259766,-1790.2204589844,156.7875213623);
		PlayerInfo[playerid][pMuted] = 1;
		PlayerPlaySound(playerid, 141, 0.0, 0.0, 0.0);

		if(GetPVarInt(playerid, "DostalAJkomunikat") == 0) 
		{
			format(string, sizeof(string), "Wracasz do Admin Jaila. {FFFFFF}Powód: %s", PlayerInfo[playerid][pAJreason]);
			SetPVarInt(playerid, "DostalAJkomunikat", 1);
		}
		if(strfind(PlayerInfo[playerid][pAJreason], "DM2", true) != -1 || 
		strfind(PlayerInfo[playerid][pAJreason], "Death Match 2", true) != -1) SetPVarInt(playerid, "DostalDM2", 1);
		SendClientMessage(playerid, COLOR_PANICRED, string);
	}
	/*MARCEPAN IS OFF else if(PlayerInfo[playerid][pJailed] == 10)//Marcepan Admin Jail
	{
		new string[256];
	    new kaseczka = (kaska[playerid] > 0) ? (kaska[playerid]/2) : 1;
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* Zosta³eœ uwieziony w Admin Jailu przez Admina Marcepan_Marks. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
		PlayerInfo[playerid][pJailed] = 3;
		PlayerInfo[playerid][pJailTime] = 15*60;
		format(PlayerInfo[playerid][pAJreason], MAX_AJ_REASON, "/q podczas akcji (Marcepan)");
        SetPlayerVirtualWorld(playerid, 1000+playerid);
		PlayerInfo[playerid][pMuted] = 1;
		SetPlayerPos(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
		format(string, sizeof(string), "Zosta³eœ ukarany na 15 minut. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina Marcepan_Marks. Powod: /q podczas akcji + zabieram po³owê kasy i broñ", sendername);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		format(string, sizeof(string), "Dodatkowo zabrano z twojego portfela %d$ i wyzerowano twoje bronie oraz zabrano po³owê matsów", kaseczka);
        SendClientMessage(playerid, COLOR_LIGHTRED, string);
        Log(punishmentLog, WARNING, "%s da³ /q podczas akcji wiêc zabrano mu %d$, %d materia³ów oraz broñ.", GetPlayerLogName(playerid), kaseczka, TakeMats(playerid, CountMats(playerid)/2));
        ZabierzKaseDone(playerid, kaseczka);
        //PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats]/2;
	}*/
	//Paintball
    else if(PlayerPaintballing[playerid] != 0)
	{
	    ResetPlayerWeapons(playerid);
  		GivePlayerWeapon(playerid, 29, 999);
	    new rand = random(sizeof(PaintballSpawns));
		SetPlayerPos(playerid, PaintballSpawns[rand][0], PaintballSpawns[rand][1], PaintballSpawns[rand][2]);
		SetCameraBehindPlayer(playerid);
	}
	//BW:
	else if(PlayerInfo[playerid][pBW] > 0)
	{
		if(PlayerRequestMedic[playerid] == 1)
		{
			ZespawnujGraczaBW(playerid);
		}
		else
		{
			ZespawnujGraczaSzpitalBW(playerid);
		}
	}
	else if(PlayerInfo[playerid][pInjury] > 0)
	{
		ZespawnujGraczaBW(playerid);
	}
    else
    {
	    //-----------------------------------[ Normalny spawn ]-----------------------------------
	    //Przywracanie do poprzedniego spawnu
		if(GetPVarInt(playerid, "spawn") == 2)
		{
			Wchodzenie(playerid);
			SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			SetPlayerInterior(playerid, PlayerInfo[playerid][pIntSpawn]);
			SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
			if(GetPLocal(playerid) == PLOCAL_INNE_BANK || GetPLocal(playerid) == PLOCAL_FRAC_DMV)
	        {
				sendTipMessage(playerid, "W banku nie wolno mieæ broni! Zostanie Ci ona przywrócona po œmierci.");
				SetPVarInt(playerid, "mozeUsunacBronie", 1);
                ResetPlayerWeapons(playerid);
				return 1;
			}

		}
		else
		{
		    if(PlayerInfo[playerid][pSpawn] == 0) //Normalny spawn
		    {
		        SetPlayerInteriorEx(playerid, 0);
		        PlayerInfo[playerid][pLocal] = 255;
				SetPlayerVirtualWorld(playerid, 0);
				if(PlayerInfo[playerid][pGrupa][0] > 0 || PlayerInfo[playerid][pGrupa][1] > 0 || PlayerInfo[playerid][pGrupa][2] > 0)
				{
					new group = GetPlayerGroupUID(playerid, PlayerInfo[playerid][pGrupaSpawn]);
					if(group > 0)
					{
						if(GroupInfo[group][g_Spawn][0] != 0.0 && GroupInfo[group][g_Spawn][0] != 1.0)
						{
							SetPlayerVirtualWorld(playerid, GroupInfo[group][g_VW]);
							SetPlayerInteriorEx(playerid, GroupInfo[group][g_Int]);
							SetPlayerPos(playerid, GroupInfo[group][g_Spawn][0], GroupInfo[group][g_Spawn][1], GroupInfo[group][g_Spawn][2]);
							SetPlayerFacingAngle(playerid, GroupInfo[group][g_Spawn][3]);
							Wchodzenie(playerid);
						}
						else
						{
							SendClientMessage(playerid, COLOR_YELLOW, "Twoja grupa nie ma jeszcze spawnu - spawnujesz siê jako cywil");
							SetPlayerPos(playerid, gRandomPlayerSpawns[0][0], gRandomPlayerSpawns[0][1], gRandomPlayerSpawns[0][2]);
							SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[0][3]);
							SetPlayerVirtualWorld(playerid, 0);
							SetPlayerInterior(playerid, 0);
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_YELLOW, "Twój wybór spawnu grupy jest niepoprawny - spawnujesz siê jako cywil");
						SetPlayerPos(playerid, gRandomPlayerSpawns[0][0], gRandomPlayerSpawns[0][1], gRandomPlayerSpawns[0][2]);
						SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[0][3]);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerInterior(playerid, 0);
						PlayerInfo[playerid][pGrupaSpawn] = 0;
					}
				}
				else if(PlayerInfo[playerid][pJob] > 0) //Spawn Prac
				{
				    switch(PlayerInfo[playerid][pJob])
				    {
						case JOB_MECHANIC:
						{
						    SetPlayerPos(playerid,1740.9182,-1757.5448,13.5289);
		    				SetPlayerFacingAngle(playerid, 80.0);
						}
						case JOB_LAWYER:
						{
							Wchodzenie(playerid);
						    SetPlayerPos(playerid,319.72470092773, -1548.3374023438, 14.555289230347);
		    				SetPlayerFacingAngle(playerid, 230.0);
						}
						case JOB_LOWCA:
						{
						    SetPlayerPos(playerid,322.0553894043, 303.41961669922, 999.1484375);
		    				SetPlayerInterior(playerid,5);
						}
						case JOB_BOXER:
						{
						    SetPlayerPos(playerid,766.0804,14.5133,1000.7004);
		    				SetPlayerInterior(playerid, 5);
						}
						case JOB_BUSDRIVER:
						{
						    SetPlayerPos(playerid, 1143.0999755859,-1754.0999755859,13.60000038147);
						}
						case JOB_BODYGUARD:
						{
						    SetPlayerPos(playerid, 2207.4038,-1725.1147,13.4060);
						}
						default: //Spawn cywila
						{
							if(PlayerCanSpawnWihoutTutorial(playerid))
							{
								SetPlayerPos(playerid, 1214.9427,-1322.5612,13.5665);
								SetPlayerFacingAngle(playerid, 92.3869);
							}
						}
				    }
				}
				else //Spawn cywila
				{
					if(PlayerCanSpawnWihoutTutorial(playerid))
					{
						SetPlayerPos(playerid, 1214.9427,-1322.5612,13.5665);
						SetPlayerFacingAngle(playerid, 92.3869);
					}
				}
		    }
		    else if(PlayerInfo[playerid][pSpawn] == 1) //Spawn przed domem / motelem
		    {
		        new i;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
					if(PlayerInfo[playerid][pMotRoom] != 0) 
					{
						i = PlayerInfo[playerid][pMotRoom];
						if(MotelRooms[i][mtrOwnerUID] == PlayerInfo[playerid][pUID]) // Sprawdza czy gracz jest jeszcze w³aœcicielem
						{
							// Sprawdzanie czy motel istnieje
							new motelID = Motel_GetMotelIDFromUID(MotelRooms[i][mtrMotUID]);
							if(motelID != -1)
							{
                				SetPlayerPos(playerid, Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ]);
								SetPlayerVirtualWorld(playerid, Motels[motelID][motVW]);
								SetPlayerInterior(playerid, Motels[motelID][motInt]);
								Wchodzenie(playerid);
								return 1;
							}
						} else PlayerInfo[playerid][pMotRoom] = 0; // Gracz nie jest ju¿ w³aœcicielem, mo¿na ustawiæ na 0
					}
           	 		
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
				Wchodzenie(playerid);
                SetPlayerPos(playerid, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]);
	  		}
	  		else if(PlayerInfo[playerid][pSpawn] == 2) //Spawn w œrodku domu / motelem
	  		{
	  		    new i, h, m;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
					if(PlayerInfo[playerid][pMotRoom] != 0) 
					{
						i = PlayerInfo[playerid][pMotRoom];
						if(MotelRooms[i][mtrOwnerUID] == PlayerInfo[playerid][pUID]) // Sprawdza czy gracz jest jeszcze w³aœcicielem
						{
							// Sprawdzanie czy motel istnieje
							new motelID = Motel_GetMotelIDFromUID(MotelRooms[i][mtrMotUID]);
							if(motelID != -1)
							{
                				SetPlayerInterior(playerid, MotelInteriors[MotelRooms[i][mtrInterior]][mtiInt]);
								SetPlayerVirtualWorld(playerid, MotelRooms[i][mtrUID]+MOTEL_VW);
								SetPlayerPos(playerid, MotelInteriors[MotelRooms[i][mtrInterior]][mtiPosX], MotelInteriors[MotelRooms[i][mtrInterior]][mtiPosY], MotelInteriors[MotelRooms[i][mtrInterior]][mtiPosZ]);
								Wchodzenie(playerid);
								return 1;
							}
						} else PlayerInfo[playerid][pMotRoom] = 0; // Gracz nie jest ju¿ w³aœcicielem, mo¿na ustawiæ na 0
					}
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
				GetPlayerTime(playerid, h, m);
   				SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
     			PlayerInfo[playerid][pDomT] = h;
                PlayerInfo[playerid][pDomWKJ] = PlayerInfo[playerid][pDom];
                SetPlayerPos(playerid, Dom[i][hInt_X], Dom[i][hInt_Y], Dom[i][hInt_Z]);
                SetPlayerInteriorEx(playerid, Dom[i][hInterior]);
                SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
                GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
	  		}
		}
	}

    //Ustawienie kamery:
    if(GetPVarInt(playerid, "spawn"))
		DeletePVar(playerid, "spawn");
    SetCameraBehindPlayer(playerid);
	return 1;
}

SetPlayerSpawnWeapon(playerid)
{
	//Resetowanie broni
    ResetPlayerWeapons(playerid);

	// katana dla ykz ez
	if(IsPlayerInGroup(playerid, FRAC_YKZ) || PlayerInfo[playerid][pLider] == FRAC_YKZ)
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 8; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 0;

	    }
	}
    //Dawanie spawnowych broni
	if(PlayerInfo[playerid][pJob])
	    DajBroniePracy(playerid);
    if(MaZapisanaBron(playerid))
		PrzywrocBron(playerid);

    //HP:	

	if(PlayerInfo[playerid][pLastHP] <= 0.0) PlayerInfo[playerid][pLastHP] = 50;

	SetPlayerHealth(playerid, PlayerInfo[playerid][pLastHP]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][pLastArmour]);
	return 1;
}

SetPlayerSpawnSkin(playerid)
{
	if(OnDuty[playerid] > 0 && PlayerInfo[playerid][pUniform] > 0) {
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
		SetPVarInt(playerid, "skinF", 1);
	}
	else
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
		SetPVarInt(playerid, "skinF", 0);
	}
	if(isNaked[playerid] == 1)
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
		isNaked[playerid] = 0;
	}
	Item_AfterLogin(playerid); //system-przedmioty.pwn
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	new string[128];
	new name[MAX_PLAYER_NAME];
    DisablePlayerCheckpoint(playerid);
	GazeciarzOnEnterCheckpoint(playerid);

	if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
	{
		if(GetPVarInt(playerid, "WybralBieg") == 1)
		{
			if(OszukujewBiegu[playerid] == 0)
			{
				if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
				{
					CreateNewRunCheckPoint(playerid, 1709.3523,-1461.3938,13.5469, 3, "Zaliczy³eœ pierwszy przystanek, kolejny jest ju¿ oznaczony!", 0, true);
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
				{
					CreateNewRunCheckPoint(playerid, 1707.8762,-1584.3118,13.5453, 3, "Zaliczy³eœ drugi przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
				{
					CreateNewRunCheckPoint(playerid, 1625.7415,-1608.9004,13.7188, 3, "Zaliczy³eœ trzeci przystanek, kolejny jest ju¿ oznaczony!", 5,true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
				{
					CreateNewRunCheckPoint(playerid, 1538.9513,-1724.1267,13.5469, 3, "Zaliczy³eœ czwarty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
				{
					CreateNewRunCheckPoint(playerid, 1322.6306,-1724.9469,13.5469, 3, "Zaliczy³eœ pi¹ty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
				{
					CreateNewRunCheckPoint(playerid, 1318.4052,-1841.7726,13.5469, 3, "Zaliczy³eœ szósty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
				{
					CreateNewRunCheckPoint(playerid,  1382.2340,-1811.7761,13.5469, 3, "Zaliczy³eœ siódmy (przedostatni) przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
				{
					EndRunPlayer(playerid, 10);
				}
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_RED, "WYKRYTO OSZUSTWO! TWÓJ BIEG ZOSTAJE PRZERWANY"); 
				DisablePlayerCheckpoint(playerid);
				SetPVarInt(playerid, "ZaliczylBaze", 0);
				SetPVarInt(playerid, "WybralBieg", 0);
				SetPVarInt(playerid, "RozpoczalBieg", 0);
			}
		}
		else if(GetPVarInt(playerid, "WybralBieg") == 2)
		{
			if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
			{
				CreateNewRunCheckPoint(playerid,  535.0668,-1364.9790,15.8432, 2, "Zaliczy³eœ pierwszy checkpoint! Nastêpny zosta³ ju¿ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
			{
				CreateNewRunCheckPoint(playerid,  339.2540,-1526.9476,33.3757, 2, "Zaliczy³eœ drugi checkpoint! Nastêpny zosta³ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
			{
				CreateNewRunCheckPoint(playerid,  317.4830,-1632.8326,33.3125, 2, "Zaliczy³eœ trzeci checkpoint! Nastêpny zosta³ oznaczony, a ty siê nie poddajesz!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
			{
				CreateNewRunCheckPoint(playerid,  364.1078,-1805.8809,7.8380, 2, "Zaliczy³eœ czwarty checkpoint! Pi¹ty jest ju¿ oznaczony!", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
			{
				CreateNewRunCheckPoint(playerid,  664.4612,-1859.3246,5.4609, 2, "Zaliczy³eœ Pi¹ty checkpoint! Zosta³y jeszcze dwa!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
			{
				CreateNewRunCheckPoint(playerid,  966.9481,-1834.9043,12.6000, 2, "Szósty przystanek zaliczony! Biegnij do kolejnego", 0, true); 

			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
			{
				CreateNewRunCheckPoint(playerid,  1000.8669,-1857.4419,12.8146, 2, "Zaliczy³eœ siódmy checkpoint! Ju¿ widaæ ostatni", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
			{
				EndRunPlayer(playerid, 5);
			}
		}
		else//Jeœli wybra³ dialog do pokazania punktu startowego trasy
		{
			DisablePlayerCheckpoint(playerid);
			sendTipMessageEx(playerid, COLOR_P@, "Aby rozpocz¹æ bieg wpisz w tym miejscu [/biegnij]"); 
			SetPVarInt(playerid, "RozpoczalBieg", 0);
		}
	}
	if(PizzaJob[playerid] != 0)
	{
	    SetTimerEx("PizzaJobTimer01", 4000, false, "i", playerid);
	    GameTextForPlayer(playerid, "KLIENT ZABIERA PIZZE", 4000, 3);
	    TogglePlayerControllable(playerid,0);
	}

    TJD_CallCheckpoint(playerid, GetPlayerVehicleID(playerid));

	if(TaxiCallTime[playerid] > 0 && TaxiAccepted[playerid] < 999)
	{
	    TaxiAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		TaxiCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	else if(BusCallTime[playerid] > 0 && BusAccepted[playerid] < 999)
	{
	    BusAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		BusCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid]==1)
	{
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    { 
			if(Car_IsValid(GetPlayerVehicleID(playerid)))
				return sendErrorMessage(playerid, "Ten pojazd nie jest ukradziony!");
			if(IsPlayerInRangeOfPoint(playerid, 50, -1548.3618,123.6438,3.2966))
			{
				PlayerInfo[playerid][pJackSkill] ++;
				if(PlayerInfo[playerid][pJackSkill] == 50)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 2, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
				else if(PlayerInfo[playerid][pJackSkill] == 100)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 3, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
				else if(PlayerInfo[playerid][pJackSkill] == 200)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 4, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
				else if(PlayerInfo[playerid][pJackSkill] == 400)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 5, bêdziesz najwiêcej zarabiaæ oraz najszybciej kraœæ auta."); }
				new level = PlayerInfo[playerid][pJackSkill];
				if(level >= 0 && level <= 50)
				{
					new money = PRICE_STEAL_CAR_1;
					format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 15 minut.", money);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					DajKaseDone(playerid, money);//moneycheat
					PlayerInfo[playerid][pCarTime] = 900;
				}
				else if(level >= 51 && level <= 100)
				{
					new money = PRICE_STEAL_CAR_2;
					format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 15 minut.", money);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					DajKaseDone(playerid, money);//moneycheat
					PlayerInfo[playerid][pCarTime] = 900;
				}
				else if(level >= 101 && level <= 200)
				{
					new money = PRICE_STEAL_CAR_3;
					format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 15 minut.", money);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					DajKaseDone(playerid, money);//moneycheat
					PlayerInfo[playerid][pCarTime] = 900;
				}
				else if(level >= 201 && level <= 400)
				{
					new money = PRICE_STEAL_CAR_4;
					format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 15 minut.", money);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					DajKaseDone(playerid, money);//moneycheat
					PlayerInfo[playerid][pCarTime] = 900;
				}
				else if(level >= 401)
				{
					new money = PRICE_STEAL_CAR_MAX;
					format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 15 minut.", money);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					DajKaseDone(playerid, money);//moneycheat
					PlayerInfo[playerid][pCarTime] = 900;
				}
				GameTextForPlayer(playerid, "~y~Sprzedales pojazd", 2500, 1);
				CP[playerid] = 0;
				DisablePlayerCheckpoint(playerid);
				Iter_Remove(StolenVehicles[playerid], GetPlayerVehicleID(playerid));
				RespawnVehicleEx(GetPlayerVehicleID(playerid));
			} else {
				SetPlayerCheckpoint(playerid, -1548.3618,123.6438,3.2966,8.0);
			}

		}
		else
		{
		    GameTextForPlayer(playerid, "Nie jestes w wozie", 5000, 1);
		}
	}
	else if(CP[playerid] == 5)
	{
	    GameTextForPlayer(playerid, "~y~W punkcie misji", 2500, 1);
		CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 9)//Karting
	{
		GameTextForPlayer(playerid, "~r~Czekaj tutaj na wiecej gokardow", 4000, 3);
		DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 10) { CP[playerid] = 11; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2258.7874,-2402.9712,12.7035,8.0); }
	else if(CP[playerid] == 11) { CP[playerid] = 12; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2225.8755,-2461.3875,12.7190,8.0); }
	else if(CP[playerid] == 12) { CP[playerid] = 13; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2276.9983,-2662.8328,12.8580,8.0); }
	else if(CP[playerid] == 13) { CP[playerid] = 14; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2449.1399,-2663.0562,12.8138,8.0); }
	else if(CP[playerid] == 14) { CP[playerid] = 15; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2566.9814,-2504.5686,12.7692,8.0); }
	else if(CP[playerid] == 15) { CP[playerid] = 16; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2719.0520,-2503.5962,12.7706,8.0); }
	else if(CP[playerid] == 16) { CP[playerid] = 17; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2720.7881,-2405.6589,12.7441,8.0); }
	else if(CP[playerid] == 17) { CP[playerid] = 18; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2571.5195,-2401.1531,12.7528,8.0); }
	else if(CP[playerid] == 18) { CP[playerid] = 19; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2406.6995,-2423.1182,12.6641,8.0); }
	else if(CP[playerid] == 19) { CP[playerid] = 20; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2322.9194,-2341.5715,12.6664,8.0); }
	else if(CP[playerid] == 20)//End of Karting
	{
	    CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	    GetPlayerName(playerid, name, sizeof(name));
	    if(FirstKartWinner == 999)
	    {
	        FirstKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako pierwszy !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(SecondKartWinner == 999)
	    {
	        SecondKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako drugi !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(ThirdKartWinner == 999)
	    {
	        ThirdKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako trzeci.",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		                SendClientMessage(i, COLOR_WHITE, "** Koniec wyœcigu **");
		                CP[i] = 0;
		                DisablePlayerCheckpoint(i);
		            }
				}
	        }
	    }
	}
	else if(zawodnik[playerid] == 1)
	{
		if(okregi[playerid] == 5)
		{
		    if(iloscwygranych == 0)
		    {
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Wygra³ %s - ukoñczy³ wyœcig zajmuj¹c 1 miejsce !!!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 1)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 2 miejsce !!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 2)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 3 miejsce !.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else
			{
			    iloscwygranych ++;
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c %d miejsce !.", sendername, iloscwygranych);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
	   			SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
	   	}
  		else if(okrazenia[playerid] == 0)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1057.6370,-994.5727,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 1)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.9596,-975.8777,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 2)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1114.9780,-985.8290,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 3)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1115.5585,-987.0826,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 4)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.2609,-1006.3092,128.9274, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] = 0;
	        okregi[playerid] ++;
	    }
	}
	else
	{
		switch (gPlayerCheckpointStatus[playerid])
		{
			case CHECKPOINT_HOME:
		    {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "~w~Tu jest twoj~n~~y~Dom", 5000, 1);
		    }
		}
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    TJD_CallRaceCheckpoint(playerid);
	if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0 && Scigamy != 666)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
		{
			return 1;
	    }
	    //
	    if(IloscCH[playerid] == (Wyscig[Scigamy][wCheckpointy]-1))
	    {
            PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        if(Wyscig[Scigamy][wTypCH] == 0)
	        {
	       	 	SetPlayerRaceCheckpoint(playerid,1,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
			else
			{
				SetPlayerRaceCheckpoint(playerid,4,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
	    }
	    else if(IloscCH[playerid] == Wyscig[Scigamy][wCheckpointy])
	    {
	        DisablePlayerRaceCheckpoint(playerid);
	        PlayerPlaySound(playerid, 1139, 0, 0, 0);
	        new string[128];
	        //
	        if(Ukonczyl == 1)
	        {
	            SendClientMessage(playerid, COLOR_YELLOW, "|_________ GRATULACJE!!!! _________|");
        		SendClientMessage(playerid, COLOR_LIGHTGREEN, "| Ukoñczy³eœ wyœcig jako pierwszy! |");
				format(string, sizeof(string), "|   Otrzymujesz %d$ nagrody!   |", Wyscig[Scigamy][wNagroda]); SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
	        	SendClientMessage(playerid, COLOR_LIGHTGREEN, "|__________________________________|");
	        	DajKaseDone(playerid, Wyscig[Scigamy][wNagroda]);
	        	if(Ukonczyl >= IloscZawodnikow)
		        {
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		        	format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s wygra³ wyœcig %s", GetNickEx(playerid), Wyscig[Scigamy][wNazwa]);
		        	foreach(new i : Player)
		        	{
		        	    if(ScigaSie[i] == Scigamy && i != playerid)
		        	    {
							SendClientMessage(i, COLOR_YELLOW, "|_________ UWAGA!!!! _________|");
		        			SendClientMessage(i, COLOR_YELLOW, string);
		        		}
				    }
				    Ukonczyl++;
				}
	        }
	        else
	        {
	            if(Ukonczyl >= IloscZawodnikow)
		        {
		            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Ukoñczy³eœ wyœcig jako ostatni - cienias!");
					format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s ukoñczy³ wyœcig jako ostatni !", GetNickEx(playerid));
					WyscigMessage(COLOR_YELLOW, string);
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		            format(string, sizeof(string), "Ukoñczy³eœ wyœcig jako %d !", Ukonczyl);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
					format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s ukoñczy³ wyœcig jako %d !", GetNickEx(playerid), Ukonczyl);
					WyscigMessage(COLOR_YELLOW, string);
	            	Ukonczyl++;
		        }
	        }
	        IloscCH[playerid] = 0;
	    }
	    else
	    {
			PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        SetPlayerRaceCheckpoint(playerid,Wyscig[Scigamy][wTypCH],wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],wCheckpoint[Scigamy][ch+1][0], wCheckpoint[Scigamy][ch+1][1], wCheckpoint[Scigamy][ch+1][2], Wyscig[Scigamy][wRozmiarCH]);
	    }
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(IsValidDynamicObject(objectid))
	{
		if(GetPVarInt(playerid, "Allow-edit"))
		{
			MoveDynamicObject(objectid, x, y, z, 10.0, rx, ry, rz);
		}

        if(response < EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new str[128];
            new frac = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
            format(str, 128, "[%d]\n%s\n%s", GetPVarInt(playerid, "Barier-id")-1, GroupInfo[frac][g_Name],GetNickEx(playerid));

            if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
            {
                new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
                GetDynamicObjectRot(objectid, rox, roy, roz);
                GetDynamicObjectPos(objectid, X, Y, Z);
                SendClientMessage(playerid, -1, "Jesteœ za daleko.");
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, 0x1E90FFFF, X, Y, Z+0.3, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid));
                SetDynamicObjectPos(objectid, X, Y, Z);
                SetDynamicObjectRot(objectid, rox, roy, roz);
            }
            else
            {
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, 0x1E90FFFF, x, y, z+0.3, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid));
                GetDynamicObjectPos(objectid, x, y, z);
                GetDynamicObjectRot(objectid, rx, ry, rz);
            }
            SetPVarInt(playerid, "Barier-id", 0);
        }
        else if(response == EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
            GetDynamicObjectRot(objectid, rox, roy, roz);
            GetDynamicObjectPos(objectid, X, Y, Z);
            for(new i=0;i<MAX_PLAYERS;i++)
            {
                if(GetPlayerSurfingObjectID(i) == objectid)
                {
                    SendClientMessage(i, 0xFF0000FF, "Zejdz z obiektu!!");
                    GetPlayerPos(i, rox, roy, roz);
                    SetPlayerPos(i, rox+0.3,roy+0.3,roz+0.2);
                    SetPlayerVelocity(i, 0.15, 0.12, 0.1);
                }
            }
            if(!IsPlayerInRangeOfPoint(playerid, 5.0, x,y,z))
            {
                SendClientMessage(playerid, 0xFF0000FF, "Podejdz do obiektu!");
                SetDynamicObjectPos(objectid, X, Y, Z);
            }
            else
            {
                new Float:speed = VectorSize(X-x, Y-y, Z-z);
                MoveDynamicObject(objectid, x, y, z, speed, rx, ry, rz);
            }
        }
		else if(response == EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
			new frac = GetPlayerFrac(playerid);
            GetDynamicObjectRot(objectid, rox, roy, roz);
            GetDynamicObjectPos(objectid, X, Y, Z);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, x,y,z))
            {
                SendClientMessage(playerid, 0xFF0000FF, "Podejdz do graffiti!");
                SetDynamicObjectPos(objectid, X, Y, Z);
            }
            else
            {
                new Float:speed = VectorSize(X-x, Y-y, Z-z);
                MoveDynamicObject(objectid, x, y, z, speed, rx, ry, rz);
            }
			if( GetPVarInt(playerid, "zoneid") == -1 || (ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != OnDuty[playerid]-1) ) 
        	{
				SendClientMessage(playerid, 0xFF0000FF, "Musisz byæ na swojej strefie!");
                SetDynamicObjectPos(objectid, X, Y, Z);
			}
		}
		else if( response == EDIT_RESPONSE_FINAL && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new f = GetPVarInt(playerid, "GraffitiID");
			new frac = GetPlayerFrac(playerid);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, x,y,z))
            {
                GameTextForPlayer(playerid, "~r~Byles za daleko.",2000, 5);
                graffiti_DeleteMySQL(f);
				graffiti_ZerujZmienne(playerid);
				graffiti_Zeruj(f);
				return 1;
			}
			if( GetPVarInt(playerid, "zoneid") == -1 || (ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != OnDuty[playerid]-1) )
        	{
				SendClientMessage(playerid, 0xFF0000FF, "Nie by³eœ na swojej strefie!");
                graffiti_DeleteMySQL(f);
				graffiti_ZerujZmienne(playerid);
				graffiti_Zeruj(f);
				return 1;
			}
			GraffitiInfo[f][grafXpos] = x;
			GraffitiInfo[f][grafYpos] = y;
			GraffitiInfo[f][grafZpos] = z;
			GraffitiInfo[f][grafXYpos] = rx;
			GraffitiInfo[f][grafYYpos] = ry;
			GraffitiInfo[f][grafZYpos] = rz;
			GameTextForPlayer(playerid, "~g~Stworzono.",2000, 5);
			graffiti_UpdateMySQL(f);
			graffiti_ReloadForPlayers(f);
			graffiti_ZerujZmienne(playerid);
			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			new akcja[150];
			format(akcja,sizeof(akcja),"* %s wyci¹ga spray i tworzy nim napis.",GetNick(playerid));
            ProxDetector(40.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(akcja, sizeof(akcja), "%s [%d] stworzy³ nowe graffiti [ID: %d], lokalizacja: %s", GetNick(playerid), playerid, f, pZone);
			SendAdminMessage(COLOR_PANICRED, akcja);
			Log(serverLog, WARNING, "%s stworzy³ nowe graffiti %s, lokalizacja: %s", GetPlayerLogName(playerid), GetGraffitiLogText(f), pZone);
		}
		else if( response == EDIT_RESPONSE_CANCEL && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new f = GetPVarInt(playerid, "GraffitiID");
			graffiti_DeleteMySQL(f);
			GameTextForPlayer(playerid, "~r~Usunieto!",2000, 5);
			graffiti_ZerujZmienne(playerid);
		}
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new player=-1;
    new pip[16];
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        GetPlayerIp(i, pip, sizeof(pip));
        if(strcmp(ip, pip, true)==0)
        {
            player=i;
            break;
        }
    }
    if(!success)
    {
        if(player != -1)
        {
            SendClientMessage(player, COLOR_PANICRED, "Otrzymujesz kicka z powodu nieautoryzowanej próby logowania przez RCON!");
            KickEx(player);
        }
    }
    else
    {
        if(player != -1)
        {
			new name[32]; format(name, sizeof(name), "rcon/%s", GetNick(player));
			if(!dini_Exists(name))
			{
				new str[128];
				format(str, 128, "RCON: U¿ytkownik %s (%d) próbowa³ siê zalogowaæ na rcona bez wymaganych uprawnieñ!", GetNickEx(player), player);
				SendAdminMessage(COLOR_PANICRED, str);
				KickEx(player);
				print(str);
				return 0;
			}
			else
			{
				SendClientMessage(player, COLOR_LIGHTBLUE, "Witaj, Rkornisto");
			}
        }
    }
    return 1;
}

public OnRconCommand(cmd[])
{
    print(cmd);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    if(pickupid == PickupSklep01)
    {
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"|_______________Wybór skina - dostêpne komendy_______________|");
        SendClientMessage(playerid,COLOR_WHITE,"{3CB371}/ubranie{FFFFFF}- zabija i przenosi do zwyk³ego menu wyboru skinów (wybiera³ka). Tylko dla cywili.");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"|___________________________________________________________|");
    }
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new string[256];

	if(!Kajdanki_JestemSkuty[playerid] && (PlayerInfo[playerid][pInjury] > 0 && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)))
	{
		return PlayerEnterVehOnInjury(playerid);
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(GetPVarInt(playerid, "Timer_OnChangingWeapon"))
		{
			AntySpam[playerid] = 0;
			DeletePVar(playerid, "Timer_OnChangingWeapon");
		}
		if(newstate == PLAYER_STATE_DRIVER)
        {
			SetPlayerArmedWeapon(playerid, PlayerInfo[playerid][pGun0]); //anty driveby
        	new vehicleid = GetPlayerVehicleID(playerid);
        	new lcarid = VehicleUID[vehicleid][vUID];
        	if(CarData[lcarid][c_OwnerType] == CAR_OWNER_SPECIAL)
        	{
 				if(CarData[lcarid][c_Owner] == RENT_CAR)
    			{
					if (CarData[lcarid][c_Rang]-1 != playerid)
					{
						new stringDialog[128];
						new costBike = BIKE_COST;
						if(PlayerInfo[playerid][pLevel] == 1)
						{
							format(stringDialog, sizeof(stringDialog), "Bêd¹c nowym graczem, mo¿esz wypo¿yczyæ ten pojazd ca³kowicie za darmo!", costBike);	
						}
						else
						{
							format(stringDialog, sizeof(stringDialog), "Mo¿esz wypo¿yczyæ ten pojazd\nCena: %d$ za 15 minut", costBike);
						}
		    			TogglePlayerControllable(playerid, 0);
						HireCar[playerid] = vehicleid;
						ShowPlayerDialogEx(playerid, 7079, DIALOG_STYLE_MSGBOX, "Wypo¿yczalnia pojazdów", stringDialog, "Wynajmij", "WyjdŸ¸");
					}
				}
			}
			SetPVarInt(playerid, "IsAGetInTheCar", 0); 
			ACv2_DrivingWithoutPremissions(playerid, vehicleid);
		}
        if(!ToggleSpeedo[playerid])
        {
			new pZone[MAX_ZONE_NAME];
    
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);//Dzielnica
			new vehicleid = GetPlayerVehicleID(playerid);
			//new lcarid = VehicleUID[vehicleid][vUID];
			new Float:vHP;
			GetVehicleHealth(vehicleid,vHP);
			new Float:vel[3];
			new Float:vSpeed = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
			if(floatround(vSpeed) > pCruiseSpeed[playerid]) vSpeed = pCruiseSpeed[playerid];

			/*if(CarData[lcarid][c_OwnerType] == CAR_OWNER_GROUP || CarData[lcarid][c_GPS] == 1)
				format(string, 128, "~y~Predkosc: ~w~%d ~w~km/h ~n~~y~Stan: ~w~%d~n~~y~Paliwo: ~w~%d~n~~y~GPS: ~w~%s",floatround(vSpeed),floatround(vHP/10), floatround(Gas[vehicleid]), pZone);
			else
				format(string, 128, "~y~Predkosc: ~w~%d ~w~km/h ~n~~y~Stan: ~w~%d~n~~y~Paliwo: ~w~%d",floatround(vSpeed),floatround(vHP/10), floatround(Gas[vehicleid]));*/
			// TODO: v4.1

			PlayerTextDrawSetPreviewModel(playerid, SpeedometerPDP[playerid][7], GetVehicleModel(vehicleid));
			PlayerTextDrawColor(playerid, SpeedometerPDP[playerid][7], -1);
			PlayerTextDrawShow(playerid, SpeedometerPDP[playerid][7]);
			TextDrawShowForPlayer(playerid, SpeedometerTD[7]);
			UpdateCarInfo(playerid);
        }
        //AT400
        if(Car_GetOwnerType(GetPlayerVehicleID(playerid)) == CAR_OWNER_GROUP && GetVehicleModel(GetPlayerVehicleID(playerid)) == 577 && !IsPlayerInGroup(playerid, FRAC_KT))
        {
            new Float:slx, Float:sly, Float:slz;
    		GetPlayerPos(playerid, slx, sly, slz);
    		SetPlayerPos(playerid, slx, sly, slz+0.2);
    		ClearAnimations(playerid);
        }
		if(IsACopCar(GetPlayerVehicleID(playerid)) && IsAPolicja(playerid, 0)) sendTipMessageEx(playerid, COLOR_BLUE, "Po³¹czy³eœ siê z komputerem policyjnym, wpisz /mdc aby zobaczyæ kartotekê policyjn¹");
        if(newstate == PLAYER_STATE_DRIVER) TJD_CallEnterVeh(playerid, GetPlayerVehicleID(playerid));
    }
    else if(oldstate == PLAYER_STATE_DRIVER)
    {
		if(KradniecieWozu[playerid] == INVALID_VEHICLE_ID) //kradzie¿ aut
		{
			KradniecieWozu[playerid] = 0;
			NieSpamujKradnij[playerid] = 0;
			KradziezTick[playerid] = 0;
			KradziezEtap[playerid] = 0;
		}
		DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        new vehicleid = GetPVarInt(playerid, "car-id");
        if(VehicleUID[vehicleid][vSiren] != 0)
    	{
    	    new sendername[MAX_PLAYER_NAME], komunikat[128];
    	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
     		VehicleUID[vehicleid][vSiren] = 0;
      		GetPlayerName(playerid, sendername, sizeof(sendername));
    		format(komunikat, sizeof(komunikat), "* %s zdejmuje kogut z dachu i chowa.", sendername);
    		ProxDetector(30.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	}
        if(TransportDuty[playerid] > 0) //Taxi duty
		{
            Taxi_FareEnd(playerid);
		}
        TJD_CallExitVeh(playerid);

        if(NieSpamujKradnij[playerid] == 1 || HireCar[playerid] != 0)
        {
            TogglePlayerControllable(playerid, 1);
        }
        //Speedo
        SpeedoHide(playerid);
        //

        #if BLINK_DISABLE_ON_EXIT_VEHICLE == 0
        #else
        if(BlinkSide[GetPVarInt(playerid, "blink-car")] != 2) DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        #endif
	}
    if(oldstate == PLAYER_STATE_PASSENGER)
    {
		if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999) //Taxi client pay
		{
            Taxi_Pay(playerid);
		}
		SpeedoHide(playerid);
    }
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
		{
		    PlayerInKart[playerid] = 0;
		    KartingPlayers --;
		}
		SetPVarInt(playerid, "IsAGetInTheCar", 0); 
		SetPlayerArmedWeapon(playerid, MyWeapon[playerid]); //back weapon antydriveby
	}
	if(newstate == PLAYER_STATE_PASSENGER) // TAXI & BUSSES
	{
		SetPVarInt(playerid, "IsAGetInTheCar", 0);
	    if(GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 27 || GetPlayerWeapon(playerid) == 23)
	    {
	        SetPlayerArmedWeapon(playerid,0);
	    }
	    if(GetPVarInt(playerid, "sanlisten") == 1)
        {
            if(RadioSANUno[0] != EOF)
 				PlayAudioStreamForPlayer(playerid, RadioSANUno);
        }
        else if(GetPVarInt(playerid, "sanlisten") == 2)
        {
            if(RadioSANDos[0] != EOF)
				PlayAudioStreamForPlayer(playerid, RadioSANDos);
        }
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    new vehicleid = GetPlayerVehicleID(playerid);
	    foreach(new i : Player)
	    {
			if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2 && TransportDuty[i] > 0)
			{
				if(kaska[playerid] < TransportValue[i])
				{
					format(string, sizeof(string), "* Potrzebujesz $%d aby wejœæ.", TransportValue[i]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					RemovePlayerFromVehicleEx(playerid);
				}
				else
				{
					if(TransportDuty[i] == 1)
					{
						format(string, sizeof(string), "* Stawka wynosi $%d za kilometr.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed³ do Twojej taryfy.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        if(PlayerInfo[playerid][pLevel] < 3)
                        {
                            ZabierzKaseDone(playerid, floatround(TransportValue[i]/4));//moneycheat
                            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Jesteœ nowym graczem, obowi¹zuje Cie rabat 75 procent na taksówkê.");
                        }
                        else
                        {
                            ZabierzKaseDone(playerid, floatround(TransportValue[i]));//moneycheat
                        }
                        TransportMoney[i] += TransportValue[i];
                        SetPVarInt(playerid, "taxi-slot", GetPlayerVehicleSeat(playerid)-1);
						TransportDist[i] = 0.0;
						TransportDist[playerid] = 0.0;
						TransportDriver[playerid] = i;
                        TransportClient[i][GetPVarInt(playerid, "taxi-slot")] = playerid;
                        Taxi_ShowHUD(playerid);
                        Taxi_ShowHUD(i);
					}
					else if(TransportDuty[i] == 2)
					{
						format(string, sizeof(string), "* Zap³aci³eœ $%d Za bilet.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed³ do autobusu i skasowa³ bilet.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        ZabierzKaseDone(playerid, TransportValue[i]);//moneycheat
					    TransportMoney[i] += TransportValue[i];
					}
				}
			}
	    }
	}
	if(newstate == PLAYER_STATE_WASTED)
	{
		//przeniesiono do onplayerdeath
	}
	if(newstate == PLAYER_STATE_DRIVER) //buggy dont finnish
	{// 38 / 49 / 56 = SS
		new newcar = GetPlayerVehicleID(playerid);
        //NOWY SYSTEM AUT FRAKCYJNYCH I PUBLICZNYCH
        if(newcar <= CAR_End) //do kradziezy
        {
			if(!Iter_Contains(StolenVehicles[playerid], newcar))
		    {
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Mo¿esz ukraœæ ten wóz, wpisz /kradnij aby spróbowaæ to zrobiæ.");
				new engine, lights, alarm, doors, bonnet, boot, objective;
				GetVehicleParamsEx(newcar, engine, lights, alarm, doors, bonnet, boot, objective);
				if(engine) SetVehicleParamsEx(newcar, 0, lights, alarm, doors, bonnet, boot, objective);
			}
        }
		gLastCar[playerid] = newcar;

		

	}
	if(newstate == PLAYER_STATE_SPAWNED)
	{
		if(IsPlayerPremiumOld(playerid)) 
		{ 
		}
		else 
		{ 
		}
		MedicBill[playerid] = 1;
		gPlayerSpawned[playerid] = 1;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
	{
		SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
		return 1;
	}
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
        return 0;
    }
    //AT400
	
    if(Car_GetOwnerType(vehicleid) == CAR_OWNER_GROUP && GetVehicleModel(vehicleid) == 577 && IsPlayerInGroup(playerid, FRAC_KT))
    {
        GameTextForPlayer(playerid, "Wracaj szybko!", 5000, 5);
        SetPlayerPos(playerid, 0.1389+KTAir_Offsets[0],33.2975+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]);
        SetPlayerVirtualWorld(playerid, 2);
        Wchodzenie(playerid);
        SetCameraBehindPlayer(playerid);
    }

    if(GetPVarInt(playerid, "sanlisten") != 0)
    {
        StopAudioStreamForPlayer(playerid);
    }
	if (GetPlayerState(playerid) == 1)
	{
		return 1;
	}
	if(gGas[playerid] == 1)
	{
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Opuscil pojazd", 500, 3);
	}
	if(naprawiony[playerid] == 1)
	{
	    naprawiony[playerid] = 0;
	}
	if(IDWymienianegoAuta[playerid] != 0)
	{
	    IDWymienianegoAuta[playerid] = 0;
	}
	if(KradniecieWozu[playerid] == INVALID_VEHICLE_ID)
	{
		KradniecieWozu[playerid] = 0;
		NieSpamujKradnij[playerid] = 0;
		KradziezTick[playerid] = 0;
		KradziezEtap[playerid] = 0;
	}
	if(!Kajdanki_JestemSkuty[playerid] && (PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)) //inna animacja dla bw
	{
		PlayerExitVehOnInjury(playerid);
		return FreezePlayerOnInjury(playerid);
	}
	return 1;
}


public OnPlayerRequestSpawn(playerid)
{
    //Zwrócenie 0 uniemo¿liwi spawn.
	if(IsPlayerNPC(playerid)) return 1;
	if(gPlayerLogged[playerid] != 1)
	{

	}
	else
	{

	}
    return 0;
}
public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
	{
		SetPVarInt(playerid, "spawn", 1);
		return 1;
	}

	SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 0.0, -1, -1, -1, -1, -1, -1);

	if(gPlayerLogged[playerid] != 1)
	{
		TogglePlayerSpectating(playerid, true);
		SetTimerEx("OPCLogin", 100, 0, "i", playerid);

		//Dla graczy którzy nie maj¹ najnowszej wersji samp'a
		PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);

		new rand = random(5);
		switch(rand)
		{
			case 0:
			{
				PlayerPlaySound(playerid, 171, 0.0, 0.0, 0.0);
			}
			case 1:
			{
				PlayerPlaySound(playerid, 176, 0.0, 0.0, 0.0);
			}
			case 2:
			{
				PlayerPlaySound(playerid, 1076, 0.0, 0.0, 0.0);
			}
			case 3:
			{
				PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
			}
			case 4:
			{
				new rand2 = random(8);
				switch(rand2)
				{
					case 0:
					{
						PlayerPlaySound(playerid, 157, 0.0, 0.0, 0.0);
					}
					case 1:
					{
						PlayerPlaySound(playerid, 162, 0.0, 0.0, 0.0);
					}
					case 2:
					{
						PlayerPlaySound(playerid, 169, 0.0, 0.0, 0.0);
					}
					case 3:
					{
						PlayerPlaySound(playerid, 178, 0.0, 0.0, 0.0);
					}
					case 4:
					{
						PlayerPlaySound(playerid, 180, 0.0, 0.0, 0.0);
					}
					case 5:
					{
						PlayerPlaySound(playerid, 181, 0.0, 0.0, 0.0);
					}
					case 6:
					{
						PlayerPlaySound(playerid, 147, 0.0, 0.0, 0.0);
					}
					case 7:
					{
						PlayerPlaySound(playerid, 140, 0.0, 0.0, 0.0);
					}
				}
			}
		}
	}
	else
	{
		TogglePlayerSpectating(playerid, true);
		TogglePlayerSpectating(playerid, false);
	}
	return 0;
}

PayDay()
{
	new string[128], account,playername2[MAX_PLAYER_NAME],
        ebill;

	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLevel] > 0)
		    {
				LVLPayDay(i);
			    if(MoneyMessage[i]==1)
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "Nie sp³aci³eœ d³ugu, wierzyciele nas³ali na ciebie Policjê !");
					PoziomPoszukiwania[i] += 2;
					SetPlayerCriminal(i,INVALID_PLAYER_ID, "Niesp³acanie d³ugu");
				}
				GetPlayerName(i, playername2, sizeof(playername2));
				account = PlayerInfo[i][pAccount];

				if(PlayerInfo[i][pPayDay] >= 5)
				{
				    if(PlayerInfo[i][pAdmin] >= 1)
				    {
				        format(string, sizeof(string), "Admini/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
				    else if (PlayerInfo[i][pZG] >= 1)
				    {
				        format(string, sizeof(string), "Zaufani/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
					if(!IsPlayerPaused(i) && AFKTime[i] < 900 && IdleCount[i] < MAX_IDLE_COUNT)
					{
						Tax += TaxValue;//Should work for every player online
						PlayerInfo[i][pAccount] -= TaxValue;
						PlayerInfo[i][pExp]++;
						PlayerPlayMusic(i);
						new wyplata_duty = 0;
						if(GroupPlayerDutyPerm(i, PERM_POLICE) || GroupPlayerDutyPerm(i, PERM_MEDIC) || GroupPlayerDutyPerm(i, PERM_TAXI) //frakcje, które maj¹ dostêp do wyp³at
						|| GroupPlayerDutyPerm(i, PERM_RESTAURANT) //biznesy
						|| GroupPlayerDutyPerm(i, PERM_PAYDAY))	   //inne grupy
						{
							if(OnDuty[i] > 0)
							{
								if(PlayerInfo[i][pDutyTime] >= 1800 && GetPVarInt(i, "duty-act")+1800 < PlayerInfo[i][pDutyTime]) //30 minut
								{
									new ginfo[64];
									format(ginfo, sizeof ginfo, "(GRUPA: %s)", GroupInfo[GetPlayerGroupUID(i, OnDuty[i]-1)][g_ShortName]);
									if(IsPlayerInGroup(i, FRAC_FBI)){
										wyplata_duty = RandomEx(PRICE_PAYDAY_MIN_FBI, PRICE_PAYDAY_MAX_FBI);
									}
									else{
										wyplata_duty = RandomEx(PRICE_PAYDAY_MIN, PRICE_PAYDAY_MAX);
									}
									DajKaseDone(i, wyplata_duty);
									SetPVarInt(i, "duty-act", PlayerInfo[i][pDutyTime]);
									Log(payLog, WARNING, "%s otrzyma³ %d$ za s³u¿be %s", GetPlayerLogName(i), wyplata_duty, ginfo);
								}
								else
									SendClientMessage(i, COLOR_GRAD1, "  Nie przegra³eœ wystarczaj¹co minut na duty, ¿eby otrzymaæ wyp³atê.");
							}
						}
						SendClientMessage(i, COLOR_WHITE, "|___ STAN KONTA ___|");
						format(string, sizeof(string), "  Wyp³ata za s³u¿bê: $%d   Podatek: -$%d", wyplata_duty, TaxValue);
						SendClientMessage(i, COLOR_GRAD1, string);
						if(PlayerInfo[i][pDom] != 0 || PlayerInfo[i][pPbiskey] != 255)
						{
							ebill = (PlayerInfo[i][pAccount]/10000)*(PlayerInfo[i][pLevel]);
							format(string, sizeof(string), "  Rachunek za pr¹d: -$%d", ebill);
							SendClientMessage(i, COLOR_GRAD1, string);
							
							//DajKase(i, checks);
							if(PlayerInfo[i][pAccount] > 0)
							{
								PlayerInfo[i][pAccount] -= ebill;
							}
							else
							{
								ebill = 0;
							}
						}
						format(string, sizeof(string), "  Stan konta: $%d", account);
						SendClientMessage(i, COLOR_GRAD1, string);
						SendClientMessage(i, COLOR_GRAD4, "|--------------------------------------|");
						format(string, sizeof(string), "  Nowy Stan Konta: $%d", PlayerInfo[i][pAccount]);
						SendClientMessage(i, COLOR_GRAD5, string);
						format(string, sizeof(string), "  Wynajem: -$%d", Dom[PlayerInfo[i][pWynajem]][hCenaWynajmu]);
						SendClientMessage(i, COLOR_GRAD5, string);
						BusinessPayDay(i);  
						format(string, sizeof(string), "~y~Wyplata");
						GameTextForPlayer(i, string, 5000, 1);
						PlayerInfo[i][pPayDay] = 0;
						PlayerInfo[i][pPayCheck] = 0;
						PlayerInfo[i][pConnectTime] += 1;
						PlayerGames[i] = 0;
                    	MRP_PremiumHours[i]++;
					} 
					else 
					{
						SendClientMessage(i, COLOR_LIGHTRED, "* By³eœ AFK zbyt d³ugo, aby dostaæ wyp³atê.");
					}

					if(PlayerInfo[i][pBP] >= 1)
					{
					    PlayerInfo[i][pBP]--;
					}
					if(((kaska[i] >= 10000000 || PlayerInfo[i][pAccount] >= 10000000) && PlayerInfo[i][pLevel] <= 2) && !DEVELOPMENT)
					{
						//MruMySQL_Banuj(i, "10MLN i 1 lvl");
						AddPunishment(i, GetNick(i), -1, gettime(), PENALTY_BAN, 0, "10MLN i 1 lvl", 0);
						Log(punishmentLog, WARNING, "%s dosta³ bana za 10MLN i 1 lvl (Portfel: %d$, Bank: %d$)", GetPlayerLogName(i), kaska[i], PlayerInfo[i][pAccount]);
						KickEx(i);
					}
					if(IsPlayerPremiumOld(i))
					{
					    PlayerInfo[i][pPayDayHad] += 1;
					    if(PlayerInfo[i][pPayDayHad] >= 5)
					    {
					        PlayerInfo[i][pExp]++;
					        PlayerInfo[i][pPayDayHad] = 0;
					    }
					}
					SetWeatherEx(2+random(19));//Pogoda dla ka¿dego
					if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)//Zerowanie pogody dla graczy w intkach
					{
						SetInteriorTimeAndWeather(i);
					}
     				if(PoziomPoszukiwania[i] >= 10)
					{
						PoziomPoszukiwania[i] = 9;
					}
					else if(PoziomPoszukiwania[i] == 0)
					{
                    	PoziomPoszukiwania[i] = 0;
                    }
                    else
					{
						PoziomPoszukiwania[i] -= 1;
						if(IsPlayerPremiumOld(i))
						{
							if(PoziomPoszukiwania[i] == 0){
								PoziomPoszukiwania[i] = 0;
							}else{
								PoziomPoszukiwania[i] -= 1;
							}
						}
						format(string, sizeof(string), "  Aktualny poziom poszukiwania to %d", PoziomPoszukiwania[i]);
						SendClientMessage(i, COLOR_WHITE, string);
					}

				}
				else
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "* Nie grasz wystarczaj¹co d³ugo, aby dostaæ wyp³atê.");
				}
				SetPlayerWantedLevel(i, PoziomPoszukiwania[i]);
			}
		}
	}
    printf("-> Updating GangZones");
    Zone_GangUpdate(true);
    printf("-> Removing Houses MapIcons");

	for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
	{
		DestroyDynamicMapIcon(Dom[i][hIkonka]);
	}
	new hour,minuite,second;
	new rand = random(80);
	gettime(hour,minuite,second);
    FixHour(hour);
	if(10 <= shifthour <= 22)
	{
	 	if(rand == 0) rand = 1;
        printf("-> Starting lotto");
	  	Lotto(rand);
	}
  	SendClientMessageToAll(COLOR_YELLOW, "Odliczanie do respawnu rozpoczête");
	BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
	BroadCast(COLOR_PANICRED, "Aby twoje ostatnio uzywane auto nie zostalo zrespawnowane wpisz /norespawn!");
    printf("-> Doing respawn");
	CountDownVehsRespawn();
	SendRconCommand("reloadlog");
	SendRconCommand("reloadbans");
	
	if(DmvActorStatus && (shifthour < 9 || shifthour > 23))
	{
		DestroyActorsInDMV(); 
	}
	else
	{
		CreateActorsInDMV(INVALID_PLAYER_ID);
	}

	UpdateRybyTop();
	if(shifthour == 3)
	{
	    SendClientMessageToAll(COLOR_YELLOW, "Trwa aktualizacja systemu domów, czas na laga");
	    for(new h; h <= dini_Int("Domy/NRD.ini", "NrDomow"); h++)
	    {
			Dom[h][hData_DD] ++;
			if(Dom[h][hData_DD] >= 30)
			{
			    ZlomowanieDomu(9999, h);
			    Log(serverLog, WARNING, "Dom %s zosta³ zez³omowany z powodu up³ywu czasu.", GetHouseLogName(h));
			}
	    }
		ZapiszDomy();
	}
	else if(shifthour == 4)
	{
	    foreach(new i : Player)
		{
			Kick(i);
		}
	    ZapiszDomy();
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
        SendClientMessageToAll(COLOR_YELLOW, "RESET");
        SendRconCommand("gmx");
	} 
	else if(shifthour == 8)
	{
		Motel_GetAllRent();
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{	
	if(IsPlayerNPC(playerid)) return 1;
	ZoneCheck(playerid);
	if((PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) && IsPlayerAimingEx(playerid))
	{
		return FreezePlayerOnInjury(playerid);
	}

	if(GetPVarInt(playerid, "showchangelog") == 1 && gPlayerLogged[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);
		if(ud == KEY_UP || ud == KEY_DOWN || lr == KEY_LEFT || lr == KEY_RIGHT)
		{
			SetPVarInt(playerid, "showchangelog", 0);
			ShowPlayerDialogEx(playerid, D_SERVERINFO, DIALOG_STYLE_MSGBOX, MruTitle("Changelog"), Changelog, "OK", "");
		}
	}

    systempozarow_OnPlayerUpdate(playerid);//System Po¿arów v0.1

	//Anty BH
	if(GetPVarInt(playerid, "Jumping") == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerVelocity(playerid, x, y, z);
		if(z > 0.05)
		{
			SetPlayerVelocity(playerid, x*0.4, y*0.4, z);
			SetPVarInt(playerid, "Jumping", -1);
		}
	}

    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        new model = GetVehicleModel(veh);
        if(model == 425 || model == 432)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_FIRE))
			{
				return 0; //desycn missile
			}
        }
        else if(model == 520)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_ACTION))
			{
				return 0; //desycn hydra missile
			}
        }
    }
    new vid = GetPlayerVehicleID(playerid);
    if(vid > 0)
    {
        if(vid != LastVehicleID[playerid])
        {
            if(GetTickDiff(GetTickCount(), VehicleIDChangeTime[playerid]) < 2000)
            {
                VehicleIDChanges[playerid]++;
                if(VehicleIDChanges[playerid] > MAX_VEHICLE_ID_CHANGES)
                {
                    GetPlayerPos(playerid, czitX, czitY, czitZ);
                    if(GetPVarInt(playerid, "ACmessaged") == 0)
                    {
                        format(acstr, 128, "%s mo¿e lagowaæ autami i dosta³ kicka U¿yj /gotoczit aby to sprawdziæ!", GetNickEx(playerid));
                        SendAdminMessage(COLOR_P@, acstr);
                        SetPVarInt(playerid, "ACmessaged", 1);
                    }
					if(!IsPlayerNPC(playerid)) Kick(playerid);
                    return 0;
                }
            }
            else VehicleIDChanges[playerid] = 1;
        }
        LastVehicleID[playerid] = vid;
        VehicleIDChangeTime[playerid] = GetTickCount();
    }
    //
    if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickDiff(GetTickCount(), noclipdata[playerid][lastmove]) > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
                if(noclipdata[playerid][fireobject] != 0) StopDynamicObject(noclipdata[playerid][fireobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        new keys, ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(ud == KEY_DOWN) Oil_OnPlayerPress(playerid, KEY_DOWN);
        else if(ud == KEY_UP) Oil_OnPlayerPress(playerid, KEY_UP);
        if(lr == KEY_RIGHT) Oil_OnPlayerPress(playerid, KEY_RIGHT*2);
        else if(lr == KEY_LEFT) Oil_OnPlayerPress(playerid, KEY_LEFT*2);
    }
	if(GetPVarInt(playerid, "timer_CruiseControl") && pCruiseCanChange[playerid] == 1)
    {
        new keys, ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(ud == KEY_DOWN) CruiseControl_SetSpeed(playerid, 10, false);
        else if(ud == KEY_UP) CruiseControl_SetSpeed(playerid, 10, true);
    }
	if(Spectate[playerid] != INVALID_PLAYER_ID && !GetPVarInt(playerid, "OnSpecChanging"))
    {
		new keys, ud,lr, actualid = INVALID_PLAYER_ID;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(lr == KEY_RIGHT) //NEXT
		{
			foreach(new i : Player)
			{
				if(i == playerid || PlayerInfo[i][pAdmin] >= 1) continue;
				if(actualid != INVALID_PLAYER_ID) //if is set
				{
					new str[6];
                	valstr(str, i);
                    RunCommand(playerid, "/spec",  str);
					break;
				}
                else if(i == Spectate[playerid]) //if not set and expect
				{
					actualid = i;
				}
            }
		}
		return 1;
    }
	return 1;
}

OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "IsDownloadingContent") == 1) DeletePVar(playerid, "IsDownloadingContent");
		MruMySQL_CreateAccount(playerid, password);
		OnPlayerLogin(playerid, password);
	}
	return 1;
}

public OnPassswordVerify(playerid,bool:success){
    new nick[MAX_PLAYER_NAME], string[512];
	GetPlayerName(playerid, nick, sizeof(nick));
	//success = true; // DO USUNIÊCIA [DEBUG]
 	if(success){
		//poprawne has³o

		//----------------------------
		//³adowanie konta i zmiennych:
		//----------------------------

		if( !MruMySQL_LoadAccount(playerid) )
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Krytyczny b³¹d konta. Zg³oœ zaistnia³¹ sytuacjê na forum.");
			Log(serverLog, ERROR, "Krytyczny b³¹d konta %s (pusty rekord?)", nick);
			KickEx(playerid);
			return 1;
		}
		
		//Sprawdzanie banów
		if(CheckBan(GetAccountIP(playerid), PlayerInfo[playerid][pGID]) || CheckBlock(PlayerInfo[playerid][pUID], BLOCK_BAN) || CheckBlock(PlayerInfo[playerid][pUID], BLOCK_CHAR_BAN)) {
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest zbanowane, nie mo¿esz na nim graæ.");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeœli uwa¿asz, ¿e konto zosta³o zbanowane nies³usznie napisz apelacje na: {33CCFF}www.Kotnik-RP.pl");
			KickEx(playerid);
			return 1;
		}
		
		//Sprawdzanie blocków:
		if(CheckBlock(PlayerInfo[playerid][pUID], BLOCK_CHAR) || CheckBlock(PlayerInfo[playerid][pUID], BLOCK_CHAR_BAN)) {
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest zablokowane, nie mo¿esz na nim graæ.");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeœli uwa¿asz, ¿e konto zosta³o zablokowane nies³usznie napisz apelacje na: {33CCFF}www.Kotnik-RP.pl");
			KickEx(playerid);
			return 1;
		}
		
		//Sprawdzanie warnów:
		if(PlayerInfo[playerid][pWarns] >= 3)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Twoje konto zosta³o zbanowane/zablokowane z powodu przekroczenia limtu warnów!");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeœli uwa¿asz, ¿e konto zosta³o zbanowane/zablokowane nies³usznie napisz apelacje na: {33CCFF}www.Kotnik-RP.pl");
			KickEx(playerid);
			return 1;
		}
		else if(PlayerInfo[playerid][pWarns] < 0) PlayerInfo[playerid][pWarns] = 0;

		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && i != playerid)
			{
				if(gPlayerLogged[i])
				{
					if(PlayerInfo[playerid][pUID] == PlayerInfo[i][pUID])
					{
						SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest ju¿ zalogowane.");
						KickEx(playerid);
						return 1;
					}
				}
			}
		}

		//Nadawanie pieniêdzy:
		ResetujKase(playerid);
		if(PlayerInfo[playerid][pCash] < 0)
		{
			if(PlayerInfo[playerid][pWL] < 9)
			{
				PlayerInfo[playerid][pWL]++; 
				sendTipMessage(playerid, "Masz d³ugi pieniê¿ne wobec pañstwa, twój poziom poszukiwania roœnie."); 
			}
			if(PlayerInfo[playerid][pWL] >= 9)
			{
				PlayerInfo[playerid][pWL] = 10; 
				sendTipMessage(playerid, "Masz ju¿ 10 poziom poszukiwania! Czêœæ jest spowodowana d³ugami! Zrób coœ z tym!"); 
			}
			ZabierzKaseDone(playerid, -PlayerInfo[playerid][pCash]);
		}
		else if(PlayerInfo[playerid][pCash] >= 0)
		{
			DajKaseDone(playerid, PlayerInfo[playerid][pCash]); 
		}
		//Ustawianie na zalogowany:
		gPlayerLogged[playerid] = 1; 
		new GPCI[41];
		gpci(playerid, GPCI, sizeof(GPCI));
		Log(connectLog, WARNING, "Gracz %s[id: %d, ip: %s, gpci: %s] zalogowa³ siê na konto", GetPlayerLogName(playerid), playerid, GetIp(playerid), GPCI);
		Car_LoadForPlayer(playerid); //System aut
		LoadPlayerItems(playerid); //System przedmiotów
		MruMySQL_LoadPhoneContacts(playerid); //Kontakty telefonu
		//Command_SetPlayerDisabled(playerid, false); //W³¹czenie komend
		CorrectPlayerBusiness(playerid);
		CheckPlayerBusiness(playerid);
		htTextDrawShow(playerid);
		
		//Lider
		Load_MySQL_Leader(playerid); 
		AC_OnPlayerLogin(playerid);
		//Frakcyjny GPS
		GPS_Load(playerid);
		//Powitanie:
		if(!IsPlayerNPC(playerid)){
			new join[128];
			format(join, sizeof(join), "[Join] %s (%d) zalogowa³ siê na serwer.", GetNickEx(playerid), GetPlayerIDFromName(GetNick(playerid)));
			OOCJoin(join);
		}
		g_ProtectionEnabled[playerid] = true;
    	SetTimerEx("DisableProtection", 10000, false, "i", playerid); // 10 sekund (10000 milisekund)
		format(string, sizeof(string), "Witaj na serwerze Kotnik Role Play, %s!",nick);
		SendClientMessage(playerid, COLOR_WHITE,string);
		printf("%s has logged in.",nick);
		if (IsPlayerPremiumOld(playerid))
		{
			SendClientMessage(playerid, COLOR_WHITE,"Jesteœ posiadaczem {E2BA1B}Konta Premium.");
		}
		else if(GetPVarInt(playerid, "got-compensation") == 0)
		{
			//SendClientMessage(playerid, COLOR_WHITE, "Mo¿esz odebraæ rekompensatê za poprzednie problemy techniczne za pomoc¹ {E2BA1B}/rekompensata");
		}
 	} else {
		//z³e has³o
		SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z³e has³o.");

		format(string, sizeof(string), "{adc7e7}Witaj na Kotnik-RP.pl, serwerze o wielkich mo¿liwoœciach\nZaloguj siê lub do³¹cz ju¿ dzisiaj do nas i baw siê razem z nami w œwiecie GTA.\n\nKonto o takim nicku jest ju¿ stworzone.\nJest Twoja? Wpisz has³o i zaloguj siê.\nJe¿eli nie wyjdŸ i wejdŸ na nowym nicku!", nick);
		ShowPlayerDialogEx(playerid, 230, DIALOG_STYLE_PASSWORD, "Logowanie", string, "Zaloguj", "WyjdŸ¸");
		gPlayerLogTries[playerid] += 1;
		if(gPlayerLogTries[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z³e has³o. Zostajesz zkickowany.");
			ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "{FF0000}Dosta³eœ kicka za wpisanie z³ego has³a 3 razy pod rz¹d!", "WyjdŸ¸", "");
			KickEx(playerid);
		}
		return 1;
 	}
	//Nadawanie pocz¹tkowych itemów po rejestracji:
	if(PlayerInfo[playerid][pReg] == 0)
	{
		PlayerInfo[playerid][pLevel] = 1;
		PlayerInfo[playerid][pSHealth] = 0.0;
		PlayerInfo[playerid][pHealth] = 100.0;
		PlayerInfo[playerid][pPos_x] = 2246.6;
		PlayerInfo[playerid][pPos_y] = -1161.9;
		PlayerInfo[playerid][pPos_z] = 1029.7;
		PlayerInfo[playerid][pInt] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pTeam] = 3;
		PlayerInfo[playerid][pUniform] = 0;
		PlayerInfo[playerid][pJobSkin] = 0; 
		PlayerInfo[playerid][pDom] = 0;
		PlayerInfo[playerid][pPbiskey] = 255;
		PlayerInfo[playerid][pAccount] = 25;
		PlayerInfo[playerid][pReg] = 1;
		PlayerInfo[playerid][pDowod] = 0;
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		PlayerInfo[playerid][pBusinessMember] = INVALID_BIZ_ID; 
		DajKaseDone(playerid, 25);
	}

	premium_loadForPlayer(playerid);

	//Przywracanie Poziomu Poszukiwania
        //Punkty karne
    if (PlayerInfo[playerid][pWL] >= 10000)
    {
        string="\0";
        new lPunkty[8];
        PlayerInfo[playerid][pWL]-=10000;
        valstr(string, PlayerInfo[playerid][pWL]);
        if(strlen(string) == 3) strmid(lPunkty, string, 0, 1);
        else if(strlen(string) == 4) strmid(lPunkty, string, 0, 2);
        PlayerInfo[playerid][pPK] = strval(lPunkty);
        if(strlen(string) == 3) strmid(lPunkty, string, 1, 3);
        else if(strlen(string) == 4) strmid(lPunkty, string, 2, 4);
        PlayerInfo[playerid][pWL] = strval(lPunkty);
    }

	if (PlayerInfo[playerid][pWL] >= 1)
	{
        if(PlayerInfo[playerid][pWL] > 100) PlayerInfo[playerid][pWL] = 0;
        else
        {
    		PoziomPoszukiwania[playerid] = clamp(PlayerInfo[playerid][pWL], 0, 10);
    		format(string, sizeof(string), "Twój poziom poszukiwania zosta³ przywrócony do %d.",PlayerInfo[playerid][pWL]);
    		SendClientMessage(playerid, COLOR_WHITE,string);
        }
	}


	
	choroby_OnPlayerLogin(playerid);

	//obiekty
	PlayerAttachments_LoadItems(playerid);
	LoadPlayerTattoo(playerid);

	//Odbugowywanie domów:
    if(PlayerInfo[playerid][pDom] != 0)
    {
    	NaprawSpojnoscWlascicielaDomu(playerid);
		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0;
    	if(Dom[PlayerInfo[playerid][pDom]][hPDW] < 0) Dom[PlayerInfo[playerid][pDom]][hPDW] = 0;//naprawa wynajmu
    	if(Dom[PlayerInfo[playerid][pDom]][hPW] < 0) Dom[PlayerInfo[playerid][pDom]][hPW] = 0;
		ZapiszDom(PlayerInfo[playerid][pDom]);
	}

	//Spawnowanie gracza
	SetTimerEx("AntySB", 5000, 0, "d", playerid); //by nie kickowa³o timer broni
	AntySpawnBroni[playerid] = 5;
	GUIExit[playerid] = 0;
	SetPlayerVirtualWorld(playerid, 0);

    Zone_Sync(playerid);
    if(strlen(ServerInfo) > 1) TextDrawShowForPlayer(playerid, TXD_Info); //Show info

    //Konwersja pojazdów:
    //CONVERT_PlayerCar(playerid);

	//Teleportacja do poprzedniej pozycji:
	if (PlayerInfo[playerid][pTut] == 1)
	{
        if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0 || IsAScripter(playerid))
        {
            if(PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] > 0)
            {
                SetPVarInt(playerid, "support_duty", 1);
                SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Stawiasz siê na s³u¿bie nowym graczom. Aby sprawdziæ zg³oszenia wpisz {00FF00}/supporty lub /reporty");
            }
			else if(PlayerInfo[playerid][pAdmin] > 0)
			{
				SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Aby widzieæ zg³oszenia z /supporty lub /reporty wpisz {FF0000}/adminduty");
			}

			if(GetPVarInt(playerid, "ChangingPassword") != 1)
				ShowPlayerDialogEx(playerid, 235, DIALOG_STYLE_INPUT, "Weryfikacja", "Logujesz siê jako cz³onek administracji. Zostajesz poproszony o wpisanie w\nponi¿sze pole has³a weryfikacyjnego. Pamiêtaj, aby nie podawaæ go nikomu!", "Weryfikuj", "WyjdŸ¸");
        }
        else if(PlayerInfo[playerid][pJailed] == 0)
        {
    		lowcap[playerid] = 1;
			if(GetPVarInt(playerid, "ChangingPassword") != 1){
				SetPVarInt(playerid, "spawn", 1);
				SetPlayerSpawn(playerid);
				TogglePlayerSpectating(playerid, false);
				ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_MSGBOX, "Serwer", "Czy chcesz siê teleportowaæ do poprzedniej pozycji?", "TAK", "NIE");
			}
        }
        else
        {
            SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
            SetPlayerSpawn(playerid);
			TogglePlayerSpectating(playerid, false);
        }
	}
    else
    {
        SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
		gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
		PlayerInfo[playerid][pMuted] = 1;
		TogglePlayerControllable(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		GUIExit[playerid] = 0;
		TutTime[playerid] = 123;
    }
	new lStr[258];
	format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `connected`='1', `online`='1' WHERE `UID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(lStr);
	return 1;
 }


OnPlayerLogin(playerid, password[])
{
	new string[128], accountPass[200], salt[200];
    
	MruMySQL_ReturnPassword(GetNick(playerid), accountPass, salt);
	format(string, sizeof(string), "%s%s", MD5_Hash(salt, true), MD5_Hash(password, true));
	format(string, sizeof(string), "%s", MD5_Hash(string, true));
	if(strcmp(string, accountPass) == 0) OnPassswordVerify(playerid, true);
	else OnPassswordVerify(playerid, false);
}


public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	OnPlayerKeyStateChangeNarko(playerid, newkeys);
	OnPlayerKeyStateChangeNarko2(playerid, newkeys);
	GazeciarzOnPlayerKey(playerid, newkeys);
	if(newkeys==KEY_YES) //Klawisz Y
	{
		if(IsPlayerInRangeOfPoint(playerid,3,1479.4830,-1672.9886,14.0469)) //Kod od mikolaja
		{
			if(PlayerInfo[playerid][pMikolaj] == 1)
			{
				sendTipMessage(playerid, "Odebra³eœ ju¿ prezent!");
				return 0;
			}
			else
			{
				new name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				new losowyprezent = RandomEx(1, 3);
				if(losowyprezent == 1)
				{
					sendTipMessage(playerid, "Dosta³eœ prezent startowy, 25$ wlecia³o do twojej kieszeni!");
					DajKaseDone(playerid, 25);
					PlayerInfo[playerid][pMikolaj] = 1;
					printf("[PREZENT STARTOWY] Gracz: %s[%d] odebral 25$", name, playerid);
				}
				if(losowyprezent == 2)
				{
					DajKP(playerid, gettime()+86400, true);
					sendTipMessage(playerid, "Dosta³eœ prezent startowy, premium na okres 1 dni jest twoje!");
					PlayerInfo[playerid][pMikolaj] = 1;
					printf("[PREZENT STARTOWY] Gracz: %s[%d] odebral premium na 1 dni", name, playerid);
				}
				if(losowyprezent == 3)
				{
					PremiumInfo[playerid][pMC] += 10;
					mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+10 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));
					sendTipMessage(playerid, "Dosta³eœ prezent startowy, 10 kotnik coinsów jest w twoim portfelu!");
					PlayerInfo[playerid][pMikolaj] = 1;
					printf("[PREZENT STARTOWY] Gracz: %s[%d] odebral 10 kotnik coinsow", name, playerid);
				}
			}
		}
	}
	//09.06.2014
    if(Teleturniejstart == 1)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2,679.1998, -1336.1652, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,679.9750, -1339.5018, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,678.9643, -1342.8322, 30.3864))
	    {
		    if(!IsPlayerInAnyVehicle(playerid))
		    {
		        if(GetPlayerVirtualWorld(playerid) == 21)
		        {
		            if(newkeys & KEY_SPRINT)
		            {
						if(grajacy[playerid] == 1)
						{
			                new ImieGracza[MAX_PLAYER_NAME],string[64];
							GetPlayerName(playerid, ImieGracza, sizeof(ImieGracza));
							format(string, sizeof(string), "* %s naciska przycisk na stoliku",ImieGracza);
							ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Teleturniejstart = 0;
							grajacy[playerid] = 0;
                            return 0;
						}
		            }
		        }
		    }
		}
	}
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid, "obezwladniony")-15 > gettime())
    {
        if(HOLDING(KEY_SPRINT))
        {
			ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 1, 1, 1, -1);
        }
    }

   	if(PRESSED(KEY_JUMP) && Spectate[playerid] != INVALID_PLAYER_ID)
    {
		PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
		PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
		SetPlayerToTeamColor(playerid);
		SetPhoneOnline(playerid, 1);
		MedicBill[playerid] = 0;
		Spectate[playerid] = INVALID_PLAYER_ID;
		GameTextForPlayer(playerid, "L O A D I N G", 1000, 3);
		TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
        SetTimerEx("SpecEnd", 500, false, "d", playerid);
		return 0;
    }
    //30.10
    if(HOLDING(KEY_ANALOG_UP))
    {
        new veh = GetPlayerVehicleID(playerid);
        if(veh != 0)
        {
            if(CarData[VehicleUID[veh][vUID]][c_Owner] == FRAC_KT && CarData[VehicleUID[veh][vUID]][c_OwnerType] == CAR_OWNER_FRACTION)
            {
                if(GetVehicleModel(veh) == 530) TJD_TryPickup(playerid, veh);
            }
        }
    }
    //12.07 TRAIN HORN
    if(PRESSED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 0)
        {
            new veh;
            if((veh = GetPlayerVehicleID(playerid)) != 0)
            {
                if(GetVehicleModel(veh) == 538 || GetVehicleModel(veh) == 537)
                {
                    if(GetPlayerVehicleSeat(playerid) == 0)
                    {
                        SetPVarInt(playerid, "horn", 1);
                        if(TRAIN_HornTimer == 0)
                        {
                            TRAIN_HornTimer = SetTimerEx("TRAIN_DoHorn", 500, 1, "i", veh);
                            TRAIN_DoHorn(veh);
                            return 0;
                        }
                    }
                }
            }
        }
    }
    else if(RELEASED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 1)
        {
            if(TRAIN_HornTimer != 0) KillTimer(TRAIN_HornTimer);
            TRAIN_HornTimer=0;
            SetPVarInt(playerid, "horn", 0);

			foreach(new i : Player)
            {
                if(GetPVarInt(i, "train-horn") == 1)
                {
                    PlayerPlaySound(i, 8199, 0.0, 0.0, 0.0);
                    SetPVarInt(i, "train-horn", 0);
                }
            }
            return 0;
        }
    }
    //BLINK
    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        if(GetPlayerVehicleSeat(playerid) == 0)
        {
        	if(PRESSED(KEY_LOOK_LEFT))
            {
    			if(!IsCarBlinking(veh)) SetCarBlinking(veh, 0), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}
        	else if(PRESSED(KEY_LOOK_RIGHT))
            {
    		    if(!IsCarBlinking(veh)) SetCarBlinking(veh, 1), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}

            if(IsCarBlinking(veh))
            {
                new Float:a, Float:b = BlinkR[veh];
                GetVehicleZAngle(veh, a);

                if(BlinkSide[veh] == 0)
                {
                    b+=BLINK_TURN_ANGLE;
                    if(b > 360.0) b -=360.0;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a > b) DisableCarBlinking(veh);
                }
                else if(BlinkSide[veh] == 1)
                {
                    b-=BLINK_TURN_ANGLE;
                    if(b < 0.0) b = 360.0 + b;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a < b) DisableCarBlinking(veh);
                }
            }
        }
    }
    //Kolczatki
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(IsAPolicja(playerid) && !KolDelay[veh])
        {
            if(IsACopCar(veh) && !IsABike(veh) && !IsAPlane(veh) && !IsABoat(veh))
            {
                if(PRESSED(KEY_ANALOG_DOWN)) //2
                {
                    new id = Kolczatka_GetID();
                    if(id != -1)
                    {
                        new Float:h, Float:a, Float:b, Float:x, Float:y, Float:z, vehid = GetPlayerVehicleID(playerid), Float:rot;
                        GetVehiclePos(vehid, x, y, z);
                        GetVehicleZAngle(vehid, rot);
                        x-=2.0*floatsin(-rot, degrees);
                        y-=2.0*floatcos(-rot, degrees);
                        GetVehicleRotation(vehid, h, a, b);
                        if(floatabs(b) > 15.0)
						{
							return 1;
						}
                        //z -= 0.5;
                        z = (b > 0) ? (z - floatcos(b, degrees)) : (z + floatsin(b, degrees));
                        if(-10.0 <= b <= 10.0) z = (b>0) ? (z+ floatabs((b-10)/20)) : (z- ((b+10)/20));
                        KolID[id] = CreateDynamicObject(2892, x, y, z, a, b, rot-90);
                        KolTime[id] = gettime()+KOLCZATKA_CZAS;
                        KolArea[id] = CreateDynamicCylinder(x, y, z-10, z+10, 4.0);
                        KolDelay[veh] = true;
                        KolVehicle[id] = veh;
                        return 0;
                    }
                }
            }
        }
    }

    //
	if((GetPVarInt(playerid, "podglada-stats") == 1) && newkeys==KEY_ACTION)
	{
		SetPVarInt(playerid, "podglada-stats", 0); 
		HideStats2(playerid);
	}
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
		{
			SendClientMessage(playerid,0x00FFFFFF, "Próbujesz podczepiæ pojazd");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!found))
			{
				vid++;
				GetVehiclePos(vid,vX,vY,vZ);
                if(vid == 1) continue;
				if ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
				{
					found=1;
					if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
						SendClientMessage(playerid,COLOR_BROWN, "Pojazd odczepiony");
                        break;
					}
					AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
					SendClientMessage(playerid,COLOR_BROWN, "Pojazd podczepiony");
				}
			}
			if (!found)
			{
				SendClientMessage(playerid,COLOR_BROWN, "Nie ma w pobli¿u ¿adnych samochodów.");
			}
            return 0;
		}
	}
	if(newkeys & KEY_YES && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))//id 131072
	{
		if(GetPlayerVehicleID(playerid) <= CAR_End) //do kradziezy
        {
			if(!Iter_Contains(StolenVehicles[playerid], GetPlayerVehicleID(playerid)))
		    {
				sendErrorMessage(playerid, "Nie mo¿esz odpaliæ wozu podczas kradniêcia");
				return 1;
			}
		}
		new engine, unused;
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine , unused , unused, unused, unused, unused, unused);
		if(engine == 1)
			RunCommand(playerid, "/zgas",  "");
		else
			RunCommand(playerid, "/odpal",  "");
	}
	if(newkeys & KEY_NO && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER)) //swiatla
	{
		if(IsARower(GetPlayerVehicleID(playerid)))
		{
			//sendErrorMessage(playerid, "Rower nie ma deski rozdzielczej!");
			return 1;
		}
		new vehicleid = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if(lights == VEHICLE_PARAMS_ON)
			SetVehicleParamsEx(vehicleid,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		else
			SetVehicleParamsEx(vehicleid,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
	}
	if((newkeys & KEY_HANDBRAKE) && (newkeys & KEY_CROUCH) && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if(GetPVarInt(playerid, "JestPodczasWjezdzania") == 1)
		{
			sendTipMessage(playerid, "Jesteœ podczas wje¿d¿ania!"); 
			return 1;
		}
		if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
		{
			sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile.");
			return 1;
		}	
		if(SprawdzWjazdy(playerid))
		{
		
		}
		else
		{
			
		}
	}
	if((newkeys & KEY_SPRINT) && newkeys & KEY_WALK)
	{
		if(SprawdzBramy(playerid))
		{
		
		}
		else if(SprawdzWejscia(playerid))
		{
		
		}
		else if(SprawdzBiznesy(playerid))
		{
			
		}
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			new Float:health;
			if(IsAtPlaceGetHP(playerid))
			{
				if(GetPlayerHealth(playerid, health) <= PlayerInfo[playerid][pHealth])
				{
					if(TimerJedzenie[playerid] == 0)
					{
						SetPlayerHealth(playerid, health+10);
						ZabierzKaseDone(playerid, PRICE_SPRUNK);
						sendTipMessageEx(playerid, COLOR_RED, "Kupi³eœ jedzenie"); 
						ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);
						GameTextForPlayer(playerid, "Om nom om", 5000, 1);
						TimerJedzenie[playerid] = 1;
						ZarcieCooldown[playerid] = SetTimerEx("JedzenieCooldown", 2500, true, "i", playerid);
					}
					else
					{
						sendTipMessage(playerid, "Odczekaj chwilê!"); 
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo¿esz wzi¹æ wiêcej HP!");
					sendTipMessage(playerid, "Aby móc braæ wiêcej HP ulepsz HP w /ulepszenia!"); 
					return 1;
				}
			}
		}
	}
	if(PRESSED(KEY_JUMP))//AntyBH
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
		    if(AntyBH == 1)
		    {
				SetPVarInt(playerid, "Jumping", 1);
			}
		}
	}
	if(newkeys - oldkeys == 40)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
		    if(WnetrzeWozu[playerid] != 0)
		    {
		        Z_WnetrzaWozu(playerid, WnetrzeWozu[playerid]);
		    }
		    else
		    {
			    for(new v; v < MAX_VEHICLES; v++)
			    {
					new model = GetVehicleModel(v);
					if(IsAInteriorVehicle(playerid))
					{
		   				new Float:vehx, Float:vehy, Float:vehz;
		          		GetVehiclePos(v, vehx, vehy, vehz);
		          		if(IsVehicleStreamedIn(v, playerid) && IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
		          		{
							if(VehicleUID[v][vIntLock] == 1)
			          	    {
								Do_WnetrzaWozu(playerid, v, model);
								return 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "Interior jest zamkniêty!");
							    return 0;
							}
		          		}
					}
			    }
		   	}
		}
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		    if (newkeys & KEY_ACTION || newkeys & KEY_FIRE)
			{
			    new Vehid = GetPlayerVehicleID(playerid);
			    new ModelID[MAX_VEHICLES];
			    ModelID[Vehid] = GetVehicleModel(Vehid);
			    if( ModelID[Vehid] == 520 || ModelID[Vehid] == 432 || ModelID[Vehid] == 425)
			    {
	    			ApplyAnimation(playerid,"PED","car_hookertalk ",4.1,1,1,1,1,1,1);
	    			TogglePlayerControllable(playerid,0);
					TogglePlayerControllable(playerid,1);
				}
			}
		}
	}
	else
	{
		if(PRESSED(KEY_FIRE))
		{
			if(GetPlayerWeapon(playerid) == 46)
			{
				new vehicleid = GetClosestCar(playerid, 3.0);
				if(vehicleid != -1)
				{
					ParachuteHit[playerid]++;
					if(ParachuteHit[playerid] >= 5)
					{
						ParachuteHit[playerid] = 0;
						SetPlayerArmedWeapon(playerid, 0); //chowanie spadochronu
						RemoveWeaponFromSlot(playerid, 11);
						GameTextForPlayer(playerid, "~y~Spadochron wyrzucony", 5000, 1);
					}
					else
					{
						SetPlayerArmedWeapon(playerid, 0); //chowanie spadochronu
        				return ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "Schowaj spadochron zanim w coœ uderzysz."); 
					}
				}
			}
		}

		if(GetPlayerWeapon(playerid) == 34 || GetPlayerWeapon(playerid) == 43)  //usuwanie obiektu maski podczas celowania snajperk¹/aparatem i przywracanie
		{
			new nick[32];
			if(GetPVarString(playerid, "maska_nick", nick, 24))
			{
				if(HOLDING(KEY_HANDBRAKE))
				{
					if(!IsAPolicja(playerid)) RemovePlayerAttachedObject(playerid, 1);
				}
				else if(RELEASED(KEY_HANDBRAKE))
				{
					if(!IsAPolicja(playerid)) SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
				}
			}
		}
	}
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
        if(GetPlayerAnimationIndex(playerid)!=1660) SetTimerEx("VendCheck", 500, false, "d", playerid);
        return 0;
    }
	if(newkeys & 4 && GetPVarInt(playerid, "anim_do") == 1) //animacje
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerSpecialAction(playerid) != 0)
			{
				SetPlayerSpecialAction(playerid, 0);
			}
		}
		ClearAnimations(playerid, 0);
		SetPVarInt(playerid, "anim_do", 0);
		return 0;
	}

	//ANTY CBUG
	/*new cbugging = GetPVarInt(playerid, "cbugging"), lastfire = GetPVarInt(playerid, "lastfire");
	if(!cbugging && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_FIRE))
		{
			switch(GetPlayerWeapon(playerid))
			{
				case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
				{
					SetPVarInt(playerid, "lastfire", gettime());
				}
			}
		}
		else if(PRESSED(KEY_CROUCH))
		{
			if((gettime() - lastfire) < 1)
			{
				TogglePlayerControllable(playerid, false);

				SetPVarInt(playerid, "cbugging", 1);

				GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);
				SetTimerEx("CBugFreezeOver", 1500, false, "i", playerid);
			}
		}
	}*/
	
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == 577)
	{
        foreach(new i : Player)
		{
			if(PlayerInfo[i][pWsamolocieLS]==1)
			{
				SendClientMessage(i, COLOR_GREY, " Samolot rozbi³ siê!");
				SetPlayerHealth(i, 0);
				PlayerInfo[i][pWsamolocieLS]=0;
				PlayerInfo[i][pWlociej]=0;
				PlayerInfo[i][pMozeskakacAT]=0;
			}
		}
		if(osoby>1)
		{
            new str[64];
            format(str, 64, "Szok! Samolot KT rozbi³ siê i zginê³o %d osób!", osoby);
			OOCNews(COLOR_LIGHTGREEN, str);
		}
	}

    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);

    TJD_CheckForUsedBox(vehicleid);

	if(VehicleUID[vehicleid][vUID] != 0)
	{
        Car_AddTune(vehicleid);
    	SetVehicleHealth(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_HP]);
    	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, CarData[VehicleUID[vehicleid][vUID]][c_Tires]);
	}
    if(VehicleUID[vehicleid][vSiren] != 0)
	{
	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
	    VehicleUID[vehicleid][vSiren] = 0;
	}
    if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION || Car_GetOwnerType(vehicleid) == CAR_OWNER_JOB) {
        RepairVehicle(vehicleid); //

    }
    return 1;
}

public OnPlayerText(playerid, text[])
{
	new giver[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new tmp[256];
	new string[256];
	new wywiad_string[256];
	new giveplayerid;
	if(text[0] == '@')
	{
		//chat grupy - skrót do /ro
		new groupcheck = strval(text[1]);
		if(groupcheck >= 1 && groupcheck <= MAX_PLAYER_GROUPS)
		{
			strdel(text, 0, 3);
			GroupSendMessageOOC(playerid, groupcheck, text, true);
			return 0;
		}
		//
		if(strlen(text) > 31)
		{
			sendTipMessage(playerid, "Nieprawid³owa d³ugoœæ znaków animacji"); 
			return 0;
		}
		if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) return 0;
        new lVal = MRP_DoAnimation(playerid, text);
        if(lVal != 1)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "@_MRP: Nie znaleziono (/anim)acji.");
		} 
		return 0;
	}
	if(text[0] == '!')
	{
		//chat grupy - skrót do /r
		new groupcheck = strval(text[1]);
		if(groupcheck >= 1 && groupcheck <= MAX_PLAYER_GROUPS)
		{
			strdel(text, 0, 3);
			GroupSendMessageRadio(playerid, groupcheck, text, true);
		}
		//
		return 0;
	}
	if(PlayerInfo[playerid][pMuted] == 1)
	{
		sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ gdy¿ jesteœ uciszony");
		return 0;
	}
	

	// Przeniesione z mrpac_callbacks.pwn
	/*if(PlayerAC[playerid][acSpam_unmuteTime] <= gettime() && PlayerAC[playerid][acSpam_unmuteTime] != 0)
	{
		printf("%d %d", PlayerAC[playerid][acSpam_unmuteTime], gettime());
		PlayerAC[playerid][acSpam_count] = 0;
		PlayerAC[playerid][acSpam_unmuteTime] = 0;
	}
	new interval = abs(GetTickCountDifference(PlayerAC[playerid][acSpam_lastTick], GetTickCount()));
	//printf("%d", interval);
	if(interval < 120 || PlayerAC[playerid][acSpam_count] >= 2)
	{
		printf("%d", PlayerAC[playerid][acSpam_count]);
		PlayerAC[playerid][acSpam_lastTick] = GetTickCount();
		PlayerAC[playerid][acSpam_count]++;
		if(PlayerAC[playerid][acSpam_count] >= 2)
		{
			PlayerAC[playerid][acSpam_unmuteTime] = gettime()+2;
			SendClientMessage(playerid, 0xFF000000, "»» Zwolnij!");
		}
		return 0;
	}
	PlayerAC[playerid][acSpam_lastTick] = GetTickCount();*/
	// ----------------------------------- //

	if(MarriageCeremoney[playerid] > 0)
	{
	    if (strcmp("tak", text, true) == 0)
		{
		    if(GotProposedBy[playerid] < 999)
		    {
			    if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
				    format(string, sizeof(string), "Ksi¹dz: %s czy chcesz wzi¹æ %s na swoj¹ ¿one? (wpisz 'tak', cokolwiek innego anuluje œlub).", giveplayer,sendername);
					SendClientMessage(GotProposedBy[playerid], COLOR_WHITE, string);
					MarriageCeremoney[GotProposedBy[playerid]] = 1;
					MarriageCeremoney[playerid] = 0;
					GotProposedBy[playerid] = 999;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
			}
			else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
						format(string, sizeof(string), "Ksi¹dz: %s i %s zostaliœcie mê¿em i ¿on¹, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s zostaliœcie mê¿em i ¿on¹, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 1)
					{
					    format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie mê¿em i mê¿em, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie mê¿em i mê¿em, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ gejowsk¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 2 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
					    format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie ¿on¹ i ¿on¹, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie ¿on¹ i ¿on¹, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ lesbijsk¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					//MarriageCeremoney[ProposedTo[playerid]] = 1;
					MarriageCeremoney[ProposedTo[playerid]] = 0;
					MarriageCeremoney[playerid] = 0;
					format(PlayerInfo[ProposedTo[playerid]][pMarriedTo], 32, "%s", sendername);
                    format(PlayerInfo[playerid][pMarriedTo], 32, "%s", giveplayer);
					ZabierzKaseDone(playerid, PRICE_SLUB);
					PlayerInfo[playerid][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pPbiskey] = PlayerInfo[playerid][pPbiskey];
					ProposedTo[playerid] = 999;
					MarriageCeremoney[playerid] = 0;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
		else
		{
		    if(GotProposedBy[playerid] < 999)
		    {
				if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poœlubiæ %s, nie powiedzia³eœ 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciê poœlubiæ gdy¿ nie powiedzia³ 'tak'.",sendername);
				    SendClientMessage(GotProposedBy[playerid], COLOR_YELLOW, string);

                    MarriageCeremoney[GotProposedBy[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
		    }
		    else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poœlubiæ %s, nie powiedzia³eœ 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciê poœlubiæ gdy¿ nie powiedzia³ 'tak'.",sendername);
				    SendClientMessage(ProposedTo[playerid], COLOR_YELLOW, string);

                    GotProposedBy[ProposedTo[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
	    return 0;
	}

	if(ConnectedToPC[playerid] == 255)
	{
		new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("Contracts", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Contracts")) || (strcmp("Kontrakty", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Kontrakty")))
		{
		    if(GroupPlayerDutyRank(playerid) < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Tylko Hitmani z 4 rang¹ mog¹ sprawdzaæ listê kontraktów !");
		        return 0;
		    }
		    SearchingHit(playerid);
			return 0;
		}
		else if ((strcmp("News", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("News")))
		{
		    	new x_nr[128];
				x_nr = strtok(text, idx);

				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "|__________________ Hitman Agency News __________________|");
					SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: News [numer] aby skasowac 'News Delate [numer]' lub 'News delete all'");
					format(string, sizeof(string), "1: %s :: Hitman: %s", News[hAdd1], News[hContact1]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "2: %s :: Hitman: %s", News[hAdd2], News[hContact2]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "3: %s :: Hitman: %s", News[hAdd3], News[hContact3]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "4: %s :: Hitman: %s", News[hAdd4], News[hContact4]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "5: %s :: Hitman: %s", News[hAdd5], News[hContact5]);
					SendClientMessage(playerid, COLOR_GREY, string);
					SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________________|");
					return 0;
				}//lets start
				if(strcmp(x_nr,"1",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz miec 3 rangê aby pisaæ newsy Hitman Agency !"); return 0; }
				    if(News[hTaken1] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "Za krótki tekst newsa !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd1], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact1], string, 0, strlen(string));
						News[hTaken1] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest zajety !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"2",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken2] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd2], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact2], string, 0, strlen(string));
						News[hTaken2] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"3",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken3] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd3], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact3], string, 0, strlen(string));
						News[hTaken3] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"4",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken4] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd4], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact4], string, 0, strlen(string));
						News[hTaken4] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"5",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken5] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd5], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact5], string, 0, strlen(string));
						News[hTaken5] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"delete",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) < 4)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 4 rangê aby usuwaæ newsy z kana³u Hitman Agency !");
				        return 0;
				    }
				    new string1[MAX_PLAYER_NAME];
				    new x_tel[128];
					x_tel = strtok(text, idx);
					if(!strlen(x_tel)) {
					    SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: News delete [numer] lub News delete all.");
					    return 0;
					}
                    if(strcmp(x_tel,"1",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (1) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"2",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (2) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"3",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (3) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"4",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (4) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"5",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (5) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"all",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ wszystkie newsy z kana³u Hitman Agency.");
						return 0;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: News delete [numer] lub News delete all.");
					    return 0;
                    }
				}
				else { return 0; }
		}
		else if ((strcmp("Givehit", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Givehit")))
		{
		    if(GroupPlayerDutyRank(playerid) < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 4 rangê aby dawaæ kontrakty Hitmanom !");
		        return 0;
		    }
		    if(hitfound == 0)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Nie sprawdzi³eœ jeszcze kontraktów, zrób to w laptopie (wpisz 'kontrakty') !");
		        return 0;
		    }
		    tmp = strtok(text, idx);
		    if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "U¿YJ: Givehit [playerid]");
				return 0;
			}
			giveplayerid = strval(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
				    if(!IsAHA(giveplayerid, 0))
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten gracz nie jest Hitmanem !");
						return 0;
				    }
				    if(GoChase[giveplayerid] < 999)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten Hitman wykonuje ju¿ jakieœ zlecenie !");
						return 0;
				    }
				    if(IsPlayerConnected(hitmanid))
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        GetPlayerName(giveplayerid, giver, sizeof(giver));
				        GetPlayerName(hitmanid, giveplayer, sizeof(giveplayer));

		    			format(string, sizeof(string), "* Hitman %s, da³ zlecenie %s na zabicie: %s(ID:%d), nagroda: $%d.", sendername, giver, giveplayer, hitmanid, PlayerInfo[hitmanid][pHeadValue]);
		    			GroupSendMessage(8, COLOR_YELLOW, string);
		    			GoChase[giveplayerid] = hitmanid;
		    			GetChased[hitmanid] = giveplayerid;
		    			GotHit[hitmanid] = 1;
		    			hitmanid = 0;
		    			hitfound = 0;

						ConnectedToPC[playerid] = 0; //roz³¹czanie z laptopem po akcji
				        return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Osoby, na któr¹ jest zlecenie, nie ma na serwerze. Spróbuj póŸ¸niej !");
				        return 0;
				    }
				}
				return 0;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Tego gracza nie ma na serwerze lub nie jest Hitmanem !");
			    return 0;
			}
		}
		else if ((strcmp("Ranks", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Ranks")) || (strcmp("Rangi", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Rangi")))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ Rangi Hitmanów __________________|");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(CheckPlayerPerm(i, PERM_HITMAN))
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
				        format(string, sizeof(string), "* %s: Ranga %d", giveplayer,GroupPlayerDutyRank(playerid));
						SendClientMessage(playerid, COLOR_GREY, string);
					}
				}
			}
		}
		else if ((strcmp("Logout", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Logout")) || (strcmp("Wyloguj", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Wyloguj")))
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wy³¹czy³eœ swój laptop i zerwa³eœ po³¹czenie z agencj¹.");
      		ConnectedToPC[playerid] = 0;
		    return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_WHITE, "|___ Hitman Agency ___|");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - News");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Kontrakty");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Givehit");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Rangi");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Wyloguj");
			SendClientMessage(playerid, COLOR_WHITE, "|______________|00:00|");
		    return 0;
		}
	    return 0;
	}
	if(CallLawyer[playerid] == 111)
	{
	    new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("tak", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("tak")))
		{
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "** %s jest w wiêzieniu i potrzebuje prawnika, jedŸ¸ na komisariat.", sendername);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, string);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, "* Kiedy bêdziesz juz na komisariacie, spytaj siê policjanta o /akceptuj prawnik.");
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "Jeœli policjant siê zgodzi, prawnik bêdzie móg³ uwolniæ ciê za op³at¹.");
	    	WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
	    	return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_LIGHTRED, "Nie ma ¿adnych prawników na serwerze, czas odsiadki rozpoczêty.");
		    WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
		    return 0;
		}
	}
	if(TalkingLive[playerid] != INVALID_PLAYER_ID)
	{
		new SanNews_nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid, SanNews_nick, sizeof(SanNews_nick));
		if(IsPlayerInGroup(playerid, 9) || PlayerInfo[playerid][pLider] == 9)
		{//todo
			if(strlen(text) < 78)
			{
				if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
				{
					SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
					return 1;
				}
				format(string, sizeof(string), "%s mówi: %s", SanNews_nick, text);
				format(wywiad_string, sizeof(wywiad_string), "Reporter %s: %s", SanNews_nick, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
				OOCNews(COLOR_LIGHTGREEN, wywiad_string);
				SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
					{
						SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
						return 1;
					}
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));
					format(string, sizeof(string), "%s mówi: %s [..]", SanNews_nick, text);
					format(wywiad_string, sizeof(wywiad_string), "Reporter %s: %s [..]", SanNews_nick, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);

					format(string, sizeof(string), "[..] %s", text2);
					format(wywiad_string, sizeof(wywiad_string), "[..] %s", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
				}
			}
		
		}
		else
		{
			if(strlen(text) < 78)
			{
				if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
				{
					SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
					return 1;
				}
				format(string, sizeof(string), "%s mówi: %s", SanNews_nick, text);
				format(wywiad_string, sizeof(wywiad_string), "Goœæ wywiadu %s: %s", SanNews_nick, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
				OOCNews(COLOR_LIGHTGREEN, wywiad_string);
				SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
					{
						SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
						return 1;
					}
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "%s mówi: %s [..]", SanNews_nick, text);
					format(wywiad_string, sizeof(wywiad_string), "Goœæ wywiadu %s: %s [..]", SanNews_nick, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);

					format(string, sizeof(string), "[..] %s", text2);
					format(wywiad_string, sizeof(wywiad_string), "[..] %s", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
				}
			}
		}
		Log(chatLog, WARNING, "%s wywiad: %s", GetPlayerLogName(playerid), text);
		return 0;
	}
	if(Mobile[playerid] != INVALID_PLAYER_ID && Callin[playerid] != CALL_NONE)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s mówi (telefon): %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		Log(chatLog, WARNING, "%s telefon: %s", GetPlayerLogName(playerid), text);

		if(Mobile[playerid] < EMERGENCY_NUMBERS)
		{
			new org = (Mobile[playerid] - EMERGENCY_NUMBERS) * -1; //wzór na wy³uskanie organizacji z numeru
			if(Mobile[playerid] == POLICE_NUMBER || Mobile[playerid] == SHERIFF_NUMBER)
			{
				if(strlen(text) > 82)
				{
					SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: Niestety, nie rozumiem. Proszê powtórzyæ ((max 75 znaków))");
					return 0;
				}
				new id, message[128];
				mysql_real_escape_string(text, message);
				new Hour, Minute;
				gettime(Hour, Minute);
				new datapowod[160];
				format(datapowod, sizeof(datapowod), "%02d:%02d",  Hour, Minute);
				new pZone[MAX_ZONE_NAME];
				GetPlayer2DZone(giveplayerid, pZone, MAX_ZONE_NAME);

				if(Mobile[playerid] == POLICE_NUMBER)
				{
					id = getWolneZgloszenie();
				}
				else //SHERIFF_NUMBER
				{
					id = getWolneZgloszenieSasp();
				}

				strmid(Zgloszenie[id][zgloszenie_kiedy], datapowod, 0, sizeof(datapowod), 36);
				format(Zgloszenie[id][zgloszenie_nadal], MAX_PLAYER_NAME, "%s", GetNick(playerid));
				format(Zgloszenie[id][zgloszenie_lokacja], MAX_ZONE_NAME, "%s", pZone);
				strmid(Zgloszenie[id][zgloszenie_tresc], message, 0, strlen(message) + 9, 128);
				Zgloszenie[id][zgloszenie_status] = 0;
			}

			new turner[MAX_PLAYER_NAME], pZone[MAX_ZONE_NAME];
			new wanted[144];
			GetPlayerName(playerid, turner, sizeof(turner));
			GetPlayer2DZone(playerid, pZone, sizeof(pZone));
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Zg³osimy to wszystkim jednostkom w danym obszarze.");
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dziêkujemy za zg³oszenie");
			format(wanted, sizeof(wanted), "Centrala: Otrzymano zg³oszenie: %s", text);
			GroupSendMessage(org, COLOR_ALLDEPT, wanted, true);
			format(wanted, sizeof(wanted), "Centrala: Nadawca: %s, lokalizacja zg³oszenia: %s", turner, pZone);
			GroupSendMessage(org, COLOR_ALLDEPT, wanted, true);
			if(org == 4 && (PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0)) PlayerRequestMedic[playerid] = 1;

			SendClientMessage(playerid, COLOR_GRAD2, "Rozmowa zakoñczona...");
			StopACall(playerid);
		}
		else
		{
			new reciverid = Mobile[playerid];
			if(RingTone[reciverid] != 0)
			{
				sendErrorMessage(playerid, "Gracz jeszcze nie odebra³ telefonu!");
			}
			else if(IsPlayerConnected(Mobile[playerid]))
			{
				new slotKontaktu = PobierzSlotKontaktuPoNumerze(Mobile[playerid], GetPhoneNumber(playerid));
				if(slotKontaktu >= 0)
				{
					format(string, sizeof(string), "%s (nr %d): %s", Kontakty[Mobile[playerid]][slotKontaktu][eNazwa], GetPhoneNumber(playerid), text);
				}
				else
				{
					format(string, sizeof(string), "Telefon (nr %d): %s", GetPhoneNumber(playerid), text);
				}
				SendClientMessage(Mobile[playerid], COLOR_YELLOW, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Nikt siê nie odzywa.");
			}
		}
		return 0;
	}
	if (realchat)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        return 0;
      	}

		if(TourettActive[playerid] && GetPlayerAdminDutyStatus(playerid) == 0)
		{
			//insert random tourette word
			new newText[256];
			new Vector:spaces;
			for(new i; text[i] != '\0'; i++) //find spaces
			{
				if(text[i] == ' ') {
					VECTOR_push_back_val(spaces, i);
				}
			}
			new size = VECTOR_size(spaces);
			if(size > 0)
			{
				//insert word
				new index = random(size);
				strcat(newText, text);
				strins(newText, TourettWords[random(sizeof(TourettWords))], VECTOR_get_val(spaces, index));
				PlayerTalkIC(playerid, newText, "mówi", 15.0);
			}
			else
			{
				PlayerTalkIC(playerid, text, "mówi", 15.0);
			}
		}
		else if(OKActive[playerid] && GetPlayerAdminDutyStatus(playerid) == 0)
		{
			//speak l33t
			new newText[256];
			strcat(newText, text);
			strreplace(newText, "a", "4", true);
			strreplace(newText, "o", "0", true);
			strreplace(newText, "e", "3", true);
			strreplace(newText, "g", "6", true);
			strreplace(newText, "l", "1", true);
			strreplace(newText, "s", "5", true);
			strreplace(newText, "t", "7", true);
			strreplace(newText, "z", "2", true);
			PlayerTalkIC(playerid, newText, "mówi", 15.0);
		}
		else
		{
			PlayerTalkIC(playerid, text, "mówi", 15.0);
		}

		Log(chatLog, WARNING, "%s chat IC: %s", GetPlayerLogName(playerid), text);
		return 0;
	}
	return 1;
}//OnPlayerText

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
    if(GetPVarInt(playerid, "Allow-edit"))
    {
        EditDynamicObject(playerid, objectid);
        new lStr[32];
        format(lStr, 32, "OBJID: %d", objectid);
        SendClientMessage(playerid, -1, lStr);
    }
    return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
    if(ZONE_DISABLED == 0) {
        if(CheckPlayerPerm(playerid, PERM_GANG))
        {
            ZoneTXD_Show(playerid, zoneid);
            if(ZonePlayerTimer[playerid] == 0) ZonePlayerTimer[playerid] = SetTimerEx("Zone_HideInfo", 30000, 0, "i", playerid);
        }
		new frac;
		for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
		{
			if(PlayerInfo[playerid][pGrupa][i] != 0)
			{
				if(GroupHavePerm(PlayerInfo[playerid][pGrupa][i], PERM_GANG))
				{
					frac = PlayerInfo[playerid][pGrupa][i];
					break;
				}
			}
		}
        //Attack sync
        if(ZoneAttack[zoneid] && PlayerInfo[playerid][pBW] == 0)
        {
            if(frac == ZoneAttackData[zoneid][2]) // attacker
            {
                if(!ZoneAttacker[playerid])
                {
                    ZoneAttacker[playerid] = true;
                    ZoneAttackData[zoneid][0]++;
                }
            }
            else if(frac == ZoneAttackData[zoneid][3]) // defender
            {
                if(!ZoneDefender[playerid])
                {
                    ZoneDefender[playerid] = true;
                    ZoneAttackData[zoneid][1]++;
                }
            }
        }
    }
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
    if(zoneid < 0)
    {
        printf("Invalid zoneid (%d) for player %d", zoneid, playerid);
        return;
    }
    if(ZonePlayerTimer[playerid] != 0)
    {
        ZoneTXD_Hide(playerid);
        KillTimer(ZonePlayerTimer[playerid]);
        ZonePlayerTimer[playerid] = 0;
    }
    //Attack sync
	new frac;
    for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
    {
        if(PlayerInfo[playerid][pGrupa][i] != 0)
        {
            if(GroupHavePerm(PlayerInfo[playerid][pGrupa][i], PERM_GANG))
            {
                frac = PlayerInfo[playerid][pGrupa][i];
                break;
            }
        }
    }
    if(ZoneAttack[zoneid])
    {
        if(frac == ZoneAttackData[zoneid][2]) // attacker
        {
            if(ZoneAttacker[playerid])
            {
                ZoneAttacker[playerid] = false;
                ZoneAttackData[zoneid][0]--;
            }
        }
        else if(frac == ZoneAttackData[zoneid][3]) // defender
        {
            if(ZoneDefender[playerid])
            {
                ZoneDefender[playerid] = false;
                ZoneAttackData[zoneid][1]--;
            }
        }
    }
    SetPVarInt(playerid, "zoneid", -1);
}

public OnTrailerUpdate(playerid, vehicleid)
{
    return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	OnUnoccupiedVehicleUpdateReczny(vehicleid);
    return 1;
}

public MRP_ChangeVehicleColor(vehicleid, color1, color2)
{
    new bool:save=false;
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1 || CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
        save = true;
    if(color1 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][0] = color1;
    if(color2 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][1] = color2;
    if(save)
        Car_Save(VehicleUID[vehicleid][vUID], CAR_SAVE_TUNE);
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    return 1;
}

public OnDynamicObjectMoved(objectid)
{
    if(ScenaCreated)
    {
        if(objectid == ScenaScreenObject)
        {
            Scena_ScreenEffect();
            return 1;
        }
        for(new i=0;i<2;i++)
        {
            if(objectid == ScenaNeonData[SCNeonObj][i])
            {
                if(ScenaNeonData[SCNeonTyp] == 2)
                {
                    ScenaNeonData[SCNeonZderzacz]++;
                    if(ScenaNeonData[SCNeonZderzacz] == 2) Scena_NeonEffect();
                }
                else Scena_NeonEffect();
                return 1;
            }
        }
    }
    return 1;
}
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(IsPlayerNPC(playerid)) return 0;
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}
	new fullurl[256+1];
	new dlfilename[64+1];
	new foundfilename=0;
 
	if(!IsPlayerConnected(playerid)) return 0;
 
	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE) {
		foundfilename = FindTextureFileNameFromCRC(crc,dlfilename,sizeof(dlfilename));
	}
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE) {
		foundfilename = FindModelFileNameFromCRC(crc,dlfilename,sizeof(dlfilename));
	}
 
	if(foundfilename) {
		format(fullurl,sizeof(fullurl), RESOURCES_LINK"%s", dlfilename);
		RedirectDownload(playerid,fullurl);
		if(!GetPVarInt(playerid, "IsDownloadingContent")) SetPVarInt(playerid, "IsDownloadingContent", 1);
	}
	return 0;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
    return 1;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
    if(GetPVarInt(forplayerid, "tognick") == 1)
        ShowPlayerNameTagForPlayer(forplayerid, playerid, 0);

    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 0; //turn off singleplayer workshops
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
    return 1;
}

forward TextDrawInfoOn(playerid,string[],time);
public TextDrawInfoOn(playerid,string[],time)
{
	if(InfoWyswietla[playerid]==1){
		TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
	}
	InfoWyswietla[playerid]=1;
	TextDrawSetString(TextDrawInfo[playerid], string);
	TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
	SetTimerEx("TextDrawInfooff",time, 0, "d", playerid);
	return 1;
}

forward TextDrawInfooff(playerid,string[]);
public TextDrawInfooff(playerid,string[])
{
	TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
	InfoWyswietla[playerid]=0;
}

forward WytrychZamek(playerid, carid);
public WytrychZamek(playerid, carid)
{
	SetPVarInt(playerid, "WytrychBlock", 0);
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
	TogglePlayerControllable(playerid, 1);
	switch(random(10)+1)
	{
		case 1:
		{
			SetPlayerChatBubble(playerid, "{E59EF3}Wklada w zamek pojazdu wytrych, ktory otwiera zamek", -1, 6.0, 8000);
			TextDrawInfoOn(playerid, "~y~Udalo sie~n~~w~samochod zostal ~g~otwarty~w~!.", 8000);
			ApplyAnimation(playerid, "INT_HOUSE", "wash_up", 4.5, 0, 0, 0, 0, 0);
			if(GetVehicleModel(carid)==481||GetVehicleModel(carid)==509||GetVehicleModel(carid)==510) return SetVehicleParamsEx(carid,engine,lights,alarm,0,bonnet,boot,objective);
			else
			{
				SetVehicleParamsEx(carid,engine,lights,0,0,bonnet,boot,objective);
				SetVehicleParamsEx(carid,engine,lights,0,0,bonnet,boot,objective);
			}
		}
		case 2: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 3: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 4: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 5: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 6: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 7: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 8: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 9: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 10: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
	}
	return 1;
}

forward WytrychSilnik(playerid, carid);
public WytrychSilnik(playerid, carid)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetPVarInt(playerid, "WytrychBlock", 0);
	TogglePlayerControllable(playerid, 1);
	switch(random(4)+1)
	{
		case 1:
		{
			TextDrawInfoOn(playerid, "~y~Udalo sie~n~~w~silnik samochodu zostal ~g~uruchomiony~w~!.", 8000);
			SetVehicleParamsEx(carid , 1, lights, alarm, doors, bonnet, boot, objective);
		}
		case 2: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 3: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
		case 4: return TextDrawInfoOn(playerid, "~w~Wytrych sie ~r~zlamal~w~!.", 8000);
	}
	return 1;
}

AntiDeAMX() //suprise motherfucker
{
    new whack[][] =
    {
        "lol",
        "traktor"
    };
    #pragma unused whack
	
	//Thanks to Y_Less
    new nyan;
    #emit load.pri nyan
    #emit stor.pri nyan
}

//Koniec.

//NOC OCZYSZCZENIA

timer resetCounter[60000](playerid, killerid)
{
	if(!Iter_Contains(KilledBy[playerid], killerid)) return 0;
	Iter_Remove(KilledBy[playerid], killerid);
	return 1;
}

new eventon = 1;

YCMD:noc_oczyszczenia(playerid, params[])
{	
	if(PlayerInfo[playerid][pAdmin] < 5000) return noAccessMessage(playerid);
	if(strval(params) != 0 && strval(params) != 1) return sendErrorMessage(playerid, "0 - off, 1 - on");
	eventon = strval(params);
	va_SendClientMessage(playerid, COLOR_GREEN, "Ustawi³eœ wartoœæ eventu na: %d", eventon);
	return 1;
}

YCMD:kit(playerid, params[])
{
	if(!eventon) return sendErrorMessage(playerid, "Event jest wy³¹czony.");
	if(strcmp(params, "bronie", true)) return sendTipMessage(playerid, "U¿yj: /kit bronie");
	if(GetPVarInt(playerid, "kit-cooldown") > gettime())
	{
		new time = GetPVarInt(playerid, "kit-cooldown")-gettime();
		return va_SendClientMessage(playerid, COLOR_RED, "Now¹ broñ mo¿esz wzi¹æ za %d minut.", floatround(time / 60 % 60));
	}
	SetWeaponValue(playerid, GetWeaponSlot(WEAPON_DEAGLE), WEAPON_DEAGLE, 500, 0);
	GivePlayerWeapon(playerid, WEAPON_DEAGLE, 500);
	SetWeaponValue(playerid, GetWeaponSlot(WEAPON_M4), WEAPON_M4, 500, 0);
	GivePlayerWeapon(playerid, WEAPON_M4, 500);
	mysql_query(sprintf("UPDATE `mru_konta` SET `NocOczyszczeniaKit` = '%d' WHERE `UID` = '%d'", gettime()+1200, PlayerInfo[playerid][pUID]));
	SetPVarInt(playerid, "kit-cooldown", gettime()+1200);
	SendClientMessage(playerid, COLOR_GREEN, "	Dosta³eœ Desert Eagle i M4 z 500 amunicji.");
	return 1;
}