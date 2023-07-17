#include <YSI\y_hooks>
#include <foreach>
 
/*
 
Easy-to-use gate system by MP2
 
Easily create automatic or command-based gates with ONE function!
 
*/
 
/*
### 'INSTALLATION' ###
 
Place this .inc file in your \pawno\include folder.
You will also need foreach and y_hooks, which can be downloaded here:
 
foreach:                                        http://forum.sa-mp.com/showthread.php?t=92679
y_hooks is part of YSI:         http://forum.sa-mp.com/showthread.php?p=1696956
 
Put all the .inc files in \pawno\include.
 
If you get an error on compile saying 'can not read from file' then you did this step wrong.
If you are 100% certain the files are in your \pawno\include folder, you may have multiple instances of pawno.
Search your PC.
 
 
 
### CHANGELOG ###
        1.0 (7th of July 2012):
        Initial release.
 
### CREDITS ###
 
MP2 - Creation
Y_Less - foreach and y_hooks
iGetty - Testing
 
 
### USAGE ###
 
Extremely simple to use, only one function required.
 
===============================================================================
 
To create an automatic gate (opens when players are near)
 
CreateAutomaticGate(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:x2, Float:y2, Float:z2, Float:rx2, Float:ry2, Float:rz2, Float:trigx, Float:trigy, Float:trigz, Float:trig_range, Float:movespeed, condition=0);
 
        Parameters:
        modelid - The object model to use for the gate
        x y z - The position of the CLOSED gate
        rx ry rz - The rotation of the CLOSED gate
        x2 y2 z2 - The position of the OPEN gate
        rx2 ry2 rz2 - The rotation of the OPEN gate
        Set ALL to -1000 to NOT change rotation
        trigx trigy trigz - The trigger point. Players in range of this point will
                                                cause the gate to open (or close if nobody in range)
        trig_range - The range from the trigger point (trigx trigy trigz) at which
                                 players will cause the gate to open (or close if not in range)
        movespeed - The movement speed for the object. The differs drastically for
                                rotating and sliding gates. See tutorial below
        condition - If condition is set to 1, you must return 1 in the the
                                OnOnPlayerRequestGate callback for the player to pass,
                                there you can check if the player meets a certain condition,
                                for example you may only want cops to be able to trigger the
                                gate to open. If set to 0 the gate will open for anyone.
                                Do note however, someone that is NOT a cop could still get in
                                after a cop triggers it to open.
 
        Returns:
        The ID of the gate that was created (NOTE: NOT the object ID!)
        -1 if the gate wasn't created (limit reached)
 
===============================================================================
 
To force a gate to open:
 
OpenGate(gateid);
 
        Parameters:
        gateid - The ID of the gate. Returned by CreateAutomaticGate().
 
        Returns:
        -1 - Gate doesn't exist
        0- Gate already open(ing)
        1 - Gate opening - success
 
===============================================================================
 
To force a gate to close:
 
CloseGate(gateid);
 
        Parameters:
        gateid - The ID of the gate. Returned by CreateAutomaticGate().
 
        Returns:
        -1 - Gate doesn't exist
        0- Gate already close(ing)
        1 - Gate closing - success
 
===============================================================================
 
To check the state of a gate (open/closed/opening/closing):
 
GateStatus(gateid);
 
        Parameters:
        gateid - The ID of the gate. Returned by CreateAutomaticGate().
 
        Returns:
        -1 - Gate doesn't exist
        GATE_STATUS_CLOSED 0 - Gate is fully closed
        GATE_STATUS_OPENING 1 - Gate is opening, not yet fully open
        GATE_STATUS_OPEN 2 - Gate is fully open
        GATE_STATUS_CLOSING 3 - Gate is closing, not yet fully closed
 
===============================================================================
 
To remove/delete/destroy a gate:
 
DestroyGate(gateid);
or
DeleteGate(gateid);
or
RemoveGate(gateid);
 
        Parameters:
        gateid -
        The ID of the gate to destroy/delete. Returned by CreateAutomaticGate().
 
        Returns:
        -1 - Invalid gate ID
        0 - Gate doesn't exist
        1 - Gate was destroyed successfully
 
===============================================================================
 
*/
 
/*     SETUP / CONFIG      */
 
