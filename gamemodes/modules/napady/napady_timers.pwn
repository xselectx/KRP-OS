//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: napady.pwn ]------------------------------------------//
//----------------------------------------[ Autor: renosk ]----------------------------------------//

#include <YSI_Coding\y_timers>

//-----------------<[ Timery: ]>-------------------

ptask Robbery[1000](playerid)
{
    new string[248];
    if(PlayerHeist[playerid][p_Heist] > -1 && Heist[PlayerHeist[playerid][p_Heist]][h_UID] > 0)
    {
        new heist = PlayerHeist[playerid][p_Heist];
        if(PlayerHeist[playerid][p_VW] != -1 && GetPlayerVirtualWorld(playerid) != PlayerHeist[playerid][p_VW])
            return Heist_Fail(playerid, INVALID_PLAYER_ID);
        if(PlayerHeist[playerid][p_RobTime] > 1)
        {
            switch(PlayerHeist[playerid][p_State])
            {
                case STATE_OPENING:
                {
                    format(string, sizeof(string), "~b~~h~Sejf~n~~n~~w~Otwieranie sejfu...~n~Do wykonania ~r~%s", ConvertToMinutes(PlayerHeist[playerid][p_RobTime]));
				    PlayerTextDrawSetString(playerid, RobberyText[playerid], string);
                }
                case STATE_OPENING2:
                {
                    format(string, sizeof(string), "~b~~h~Sejf~n~~n~~w~Otwieranie drzwi sejfu...~n~Do wykonania ~r~%s", ConvertToMinutes(PlayerHeist[playerid][p_RobTime]));
				    PlayerTextDrawSetString(playerid, RobberyText[playerid], string);
                }
                case STATE_ROBBING:
                {
                    if(PlayerHeist[playerid][p_RobTime]%5==0)
                    {
                        if( PlayerHeist[playerid][p_MoneyStolen] >= Heist[heist][h_Cash])
                        {
                            PlayerHeist[playerid][p_RobTime] = 2;
                        }
                        else
                        {
                            PlayerHeist[playerid][p_MoneyStolen] += RandomEx(750, 1000);
                                
                            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
                        }
                    }
                    format(string, sizeof(string), "~b~~h~Sejf~n~~n~~w~Zgarniete pieniadze: ~g~~h~~h~%s~n~Sukces za okolo ~r~%s", formatInt(PlayerHeist[playerid][p_MoneyStolen]), ConvertToMinutes(PlayerHeist[playerid][p_RobTime]));
				    PlayerTextDrawSetString(playerid, RobberyText[playerid], string);
                }
            }
            PlayerHeist[playerid][p_RobTime]--;
        }
        else if(PlayerHeist[playerid][p_RobTime] == 1)
        {
            switch(PlayerHeist[playerid][p_State])
            {
                case STATE_OPENING:
                {
                    new Float: x, Float: y, Float: z, Float: a;
                    GetDynamicObjectPos(Heist[heist][h_Object][0], x, y, z);
                    GetDynamicObjectRot(Heist[heist][h_Object][1], a, a, a);
                    MoveDynamicObject(Heist[heist][h_Object][1], x, y, z+0.015, 0.005, 0.0, 0.0, a+230.0);
                    
                    PlayerHeist[playerid][p_RobTime] = 4;
                    PlayerHeist[playerid][p_State] = STATE_OPENING2;
                    PlayerTextDrawSetString(playerid, RobberyText[playerid], "~b~~h~Sejf~n~~n~~w~Otwieranie drzwi sejfu...~n~Do wykonania ~r~00:04");
                    RemovePlayerAttachedObject(playerid, 4);
                    ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Open", 4.0, 0, 0, 0, 0, 0, 1);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                }
                case STATE_OPENING2:
                {
                    PlayerHeist[playerid][p_RobTime] = 900;
                    PlayerHeist[playerid][p_State] = STATE_ROBBING;
                    SetPlayerAttachedObject(playerid, 4, 1550, 1, 0.029999, -0.265000, 0.017000, 6.199993, 88.800003, 0.0);
                    format(string, sizeof(string), "~b~~h~Sejf~n~~n~~w~Zgarniete pieniadze: ~g~~h~~h~$0~n~Do wykonania ~r~%s", ConvertToMinutes(PlayerHeist[playerid][p_RobTime]));
                    PlayerTextDrawSetString(playerid, RobberyText[playerid], string);
                    ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                }
                case STATE_ROBBING:
                {
                    format(string, sizeof(string), "~n~~n~~n~~b~~h~~h~Sejf okradziony pomyslnie!~n~~w~Zgarniete pieniadze: ~g~~h~~h~%s", formatInt(PlayerHeist[playerid][p_MoneyStolen]));
                    GameTextForPlayer(playerid, string, 3000, 3);
                    DajKaseDone(playerid, PlayerHeist[playerid][p_MoneyStolen]);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
         		    TogglePlayerControllable(playerid, 1);
                    ClearAnimations(playerid);
                    RemovePlayerAttachedObject(playerid, 4);
                    PlayerTextDrawHide(playerid, RobberyText[playerid]);


                    Heist[heist][h_Cooldown] = gettime()+10800; //10800 = 5 godzin
		    	    Heist_Reset(heist);

                    PlayerHeist[playerid][p_Heist] = -1;
                    PlayerHeist[playerid][p_VW] = -1;
                    PlayerHeist[playerid][p_RobTime] = 0;
                    PlayerHeist[playerid][p_MoneyStolen] = 0;
                }
            }
        }
    }
    return 1;
}