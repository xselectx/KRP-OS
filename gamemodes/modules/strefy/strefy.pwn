const Float:ZONE_RADIUS = 200.0; // promie� strefy
const Float:ZONE_X = 891.41, Float:ZONE_Y = -1315.38, Float:ZONE_Z = 17.62; // koordynaty strefy
new InZone[MAX_PLAYERS]; // statyczna zmienna przechowuj�ca informacj�, czy gracz jest w strefie
//new area_zoneid = -1; // id obiektu strefy

forward ZoneCheck(playerid);

hook OnGameModeInit()
{
    // Inicjalizacja strefy
    //CreateDynamicSphere(ZONE_X, ZONE_Y, ZONE_Z, ZONE_RADIUS, 255, 255, 255, 20);
    //area_zoneid = CreateDynamicCircle(ZONE_X, ZONE_Y, ZONE_RADIUS, 0, 255, 0, 20);
    return 1;
}

public ZoneCheck(playerid)
{
    new Float:distance = GetPlayerDistanceFromPoint(playerid, ZONE_X, ZONE_Y, ZONE_Z);

    if(distance <= ZONE_RADIUS && !InZone[playerid])
    {
        InZone[playerid] = true; // ustawiamy informacj�, �e gracz jest ju� w strefie
        SendClientMessage(playerid, COLOR_GREEN, "Jeste� w zielonej strefie biznesowej! Pami�taj w tej strefie stawiamy na wy�sze RP!");
    }
    else if(distance > ZONE_RADIUS && InZone[playerid])
    {
        InZone[playerid] = false; // ustawiamy informacj�, �e gracz opu�ci� stref�
        SendClientMessage(playerid, COLOR_RED, "Nie jeste� ju� w zielonej strefie.");
    }
    return 1;
}