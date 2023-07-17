// ** IS INCLUDE ALREADY INCLUDED?

#if defined _ANTI_CHEAT
	#endinput
#endif

#define _ANTI_CHEAT

// ** DEFINITIONS

// *** SYSTEM IDS

#define FAILED_INITIAL_POSITION_DETECT 1
#define ANTI_SLAP 2
#define ANTI_TELEPORT 3

// ** CALLBACKS

forward OnPlayerTriggerAntiCheat(playerid, system_id);

// ** FUNCTIONS

stock AC_SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	return CallRemoteFunction("ACI_SetSpawnInfo", "iiiffffiiiiii", playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}

stock AC_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{
	return CallRemoteFunction("ACI_SetVehiclePos", "ifff", vehicleid, x, y, z);
}

stock AC_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	return CallRemoteFunction("ACI_SetPlayerPos", "ifff", playerid, x, y, z);
}

stock AC_KickPlayer(playerid) // stops all anti-cheat systems, waits 100ms then kicks the player
{
	return CallRemoteFunction("ACI_KickPlayer", "i", playerid);
}

stock AC_StopSystemsForPlayer(playerid) // stops all anti-cheat systems
{
	return CallRemoteFunction("ACI_StopSystemsForPlayer", "i", playerid);
}