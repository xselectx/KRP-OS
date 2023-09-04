#include <a_samp>
#define FILTERSCRIPT
#define COLOR 0x33CCFFAA
#define hp 30
new incar[MAX_PLAYERS];
new WszedlDoPojazdu[MAX_PLAYERS];
new Float:oldhealth[MAX_PLAYERS];
new Float:newhealth[MAX_PLAYERS];
new pasy[MAX_PLAYERS];//pasy
new kask[MAX_PLAYERS];
new scantimer[MAX_PLAYERS];

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

public OnFilterScriptInit()
{
	for(new i; i<MAX_PLAYERS; i++)
		scantimer[i] = -1;
	print("Wypadek by Mrucznik");
	return 1;
}

public OnPlayerConnect(playerid)
{
    incar[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(incar[playerid] == 1) 
	{
		KillScanhpTimer(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(incar[playerid] == 1)
		KillScanhpTimer(playerid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehicleid,newhealth[playerid]);
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		StarScanhpTimer(playerid);
	    GetVehicleHealth(vehicleid,oldhealth[playerid]);
	    incar[playerid] = 1;
		return 1;
	}
	if((oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) || (oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT))
	{
		KillScanhpTimer(playerid);
		new nick[MAX_PLAYER_NAME];
	   	new string[256];
		GetPlayerName(playerid, nick, sizeof(nick));
		if(pasy[playerid] == 1)
		{
		   	format(string, sizeof(string), "* %s odpina pasy.", nick);
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
			pasy[playerid] = 0;
		}
		if(kask[playerid] == 1)
		{
		   	format(string, sizeof(string), "* %s �ci�ga kask z g�owy.", nick);
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
			RemovePlayerAttachedObject(playerid, 3);
			kask[playerid] = 0;
		}
		incar[playerid] = 0;
		return 1;
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    SetTimerEx("EnterCar",15000,0,"d",playerid);
	WszedlDoPojazdu[playerid] = 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
	{
		if(!strcmp(cmdtext, "/zp", true) || !strcmp(cmdtext, "/zapnijpasy", true))
		{
		    if(!IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		format(string, sizeof(string), "* %s zapina pasy", nick);
				ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
				pasy[playerid] = 1;
            }
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo�esz zapi�� pas�w!");
			}
		}
		if(!strcmp(cmdtext, "/op", true) || !strcmp(cmdtext, "/odepnijpasy", true))
		{
		    if(!IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		format(string, sizeof(string), "* %s odpina pasy", nick);
				ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
				pasy[playerid] = 0;
            }
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo�esz odpi�� pas�w!");
			}
		}
		if(!strcmp(cmdtext, "/kask", true))
		{
			if(IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		if(kask[playerid] == 1)
				{
		   			format(string, sizeof(string), "* %s �ci�ga kask z g�owy.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					RemovePlayerAttachedObject(playerid, 3);
					kask[playerid] = 0;
				}
				else if(kask[playerid] != 1)
				{
			    	format(string, sizeof(string), "* %s zak�ada kask na g�ow�.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SetPlayerAttachedObject(playerid,3 , 18645, 2, 0.07, 0.017, 0, 88, 75, 0);
					kask[playerid] = 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo�esz za�o�y� kasku!");
			}
		}
	}
	return 0;
}

forward scanhp(playerid);
public scanhp(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
    new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehicleid,newhealth[playerid]);
	if(oldhealth[playerid] > (newhealth[playerid] + hp))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 2064.0703,-1831.3167,13.3853) || IsPlayerInRangeOfPoint(playerid, 7.0, 1024.8514,-1022.2302,31.9395) || IsPlayerInRangeOfPoint(playerid, 7.0, 486.9398,-1742.4130,10.9594) || IsPlayerInRangeOfPoint(playerid, 7.0, -1904.2325,285.3743,40.8843)  || IsPlayerInRangeOfPoint(playerid, 7.0, 720.0876,-458.3574,16.3359))
	    {
	        SendClientMessage(playerid,COLOR,"Pojazd naprawiony!");
	    }
	    else
		{
			if(WszedlDoPojazdu[playerid] == 0)
			{
				if(oldhealth[playerid] > (newhealth[playerid] + 120))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					new Float:zyciewypadku;
					GetPlayerName(playerid, nick, sizeof(nick));
					GetPlayerHealth(playerid, zyciewypadku);
					SetPlayerHealth(playerid, zyciewypadku-7);
					format(string, sizeof(string), "* %s uderzy� g�ow� w kierownice mimo zapi�tych pas�w", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid,COLOR,"Ale przywali�e�, szcz�cie �e mia�e� zapi�te pasy!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + hp))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Pasy zadzia�a�y i %s nie dozna� powa�nych obra�e� (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid,COLOR,"Kolejna st�uczka, mia�e� zapi�te pasy i nic ci si� nie sta�o!");
				}
			}
			else if(WszedlDoPojazdu[playerid] == 0 && IsABike(vehicleid))
			{
				if(oldhealth[playerid] > (newhealth[playerid] + 120))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					new Float:zyciewypadku;
					GetPlayerName(playerid, nick, sizeof(nick));
					GetPlayerHealth(playerid, zyciewypadku);
					SetPlayerHealth(playerid, zyciewypadku-7);
					format(string, sizeof(string), "* %s uderzy� kaskiem w kierownic�.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid,COLOR,"Ale przywali�e�, szcz�cie �e mia�e� kask na g�owie!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + hp))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Kask uratowa� %s i nie dozna� powa�nych obra�e�. (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid,COLOR,"Kolejna st�uczka, mia�e� kask na g�owie i nic ci si� nie sta�o!");
				}
			}
		}
	}
	GetVehicleHealth(vehicleid,oldhealth[playerid]);
	return 1;
}

forward EnterCar(playerid);
public EnterCar(playerid)
{
	WszedlDoPojazdu[playerid] = 0;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, string);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, string);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, string);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, string);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, string);
				}
			}
		}
	}//not connected
	return 1;
}
stock IsABike(vehicleid) //Made by me :D
{
	new result;
	new model = GetVehicleModel(vehicleid);
    switch(model)
    {
        case 509, 481, 510, 462, 448, 581, 522, 461, 521, 523, 463, 586, 468, 471: result = model;
        default: result = 0;
    }
	return result;
}

StarScanhpTimer(playerid)
{
	if(!IsScanhpTimerActive(playerid))
	{
		scantimer[playerid] = SetTimerEx("scanhp",1000,true,"i",playerid);
	}
}

IsScanhpTimerActive(playerid)
{
	return scantimer[playerid] != -1;
}

KillScanhpTimer(playerid)
{
	KillTimer(scantimer[playerid]);
	scantimer[playerid] = -1;
}