// Number of gates that can be created by the script.
#define MAX_AUTOGATES 100
 
// The interval at which the gates are checked for players in range (in MS)
#define TRIGGER_INTERVAL 1000 // Once a second
 
//#define GATE_DEBUG // Un-comment this (remove //) to enable debugging messages (in-game)
 
/*  END OF SETUP / CONFIG  */
 
 
 
// SCRIPT STARTS.
// FEEL FREE TO BROWSE THE CODE TO LEARN
// IT IS WELL COMMENTED FOR THIS EXACT PURPOSE.
 
/* FAKE NATIVES */
/*
native CreateAutomaticGate(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:x2, Float:y2, Float:z2, Float:rx2, Float:ry2, Float:rz2, Float:trigx, Float:trigy, Float:trigz, Float:trig_range, Float:movespeed, condition=0);
native OpenGate(gateid);
native CloseGate(gateid);
native GateStatus(gateid);
native IsValidGateID(gateid);
native DeleteGate(gateid);
native DestroyGate(gateid);
native RemoveGate(gateid);
 
*/
 
forward OnGateOpenClose(gateid, openclose, Float:gatex, Float:gatey, Float:gatez);
// OnGateOpenClose is called when a gate opens or closes.
//      GATE_STATUS_CLOSED 0 - Gate is fully closed
//      GATE_STATUS_OPENING 1 - Gate is opening, not yet fully open
//      GATE_STATUS_OPEN 2 - Gate is fully open
//      GATE_STATUS_CLOSING 3 - Gate is closing, not yet fully closed
 
forward OnPlayerRequestGate(playerid, gateid);
// OnPlayerRequestGate is called when a gate is triggered if 'condition' was set to 1 in CreateAutomaticGate.
// Returning 0 in this callback will prevent the gate from opening, so you can check for stuff
// For example you may only want cops to access a gate.
 
forward OnPlayerTriggerGate(playerid, gateid);
 
 
 
 
 
 
// Gate States
#define GATE_STATUS_CLOSED 0
#define GATE_STATUS_OPENING 1
#define GATE_STATUS_OPEN 2
#define GATE_STATUS_CLOSING 3
 
// openclose states (for OnGateOpenClose callback)
#define GATE_CLOSE 0
#define GATE_OPEN 1
 
enum E_AUTO_GATE_DATA
{
        gate_objectid, // The internal objectid for the gate
        gate_model, // The object model of the gate
        Float:gate_closed_pos[6], // The gate's pos and rot when closed
        Float:gate_open_pos[6], // The gate's pos and rot when
        Float:gate_trigger[3], // The trigger point
        Float:gate_trigger_radius, // The radius from the trigger point at which the gate is triggered to open
        Float:gate_movespeed, // The movement speed for the object
        gate_condition, // if 1 the gate will not open unless 'return 1;' is used in the OnPlayerRequestGate() callback
        gate_status
}
 
new g_GateData[MAX_AUTOGATES][E_AUTO_GATE_DATA];
 
new Iterator:Gates<MAX_AUTOGATES>;
 
// The ID for the timer. Killed if filterscript is unloaded (if a FS)
new GATE_TRIGGER_TIMERID;
 
 
 
/*   ## FUNCTIONS ##   */
 
stock CreateAutomaticGate(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:x2, Float:y2, Float:z2, Float:rx2, Float:ry2, Float:rz2, Float:trigx, Float:trigy, Float:trigz, Float:trig_range, Float:movespeed, condition=0)
{
        if(Iter_Count(Gates) == MAX_AUTOGATES) return -1;
 
        new i = Iter_Free(Gates);
    // Create the object
        new objectid = CreateObject(modelid, x, y, z, rx, ry, rz, 300.0);
 
        // Set the data
        g_GateData[i][gate_objectid] = objectid;
        g_GateData[i][gate_model] = modelid;
        g_GateData[i][gate_closed_pos][0] = x;
        g_GateData[i][gate_closed_pos][1] = y;
        g_GateData[i][gate_closed_pos][2] = z;
        g_GateData[i][gate_closed_pos][3] = rx;
        g_GateData[i][gate_closed_pos][4] = ry;
        g_GateData[i][gate_closed_pos][5] = rz;
        g_GateData[i][gate_open_pos][0] = x2;
        g_GateData[i][gate_open_pos][1] = y2;
        g_GateData[i][gate_open_pos][2] = z2;
        g_GateData[i][gate_open_pos][3] = rx2;
        g_GateData[i][gate_open_pos][4] = ry2;
        g_GateData[i][gate_open_pos][5] = rz2;
        g_GateData[i][gate_trigger][0] = trigx;
        g_GateData[i][gate_trigger][1] = trigy;
        g_GateData[i][gate_trigger][2] = trigz;
        g_GateData[i][gate_trigger_radius] = trig_range;
        g_GateData[i][gate_movespeed] = movespeed;
        g_GateData[i][gate_condition] = condition;
        g_GateData[i][gate_status] = GATE_STATUS_CLOSED;
       
        Iter_Add(Gates, i);
        return i;
}
 
