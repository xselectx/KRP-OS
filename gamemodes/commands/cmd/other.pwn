//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ admini ]------------------------------------------------//
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
// WALKSTYLE
#define WALK_DEFAULT    0
#define WALK_NORMAL     1
#define WALK_PED        2
#define WALK_GANGSTA    3
#define WALK_GANGSTA2   4
#define WALK_OLD        5
#define WALK_FAT_OLD    6
#define WALK_FAT        7
#define WALK_LADY      	8
#define WALK_LADY2      9
#define WALK_WHORE      10
#define WALK_WHORE2     11
#define WALK_DRUNK     	12
#define WALK_BLIND     	13
#define DIALOG_WALKSTYLE 			59

new WalkStyle[MAX_PLAYERS];
stock SetPlayerWalkingStyle(playerid, style)
{
    WalkStyle[playerid] = style;
}

stock GetPlayerWalkingStyle(playerid)
{
	return WalkStyle[playerid];
}
forward rozpowszechnianie(playerid);
public rozpowszechnianie(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	AddFire(X+0.5, Y, Z, 500);
}

#define MAX_SPIKES 1 //Maxymalna iloœæ kolczatek
enum SpikeEnum
{
	bool:Use,
	ObjectID,
	Float:pX1,
	Float:pY1,
	Float:pZ1,
	Float:pX2,
	Float:pY2,
	Float:pZ2,
	Float:pX3,
	Float:pY3,
	Float:pZ3,
	Float:pX4,
	Float:pY4,
	Float:pZ4,
	Float:pX5,
	Float:pY5,
	Float:pZ5
};
new Spike[MAX_SPIKES][SpikeEnum],
Spikes;

stock GetXYPoint(Float:addplus, &Float:x, &Float:y, &Float:a, Float:distance)
{
	a += addplus;
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock CreateSpike(Float:x, Float:y, Float:z, Float:a)
{
    new spikeid = -1;
    for(new i = 0; i < MAX_SPIKES; i++)
    {
        if(Spike[i][Use] == false)
        {
            new Float:pos[2];
            pos[0] = x;
            pos[1] = y;

            Spike[i][Use] = true;
            Spike[i][ObjectID] = CreateObject(2892,x,y,z,0.0,0.0,a);
            Spikes += 1;
            spikeid = i;

            Spike[i][pX1] = x;
            Spike[i][pY1] = y;
            Spike[i][pZ1] = z;

            GetXYPoint(0.0,x,y,a,2);
            Spike[i][pX2] = x;
            Spike[i][pY2] = y;
            Spike[i][pZ2] = z;
            x = pos[0];
            y = pos[1];

            GetXYPoint(0.0,x,y,a,4);
            Spike[i][pX3] = x;
            Spike[i][pY3] = y;
            Spike[i][pZ3] = z;
            x = pos[0];
            y = pos[1];

            GetXYPoint(0.0,x,y,a,-2);
            Spike[i][pX4] = x;
            Spike[i][pY4] = y;
            Spike[i][pZ4] = z;
            x = pos[0];
            y = pos[1];

            GetXYPoint(0.0,x,y,a,-4);
            Spike[i][pX5] = x;
            Spike[i][pY5] = y;
            Spike[i][pZ5] = z;
            x = pos[0];
            y = pos[1];
            break;
        }
    }
    return spikeid;
}

stock DestroySpike(spikeid)
{
    if(Spike[spikeid][Use] == true)
    {
        Spike[spikeid][Use] = false;
        DestroyObject(Spike[spikeid][ObjectID]);
        return 1;
    }
    return 0;
}

YCMD:kolczatka(playerid, params[])
{
    if(IsAPolicja(playerid) && OnDuty[playerid] > 0)
    {
        new Float:pos[4];
        GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
        GetPlayerFacingAngle(playerid,pos[3]);
        CreateSpike(pos[0],pos[1],pos[2] - 1,pos[3]); 
    }
    return 1;
}

YCMD:usunkol(playerid, params[])
{
    if(IsAPolicja(playerid) && OnDuty[playerid] > 0)
    {
        new spikeid;
        DestroySpike(spikeid);
    }
    return 1;
}

YCMD:apteka(playerid, params[])
{
	if(!DoInRange(1.5,playerid,1148.7488, -1323.1597, 68.2710))
	{
		SendClientMessage(playerid, CLR_RED,"Nie jesteœ w szpitalu.");
		return 1;
	}
	ShowPlayerDialogEx(playerid,D_APTEKA,DIALOG_STYLE_LIST,"APTEKA","GRIPEX (45hp) \nAPAP (50hp)\n","Wybierz","WyjdŸ");
	return 1;
}

YCMD:walkstyle(playerid, params[])
{
    if(IsPlayerConnected(playerid))
 	{
        {
        	ShowPlayerDialogEx(playerid, DIALOG_WALKSTYLE, DIALOG_STYLE_LIST, "Pobijanie stylu:", "Normal\nLow Walk\nGangsta\nGangsta2\nOld Walk\nOld Walk2\nNormal Walk2\nFemale Walk\nFemale Walk2\nWhore Walk\nFemale Walk3\nDrunk Walk\nBlind Walk\nNormal", "Wybierz", "Anuluj");
  			return 1;
		}
	}
	return 1;
}
YCMD:zegarek(playerid, params[])
{
	ApplyAnimation(playerid,"PLAYIDLES","time",4.1,0,1,1,1,1);
	return 1;
}