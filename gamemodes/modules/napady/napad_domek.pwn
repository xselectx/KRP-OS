//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: napad_domek.pwn ]------------------------------------------//
//----------------------------------------[ Autor: Dawidoskyy ]----------------------------------------//

// kupa

#include <YSI_Coding\y_hooks>

#define randomexyz(%0,%1) 							(random((%1)-(%0)+1)+(%0))
#define COLOR_LIGHTGREENNAPAD 	0x00CA00FF
#define SAFEROBTIME 120
#define DOORKICKTIME 35
#define DOORCLOSETIME 450
#define MINMONEY 1000
#define MAXMONEY 5000
#define WAITTIME 1900

enum RobTheHouseInfo{
	dooorss,
	bool:openeedd,
	safee1,
	safee2,
	Text3D:textdooorss,
	Text3D:textsafee1,
	Text3D:textsafee2,
	TimerKickdooorss,
	TimeToKick,
	TimerClosedooorss,
	TimeToClose,
	TimerRobbing1,
	TimerRobbing2,
	TimeToRob1,
	TimeToRob2,
	bool:safeopeneedd1,
	bool:safeopeneedd2,
	WaitTimer,
	WaitTime
};
new RTH[RobTheHouseInfo];

stock OnGameModeNapadDomek(){
	CreateDynamicObject(17698, 2401.89307, -1707.46179, 15.50286,   0.00000, 0.00000, 90.04841);
	CreateDynamicObject(17698, 2401.89307, -1707.46179, 15.50286,   0.00000, 0.00000, 90.04841);
	CreateDynamicObject(17566, 2398.07959, -1716.80054, 14.35603,   0.00000, 0.00000, 270.27847);
	CreateDynamicObject(19365, 2408.01587, -1700.09668, 15.75107,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.02808, -1708.84106, 14.44807,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.02808, -1708.84106, 14.44807,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.03052, -1708.83801, 15.75408,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.07715, -1705.72656, 15.78164,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.06836, -1702.60718, 15.75207,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.02197, -1700.09668, 14.44807,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.06934, -1702.61230, 14.44807,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.07715, -1705.72656, 14.44707,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.05298, -1711.99829, 14.44807,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2397.36841, -1708.65454, 15.84674,   0.00000, 0.00000, 271.43210);
	CreateDynamicObject(19365, 2408.05298, -1711.99829, 15.75408,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.04370, -1712.19971, 11.55200,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.04370, -1712.19971, 14.93308,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2408.04370, -1712.19971, 15.73508,   0.00000, 0.00000, 0.39998);
	CreateDynamicObject(19365, 2406.36279, -1713.53735, 14.33681,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2406.36279, -1713.53735, 15.73882,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2401.11426, -1713.47754, 12.16838,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2405.92847, -1713.49707, 15.72099,   0.00000, 0.00000, 268.99124);
	CreateDynamicObject(19365, 2399.46680, -1713.49133, 14.41698,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2400.13818, -1711.86279, 15.94270,   0.00000, 0.00000, 182.08331);
	CreateDynamicObject(19365, 2398.49268, -1708.63611, 15.84470,   0.00000, 0.00000, 91.12875);
	CreateDynamicObject(19365, 2400.07544, -1710.19751, 15.86205,   0.00000, 0.00000, 181.98131);
	CreateDynamicObject(19365, 2398.49268, -1708.63611, 14.33870,   0.00000, 0.00000, 91.12875);
	CreateDynamicObject(19365, 2395.77490, -1700.12683, 14.92706,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2400.08545, -1710.09802, 14.33870,   0.00000, 0.00000, 182.18231);
	CreateDynamicObject(19365, 2400.13818, -1711.86279, 14.33870,   0.00000, 0.00000, 182.08331);
	CreateDynamicObject(19356, 2406.30518, -1709.40308, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2402.67261, -1712.44141, 13.12509,   0.00000, 90.00000, -0.48000);
	CreateDynamicObject(19356, 2399.18237, -1712.43604, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2399.22583, -1709.25037, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2402.66455, -1709.22852, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2397.32471, -1709.10706, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2397.32666, -1706.16748, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2400.71191, -1706.10010, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2404.18066, -1706.18750, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2406.30762, -1699.97522, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2406.20044, -1711.93640, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2406.10034, -1711.93799, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2406.20825, -1706.23547, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2406.16016, -1703.10474, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2402.72241, -1703.06335, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2399.30078, -1703.06116, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2397.34229, -1703.03845, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2397.19556, -1699.97058, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2400.56470, -1700.03674, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19356, 2403.73096, -1700.01697, 13.12509,   0.00000, 90.00000, 359.84982);
	CreateDynamicObject(19365, 2399.46680, -1713.49133, 15.72099,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2401.18066, -1713.44128, 14.91998,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2400.98022, -1713.43225, 15.71999,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2397.36792, -1708.64697, 14.33870,   0.00000, 0.00000, 271.43210);
	CreateDynamicObject(19365, 2395.78638, -1707.11389, 14.29261,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2395.78638, -1707.11389, 15.90472,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2395.79053, -1703.93738, 14.80471,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2395.79053, -1703.93738, 15.92607,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2395.78174, -1700.72864, 14.92406,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2406.37500, -1698.58899, 12.61607,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2395.75269, -1700.10938, 15.92707,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19394, 2403.49487, -1713.47534, 15.03433,   0.00000, 0.00000, 269.02487);
	CreateDynamicObject(19365, 2405.96313, -1713.59082, 13.27539,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2405.86328, -1713.59473, 12.16838,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19365, 2395.78174, -1700.72961, 15.92607,   0.00000, 0.00000, 180.08966);
	CreateDynamicObject(19365, 2397.39893, -1698.62671, 14.93920,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2397.39893, -1698.62610, 15.64020,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2400.66431, -1698.64636, 14.92809,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2400.66431, -1698.64636, 15.62809,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2403.77563, -1698.66187, 14.92709,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2403.77563, -1698.66187, 15.72909,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2406.37500, -1698.58899, 15.72909,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2401.16455, -1700.03540, 15.82839,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2401.17163, -1703.24744, 15.81627,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2401.16455, -1700.03540, 14.21327,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2401.17163, -1703.24744, 15.81627,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19394, 2401.12573, -1707.00806, 15.78954,   0.00000, 0.00000, 357.49680);
	CreateDynamicObject(19365, 2401.17163, -1703.24744, 14.21327,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2399.44873, -1708.61719, 15.90355,   0.00000, 0.00000, 271.99802);
	CreateDynamicObject(19365, 2401.18164, -1703.85339, 15.83562,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2401.18164, -1703.85339, 14.21327,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2401.18555, -1704.65417, 12.35940,   0.00000, 0.00000, 359.99899);
	CreateDynamicObject(19365, 2401.06128, -1709.31921, 12.35940,   0.00000, 0.00000, 359.99899);
	CreateDynamicObject(19365, 2401.06128, -1709.31921, 15.81057,   0.00000, 0.00000, 359.99899);
	CreateDynamicObject(19365, 2399.47461, -1710.84961, 14.80656,   0.00000, 0.00000, 271.89801);
	CreateDynamicObject(19365, 2399.47461, -1710.84961, 15.80656,   0.00000, 0.00000, 271.89801);
	CreateDynamicObject(19365, 2399.44873, -1708.61719, 14.90255,   0.00000, 0.00000, 271.99802);
	CreateDynamicObject(2313, 2407.33765, -1702.16260, 13.19065,   0.00000, 0.00000, 271.05884);
	CreateDynamicObject(1752, 2407.43677, -1702.92798, 13.73880,   0.00000, 0.00000, 271.37253);
	CreateDynamicObject(2818, 2403.92407, -1703.02014, 13.25755,   0.00000, 0.00000, 270.50848);
	CreateDynamicObject(2637, 2404.40723, -1703.40674, 13.70218,   0.00000, 0.00000, 270.74286);
	CreateDynamicObject(2240, 2401.73950, -1699.27942, 13.68537,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 2401.82275, -1704.29517, 13.20018,   0.00000, 0.00000, 90.42944);
	CreateDynamicObject(1725, 2399.36890, -1702.23718, 13.06973,   0.00000, 0.00000, 0.10001);
	CreateDynamicObject(2195, 2396.38452, -1699.26233, 13.75639,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2528, 2396.36206, -1706.74951, 13.21242,   0.00000, 0.00000, 90.87653);
	CreateDynamicObject(19365, 2397.49878, -1698.62256, 14.93920,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19365, 2397.49878, -1698.62195, 15.64020,   0.00000, 0.00000, 90.32404);
	CreateDynamicObject(19362, 5034.87988, -11363.89844, 500.74258,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, 2406.50244, -1703.16895, 17.21711,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2397.53857, -1705.28125, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.39819, -1702.47681, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.38647, -1704.66907, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.37866, -1707.74695, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.36377, -1710.92920, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.36816, -1711.82996, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2405.74707, -1711.81091, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2406.24854, -1711.80786, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2406.28223, -1706.31946, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2405.82910, -1708.67969, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2405.71265, -1705.61707, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2405.68628, -1702.50305, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2405.80933, -1700.01843, 17.21711,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2406.42432, -1700.00281, 17.21711,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2406.22949, -1708.65173, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2402.37402, -1699.34839, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2398.96802, -1699.27478, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2397.56274, -1699.24402, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2397.65088, -1702.35864, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2398.95093, -1702.31421, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2399.23071, -1705.14478, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2399.22144, -1707.05518, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, 2397.61792, -1707.23267, 17.21510,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19394, 2403.49487, -1713.47534, 15.63534,   0.00000, 0.00000, 269.02487);
	CreateDynamicObject(19365, 2400.98022, -1713.43225, 14.91998,   0.00000, 0.00000, 270.20139);
	CreateDynamicObject(19356, 2406.10400, -1709.40332, 13.12509,   0.00000, 90.00000, 359.84982);
	RTH[dooorss] = CreateDynamicObject(1498, 2402.765625, -1713.649658, 13.2043,   0.00000, 0.00000, 0.00000);
	RTH[safee1] = CreateDynamicObject(2332,2401.61060,-1701.00549,13.62613,0,0,90.38680);
	RTH[safee2] = CreateDynamicObject(2332,2398.41870,-1699.10547,13.61148,0,0,0);
	RTH[textdooorss] = CreateDynamic3DTextLabel("{4169E1}Dom z sejfami\n{FFFFFF}Wpisz {4169E1}/wy³am {FFFFFF}aby wy³amaæ drzwi",COLOR_LIGHTGREENNAPAD,2403.6008,-1714.6058,14.2733,9);
	RTH[textsafee1] = CreateDynamic3DTextLabel("{4169E1}Sejf\n{FFFFFF}Wpisz {4169E1}/wlamanie {FFFFFF}aby w³amaæ siê do sejfu",COLOR_LIGHTGREENNAPAD,2402.9250,-1701.0734,14.2110,3);
	RTH[textsafee2] = CreateDynamic3DTextLabel("{4169E1}Sejf\n{FFFFFF}Wpisz {4169E1}/wlamanie {FFFFFF}aby w³amaæ siê do sejfu",COLOR_LIGHTGREENNAPAD,2398.5591,-1700.7568,14.2110,3);
	RTH[TimeToKick] = DOORKICKTIME;
	RTH[TimeToClose] = DOORCLOSETIME;
	RTH[TimeToRob1] = SAFEROBTIME;
	RTH[TimeToRob2] = SAFEROBTIME;
	RTH[WaitTime] = 0;
	return 1;
}

