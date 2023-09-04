/* 
					 _           _         _____  ____  _  __     __
					| |         | |       / ____|/ __ \| | \ \   / /
					| |    _   _| | _____| (___ | |  | | |  \ \_/ / 
					| |   | | | | |/ / _ \\___ \| |  | | |   \   /  
					| |___| |_| |   <  __/____) | |__| | |____| |   
					|______\__,_|_|\_\___|_____/ \___\_\______|_|   
			
			//------------- NAPADY SYSTEM BY LukeSQLY -------------//
			//------------------------ VER 1.0 ----------------------//


			TODO:

			Dodaæ ograniczenie tworzenia napadów co 1 godzinê

*/

#define DEFAULT_ROB_TIME 600
#define MIN_COP_ONLINE 3
#define MIN_ORG_ONLINE 3

new robSync;
new robTimerVar[MAX_PLAYERS];
new robInProgress[MAX_PLAYERS];

new MembersRobOrg[MAX_PLAYERS][MAX_PLAYERS] = {INVALID_PLAYER_ID, INVALID_PLAYER_ID, ...};


new Float:NPCPosition[3][3] = {
	{-23.8159, -57.3964, 1003.5469},
	{-27.8796, -91.6363, 1003.5469},
	{-29.1886, -186.8156, 1003.5469}
};

			//------------------------ <! functions !> ----------------------//


stock LoadActorsToRob()
{
	new rob;
	for(new i; i < sizeof(NPCPosition); i++) {
  		CreateDynamicActor(2, NPCPosition[i][0], NPCPosition[i][1], NPCPosition[i][2], 360.0, 1, 100.0, 0, 17, -1, STREAMER_ACTOR_SD, -1, 0);
  		rob++;
	}
	printf("Za³adowano %d aktorów do obrabowania dla organizacji przestepczych!", rob);
}

forward SendCallToPolice(playerid);
public SendCallToPolice(playerid)
{ 
	GroupSendMessage(1, COLOR_RED, "ALARM: W sklepie 24/7 w okolicy urzêdu miasta uruchomi³ siê alarm!");
	format(C_STRING, sizeof(C_STRING), "[**] Monitoring CCTV: W sklepie 24/7 obok urzêdu urchomi³ siê alarm! [**]");
   	SendTeamMessage(4, COLOR_ALLDEPT, C_STRING);
   	SendTeamMessage(3, COLOR_ALLDEPT, C_STRING);
   	SendTeamMessage(2, COLOR_ALLDEPT, C_STRING);
   	SendTeamMessage(1, COLOR_ALLDEPT, C_STRING);
    print(C_STRING);
}

CheckMembersFromOrg(playerid)
{
    new x;
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[playerid][pMember] == PlayerInfo[i][pMember] && GetDistanceBetweenPlayers(playerid, i) <= 10)
        {
            x++;
            AddPlayerMembersRob(playerid, i);
        }
    }
    return x;
}

AddPlayerMembersRob(playerid, id)
{
    for(new i = 0; i<MAX_PLAYERS;i++)
    {
        if(MembersRobOrg[playerid][i] == INVALID_PLAYER_ID) MembersRobOrg[playerid][i] = id;
        return 1;
    }
    return 1;
}

forward CheckCopPlayers(playerid);
public CheckCopPlayers(playerid)
{
	new i, x;
    for(i = 0; i < MAX_PLAYERS; i++) {
    	if(IsACop(i) && (OnDuty[i] > 0 || OnDutyCD[i] > 0))
    	{
    		x++;
		} 
    }
    if(x >= MIN_COP_ONLINE) {
    	SendCallToPolice(playerid);
    	StartPlayerRob(playerid);
    	printf("policjantow online: %d", x);
    } else sendErrorDialogMessage(playerid, "Nie ma funkcjonariuszy LSPD/FBI na s³u¿bie!");
}

forward StartPlayerRob(playerid);
public StartPlayerRob(playerid)
{
	new string[125];
	robSync = 1;
	robTimerVar[playerid] = DEFAULT_ROB_TIME;
	robInProgress[playerid] = 1;

 	sendTipDialogMessage(playerid, "Rozpocz¹³eœ okradanie sprzedawcy sklepu\ns³u¿by zosta³y poinformowane o zaistnia³ej sytuacji!");
 	format(C_STRING, sizeof(C_STRING), "[# NAPAD #] Gracz %s [%d] zorganizowa³ napad w sklepie 24/7", GetNick(playerid), playerid);
 	SendCommandLogMessage(C_STRING);
 	RobLog(C_STRING);

 	if(PlayerInfo[playerid][pMaska] == 1) {
 		sendTipMessage(playerid, "Jesteœ zamaskowany, nie otrzymujesz WL za zorganizowanie napadu!");
 		return 1;
 	} 
 	else
 	{
 		PoziomPoszukiwania[playerid] = 10;
 		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
 		format(string, sizeof(string), "Napad na sklep 24/7");
		SetPlayerCriminal(playerid, INVALID_PLAYER_ID, string);
 	}
 	return 1; 	
}

			//------------------------ <! commands!> ----------------------//

YCMD:napadaj(playerid, params[])
{
	if(!IsAPrzestepca(playerid)) return sendErrorDialogMessage(playerid, "Nie jesteœ z organizacji przestêpczej!!");
	if(IsPlayerInRangeOfPoint(playerid, 2, NPCPosition[0][0], NPCPosition[0][1], NPCPosition[0][2]) || IsPlayerInRangeOfPoint(playerid, 2, NPCPosition[1][0], NPCPosition[1][1], NPCPosition[1][2]) || IsPlayerInRangeOfPoint(playerid, 2, NPCPosition[2][0], NPCPosition[2][1], NPCPosition[2][2])) {
		if(robSync >= 1) return sendErrorDialogMessage(playerid, "Ten sklep zosta³ niedawno obrabowany, spróbuj póŸniej");
		if(CheckMembersFromOrg(playerid) < MIN_ORG_ONLINE) return sendTipDialogMessage(playerid, "Nie ma w pobli¿u Ciebie cz³onków twojej organizacji (min. 3 osoby)"); 
		if(!GetPlayerWeapon(playerid)) return sendErrorDialogMessage(playerid, "Nie trzymasz ¿adnej broni w rêce!");
		CheckCopPlayers(playerid);
		return 1;
	} 
	else sendErrorDialogMessage(playerid, "Nie jesteœ w pobli¿u sprzedawcy!");
	return 1;
}