#define IsValidGateID(%0) (%0 >= 0 && %0 < MAX_AUTOGATES)
 
stock OpenGate(gateid)
{
        if(!IsValidGateID(gateid)) return -1;
        if(Itter_Contains(Gates, gateid) == 0) return -1; // Doesn't exist
 
        if(g_GateData[gateid][gate_status] == GATE_STATUS_OPEN || g_GateData[gateid][gate_status] == GATE_STATUS_OPENING) return 0; // Already open
 
        MoveObject(g_GateData[gateid][gate_objectid], g_GateData[gateid][gate_open_pos][0], g_GateData[gateid][gate_open_pos][1], g_GateData[gateid][gate_open_pos][2], g_GateData[gateid][gate_movespeed], g_GateData[gateid][gate_open_pos][3], g_GateData[gateid][gate_open_pos][4], g_GateData[gateid][gate_open_pos][5]);
 
        g_GateData[gateid][gate_status] = GATE_STATUS_OPENING;
 
        CallLocalFunction("OnGateOpenClose", "iifff", gateid, GATE_STATUS_OPENING, g_GateData[gateid][gate_closed_pos][0], g_GateData[gateid][gate_closed_pos][1], g_GateData[gateid][gate_closed_pos][2]);
        return 1;
}
 
stock CloseGate(gateid)
{
        if(!IsValidGateID(gateid)) return -1;
        if(Itter_Contains(Gates, gateid) == 0) return -1; // Doesn't exist
 
        if(g_GateData[gateid][gate_status] == GATE_STATUS_CLOSED || g_GateData[gateid][gate_status] == GATE_STATUS_CLOSING) return 0; // Already closed
 
        MoveObject(g_GateData[gateid][gate_objectid], g_GateData[gateid][gate_closed_pos][0], g_GateData[gateid][gate_closed_pos][1], g_GateData[gateid][gate_closed_pos][2], g_GateData[gateid][gate_movespeed], g_GateData[gateid][gate_closed_pos][3], g_GateData[gateid][gate_closed_pos][4], g_GateData[gateid][gate_closed_pos][5]);
 
        g_GateData[gateid][gate_status] = GATE_STATUS_CLOSING;
 
        CallLocalFunction("OnGateOpenClose", "iifff", gateid, GATE_STATUS_CLOSING, g_GateData[gateid][gate_open_pos][0], g_GateData[gateid][gate_open_pos][1], g_GateData[gateid][gate_open_pos][2]);
        return 1;
}
 
#define DeleteGate DestroyGate // alternative function name
#define RemoveGate DestroyGate // alternative function name
stock DestroyGate(gateid)
{
    if(!IsValidGateID(gateid)) return -1;
       
        if(Itter_Contains(Gates, gateid) == 0) return 0; // Doesn't exist
 
    DestroyObject(g_GateData[gateid][gate_objectid]);
    Iter_Remove(Gates, gateid);
        return 1;
}
 
stock GateStatus(gateid)
{
        if(!IsValidGateID(gateid)) return -1;
        if(Itter_Contains(Gates, gateid) == 0) return -1; // Doesn't exist
       
        return g_GateData[igateidgate_status];
}
 
 
 
/*   ## TIMER ##   */
 