stock OnPlayerConnectNapadDomek(playerid)
{
	RemoveBuildingForPlayer(playerid, 17935, 2401.2656, -1708.3828, 14.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 2404.5625, -1718.9922, 13.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 2399.1406, -1718.5625, 13.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 17934, 2401.2656, -1708.3828, 14.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 2394.1875, -1700.7188, 12.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 17876, 2393.0625, -1677.5234, 20.8203, 0.25);
}

YCMD:wlamanie(playerid, params[]){
	if(IsPlayerInRangeOfPoint(playerid, 1.0, 2402.9250,-1701.0734,14.2110) || IsPlayerInRangeOfPoint(playerid, 1.0, 2398.5591,-1700.7568,14.2110)){
		if(!IsAPrzestepca(playerid)) return noAccessMessage(playerid);
		if(GetPlayerVirtualWorld(playerid) != 0) return SendClientMessage(playerid, -1, "Dom mo¿na okradaæ tylko na vw 0!");
		if(!RTH[openeedd] || RTH[TimerKickdooorss] != 0){
			SendClientMessage(playerid, -1, "Drzwi s¹ zamkniête");
		}
		else{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, 2402.9250,-1701.0734,14.2110)){
				if(RTH[TimerRobbing1] != 0 || RTH[safeopeneedd1]){
					SendClientMessage(playerid, -1, "Nie mo¿esz ju¿ okraœæ tego sejfu.");
				}
				else if((RTH[TimeToClose] - 10) < SAFEROBTIME){
					SendClientMessage(playerid, -1, "Uciekaj st¹d, nie zd¹¿y³byœ");
				}
				else{
					DestroyDynamicObject(RTH[safee1]);
					RTH[safeopeneedd1] = true;
					RTH[safee1] = CreateDynamicObject(1829,2402.02686,-1701.00488,13.64308,0,0,89.68206);
					Streamer_Update(playerid);
					SetPlayerPos(playerid, 2402.6479,-1700.9277,14.2110);
					SetPlayerFacingAngle(playerid, 90.0);
					SetCameraBehindPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					RTH[TimerRobbing1] = SetTimerEx("RobSafe", 1000, true, "id", playerid, 1); 
					ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
					UpdateDynamic3DTextLabelText(RTH[textsafee1], COLOR_LIGHTGREENNAPAD, "{4169E1}Sejf\n{FF0000}Trwa okradanie");
					SendRadioMessage(1, COLOR_LIGHTRED, "HQ: Trwa rabunek na dom w dzielnicy Idlewood!!!", 0);
				}
			}
			else{
				if(RTH[TimerRobbing2] != 0 || RTH[safeopeneedd2]){
					SendClientMessage(playerid, -1, "Nie mo¿esz ju¿ okraœæ tego sejfu.");
				}
				else if((RTH[TimeToClose] - 10) < SAFEROBTIME){
					SendClientMessage(playerid, -1, "Uciekaj st¹d, nie zd¹¿y³byœ");
				}
				else{
					DestroyDynamicObject(RTH[safee2]);
					RTH[safeopeneedd2] = true;
					RTH[safee2] = CreateDynamicObject(1829,2398.47705,-1699.42151,13.61457,0,0,0);
					Streamer_Update(playerid);
					SetPlayerPos(playerid, 2398.4651,-1700.1763,14.2110);
					SetPlayerFacingAngle(playerid, 0.0);
					SetCameraBehindPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					RTH[TimerRobbing2] = SetTimerEx("RobSafe", 1000, true, "id", playerid, 2); 
					ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
					UpdateDynamic3DTextLabelText(RTH[textsafee2], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\n{FF0000}Trwa okradanie");
					SendRadioMessage(1, COLOR_LIGHTRED, "HQ: Trwa rabunek na dom w dzielnicy Idlewood!!!", 0);
				}
			}
		}	
	}
	else{
		SendClientMessage(playerid, -1, "Nie stoisz przy sejfie");
	}
	return 1;
}

