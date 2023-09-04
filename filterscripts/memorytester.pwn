//memorytester.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------[ Filterscript: memorytester.pwn ]--------------------------------------//
//Opis:
/*
	Filterscript do testowania sum kontrolnych okre�lonych kom�rek pami�ci GTA San Andreas.
	Stworzony aby poblokowa� cziters�w.
*/
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

//

#include <a_samp>


native SendClientCheck(clientid, actionid, arg1= 0x00000000, arg2= 0x0000, bytes= 0x0004); // int32, int8, int32, int16, int16
forward OnClientCheckResponse(clientid, actionid, checksum, crc);

public OnFilterScriptInit()
{
	print("Memory tester loaded.");
	return 1;
}

public OnFilterScriptExit()
{
	print("Memory tester unloaded.");
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientCheck(playerid, 0x47);
	return 1;
}

stock MemoryChecksumSnapshot(playerid)
{
	for(new i=0; i <0xffff; i++;
}

public OnClientCheckResponse(clientid, actionid, checksum, crc)
{
	switch(actionid)
	{
        case 0x47: SendClientCheck(clientid, 0x02);
        case 0x02:
        {
			if(pAFKK[clientid]) pAFKK[clientid] = false;

			if(checksum & 0x00ff0000 == 0x00300000)
			{
				pHaveSobeit[clientid] = true;
				pCountCheck[clientid] = 0;
				OznaczCzitera(clientid);
				
			}
			else if(checksum & 0x00ff0000 == 0x00CC0000)
			{
				pHaveSobeit[clientid] = true;
				pCountCheck[clientid] = 0;
				OznaczCzitera(clientid);
			}
			else if(checksum & 0x00ff0000 == 0x00FC0000)
			{
				pCountCheck[clientid] = 0;
				pAFKK[clientid] = true;
			}
			else
			{
				SetTimerEx("Check", 1000, false, "d", clientid);// timer jest dlatego, �e pierwsze wykonanie akcji za po�rednictwem onplayerconnect nie jest prawdziwe i bezu�yteczne, dla pewno�ci robi� prawdziwe 3 pr�by
			}
        }
	}

	printf("clientid: %d, actionid: 0x%02x, checksum: 0x%08x, crc: %d", clientid,actionid,checksum,crc);    
}