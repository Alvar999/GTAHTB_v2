/* 
In acest include se gasesc functiile ( FORWARD, STOCK, ETC ) create de mine */
forward SS(playerid, text[], text2[]);
public SS(playerid, text[], text2[])
{
	if(PlayerInfo[playerid][pLanguage] == 1)// english
	{
		SendClientMessage(playerid, -1, text);
	}
	if(PlayerInfo[playerid][pLanguage] == 2)// romana
	{
		SendClientMessage(playerid, -1, text2);
	}
	return 1;
} 