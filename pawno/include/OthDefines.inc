/* Other Defines */
// TEAM
#define TEAM_CYAN 	1
#define TEAM_BLUE 	2
#define TEAM_GREEN 	3
#define TEAM_ORANGE 4
#define TEAM_COR 	5
#define TEAM_BAR 	6
#define TEAM_TAT 	7
#define TEAM_CUN 	8
#define TEAM_STR 	9
#define TEAM_HIT 	10
#define TEAM_ADMIN 	11

#define pCashx				1
#define pRP  				2
#define pBank  				3
#define pCarLicTx 			4
#define pFlyLicTx 			5
#define pBoatLicTx 			6
#define pGunLicTx 			8
#define pRobx 				9
#define pFpunishx           10
#define pLawyerx            11
#define pConnectTimex       12
#define pPayDayx      		15
#define pPayCheckx      	16
#define pPhousekeyx      	17
#define pJailedx      		18
#define pJailTimex     		19
#define pWantedLevelx       21
#define pPhonex             22
#define pMatsx              23
#define pFishesx            24
#define pFishSkillx         25
#define pRobSkillx          26
#define pLevelx             27
#define pPremiumAccountx    28
#define pPbiskeyx           29
#define pPnumberx           30
#define pRegx               31
#define pRegistredDatex     32
#define pPcarkeyx           33
#define	pmotokeyx           34
#define	phelikeyx           35
#define	pprcarkeyx          36
#define pRentedx            37
#define pCrimesx            38
#define pCrime1x            40
#define pCrime2x            41
#define pCrime3x            42
#define pVictimx            43
#define pAccusedx           44
#define pEmailx             45
#define pWarnsx             52
#define pLanguagex          53
#define pPremiumPointsx     54
#define pprcarkey2x         55
#define pPPluscarkeyx       56
#define pPPluscarkey2x      57
#define pPlusSlot1x         58
#define pPlusSlot2x         59
#define pFWorksx            61
#define pVirtualPDx         62
#define pGlassesx           63
#define pHatsx           	64
#define pTruckSkillx        65
#define pTruckTimesx        66
#define pTruckRemx          67
#define pFarmSkillx         68
#define pFarmTimesx         69
#define pFarmRemx           70
#define pFishTimesx         71
#define pFishRemx           72
#define pSpawnChangex      	73
#define pRobTimesx          74
#define pRobRemx            75
#define pCreditsx           76
#define pFactionTimex       77
#define pNMutedx            78
#define pHelpedPlayersx     79
#define pHiddenColorx       80
#define pGiftTimex          81
#define pFightStylex        82
#define pHUD1x              83
#define pHUD2x              84
#define pHUD3x              85
#define pGasCanx			86
#define pCarLicSuspendx		87
#define pGunLicSuspendx		88
#define pPizzaSkillx		89
#define pPizzaTimesx		90
#define pPizzaRemx			91
#define pArmsSkillx			92
#define pArmsTimesx			93
#define pArmsRemx			94
#define pBusSkillx			95
#define pBusTimesx			96
#define pBusRemx			97
#define pSecSkinx           98
#define pFristIPx           99
#define pBlockedx           100

// CARS
#define cLocationxx 			1
#define cLocationyx 			2
#define cLocationzx 			3
#define cAnglex 				4
#define cModelx                 5
#define cColorOnex              6
#define cColorTwox              7
#define cOwnerx                 8
#define cValuex                 9
#define cLicensex               10
#define cDescriptionx           11
#define cLockx                  12
#define cTimedx                 13
#define cInscarpricex           14
#define cInsurancecarx          15
#define cKMx                    16
#define cOwnedx                 17
#define cSellx                  18
#define cModsx                  19
#define cPaintJx                20
#define cDaysx                  21
#define cHPx					22
#define cDamage1x				23
#define cDamage2x				24
#define cDamage3x				25
#define cDamage4x				26
#define cGasx					27
#define cVIPx                   28
#define cVipTextx               29
#define cNeonx                  30


//HOUSE
#define hExitxx             1
#define hExityx             2
#define hExitzx             3
#define hInteriorx          4

#define NUMDIS 40.0
#define MAX_GANGZONES 68

//SBUSSINES
#define sbTillx         1
#define MAX_PVEHS (6)
#define EX_SPLITLENGTH 113
#define EX_SPLITLENGTHH 128
#define SECONDS_BETWEEN_SAME_MSGS (5)
#define RATE_INC (500)
#define RATE_MAX (2500)
#define THRESOLD_ACTION 1
#define MAX_GROUPS (15)
#define MAX_PERSONAL_CARS (101)
#define MAX_LIGHTS 100
#define MAX_SPIKES 10
#define RBSprinkleid 20
#define SERVER_VERSION "Evo RPG v11.22.2016"
#define AdminOnly "EROARE: {FFFFFF}Nu esti autorizat sa folosesti aceasta comanda."
#define SetPlayerHoldingObject(%1,%2,%3,%4,%5,%6,%7,%8,%9) SetPlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1,%2,%3,%4,%5,%6,%7,%8,%9)
#define StopPlayerHoldingObject(%1) RemovePlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define IsPlayerHoldingObject(%1) IsPlayerAttachedObjectSlotUsed(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.8)
#define                 hidePlayerDialog(%0)                    ShowPlayerDialog(%0, -1, 0, " ", " ", "", "")
#define 				strcpy(%0,%1,%2) 						strcat((%0[0] = '\0', %0), %1, %2)
#define GetVehicleSeats(%0) (GetVehicleModelSeats(GetVehicleModel(%0)))
#define function%0(%1) forward%0(%1); public%0(%1)
#define ATTACK_TYPE_PLAYERID 1
#define ATTACK_TYPE_IP 2
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))


// WALKIE TALKIE
#define MAX_CHANNEL 1000

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

#define maxobj 50
#define Spam_MaxMsgs     4
#define MAX_STRING 2400
#define c_y 0xFFFF00AA
#define c_r 0xAA3333AA
#define CHECKPOINT_NONE 0
#define CHECKPOINT_HOME 12
#define CHECKPOINT_LOCATE 53
#define KEY_AIM (128)
#define KEY_HANDBRAKE (128)
#define SCM SendClientMessage
#define SPECIAL_ACTION_PISSING 68


#define MAX_SLOTS           50
#define MAX_SNOW_OBJECTS    8
#define UPDATE_INTERVAL     750

#define ploop(%0)                       for(new %0 = 0; %0 < MAX_SLOTS; %0++) if(IsPlayerConnected(%0))
#define CB:%0(%1)           forward %0(%1); public %0(%1)


// KICK - BAN
forward Kick_Ban ( playerid, bool: kickban ); public Kick_Ban ( playerid, bool: kickban ) return ( !kickban ) ? Kick ( playerid ) : Ban ( playerid );
#define KickEx(%1) 			SetTimerEx ( "Kick_Ban", 500, false, "ii", %1, false )
#define Ban(%1) 			SetTimerEx ( "Kick_Ban", 500, false, "ii", %1, true )