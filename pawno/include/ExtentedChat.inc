#if defined _ex_chat_included
  #endinput
#endif
#define _ex_chat_included

// Author: kaZax
// Credits: urShadow (Pawn.Regex)
// IncludeVersion: 1.0

#include <Pawn.Regex>

#define ExChat::				_ex_chat_

#define _ex_chat_TextSize 		(384)

new regex:ExChat::Main,
	regex:ExChat::Replace;

stock ExChat::RegExInit()
{
	ExChat::Main = regex_new("[#@]\\d+");

	if (!ExChat::Main)
		print("ExtendedChat: ex_chat_RegExInit() Error!");

	print("ExtendedChat by kaZax loaded.");
}

stock ExChat::RegExExit()
{
	regex_delete(ExChat::Main);

	print("ExtendedChat unloaded.");
}

stock ExChat::ReplaceString(const str[], const regexp[], const fmt[], dest[], size = sizeof dest)
{
    ExChat::Replace = regex_new(regexp);
    
    if (ExChat::Replace) 
    	regex_replace(str, ExChat::Replace, fmt, dest, MATCH_DEFAULT, size);

    regex_delete(ExChat::Replace);
} 

public OnPlayerText(playerid, text[])
{	
	new message[_ex_chat_TextSize];
	format(message, _ex_chat_TextSize, text);

	if (ExChat::Main)
	{
		new match_results:m, 
			startpos, 
			pos,
			str[48];

		new playerID,
		 	playerName[MAX_PLAYER_NAME];

		while (regex_search(message, ExChat::Main, m, pos, startpos))
	    {
	        match_get_group(m, 0, str);
	        match_free(m);

	        startpos += pos + strlen(str);

	        playerID = strval(str[1]);

	        if (IsPlayerConnected(playerID)) 
	        {
	        	GetPlayerName(playerID, playerName, MAX_PLAYER_NAME);
	        	ExChat::ReplaceString(message, str, playerName, message, _ex_chat_TextSize);
	        }   
	    }		
	}

	#if defined ex_chat_OnPlayerText
		ex_chat_OnPlayerText(playerid, message);
	#endif
	return 0;
}
 
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif

#define OnPlayerText ex_chat_OnPlayerText

#if defined ex_chat_OnPlayerText
	forward ex_chat_OnPlayerText(playerid, text[]);
#endif

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
	{		
		ExChat::RegExInit();
		
		#if defined ex_chat_OnFilterScriptInit
			ex_chat_OnFilterScriptInit();
		#endif
		
		return 1;
	}
	 
	public OnFilterScriptExit()
	{
		ExChat::RegExExit();

		#if defined ex_chat_OnFilterScriptExit
			ex_chat_OnFilterScriptExit();
		#endif
		return 1;
	} 
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif

	#define OnFilterScriptInit ex_chat_OnFilterScriptInit

	#if defined ex_chat_OnFilterScriptExit
		forward ex_chat_OnFilterScriptExit();
	#endif

	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif

	#define OnFilterScriptExit ex_chat_OnFilterScriptExit

	#if defined ex_chat_OnFilterScriptExit
		forward ex_chat_OnFilterScriptExit();
	#endif
#else
	public OnGameModeInit()
	{	
		ExChat::RegExInit();
		
		#if defined ex_chat_OnGameModeInit
			ex_chat_OnGameModeInit();
		#endif
		return 1;
	}
	
	public OnGameModeExit()
	{
		ExChat::RegExExit();

		#if defined ex_chat_OnGameModeExit
			ex_chat_OnGameModeExit();
		#endif
		return 1;
	}

	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif

	#define OnGameModeInit ex_chat_OnGameModeInit

	#if defined ex_chat_OnGameModeInit
		forward ex_chat_OnGameModeInit();
	#endif

	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif

	#define OnGameModeExit ex_chat_OnGameModeExit

	#if defined ex_chat_OnGameModeExit
		forward ex_chat_OnGameModeExit();
	#endif
#endif