forward GateTriggerCheckTimer();
public GateTriggerCheckTimer()
{
        new count;
        foreach(new i : Gates)
        {
            if(g_GateData[i][gate_status] == GATE_STATUS_CLOSED || g_GateData[i][gate_status] == GATE_STATUS_CLOSING) // Gate is closed/closing, check if any players are near and open if so
            {
                foreach(new playerid : Player)
                {
                    if(IsPlayerInRangeOfPoint(playerid, g_GateData[i][gate_trigger_radius], g_GateData[i][gate_trigger][0], g_GateData[i][gate_trigger][1], g_GateData[i][gate_trigger][2])) // if in range of the gate
                    {
                                        if(g_GateData[i][gate_condition] == 1) // Must pass condition!
                                        {
                                                if(CallLocalFunction("OnPlayerRequestGate", "ii", playerid, i) == 1)
                                                {
                                                        OpenGate(i); // Open the gate
                                                        CallLocalFunction("OnPlayerTriggerGate", "ii", playerid, i);
                                                        break; // Break out of loop, we know at least one player is in the trigger radius, no need to continue
                                                }
                                        }
                                        else
                                        {
                                                OpenGate(i); // Open the gate
                                                CallLocalFunction("OnPlayerTriggerGate", "ii", playerid, i);
                                                break; // Break out of loop, we know at least one player is in the trigger radius, no need to continue
                                        }
                    }
                }
            }
            else if(g_GateData[i][gate_status] == GATE_STATUS_OPEN) // Gate is fully open, check if there are no players near trigger zone and close if so
            {
                foreach(new playerid : Player)
                {
                    if(IsPlayerInRangeOfPoint(playerid, g_GateData[i][gate_trigger_radius], g_GateData[i][gate_trigger][0], g_GateData[i][gate_trigger][1], g_GateData[i][gate_trigger][2])) // if in range of the gate
                    {
                                        if(g_GateData[i][gate_condition] == 1) // Must pass condition!
                                        {
                                                if(CallLocalFunction("OnPlayerRequestGate", "ii", playerid, i) == 1)
                                                {
                                                        count = 1;
                                                        break; // Break out of loop, we know at least one player is in the trigger radius, no need to continue
                                                }
                                        }
                                        else
                                        {
                                                count = 1;
                                                break; // Break out of loop, we know at least one player is in the trigger radius, no need to continue
                                        }
                    }
                }
                if(!count) CloseGate(i);
            }
        }
        return 1;
}
 
 
 
/*   ## HOOKS ##   */
 
Hook:gate_OnGameModeInit()
{
        GATE_TRIGGER_TIMERID = SetTimer("GateTriggerCheckTimer", TRIGGER_INTERVAL, true);
        return 1;
}
 
Hook:gate_OnFilterScriptInit()
{
        GATE_TRIGGER_TIMERID = SetTimer("GateTriggerCheckTimer", TRIGGER_INTERVAL, true);
        return 1;
}
 
Hook:gate_OnFilterScriptExit()
{
        KillTimer(GATE_TRIGGER_TIMERID);
        return 1;
}
 
Hook:gate_OnObjectMoved(objectid)
{
        // Check if a gate moved
        foreach(new i : Gates)
        {
                if(g_GateData[i][gate_model] != 0 && g_GateData[i][gate_objectid] == objectid) // We found our gate.
                {
                        if(g_GateData[i][gate_status] == GATE_STATUS_CLOSING)
                        {
                                g_GateData[i][gate_status] = GATE_STATUS_CLOSED;
                                CallLocalFunction("OnGateOpenClose", "iifff", i, GATE_STATUS_CLOSED, g_GateData[i][gate_closed_pos][0], g_GateData[i][gate_closed_pos][1], g_GateData[i][gate_closed_pos][2]);
                        }
                        else
                        {
                                g_GateData[i][gate_status] = GATE_STATUS_OPEN;
                                CallLocalFunction("OnGateOpenClose", "iifff", i, GATE_STATUS_OPEN, g_GateData[i][gate_open_pos][0], g_GateData[i][gate_open_pos][1], g_GateData[i][gate_open_pos][2]);
                        }
                }
        }
        return 1;
}
 
 
 
/*
 
DEV NOTES:
 
Set object model (array) to 0 when gate destroyed - this is how the script
knows if a gate exists or not (saves a gate_created variable)
 
PLANS:
LockGate(gateid, openclose=0) // Lock a gate open or closed
FreezeGate/StopGate(gateid) // Stop a gate where it is
 
*/