YCMD:wylam(playerid, params[]){
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2402.765625, -1713.649658, 13.2043))
	{
		if(!IsAPrzestepca(playerid)) return noAccessMessage(playerid);
		if(GetPlayerVirtualWorld(playerid) != 0) return SendClientMessage(playerid, -1, "Dom mo¿na okradaæ tylko na vw 0!");
		if(RTH[openeedd])
			return SendClientMessage(playerid, -1, "Nie mo¿esz otworzyæ drzwi, s¹ otwarte b¹dŸ ktoœ je otwiera");
		if(RTH[WaitTimer] != 0)
			return SendClientMessage(playerid, -1, "Nie mo¿esz teraz u¿yæ tej komendy");
		SetPlayerPos(playerid, 2403.5842, -1714.7684, 14.2733);
		SetPlayerFacingAngle(playerid, 0.0);
		SetCameraBehindPlayer(playerid);
		
		RTH[TimerKickdooorss] = SetTimerEx("Kickdooorss", 1000, true, "i", playerid);
		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 1, 0, 0, 0, 0, 1);
		TogglePlayerControllable(playerid, 0);
		RTH[openeedd] = true;
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, "{4169E1}Dom z sejfami\n{FF0000}Drzwi s¹ wy³amywane");
	}
	else
		SendClientMessage(playerid, -1, "Nie stoisz przy drzwiach");
	return 1;
}

