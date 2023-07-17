
#pragma warning disable 217
#pragma warning disable 208
#pragma warning disable 202
#pragma warning disable 213
#pragma warning disable 201


#define SERVER_GM_TEXT "GTAHTB"

#include <a_samp>
#include <a_mysql>
#include <a_actor>
#include <streamer>
#include <yom_buttons>		
#include <ZCMD>
#include <dini>
#include <easydialog>
#include <sscanf2>
#include <foreach>
#include <YSI\y_timers>
#include <YSI\y_utils>
#include <sampvoice>
#include <progress>
#include <progress2>
#if defined SOCKET_ENABLED
#include <socket>
#endif

//Main
#include "./includes/Main/HTBV2.pwn"

//TextDraws
#include "./includes/TextDraws/SaiLenh.pwn"
#include "./includes/TextDraws/Loading.pwn"


#pragma disablerecursion

main() {}

public OnGameModeInit()
{
	print("Dang chuan bi tai gamemode, xin vui long cho doi...");
	g_mysql_Init();
	gstream = SvCreateGStream(0xffff0000, "Global");
	return 1;
}

public OnGameModeExit()
{
    g_mysql_Exit();
    if (gstream) SvDeleteStream(gstream);
	return 1;
}
