new g_Alpha[MAX_PLAYERS];
new PlayerText:g_PlayerTextDraw[MAX_PLAYERS] = PlayerText:INVALID_TEXT_DRAW;
#define AlphaConvert(%0,%1) ((%0 & ~0xFF) | clamp(%1, 0x00, 0xFF))

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	if(g_PlayerTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		g_PlayerTextDraw[playerid] = CreatePlayerTextDraw(playerid,  -24.000000, -13.000000, "ld_dual:health");
		PlayerTextDrawFont(playerid, g_PlayerTextDraw[playerid], 4);
		PlayerTextDrawLetterSize(playerid, g_PlayerTextDraw[playerid],  0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, g_PlayerTextDraw[playerid], 702.000000, 489.000000);
		PlayerTextDrawColor(playerid, g_PlayerTextDraw[playerid], 0x772222FF);
		PlayerTextDrawAlignment(playerid, g_PlayerTextDraw[playerid], 1);
		PlayerTextDrawSetProportional(playerid, g_PlayerTextDraw[playerid], 1);
	}
	g_Alpha[playerid] = 200;
	PlayerTextDrawColor(playerid, g_PlayerTextDraw[playerid], AlphaConvert(0x552222FF, g_Alpha[playerid]));
	PlayerTextDrawShow(playerid, g_PlayerTextDraw[playerid]);
	return true;
}

hook OnPlayerUpdate(playerid)
{
	if(g_Alpha[playerid] > 0)
	{
		g_Alpha[playerid] -= 5;
		PlayerTextDrawColor(playerid, g_PlayerTextDraw[playerid], AlphaConvert(0x552222FF, g_Alpha[playerid]));
		PlayerTextDrawShow(playerid, g_PlayerTextDraw[playerid]);
	}
	else if(g_PlayerTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawHide(playerid, g_PlayerTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, g_PlayerTextDraw[playerid]);
		g_PlayerTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return true;
}