forward RobSafe(playerid, id);
public RobSafe(playerid, id){
	new string[128];
	if(id == 1){
		RTH[TimeToRob1]--;
		if(RTH[TimeToRob1] <= 0){
			SetPVarInt(playerid, "ROBBING_SAFE", 0);
			KillTimer(RTH[TimerRobbing1]);
			RTH[TimerRobbing1] = 0;
			RTH[TimeToRob1] = SAFEROBTIME;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
			UpdateDynamic3DTextLabelText(RTH[textsafee1], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\n{FF0000}Okradziony");
			new ile = randomexyz(MINMONEY, MAXMONEY);
			DajKaseDone(playerid, ile);
			format(string, sizeof string, "Zdoby³eœ %d$, a teraz siê sprê¿aj z ucieczk¹, do zamkniêcia drzwi pozosta³o %dsek.", ile, RTH[TimeToClose]);
			SendClientMessage(playerid, -1, string);
			TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
		}
		else{
			SetPVarInt(playerid, "ROBBING_SAFE", 1);
			format(string, sizeof(string), "Wlamywanie: ~y~%d~w~s~n~Nacisnij ~y~N ~w~aby anulowac", RTH[TimeToRob1]); 
			//GameTextForPlayer(playerid, string, 1000, 4);
			TextDrawSetString(TextDrawInfo[playerid], string);
			TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
			ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
		}
	}
	else if(id == 2){
		RTH[TimeToRob2]--;
		if(RTH[TimeToRob2] <= 0){
			SetPVarInt(playerid, "ROBBING_SAFE", 0);
			KillTimer(RTH[TimerRobbing2]);
			RTH[TimerRobbing2] = 0;
			RTH[TimeToRob2] = SAFEROBTIME;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
			UpdateDynamic3DTextLabelText(RTH[textsafee2], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\n{FF0000}Okradziony");
			new ile = randomexyz(MINMONEY, MAXMONEY);
			DajKaseDone(playerid, ile);
			format(string, sizeof string, "Zdoby³eœ %d$, a teraz siê sprê¿aj z ucieczk¹, do zamkniêcia drzwi pozosta³o %dsek.", ile, RTH[TimeToClose]);
			SendClientMessage(playerid, -1, string);
			TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
		}
		else{
			SetPVarInt(playerid, "ROBBING_SAFE", 2);
			format(string, sizeof(string), "Wlamywanie: ~y~%d~w~s~n~Nacisnij ~y~N ~w~aby anulowac", RTH[TimeToRob2]); 
			//GameTextForPlayer(playerid, string, 1000, 4);
			TextDrawSetString(TextDrawInfo[playerid], string);
			TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
			ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
		}
	}
	return 1;
}

forward Kickdooorss(playerid);
public Kickdooorss(playerid){
	RTH[TimeToKick]--;
	new string[128];
	if(RTH[TimeToKick] <= 0){
		SetPVarInt(playerid, "ROBBING_DOORS", 0);
		KillTimer(RTH[TimerKickdooorss]);
		RTH[TimerKickdooorss] = 0;
		RTH[TimeToKick] = DOORKICKTIME;
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		SetDynamicObjectRot(RTH[dooorss], 0.0, 0.0, -116.0);
		RTH[TimerClosedooorss] = SetTimer("Closedooorss", 1000, 1);
		format(string, sizeof string, "{4169E1}Dom z sejfami\n{FF0000}\n{FFFFFF}Do zamkniêcia siê drzwi pozosta³o: {FFFF00}%d sekund", RTH[TimeToClose]);
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, string);
	}
	else{
		SetPVarInt(playerid, "ROBBING_DOORS", 1);
		format(string, sizeof string, "Wykopywanie drzwi, pozostalo: ~y~%d~w~s~n~Nacisnij ~y~N ~w~aby anulowac", RTH[TimeToKick]);
		//GameTextForPlayer(playerid, string, 1000, 4);
		TextDrawInfoOn(playerid, string, DOORKICKTIME * 1000);
		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

forward Closedooorss();
public Closedooorss(){
	RTH[TimeToClose]--;
	if(RTH[TimeToClose] <= 0){
		SetDynamicObjectRot(RTH[dooorss], 0.0, 0.0, 0.0);
		KillTimer(RTH[TimerClosedooorss]);
		RTH[openeedd] = false;
		RTH[TimeToClose] = DOORCLOSETIME;
		DestroyDynamicObject(RTH[safee1]);
		DestroyDynamicObject(RTH[safee2]);
		RTH[safee1] = CreateDynamicObject(2332,2401.61060,-1701.00549,13.62613,0,0,90.38680);
		RTH[safee2] = CreateDynamicObject(2332,2398.41870,-1699.10547,13.61148,0,0,0);
		RTH[safeopeneedd1] = false;
		RTH[safeopeneedd2] = false;
		RTH[WaitTime] = WAITTIME;
		RTH[WaitTimer] = SetTimer("Unlockdooorss", 1000, 1);
		UpdateDynamic3DTextLabelText(RTH[textsafee1], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\nWpisz {FFFFFF}/wlamanie {1FA7FF}aby w³amaæ siê do sejfu");
		UpdateDynamic3DTextLabelText(RTH[textsafee2], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\nWpisz {FFFFFF}/wlamanie {1FA7FF}aby w³amaæ siê do sejfu");
		new string[128];
		format(string, sizeof string, "{1FA7FF}Dom z sejfami\n{FF0000}\n{FFFFFF}Mo¿liwoœæ otwarcia drzwi zostanie przywrócona za {FFFF00}%d sekund", RTH[WaitTime]);
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, string);
	}
	else{
		new string[128];
		format(string, sizeof string, "{1FA7FF}Dom z sejfami\n{FF0000}\n{FFFFFF}Do zamkniêcia siê drzwi pozosta³o: {FFFF00}%d sekund", RTH[TimeToClose]);
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, string);
	}
	return 1;
}

forward Unlockdooorss();
public Unlockdooorss(){
	RTH[WaitTime]--;
	if(RTH[WaitTime] <= 0){
		KillTimer(RTH[WaitTimer]);
		RTH[WaitTimer] = 0;
		RTH[WaitTime] = WAITTIME;
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Dom z sejfami\nWpisz {FFFFFF}/wylam {1FA7FF}aby wylamac drzwi");
	}
	else{
		new string[128];
		format(string, sizeof string, "{1FA7FF}Dom z sejfami\n{FF0000}\n{FFFFFF}Mo¿liwoœæ otwarcia drzwi zostanie przywrócona za {FFFF00}%d sekund", RTH[WaitTime]);
		UpdateDynamic3DTextLabelText(RTH[textdooorss], COLOR_LIGHTGREENNAPAD, string);
	}
	return 1;
}